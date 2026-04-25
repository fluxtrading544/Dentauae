"use client";

import Image from "next/image";
import Link from "next/link";
import { CheckCircle2, ArrowRight } from "lucide-react";

interface BrandFeatureProps {
  title: string;
  description: string;
  features: string[];
  image: string;
  ctaText: string;
  ctaLink: string;
  imagePosition?: "left" | "right";
  badge?: string;
}

export const BrandFeature = ({
  title,
  description,
  features,
  image,
  ctaText,
  ctaLink,
  imagePosition = "left",
  badge
}: BrandFeatureProps) => {
  return (
    <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-24">
      <div className={`flex flex-col ${imagePosition === 'right' ? 'lg:flex-row-reverse' : 'lg:flex-row'} items-center gap-16 lg:gap-24`}>
        {/* Image Side */}
        <div className="flex-1 w-full relative">
          <div className="relative h-[400px] lg:h-[600px] rounded-[3rem] overflow-hidden shadow-2xl group">
            <Image 
              src={image}
              alt={title}
              fill
              className="object-cover group-hover:scale-105 transition-transform duration-[2s]"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-transparent"></div>
            
            {/* Glassmorphism Badge Overlay */}
            <div className={`absolute bottom-8 ${imagePosition === 'left' ? 'right-8' : 'left-8'} p-6 bg-white/10 backdrop-blur-xl border border-white/20 rounded-2xl max-w-[200px] shadow-2xl`}>
              <p className="text-white text-xs font-bold uppercase tracking-widest mb-1">Editor&apos;s Choice</p>
              <p className="text-white/80 text-[10px] leading-tight italic">Recommended by UAE&apos;s top clinical specialists for daily hygiene.</p>
            </div>
          </div>
        </div>

        {/* Text Side */}
        <div className="flex-1 flex flex-col gap-8">
          <div className="flex flex-col gap-4">
            {badge && (
              <span className="text-primary font-bold text-[10px] uppercase tracking-[0.3em]">{badge}</span>
            )}
            <h2 className="text-4xl lg:text-6xl font-serif text-primary-dark tracking-tight leading-[1.1]">{title}</h2>
            <p className="text-xl text-gray-500 leading-relaxed italic max-w-xl">{description}</p>
          </div>

          <ul className="flex flex-col gap-5">
            {features.map((feature, index) => (
              <li key={index} className="flex items-center gap-4 text-gray-700 font-sans group">
                <CheckCircle2 size={24} className="text-primary group-hover:scale-110 transition-transform" />
                <span className="text-lg">{feature}</span>
              </li>
            ))}
          </ul>

          <Link 
            href={ctaLink} 
            className="group flex items-center gap-4 text-primary-dark font-bold text-lg w-fit mt-4"
          >
            <span className="border-b-2 border-primary/20 group-hover:border-primary transition-all pb-1">{ctaText}</span>
            <ArrowRight size={24} className="group-hover:translate-x-2 transition-transform" />
          </Link>
        </div>
      </div>
    </section>
  );
};

export default BrandFeature;
