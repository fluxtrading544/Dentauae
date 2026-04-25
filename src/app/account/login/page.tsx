import AuthForms from "@/components/account/AuthForms";
import { Suspense } from "react";

export default function LoginPage() {
  return (
    <div className="min-h-screen bg-surface flex flex-col items-center justify-center p-4 lg:p-12">
      <div className="max-w-7xl mx-auto w-full grid grid-cols-1 lg:grid-cols-2 gap-20 items-center">
        {/* Branding/Value Prop */}
        <div className="hidden lg:flex flex-col gap-10">
          <div className="flex flex-col gap-6">
            <span className="text-primary font-bold tracking-[0.3em] uppercase text-sm">Welcome to the Atelier</span>
            <h1 className="text-6xl font-serif text-primary-dark leading-[1.1]">
              Elevate Your <br />
              <span className="text-teal-600/40 italic">Oral Wellness</span> Journey
            </h1>
            <p className="text-lg text-gray-600 leading-relaxed max-w-md">
              Access your personalized clinical profile to track diagnoses, manage clinical deliveries, and access exclusive professional dental technologies.
            </p>
          </div>

          <div className="grid grid-cols-1 gap-6">
            <div className="flex items-center gap-5 p-6 bg-white rounded-2xl border border-border-custom shadow-sm transition-all hover:shadow-md">
              <div className="w-12 h-12 bg-primary/10 rounded-xl flex items-center justify-center text-primary italic font-serif text-xl">D</div>
              <div className="flex flex-col">
                <span className="font-bold text-primary-dark">Digital Diagnostics</span>
                <span className="text-sm text-gray-500">View brushing historical reports from A.I. modules.</span>
              </div>
            </div>
            <div className="flex items-center gap-5 p-6 bg-white rounded-2xl border border-border-custom shadow-sm transition-all hover:shadow-md">
              <div className="w-12 h-12 bg-primary/10 rounded-xl flex items-center justify-center text-primary italic font-serif text-xl">D</div>
              <div className="flex flex-col">
                <span className="font-bold text-primary-dark">Diagnostic History</span>
                <span className="text-sm text-gray-500">Track all your premium clinical order records.</span>
              </div>
            </div>
          </div>
        </div>

        {/* Login Form Container */}
        <Suspense fallback={<div className="flex items-center justify-center p-20"><div className="w-10 h-10 border-4 border-primary border-t-transparent animate-spin rounded-full"></div></div>}>
          <AuthForms />
        </Suspense>
      </div>
    </div>
  );
}
