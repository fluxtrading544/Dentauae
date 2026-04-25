"use client";

import { useEffect, useState } from "react";
import Image from "next/image";
import Link from "next/link";
import type { Product } from "@/lib/mock-data";

export const RecentlyViewed = ({ currentProduct }: { currentProduct: Product }) => {
  const [recentProducts, setRecentProducts] = useState<Product[]>([]);

  useEffect(() => {
    // 1. Get existing history
    const historyRaw = localStorage.getItem("denta_browsing_history");
    let history: Product[] = historyRaw ? JSON.parse(historyRaw) : [];

    // 2. Filter out current product and add to front
    history = history.filter(p => p.id !== currentProduct.id);
    const newHistory = [currentProduct, ...history].slice(0, 5); // Keep last 5

    // 3. Save back
    localStorage.setItem("denta_browsing_history", JSON.stringify(newHistory));

    // 4. Set state to display (excluding current one)
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setRecentProducts(newHistory.filter(p => p.id !== currentProduct.id));
  }, [currentProduct]);

  if (recentProducts.length === 0) return null;

  return (
    <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-24 bg-[#FAFAF8] rounded-[3rem] mt-12 overflow-hidden">
      <div className="flex flex-col gap-12">
        <h2 className="text-3xl font-serif text-primary-dark">Recently Viewed</h2>
        
        <div className="flex gap-8 overflow-x-auto pb-8 snap-x no-scrollbar">
          {recentProducts.map((p) => (
            <Link 
              key={p.id} 
              href={`/products/${p.id}`}
              className="flex-shrink-0 w-64 group snap-start"
            >
              <div className="relative aspect-square bg-white rounded-3xl p-8 mb-4 shadow-sm group-hover:shadow-xl transition-all border border-gray-50 flex items-center justify-center">
                <Image src={p.image} alt={p.name} fill className="object-contain p-8 group-hover:scale-105 transition-transform" />
              </div>
              <h3 className="text-sm font-bold text-primary-dark leading-tight group-hover:text-primary transition-colors">{p.name}</h3>
              <p className="text-sm font-bold text-gray-500 mt-1">AED {p.price.toFixed(2)}</p>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
};

export default RecentlyViewed;
