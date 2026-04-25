"use client";

import { useCartStore } from "@/lib/store";
import { useRouter } from "next/navigation";
import { 
  Settings, 
  LogOut, 
  MapPin, 
  CreditCard, 
  Heart, 
  Stethoscope,
  ChevronRight,
  TrendingUp
} from "lucide-react";
import OrderHistory from "@/components/account/OrderHistory";
import { ReturnsHistory } from "@/components/account/ReturnsHistory";

export default function AccountPage() {
  const { customer, logout } = useCartStore();
  const router = useRouter();

  if (!customer) return null; // Middleware handles redirect, but guard is safe

  const handleLogout = async () => {
    await logout();
    router.push("/");
  };

  return (
    <div className="min-h-screen bg-surface pt-12 pb-24 px-4 lg:px-8">
      <div className="max-w-7xl mx-auto w-full flex flex-col gap-12">
        
        {/* Portal Header */}
        <div className="flex flex-col lg:flex-row items-start lg:items-center justify-between gap-8 pt-8 border-t border-border-custom">
          <div className="flex flex-col gap-2">
            <span className="text-primary font-bold tracking-[0.3em] uppercase text-xs">Patient Identification</span>
            <h1 className="text-4xl lg:text-5xl font-serif text-primary-dark">
              Welcome back, <br />
              <span className="text-teal-600/60 italic">{customer.first_name} {customer.last_name}</span>
            </h1>
          </div>
          <div className="flex items-center gap-4">
            <button className="flex items-center gap-2 px-5 py-2.5 rounded-full border border-border-custom bg-white font-bold text-sm text-primary-dark hover:border-primary transition-all">
              <Settings size={18} />
              Portal Settings
            </button>
            <button 
              onClick={handleLogout}
              className="flex items-center gap-2 px-5 py-2.5 rounded-full bg-red-50 font-bold text-sm text-red-600 hover:bg-red-100 transition-all"
            >
              <LogOut size={18} />
              Logout
            </button>
          </div>
        </div>

        {/* Dashboard Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-10">
          
          {/* Main Diagnostic History */}
          <div className="lg:col-span-2 flex flex-col gap-16">
            <div className="flex flex-col gap-8">
              <div className="flex items-center justify-between">
                <h2 className="text-2xl font-serif text-primary-dark">Clinical Diagnostic History</h2>
              </div>
              <OrderHistory />
            </div>

            <div className="flex flex-col gap-8">
              <ReturnsHistory />
            </div>
          </div>

          {/* Side Panels */}
          <div className="flex flex-col gap-8">
            
            {/* Quick Actions */}
            <div className="flex flex-col gap-4">
              <h3 className="text-xs font-bold text-gray-400 uppercase tracking-widest px-1">Quick Access</h3>
              <div className="grid grid-cols-1 gap-3">
                <button className="flex items-center justify-between p-5 bg-white border border-border-custom rounded-2xl group hover:border-primary/40 transition-all shadow-sm hover:shadow-lg">
                  <div className="flex items-center gap-4">
                    <div className="p-2.5 bg-surface rounded-xl text-primary"><MapPin size={20} /></div>
                    <span className="font-bold text-primary-dark text-sm">Delivery Addresses</span>
                  </div>
                  <ChevronRight size={18} className="text-gray-300 group-hover:text-primary transition-all" />
                </button>
                <button className="flex items-center justify-between p-5 bg-white border border-border-custom rounded-2xl group hover:border-primary/40 transition-all shadow-sm hover:shadow-lg">
                  <div className="flex items-center gap-4">
                    <div className="p-2.5 bg-surface rounded-xl text-primary"><CreditCard size={20} /></div>
                    <span className="font-bold text-primary-dark text-sm">Payment Sources</span>
                  </div>
                  <ChevronRight size={18} className="text-gray-300 group-hover:text-primary transition-all" />
                </button>
                <button className="flex items-center justify-between p-5 bg-white border border-border-custom rounded-2xl group hover:border-primary/40 transition-all shadow-sm hover:shadow-lg">
                  <div className="flex items-center gap-4">
                    <div className="p-2.5 bg-surface rounded-xl text-primary"><Heart size={20} /></div>
                    <span className="font-bold text-primary-dark text-sm">Clinical Favorites</span>
                  </div>
                  <ChevronRight size={18} className="text-gray-300 group-hover:text-primary transition-all" />
                </button>
              </div>
            </div>

            {/* Health Stats (Clinical Flair) */}
            <div className="p-8 bg-primary-dark rounded-[2.5rem] text-white flex flex-col gap-8 shadow-2xl shadow-primary/20 relative overflow-hidden">
              <TrendingUp className="absolute -top-10 -right-10 text-white/5 w-40 h-40" />
              <div className="flex flex-col gap-4 relative z-10">
                <div className="w-12 h-12 bg-white/10 backdrop-blur-md rounded-2xl flex items-center justify-center">
                  <Stethoscope size={24} className="text-teal-300" />
                </div>
                <div className="flex flex-col">
                  <span className="text-xs font-bold text-teal-300 uppercase tracking-widest mb-1">Health Metric</span>
                  <p className="text-xl font-serif">Brushing diagnostic is due in 3 days.</p>
                </div>
              </div>
              <p className="text-sm text-white/60 leading-relaxed relative z-10">
                Your last iO9 report shows optimal pressure coverage. Maintain your 2-minute cycle.
              </p>
              <button className="w-full py-4 bg-white text-primary-dark rounded-xl font-bold text-sm hover:bg-teal-50 transition-all relative z-10">
                View Latest Report
              </button>
            </div>

          </div>
        </div>

      </div>
    </div>
  );
}
