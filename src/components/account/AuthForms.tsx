"use client";

import { useState, Suspense } from "react";
import { useCartStore } from "@/lib/store";
import { useRouter, useSearchParams } from "next/navigation";
import { Lock, Mail, ArrowRight, UserPlus, Loader2 } from "lucide-react";

function AuthFormsContent() {
  const [view, setView] = useState<"login" | "register">("login");
  const [error, setError] = useState<string | null>(null);
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    first_name: "",
    last_name: "",
  });

  const { login, isLoading } = useCartStore();
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirect = searchParams.get("redirect") || "/account";

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    try {
      await login({ email: formData.email, password: formData.password });
      router.push(redirect);
    } catch {
      setError("Invalid clinical credentials. Please try again.");
    }
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    try {
      const { registerCustomer } = await import("@/lib/data/customer");
      await registerCustomer({
        email: formData.email,
        password: formData.password,
        first_name: formData.first_name,
        last_name: formData.last_name,
      });
      // Auto login after register
      await login({ email: formData.email, password: formData.password });
      router.push("/account");
    } catch {
      setError("Registration failed. This email may already be registered.");
    }
  };

  return (
    <div className="w-full max-w-md mx-auto">
      <div className="bg-white rounded-3xl shadow-2xl overflow-hidden border border-border-custom">
        <div className="p-8 lg:p-12">
          <div className="flex flex-col items-center text-center gap-4 mb-10">
            <div className="w-16 h-16 bg-surface rounded-2xl flex items-center justify-center text-primary shadow-inner">
              {view === "login" ? <Lock size={32} /> : <UserPlus size={32} />}
            </div>
            <h2 className="text-3xl font-serif text-primary-dark">
              {view === "login" ? "Patient Login" : "Patient Registration"}
            </h2>
            <p className="text-teal-600/60 text-sm font-medium uppercase tracking-widest">
              DentaUAE Clinical Atelier
            </p>
          </div>

          <form onSubmit={view === "login" ? handleLogin : handleRegister} className="flex flex-col gap-5">
            {view === "register" && (
              <div className="grid grid-cols-2 gap-4">
                <div className="flex flex-col gap-2">
                  <label className="text-xs font-bold text-primary-dark uppercase">First Name</label>
                  <input
                    type="text"
                    required
                    className="p-4 bg-surface rounded-xl border border-transparent focus:border-primary/30 outline-none transition-all text-sm"
                    placeholder="John"
                    value={formData.first_name}
                    onChange={(e) => setFormData({ ...formData, first_name: e.target.value })}
                  />
                </div>
                <div className="flex flex-col gap-2">
                  <label className="text-xs font-bold text-primary-dark uppercase">Last Name</label>
                  <input
                    type="text"
                    required
                    className="p-4 bg-surface rounded-xl border border-transparent focus:border-primary/30 outline-none transition-all text-sm"
                    placeholder="Doe"
                    value={formData.last_name}
                    onChange={(e) => setFormData({ ...formData, last_name: e.target.value })}
                  />
                </div>
              </div>
            )}

            <div className="flex flex-col gap-2">
              <label className="text-xs font-bold text-primary-dark uppercase">Clinical Email</label>
              <div className="relative">
                <Mail className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400" size={18} />
                <input
                  type="email"
                  required
                  className="w-full p-4 pl-12 bg-surface rounded-xl border border-transparent focus:border-primary/30 outline-none transition-all text-sm"
                  placeholder="name@example.com"
                  value={formData.email}
                  onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                />
              </div>
            </div>

            <div className="flex flex-col gap-2">
              <label className="text-xs font-bold text-primary-dark uppercase">Password</label>
              <div className="relative">
                <Lock className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400" size={18} />
                <input
                  type="password"
                  required
                  className="w-full p-4 pl-12 bg-surface rounded-xl border border-transparent focus:border-primary/30 outline-none transition-all text-sm"
                  placeholder="••••••••"
                  value={formData.password}
                  onChange={(e) => setFormData({ ...formData, password: e.target.value })}
                />
              </div>
            </div>

            {error && (
              <p className="text-red-500 text-xs font-bold bg-red-50 p-3 rounded-lg border border-red-100 flex items-center gap-2">
                <span className="w-1 h-1 bg-red-500 rounded-full" />
                {error}
              </p>
            )}

            <button
              disabled={isLoading}
              className="w-full py-5 bg-primary-dark text-white rounded-xl font-bold shadow-xl shadow-primary/20 hover:bg-primary transition-all flex items-center justify-center gap-2 mt-4"
            >
              {isLoading ? (
                <Loader2 className="animate-spin" size={20} />
              ) : (
                <>
                  {view === "login" ? "Access Portal" : "Create Patient Account"}
                  <ArrowRight size={20} />
                </>
              )}
            </button>
          </form>

          <div className="mt-8 text-center bg-surface p-4 rounded-xl">
            <p className="text-sm text-gray-500">
              {view === "login" ? "New to DentaUAE?" : "Already have an account?"}{" "}
              <button
                onClick={() => setView(view === "login" ? "register" : "login")}
                className="text-primary font-bold hover:underline"
              >
                {view === "login" ? "Register your clinical profile" : "Log in to your portal"}
              </button>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default function AuthForms() {
  return (
    <Suspense fallback={<div className="w-full max-w-md mx-auto text-center py-10 font-bold text-primary-dark">Loading Authentication Securely...</div>}>
      <AuthFormsContent />
    </Suspense>
  );
}
