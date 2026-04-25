"use client";

import Link from "next/link";
import { ArrowRight, ShoppingBag, Trash2, Minus, Plus } from "lucide-react";
import { useCartStore } from "@/lib/store";
import { useState, useEffect } from "react";
import Image from "next/image";

export default function CartPage() {
  const [mounted, setMounted] = useState(false);
  const { items, updateQuantity, removeItem, getCartTotal, getCartCount, isLoading } = useCartStore();

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setMounted(true);
  }, []);

  if (!mounted) return null;

  const totalSegments = getCartTotal();
  const subtotal = totalSegments / 1.05; // Assuming 5% VAT included
  const vat = totalSegments - subtotal;
  const isFreeShipping = totalSegments > 99;

  return (
    <main className="bg-surface min-h-screen pt-32 pb-24">
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 flex flex-col gap-12">
        <div className="flex flex-col gap-2">
          <h1 className="text-4xl lg:text-5xl font-serif text-primary-dark tracking-tight">Your Cart</h1>
          <p className="text-gray-500">{getCartCount()} items in your cart</p>
        </div>

        {items.length === 0 ? (
          <div className="bg-white rounded-3xl p-12 lg:p-24 border border-gray-100 shadow-sm text-center flex flex-col items-center justify-center gap-8 min-h-[40vh]">
            <div className="w-16 h-16 bg-surface-container-high rounded-full flex items-center justify-center text-gray-400">
              <ShoppingBag size={24} />
            </div>
            <div className="flex flex-col gap-4">
              <h2 className="text-2xl font-serif font-bold text-primary-dark">Your cart is empty</h2>
              <p className="text-gray-500 max-w-md mx-auto">
                Before proceeding to checkout, you must add some products to your shopping cart.
              </p>
            </div>
            <Link href="/shop" className="bg-primary text-white hover:bg-primary-dark px-8 py-4 rounded-xl font-semibold transition-all shadow-md flex items-center gap-2 mt-4">
              Browse Products <ArrowRight size={18} />
            </Link>
          </div>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-12 items-start">
            {/* Cart Items */}
            <div className="lg:col-span-2 flex flex-col gap-6">
              <div className="flex flex-col gap-6 bg-white p-6 md:p-8 rounded-3xl border border-border-custom shadow-sm">
                {items.map((item) => (
                  <div key={item.lineId || item.id} className="flex flex-col md:flex-row gap-6 relative py-6 border-b border-gray-100 last:border-0 last:pb-0 first:pt-0">
                    <div className="relative w-24 h-24 bg-[#f9f9f7] rounded-xl flex-shrink-0 border border-border-custom shadow-sm overflow-hidden p-2">
                      <Image src={item.image} alt={item.name} fill className="object-contain" />
                    </div>
                    <div className="flex flex-col justify-center flex-1 gap-1">
                      <h3 className="text-lg font-serif font-semibold text-primary-dark">{item.name}</h3>
                      <p className="text-sm text-gray-400 uppercase tracking-widest">{item.brand}</p>
                      <div className="text-primary-dark font-bold mt-2">AED {item.price.toFixed(2)}</div>
                    </div>
                    <div className="flex md:flex-col items-end justify-between md:justify-center gap-4">
                      <div className="flex items-center bg-surface-container-low rounded-lg border border-border-custom p-1">
                        <button 
                          onClick={() => updateQuantity(item.lineId!, item.quantity - 1)}
                          disabled={isLoading}
                          className="w-8 h-8 flex items-center justify-center hover:bg-white rounded text-primary transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
                        >
                          <Minus size={14} />
                        </button>
                        <span className="w-8 text-center text-sm font-semibold">{item.quantity}</span>
                        <button 
                          onClick={() => updateQuantity(item.lineId!, item.quantity + 1)}
                          disabled={isLoading}
                          className="w-8 h-8 flex items-center justify-center hover:bg-white rounded text-primary transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
                        >
                          <Plus size={14} />
                        </button>
                      </div>
                      <button 
                        onClick={() => removeItem(item.lineId!)}
                        disabled={isLoading}
                        className="text-gray-400 hover:text-red-500 transition-colors flex items-center gap-1 text-sm font-medium disabled:opacity-30 disabled:cursor-not-allowed"
                      >
                        <Trash2 size={14} /> Remove
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Order Summary */}
            <div className="bg-white p-6 md:p-8 rounded-3xl border border-border-custom shadow-sm flex flex-col gap-6 sticky top-32">
              <h3 className="text-xl font-serif font-bold text-primary-dark border-b border-gray-100 pb-4">Order Summary</h3>
              
              <div className="flex flex-col gap-3 text-sm text-gray-600">
                <div className="flex justify-between">
                  <span>Subtotal</span>
                  <span className="font-medium text-primary-dark">AED {subtotal.toFixed(2)}</span>
                </div>
                <div className="flex justify-between">
                  <span>VAT (5% Included)</span>
                  <span>AED {vat.toFixed(2)}</span>
                </div>
                <div className="flex justify-between">
                  <span>Shipping</span>
                  {isFreeShipping ? (
                    <span className="text-primary font-bold">Free</span>
                  ) : (
                    <span>AED 20.00</span>
                  )}
                </div>
              </div>

              {!isFreeShipping && (
                <div className="bg-primary/5 p-3 rounded-xl border border-primary/10 text-xs text-primary-dark font-medium flex items-center justify-center gap-2 text-center">
                  Add AED {(99 - totalSegments).toFixed(2)} more to qualify for free shipping!
                </div>
              )}

              <div className="border-t border-gray-100 pt-4 flex justify-between items-center text-lg font-bold text-primary-dark">
                <span>Total</span>
                <span>AED {(totalSegments + (!isFreeShipping ? 20 : 0)).toFixed(2)}</span>
              </div>

              <div className="flex flex-col gap-3 mt-2">
                <Link href="/checkout" className="w-full bg-primary hover:bg-primary-dark text-white py-4 rounded-xl font-bold shadow-md shadow-primary/20 transition-all flex items-center justify-center gap-2">
                  Proceed to Checkout <ArrowRight size={18} />
                </Link>
                <Link href="/shop" className="w-full border border-gray-200 hover:border-primary py-4 rounded-xl font-bold text-gray-600 hover:text-primary transition-all flex items-center justify-center">
                  Continue Shopping
                </Link>
              </div>

              {/* Secure Payment Badges */}
              <div className="flex flex-col items-center gap-3 pt-6 border-t border-gray-100 opacity-60">
                <span className="text-xs font-semibold uppercase tracking-widest text-gray-400">Secure Checkout</span>
                <div className="flex items-center gap-2">
                  <div className="w-8 h-5 bg-gray-200 rounded"></div>
                  <div className="w-8 h-5 bg-gray-200 rounded"></div>
                  <div className="w-8 h-5 bg-gray-200 rounded"></div>
                  <div className="w-8 h-5 bg-gray-200 rounded"></div>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </main>
  );
}
