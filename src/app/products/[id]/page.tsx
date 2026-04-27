import { getProductByHandle, getRelatedProducts } from "@/lib/data/products";
import ProductPageContent from "./ProductPageContent";
import { notFound } from "next/navigation";

export default async function ProductPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;

  // FIX: Run both fetches in parallel — previously they were sequential,
  // adding unnecessary latency to every product page load.
  const [product, bundleItem] = await Promise.all([
    getProductByHandle(id),
    getProductByHandle("io-heads"),
  ]);

  if (!product) {
    notFound();
  }

  // FIX: Use getRelatedProducts() which passes the product's category IDs to
  // the backend query, so only relevant products come back.
  // The old code called getProductsList({ limit: 5 }) which fetched ALL products
  // (with no category filter) and discarded most of the results client-side.
  const relatedData = await getRelatedProducts(product.id, product.categoryIds ?? [], 4);

  return (
    <ProductPageContent
      product={product}
      bundleItem={bundleItem}
      relatedProductsData={relatedData}
    />
  );
}
