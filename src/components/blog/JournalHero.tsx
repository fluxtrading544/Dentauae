import Image from "next/image";
import Link from "next/link";
import { ArrowRight, ShieldCheck } from "lucide-react";
import { BlogPost } from "@/lib/blog-data";

export const JournalHero = ({ post }: { post: BlogPost }) => {
  return (
    <section className="relative w-full min-h-[70vh] rounded-[3rem] lg:rounded-[5rem] overflow-hidden group">
      <Image 
        src={post.image} 
        alt={post.title} 
        fill 
        className="object-cover transition-transform duration-[3000ms] group-hover:scale-110" 
        priority
      />
      <div className="absolute inset-0 bg-gradient-to-t from-primary-dark via-primary-dark/40 to-transparent" />
      
      <div className="absolute inset-0 flex flex-col justify-end p-8 lg:p-24">
        <div className="max-w-4xl flex flex-col gap-8">
           <div className="flex items-center gap-3">
              <div className="bg-tertiary/90 backdrop-blur-md px-5 py-2 rounded-full text-[10px] font-bold text-white uppercase tracking-[0.2em] shadow-lg flex items-center gap-2">
                 <ShieldCheck size={14} />
                 Featured Research
              </div>
           </div>

           <div className="flex flex-col gap-6">
              <h1 className="text-3xl lg:text-6xl font-serif text-white tracking-tight leading-[1.1]">
                {post.title}
              </h1>
              <p className="text-lg lg:text-xl text-white/80 leading-relaxed max-w-2xl font-light italic">
                {post.excerpt}
              </p>
           </div>

           <div className="flex flex-col lg:flex-row lg:items-center gap-8 lg:gap-16 pt-4">
              <div className="flex items-center gap-4">
                <div className="relative w-14 h-14 rounded-2xl overflow-hidden border-2 border-white/20">
                  <Image src={post.author.image} alt={post.author.name} fill className="object-cover" />
                </div>
                <div className="flex flex-col">
                  <span className="text-sm font-bold text-white">{post.author.name}</span>
                  <span className="text-[10px] text-white/60 uppercase tracking-widest">{post.author.role}</span>
                </div>
              </div>

              <Link 
                href={`/blog/${post.slug}`}
                className="bg-white text-primary-dark px-10 py-5 rounded-full font-bold flex items-center justify-center gap-3 hover:bg-primary hover:text-white transition-all group/btn shadow-2xl shadow-black/20"
              >
                Read Full Paper <ArrowRight size={20} className="group-hover/btn:translate-x-2 transition-transform" />
              </Link>
           </div>
        </div>
      </div>
    </section>
  );
};
