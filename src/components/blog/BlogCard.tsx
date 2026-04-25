import Image from "next/image";
import Link from "next/link";
import { ArrowUpRight, Clock } from "lucide-react";
import { BlogPost } from "@/lib/blog-data";

export const BlogCard = ({ post }: { post: BlogPost }) => {
  return (
    <div className="group relative flex flex-col gap-6 bg-white rounded-[2rem] p-6 border border-gray-100 hover:shadow-2xl hover:shadow-primary/5 transition-all duration-500 h-full">
      <div className="relative aspect-[1.5/1] w-full rounded-2xl overflow-hidden bg-[#fafafa]">
        <Image 
          src={post.image} 
          alt={post.title} 
          fill 
          className="object-cover group-hover:scale-105 transition-transform duration-700" 
        />
        <div className="absolute top-4 left-4">
          <span className="bg-white/90 backdrop-blur-md px-4 py-2 rounded-full text-[10px] font-bold text-primary uppercase tracking-widest shadow-sm border border-white/20">
            {post.category}
          </span>
        </div>
      </div>

      <div className="flex flex-col gap-4 flex-1">
        <div className="flex items-center gap-4 text-[10px] font-bold text-gray-400 uppercase tracking-widest">
            <div className="flex items-center gap-1.5">
                <Clock size={12} />
                <span>{post.readingTime}</span>
            </div>
            <div className="w-1 h-1 rounded-full bg-gray-300" />
            <span>{post.date}</span>
        </div>

        <h3 className="text-xl font-serif text-primary-dark leading-tight group-hover:text-primary transition-colors">
          {post.title}
        </h3>

        <p className="text-sm text-gray-500 leading-relaxed line-clamp-2">
          {post.excerpt}
        </p>
      </div>

      <div className="pt-6 border-t border-gray-50 flex items-center justify-between mt-auto">
        <div className="flex items-center gap-3">
            <div className="relative w-8 h-8 rounded-full overflow-hidden border border-primary/10">
                <Image src={post.author.image} alt={post.author.name} fill className="object-cover" />
            </div>
            <div className="flex flex-col">
                <span className="text-[10px] font-bold text-primary-dark">{post.author.name}</span>
                <span className="text-[8px] text-gray-400 uppercase tracking-tight">{post.author.role}</span>
            </div>
        </div>
        <div className="w-10 h-10 rounded-full bg-primary/5 flex items-center justify-center text-primary group-hover:bg-primary group-hover:text-white transition-all">
            <ArrowUpRight size={18} />
        </div>
      </div>

      <Link href={`/blog/${post.slug}`} className="absolute inset-0 z-10" />
    </div>
  );
};
