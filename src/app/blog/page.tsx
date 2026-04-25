import { Metadata } from "next";
import { BLOG_POSTS } from "@/lib/blog-data";
import { BlogCard } from "@/components/blog/BlogCard";
import { JournalHero } from "@/components/blog/JournalHero";
import { Shield, Microscope, Award } from "lucide-react";

export const metadata: Metadata = {
  title: "Clinical Journal | DentaUAE",
  description: "Peer-reviewed insights and surgical-grade dental research for the modern patient.",
};

export default function BlogPage() {
  const featuredPost = BLOG_POSTS[0];
  const regularPosts = BLOG_POSTS.slice(1);

  return (
    <main className="bg-[#FAF9F7] min-h-screen pt-32 pb-32">
      <div className="max-w-7xl mx-auto px-4 lg:px-12 flex flex-col gap-24">
        
        {/* Editorial Header */}
        <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-10 border-b border-gray-200 pb-16">
          <div className="flex flex-col gap-6 max-w-3xl">
            <div className="flex items-center gap-3 text-primary font-bold tracking-[0.3em] uppercase text-xs">
              <div className="w-12 h-[1px] bg-primary"></div>
              The DentaUAE Journal
            </div>
            <h1 className="text-4xl lg:text-7xl font-serif text-primary-dark tracking-tighter leading-[0.9]">
              Scholarly <br/> <span className="italic text-primary/80 pl-12 lg:pl-24">Perspectives.</span>
            </h1>
          </div>
          <div className="flex flex-col gap-4 text-right">
              <div className="flex items-center justify-end gap-3 text-primary font-bold">
                  <Award size={18} />
                  <span className="text-[10px] uppercase tracking-widest">Board Certified Board</span>
              </div>
              <p className="text-gray-500 max-w-sm italic ml-auto">
                Bridging the gap between clinical excellence and home-based preventative care through rigorous scientific inquiry.
              </p>
          </div>
        </div>

        {/* Featured Section */}
        <JournalHero post={featuredPost} />

        {/* Board Section (Small bar) */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-10 py-12 bg-primary-dark rounded-[3rem] px-12 lg:px-24">
            <div className="flex items-center gap-6 group">
                <div className="w-12 h-12 rounded-full border border-white/20 flex items-center justify-center text-tertiary group-hover:scale-110 transition-transform">
                    <Shield size={20} />
                </div>
                <div className="flex flex-col">
                    <span className="text-white font-bold text-sm">Clinical Integrity</span>
                    <span className="text-white/40 text-[10px] uppercase tracking-widest">Evidence-Based</span>
                </div>
            </div>
            <div className="flex items-center gap-6 group">
                <div className="w-12 h-12 rounded-full border border-white/20 flex items-center justify-center text-tertiary group-hover:scale-110 transition-transform">
                    <Microscope size={20} />
                </div>
                <div className="flex flex-col">
                    <span className="text-white font-bold text-sm">Research Lab</span>
                    <span className="text-white/40 text-[10px] uppercase tracking-widest">In-Vivo Studies</span>
                </div>
            </div>
            <div className="flex items-center gap-6 group">
                <div className="w-12 h-12 rounded-full border border-white/20 flex items-center justify-center text-tertiary group-hover:scale-110 transition-transform">
                    <Award size={20} />
                </div>
                <div className="flex flex-col">
                    <span className="text-white font-bold text-sm">Global Standards</span>
                    <span className="text-white/40 text-[10px] uppercase tracking-widest">ISO Certified</span>
                </div>
            </div>
        </div>

        {/* Journal Feed */}
        <div className="flex flex-col gap-16">
          <div className="flex items-center justify-between">
            <h2 className="text-3xl font-serif text-primary-dark tracking-tight">Recent Publications</h2>
            <div className="flex gap-4">
              {["All Papers", "Clinical Research", "Routine Guide", "Biological"].map((filter, i) => (
                <button 
                  key={i}
                  className={`text-[10px] font-bold uppercase tracking-widest px-6 py-2.5 rounded-full border transition-all ${i === 0 ? "bg-primary text-white border-primary" : "border-gray-200 text-gray-500 hover:border-primary hover:text-primary"}`}
                >
                  {filter}
                </button>
              ))}
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-12">
            {regularPosts.map((post) => (
              <BlogCard key={post.id} post={post} />
            ))}
            {/* Repeat post 2 just to fill the grid for aesthetic purposes */}
            {regularPosts[0] && <BlogCard key="extra-1" post={regularPosts[0]} />}
          </div>
        </div>

        {/* Newsletter / Subscription */}
        <section className="relative py-24 rounded-[4rem] overflow-hidden bg-primary shadow-2xl shadow-primary/20 mt-12">
           <div className="absolute inset-0 opacity-10 pointer-events-none">
              <div className="absolute top-0 right-0 w-full h-full bg-[radial-gradient(circle_at_80%_20%,#ffffff,transparent_50%)]"></div>
           </div>
           <div className="relative z-10 max-w-3xl mx-auto text-center flex flex-col gap-10 px-8">
              <h2 className="text-4xl lg:text-6xl font-serif text-white tracking-tight">Access the Journal <br/> <span className="italic text-tertiary">Weekly.</span></h2>
              <p className="text-white/70 text-lg leading-relaxed">
                Join 5,000+ clinicians and patients receiving the latest breakthroughs in preventative dental care and routine optimization.
              </p>
              <div className="flex flex-col sm:flex-row gap-4 max-w-md mx-auto w-full">
                <input 
                  type="email" 
                  placeholder="name@clinical.com" 
                  className="flex-1 bg-white/10 border border-white/20 rounded-full px-8 py-5 text-white placeholder-white/40 focus:outline-none focus:bg-white/20 transition-all text-center sm:text-left"
                />
                <button className="bg-white text-primary-dark font-bold px-10 py-5 rounded-full hover:bg-tertiary hover:text-white transition-all shadow-xl">
                  Subscribe
                </button>
              </div>
           </div>
        </section>

      </div>
    </main>
  );
}
