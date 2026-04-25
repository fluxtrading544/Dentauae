"use client";

import { useCartStore } from "@/lib/store";
import type { Product } from "@/lib/mock-data";
import { useState } from "react";
import { CheckCircle2 } from "lucide-react";

export const AddBundleButton = ({ mainProduct, bundleProduct }: { mainProduct: Product, bundleProduct: Product }) => {
  const addItem = useCartStore((state) => state.addItem);
  const [added, setAdded] = useState(false);

  return (
    <button 
      onClick={(e) => {
        e.preventDefault();
        addItem(mainProduct);
        addItem(bundleProduct);
        setAdded(true);
        setTimeout(() => setAdded(false), 2000);
      }}
      className={`w-full py-4 px-6 rounded-xl font-bold transition-all flex items-center justify-center gap-3 shadow-lg ${
        added 
          ? "bg-primary-dark text-white opacity-80" 
          : "bg-primary hover:bg-primary-dark text-white shadow-primary/20"
      }`}
    >
      {added ? <CheckCircle2 size={20} /> : null}
      <span className="whitespace-nowrap tracking-[0.2em]">{added ? "ADDED!" : "ADD BUNDLE"}</span>
    </button>
  );
};
