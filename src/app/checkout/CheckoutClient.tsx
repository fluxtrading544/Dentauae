"use client";

import { useCartStore } from "@/lib/store";
import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { SafeImage } from "@/components/ui/SafeImage";
import { CreditCard, Truck, AlertCircle, ChevronRight, Lock, Calendar } from "lucide-react";
import { loadStripe } from "@stripe/stripe-js";
import { Elements } from "@stripe/react-stripe-js";
import { StripePayment } from "@/components/checkout/StripePayment";
import { HttpTypes } from "@medusajs/types";

const stripePromise = loadStripe(process.env.NEXT_PUBLIC_STRIPE_KEY || "");

export const CheckoutClient = () => {
  const router = useRouter();
  const [mounted, setMounted] = useState(false);
  const { 
    items, 
    getCartTotal, 
    updateCheckoutData, 
    fetchShippingMethods, 
    shippingMethods,
    setShippingOption,
    selectedShippingOptionId,
    selectedShippingMethod,
    initPayment,
    finalizeCheckout,
  } = useCartStore();

  const [step, setStep] = useState<"info" | "payment">("info");
  const [paymentMethod, setPaymentMethod] = useState("card");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [clientSecret, setClientSecret] = useState<string | null>(null);

  // Form State
  const [formData, setFormData] = useState({
    email: "",
    phone: "",
    firstName: "",
    lastName: "",
    emirate: "",
    address: "",
  });

  useEffect(() => {
    setMounted(true);
    if (items.length === 0) {
      router.push("/cart");
    }
  }, [items.length, router]);

  if (!mounted || items.length === 0) return null;

  const totalSegments = getCartTotal();
  const subtotal = totalSegments / 1.05;
  const vat = totalSegments - subtotal;
  
  // Use selected shipping method amount if available, otherwise fallback
  const isFreeShipping = totalSegments > 99;
  const shippingCost = selectedShippingMethod 
    ? (selectedShippingMethod.amount || 0) 
    : (!isFreeShipping ? 20 : 0);
    
  const finalTotal = totalSegments + shippingCost;

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleInfoSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);
    
    try {
      const address = {
        first_name: formData.firstName,
        last_name: formData.lastName,
        address_1: formData.address,
        city: formData.emirate,
        province: formData.emirate,
        country_code: "ae",
        phone: formData.phone,
      };

      await updateCheckoutData(formData.email, address);
      await fetchShippingMethods();
      
      const methods = useCartStore.getState().shippingMethods;
      if (methods && methods.length > 0) {
        // Only set default if one isn't already selected
        if (!selectedShippingOptionId) {
          const standard = methods.find(m => m.name.toLowerCase().includes('standard')) || methods[0];
          await setShippingOption(standard.id);
        }
      } else {
        throw new Error("No shipping methods available for this region.");
      }

      if (paymentMethod === "card") {
        const paymentCollection = await initPayment("stripe");
        // In Medusa v2, payment_collection has payment_sessions
        const session = paymentCollection?.payment_sessions?.find((s: HttpTypes.StorePaymentSession) => s.provider_id === "stripe");
        if (session?.data?.client_secret) {
          setClientSecret(session.data.client_secret as string);
          setStep("payment");
        } else {
          throw new Error("Payment session could not be established. Please try again or contact support.");
        }
      } else {
        // COD: use the system default manual payment provider
        await initPayment("pp_system_default");
        handlePaymentSuccess();
      }
    } catch (err: unknown) {
      console.error("Info submission failed:", err);
      const errorMessage = err instanceof Error ? err.message : "An error occurred. Check backend logs.";
      setError(errorMessage);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handlePaymentSuccess = async () => {
    try {
      const order = await finalizeCheckout();
      if (order && order.id) {
        router.push(`/checkout/success?id=${order.id}`);
      } else {
        throw new Error("Order completion failed.");
      }
    } catch (err: unknown) {
      const errorMessage = err instanceof Error ? err.message : "An unexpected error occurred";
      setError(errorMessage);
      setIsSubmitting(false);
    }
  };

  return (
    <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-12 lg:py-24 grid grid-cols-1 lg:grid-cols-2 gap-16 items-start">
      
      {/* Left Column: Form */}
      <div className="flex flex-col gap-10">
        <div>
          <div className="flex items-center gap-2 mb-2">
            <span className={`text-xs font-bold px-2 py-1 rounded-full ${step === 'info' ? 'bg-primary text-white' : 'bg-gray-100 text-gray-500'}`}>Step 1</span>
            <ChevronRight size={12} className="text-gray-300" />
            <span className={`text-xs font-bold px-2 py-1 rounded-full ${step === 'payment' ? 'bg-primary text-white' : 'bg-gray-100 text-gray-500'}`}>Step 2</span>
          </div>
          <h1 className="text-3xl font-serif text-primary-dark tracking-tight mb-2">
            {step === "info" ? "Shipping & Contact" : "Secure Payment"}
          </h1>
          <p className="text-gray-500">
            {step === "info" ? "Please provide your details for delivery." : "Confirm your payment to complete the order."}
          </p>
          {error && (
            <div className="mt-4 p-4 bg-red-50 border border-red-200 rounded-xl flex items-center gap-3 text-red-600">
              <AlertCircle size={20} />
              <p className="text-sm font-medium">{error}</p>
            </div>
          )}
        </div>

        {step === "info" ? (
          <form onSubmit={handleInfoSubmit} className="flex flex-col gap-10">
            <section className="flex flex-col gap-6">
              <h2 className="text-xl font-serif font-bold text-primary-dark pb-2 border-b border-gray-100">Contact Information</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="flex flex-col gap-2">
                  <label className="text-sm font-medium text-gray-700">Email Address *</label>
                  <input required type="email" name="email" value={formData.email} onChange={handleInputChange} className="px-4 py-3 bg-white border border-border-custom rounded-xl focus:border-primary focus:ring-1 focus:ring-primary transition-all" />
                </div>
                <div className="flex flex-col gap-2">
                  <label className="text-sm font-medium text-gray-700">Phone Number *</label>
                  <input required type="tel" name="phone" value={formData.phone} onChange={handleInputChange} className="px-4 py-3 bg-white border border-border-custom rounded-xl focus:border-primary focus:ring-1 focus:ring-primary transition-all" />
                </div>
              </div>
            </section>

            <section className="flex flex-col gap-6">
              <h2 className="text-xl font-serif font-bold text-primary-dark pb-2 border-b border-gray-100">Shipping Details</h2>
              <div className="grid grid-cols-1 gap-4">
                <div className="flex flex-col gap-2">
                  <label className="text-sm font-medium text-gray-700">Emirate *</label>
                  <select required name="emirate" value={formData.emirate} onChange={handleInputChange} className="px-4 py-3 bg-white border border-border-custom rounded-xl">
                    <option value="">Select Emirate</option>
                    <option value="Dubai">Dubai</option>
                    <option value="Abu Dhabi">Abu Dhabi</option>
                    <option value="Sharjah">Sharjah</option>
                    <option value="Ajman">Ajman</option>
                    <option value="Ras Al Khaimah">Ras Al Khaimah</option>
                  </select>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <input required name="firstName" value={formData.firstName} onChange={handleInputChange} placeholder="First Name" className="px-4 py-3 border border-border-custom rounded-xl" />
                  <input required name="lastName" value={formData.lastName} onChange={handleInputChange} placeholder="Last Name" className="px-4 py-3 border border-border-custom rounded-xl" />
                </div>
                <input required name="address" value={formData.address} onChange={handleInputChange} placeholder="Street Address" className="px-4 py-3 border border-border-custom rounded-xl" />
              </div>
            </section>

            {shippingMethods?.length > 0 && (
              <section className="flex flex-col gap-6">
                <h2 className="text-xl font-serif font-bold text-primary-dark pb-2 border-b border-gray-100">Delivery Method</h2>
                <div className="grid grid-cols-1 gap-3">
                  {shippingMethods.map(method => {
                    const isSelected = selectedShippingOptionId === method.id;
                    const isExpress = method.name.toLowerCase().includes('express');
                    return (
                      <div 
                        key={method.id}
                        onClick={() => setShippingOption(method.id)}
                        className={`flex items-center justify-between p-5 rounded-2xl border-2 transition-all cursor-pointer ${
                          isSelected ? 'border-primary bg-primary/5 shadow-sm' : 'border-gray-100 bg-white hover:border-gray-200'
                        }`}
                      >
                        <div className="flex items-center gap-4">
                          <div className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${isSelected ? 'border-primary' : 'border-gray-300'}`}>
                            {isSelected && <div className="w-2.5 h-2.5 rounded-full bg-primary" />}
                          </div>
                          <div className="flex flex-col">
                            <span className="font-bold text-primary-dark">{method.name}</span>
                            <span className="text-xs text-gray-400 font-medium">
                              {isExpress ? "Arrival Next Day" : "Arrival in 2-3 Days"}
                            </span>
                          </div>
                        </div>
                        <span className={`font-bold ${isSelected ? 'text-primary' : 'text-primary-dark'}`}>
                          {method.amount > 0 ? `AED ${method.amount.toFixed(2)}` : 'FREE'}
                        </span>
                      </div>
                    );
                  })}
                </div>
              </section>
            )}

            <section className="flex flex-col gap-6">
              <h2 className="text-xl font-serif font-bold text-primary-dark pb-2 border-b border-gray-100">Preferred Payment</h2>
              <div className="flex flex-col gap-3">
                <label 
                  className={`flex items-center justify-between p-4 rounded-xl border-2 cursor-pointer ${paymentMethod === 'card' ? 'border-primary bg-primary/5' : 'border-border-custom bg-white'}`}
                  onClick={() => setPaymentMethod('card')}
                >
                  <div className="flex items-center gap-3">
                    <div className={`w-4 h-4 rounded-full border-2 flex items-center justify-center ${paymentMethod === 'card' ? 'border-primary' : 'border-gray-300'}`}>
                      {paymentMethod === 'card' && <div className="w-2 h-2 rounded-full bg-primary" />}
                    </div>
                    <span className="font-semibold text-primary-dark">Credit / Debit Card</span>
                  </div>
                  <CreditCard size={20} className={paymentMethod === 'card' ? 'text-primary' : 'text-gray-400'} />
                </label>
                <label 
                  className={`flex items-center justify-between p-4 rounded-xl border-2 cursor-pointer ${paymentMethod === 'cod' ? 'border-primary bg-primary/5' : 'border-border-custom bg-white'}`}
                  onClick={() => setPaymentMethod('cod')}
                >
                  <div className="flex items-center gap-3">
                    <div className={`w-4 h-4 rounded-full border-2 flex items-center justify-center ${paymentMethod === 'cod' ? 'border-primary' : 'border-gray-300'}`}>
                      {paymentMethod === 'cod' && <div className="w-2 h-2 rounded-full bg-primary" />}
                    </div>
                    <span className="font-semibold text-primary-dark">Cash on Delivery</span>
                  </div>
                  <Truck size={20} className={paymentMethod === 'cod' ? 'text-primary' : 'text-gray-400'} />
                </label>
              </div>
            </section>

            <button 
              type="submit" 
              disabled={isSubmitting}
              className="w-full bg-primary hover:bg-primary-dark text-white py-5 rounded-xl font-bold text-lg transition-all disabled:opacity-70 mt-4 flex items-center justify-center gap-2"
            >
              {isSubmitting ? "Saving Details..." : (
                <>
                  Continue to Payment
                  <ChevronRight size={20} />
                </>
              )}
            </button>
          </form>
        ) : (
          <div className="flex flex-col gap-8">
            <button onClick={() => setStep("info")} className="text-sm font-semibold text-primary hover:underline flex items-center gap-1">
              ← Edit Shipping Details
            </button>
            {clientSecret && (
              <Elements stripe={stripePromise} options={{ clientSecret }}>
                <StripePayment 
                  total={finalTotal} 
                  onSuccess={handlePaymentSuccess} 
                  onError={(msg) => setError(msg)} 
                />
              </Elements>
            )}
            <div className="flex items-center justify-center gap-2 text-gray-400 text-xs">
              <Lock size={12} />
              <span>SSL Secure Encryption</span>
            </div>
          </div>
        )}
      </div>

      {/* Right Column: Order Summary */}
      <div className="bg-surface-container-low p-6 md:p-10 rounded-3xl border border-border-custom sticky top-12 flex flex-col gap-8">
        <h3 className="text-2xl font-serif font-bold text-primary-dark">Order Summary</h3>
        
        {/* Clinical Delivery Promise */}
        <div className="bg-white p-4 rounded-2xl border border-primary/10 flex items-center gap-4 bg-primary/5">
          <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center text-primary shadow-sm">
            <Calendar size={18} />
          </div>
          <div>
            <p className="text-[10px] font-bold text-primary uppercase tracking-widest leading-none mb-1">Clinical Delivery Promise</p>
            <p className="text-sm font-bold text-primary-dark">
              Expected Arrival: {(() => {
                const isExpress = selectedShippingMethod?.name?.toLowerCase().includes('express');
                const startOff = isExpress ? 1 : 2;
                const endOff = isExpress ? 1 : 3;
                const start = new Date(new Date().setDate(new Date().getDate() + startOff)).toLocaleDateString('en-AE', { month: 'short', day: 'numeric' });
                const end = new Date(new Date().setDate(new Date().getDate() + endOff)).toLocaleDateString('en-AE', { month: 'short', day: 'numeric' });
                return isExpress ? `Tomorrow, ${start}` : `${start} - ${end}`;
              })()}
            </p>
          </div>
        </div>

        <div className="flex flex-col gap-4 max-h-[40vh] overflow-y-auto pr-2 mt-2">
          {items.map(item => (
            <div key={item.id} className="flex gap-4 items-center">
              <div className="relative w-16 h-16 bg-white rounded-lg border border-gray-100 overflow-hidden">
                <SafeImage src={item.image} alt={item.name} fill sizes="64px" className="object-contain p-2" />
                <span className="absolute -top-2 -right-2 bg-gray-500 text-white text-[10px] w-5 h-5 rounded-full flex items-center justify-center font-bold">{item.quantity}</span>
              </div>
              <div className="flex flex-col flex-1">
                <h4 className="text-sm font-semibold text-primary-dark line-clamp-1">{item.name}</h4>
                <span className="text-xs text-gray-500">{item.brand}</span>
              </div>
              <div className="font-bold text-primary-dark text-sm">AED {(item.price * item.quantity).toFixed(2)}</div>
            </div>
          ))}
        </div>
        <div className="flex flex-col gap-3 text-sm text-gray-600 border-t border-border-custom pt-6">
          <div className="flex justify-between"><span>Subtotal</span><span className="font-medium text-primary-dark">AED {subtotal.toFixed(2)}</span></div>
          <div className="flex justify-between"><span>VAT (5%)</span><span>AED {vat.toFixed(2)}</span></div>
          <div className="flex justify-between">
            <span>Shipping ({selectedShippingMethod?.name || 'Standard'})</span>
            <span className={shippingCost === 0 ? 'text-primary font-bold' : ''}>
              {shippingCost === 0 ? 'Free' : `AED ${shippingCost.toFixed(2)}`}
            </span>
          </div>
        </div>
        <div className="border-t border-gray-200 pt-6 flex justify-between items-center text-xl font-bold text-primary-dark">
          <span>Total</span>
          <span>AED {finalTotal.toFixed(2)}</span>
        </div>
      </div>
    </div>
  );
};
