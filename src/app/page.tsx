import Image from "next/image";
import Link from "next/link";
import { ArrowRight, ShieldCheck, Zap, CreditCard } from "lucide-react";
import { BRANDS } from "@/lib/mock-data";
import { ProductCard } from "@/components/products/ProductCard";
import { getProductsList, getHomeContent } from "@/lib/data/products";
import { CategorySubNav } from "@/components/home/CategorySubNav";
import { HeroProductCard } from "@/components/home/HeroProductCard";
import { CategoryGrid } from "@/components/home/CategoryGrid";
import { FlashSaleBanner } from "@/components/home/FlashSaleBanner";
import { BrandFeature } from "@/components/home/BrandFeature";
import { Testimonials } from "@/components/home/Testimonials";
import { BlogHighlight } from "@/components/home/BlogHighlight";
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "DentaUAE | Premium Dental Care & Clinical Technology",
  description: "Experience the gold standard of oral hygiene in the UAE. Curated professional dental solutions direct from global brands like Oral-B, Philips, and more.",
  keywords: ["dental care", "UAE", "electric toothbrush", "Oral-B", "Philips Sonicare", "clinical dental care"],
};

export default async function Home() {
  const [{ response }, homeContent] = await Promise.all([
    getProductsList({ limit: 4 }),
    getHomeContent()
  ]);

  const bestSellers = response.products;
  
  // Content from Collection or Region Fallback
  const { title: heroTitle, subtitle: heroSubtitle, image: heroImage, products: heroProducts } = homeContent;

  // Map Hero Products (Take first two from collection)
  const io9 = heroProducts[0];
  const sonicare = heroProducts[1];

  return (
    <div className="flex flex-col pb-24">
      {/* 1. Category Sub-Nav (Tight to Navbar) */}
      <CategorySubNav />

      {/* 2. Hero Section */}
      <section className="relative min-h-fit flex items-start pt-6 lg:pt-8 px-4 lg:px-8 overflow-hidden bg-[#FAFAF8] pb-20 border-b border-gray-100">
        <div className="absolute top-24 left-1/2 -translate-x-1/2 w-[800px] h-[800px] bg-primary-light/30 rounded-full blur-[120px] -z-10"></div>
        <div className="max-w-7xl mx-auto w-full grid grid-cols-1 lg:grid-cols-2 gap-20 items-start z-10 pt-4">
          <div className="flex flex-col gap-10">
            <div className="flex items-center gap-3">
              <span className="px-3 py-1 bg-primary-light text-primary-dark font-bold text-[10px] uppercase tracking-widest rounded-full">
                Premium Dental Care
              </span>
            </div>
            <h1 className="text-6xl lg:text-[5.5rem] font-serif text-primary-dark leading-[0.95] tracking-tight" dangerouslySetInnerHTML={{ __html: heroTitle?.replace("\n", "<br />") }}>
            </h1>
            <p className="text-xl text-gray-600 max-w-lg leading-relaxed font-sans">
              {heroSubtitle}
            </p>
            <div className="flex flex-wrap items-center gap-6 pt-4">
              <Link href="/shop" className="bg-primary hover:bg-primary-dark text-white px-10 py-5 rounded-2xl font-bold transition-all shadow-xl shadow-primary/20 flex items-center gap-3 text-lg group">
                Shop Collections <ArrowRight size={20} className="group-hover:translate-x-1 transition-transform" />
              </Link>
              <Link href="/brands" className="bg-white hover:bg-gray-50 text-primary-dark px-10 py-5 rounded-2xl font-bold transition-all border border-gray-100 shadow-sm text-lg">
                View All Brands
              </Link>
            </div>
          </div>
          <div className="relative h-[700px] hidden lg:flex items-center justify-center">
            <div className="relative w-full h-[600px] rounded-[3rem] bg-gradient-to-br from-primary-light/50 to-primary/10 overflow-hidden shadow-2xl">
              <Image 
                src={heroImage}
                alt="DentaUAE Premium Care"
                fill
                className="object-cover opacity-90 scale-105 hover:scale-100 transition-transform duration-1000"
                priority
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent"></div>
            </div>
            <HeroProductCard 
              name={io9?.name || "Oral-B iO 9"}
              subtext={io9?.brand || "Intelligent AI Pressure Control"}
              price={io9 ? `AED ${io9.price.toLocaleString()}` : "AED 1,499"}
              image={io9?.image || "https://lh3.googleusercontent.com/aida/ADBb0ujMDuOwqHHRGNINQ4pttxZ_PLlKFK6cYrcTrx2PbNA0lKjBah_rZ-9k_BaQJxw6sqgZ0O-oacb3mhsH9Lh-W5DUQAzmaK9iurosuXKXW2P683HtHo8LPt_4cmnnNYP9IT5qCRXFVgGlSYu2CjxlUv3SZP1XsbyUMi0fs25GIuTsAs1yVhbs4DzQeHI9NAd7b1o_2rQKmaSl8FTWTyRorsjHH6RhvhwoPyVfYwzwf6wQ-3MHUJFp98dIBa0f"}
              className="absolute -right-8 top-12 z-20 scale-110 shadow-2xl"
            />
            <HeroProductCard 
              name={sonicare?.name || "Sonicare 9900"}
              subtext={sonicare?.brand || "SenseIQ Technology"}
              price={sonicare ? `AED ${sonicare.price.toLocaleString()}` : "AED 1,349"}
              image={sonicare?.image || "https://lh3.googleusercontent.com/aida/ADBb0ujhg6XcViiOJWfNFXFt5ZK8drfuYHWrTxxr8mmggNIPI09rya-gnHhaQGz_-K0IZ4pp6wb84V_NBcIh2g96fHzroIXWd3xCNhmD4kv9jU3eCJEwfFIFG1V0LCqlb5l3kDNK7PKdVpMcjW_Vvxe58gDmjrcp_gzbyCqN6J44VuumTRu1G041LBfWx30Sk3Za6K_-MGX5tvsYkcHzASBO6dVzE_aSLE_Plw2OQPq1NfyNLzGmITJhZl25H19G"}
              className="absolute -left-12 bottom-20 z-20 shadow-2xl"
            />
          </div>
        </div>
      </section>

      {/* 3. Brands Bar */}
      <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 mt-12 mb-12">
        <div className="flex flex-col gap-10 text-center">
          <p className="text-xs font-bold uppercase tracking-[0.3em] text-primary/40">The Clinical Network</p>
          <div className="flex flex-wrap items-center justify-center gap-12 lg:gap-24 opacity-40 grayscale hover:opacity-100 hover:grayscale-0 transition-all duration-700">
            {BRANDS.map(brand => (
              <span key={brand} className="text-xl font-serif font-bold text-primary-dark">{brand}</span>
            ))}
          </div>
        </div>
      </section>

      {/* 4. Shop by Category Grid */}
      <CategoryGrid />

      {/* 5. Bestselling Essentials */}
      <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 flex flex-col gap-16 py-24">
        <div className="flex items-end justify-between border-b border-primary/5 pb-8">
          <div className="flex flex-col gap-4">
            <h2 className="text-5xl font-serif text-primary-dark tracking-tight">Bestselling Essentials</h2>
            <p className="text-gray-500 max-w-sm text-lg italic">The most recommended products by our partner clinics this month.</p>
          </div>
          <Link href="/shop" className="text-primary-dark font-bold flex items-center gap-2 hover:gap-4 transition-all pb-2 border-b-2 border-primary/10 hover:border-primary">
            Explore All Collection <ArrowRight size={20} />
          </Link>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-10">
          {bestSellers.map((product) => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>
      </section>

      {/* 6. Flash Sale Banner */}
      <FlashSaleBanner />

      {/* 7. Brand Feature: Oral-B iO */}
      <BrandFeature 
        title="The Oral-B iO Collection"
        description="Experience a professional clean feeling every day. The iO series combines Oral-B's iconic round brush head with the gentle energy of micro-vibrations."
        badge="CLINICAL FOCUS"
        features={[
          "Revolutionary Magnetic iO Drive",
          "Interactive Color Display",
          "3D Teeth Tracking with AI"
        ]}
        image="https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb"
        ctaText="Discover Oral-B"
        ctaLink="/shop?brand=Oral-B"
        imagePosition="left"
      />

      {/* 8. Brand Feature: Sonicare Prestige */}
      <BrandFeature 
        title="Sonicare Prestige 9900"
        description="Our most advanced electric toothbrush yet. It senses your brushing style and adapts in real time with SenseIQ technology for personalized care."
        badge="INNOVATION HIGHLIGHT"
        features={[
          "Senses Brushing Pressure and Motion",
          "Adapts Intensity Automatically",
          "Personalized Brushing Guidance via App"
        ]}
        image="https://lh3.googleusercontent.com/aida/ADBb0ui_fh04OXHJNgNxBF8yqvegrxXCs6v4CQmDevUZ60uh7CvpqZQGsNRkjz9SX-kGm3NV82WgGd1c28h1KfxH4KxXTeJIi6WCY4FsQnOkRrr5L-RPk71cRn9PgtnBCYtwihjDgTF9uoqdUzVuvpaM6aBYYHtUUtJZvvzG2CByADCLHApG7NcsHOy1ZI86l0j9dsVwk_U08kSUaH3MgRCd5clQWcvtWu16ydZ4o9FwQaSch7H9n5vUO8qkEX0"
        ctaText="Discover Sonicare"
        ctaLink="/shop?brand=Philips+Sonicare"
        imagePosition="right"
      />

      {/* 9. Trust Badges (4 Column) */}
      <section className="bg-primary-dark py-24 px-4 lg:px-8 relative overflow-hidden">
        <div className="absolute top-0 right-0 w-96 h-96 bg-primary/10 rounded-full blur-[100px]"></div>
        <div className="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-16 text-white relative z-10">
          <div className="flex flex-col items-center text-center gap-6">
            <div className="p-5 bg-white/10 rounded-2xl backdrop-blur-sm border border-white/10">
              <ShieldCheck size={36} className="text-primary-mid" />
            </div>
            <h4 className="text-2xl font-serif font-semibold">100% Authentic</h4>
            <p className="text-base text-white/50 leading-relaxed font-sans max-w-[280px]">Directly sourced from global brands and official distributors.</p>
          </div>
          <div className="flex flex-col items-center text-center gap-6">
            <div className="p-5 bg-white/10 rounded-2xl backdrop-blur-sm border border-white/10">
              <Zap size={36} className="text-primary-mid" />
            </div>
            <h4 className="text-2xl font-serif font-semibold">Same-Day Delivery</h4>
            <p className="text-base text-white/50 leading-relaxed font-sans max-w-[280px]">Express shipping available across Dubai, Abu Dhabi & the wider UAE.</p>
          </div>
          <div className="flex flex-col items-center text-center gap-6">
            <div className="p-5 bg-white/10 rounded-2xl backdrop-blur-sm border border-white/10">
              <ShieldCheck size={36} className="text-primary-mid" />
            </div>
            <h4 className="text-2xl font-serif font-semibold">DDS Approved</h4>
            <p className="text-base text-white/50 leading-relaxed font-sans max-w-[280px]">All products curated and vetted by leading dental professionals.</p>
          </div>
          <div className="flex flex-col items-center text-center gap-6">
            <div className="p-5 bg-white/10 rounded-2xl backdrop-blur-sm border border-white/10">
              <CreditCard size={36} className="text-primary-mid" />
            </div>
            <h4 className="text-2xl font-serif font-semibold">Flexible Payments</h4>
            <p className="text-base text-white/50 leading-relaxed font-sans max-w-[280px]">Buy now, pay later with Tabby and Tamara available at checkout.</p>
          </div>
        </div>
      </section>

      {/* 10. Testimonials */}
      <Testimonials />

      {/* 11. BlogHighlight */}
      <BlogHighlight />
    </div>
  );
}
