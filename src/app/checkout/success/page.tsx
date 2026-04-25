"use client";

import Link from "next/link";
import { CheckCircle, Package, ArrowRight } from "lucide-react";
import { useEffect, useState, Suspense } from "react";
import { useSearchParams } from "next/navigation";

function SuccessContent() {
  const [mounted, setMounted] = useState(false);
  const searchParams = useSearchParams();
  const orderId = searchParams.get("id");
  const [orderNumber, setOrderNumber] = useState<string | null>(null);

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setMounted(true);
    if (!orderNumber) {
      setOrderNumber(orderId || "UAE-" + Math.floor(Math.random() * 1000000).toString().padStart(6, '0'));
    }
  }, [orderId, orderNumber]);

  if (!mounted) return null;

  return (
    <main className="bg-surface min-h-screen pt-32 pb-24 flex items-center justify-center">
      <div className="max-w-2xl mx-auto w-full px-4 text-center flex flex-col items-center">
        
        {/* Animated Checkmark Circle */}
        <div className="relative mb-8">
          <div className="absolute inset-0 bg-primary/20 rounded-full animate-ping"></div>
          <div className="relative w-24 h-24 bg-primary text-white rounded-full flex items-center justify-center shadow-xl shadow-primary/30 z-10">
            <CheckCircle size={48} />
          </div>
        </div>

        <h1 className="text-4xl lg:text-5xl font-serif text-primary-dark tracking-tight mb-4">
          Order Confirmed!
        </h1>
        
        <p className="text-gray-500 text-lg mb-8 max-w-md mx-auto">
          Thank you for choosing DentaUAE. Our clinical team is preparing your premium oral care items for dispatch.
        </p>

        <div className="bg-white border border-border-custom rounded-2xl p-8 w-full shadow-sm flex flex-col gap-6 mb-10">
          <div className="flex items-center justify-between border-b border-gray-100 pb-4">
            <span className="text-gray-500 font-medium">Order Number</span>
            <span className="font-bold text-primary-dark font-mono bg-gray-50 px-3 py-1 rounded">{orderNumber}</span>
          </div>
          
          <div className="flex items-center gap-4 text-left">
            <div className="w-12 h-12 bg-surface-container-low rounded-xl flex items-center justify-center text-primary-dark shrink-0">
              <Package size={24} />
            </div>
            <div>
              <h4 className="font-bold text-primary-dark">Tracking updates sent via email</h4>
              <p className="text-sm text-gray-500">You will receive an SMS and email notification once your package is with the courier.</p>
            </div>
          </div>
        </div>

        <Link 
          href="/shop" 
          className="bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-xl font-bold shadow-lg shadow-primary/20 transition-all flex items-center gap-2"
        >
          Continue Shopping <ArrowRight size={18} />
        </Link>
      </div>
    </main>
  );
}

export default function SuccessPage() {
  return (
    <Suspense fallback={<div className="min-h-screen pt-32 pb-24 flex items-center justify-center font-bold text-primary-dark">Loading Order...</div>}>
      <SuccessContent />
    </Suspense>
  );
}
