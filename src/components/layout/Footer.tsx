import Link from "next/link";
import { Mail, Globe } from "lucide-react";

export const Footer = () => {
  return (
    <footer className="w-full bg-surface-container-low pt-16 pb-8 border-t border-border-custom px-4 lg:px-8">
      <div className="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 lg:gap-8">
        {/* About column */}
        <div className="flex flex-col gap-6">
          <Link href="/" className="flex items-center gap-2 group">
            <span className="text-2xl font-bold font-serif text-primary-dark tracking-tight">
              Denta<span className="text-accent italic">UAE</span>
            </span>
          </Link>
          <p className="text-sm text-gray-600 leading-relaxed font-sans">
            Your premium destination for professional oral care in the UAE. Quality clinical products delivered to your doorstep.
          </p>
          <div className="flex items-center gap-4 mt-2">
            <a href="#" className="p-2 bg-white rounded-full text-primary hover:bg-primary hover:text-white transition-all shadow-sm">
              <Globe size={18} />
            </a>
            <a href="#" className="p-2 bg-white rounded-full text-primary hover:bg-primary hover:text-white transition-all shadow-sm">
              <Globe size={18} />
            </a>
            <a href="#" className="p-2 bg-white rounded-full text-primary hover:bg-primary hover:text-white transition-all shadow-sm">
              <Mail size={18} />
            </a>
          </div>
        </div>

        {/* Quick Links column */}
        <div className="flex flex-col gap-6">
          <h4 className="text-lg font-serif font-semibold text-primary-dark">Quick Links</h4>
          <nav className="flex flex-col gap-3">
            {["Home", "Shop All", "Best Sellers", "Our Clinics"].map((link) => (
              <Link key={link} href={`/${link.toLowerCase().replace(" ", "-")}`} className="text-sm text-gray-600 hover:text-primary transition-colors">
                {link}
              </Link>
            ))}
          </nav>
        </div>

        {/* Customer Service column */}
        <div className="flex flex-col gap-6">
          <h4 className="text-lg font-serif font-semibold text-primary-dark">Customer Service</h4>
          <nav className="flex flex-col gap-3">
            {["Contact Us", "Shipping & Returns", "Warranty Information", "FAQs"].map((link) => (
              <Link key={link} href={`/${link.toLowerCase().replace(" ", "-")}`} className="text-sm text-gray-600 hover:text-primary transition-colors">
                {link}
              </Link>
            ))}
          </nav>
        </div>

        {/* Newsletter column */}
        <div className="flex flex-col gap-6">
          <h4 className="text-lg font-serif font-semibold text-primary-dark">Newsletter</h4>
          <p className="text-sm text-gray-600 leading-relaxed">
            Subscribe for oral health tips and exclusive deals.
          </p>
          <form className="flex flex-col gap-3 mt-2">
            <input 
              type="email" 
              placeholder="Email address" 
              className="bg-white px-4 py-2.5 rounded-lg border border-border-custom focus:outline-none focus:ring-1 focus:ring-primary text-sm shadow-sm"
            />
            <button className="bg-primary hover:bg-primary-dark text-white px-4 py-2.5 rounded-lg text-sm font-semibold transition-all shadow-sm">
              Subscribe Now
            </button>
          </form>
        </div>
      </div>

      {/* Bottom Bar */}
      <div className="max-w-7xl mx-auto mt-16 pt-8 border-t border-border-custom flex flex-col md:flex-row items-center justify-between gap-4">
        <p className="text-xs text-gray-500 font-sans">
          © 2024 DentaUAE. All rights reserved. VAT Reg No. 100xxxxxxxxx
        </p>
        <div className="flex items-center gap-6">
          <Link href="/privacy" className="text-xs text-gray-500 hover:text-primary transition-colors">Privacy Policy</Link>
          <Link href="/terms" className="text-xs text-gray-500 hover:text-primary transition-colors">Terms of Sale</Link>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
