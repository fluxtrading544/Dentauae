"use client";

import { Star } from "lucide-react";

const STAR_DISTRIBUTION = [
  { stars: 5, percentage: 85 },
  { stars: 4, percentage: 10 },
  { stars: 3, percentage: 3 },
  { stars: 2, percentage: 1 },
  { stars: 1, percentage: 1 },
];

const REVIEWS = [
  {
    user: "Sarah J.",
    status: "Verified Buyer",
    title: "Incredible Cleaning Technology",
    content: "As someone who has used electric brushes for years, the iO9 is in a different league. The pressure sensor is incredibly helpful—it turns green when you're just right. My teeth have never felt smoother after a home brush.",
    rating: 5,
    date: "2 days ago"
  },
  {
    user: "Ahmed M.",
    status: "Verified Buyer",
    title: "Premium Feel and App tracking is great",
    content: "The travel case that charges is a game changer for my work trips. The AI tracking in the app helps ensure I'm hitting every surface. Highly recommend if you take dental health seriously.",
    rating: 5,
    date: "1 week ago"
  }
];

export const ProductReviews = ({ rating, reviewsCount }: { rating: number; reviewsCount: number }) => {
  return (
    <section className="max-w-7xl mx-auto w-full px-4 lg:px-8 py-24 border-t border-gray-100 mt-12">
      <div className="flex flex-col gap-16">
        <h2 className="text-3xl font-serif text-primary-dark">Clinical Feedback & Reviews</h2>
        
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-16">
          {/* Scorecard */}
          <div className="bg-surface-container-low rounded-[2rem] p-10 flex flex-col gap-8 shadow-sm border border-border-custom">
            <div className="flex flex-col items-center gap-2">
              <span className="text-7xl font-serif text-primary-dark font-bold">{rating}</span>
              <div className="flex gap-1 text-accent">
                {[...Array(5)].map((_, i) => <Star key={i} size={24} fill="currentColor" stroke="none" />)}
              </div>
              <p className="text-sm text-gray-500 font-bold uppercase tracking-widest mt-2">Based on {reviewsCount} Reviews</p>
            </div>

            <div className="flex flex-col gap-3">
              {STAR_DISTRIBUTION.map((row) => (
                <div key={row.stars} className="flex items-center gap-4">
                  <span className="text-xs font-bold text-gray-400 w-4">{row.stars}</span>
                  <div className="flex-1 h-1.5 bg-gray-100 rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-primary" 
                      style={{ width: `${row.percentage}%` }}
                    ></div>
                  </div>
                  <span className="text-xs font-bold text-gray-400 w-8">{row.percentage}%</span>
                </div>
              ))}
            </div>
          </div>

          {/* Individual Reviews */}
          <div className="lg:col-span-2 flex flex-col gap-12">
            {REVIEWS.map((review, index) => (
              <div key={index} className="flex flex-col gap-5 pb-10 border-b border-gray-100 last:border-0 group">
                <div className="flex items-center justify-between">
                  <div className="flex gap-1 text-primary">
                    {[...Array(review.rating)].map((_, i) => <Star key={i} size={16} fill="currentColor" stroke="none" />)}
                  </div>
                  <span className="text-xs text-gray-400 font-bold">{review.date}</span>
                </div>
                
                <div className="flex flex-col gap-2">
                  <h4 className="text-xl font-bold text-primary-dark group-hover:text-primary transition-colors">{review.title}</h4>
                  <p className="text-gray-600 leading-relaxed italic">&ldquo;{review.content}&rdquo;</p>
                </div>

                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary text-xs font-bold">
                    {review.user[0]}
                  </div>
                  <div>
                    <p className="text-sm font-bold text-primary-dark">{review.user}</p>
                    <p className="text-[10px] text-accent font-bold uppercase tracking-widest">{review.status}</p>
                  </div>
                </div>
              </div>
            ))}
            
            <button className="text-primary-dark font-bold text-sm uppercase tracking-[0.2em] py-5 border border-primary/20 rounded-2xl hover:bg-primary/5 transition-all w-full mt-4">
              Read All {reviewsCount} Reviews
            </button>
          </div>
        </div>
      </div>
    </section>
  );
};

export default ProductReviews;
