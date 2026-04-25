"use client";

import Image from "next/image";
import { Star } from "lucide-react";

const TESTIMONIALS = [
  {
    name: "SARA AL-SAYED",
    role: "Verified Patient",
    quote: "Best place in UAE to get genuine dental products. The shipping was incredibly fast, arrived within 4 hours!",
    image: "https://lh3.googleusercontent.com/aida/ADBb0ui_fh04OXHJNgNxBF8yqvegrxXCs6v4CQmDevUZ60uh7CvpqZQGsNRkjz9SX-kGm3NV82WgGd1c28h1KfxH4KxXTeJIi6WCY4FsQnOkRrr5L-RPk71cRn9PgtnBCYtwihjDgTF9uoqdUzVuvpaM6aBYYHtUUtJZvvzG2CByADCLHApG7NcsHOy1ZI86l0j9dsVwk_U08kSUaH3MgRCd5clQWcvtWu16ydZ4o9FwQaSch7H9n5vUO8qkEX0"
  },
  {
    name: "DR. AHMED MEHREZ",
    role: "Clinical Director, Pearl Dental",
    quote: "Their customer service team is so helpful. They helped me pick the right water flosser for my braces. Excellent support.",
    image: "https://lh3.googleusercontent.com/aida/ADBb0ujMDuOwqHHRGNINQ4pttxZ_PLlKFK6cYrcTrx2PbNA0lKjBah_rZ-9k_BaQJxw6sqgZ0O-oacb3mhsH9Lh-W5DUQAzmaK9iurosuXKXW2P683HtHo8LPt_4cmnnNYP9IT5qCRXFVgGlSYu2CjxlUv3SZP1XsbyUMi0fs25GIuTsAs1yVhbs4DzQeHI9NAd7b1o_2rQKmaSl8FTWTyRorsjHH6RhvhwoPyVfYwzwf6wQ-3MHUJFp98dIBa0f"
  },
  {
    name: "EMA JAMES",
    role: "Premium Member",
    quote: "Luxury experience from browsing to unboxing. I highly recommend DentaUAE for anyone serious about their teeth.",
    image: "https://lh3.googleusercontent.com/aida/ADBb0ujhg6XcViiOJWfNFXFt5ZK8drfuYHWrTxxr8mmggNIPI09rya-gnHhaQGz_-K0IZ4pp6wb84V_NBcIh2g96fHzroIXWd3xCNhmD4kv9jU3eCJEwfFIFG1V0LCqlb5l3kDNK7PKdVpMcjW_Vvxe58gDmjrcp_gzbyCqN6J44VuumTRu1G041LBfWx30Sk3Za6K_-MGX5tvsYkcHzASBO6dVzE_aSLE_Plw2OQPq1NfyNLzGmITJhZl25H19G"
  }
];

export const Testimonials = () => {
  return (
    <section className="bg-[#FAF9F6] py-24 px-4 lg:px-8">
      <div className="max-w-7xl mx-auto flex flex-col gap-16">
        <div className="text-center flex flex-col gap-4">
          <h2 className="text-4xl lg:text-5xl font-serif text-primary-dark tracking-tight leading-[1.1]">
            Loved by <span className="italic font-medium text-primary">Our Community</span>
          </h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
          {TESTIMONIALS.map((t, index) => (
            <div key={index} className="bg-white p-10 rounded-[2.5rem] shadow-sm hover:shadow-xl transition-all duration-500 flex flex-col gap-8 group">
              <div className="flex gap-1 text-primary">
                {[...Array(5)].map((_, i) => (
                  <Star key={i} size={18} fill="currentColor" stroke="none" />
                ))}
              </div>
              
              <p className="text-lg text-gray-600 italic leading-relaxed font-sans flex-1">
                &ldquo;{t.quote}&rdquo;
              </p>

              <div className="flex items-center gap-4 pt-6 border-t border-gray-100">
                <div className="relative w-12 h-12 rounded-full overflow-hidden grayscale group-hover:grayscale-0 transition-all">
                  <Image src={t.image} alt={t.name} fill className="object-cover" />
                </div>
                <div>
                  <h4 className="text-primary-dark font-bold text-sm uppercase tracking-widest">{t.name}</h4>
                  <p className="text-gray-400 text-[10px] font-bold uppercase">{t.role}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Testimonials;
