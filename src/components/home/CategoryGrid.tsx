"use client";

import Image from "next/image";
import Link from "next/link";
import { ArrowRight } from "lucide-react";

const CATEGORIES = [
  { name: "Electric Brushes", image: "https://lh3.googleusercontent.com/aida/ADBb0ujhg6XcViiOJWfNFXFt5ZK8drfuYHWrTxxr8mmggNIPI09rya-gnHhaQGz_-K0IZ4pp6wb84V_NBcIh2g96fHzroIXWd3xCNhmD4kv9jU3eCJEwfFIFG1V0LCqlb5l3kDNK7PKdVpMcjW_Vvxe58gDmjrcp_gzbyCqN6J44VuumTRu1G041LBfWx30Sk3Za6K_-MGX5tvsYkcHzASBO6dVzE_aSLE_Plw2OQPq1NfyNLzGmITJhZl25H19G", href: "/shop?category=electric-toothbrushes" },
  { name: "Toothpaste", image: "https://lh3.googleusercontent.com/aida/ADBb0ui_fh04OXHJNgNxBF8yqvegrxXCs6v4CQmDevUZ60uh7CvpqZQGsNRkjz9SX-kGm3NV82WgGd1c28h1KfxH4KxXTeJIi6WCY4FsQnOkRrr5L-RPk71cRn9PgtnBCYtwihjDgTF9uoqdUzVuvpaM6aBYYHtUUtJZvvzG2CByADCLHApG7NcsHOy1ZI86l0j9dsVwk_U08kSUaH3MgRCd5clQWcvtWu16ydZ4o9FwQaSch7H9n5vUO8qkEX0", href: "/shop?category=toothpaste" },
  { name: "Whitening", image: "https://lh3.googleusercontent.com/aida/ADBb0uiO1YBucLmarun_pz2cn_BBsZMvwn2QYI6khYZ-WARGN6VfuHjH7Sp5Z7kcr3BVis8qyF_JKxLzmg7MBsx5WN6eAgn4PnX9Vivi448i72aRfMNE1uCMqCa7YHke6oDsObX_XHJWxuFmHy5rb9M95nISZeM8ZeXWQM3UYqN1ZKZg2moYCpvsm2Rhe_jotULS-8EWTMtmk5-svGvk8yr4aw0sHf6HcTr2-dqTy2qwmQc-j1zgfbg5YSE3vfFN", href: "/shop?category=whitening" },
  { name: "Mouthwash", image: "https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb", href: "/shop?category=mouthwash" },
  { name: "Floss & Picks", image: "https://lh3.googleusercontent.com/aida/ADBb0ui_fh04OXHJNgNxBF8yqvegrxXCs6v4CQmDevUZ60uh7CvpqZQGsNRkjz9SX-kGm3NV82WgGd1c28h1KfxH4KxXTeJIi6WCY4FsQnOkRrr5L-RPk71cRn9PgtnBCYtwihjDgTF9uoqdUzVuvpaM6aBYYHtUUtJZvvzG2CByADCLHApG7NcsHOy1ZI86l0j9dsVwk_U08kSUaH3MgRCd5clQWcvtWu16ydZ4o9FwQaSch7H9n5vUO8qkEX0", href: "/shop?category=floss" },
  { name: "Kids Dental", image: "https://lh3.googleusercontent.com/aida/ADBb0ujhg6XcViiOJWfNFXFt5ZK8drfuYHWrTxxr8mmggNIPI09rya-gnHhaQGz_-K0IZ4pp6wb84V_NBcIh2g96fHzroIXWd3xCNhmD4kv9jU3eCJEwfFIFG1V0LCqlb5l3kDNK7PKdVpMcjW_Vvxe58gDmjrcp_gzbyCqN6J44VuumTRu1G041LBfWx30Sk3Za6K_-MGX5tvsYkcHzASBO6dVzE_aSLE_Plw2OQPq1NfyNLzGmITJhZl25H19G", href: "/shop?category=kids-dental" },
  { name: "Water Flossers", image: "https://lh3.googleusercontent.com/aida/ADBb0ujMDuOwqHHRGNINQ4pttxZ_PLlKFK6cYrcTrx2PbNA0lKjBah_rZ-9k_BaQJxw6sqgZ0O-oacb3mhsH9Lh-W5DUQAzmaK9iurosuXKXW2P683HtHo8LPt_4cmnnNYP9IT5qCRXFVgGlSYu2CjxlUv3SZP1XsbyUMi0fs25GIuTsAs1yVhbs4DzQeHI9NAd7b1o_2rQKmaSl8FTWTyRorsjHH6RhvhwoPyVfYwzwf6wQ-3MHUJFp98dIBa0f", href: "/shop?category=water-flossers" },
  { name: "Accessories", image: "https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb", href: "/shop?category=accessories" },
];

export const CategoryGrid = () => {
  return (
    <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-24">
      <div className="flex flex-col gap-12">
        <div className="flex items-end justify-between border-b border-gray-100 pb-8">
          <div className="flex flex-col gap-4">
            <h2 className="text-4xl lg:text-5xl font-serif text-primary-dark tracking-tight">Shop by Category</h2>
            <p className="text-gray-500 max-w-lg text-lg italic">Tailored solutions for every aspect of your oral wellness journey.</p>
          </div>
          <Link href="/shop" className="text-primary-dark font-bold flex items-center gap-2 hover:gap-4 transition-all pb-2 border-b-2 border-primary/10 hover:border-primary">
            Explore All <ArrowRight size={20} />
          </Link>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-6 lg:gap-8">
          {CATEGORIES.map((cat) => (
            <Link 
              key={cat.name} 
              href={cat.href}
              className="group relative h-[300px] lg:h-[400px] rounded-3xl overflow-hidden shadow-sm hover:shadow-2xl transition-all duration-500"
            >
              <Image 
                src={cat.image}
                alt={cat.name}
                fill
                className="object-cover group-hover:scale-110 transition-transform duration-1000"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-primary-dark/80 via-primary-dark/20 to-transparent"></div>
              <div className="absolute bottom-6 left-6 right-6">
                <h3 className="text-white text-xl lg:text-2xl font-serif font-bold group-hover:translate-x-2 transition-transform">{cat.name}</h3>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
};

export default CategoryGrid;
