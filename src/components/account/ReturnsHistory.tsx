"use client";

import React from "react";
import { 
  History, 
  ArrowLeftRight, 
  CheckCircle2, 
  Clock, 
  FileText, 
  ExternalLink,
  Info
} from "lucide-react";

interface ReturnRequest {
  id: string;
  invoiceNumber: string;
  amount: number;
  date: string;
  status: "pending" | "received" | "processed" | "refunded";
  statusLabel: string;
  confirmedDate?: string;
}

const SAMPLE_RETURNS: ReturnRequest[] = [
  {
    id: "RET-001",
    invoiceNumber: "SC01100001",
    amount: 735.85,
    date: "2024-10-01",
    status: "received",
    statusLabel: "Confirmed Delivered",
    confirmedDate: "Oct 11, 2024"
  }
];

export const ReturnsHistory = () => {
  return (
    <div className="flex flex-col gap-8 py-4">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-secondary/10 rounded-xl flex items-center justify-center text-secondary">
            <ArrowLeftRight size={22} />
          </div>
          <div>
            <h3 className="text-xl font-serif font-bold text-primary-dark">Returns & Refunds</h3>
            <p className="text-sm text-gray-500">Track and manage your recent refund requests.</p>
          </div>
        </div>
        <button className="text-sm font-semibold text-primary hover:underline flex items-center gap-1">
          Request New Return
        </button>
      </div>

      <div className="grid grid-cols-1 gap-6">
        {SAMPLE_RETURNS.map((req) => (
          <div key={req.id} className="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-sm hover:shadow-md transition-shadow">
            <div className="p-6 md:p-8 flex flex-col md:flex-row md:items-center justify-between gap-6">
              <div className="flex flex-col gap-1">
                <div className="flex items-center gap-2 mb-1">
                  <span className="text-[10px] font-bold uppercase tracking-widest text-gray-400">Request #{req.id}</span>
                  <div className="px-2 py-0.5 bg-secondary/10 text-secondary text-[10px] font-bold rounded-full">
                    {req.statusLabel}
                  </div>
                </div>
                <h4 className="text-lg font-bold text-primary-dark">Refund for Invoice: {req.invoiceNumber}</h4>
                <div className="flex items-center gap-4 text-xs text-gray-500 mt-1">
                  <span className="flex items-center gap-1"><FileText size={14} /> Created {req.date}</span>
                  {req.confirmedDate && (
                    <span className="flex items-center gap-1 text-secondary font-medium"><CheckCircle2 size={14} /> Received {req.confirmedDate}</span>
                  )}
                </div>
              </div>

              <div className="flex items-center gap-8">
                <div className="flex flex-col items-end">
                  <span className="text-xs text-gray-400">Refund Amount</span>
                  <span className="text-xl font-bold text-primary-dark">AED {req.amount.toFixed(2)}</span>
                </div>
                <button className="p-3 bg-surface-container-low hover:bg-surface-container-medium rounded-xl border border-border-custom transition-colors">
                  <ExternalLink size={18} className="text-primary-dark" />
                </button>
              </div>
            </div>

            {/* Refund Progress Tracker */}
            <div className="px-6 pb-6 bg-surface-container-low/30 border-t border-gray-50 pt-4">
              <div className="flex justify-between items-center mb-6 px-2">
                <span className="text-[10px] font-bold text-gray-400">REFUND PROGRESS</span>
                <div className="flex items-center gap-1 text-[10px] text-primary font-bold">
                  <Info size={12} />
                  DUE TO ORIGINAL PAYMENT METHOD
                </div>
              </div>
              
              <div className="relative flex justify-between px-10">
                {/* Lines */}
                <div className="absolute top-4 left-10 right-10 h-0.5 bg-gray-100 -z-10" />
                <div className="absolute top-4 left-10 w-[66%] h-0.5 bg-secondary -z-10" />

                <div className="flex flex-col items-center gap-2">
                  <div className="w-8 h-8 rounded-full bg-secondary text-white flex items-center justify-center shadow-lg shadow-secondary/20">
                    <History size={14} />
                  </div>
                  <span className="text-[10px] font-bold text-primary-dark">Requested</span>
                </div>

                <div className="flex flex-col items-center gap-2">
                  <div className="w-8 h-8 rounded-full bg-secondary text-white flex items-center justify-center shadow-lg shadow-secondary/20">
                    <CheckCircle2 size={14} />
                  </div>
                  <span className="text-[10px] font-bold text-primary-dark">Received</span>
                </div>

                <div className="flex flex-col items-center gap-2">
                  <div className="w-8 h-8 rounded-full bg-white border-2 border-secondary text-secondary flex items-center justify-center animate-pulse">
                    <Clock size={14} />
                  </div>
                  <span className="text-[10px] font-bold text-secondary">Processing</span>
                </div>

                <div className="flex flex-col items-center gap-2 opacity-30">
                  <div className="w-8 h-8 rounded-full bg-gray-100 border-2 border-gray-200 text-gray-400 flex items-center justify-center">
                    <CheckCircle2 size={14} />
                  </div>
                  <span className="text-[10px] font-bold text-gray-400">Refunded</span>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
