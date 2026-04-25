import Link from "next/link";
import { BadgeCheck } from "lucide-react";
import { DentalBrand } from "@/lib/brand-data";

export const BrandCard = ({ brand }: { brand: DentalBrand }) => {
  return (
    <div className="group relative bg-white rounded-[2rem] p-8 border border-gray-100 hover:shadow-2xl hover:shadow-primary/5 transition-all duration-500 flex flex-col gap-6">
      <div className="relative w-full aspect-video rounded-xl overflow-hidden bg-[#fafafa] flex items-center justify-center p-8">
         <div className="text-3xl font-serif text-primary/20 uppercase tracking-widest">{brand.name}</div>
         {/* In a real app, use brand.logo */}
      </div>

      <div className="flex flex-col gap-4">
        <div className="flex items-center justify-between">
           <span className="text-[10px] font-bold text-primary uppercase tracking-[0.2em]">{brand.specialty}</span>
           <div className="flex items-center gap-1 text-primary">
              <BadgeCheck size={16} />
              <span className="text-[10px] font-bold uppercase tracking-widest">Authorized</span>
           </div>
        </div>
        <h3 className="text-2xl font-serif text-primary-dark">{brand.name}</h3>
        <p className="text-sm text-gray-500 leading-relaxed">
           {brand.description}
        </p>
      </div>

      <Link 
        href={`/shop?brand=${brand.slug}`}
        className="mt-4 flex items-center justify-center py-4 rounded-xl border border-primary/10 text-primary font-bold text-xs uppercase tracking-widest hover:bg-primary hover:text-white transition-all"
      >
        View Collections
      </Link>
    </div>
  );
};
