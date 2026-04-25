"use client";

import { ContactHero } from "@/components/contact/ContactHero";
import { ContactGrid } from "@/components/contact/ContactGrid";
import { ContactForm } from "@/components/contact/ContactForm";
import { FAQSection } from "@/components/contact/FAQSection";
import { ArrowRight, ShieldCheck, Truck, RotateCcw, Award } from "lucide-react";
import Link from "next/link";

export const ContactPageClient = () => {
  const supportLinks = [
    { icon: <RotateCcw size={20} />, title: "Return & Refund Policy", href: "/refund-policy" },
    { icon: <Truck size={20} />, title: "Shipping Policy", href: "/shipping-policy" },
    { icon: <Award size={20} />, title: "Warranty Information", href: "/warranty-information" },
  ];

  return (
    <div className="flex flex-col gap-0 pb-20">
      <ContactHero />
      <ContactGrid />
      
      <div className="max-w-7xl mx-auto w-full px-8 grid grid-cols-1 lg:grid-cols-12 gap-16 py-12">
        <div className="lg:col-span-7">
          <ContactForm />
        </div>
        
        <div className="lg:col-span-5 flex flex-col gap-12">
          {/* Quick Links */}
          <div className="flex flex-col gap-6">
            <h3 className="text-2xl font-serif font-bold text-primary-dark">Quick Support Links</h3>
            <div className="flex flex-col gap-4">
              {supportLinks.map((link, i) => (
                <Link 
                  key={i} 
                  href={link.href}
                  className="group flex items-center justify-between p-6 bg-[#F9F9F7] rounded-2xl hover:bg-white hover:shadow-lg transition-all border border-transparent hover:border-gray-100"
                >
                  <div className="flex items-center gap-4">
                    <div className="text-primary">{link.icon}</div>
                    <span className="font-bold text-primary-dark">{link.title}</span>
                  </div>
                  <ArrowRight size={18} className="text-gray-300 group-hover:text-primary transition-colors" />
                </Link>
              ))}
            </div>
          </div>

          {/* Authenticity Guarantee */}
          <div className="bg-primary-dark text-white p-10 rounded-[2.5rem] relative overflow-hidden shadow-2xl">
            <div className="relative z-10 flex flex-col gap-6">
              <div className="w-12 h-12 bg-white/10 rounded-full flex items-center justify-center">
                <ShieldCheck size={28} className="text-accent" />
              </div>
              <div className="flex flex-col gap-2">
                <h3 className="text-2xl font-serif font-bold">Authenticity Guarantee</h3>
                <p className="text-white/70 leading-relaxed">
                  Every instrument and material on DentaUAE is sourced directly from manufacturers or authorized distributors with full UAE MoH certification.
                </p>
              </div>
            </div>
            
            {/* Decorative background logo */}
            <div className="absolute -right-10 -bottom-10 opacity-5">
               <ShieldCheck size={200} strokeWidth={1} />
            </div>
          </div>
        </div>
      </div>

      <FAQSection />

      {/* Deep Footer CTA */}
      <div className="max-w-4xl mx-auto text-center py-20 px-8">
        <h3 className="text-3xl font-serif font-bold text-primary-dark">Still need assistance?</h3>
        <p className="text-gray-500 mt-4 mb-8">
          Our clinical experts are standing by to help with your specialized equipment needs.
        </p>
        <div className="flex flex-wrap items-center justify-center gap-6">
          <div className="flex flex-col">
            <span className="text-xs uppercase tracking-widest text-gray-400 font-bold mb-1">Dubai Healthcare City</span>
            <span className="text-primary-dark font-medium">Building 64, UAE.</span>
          </div>
        </div>
      </div>
    </div>
  );
};
