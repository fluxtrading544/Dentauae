"use client";

import { useEffect, useState } from "react";
import Image from "next/image";
import { AddToCartButton } from "./AddToCartButton";
import type { Product } from "@/lib/mock-data";

export const StickyAddToCart = ({ product, variantId }: { product: Product; variantId?: string }) => {
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      // Show after user scrolls past the main CTA (roughly 800px)
      setIsVisible(window.scrollY > 800);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <div className={`fixed bottom-0 left-0 right-0 z-50 bg-white border-t border-gray-100 shadow-[0_-10px_40px_rgba(0,0,0,0.05)] transition-transform duration-500 transform ${isVisible ? 'translate-y-0' : 'translate-y-full'}`}>
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-4 flex items-center justify-between gap-8">
        <div className="flex items-center gap-4">
          <div className="relative w-12 h-12 rounded-xl bg-[#FAFAF8] p-1 shadow-sm border border-gray-50 flex items-center justify-center">
            <Image src={product.image} alt="Sticky" fill className="object-contain p-2" />
          </div>
          <div className="flex flex-col">
            <h4 className="text-sm font-bold text-primary-dark truncate max-w-[150px] lg:max-w-xs">{product.name}</h4>
            <p className="text-xs font-bold text-primary">AED {product.price.toFixed(2)}</p>
          </div>
        </div>

        <div className="flex-1 max-w-xs">
          <AddToCartButton product={product} variantId={variantId} />
        </div>
      </div>
    </div>
  );
};

export default StickyAddToCart;
