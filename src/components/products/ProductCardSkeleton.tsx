export const ProductCardSkeleton = () => {
  return (
    <div className="flex flex-col gap-6 animate-pulse">
      {/* Image Skeleton */}
      <div className="aspect-[4/5] bg-gray-100 rounded-[2rem] w-full" />
      
      <div className="flex flex-col gap-3 px-2">
        {/* Category/Brand Skeleton */}
        <div className="h-3 bg-gray-100 rounded w-1/3" />
        
        {/* Title Skeleton */}
        <div className="h-6 bg-gray-100 rounded w-full" />
        
        {/* Price Skeleton */}
        <div className="h-5 bg-gray-100 rounded w-1/4 mt-2" />
      </div>
    </div>
  );
};
