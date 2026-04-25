"use client";

import { Search, ChevronDown, Check, Star } from "lucide-react";
import { BRANDS } from "@/lib/mock-data";

interface SidebarProps {
  filters: {
    search: string;
    brands: string[];
    priceRange: [number, number];
    rating: number;
    plans: string[];
  };
  setFilters: (filters: SidebarProps['filters']) => void;
  brandCounts: Record<string, number>;
}

export const ShopSidebar = ({ filters, setFilters, brandCounts }: SidebarProps) => {
  const toggleBrand = (brand: string) => {
    const newBrands = filters.brands.includes(brand)
      ? filters.brands.filter(b => b !== brand)
      : [...filters.brands, brand];
    setFilters({ ...filters, brands: newBrands });
  };

  const togglePlan = (plan: string) => {
    const newPlans = filters.plans.includes(plan)
      ? filters.plans.filter(p => p !== plan)
      : [...filters.plans, plan];
    setFilters({ ...filters, plans: newPlans });
  };

  return (
    <aside className="w-full flex flex-col gap-10">
      {/* Search */}
      <div className="flex flex-col gap-4">
        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-widest">Search Products</h3>
        <div className="relative">
          <input 
            type="text" 
            placeholder="Model, feature..."
            value={filters.search}
            onChange={(e) => setFilters({ ...filters, search: e.target.value })}
            className="w-full bg-[#F5F5F3] border-none rounded-xl py-4 pl-12 pr-4 text-sm focus:ring-2 focus:ring-primary/20 transition-all font-medium"
          />
          <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400" />
        </div>
      </div>

      {/* Sort By */}
      <div className="flex flex-col gap-4">
        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-widest">Sort By</h3>
        <div className="relative group">
          <select className="w-full bg-white border border-gray-100 rounded-xl py-4 px-4 text-sm appearance-none focus:ring-2 focus:ring-primary/10 font-bold text-primary-dark cursor-pointer shadow-sm">
            <option>Featured Products</option>
            <option>Price: Low to High</option>
            <option>Price: High to Low</option>
            <option>Newest Arrivals</option>
          </select>
          <ChevronDown size={18} className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none group-hover:text-primary transition-colors" />
        </div>
      </div>

      {/* Price Range */}
      <div className="flex flex-col gap-4">
        <div className="flex items-center justify-between">
          <h3 className="text-xs font-bold text-gray-400 uppercase tracking-widest">Price Range</h3>
          <span className="text-xs font-bold text-accent">AED {filters.priceRange[0]} - {filters.priceRange[1]}</span>
        </div>
        <div className="relative h-1.5 w-full bg-gray-100 rounded-full mt-4">
          <div className="absolute left-0 right-0 h-full bg-primary/20 rounded-full"></div>
          <div className="absolute left-0 top-1/2 -translate-y-1/2 w-4 h-4 bg-white border-4 border-primary rounded-full shadow-md cursor-pointer"></div>
          <div className="absolute right-0 top-1/2 -translate-y-1/2 w-4 h-4 bg-white border-4 border-primary rounded-full shadow-md cursor-pointer"></div>
        </div>
      </div>

      {/* Brand */}
      <div className="flex flex-col gap-4">
        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-widest">Brand</h3>
        <div className="flex flex-col gap-3">
          {BRANDS.map(brand => (
            <label key={brand} className="flex items-center justify-between group cursor-pointer">
              <div className="flex items-center gap-3">
                <div className={`w-5 h-5 rounded border-2 flex items-center justify-center transition-all ${
                  filters.brands.includes(brand) ? "bg-primary border-primary text-white" : "border-gray-200 group-hover:border-primary/50"
                }`}>
                  {filters.brands.includes(brand) && <Check size={14} strokeWidth={3} />}
                </div>
                <span className={`text-sm font-medium transition-colors ${filters.brands.includes(brand) ? "text-primary-dark" : "text-gray-500 group-hover:text-primary-dark"}`}>
                  {brand}
                </span>
              </div>
              <span className="text-[10px] bg-gray-100 text-gray-400 font-bold px-2 py-0.5 rounded-full group-hover:bg-primary/10 group-hover:text-primary transition-colors">
                {brandCounts[brand] || 0}
              </span>
              <input type="checkbox" className="hidden" onChange={() => toggleBrand(brand)} checked={filters.brands.includes(brand)} />
            </label>
          ))}
        </div>
      </div>

      {/* Interest-Free Plans */}
      <div className="bg-[#FAF9F6] p-6 rounded-3xl flex flex-col gap-6">
        <h3 className="text-xs font-bold text-primary-dark uppercase tracking-widest">Interest-Free Plans</h3>
        <div className="flex flex-col gap-3">
          {["Tabby", "Tamara"].map(plan => (
            <div 
              key={plan}
              onClick={() => togglePlan(plan)}
              className={`flex items-center justify-between p-4 bg-white rounded-2xl border transition-all cursor-pointer shadow-sm ${
                filters.plans.includes(plan) ? "border-primary ring-1 ring-primary/20" : "border-transparent hover:border-gray-200"
              }`}
            >
              <span className="font-bold text-primary-dark">{plan}</span>
              <div className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${filters.plans.includes(plan) ? "bg-primary border-primary text-white" : "border-gray-100"}`}>
                {filters.plans.includes(plan) && <Check size={12} strokeWidth={3} />}
              </div>
            </div>
          ))}
        </div>
        <p className="text-[10px] text-gray-400 font-medium leading-relaxed italic">
          Split into 4 monthly payments with 0% interest on all electric brushes.
        </p>
      </div>

      {/* Rating */}
      <div className="flex flex-col gap-4">
        <h3 className="text-xs font-bold text-gray-400 uppercase tracking-widest">Rating</h3>
        <div className="flex flex-col gap-3">
          {[5, 4, 3].map(rating => (
            <label key={rating} className="flex items-center gap-3 cursor-pointer group">
              <div className={`w-5 h-5 rounded-full border-2 transition-all flex items-center justify-center ${filters.rating === rating ? "border-primary bg-primary/5 shadow-inner" : "border-gray-100"}`}>
                <div className={`w-2 h-2 rounded-full bg-primary scale-0 transition-transform ${filters.rating === rating ? "scale-100" : ""}`}></div>
              </div>
              <div className="flex items-center gap-1">
                {[...Array(5)].map((_, i) => (
                  <Star key={i} size={14} fill={i < rating ? "#BA7517" : "none"} className={i < rating ? "text-accent" : "text-gray-200"} />
                ))}
                <span className="text-xs font-bold text-gray-400 ml-1">& Up</span>
              </div>
              <input type="radio" value={rating} className="hidden" onChange={() => setFilters({...filters, rating})} />
            </label>
          ))}
        </div>
      </div>
    </aside>
  );
};
