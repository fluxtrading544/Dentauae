"use client";

import Link from "next/link";
import { Search, ShoppingBag, User, Menu, X } from "lucide-react";
import { useCartStore } from "@/lib/store";
import { useState, useEffect } from "react";

export const Navbar = () => {
  const [mounted, setMounted] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const cartCount = useCartStore((state) => state.getCartCount());

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setMounted(true);
  }, []);

  return (
    <header className="w-full flex flex-col fixed top-0 left-0 z-50 transition-all bg-white shadow-sm">
      {/* Announcement Bar */}
      <div className="w-full bg-primary py-2 text-center text-white text-xs font-medium tracking-wide">
        Free clinical shipping on orders over AED 99. Trusted by UAE Dentists.
      </div>
      
      {/* Main Navbar */}
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-4 flex items-center justify-between">
        {/* Mobile Menu */}
        <button onClick={() => setIsMobileMenuOpen(true)} className="lg:hidden p-1 text-primary-dark" aria-label="Open Menu">
          <Menu size={24} />
        </button>

        {/* Logo */}
        <Link href="/" className="flex items-center gap-2 group">
          <span className="text-2xl font-bold font-serif text-primary-dark tracking-tight">
            Denta<span className="text-accent italic">UAE</span>
          </span>
        </Link>

        {/* Desktop Navigation */}
        <nav className="hidden lg:flex items-center gap-8">
          {["Shop", "Brands", "Deals", "Blog", "For Clinics"].map((item) => {
            const href = item === "For Clinics" ? "/clinics" : `/${item.toLowerCase().replace(" ", "-")}`;
            return (
              <Link
                key={item}
                href={href}
                className="text-sm font-medium text-gray-700 hover:text-primary transition-colors tracking-wide"
              >
                {item}
              </Link>
            );
          })}
        </nav>

        {/* Actions */}
        <div className="flex items-center gap-5 text-primary-dark">
          <button className="p-1 hover:text-accent transition-colors" aria-label="Search Products">
            <Search size={20} />
          </button>
          <Link href="/account" className="p-1 hover:text-accent transition-colors" aria-label="User Account">
            <User size={20} />
          </Link>
          <Link href="/cart" className="p-1 hover:text-accent transition-colors relative group" aria-label={`Shopping Bag with ${cartCount} items`}>
            <ShoppingBag size={20} />
            {mounted && cartCount > 0 && (
              <span className="absolute -top-1.5 -right-1.5 bg-accent text-[10px] text-white w-4 h-4 rounded-full flex items-center justify-center border-2 border-white">
                {cartCount}
              </span>
            )}
          </Link>
        </div>
      </div>

      {/* Mobile Menu Drawer */}
      <div 
        className={`fixed inset-0 bg-black/50 z-50 transition-opacity duration-300 lg:hidden ${isMobileMenuOpen ? 'opacity-100' : 'opacity-0 pointer-events-none'}`} 
        onClick={() => setIsMobileMenuOpen(false)}
      >
        <div 
          className={`absolute top-0 left-0 w-[80%] max-w-sm h-full bg-white shadow-2xl transition-transform duration-300 flex flex-col ${isMobileMenuOpen ? 'translate-x-0' : '-translate-x-full'}`}
          onClick={(e) => e.stopPropagation()}
        >
          <div className="p-4 flex items-center justify-between border-b border-gray-100">
            <span className="text-2xl font-bold font-serif text-primary-dark tracking-tight">
              Denta<span className="text-accent italic">UAE</span>
            </span>
            <button onClick={() => setIsMobileMenuOpen(false)} className="p-2 text-gray-500 hover:text-primary rounded-full hover:bg-gray-100 transition-all">
              <X size={24} />
            </button>
          </div>
          <div className="flex flex-col py-4 overflow-y-auto flex-1">
            {["Home", "Shop", "Brands", "Deals", "Blog", "For Clinics"].map((item) => {
              const href = item === "Home" ? "/" : (item === "For Clinics" ? "/clinics" : `/${item.toLowerCase().replace(" ", "-")}`);
              return (
                <Link
                  key={item}
                  href={href}
                  onClick={() => setIsMobileMenuOpen(false)}
                  className="px-6 py-4 text-lg font-medium text-primary-dark border-b border-gray-50 hover:bg-surface-container-low hover:text-primary transition-colors"
                >
                  {item}
                </Link>
              );
            })}
          </div>
          <div className="p-6 border-t border-gray-100 bg-surface-container-low">
            <div className="flex items-center gap-4 text-primary-dark justify-center">
              <button className="p-2 hover:text-accent transition-colors">
                <Search size={22} />
              </button>
              <Link 
                href="/account" 
                onClick={() => setIsMobileMenuOpen(false)}
                className="p-2 hover:text-accent transition-colors"
              >
                <User size={22} />
              </Link>
            </div>
            <p className="text-center text-xs text-gray-500 mt-4">Free delivery on orders over AED 99</p>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Navbar;
