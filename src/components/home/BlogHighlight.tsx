"use client";

import Image from "next/image";
import Link from "next/link";
import { ArrowRight } from "lucide-react";

const ARTICLES = [
  {
    title: "Sonic vs. Oscillating: Which is better for your gums?",
    excerpt: "The ultimate guide to choosing the right electric toothbrush technology for your specific needs.",
    category: "Oral Health",
    date: "April 15, 2024",
    image: "https://lh3.googleusercontent.com/aida/ADBb0ui_fh04OXHJNgNxBF8yqvegrxXCs6v4CQmDevUZ60uh7CvpqZQGsNRkjz9SX-kGm3NV82WgGd1c28h1KfxH4KxXTeJIi6WCY4FsQnOkRrr5L-RPk71cRn9PgtnBCYtwihjDgTF9uoqdUzVuvpaM6aBYYHtUUtJZvvzG2CByADCLHApG7NcsHOy1ZI86l0j9dsVwk_U08kSUaH3MgRCd5clQWcvtWu16ydZ4o9FwQaSch7H9n5vUO8qkEX0",
    href: "/blog/sonic-vs-oscillating"
  },
  {
    title: "How to maintain your white smile at home",
    excerpt: "Practical tips and product recommendations to keep your smile bright between clinic visits.",
    category: "Whitening",
    date: "April 12, 2024",
    image: "https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb",
    href: "/blog/maintaining-white-smile"
  },
  {
    title: "Making Brushing Fun for Your Kids",
    excerpt: "Turn daily hygiene into a playful activity with these expert-approved strategies.",
    category: "Kids Dental",
    date: "April 08, 2024",
    image: "https://lh3.googleusercontent.com/aida/ADBb0ui_fh04OXHJNgNxBF8yqvegrxXCs6v4CQmDevUZ60uh7CvpqZQGsNRkjz9SX-kGm3NV82WgGd1c28h1KfxH4KxXTeJIi6WCY4FsQnOkRrr5L-RPk71cRn9PgtnBCYtwihjDgTF9uoqdUzVuvpaM6aBYYHtUUtJZvvzG2CByADCLHApG7NcsHOy1ZI86l0j9dsVwk_U08kSUaH3MgRCd5clQWcvtWu16ydZ4o9FwQaSch7H9n5vUO8qkEX0",
    href: "/blog/kids-brushing-fun"
  }
];

export const BlogHighlight = () => {
  return (
    <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-24">
      <div className="flex flex-col gap-12">
        <div className="flex items-end justify-between border-b border-gray-100 pb-8">
          <div className="flex flex-col gap-4">
            <h2 className="text-4xl lg:text-5xl font-serif text-primary-dark tracking-tight">The Dental Journal</h2>
            <p className="text-gray-500 max-w-lg text-lg italic">Clinical insights, expert guides, and the latest in oral wellness.</p>
          </div>
          <Link href="/blog" className="text-primary-dark font-bold flex items-center gap-2 hover:gap-4 transition-all pb-2 border-b-2 border-primary/10 hover:border-primary">
            Read All Articles <ArrowRight size={20} />
          </Link>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
          {ARTICLES.map((article, index) => (
            <Link key={index} href={article.href} className="group flex flex-col gap-8">
              <div className="relative h-[300px] rounded-[2.5rem] overflow-hidden shadow-sm group-hover:shadow-2xl transition-all duration-700">
                <Image src={article.image} alt={article.title} fill className="object-cover group-hover:scale-110 transition-transform duration-[2s]" />
                <div className="absolute top-6 left-6">
                  <span className="px-4 py-2 bg-white/90 backdrop-blur-md rounded-full text-[10px] font-bold uppercase tracking-widest text-primary-dark shadow-xl">
                    {article.category}
                  </span>
                </div>
              </div>

              <div className="flex flex-col gap-4">
                <p className="text-xs font-bold uppercase tracking-widest text-primary-dark/40">{article.date}</p>
                <h3 className="text-2xl lg:text-3xl font-serif text-primary-dark group-hover:text-primary transition-colors leading-tight">
                  {article.title}
                </h3>
                <p className="text-gray-500 line-clamp-2 leading-relaxed font-sans italic">
                  {article.excerpt}
                </p>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
};

export default BlogHighlight;
