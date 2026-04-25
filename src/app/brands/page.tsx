import { Metadata } from "next";
import { DENTAL_BRANDS } from "@/lib/brand-data";
import { BrandCard } from "@/components/brands/BrandCard";
import { ShieldCheck, ShieldAlert, Award, Search } from "lucide-react";

export const metadata: Metadata = {
  title: "Authorized Dealer Directory | DentaUAE",
  description: "Verified authenticity and clinical integrity statement for all partner brands.",
};

export default function BrandsPage() {
  return (
    <main className="bg-[#FAF9F7] min-h-screen pt-32 pb-32">
      <div className="max-w-7xl mx-auto px-4 lg:px-12 flex flex-col gap-24">
        
        {/* Editorial Header */}
        <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-10 border-b border-gray-200 pb-16">
          <div className="flex flex-col gap-6 max-w-3xl">
            <div className="flex items-center gap-3 text-primary font-bold tracking-[0.3em] uppercase text-xs">
              <div className="w-12 h-[1px] bg-primary"></div>
              Integrity & Trust
            </div>
            <h1 className="text-4xl lg:text-7xl font-serif text-primary-dark tracking-tighter leading-[0.9]">
              Authorized <br/> <span className="italic text-primary/80 pl-12 lg:pl-24">Directory.</span>
            </h1>
          </div>
          <div className="flex flex-col gap-4 text-right">
              <div className="flex items-center justify-end gap-3 text-primary font-bold">
                  <ShieldCheck size={18} />
                  <span className="text-[10px] uppercase tracking-widest">100% Genuine Clinical Goods</span>
              </div>
              <p className="text-gray-500 max-w-sm italic ml-auto">
                DentaUAE serves as the primary authorized channel for clinical-grade oral technology, ensuring patient safety through verified supply chains.
              </p>
          </div>
        </div>

        {/* Integrity Statement Section */}
        <section className="bg-primary-dark rounded-[3rem] p-12 lg:p-24 text-white overflow-hidden relative group">
           <div className="absolute top-0 right-0 w-1/2 h-full bg-[radial-gradient(circle_at_70%_30%,rgba(186,117,23,0.15),transparent_70%)] pointer-events-none"></div>
           <div className="max-w-4xl flex flex-col gap-12 relative z-10">
              <div className="flex items-center gap-4 text-tertiary">
                 <ShieldAlert size={32} />
                 <h2 className="text-2xl lg:text-3xl font-serif">The Integrity Statement</h2>
              </div>
              <div className="flex flex-col gap-8">
                 <p className="text-xl lg:text-2xl font-light leading-relaxed text-white/80">
                    At DentaUAE, we recognize that oral care is medical care. Counterfeit or &quot;grey market&quot; dental tools pose significant risks to patient safety and clinical outcomes.
                 </p>
                 <div className="grid grid-cols-1 md:grid-cols-2 gap-12 pt-8">
                    <div className="flex flex-col gap-4">
                       <h4 className="font-bold text-lg text-primary-light">Direct Manufacturer Sourcing</h4>
                       <p className="text-sm text-white/60 leading-relaxed">
                          We maintain direct relationships with Oral-B, Philips, and Waterpik. Every unit in our inventory is tracked from the manufacturer&apos;s facility to our temperature-controlled Dubai hub.
                       </p>
                    </div>
                    <div className="flex flex-col gap-4">
                       <h4 className="font-bold text-lg text-primary-light">Warranty & Support Integrity</h4>
                       <p className="text-sm text-white/60 leading-relaxed">
                          Buying from an authorized dealer is the only way to ensure your 2-year manufacturer warranty is honored in the UAE. We facilitate all clinical support claims.
                       </p>
                    </div>
                 </div>
              </div>
           </div>
        </section>

        {/* Search & Stats */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-12">
           <div className="flex items-center gap-12">
              <div className="flex flex-col">
                 <span className="text-4xl font-serif text-primary-dark tracking-tighter">04</span>
                 <span className="text-[10px] font-bold text-gray-400 uppercase tracking-widest">Global Partners</span>
              </div>
              <div className="w-[1px] h-12 bg-gray-200"></div>
              <div className="flex flex-col">
                 <span className="text-4xl font-serif text-primary-dark tracking-tighter">100%</span>
                 <span className="text-[10px] font-bold text-gray-400 uppercase tracking-widest">Authenticity Rate</span>
              </div>
           </div>

           <div className="relative w-full lg:w-96 group">
              <input 
                type="text" 
                placeholder="Search authorized brands..." 
                className="w-full bg-white border border-gray-100 rounded-full px-8 py-4 focus:outline-none focus:ring-2 focus:ring-primary/20 transition-all text-sm group-hover:border-primary/20"
              />
              <Search className="absolute right-6 top-1/2 -translate-y-1/2 text-gray-300 group-hover:text-primary transition-colors" size={18} />
           </div>
        </div>

        {/* Directory Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-12">
           {DENTAL_BRANDS.map((brand) => (
             <BrandCard key={brand.id} brand={brand} />
           ))}
        </div>

        {/* Verification Checker CTA */}
        <section className="bg-surface-container rounded-[4rem] p-12 lg:p-20 flex flex-col lg:flex-row items-center gap-16 border border-gray-100">
           <div className="flex-1 flex flex-col gap-8">
              <Award className="text-tertiary w-16 h-16" />
              <h3 className="text-3xl lg:text-5xl font-serif text-primary-dark leading-tight">Patient Safety <br/> <span className="italic pl-12 text-primary/70">Registry.</span></h3>
              <p className="text-gray-500 leading-relaxed text-lg">
                Not sure if your purchase is authorized? Use our clinical registry to verify serial numbers against official manufacturer databases.
              </p>
           </div>
           <div className="flex-1 w-full bg-white rounded-[3rem] p-10 shadow-xl shadow-primary/5 border border-gray-50">
              <div className="flex flex-col gap-6">
                 <div className="flex flex-col gap-2">
                    <label className="text-[10px] font-bold text-primary uppercase tracking-widest">Serial Number / Batch ID</label>
                    <input 
                      type="text" 
                      placeholder="e.g. SN-2024-OX-99..." 
                      className="bg-surface-container-low px-6 py-4 rounded-2xl border border-gray-100 focus:outline-none focus:border-primary transition-all text-sm"
                    />
                 </div>
                 <button className="w-full bg-primary text-white font-bold py-5 rounded-2xl hover:bg-primary-dark transition-all shadow-lg shadow-primary/10 uppercase tracking-widest text-xs">
                    Verify Authenticity
                 </button>
                 <span className="text-[9px] text-center text-gray-400">DentaUAE utilizes direct API access to manufacturer safety registries.</span>
              </div>
           </div>
        </section>

      </div>
    </main>
  );
}
