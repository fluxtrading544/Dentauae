"use client";

import { useState, useMemo } from "react";
import Image from "next/image";
import { Star, ShieldCheck, Truck, Tag, Clock, Copy, Check, Rocket } from "lucide-react";
import { useRouter } from "next/navigation";
import { useCartStore } from "@/lib/store";
import type { Product } from "@/lib/mock-data";
import { AddToCartButton } from "./AddToCartButton";

export const ProductDetailsClient = ({ product }: { product: Product }) => {
  const router = useRouter();
  const addItem = useCartStore((state) => state.addItem);

  const initialVariant = useMemo(() => {
    return product.variants?.find(v => v.id === product.variantId) || product.variants?.[0];
  }, [product.variants, product.variantId]);

  const [selectedVariant, setSelectedVariant] = useState(initialVariant);
  const [copiedCode, setCopiedCode] = useState<string | null>(null);

  const optionsList = product.options || [];

  const handleVariantChange = (optionTitle: string, value: string) => {
    const newVariant = product.variants?.find(v => {
      return v.options[optionTitle] === value;
    });
    if (newVariant) {
      setSelectedVariant(newVariant);
    }
  };

  const copyToClipboard = (code: string) => {
    navigator.clipboard.writeText(code);
    setCopiedCode(code);
    setTimeout(() => setCopiedCode(null), 2000);
  };

  if (!selectedVariant) return null;

  const originalPrice = selectedVariant.price * 1.15;
  const savings = originalPrice - selectedVariant.price;

  return (
    <div className="flex flex-col gap-10">
      {/* Brand & Title */}
      <div className="flex flex-col gap-5">
        <div className="flex items-center justify-between border-b border-gray-100 pb-4">
          <span className="text-sm font-bold text-primary uppercase tracking-[0.3em] font-serif">{product.brand}</span>
          <div className="flex items-center gap-2">
            <div className="flex gap-0.5 text-accent">
              {[...Array(5)].map((_, i) => <Star key={i} size={14} fill="currentColor" stroke="none" />)}
            </div>
            <span className="text-xs font-bold text-primary-dark">({product.reviews} Reviews)</span>
          </div>
        </div>
        
        <h1 className="text-2xl lg:text-3xl font-serif text-primary-dark tracking-tight leading-snug">
          {product.name}
        </h1>
      </div>

      {/* Pricing & Promo Alerts */}
      <div className="flex flex-col gap-6">
        <div className="flex flex-col gap-3">
          <div className="flex items-baseline gap-4">
            <span className="text-5xl font-bold text-primary-dark">AED {selectedVariant.price.toFixed(2)}</span>
            <span className="text-xl text-gray-400 line-through font-light">AED {originalPrice.toFixed(2)}</span>
          </div>
          <div className="flex flex-wrap items-center gap-3">
             <span className="bg-primary/10 text-primary text-[10px] font-bold px-3 py-1 rounded-full uppercase tracking-widest border border-primary/20">
               Savings: AED {savings.toFixed(2)} (15% OFF)
             </span>
             {product.couponTimer && (
                <div className="flex items-center gap-2 bg-accent/10 text-accent text-[10px] font-bold px-3 py-1 rounded-full uppercase tracking-widest border border-accent/20 animate-pulse">
                    <Clock size={10} />
                    Ends In: {product.couponTimer}
                </div>
             )}
          </div>
        </div>

        {/* PROMO SECTION */}
        {product.promos && product.promos.length > 0 && (
            <div className="flex flex-col gap-4 p-5 bg-[#fafafa] rounded-[2rem] border border-gray-100">
                <div className="flex items-center gap-2 text-xs font-bold text-primary-dark uppercase tracking-widest">
                    <Tag size={14} className="text-primary" />
                    Clinical Offers Applied
                </div>
                <div className="flex flex-col gap-3">
                    {product.promos.map((promo, idx) => (
                        <div key={idx} className="flex items-center justify-between bg-white px-4 py-3 rounded-xl border border-gray-50 shadow-sm group">
                            <div className="flex flex-col">
                                <span className="text-[10px] font-bold text-gray-400 uppercase">{promo.label}</span>
                                <span className="text-sm font-bold text-primary-dark">{promo.code}</span>
                            </div>
                            <button 
                                onClick={() => copyToClipboard(promo.code)}
                                className={`flex items-center gap-2 px-4 py-2 rounded-lg text-[10px] font-bold uppercase transition-all ${
                                    copiedCode === promo.code 
                                    ? "bg-green-500 text-white" 
                                    : "bg-primary-dark text-white hover:bg-primary"
                                }`}
                            >
                                {copiedCode === promo.code ? <Check size={12} /> : <Copy size={12} />}
                                {copiedCode === promo.code ? "Copied" : "Copy"}
                            </button>
                        </div>
                    ))}
                </div>
            </div>
        )}
      </div>

      {/* Visual Variant Selector */}
      <div className="flex flex-col gap-8 pt-8 border-t border-gray-100">
        {optionsList.map((option) => {
          return (
            <div key={option.id} className="flex flex-col gap-5">
              <label className="text-xs font-bold text-primary-dark uppercase tracking-[0.2em]">
                {option.title}: <span className="text-gray-400 font-medium">{selectedVariant.options[option.title]}</span>
              </label>
              
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
                {option.values.map((val) => {
                  const isSelected = selectedVariant.options[option.title] === val;
                  const variant = product.variants?.find(v => v.options[option.title] === val);
                  
                  return (
                    <button
                      key={val}
                      onClick={() => handleVariantChange(option.title, val)}
                      className={`relative flex flex-col items-center gap-2 p-3 rounded-2xl border-2 transition-all group ${
                        isSelected 
                          ? "border-primary bg-primary/5 ring-4 ring-primary/5" 
                          : "border-gray-100 bg-white hover:border-primary/50"
                      }`}
                    >
                      <div className="relative w-full aspect-square rounded-xl overflow-hidden bg-[#fbfbfb] mb-1">
                        {variant?.thumbnail ? (
                          <Image 
                            src={variant.thumbnail} 
                            alt={val} 
                            fill 
                            className="object-contain p-1.5 transition-transform group-hover:scale-110" 
                          />
                        ) : (
                          <Image
                            src={product.image}
                            alt={val}
                            fill
                            className="object-contain p-1"
                          />
                        )}
                      </div>
                      <div className="flex flex-col items-center text-center w-full gap-0.5">
                        <span className={`text-[9px] font-bold uppercase truncate max-w-full ${isSelected ? "text-primary" : "text-gray-500"}`}>
                          {val}
                        </span>
                        {variant && (
                          <span className="text-[11px] font-bold text-primary-dark">
                            AED {variant.price.toFixed(2)}
                          </span>
                        )}
                      </div>
                      {isSelected && (
                        <div className="absolute -top-1.5 -right-1.5 w-5 h-5 bg-primary rounded-full flex items-center justify-center text-white border-2 border-white shadow-md z-10">
                          <Check size={12} strokeWidth={4} />
                        </div>
                      )}
                    </button>
                  );
                })}
              </div>
            </div>
          );
        })}
      </div>

      {/* Technical Specifications Section */}
      {product.techSpecs && Object.keys(product.techSpecs).length > 0 && (
          <div className="flex flex-col gap-6 pt-10 border-t border-gray-100">
              <h3 className="text-sm font-bold text-primary-dark uppercase tracking-widest flex items-center gap-2">
                  <ShieldCheck size={16} className="text-primary" />
                  Clinical Specifications
              </h3>
              <div className="grid grid-cols-1 gap-1 border border-gray-100 rounded-2xl overflow-hidden">
                  {Object.entries(product.techSpecs).map(([key, value]) => (
                      <div key={key} className="flex justify-between items-center px-5 py-3 even:bg-[#fafafa]">
                          <span className="text-[10px] font-bold text-gray-500 uppercase tracking-wider">{key}</span>
                          <span className="text-xs font-semibold text-primary-dark">{value as string}</span>
                      </div>
                  ))}
              </div>
          </div>
      )}

      {/* Action Buttons */}
      <div className="flex flex-col gap-4 pt-4">
        <AddToCartButton product={product} variantId={selectedVariant.id} />
        <button 
          onClick={() => {
            const productToAdd = { ...product, variantId: selectedVariant.id };
            addItem(productToAdd);
            router.push("/checkout");
          }}
          className="w-full h-16 bg-white border-2 border-primary-dark text-primary-dark rounded-2xl font-bold uppercase tracking-widest hover:bg-gray-50 transition-all shadow-sm flex items-center justify-center gap-2"
        >
          <Rocket size={20} className="text-primary" />
          Express Checkout
        </button>
      </div>

      {/* Trust Markers */}
      <div className="grid grid-cols-2 gap-6 pt-10 border-t border-gray-100">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-primary/5 flex items-center justify-center text-primary">
            <Truck size={18} />
          </div>
          <p className="text-[10px] font-bold text-gray-500 uppercase leading-snug">Free Express UAE Shipping</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-primary/5 flex items-center justify-center text-primary">
            <ShieldCheck size={18} />
          </div>
          <p className="text-[10px] font-bold text-gray-500 uppercase leading-snug">Original Clinical Warranty</p>
        </div>
      </div>
    </div>
  );
};

export default ProductDetailsClient;
