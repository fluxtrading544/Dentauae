"use client";

import Image from "next/image";
import Link from "next/link";
import { ShoppingBag, CheckCircle2 } from "lucide-react";
import type { Product } from "@/lib/mock-data";
import { useCartStore } from "@/lib/store";
import { useState } from "react";

export const ProductCard = ({ product }: { product: Product }) => {
  const addItem = useCartStore((state) => state.addItem);
  const [added, setAdded] = useState(false);
  return (
    <div 
      className="group flex flex-col bg-white rounded-2xl border border-gray-100 hover:border-primary/20 hover:shadow-xl transition-all duration-500 overflow-hidden relative"
    >
      {/* Top Badges */}
      <div className="absolute top-4 left-4 z-10 flex flex-col gap-1.5">
        {product.price > 800 && (
          <span className="bg-[#EAB308] text-white text-[8px] font-bold px-2 py-0.5 rounded tracking-widest shadow-sm">BESTSELLER</span>
        )}
        {product.id === 'io-9' && (
          <span className="bg-primary text-white text-[8px] font-bold px-2 py-0.5 rounded tracking-widest shadow-sm">NEW</span>
        )}
      </div>

      {/* Wishlist Heart */}
      <button className="absolute top-4 right-4 z-10 w-8 h-8 rounded-full bg-white/80 backdrop-blur-sm border border-gray-100 flex items-center justify-center text-gray-300 hover:text-red-400 transition-all">
        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>
      </button>

      {/* Image Area */}
      <Link href={`/products/${product.id}`} className="relative aspect-square bg-[#F9F9F7] overflow-hidden">
        <Image 
          src={product.image}
          alt={product.name}
          fill
          className="object-contain p-6 group-hover:scale-105 transition-transform duration-700"
        />
      </Link>
      
      {/* Content Area */}
      <div className="p-5 flex flex-col gap-3 flex-1">
        <div className="flex flex-col gap-0.5">
          <span className="text-[9px] font-bold text-gray-400 uppercase tracking-widest">{product.brand}</span>
          <Link href={`/products/${product.id}`}>
            <h3 className="text-base lg:text-lg font-serif font-bold text-primary-dark group-hover:text-primary transition-colors leading-snug line-clamp-2">
              {product.name}
            </h3>
          </Link>
        </div>

        <div className="flex flex-col gap-2">
          <div className="flex items-baseline gap-2">
             <span className="text-lg font-bold text-primary-dark">AED {product.price.toFixed(0)}</span>
             <span className="text-xs text-gray-400 line-through font-light">AED {(product.price * 1.15).toFixed(0)}</span>
          </div>
          
          {/* BNPL Badges */}
          <div className="flex items-center gap-1.5">
            <div className="px-1.5 py-0.5 rounded bg-gray-50 border border-gray-100 flex items-center">
               <span className="text-[7px] font-bold text-[#E94B8A]">tabby</span>
            </div>
            <div className="px-1.5 py-0.5 rounded bg-gray-50 border border-gray-100 flex items-center">
               <span className="text-[7px] font-bold text-[#FF9000]">tamara</span>
            </div>
          </div>
        </div>

        <button 
          onClick={(e) => {
            e.preventDefault();
            addItem(product);
            setAdded(true);
            setTimeout(() => setAdded(false), 2000);
          }}
          className={`w-full mt-2 py-3 rounded-lg font-bold text-[10px] tracking-widest transition-all flex items-center justify-center gap-2 ${
            added 
              ? "bg-primary-dark text-white shadow-inner" 
              : "bg-primary hover:bg-primary-dark text-white"
          }`}
        >
          <ShoppingBag size={14} className={added ? "hidden" : "block"} />
          {added ? <CheckCircle2 size={14} /> : null}
          {added ? "ADDED TO CART" : "ADD TO CART"}
        </button>
      </div>
    </div>
  );
};

export default ProductCard;
