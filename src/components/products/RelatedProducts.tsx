import { getProductsList } from "@/lib/data/products";
import { ProductCard } from "./ProductCard";
import Link from "next/link";
import { ArrowRight } from "lucide-react";

export const RelatedProducts = async ({ currentProductId }: { category: string; currentProductId: string }) => {
  const { response } = await getProductsList({ limit: 5 });
  const related = response.products.filter(p => p.id !== currentProductId).slice(0, 4);

  if (related.length === 0) return null;

  return (
    <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-24 border-t border-gray-100">
      <div className="flex flex-col gap-16">
        <div className="flex items-end justify-between border-b border-gray-100 pb-8">
          <div className="flex flex-col gap-4">
            <span className="text-xs font-bold text-gray-400 uppercase tracking-widest">Clinician&apos;s Choice</span>
            <h2 className="text-4xl font-serif text-primary-dark tracking-tight">Related Products</h2>
          </div>
          <Link href="/shop" className="text-primary-dark font-bold flex items-center gap-2 hover:gap-4 transition-all pb-2 border-b-2 border-primary/10 hover:border-primary">
            View Entire Shop <ArrowRight size={20} />
          </Link>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-10">
          {related.map((product) => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>
      </div>
    </section>
  );
};

export default RelatedProducts;
