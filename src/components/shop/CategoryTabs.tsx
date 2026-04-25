"use client";

import { Zap, Brush, Sparkles, Droplets, Waves } from "lucide-react";

const categories = [
  { name: "Electric Brushes", icon: Zap, color: "bg-teal-50 text-teal-600" },
  { name: "Toothpaste", icon: Brush, color: "bg-blue-50 text-blue-600" },
  { name: "Whitening", icon: Sparkles, color: "bg-amber-50 text-amber-600" },
  { name: "Mouthwash", icon: Droplets, color: "bg-cyan-50 text-cyan-600" },
  { name: "Floss & Picks", icon: Waves, color: "bg-green-50 text-green-600" },
];

export const CategoryTabs = ({ selected, onSelect }: { selected?: string, onSelect: (name: string) => void }) => {
  return (
    <div className="flex items-center gap-4 overflow-x-auto pb-4 scrollbar-hide">
      {categories.map((cat) => {
        const Icon = cat.icon;
        const isActive = selected === cat.name;
        
        return (
          <button
            key={cat.name}
            onClick={() => onSelect(cat.name)}
            className={`flex items-center gap-3 px-6 py-3 rounded-full border transition-all whitespace-nowrap ${
              isActive 
                ? "bg-primary-dark text-white border-primary-dark shadow-lg scale-105" 
                : "bg-white text-gray-600 border-gray-100 hover:border-primary/30 hover:bg-primary/5 shadow-sm"
            }`}
          >
            <div className={`p-1.5 rounded-full ${isActive ? "bg-white/20" : cat.color}`}>
              <Icon size={16} />
            </div>
            <span className="text-sm font-bold tracking-tight">{cat.name}</span>
          </button>
        );
      })}
    </div>
  );
};
