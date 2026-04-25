"use client";

import { useCartStore } from "@/lib/store";
import type { Product } from "@/lib/mock-data";
import { useState } from "react";
import { CheckCircle2 } from "lucide-react";

export const AddToCartButton = ({ product, variantId }: { product: Product, variantId?: string }) => {
  const addItem = useCartStore((state) => state.addItem);
  const [added, setAdded] = useState(false);

  const handleAdd = (e: React.MouseEvent) => {
    e.preventDefault();
    // Wrap product with the selected variant if provided
    const productToAdd = { ...product, variantId: variantId || product.variantId };
    addItem(productToAdd);
    setAdded(true);
    setTimeout(() => setAdded(false), 2000);
  };

  return (
    <button 
      onClick={handleAdd}
      className={`w-full py-5 rounded-xl font-bold text-lg shadow-xl transition-all flex items-center justify-center gap-3 mt-4 ${
        added 
          ? "bg-primary-dark text-white shadow-primary/10" 
          : "bg-primary hover:bg-primary-dark text-white shadow-primary/20"
      }`}
    >
      {added ? <CheckCircle2 size={24} /> : null}
      {added ? "Added to Cart" : "Add to Secure Cart"}
    </button>
  );
};
