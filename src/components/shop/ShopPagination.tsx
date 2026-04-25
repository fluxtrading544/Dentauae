"use client";

import { ChevronLeft, ChevronRight } from "lucide-react";

export const ShopPagination = ({ total, current, onPageChange }: { total: number, current: number, onPageChange: (p: number) => void }) => {
  return (
    <div className="flex items-center justify-center gap-2 py-12">
      <button 
        onClick={() => onPageChange(Math.max(1, current - 1))}
        className="w-10 h-10 rounded-full border border-gray-100 flex items-center justify-center text-gray-400 hover:bg-gray-50 hover:text-primary transition-all disabled:opacity-30"
        disabled={current === 1}
      >
        <ChevronLeft size={18} />
      </button>

      {[...Array(total)].map((_, i) => {
        const page = i + 1;
        const isActive = current === page;
        
        return (
          <button
            key={page}
            onClick={() => onPageChange(page)}
            className={`w-10 h-10 rounded-full text-sm font-bold transition-all ${
              isActive 
                ? "bg-primary-dark text-white shadow-lg" 
                : "bg-white text-gray-500 border border-gray-100 hover:border-primary/30"
            }`}
          >
            {page}
          </button>
        );
      })}

      <button 
        onClick={() => onPageChange(Math.min(total, current + 1))}
        className="w-10 h-10 rounded-full border border-gray-100 flex items-center justify-center text-gray-400 hover:bg-gray-50 hover:text-primary transition-all disabled:opacity-30"
        disabled={current === total}
      >
        <ChevronRight size={18} />
      </button>
    </div>
  );
};
