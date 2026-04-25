import { getProductByHandle, getProductsList } from "@/lib/data/products";
import ProductPageContent from "./ProductPageContent";
import { notFound } from "next/navigation";

export default async function ProductPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  
  const product = await getProductByHandle(id);
  
  if (!product) {
    notFound();
  }

  const bundleItem = await getProductByHandle("io-heads");
  
  // Fetch related products data on the server
  const { response: relatedResponse } = await getProductsList({ 
    limit: 5,
    category_id: [] // We don't have category filtering in basic sdk yet, filter manually below
  });
  
  const relatedData = relatedResponse.products
    .filter(p => p.id !== product.id)
    .slice(0, 4);

  return (
    <ProductPageContent 
      product={product} 
      bundleItem={bundleItem}
      relatedProductsData={relatedData}
    />
  );
}
