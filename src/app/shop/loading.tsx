import { ProductCardSkeleton } from "@/components/products/ProductCardSkeleton";

export default function ShopLoading() {
  return (
    <div className="flex flex-col gap-8 lg:gap-10">
      {/* 1. Hero Skeleton */}
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 pt-0">
        <div className="w-full h-[400px] bg-gray-100 rounded-[3rem] animate-pulse"></div>
      </div>

      {/* 2. Category Tabs Skeleton */}
      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 flex justify-center">
        <div className="flex gap-4">
          {[1, 2, 3, 4].map(i => (
            <div key={i} className="w-32 h-12 bg-gray-100 rounded-full animate-pulse"></div>
          ))}
        </div>
      </div>

      <div className="max-w-7xl mx-auto w-full px-4 lg:px-8 pb-32">
        {/* 3. Main Content Row Skeleton */}
        <div className="flex flex-col lg:flex-row gap-12 items-start mt-12">
          
          {/* Sidebar Skeleton */}
          <div className="w-full lg:w-72 flex flex-col gap-8">
            {[1, 2, 3].map(i => (
              <div key={i} className="flex flex-col gap-4">
                <div className="w-24 h-4 bg-gray-100 rounded animate-pulse"></div>
                <div className="w-full h-8 bg-gray-50 rounded animate-pulse"></div>
                <div className="w-full h-8 bg-gray-50 rounded animate-pulse"></div>
              </div>
            ))}
          </div>

          {/* Product Feed Skeleton */}
          <div className="flex-1 w-full scale-100">
            <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
              {[1, 2, 3, 4, 5, 6].map(i => (
                <div key={i} className="aspect-[4/5] bg-gray-50 rounded-2xl animate-pulse flex flex-col p-6 gap-4">
                   <div className="w-full h-2/3 bg-white rounded-xl"></div>
                   <div className="w-1/2 h-4 bg-gray-200 rounded"></div>
                   <div className="w-full h-8 bg-gray-200 rounded"></div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
