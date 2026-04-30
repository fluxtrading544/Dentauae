"use client";

import React, { useState } from "react";
import { 
  ShoppingBag, 
  ArrowRight, 
  CheckCircle2, 
  Loader2, 
  ExternalLink,
  Info,
  ShieldCheck
} from "lucide-react";
import { useRouter } from "next/navigation";

export default function AmazonImportPage() {
  const [url, setUrl] = useState("");
  const [isImporting, setIsImporting] = useState(false);
  const [status, setStatus] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [importedProduct, setImportedProduct] = useState<Record<string, unknown> | null>(null);
  const router = useRouter();

  const handleImport = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!url) return;

    setIsImporting(true);
    setError(null);
    setStatus("Analyzing Amazon link...");
    setImportedProduct(null);

    try {
      const backendUrl = process.env.NEXT_PUBLIC_MEDUSA_BACKEND_URL || "http://localhost:9000";
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 60000); // 60s timeout

      // Simulate status updates (Premium feel)
      const t1 = setTimeout(() => setStatus("Extracting product metadata..."), 1500);
      const t2 = setTimeout(() => setStatus("Downloading images..."), 4000);
      const t3 = setTimeout(() => setStatus("Creating product in Medusa..."), 8000);

      const response = await fetch(`${backendUrl}/amazon-import`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ url }),
        signal: controller.signal
      });

      clearTimeout(timeoutId);
      clearTimeout(t1); clearTimeout(t2); clearTimeout(t3);

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || "Failed to import product");
      }

      setImportedProduct(data.product as Record<string, unknown>);
      setStatus("Import Successful!");
    } catch {
      setError("An unexpected error occurred");
      setStatus(null);
    } finally {
      setIsImporting(false);
    }
  };

  return (
    <div className="min-h-[80vh] flex items-center justify-center px-4 py-20 bg-[radial-gradient(circle_at_top_right,_var(--color-slate-100),_transparent)]">
      <div className="max-w-xl w-full">
        {/* Header */}
        <div className="text-center mb-10">
          <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-teal-600/10 text-teal-600 mb-4">
            <ShoppingBag className="w-8 h-8" />
          </div>
          <h1 className="text-4xl font-serif text-slate-900 mb-3">Amazon Importer</h1>
          <p className="text-slate-500 max-w-sm mx-auto">
            Quickly add premium dental products to your catalog by pasting an Amazon UAE link.
          </p>
        </div>

        {/* Form Card */}
        <div className="bg-white/70 backdrop-blur-xl border border-slate-200 rounded-3xl p-8 shadow-2xl shadow-slate-200/50">
          {!importedProduct ? (
            <form onSubmit={handleImport} className="space-y-6">
              <div className="space-y-2">
                <label className="text-xs font-semibold uppercase tracking-wider text-slate-400 ml-1">
                  Amazon Product URL or ASIN
                </label>
                <div className="relative group">
                  <input
                    type="text"
                    value={url}
                    onChange={(e) => setUrl(e.target.value)}
                    placeholder="https://www.amazon.ae/dp/..."
                    className="w-full h-14 pl-5 pr-12 rounded-2xl border-2 border-slate-100 bg-white group-focus-within:border-teal-500 transition-all outline-none"
                    disabled={isImporting}
                  />
                  <div className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-300 group-focus-within:text-teal-500 transition-colors">
                    <ArrowRight className="w-5 h-5" />
                  </div>
                </div>
              </div>

              {isImporting && (
                <div className="flex items-center gap-3 p-4 rounded-2xl bg-teal-50 border border-teal-100">
                  <Loader2 className="w-5 h-5 text-teal-600 animate-spin" />
                  <span className="text-sm font-medium text-teal-700">{status}</span>
                </div>
              )}

              {error && (
                <div className="p-4 rounded-2xl bg-red-50 border border-red-100 text-sm text-red-600 flex items-start gap-3">
                  <Info className="w-5 h-5 shrink-0" />
                  <span>{error}</span>
                </div>
              )}

              <button
                type="submit"
                disabled={isImporting || !url}
                className="w-full h-14 bg-slate-900 text-white rounded-2xl font-semibold flex items-center justify-center gap-2 hover:bg-slate-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all transform active:scale-[0.98]"
              >
                {isImporting ? "Processing..." : "Start Import"}
              </button>
              
              <div className="flex items-center justify-center gap-2 text-[10px] text-slate-400 uppercase tracking-widest pt-2">
                <ShieldCheck className="w-3 h-3" />
                DentaUAE Admin Protocol v2.0
              </div>
            </form>
          ) : (
            <div className="space-y-6 animate-in fade-in zoom-in duration-500">
              <div className="flex flex-col items-center text-center space-y-4">
                <CheckCircle2 className="w-16 h-16 text-teal-500" />
                <div>
                  <h2 className="text-2xl font-serif text-slate-900">Success!</h2>
                  <p className="text-slate-500">&quot;{importedProduct?.title as string}&quot; has been added to your store.</p>
                </div>
              </div>

              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-100 space-y-3">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-slate-500">Handle:</span>
                  <span className="font-mono text-slate-700">{importedProduct.handle as string}</span>
                </div>
                <div className="flex items-center justify-between text-sm">
                  <span className="text-slate-500">Status:</span>
                  <span className="px-2 py-0.5 bg-teal-100 text-teal-700 rounded-lg text-[10px] font-bold uppercase tracking-tight">Active</span>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <button
                  onClick={() => setImportedProduct(null)}
                  className="h-12 border border-slate-200 text-slate-600 rounded-xl font-medium hover:bg-slate-50 transition-all"
                >
                  Import Another
                </button>
                <button
                  onClick={() => router.push(`/products/${importedProduct.handle as string}`)}
                  className="h-12 bg-teal-600 text-white rounded-xl font-medium hover:bg-teal-700 transition-all flex items-center justify-center gap-2"
                >
                  View Product <ExternalLink className="w-4 h-4" />
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
