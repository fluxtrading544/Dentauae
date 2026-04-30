import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http";
import { createProductsWorkflow } from "@medusajs/medusa/core-flows";
import { ProductStatus } from "@medusajs/framework/utils";
import axios from "axios";
import * as cheerio from "cheerio";

const getCorsHeaders = (origin: string | undefined) => {
  const allowedOrigins = [
    "https://dentauae.com",
    "https://www.dentauae.com",
    "http://localhost:3000"
  ];

  const corsOrigin = origin && allowedOrigins.includes(origin) ? origin : allowedOrigins[0];

  return {
    "Access-Control-Allow-Origin": corsOrigin,
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Credentials": "true",
  };
};

export const GET = async (req: MedusaRequest, res: MedusaResponse) => {
  const headers = getCorsHeaders(req.headers.origin as string);
  Object.entries(headers).forEach(([key, value]) => res.setHeader(key, value));

  res.json({ 
    message: "Amazon Import Tool is ACTIVE.",
    usage: "Send a POST request with { 'url': '...' } to this endpoint to import a product.",
    status: "Ready"
  });
};

export const OPTIONS = async (req: MedusaRequest, res: MedusaResponse) => {
  const headers = getCorsHeaders(req.headers.origin as string);
  return res.status(204).set(headers).send();
};

export const POST = async (req: MedusaRequest, res: MedusaResponse) => {
  const headers = getCorsHeaders(req.headers.origin as string);
  Object.entries(headers).forEach(([key, value]) => res.setHeader(key, value));
  const { url } = req.body as { url: string };

  if (!url) {
    return res.status(400).json({ message: "Amazon URL or ASIN is required" });
  }

  try {
    // 1. Scrape Amazon
    const productData = await scrapeAmazonProduct(url);
    
    // 2. Resolve default Sales Channel
    const query = req.scope.resolve("query");
    const { data: salesChannels } = await query.graph({
      entity: "sales_channel",
      fields: ["id"],
      filters: { name: "Default Sales Channel" }
    }) as { data: any[] };

    const salesChannelId = salesChannels[0]?.id;

    // 3. Prepare options and variants carefully for Medusa V2
    const medusaOptions = productData.options.length > 0 
        ? productData.options 
        : [{ title: "Selection", values: ["Default"] }];

    const medusaVariants = productData.variants.length > 0 
        ? productData.variants.map((v: any) => ({
            ...v,
            title: v.title || "Default",
            options: productData.options.length > 0 ? v.options : { "Selection": "Default" },
            manage_inventory: false,
        }))
        : [{
            title: "Default",
            sku: `AMZ-${productData.asin}-DEF`,
            options: { "Selection": "Default" },
            prices: [{ amount: productData.price, currency_code: "aed" }],
            manage_inventory: false
        }];

    // 4. Create Product using Medusa Workflow
    const brand = productData.techSpecs["Brand"] || "Professional Selection";

    const { result } = await createProductsWorkflow(req.scope).run({
      input: {
        products: [
          {
            title: productData.title,
            subtitle: brand,
            description: productData.description,
            handle: productData.handle,
            status: ProductStatus.PUBLISHED,
            images: productData.images.map((url: string) => ({ url })),
            thumbnail: productData.images[0],
            metadata: {
                promos: productData.promos,
                coupon_timer: productData.couponTimer,
                tech_specs: productData.techSpecs
            },
            options: medusaOptions,
            variants: medusaVariants,
            sales_channels: salesChannelId ? [{ id: salesChannelId }] : []
          }
        ]
      }
    });

    return res.status(200).json({ 
      success: true, 
      product: result[0] 
    });

  } catch (error: unknown) {
    console.error("Amazon Import Error:", error);
    const errorMessage = error instanceof Error ? error.message : "Failed to import product";
    return res.status(500).json({ 
      message: "Failed to import product", 
      error: errorMessage 
    });
  }
};

async function scrapeAmazonProduct(input: string) {
  const asinMatch = input.match(/\/(?:dp|gp\/product)\/([A-Z0-9]{10})/);
  const asin = asinMatch ? asinMatch[1] : (input.length === 10 ? input : null);
  
  if (!asin) throw new Error("Could not extract ASIN from URL");
  const url = input.startsWith("http") ? input : `https://www.amazon.ae/dp/${asin}`;

  const { data: html } = await axios.get(url, {
    headers: {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36",
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
      "Accept-Language": "en-US,en;q=0.9",
      "Referer": "https://www.google.com/",
    }
  });

  const $ = cheerio.load(html);
  const title = $("#productTitle").text().trim();
  const priceText = $(".a-price-whole").first().text().replace(/[^0-9.]/g, "");
  const basePrice = priceText ? parseFloat(priceText) : 0;

  // 1. Enhanced Description (Markdown Bullets)
  const features: string[] = [];
  $("#feature-bullets ul li span").each((_, el) => {
    const text = $(el).text().trim();
    if (text && !text.includes("About this item")) {
        features.push(`- ${text}`);
    }
  });
  const description = features.join("\n");

  // 2. Extract Technical Specifications
  const techSpecs: Record<string, string> = {};
  $("#productOverview_feature_div tr, .prodDetSectionEntry").each((_, el) => {
      const key = $(el).find("td.a-span3, th").text().trim();
      const val = $(el).find("td.a-span9, td").text().trim();
      if (key && val) {
          techSpecs[key] = val;
      }
  });

  // 3. Extract Images (High Res Gallery)
  const imageSet = new Set<string>();
  
  // Try dynamic image collection
  const scripts = $("script").toArray();
  for (const script of scripts) {
      const content = $(script).html() || "";
      if (content.includes("colorImages") || content.includes("imageGalleryData")) {
          const match = content.match(/'colorImages':\s*({.+}),/m) || content.match(/"colorImages":\s*({.+}),/m);
          if (match) {
              try {
                  const data = JSON.parse(match[1]) as Record<string, unknown[]>;
                  const firstColor = Object.keys(data)[0];
                  (data[firstColor] as Record<string, any>[]).forEach((img) => {
                      if (img.hiRes) imageSet.add(img.hiRes);
                      else if (img.large) imageSet.add(img.large);
                  });
              } catch {
                // Ignore parsing errors
              }
          }
      }
  }

  const landingImage = $("#landingImage").attr("data-a-dynamic-image");

  // Fallback to landing image if collection failed
  if (imageSet.size === 0) {
    if (landingImage) {
        try {
            const imgObj = JSON.parse(landingImage) as Record<string, unknown>;
            Object.keys(imgObj).forEach(u => imageSet.add(cleanAmazonUrl(u)));
        } catch {
          // Ignore
        }
    }
  }
  
  // 4. Extract Variations with better thumbnails and high-res mapping
  const options: { title: string; values: string[] }[] = [];
  const variants: Record<string, any>[] = [];
  
  const variationList = $("#variation_style_name, #variation_color_name, #variation_size_name").first();       
  if (variationList.length) {
      const dimTitle = variationList.attr("id")?.replace("variation_", "").replace("_name", "").replace(/^\w/, c => c.toUpperCase()) || "Option";
      const values: string[] = [];
      
      variationList.find("li").each((_, li) => {
          const label = $(li).find("img").attr("alt") || $(li).find(".variation_primary_label").text().trim() || $(li).text().trim();
          const thumb = $(li).find("img").attr("src");

          if (label && !values.includes(label)) {
              values.push(label);

              variants.push({
                  title: label,
                  sku: `AMZ-${$(li).attr("data-defaultasin") || Math.random().toString(36).substring(7).toUpperCase()}`,
                  options: { [dimTitle]: label },
                  prices: [{ amount: basePrice, currency_code: "aed" }],
                  metadata: {
                      thumbnail_url: thumb ? cleanAmazonUrl(thumb) : Array.from(imageSet)[0],
                      asin: $(li).attr("data-defaultasin")
                  }
              });
          }
      });
      if (values.length > 0) {
          options.push({ title: dimTitle, values });
      }
  } else {
      // Single product, ensure variant gets the image
      variants.push({
          title: "Default",
          sku: `AMZ-${asin}-DEF`,
          options: { "Selection": "Default" },
          prices: [{ amount: basePrice, currency_code: "aed" }],
          metadata: {
              thumbnail_url: Array.from(imageSet)[0],
              asin: asin
          },
          manage_inventory: false
      });
      options.push({ title: "Selection", values: ["Default"] });
  }

  // 5. Extract Promos
  const promos: Record<string, string>[] = [];
  $("#applicable_promotion_list_feature_div, #applicable_promotion_list").find("span, li, a").each((_, el) => {
      const text = $(el).text().trim();
      const code = text.match(/[A-Z0-9]{6,15}/)?.[0];
      if (code && !promos.find(p => p.code === code)) {
          promos.push({
              code,
              label: text.includes("Bank") ? "Bank Offer" : "Special Offer",
              discount: text.match(/\d+%/)?.[0] || "Extra Savings"
          });
      }
  });

  return {
    asin,
    title: title || "Unknown Amazon Product",
    price: basePrice,
    description: description || "No description available.",
    images: Array.from(imageSet).slice(0, 10),
    options,
    variants,
    promos,
    techSpecs,
    couponTimer: $(".deal-timer-timer").text().trim() || null,
    handle: `amz-${asin.toLowerCase()}`
  };
}

function cleanAmazonUrl(url: string): string {
    // Try to get the high-res version by removing the sizing segment
    return url.replace(/\._[A-Z0-9,_-]+\./g, ".");
}
