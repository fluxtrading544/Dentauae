"use client";

import { useState } from "react";
import { ChevronDown } from "lucide-react";

export const FAQSection = () => {
  const faqs = [
    {
      q: "What are the delivery timelines within the UAE?",
      a: "For orders within Dubai and Abu Dhabi, we offer same-day or next-day delivery. Other emirates typically receive delivery within 24-48 hours."
    },
    {
      q: "How do I process a return for clinical materials?",
      a: "Clinical materials must be in their original, unopened packaging to be eligible for return. Please contact our support team within 7 days of delivery to initiate a return request."
    },
    {
      q: "Are your products UAE Ministry of Health (MoH) approved?",
      a: "Yes, 100% of the clinical instruments and materials on DentaUAE are sourced from authorized distributors and carry full UAE MoH certification."
    },
    {
      q: "Does the pricing include VAT?",
      a: "All prices shown on DentaUAE are exclusive of VAT. The standard 5% VAT will be applied at the checkout stage as per UAE regulations."
    }
  ];

  const [active, setActive] = useState<number | null>(0);

  return (
    <section className="bg-[#FAF9F6] py-24 px-8">
      <div className="max-w-4xl mx-auto flex flex-col gap-16">
        <div className="text-center flex flex-col gap-4">
          <h2 className="text-4xl lg:text-5xl font-serif font-bold text-primary-dark tracking-tight">Frequently Asked Questions</h2>
          <p className="text-gray-600">Find quick answers to our most common patient and practitioner inquiries.</p>
        </div>

        <div className="flex flex-col gap-4">
          {faqs.map((faq, i) => (
            <div 
              key={i}
              className={`bg-white rounded-2xl border transition-all duration-300 overflow-hidden ${
                active === i ? "border-primary shadow-lg" : "border-gray-100 shadow-sm"
              }`}
            >
              <button 
                onClick={() => setActive(active === i ? null : i)}
                className="w-full px-8 py-6 flex items-center justify-between text-left group"
              >
                <span className={`text-lg font-bold font-serif transition-colors ${active === i ? "text-primary" : "text-primary-dark group-hover:text-primary"}`}>
                  {faq.q}
                </span>
                <div className={`p-1 rounded-full transition-all ${active === i ? "bg-primary text-white rotate-180" : "bg-gray-50 text-gray-400 group-hover:bg-primary/10 group-hover:text-primary"}`}>
                  <ChevronDown size={20} />
                </div>
              </button>
              
              <div 
                className={`transition-all duration-500 ease-in-out px-8 overflow-hidden ${
                  active === i ? "max-h-[300px] pb-8 opacity-100" : "max-h-0 opacity-0"
                }`}
              >
                <p className="text-gray-600 leading-relaxed font-sans border-t border-gray-50 pt-6">
                  {faq.a}
                </p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
