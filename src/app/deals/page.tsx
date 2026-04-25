import { ArrowRight, Tag, ChevronLeft, ChevronRight } from "lucide-react";
import Link from "next/link";
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "Deals & Special Offers | DentaUAE",
  description: "Exclusive curated savings on clinical-grade oral hygiene technology. Professional dental care bundles for the modern patient.",
};

export default function DealsPage() {
  return (
    <main className="min-h-screen bg-white">
      {/* 1. Hero Section: Dark Teal Minimalist */}
      <section className="bg-[#004736] pt-40 pb-24 px-4 lg:px-12 relative overflow-hidden">
        <div className="max-w-7xl mx-auto flex flex-col lg:flex-row items-center justify-between gap-16">
          <div className="flex flex-col gap-8 max-w-xl">
             <div className="inline-flex items-center px-4 py-1.5 bg-[#BA7517] text-white text-[10px] font-bold uppercase tracking-widest rounded-full w-fit">
                Limited Time Only
             </div>
             <h1 className="text-5xl lg:text-8xl font-serif text-white leading-[1.1] tracking-tight">
                Exclusive <br /> Dental <br /> Deals
             </h1>
             <p className="text-white/70 text-lg leading-relaxed max-w-lg">
                Elevate your oral care routine with clinical-grade equipment at atelier prices. Discover curated savings for your smile.
             </p>
             
             {/* Countdown Timer */}
             <div className="flex items-center gap-8 pt-8">
                <div className="flex flex-col items-center gap-1">
                   <span className="text-4xl lg:text-6xl font-serif text-white">12</span>
                   <span className="text-[10px] text-white/50 font-bold uppercase tracking-widest">Hours</span>
                </div>
                <span className="text-3xl text-white/30 font-serif">:</span>
                <div className="flex flex-col items-center gap-1">
                   <span className="text-4xl lg:text-6xl font-serif text-white">48</span>
                   <span className="text-[10px] text-white/50 font-bold uppercase tracking-widest">Minutes</span>
                </div>
                <span className="text-3xl text-white/30 font-serif">:</span>
                <div className="flex flex-col items-center gap-1">
                   <span className="text-4xl lg:text-6xl font-serif text-white">15</span>
                   <span className="text-[10px] text-white/50 font-bold uppercase tracking-widest">Seconds</span>
                </div>
             </div>
          </div>

          <div className="relative w-full lg:w-[600px] h-[400px] lg:h-[600px] rounded-[2rem] overflow-hidden shadow-2xl">
             {/* Placeholder for Hero Image */}
             <div className="absolute inset-0 bg-[#00382b] flex items-center justify-center p-8">
                 <div className="relative w-full h-full border border-white/10 rounded-2xl overflow-hidden">
                    <div className="absolute inset-0 bg-gradient-to-tr from-black/40 to-transparent"></div>
                    <div className="absolute bottom-8 left-8 text-white font-serif text-2xl italic opacity-50">Studio Still _04</div>
                 </div>
             </div>
          </div>
        </div>
      </section>

      {/* 2. Tab Navigation */}
      <nav className="border-b border-gray-100 sticky top-0 bg-white/80 backdrop-blur-md z-40">
        <div className="max-w-7xl mx-auto px-4 lg:px-12 flex items-center gap-12 overflow-x-auto h-20">
           {["Flash Sale", "Bundle Deals", "Clearance", "New Arrivals"].map((tab, idx) => (
             <button 
               key={tab} 
               className={`h-full text-[11px] font-bold uppercase tracking-widest transition-all px-2 border-b-2 whitespace-nowrap ${idx === 0 ? "border-primary text-primary" : "border-transparent text-gray-400 hover:text-gray-600"}`}
             >
               {tab}
             </button>
           ))}
        </div>
      </nav>

      {/* 3. Signature Bundles Section */}
      <section className="py-24 px-4 lg:px-12">
        <div className="max-w-7xl mx-auto flex flex-col gap-12">
           <div className="flex items-center justify-between">
              <h2 className="text-3xl font-serif text-primary-dark">Signature Bundles</h2>
              <Link href="/shop" className="text-[10px] font-bold text-gray-400 uppercase tracking-widest hover:text-primary transition-colors">
                 View All Curated Sets
              </Link>
           </div>
           
           <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
              {[
                { 
                  title: "The Complete Clean", 
                  desc: "A holistic clinical ritual featuring our Sonic Pro, Charcoal Floss, and Hydro-Paste.", 
                  price: "779.00", 
                  oldPrice: "1050.00", 
                  badge: "SAVE AED 150" 
                },
                { 
                  title: "Luminous Glow Kit", 
                  desc: "Professional grade whitening technology designed for sensitive enamels. 14-day supply.", 
                  price: "950.00", 
                  oldPrice: "1250.00", 
                  badge: "SAVE AED 200" 
                }
              ].map((bundle, idx) => (
                <div key={idx} className="bg-[#FAF9F7] rounded-[2.5rem] p-4 flex flex-col sm:flex-row gap-8 hover:shadow-xl hover:shadow-primary/5 transition-all group border border-transparent hover:border-primary/10">
                   <div className="w-full sm:w-64 h-64 bg-white rounded-3xl overflow-hidden relative p-8 flex items-center justify-center">
                       <span className="text-primary/10 font-serif text-lg italic uppercase">{bundle.title.split(' ')[0]}</span>
                   </div>
                   <div className="flex-1 py-8 flex flex-col justify-between gap-6 pr-8">
                      <div className="flex flex-col gap-4">
                         <span className="bg-[#5D4037] text-white px-3 py-1 rounded text-[8px] font-bold uppercase tracking-tighter w-fit">{bundle.badge}</span>
                         <h3 className="text-2xl font-serif text-primary-dark">{bundle.title}</h3>
                         <p className="text-sm text-gray-500 leading-relaxed font-light">{bundle.desc}</p>
                      </div>
                      <div className="flex items-center justify-between">
                         <div className="flex flex-col">
                            <span className="text-[10px] text-gray-400 line-through uppercase tracking-widest">AED {bundle.oldPrice}</span>
                            <span className="text-2xl font-serif text-primary-dark">AED {bundle.price}</span>
                         </div>
                         <button className="bg-primary-dark text-white px-6 py-3 rounded-xl text-[10px] font-bold uppercase tracking-widest hover:bg-primary transition-all">
                            Add to Bag
                         </button>
                      </div>
                   </div>
                </div>
              ))}
           </div>
        </div>
      </section>

      {/* 4. Promo Banner */}
      <section className="px-4 lg:px-12 pb-24">
        <div className="max-w-7xl mx-auto bg-[#F9F7F4] rounded-[2rem] p-8 lg:p-12 flex flex-col md:flex-row items-center justify-between gap-8 border border-gray-100">
           <div className="flex items-center gap-6">
              <div className="w-12 h-12 bg-white rounded-full flex items-center justify-center text-primary shadow-sm">
                 <Tag size={20} />
              </div>
              <p className="text-primary-dark/80 font-medium">
                 Experience excellence. Use code <span className="font-bold text-primary-dark">SMILE10</span> for an extra 10% off your first order.
              </p>
           </div>
           <button className="bg-[#5D4037] text-white px-10 py-4 rounded-xl font-bold text-[10px] uppercase tracking-widest hover:bg-[#4A322C] transition-all shadow-lg shadow-brown-900/10">
              Copy Code
           </button>
        </div>
      </section>

      {/* 5. Curated Offers Section */}
      <section className="py-24 px-4 lg:px-12 bg-white">
         <div className="max-w-7xl mx-auto flex flex-col gap-12">
            <h2 className="text-3xl font-serif text-primary-dark">Curated Offers</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
               {[
                 { brand: "DentaElite", title: "Signature Bamboo Brush", price: "45.00", oldPrice: "65.00" },
                 { brand: "Silk & Care", title: "Essential Silk Floss", price: "32.00", oldPrice: "49.00" },
                 { brand: "Botanical Oral", title: "Herbal Tonic Rinse", price: "89.00", oldPrice: "120.00" },
                 { brand: "DentaBright", title: "7-Day Express Strips", price: "140.00", oldPrice: "210.00" }
               ].map((item, idx) => (
                 <div key={idx} className="group flex flex-col gap-6">
                    <div className="relative aspect-square bg-[#FAF9F7] rounded-[2rem] overflow-hidden p-12 flex items-center justify-center">
                       <div className="absolute top-4 left-4 bg-primary text-white text-[8px] font-bold px-2 py-1 rounded">SALE</div>
                       <span className="text-primary-dark/10 font-serif text-4xl">{idx + 1}</span>
                    </div>
                    <div className="flex flex-col gap-2">
                       <span className="text-[10px] font-bold text-gray-400 uppercase tracking-widest">{item.brand}</span>
                       <h4 className="text-lg font-serif text-primary-dark group-hover:text-primary transition-colors">{item.title}</h4>
                       <div className="flex items-center gap-3">
                          <span className="text-sm font-bold text-primary-dark">AED {item.price}</span>
                          <span className="text-xs text-gray-400 line-through">AED {item.oldPrice}</span>
                       </div>
                    </div>
                 </div>
               ))}
            </div>
         </div>
      </section>

      {/* 6. The Brand Atelier */}
      <section className="py-32 px-4 lg:px-12 bg-white flex flex-col gap-16 border-t border-gray-100">
         <div className="max-w-7xl mx-auto w-full flex flex-col gap-12">
            <div className="flex items-end justify-between">
               <div className="flex flex-col gap-4">
                  <h2 className="text-4xl font-serif text-primary-dark">The Brand Atelier</h2>
                  <p className="text-gray-400 text-sm italic">Exceptional value on world-renowned clinical partners.</p>
               </div>
               <div className="flex gap-4">
                  <button className="w-12 h-12 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:border-primary hover:text-primary transition-all">
                     <ChevronLeft size={20} />
                  </button>
                  <button className="w-12 h-12 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:border-primary hover:text-primary transition-all">
                     <ChevronRight size={20} />
                  </button>
               </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
               {[
                 { brand: "Oral-B", offer: "Up to 25% Off Professional Series", bg: "bg-[#0A4839]" },
                 { brand: "Philips Sonicare", offer: "Exclusive Member Pricing", bg: "bg-[#1E5F4F]" },
                 { brand: "Curaprox", offer: "3 for 2 on Ultra Soft Range", bg: "bg-[#033429]" }
               ].map((partner, idx) => (
                 <div key={idx} className={`${partner.bg} rounded-[2.5rem] p-12 h-[450px] flex flex-col justify-between text-white relative group overflow-hidden`}>
                    <div className="absolute inset-0 bg-white/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                    <div className="flex flex-col gap-4 relative z-10">
                       <h3 className="text-4xl font-serif">{partner.brand}</h3>
                       <p className="text-white/60 text-sm uppercase tracking-widest font-bold">{partner.offer}</p>
                    </div>
                    <Link href="/shop" className="flex items-center gap-3 text-white font-bold text-[10px] uppercase tracking-widest relative z-10 group-hover:gap-5 transition-all">
                       Explore Deals <ArrowRight size={14} />
                    </Link>
                 </div>
               ))}
            </div>
         </div>
      </section>

    </main>
  );
}
