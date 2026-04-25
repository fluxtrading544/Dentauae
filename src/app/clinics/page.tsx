import Link from "next/link";
import { ArrowRight, MapPin } from "lucide-react";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Partner Clinics | DentaUAE",
  description: "Find an authorized DentaUAE partner clinic near you.",
};

export default function ClinicsPage() {
  return (
    <main className="bg-surface min-h-screen pt-32 pb-24">
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 flex flex-col gap-16">
        
        <div className="flex flex-col gap-6 text-center max-w-3xl mx-auto">
          <div className="flex items-center justify-center gap-2 text-primary font-semibold tracking-widest uppercase text-xs">
            <span className="w-8 h-[1px] bg-primary"></span>
            Professional Network
            <span className="w-8 h-[1px] bg-primary"></span>
          </div>
          <h1 className="text-4xl lg:text-5xl font-serif text-primary-dark tracking-tight">Our Clinics</h1>
          <p className="text-gray-500 leading-relaxed text-lg">
            Experience our premium oral care products firsthand through our network of elite dental partners across the UAE.
          </p>
        </div>

        <div className="bg-white rounded-3xl p-12 lg:p-24 border border-gray-100 shadow-sm text-center flex flex-col items-center justify-center gap-8 min-h-[40vh]">
          <div className="w-16 h-16 bg-primary-light rounded-full flex items-center justify-center text-primary">
            <MapPin size={24} />
          </div>
          <div className="flex flex-col gap-4">
            <h2 className="text-2xl font-serif font-bold text-primary-dark">Clinic Locator Loading</h2>
            <p className="text-gray-500 max-w-md mx-auto">
              We are finalizing the integration with our Maps provider. Soon, you will be able to book consultations and pick up products directly from your nearest certified provider.
            </p>
          </div>
          <Link href="/" className="text-primary font-semibold hover:underline flex items-center gap-2 mt-4">
            <ArrowRight size={18} className="rotate-180" /> Return Home
          </Link>
        </div>

      </div>
    </main>
  );
}
