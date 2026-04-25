"use client";

import { useEffect, useState } from "react";
import Link from "next/link";

export const FlashSaleBanner = () => {
  const [timeLeft, setTimeLeft] = useState({
    hours: 8,
    minutes: 42,
    seconds: 15,
  });

  useEffect(() => {
    const timer = setInterval(() => {
      setTimeLeft((prev) => {
        if (prev.seconds > 0) return { ...prev, seconds: prev.seconds - 1 };
        if (prev.minutes > 0) return { ...prev, minutes: prev.minutes - 1, seconds: 59 };
        if (prev.hours > 0) return { ...prev, hours: prev.hours - 1, minutes: 59, seconds: 59 };
        return prev;
      });
    }, 1000);

    return () => clearInterval(timer);
  }, []);

  return (
    <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-12">
      <div className="bg-primary rounded-[3rem] p-8 lg:p-16 relative overflow-hidden flex flex-col lg:flex-row items-center justify-between gap-12 group">
        {/* Background Patterns */}
        <div className="absolute top-0 right-0 w-1/2 h-full bg-white/5 -skew-x-12 translate-x-20 group-hover:translate-x-10 transition-transform duration-1000"></div>
        <div className="absolute bottom-0 left-0 w-1/3 h-1/2 bg-black/5 rounded-full blur-3xl -translate-x-20"></div>

        <div className="relative z-10 flex flex-col gap-6 text-center lg:text-left max-w-2xl">
          <span className="px-4 py-1 bg-white/10 text-white font-bold text-xs uppercase tracking-widest rounded-full w-fit mx-auto lg:mx-0 backdrop-blur-md">
            Limited Time Offer
          </span>
          <h2 className="text-4xl lg:text-5xl font-serif text-white tracking-tight leading-[1.1]">
            Flash Sale: Up to <br />
            <span className="text-primary-light italic">40% Off Select Brands</span>
          </h2>
          
          <div className="flex items-center justify-center lg:justify-start gap-8 mt-4">
            <div className="flex flex-col items-center">
              <span className="text-4xl lg:text-5xl font-mono font-bold text-white leading-none">
                {String(timeLeft.hours).padStart(2, '0')}
              </span>
              <span className="text-[10px] uppercase tracking-tighter text-white/50 font-bold mt-2">Hours</span>
            </div>
            <span className="text-3xl text-white/30 pt-2 font-bold">:</span>
            <div className="flex flex-col items-center">
              <span className="text-4xl lg:text-5xl font-mono font-bold text-white leading-none">
                {String(timeLeft.minutes).padStart(2, '0')}
              </span>
              <span className="text-[10px] uppercase tracking-tighter text-white/50 font-bold mt-2">Mins</span>
            </div>
            <span className="text-3xl text-white/30 pt-2 font-bold">:</span>
            <div className="flex flex-col items-center">
              <span className="text-4xl lg:text-5xl font-mono font-bold text-white leading-none">
                {String(timeLeft.seconds).padStart(2, '0')}
              </span>
              <span className="text-[10px] uppercase tracking-tighter text-white/50 font-bold mt-2">Secs</span>
            </div>
          </div>
        </div>

        <div className="relative z-10 flex flex-col items-center gap-6">
          <Link 
            href="/shop" 
            className="bg-white text-primary p-8 rounded-full font-bold transition-all shadow-2xl hover:scale-105 active:scale-95 flex items-center justify-center text-center w-40 h-40 group/btn"
          >
            <span className="group-hover:scale-110 transition-transform">Grab the <br /> Deal Now</span>
          </Link>
        </div>
      </div>
    </section>
  );
};

export default FlashSaleBanner;
