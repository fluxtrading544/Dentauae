"use client";

import Image from "next/image";
import { ChevronRight, CheckCircle } from "lucide-react";
import { useState } from "react";
import { ProductDetailsClient } from "@/components/products/ProductDetailsClient";
import { ProductReviews } from "@/components/products/ProductReviews";
import { RecentlyViewed } from "@/components/products/RecentlyViewed";
import { StickyAddToCart } from "@/components/products/StickyAddToCart";
import { AddBundleButton } from "@/components/products/AddBundleButton";
import { JsonLd } from "@/components/seo/JsonLd";
import Link from "next/link";
import type { Product } from "@/lib/mock-data";

export default function ProductPage({ 
  product, 
  bundleItem,
  relatedProductsData
}: { 
  product: Product;
  bundleItem: Product | null;
  relatedProductsData: Product[];
}) {
  const allImages = product.images || [product.image];
  const [activeImage, setActiveImage] = useState(allImages[0]);
  const [isZoomed, setIsZoomed] = useState(false);

  const productSchema = {
    "@context": "https://schema.org",
    "@type": "Product",
    "name": product.name,
    "image": product.image,
    "description": product.description,
    "brand": { "@type": "Brand", "name": product.brand }
  };

  return (
    <div className="flex flex-col pb-24 overflow-x-hidden">
      <JsonLd data={productSchema} />
      
      {/* 1. Breadcrumbs */}
      <nav className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-8">
        <div className="flex items-center gap-2 text-[10px] font-bold uppercase tracking-widest text-gray-400">
          <Link href="/shop" className="hover:text-primary">Shop</Link>
          <ChevronRight size={10} />
          <Link href={`/shop?category=${product.category}`} className="hover:text-primary">{product.category}</Link>
          <ChevronRight size={10} />
          <span className="text-primary-dark">{product.name}</span>
        </div>
      </nav>
      
      {/* 2. Product Hero */}
      <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 grid grid-cols-1 lg:grid-cols-12 gap-16 items-start pb-24">
        {/* Gallery: Vertical Thumbnails on Left + Main Image */}
        <div className="lg:col-span-7 flex flex-col-reverse lg:flex-row gap-6 sticky top-32">
          {/* Thumbnails */}
          <div className="flex lg:flex-col gap-4 overflow-x-auto lg:overflow-y-auto no-scrollbar lg:w-24 pb-4 lg:pb-0">
            {allImages.map((img, i) => (
              <div 
                key={i} 
                onMouseEnter={() => setActiveImage(img)}
                onClick={() => setActiveImage(img)}
                className={`relative aspect-square w-20 lg:w-full flex-shrink-0 bg-[#f9f9f7] rounded-2xl overflow-hidden border transition-all cursor-pointer group ${
                  activeImage === img ? "border-primary ring-2 ring-primary/10 shadow-lg" : "border-border-custom hover:border-primary/50"
                }`}
              >
                <Image 
                  src={img} 
                  alt={`${product.name} gallery ${i}`} 
                  fill 
                  className={`object-contain p-2 transition-opacity ${activeImage === img ? "opacity-100" : "opacity-60 group-hover:opacity-100"}`} 
                />
              </div>
            ))}
          </div>

          {/* Main Image with Hover Zoom */}
          <div 
            className="flex-1 relative aspect-square bg-[#f9f9f7] rounded-[2.5rem] lg:rounded-[4rem] overflow-hidden shadow-2xl shadow-slate-200/50 border border-white group"
            onMouseEnter={() => setIsZoomed(true)}
            onMouseLeave={() => setIsZoomed(false)}
          >
             <div className="absolute top-8 left-8 z-20">
                <div className="bg-primary/90 text-white text-[10px] font-bold px-4 py-2 rounded-full uppercase tracking-widest backdrop-blur-md shadow-lg border border-white/10">
                   Official Partner
                </div>
             </div>
            <div className={`relative w-full h-full transition-transform duration-700 ease-out ${isZoomed ? "scale-125 cursor-zoom-in" : "scale-100"}`}>
              <Image 
                src={activeImage}
                alt={product.name}
                fill
                className="object-contain p-12 lg:p-24"
                priority
              />
            </div>
          </div>
        </div>

        {/* Info Side Panel */}
        <div className="lg:col-span-5">
          <ProductDetailsClient product={product} />
        </div>
      </section>

      {/* 3. Feature Section */}
      <section className="bg-white py-24 border-t border-gray-50">
        <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 grid grid-cols-1 lg:grid-cols-2 gap-20 items-center">
           <div className="flex flex-col gap-8 order-2 lg:order-1">
              <h2 className="text-4xl lg:text-5xl font-serif text-primary-dark tracking-tight leading-tight">Redefining the Professional Clean.</h2>
              <div className="text-gray-600 leading-relaxed text-lg pr-12 border-l-4 border-primary/20 pl-8 flex flex-col gap-4">
                {product.description.split("\n").map((line, i) => {
                  if (line.trim().startsWith("-")) {
                    return (
                      <div key={i} className="flex gap-3 items-start">
                        <div className="w-1.5 h-1.5 rounded-full bg-primary mt-2.5 flex-shrink-0" />
                        <span className="text-gray-700 font-medium">{line.trim().substring(1).trim()}</span>
                      </div>
                    );
                  }
                  return <p key={i} className="italic font-serif text-primary-dark/80">{line}</p>;
                })}
              </div>
              <div className="flex flex-col gap-5 mt-4">
                {[
                  "Clinically proven A.I. deep-clean tracking",
                  "Whisper-quiet magnetic drive technology",
                  "Interactive diagnostic color display"
                ].map((feature, i) => (
                  <div key={i} className="flex items-center gap-4 group">
                    <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary group-hover:bg-primary group-hover:text-white transition-all shadow-sm">
                      <CheckCircle size={16} fill="currentColor" stroke="none" className="text-inherit" />
                    </div>
                    <span className="text-primary-dark font-bold text-base tracking-tight">{feature}</span>
                  </div>
                ))}
              </div>
           </div>
           <div className="relative aspect-[1.2/1] rounded-[4rem] overflow-hidden shadow-[0_50px_100px_-20px_rgba(0,0,0,0.15)] order-1 lg:order-2 border-8 border-white/50">
              <Image 
                src={product.image} 
                alt="Product Lifestyle"
                fill
                className="object-cover scale-150 grayscale-[0.2] brightness-95 hover:scale-110 transition-transform duration-[2000ms]"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent"></div>
           </div>
        </div>
      </section>

      {/* 4. Frequently Bought Together */}
      {bundleItem && (
        <section className="px-4 lg:px-8 py-24">
          <div className="max-w-7xl mx-auto w-full bg-gradient-to-br from-[#FAFAF8] to-white rounded-[4rem] lg:rounded-[6rem] p-10 lg:p-24 flex flex-col gap-12 border border-white shadow-xl shadow-slate-100">
            <h2 className="text-4xl font-serif text-primary-dark text-center lg:text-left">Frequently Bought Together</h2>
            
            <div className="flex flex-col lg:flex-row items-center justify-between gap-16">
              <div className="flex items-center gap-6 lg:gap-14">
                <div className="relative w-36 h-36 lg:w-48 lg:h-48 bg-white rounded-[2rem] p-6 shadow-xl shadow-slate-200 border border-white flex items-center justify-center group">
                  <Image src={product.image} alt="Original" fill className="object-contain p-6 group-hover:scale-105 transition-transform" />
                </div>
                <div className="text-5xl text-slate-200 font-light">+</div>
                <div className="relative w-36 h-36 lg:w-48 lg:h-48 bg-white rounded-[2rem] p-6 shadow-xl shadow-slate-200 border border-white flex items-center justify-center group">
                  <Image src={bundleItem.image} alt="Heads" fill className="object-contain p-6 group-hover:scale-105 transition-transform" />
                </div>
              </div>
              
              <div className="flex-1 flex flex-col gap-3 text-center lg:text-left">
                <h3 className="text-2xl font-bold text-primary-dark">Pro-Clinical Bundle Deal</h3>
                <p className="text-lg text-slate-500 font-medium italic">Save AED 45.00 when bundled today</p>
              </div>

              <div className="flex flex-col lg:items-end gap-8 min-w-[320px]">
                <div className="flex flex-col lg:items-end gap-1">
                  <span className="text-5xl lg:text-6xl font-bold text-primary tracking-tighter">AED {(product.price + bundleItem.price - 45).toFixed(2)}</span>
                  <span className="text-lg text-slate-300 line-through font-light">AED {(product.price + bundleItem.price).toFixed(2)}</span>
                </div>
                <div className="w-full lg:w-auto">
                  <AddBundleButton mainProduct={product} bundleProduct={bundleItem} />
                </div>
              </div>
            </div>
          </div>
        </section>
      )}

      {/* 5. Clinical Feedback & Reviews */}
      <ProductReviews rating={product.rating} reviewsCount={product.reviews} />

      {/* 6. Related Products */}
      <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-24 border-t border-gray-100">
        <div className="flex flex-col gap-16">
          <div className="flex items-end justify-between border-b border-gray-100 pb-8">
            <div className="flex flex-col gap-4">
              <span className="text-xs font-bold text-gray-400 uppercase tracking-widest">Clinician&apos;s Choice</span>
              <h2 className="text-4xl font-serif text-primary-dark tracking-tight">Related Products</h2>
            </div>
            <Link href="/shop" className="text-primary-dark font-bold flex items-center gap-2 hover:gap-4 transition-all pb-2 border-b-2 border-primary/10 hover:border-primary">
              View Entire Shop <ChevronRight size={20} />
            </Link>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-10">
            {relatedProductsData.map((p) => (
              <div key={p.id} className="group relative bg-white rounded-3xl p-6 border border-gray-100 hover:shadow-2xl transition-all h-[400px] flex flex-col">
                <div className="relative aspect-square mb-6 overflow-hidden rounded-2xl bg-gray-50">
                   <Image src={p.image} alt={p.name} fill className="object-contain p-6 group-hover:scale-110 transition-transform duration-500" />
                </div>
                <div className="flex flex-col gap-2 mt-auto">
                   <span className="text-[10px] font-bold text-primary uppercase tracking-[0.2em]">{p.brand}</span>
                   <h3 className="font-serif text-primary-dark text-lg line-clamp-1">{p.name}</h3>
                   <span className="text-lg font-bold text-primary-dark">AED {p.price.toFixed(2)}</span>
                </div>
                <Link href={`/products/${p.id}`} className="absolute inset-0 z-10" />
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* 7. Recently Viewed */}
      <RecentlyViewed currentProduct={product} />

      {/* 8. Sticky Action Bar */}
      <StickyAddToCart product={product} variantId={product.variantId} />
    </div>
  );
}
