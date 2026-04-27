import { sdk } from "@/lib/medusa";
import { HttpTypes } from "@medusajs/types";
import { Product } from "@/lib/mock-data";

// ─────────────────────────────────────────────────────────────────────────────
// Region Cache
// ─────────────────────────────────────────────────────────────────────────────
// FIX: Previously every data function independently called getRegionAe(),
// causing 4+ serial network requests on the home page alone.
// Now the region is cached for 5 minutes at the module level (server-side).
// In Next.js App Router this module is loaded once per server process.

let _cachedRegion: HttpTypes.StoreRegion | undefined = undefined;
let _cacheExpiry = 0;
const REGION_CACHE_TTL_MS = 5 * 60 * 1000; // 5 minutes

/**
 * Fetches the UAE Region with a 5-minute server-side in-memory cache.
 * Falls back to the first available region if no UAE region is found.
 */
export async function getRegionAe(): Promise<HttpTypes.StoreRegion | undefined> {
  const now = Date.now();
  if (_cachedRegion && now < _cacheExpiry) {
    return _cachedRegion;
  }

  try {
    const { regions } = await sdk.store.region.list();
    const region =
      regions?.find((r: HttpTypes.StoreRegion) =>
        r.countries?.some((c: any) => c.iso_2 === "ae")
      ) || regions?.[0];

    if (region) {
      _cachedRegion = region;
      _cacheExpiry = now + REGION_CACHE_TTL_MS;
    }
    return region;
  } catch (error) {
    console.error("Failed to fetch region:", error);
    return undefined;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Product Mapper
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Maps a complex Medusa backend product into our clean frontend Product interface.
 */
export function mapMedusaProductToStorefront(medusaProduct: HttpTypes.StoreProduct): Product {
  const firstVariant = medusaProduct.variants?.[0];
  const price = firstVariant?.calculated_price?.calculated_amount ?? 0;

  const categoryName = medusaProduct.categories?.[0]?.name ?? "Electric Brushes";

  let brand = (medusaProduct as { subtitle?: string }).subtitle || "Professional Selection";
  if (brand.toLowerCase().includes("imported from amazon")) {
    brand =
      (medusaProduct as { metadata?: { tech_specs?: Record<string, string> } }).metadata
        ?.tech_specs?.["Brand"] || "Professional Selection";
  }

  const image = medusaProduct.images?.[0]?.url ?? "/images/io7.jpg";

  const variants = medusaProduct.variants?.map((v) => ({
    id: v.id!,
    title: v.title!,
    sku: v.sku!,
    price: v.calculated_price?.calculated_amount ?? 0,
    thumbnail:
      (v as { metadata?: { thumbnail_url?: string; image_url?: string } }).metadata?.thumbnail_url ||
      (v as { metadata?: { thumbnail_url?: string; image_url?: string } }).metadata?.image_url,
    options: (
      v.options?.reduce(
        (acc: Record<string, string>, opt: HttpTypes.StoreProductOptionValue) => {
          const key = (opt.option?.title || opt.option_id) as string;
          if (key && opt.value) acc[key] = opt.value;
          return acc;
        },
        {} as Record<string, string>
      ) || {}
    ) as Record<string, string>,
  }));

  const options = medusaProduct.options?.map((o) => ({
    id: o.id!,
    title: o.title!,
    values: o.values?.map((v) => v.value!) || [],
  }));

  const metadata = medusaProduct.metadata as
    | { promos?: unknown[]; coupon_timer?: string; tech_specs?: Record<string, string> }
    | undefined;
  const promos = (metadata?.promos as any) || [];
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
    images: medusaProduct.images?.map((img) => img.url!) || [image],
    reviews: 128,
    rating: 4.8,
    category: categoryName,
    // Carry raw category IDs so related-products can filter server-side
    categoryIds: medusaProduct.categories?.map((c) => c.id) ?? [],
    variants,
    options,
    promos,
    couponTimer,
    techSpecs,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Data Fetchers
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Fetches a paginated list of products.
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
    if (!region?.id) {
      console.warn("No region found — Medusa backend may be offline or unconfigured.");
      return { response: { products: [], count: 0 } };
    }

    const { products, count } = await sdk.store.product.list({
      limit,
      offset: (pageParam - 1) * limit,
      region_id: region.id,
      category_id: category_id.length > 0 ? category_id : undefined,
      fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
    });

    return {
      response: {
        products: products.map(mapMedusaProductToStorefront),
        count,
      },
    };
  } catch (error) {
    console.error("Failed to fetch products:", error);
    return { response: { products: [], count: 0 } };
  }
}

/**
 * Fetches a single product by its handle (URL slug).
 */
export async function getProductByHandle(handle: string): Promise<Product | null> {
  try {
    const region = await getRegionAe();
    if (!region?.id) return null;

    const { products } = await sdk.store.product.list({
      handle,
      region_id: region.id,
      fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
    });

    if (!products || products.length === 0) return null;
    return mapMedusaProductToStorefront(products[0]);
  } catch (error) {
    console.error(`Failed to fetch product "${handle}":`, error);
    return null;
  }
}

/**
 * Fetches specific products by handle array for the hero section.
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
 * FIX: Fetches related products filtered by the current product's category IDs.
 * Previously the product page fetched ALL 50 products then filtered client-side,
 * wasting a full backend round-trip for irrelevant data.
 */
export async function getRelatedProducts(
  currentProductId: string,
  categoryIds: string[],
  limit = 4
): Promise<Product[]> {
  try {
    const region = await getRegionAe();
    if (!region?.id) return [];

    const { products } = await sdk.store.product.list({
      limit: limit + 2, // fetch extra to account for filtering out current product
      region_id: region.id,
      category_id: categoryIds.length > 0 ? categoryIds : undefined,
      fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
    });

    return products
      .map(mapMedusaProductToStorefront)
      .filter((p) => p.id !== currentProductId)
      .slice(0, limit);
  } catch (error) {
    console.error("Failed to fetch related products:", error);
    return [];
  }
}

/**
 * Fetches home page content from a Collection or falls back to Region metadata.
 */
export async function getHomeContent(): Promise<{
  title: string;
  subtitle: string;
  image: string;
  products: Product[];
}> {
  const defaultTitle = "Smile Brighter,\nEvery Single Day";
  const defaultSubtitle =
    "Curated professional dental solutions delivered to your doorstep. Experience the gold standard of oral hygiene in the UAE.";
  const defaultImage =
    "https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb";

  try {
    // getRegionAe() is cached — all callers in a single request share the result
    const region = await getRegionAe();

    const { collections } = await sdk.store.collection.list({ handle: "home-page" });
    const homeCollection = collections?.[0];

    if (homeCollection) {
      const { products: collectionProducts } = await sdk.store.product.list({
        collection_id: [homeCollection.id],
        region_id: region?.id,
        fields: "variants.*,variants.calculated_price.*,options.*,categories.*",
      });

      const finalProducts =
        collectionProducts.length > 0
          ? collectionProducts.map(mapMedusaProductToStorefront)
          : await getHomeHeroProducts(["io-9", "sonicare-9900"]);

      return {
        title:
          (homeCollection.metadata?.hero_title as string) ||
          (region?.metadata?.hero_title as string) ||
          defaultTitle,
        subtitle:
          (homeCollection.metadata?.hero_subtitle as string) ||
          (region?.metadata?.hero_subtitle as string) ||
          defaultSubtitle,
        image:
          (homeCollection.metadata?.hero_image_url as string) ||
          (region?.metadata?.hero_image_url as string) ||
          defaultImage,
        products: finalProducts,
      };
    }

    if (region) {
      return {
        title: (region.metadata?.hero_title as string) || defaultTitle,
        subtitle: (region.metadata?.hero_subtitle as string) || defaultSubtitle,
        image: (region.metadata?.hero_image_url as string) || defaultImage,
        products: await getHomeHeroProducts(["io-9", "sonicare-9900"]),
      };
    }

    return { title: defaultTitle, subtitle: defaultSubtitle, image: defaultImage, products: [] };
  } catch (error) {
    console.error("Failed to fetch home content:", error);
    return { title: defaultTitle, subtitle: defaultSubtitle, image: defaultImage, products: [] };
  }
}
