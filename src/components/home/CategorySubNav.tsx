"use client";

import Link from "next/link";
import { Zap, Sparkles, Sun, Droplets, Activity, Baby } from "lucide-react";

const CATEGORIES = [
  { name: "Electric Brushes", icon: Zap, href: "/shop?category=electric-toothbrushes" },
  { name: "Toothpaste", icon: Sparkles, href: "/shop?category=toothpaste" },
  { name: "Whitening", icon: Sun, href: "/shop?category=whitening" },
  { name: "Mouthwash", icon: Droplets, href: "/shop?category=mouthwash" },
  { name: "Floss & Picks", icon: Activity, href: "/shop?category=floss" },
  { name: "Kids Dental", icon: Baby, href: "/shop?category=kids-dental" },
];

export const CategorySubNav = () => {
  return (
    <nav className="w-full bg-[#f8f9f8] border-b border-primary/5 py-3"> {/* Layout provides the Navbar offset */}
      <div className="max-w-7xl mx-auto px-4 lg:px-8">
        <div className="flex flex-wrap items-center justify-center gap-x-8 gap-y-4 md:gap-x-12">
          {CATEGORIES.map((cat) => (
            <Link
              key={cat.name}
              href={cat.href}
              className="flex items-center gap-2 text-primary-dark group transition-all"
            >
              <div className="p-1.5 rounded-full bg-white shadow-sm ring-1 ring-primary/5 group-hover:scale-110 group-hover:text-primary transition-all">
                <cat.icon size={16} />
              </div>
              <span className="text-[13px] font-semibold tracking-wide group-hover:text-primary transition-colors">
                {cat.name}
              </span>
            </Link>
          ))}
        </div>
      </div>
    </nav>
  );
};

export default CategorySubNav;
