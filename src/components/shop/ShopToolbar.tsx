"use client";

import { LayoutGrid, List } from "lucide-react";

interface ToolbarProps {
  count: number;
  viewMode: "grid" | "list";
  setViewMode: (mode: "grid" | "list") => void;
}

export const ShopToolbar = ({ count, viewMode, setViewMode }: ToolbarProps) => {
  return (
    <div className="flex items-center justify-between py-6 border-b border-gray-100">
      <span className="text-gray-400 font-medium tracking-tight">
        Showing <span className="text-primary-dark font-bold">1-{Math.min(count, 24)}</span> of <span className="text-primary-dark font-bold">{count}</span> products
      </span>

      <div className="flex items-center gap-6">
        <div className="flex items-center gap-1">
          <button 
            onClick={() => setViewMode("grid")}
            className={`flex items-center gap-2 px-3 py-1.5 rounded-lg transition-all ${
              viewMode === "grid" ? "text-primary-dark font-bold bg-[#F5F5F3]" : "text-gray-300 hover:text-gray-500"
            }`}
          >
            <LayoutGrid size={18} />
            <span className="text-xs uppercase tracking-widest">Grid</span>
          </button>
          
          <button 
            onClick={() => setViewMode("list")}
            className={`flex items-center gap-2 px-3 py-1.5 rounded-lg transition-all ${
              viewMode === "list" ? "text-primary-dark font-bold bg-[#F5F5F3]" : "text-gray-300 hover:text-gray-500"
            }`}
          >
            <List size={18} />
            <span className="text-xs uppercase tracking-widest">List</span>
          </button>
        </div>
      </div>
    </div>
  );
};
