"use client";

import { useEffect } from "react";
import { useCartStore } from "@/lib/store";

/**
 * Ensures the Medusa cart is initialized session-wide.
 */
export default function CartInitializer() {
  const initializeCart = useCartStore((state) => state.initializeCart);

  useEffect(() => {
    initializeCart();
  }, [initializeCart]);

  return null;
}
