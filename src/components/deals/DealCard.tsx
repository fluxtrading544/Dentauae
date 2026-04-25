import Link from "next/link";
import { Timer, ArrowUpRight } from "lucide-react";
import { Deal } from "@/lib/deal-data";

export const DealCard = ({ deal }: { deal: Deal }) => {
  return (
    <div className="group relative bg-white rounded-[3rem] overflow-hidden flex flex-col lg:flex-row min-h-[480px] border border-gray-100 hover:shadow-2xl hover:shadow-primary/5 transition-all duration-700">
      <div className="lg:w-1/2 relative bg-[#F9F9F7] overflow-hidden flex items-center justify-center p-12">
         {/* Atmospheric Backdrop */}
         <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(0,84,64,0.03),transparent_70%)]"></div>
         
         <div className="text-4xl font-serif text-primary/5 uppercase tracking-[0.6em] rotate-[-15deg] absolute inset-0 flex items-center justify-center pointer-events-none select-none">
            {deal.category}
         </div>
         
         {/* Representative Bracketed Title (Stitch Style) */}
         <div className="relative z-10 text-primary-dark font-serif text-3xl lg:text-4xl group-hover:scale-105 transition-transform duration-1000 flex items-center gap-4">
            <span className="text-tertiary/40">[</span>
            {deal.title}
            <span className="text-tertiary/40">]</span>
         </div>
      </div>

      <div className="lg:w-1/2 p-12 lg:p-20 flex flex-col justify-between gap-12 bg-white">
         <div className="flex flex-col gap-10">
            <div className="flex items-center justify-between">
               <div className="flex items-center gap-3">
                  <div className="w-2 h-2 rounded-full bg-tertiary animate-pulse"></div>
                  <span className="text-tertiary font-bold text-[10px] uppercase tracking-[0.2em]">
                     {deal.discountTag}
                  </span>
               </div>
               <div className="flex items-center gap-2 text-primary/50 font-bold text-[9px] uppercase tracking-[0.2em]">
                  <Timer size={12} />
                  {deal.expiryDate}
               </div>
            </div>

            <div className="flex flex-col gap-6">
               <h3 className="text-3xl lg:text-5xl font-serif text-primary-dark leading-[1.1] tracking-tighter">
                  {deal.title}
               </h3>
               <p className="text-gray-500 leading-relaxed text-base border-l-2 border-primary/5 pl-8 italic">
                  &quot;{deal.description}&quot;
               </p>
            </div>
         </div>

         <Link 
           href={`/shop`}
           className="flex items-center gap-4 text-primary font-bold uppercase tracking-[0.25em] text-[10px] group/link"
         >
           Access Offer
           <div className="w-12 h-12 rounded-full border border-primary/10 flex items-center justify-center group-hover/link:bg-primary group-hover/link:text-white group-hover/link:scale-110 transition-all duration-500">
              <ArrowUpRight size={18} />
           </div>
         </Link>
      </div>
    </div>
  );
};
