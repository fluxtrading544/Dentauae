"use client";

import { useState, useMemo } from "react";
import { ProductCard } from "@/components/products/ProductCard";
import { Product } from "@/lib/mock-data";
import { ShopHero } from "@/components/shop/ShopHero";
import { CategoryTabs } from "@/components/shop/CategoryTabs";
import { ShopSidebar } from "@/components/shop/ShopSidebar";
import { ShopToolbar } from "@/components/shop/ShopToolbar";
import { ShopPagination } from "@/components/shop/ShopPagination";

export const ShopPageClient = ({ initialProducts }: { initialProducts: Product[] }) => {
  const [viewMode, setViewMode] = useState<"grid" | "list">("grid");
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedCategory, setSelectedCategory] = useState<string>("Electric Brushes");
  const [filters, setFilters] = useState({
    search: "",
    brands: [] as string[],
    priceRange: [50, 2000] as [number, number],
    rating: 0,
    plans: [] as string[]
  });

  // Calculate dynamic brand counts based on the current category
  const brandCounts = useMemo(() => {
    const counts: Record<string, number> = {};
    initialProducts
      .filter(p => p.category === selectedCategory)
      .forEach(p => {
        counts[p.brand] = (counts[p.brand] || 0) + 1;
      });
    return counts;
  }, [initialProducts, selectedCategory]);

  const filteredProducts = useMemo(() => {
    return initialProducts.filter(product => {
      if (selectedCategory && product.category !== selectedCategory) return false;
      if (filters.brands.length > 0 && !filters.brands.includes(product.brand)) return false;
      if (filters.search && !product.name.toLowerCase().includes(filters.search.toLowerCase())) return false;
      if (product.price < filters.priceRange[0] || product.price > filters.priceRange[1]) return false;
      if (filters.rating > 0 && product.rating < filters.rating) return false;
      return true;
    });
  }, [initialProducts, selectedCategory, filters]);

  // Handle hero content dynamically
  const heroContent = {
    title: selectedCategory || "The Clinical Collection",
    description: "Advanced oral care technology for a brighter, healthier smile. Discover premium models expertly curated for the UAE.",
    image: initialProducts.find(p => p.category === selectedCategory)?.image || initialProducts[0]?.image || "https://lh3.googleusercontent.com/aida/ADBb0uihHWsAYPZ-TfRuQ_ggJRfzLqraJD5F_kSb_LgjEoYHNv4tdVDjjOEVVmTcSaZ_IekfH6G_0xlPbB-11mbfD9DrohjqhUC0t_-0Hc-BzxcMKce6MZpkhOYqia1ChIagYBVUSVI0dCClUGtKd_m9LG7-GJ1li7TVxu4dJsZjDF88M0Ic1q5fjTAP2-i3GFvNPczxD3gy8moe81s24Akp4jecBb1EjZA5y5P5gmQW0n1djO-ONGDGF81bvkXk"
  };

  return (
    <div className="flex flex-col gap-8 lg:gap-10">
      {/* 1. Hero Section */}
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 pt-0">
        <ShopHero 
          title={heroContent.title}
          description={heroContent.description}
          image="https://lh3.googleusercontent.com/aida/ADBb0uihHWsAYPZ-TfRuQ_ggJRfzLqraJD5F_kSb_LgjEoYHNv4tdVDjjOEVVmTcSaZ_IekfH6G_0xlPbB-11mbfD9DrohjqhUC0t_-0Hc-BzxcMKce6MZpkhOYqia1ChIagYBVUSVI0dCClUGtKd_m9LG7-GJ1li7TVxu4dJsZjDF88M0Ic1q5fjTAP2-i3GFvNPczxD3gy8moe81s24Akp4jecBb1EjZA5y5P5gmQW0n1djO-ONGDGF81bvkXk"
        />
      </div>

      {/* 2. Category Navigation */}
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 flex justify-center">
        <CategoryTabs 
          selected={selectedCategory} 
          onSelect={(cat) => { setSelectedCategory(cat); setCurrentPage(1); }} 
        />
      </div>

      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 pb-32">
        {/* 3. Toolbar (Counts & Toggle) */}
        <ShopToolbar 
          count={filteredProducts.length} 
          viewMode={viewMode} 
          setViewMode={setViewMode} 
        />

        {/* 4. Main Content Row */}
        <div className="flex flex-col lg:flex-row gap-12 items-start mt-4">
          
          {/* Sidebar */}
          <div className="w-full lg:w-72 sticky top-32">
            <ShopSidebar 
              filters={filters} 
              setFilters={setFilters} 
              brandCounts={brandCounts}
            />
          </div>

          {/* Product Feed */}
          <div className="flex-1 w-full">
            <div className={`grid ${
              viewMode === "grid" 
                ? "grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8" 
                : "flex flex-col gap-6"
            }`}>
              {filteredProducts.slice(0, 24).map(product => (
                <ProductCard key={product.id} product={product} />
              ))}
            </div>

            {filteredProducts.length === 0 && (
              <div className="flex flex-col items-center justify-center py-32 text-center gap-6 bg-[#FAFAF8] rounded-[3rem] border border-dashed border-gray-200">
                <div className="w-20 h-20 bg-white rounded-full flex items-center justify-center shadow-sm text-gray-300">
                  <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
                </div>
                <div>
                  <h3 className="text-xl font-bold text-primary-dark">No products found</h3>
                  <p className="text-gray-400 mt-2">Try adjusting your filters or searching for something else.</p>
                </div>
                <button 
                  onClick={() => setFilters({search: "", brands: [], priceRange: [50, 2000], rating: 0, plans: []})}
                  className="px-8 py-3 bg-primary text-white rounded-xl font-bold shadow-lg shadow-primary/20 hover:bg-primary-dark transition-all"
                >
                  Clear All Filters
                </button>
              </div>
            )}

            {filteredProducts.length > 24 && (
              <ShopPagination 
                total={Math.ceil(filteredProducts.length / 24)} 
                current={currentPage} 
                onPageChange={setCurrentPage} 
              />
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default ShopPageClient;
