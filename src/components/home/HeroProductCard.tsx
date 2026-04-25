"use client";

import Image from "next/image";

interface HeroProductCardProps {
  name: string;
  subtext: string;
  price: string;
  image: string;
  className?: string;
}

export const HeroProductCard = ({ name, subtext, price, image, className }: HeroProductCardProps) => {
  return (
    <div className={`bg-white/90 backdrop-blur-md p-5 rounded-2xl shadow-xl flex flex-col gap-3 max-w-[240px] border border-white/40 transition-all hover:-translate-y-1 ${className}`}>
      <div className="relative aspect-square w-full rounded-xl overflow-hidden bg-[#f4f4f2]">
        <Image 
          src={image} 
          alt={name} 
          fill 
          className="object-contain p-4"
        />
      </div>
      <div className="flex flex-col gap-1">
        <h4 className="text-lg font-serif font-bold text-primary-dark leading-tight">{name}</h4>
        <p className="text-[11px] font-medium text-gray-500 uppercase tracking-widest">{subtext}</p>
        <div className="mt-2 text-primary font-bold">{price}</div>
      </div>
    </div>
  );
};

export default HeroProductCard;
