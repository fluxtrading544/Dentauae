"use client";

import { useEffect, useState } from "react";
import { listCustomerOrders } from "@/lib/data/customer";
import { Package, Calendar, Clock, ChevronRight, Activity } from "lucide-react";
import type { HttpTypes } from "@medusajs/types";

export default function OrderHistory() {
  const [orders, setOrders] = useState<HttpTypes.StoreOrder[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const { orders } = await listCustomerOrders();
        setOrders(orders);
      } finally {
        setLoading(false);
      }
    };
    fetchOrders();
  }, []);

  if (loading) {
    return (
      <div className="flex flex-col gap-4">
        {[1, 2, 3].map((i) => (
          <div key={i} className="h-24 bg-surface animate-pulse rounded-2xl border border-border-custom" />
        ))}
      </div>
    );
  }

  if (orders.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center p-12 bg-white rounded-3xl border border-dashed border-border-custom gap-4 text-center">
        <div className="w-12 h-12 bg-surface rounded-full flex items-center justify-center text-gray-300">
          <Clock size={24} />
        </div>
        <div className="flex flex-col gap-1">
          <p className="font-bold text-primary-dark uppercase text-xs tracking-widest">No Diagnostic History</p>
          <p className="text-sm text-gray-400">Your future dental experiences will appear here.</p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-4">
      {orders.map((order) => (
        <div 
          key={order.id} 
          className="group bg-white p-6 rounded-3xl border border-border-custom shadow-sm transition-all hover:shadow-xl hover:border-primary/20 flex items-center justify-between cursor-pointer"
        >
          <div className="flex items-center gap-6">
            <div className={`w-14 h-14 rounded-2xl flex items-center justify-center ${
              order.status === "completed" ? "bg-primary/10 text-primary" : "bg-teal-50 text-teal-600"
            }`}>
              <Activity size={24} />
            </div>
            
            <div className="flex flex-col gap-1">
              <div className="flex items-center gap-2">
                <span className="text-sm font-bold text-primary-dark">Diagnostic #{order.display_id || order.id.slice(-6)}</span>
                <span className={`px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider rounded-md ${
                  order.fulfillment_status === "fulfilled" ? "bg-green-100 text-green-700" : "bg-surface text-gray-500"
                }`}>
                  {order.fulfillment_status}
                </span>
              </div>
              <div className="flex items-center gap-4 text-xs text-gray-500">
                <span className="flex items-center gap-1.5 font-medium"><Calendar size={12} /> {new Date(order.created_at).toLocaleDateString()}</span>
                <span className="flex items-center gap-1.5 font-medium"><Package size={12} /> {order.items?.length || 0} Modules</span>
              </div>
            </div>
          </div>

          <div className="flex items-center gap-8">
            <div className="flex flex-col items-end gap-1">
              <span className="text-lg font-bold text-primary-dark">AED {order.total.toFixed(2)}</span>
              <span className="text-[10px] font-bold text-gray-400 uppercase tracking-widest italic">{order.payment_status}</span>
            </div>
            <ChevronRight className="text-gray-300 transition-transform group-hover:translate-x-1" size={20} />
          </div>
        </div>
      ))}
    </div>
  );
}
