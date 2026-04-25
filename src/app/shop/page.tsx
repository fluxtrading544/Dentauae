import ShopPageClient from "./ShopPageClient";
import type { Metadata } from "next";
import { getProductsList } from "@/lib/data/products";
import { JsonLd } from "@/components/seo/JsonLd";

export const metadata: Metadata = {
  title: "Shop Premium Dental Care | DentaUAE",
  description: "Advanced oral care technology for a brighter, healthier smile. Discover premium models expertly curated for the UAE.",
};

export default async function ShopPage() {
  const { response } = await getProductsList({ limit: 50 });
  const products = response.products;

  const listSchema = {
    "@context": "https://schema.org",
    "@type": "ItemList",
    "name": "DentaUAE Product Catalog",
    "description": "Premium clinical oral care products",
    "itemListElement": products.map((product, index) => ({
      "@type": "ListItem",
      "position": index + 1,
      "url": `https://dentauae.com/products/${product.id}`,
      "name": product.name,
      "image": product.image
    }))
  };

  return (
    <main className="bg-surface min-h-screen pt-6">
      <JsonLd data={listSchema} />
      <ShopPageClient initialProducts={products} />
    </main>
  );
}
