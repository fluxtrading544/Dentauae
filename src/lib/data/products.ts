import { sdk } from "@/lib/medusa";
import { HttpTypes } from "@medusajs/types";
import { Product } from "@/lib/mock-data"; 

/**
 * Maps a complex backend Medusa Product into our clean frontend Product interface
 */
export function mapMedusaProductToStorefront(medusaProduct: HttpTypes.StoreProduct): Product {
  // Grab the first variant's calculated price or fallback to 0
  const firstVariant = medusaProduct.variants?.[0];
  const price = firstVariant?.calculated_price?.calculated_amount ?? 0;
  
  // Extract category string
  const categoryName = medusaProduct.categories?.[0]?.name ?? "Electric Brushes";

  // Identify brand generically
  let brand = (medusaProduct as { subtitle?: string }).subtitle || "Professional Selection"; 
  if (brand.toLowerCase().includes("imported from amazon")) {
    brand = (medusaProduct as { metadata?: { tech_specs?: Record<string, string> } }).metadata?.tech_specs?.["Brand"] || "Professional Selection";
  }

  // Safely grab the first image
  const image = medusaProduct.images?.[0]?.url ?? "/images/io7.jpg";

  // Map Variants
  const variants = medusaProduct.variants?.map(v => ({
    id: v.id!,
    title: v.title!,
    sku: v.sku!,
    price: v.calculated_price?.calculated_amount ?? 0,
    thumbnail: (v as { metadata?: { thumbnail_url?: string; image_url?: string } }).metadata?.thumbnail_url || (v as { metadata?: { thumbnail_url?: string; image_url?: string } }).metadata?.image_url,
    options: v.options?.reduce((acc: Record<string, string | undefined>, opt: HttpTypes.StoreProductOptionValue) => {
      const key = (opt.option?.title || opt.option_id) as string;
      if (key) acc[key] = opt.value;
      return acc;
    }, {}) || {}
  }));

  // Map Options
  const options = medusaProduct.options?.map(o => ({
    id: o.id!,
    title: o.title!,
    values: o.values?.map(v => v.value!) || []
  }));

  // Map Promos from Metadata
  const metadata = medusaProduct.metadata as { promos?: unknown[]; coupon_timer?: string; tech_specs?: Record<string, string> } | undefined;
  const promos = metadata?.promos || [];
  const couponTimer = metadata?.coupon_timer;
  const techSpecs = metadata?.tech_specs || {};

  return {
    id: medusaProduct.handle!,
    variantId: firstVariant?.id,
    name: medusaProduct.title!,
    brand,
    price,
    description: medusaProduct.description ?? "Premium dental care device.",
    features: ["Advanced Cleaning", "Smart Modes"], 
    image,
    images: medusaProduct.images?.map(img => img.url!) || [image],
    reviews: 128, 
    rating: 4.8, 
    category: categoryName,
    variants,
    options,
    promos,
    couponTimer,
    techSpecs
  };
}

/**
 * Fetches the UAE Region details including metadata.
 */
export async function getRegionAe(): Promise<HttpTypes.StoreRegion | undefined> {
  try {
    const { regions } = await sdk.store.region.list();
    return regions?.find((r: HttpTypes.StoreRegion) => r.countries?.some((c: Record<string, unknown>) => c.iso_2 === "ae")) || regions?.[0];
  } catch (error) {
    console.error("Failed to fetch region:", error);
    return undefined;
  }
}

/**
 * Fetches a list of products from the Medusa backend.
 */
export async function getProductsList({
  pageParam = 1,
  limit = 12,
  category_id = [],
}: {
  pageParam?: number;
  limit?: number;
  category_id?: string[];
}): Promise<{ response: { products: Product[]; count: number } }> {
  try {
    const region = await getRegionAe();
    const regionId = region?.id;
    if (!regionId) {
      console.warn("No region found. Medusa backend might be offline or no regions are configured.");
      return {
        response: {
          products: [],
          count: 0,
        },
      };
    }

    const { products, count } = await sdk.store.product.list({
      limit,
      offset: (pageParam - 1) * limit,
      region_id: regionId,
      category_id: category_id.length > 0 ? category_id : undefined,
      fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
    });

    const mappedProducts = products.map(mapMedusaProductToStorefront);

    return {
      response: {
        products: mappedProducts,
        count,
      },
    };
  } catch (error) {
    console.error("Failed to fetch products from Medusa:", error);
    return {
      response: {
        products: [],
        count: 0,
      },
    };
  }
}

/**
 * Fetches a single product by its handle.
 */
export async function getProductByHandle(handle: string): Promise<Product | null> {
  try {
    const region = await getRegionAe();
    const regionId = region?.id;
    if (!regionId) return null;

    const { products } = await sdk.store.product.list({
      handle,
      region_id: regionId,
      fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
    });

    if (!products || products.length === 0) return null;
    return mapMedusaProductToStorefront(products[0]);
  } catch (error) {
    console.error(`Failed to fetch product handle ${handle}:`, error);
    return null;
  }
}

/**
 * Fetches specific products for the home page hero section.
 */
export async function getHomeHeroProducts(handles: string[]): Promise<Product[]> {
  try {
    const region = await getRegionAe();
    if (!region?.id) return [];

    const { products } = await sdk.store.product.list({
      handle: handles,
      region_id: region.id,
      fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
    });

    return products.map(mapMedusaProductToStorefront);
  } catch (error) {
    console.error("Failed to fetch home hero products:", error);
    return [];
  }
}

/**
 * Fetches Home Content from either a Collection (Visual) or Region (Fallback).
 */
export async function getHomeContent(): Promise<{
  title: string;
  subtitle: string;
  image: string;
  products: Product[];
}> {
  const defaultTitle = "Smile Brighter,\nEvery Single Day";
  const defaultSubtitle = "Curated professional dental solutions delivered to your doorstep. Experience the gold standard of oral hygiene in the UAE.";
  const defaultImage = "https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb";

  try {
    const region = await getRegionAe();
    
    // 1. Try to fetch the 'home-page' collection
    const { collections } = await sdk.store.collection.list({ handle: "home-page" });
    const homeCollection = collections?.[0];

    if (homeCollection) {
      // Fetch products in this collection
      const { products: collectionProducts } = await sdk.store.product.list({
        collection_id: [homeCollection.id],
        region_id: region?.id,
        fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
      });

      // If collection exists but is empty, fallback to default products but keep collection metadata if available
      const finalProducts = collectionProducts.length > 0 
        ? collectionProducts.map(mapMedusaProductToStorefront)
        : await getHomeHeroProducts(["io-9", "sonicare-9900"]);

      return {
        title: homeCollection.metadata?.hero_title || region?.metadata?.hero_title || defaultTitle,
        subtitle: homeCollection.metadata?.hero_subtitle || region?.metadata?.hero_subtitle || defaultSubtitle,
        image: homeCollection.metadata?.hero_image_url || region?.metadata?.hero_image_url || defaultImage,
        products: finalProducts,
      };
    }

    // 2. Fallback to Region Metadata
    if (region) {
      return {
        title: region.metadata?.hero_title || defaultTitle,
        subtitle: region.metadata?.hero_subtitle || defaultSubtitle,
        image: region.metadata?.hero_image_url || defaultImage,
        products: await getHomeHeroProducts(["io-9", "sonicare-9900"]),
      };
    }

    return {
      title: defaultTitle,
      subtitle: defaultSubtitle,
      image: defaultImage,
      products: [],
    };
  } catch (error) {
    console.error("Failed to fetch home content:", error);
    return {
      title: defaultTitle,
      subtitle: defaultSubtitle,
      image: defaultImage,
      products: [],
    };
  }
}

