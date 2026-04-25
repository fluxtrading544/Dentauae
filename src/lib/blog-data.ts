export interface BlogPost {
  id: string;
  title: string;
  slug: string;
  excerpt: string;
  content: string;
  date: string;
  author: {
    name: string;
    role: string;
    image: string;
  };
  category: string;
  image: string;
  readingTime: string;
}

export const BLOG_POSTS: BlogPost[] = [
  {
    id: "post-1",
    title: "The Science of Sonic Vibration: Why frequencies matter in oral care",
    slug: "science-of-sonic-vibration",
    excerpt: "Explore the clinical correlation between high-frequency sonic drive and the elimination of subgingival biofilm without damaging soft tissue.",
    content: "Full content here...",
    date: "April 24, 2026",
    author: {
      name: "Dr. Elena Vance",
      role: "Board Certified Periodontist",
      image: "https://images.unsplash.com/photo-1559839734-2b71f1536783?auto=format&fit=crop&q=80&w=200&h=200"
    },
    category: "Clinical Research",
    image: "https://images.unsplash.com/photo-1606811841689-23dfddce3e95?auto=format&fit=crop&q=80&w=1200",
    readingTime: "8 min read"
  },
  {
    id: "post-2",
    title: "Decoding pH: How salivary chemistry dictates tooth longevity",
    slug: "decoding-ph-salivary-chemistry",
    excerpt: "A deep dive into the buffering capacity of saliva and how professional-grade whitening treatments impact the oral microbiome ecosystem.",
    content: "Full content here...",
    date: "April 20, 2026",
    author: {
      name: "Dr. Marcus Thorne",
      role: "Professor of Preventative Dentistry",
      image: "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&q=80&w=200&h=200"
    },
    category: "Oral Microbiome",
    image: "https://images.unsplash.com/photo-1576091160550-217359f49f4c?auto=format&fit=crop&q=80&w=1200",
    readingTime: "12 min read"
  },
  {
    id: "post-3",
    title: "From Clinics to Closets: Curating a surgical-grade home dental routine",
    slug: "curating-surgical-grade-routine",
    excerpt: "Bridging the gap between biennial clinical visits and daily maintenance using advanced iO technology and targeted interdental solutions.",
    content: "Full content here...",
    date: "April 15, 2026",
    author: {
      name: "Sarah Jenkins",
      role: "Lead Clinical Hygienist",
      image: "https://images.unsplash.com/photo-1594824476967-48c8b964273f?auto=format&fit=crop&q=80&w=200&h=200"
    },
    category: "Routine Optimization",
    image: "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?auto=format&fit=crop&q=80&w=1200",
    readingTime: "6 min read"
  }
];
