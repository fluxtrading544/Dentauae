"use client";

import React, { useState } from "react";
import {
  PaymentElement,
  useStripe,
  useElements,
} from "@stripe/react-stripe-js";
import { AlertCircle, ShieldCheck, Loader2 } from "lucide-react";

interface StripePaymentProps {
  onSuccess: (paymentId: string) => void;
  onError: (message: string) => void;
  total: number;
}

export const StripePayment: React.FC<StripePaymentProps> = ({ onSuccess, onError, total }) => {
  const stripe = useStripe();
  const elements = useElements();
  const [isProcessing, setIsProcessing] = useState(false);

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    if (!stripe || !elements) {
      return;
    }

    setIsProcessing(true);

    const { error, paymentIntent } = await stripe.confirmPayment({
      elements,
      confirmParams: {
        // Return URL for handles if needed, but for headless we usually capture in-app
        return_url: `${window.location.origin}/checkout/success`,
      },
      redirect: "if_required",
    });

    if (error) {
      onError(error.message || "An unexpected error occurred.");
      setIsProcessing(false);
    } else if (paymentIntent && paymentIntent.status === "succeeded") {
      onSuccess(paymentIntent.id);
    }
  };

  return (
    <div className="flex flex-col gap-6 animate-in fade-in slide-in-from-top-4 duration-500">
      <div className="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-2">
            <ShieldCheck className="text-secondary" size={20} />
            <span className="text-sm font-semibold text-primary-dark">Secure Card Processing</span>
          </div>
          <div className="flex gap-1">
            <div className="w-8 h-5 bg-gray-100 rounded border border-gray-200 flex items-center justify-center text-[8px] font-bold text-gray-400">VISA</div>
            <div className="w-8 h-5 bg-gray-100 rounded border border-gray-200 flex items-center justify-center text-[8px] font-bold text-gray-400">MC</div>
          </div>
        </div>

        <PaymentElement 
          options={{
            layout: "tabs",
          }} 
        />
        
        <div className="mt-6 flex items-start gap-3 p-4 bg-teal-50/50 rounded-xl border border-teal-100 text-teal-800 text-xs">
          <AlertCircle size={14} className="mt-0.5" />
          <p>
            Your payment is processed by Stripe. DentaUAE does not store your credit card information. 
            Final amount: <span className="font-bold underline decoration-secondary decoration-2 underline-offset-2">AED {total.toFixed(2)}</span>
          </p>
        </div>
      </div>

      <button
        type="submit"
        onClick={handleSubmit}
        disabled={!stripe || isProcessing}
        className="w-full bg-primary hover:bg-primary-dark text-white py-5 rounded-xl font-bold text-lg shadow-xl shadow-primary/20 transition-all flex items-center justify-center disabled:opacity-70 disabled:cursor-not-allowed"
      >
        {isProcessing ? (
          <>
            <Loader2 className="animate-spin mr-2" size={20} />
            Validating Transaction...
          </>
        ) : (
          `Complete Secure Payment`
        )}
      </button>
    </div>
  );
};
