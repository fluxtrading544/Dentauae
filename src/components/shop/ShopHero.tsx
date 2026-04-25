import Image from "next/image";

export const ShopHero = ({ title, description, image }: { title: string, description: string, image: string }) => {
  return (
    <section className="w-full min-h-[280px] relative overflow-hidden bg-[#E8F5F1] rounded-2xl lg:rounded-[3rem] p-8 lg:p-12 flex flex-col items-start justify-center shadow-sm border border-white/50">
      <div className="w-full lg:w-[60%] flex flex-col gap-3 relative z-10">
        <h1 className="text-3xl lg:text-4xl font-serif font-bold text-primary-dark tracking-tight leading-tight">
          {title}
        </h1>
        <p className="text-gray-500 text-xs lg:text-sm leading-relaxed max-w-[340px]">
          {description}
        </p>
      </div>
      
      <div className="absolute right-0 bottom-0 w-full lg:w-[40%] h-full flex items-center justify-end p-4">
        <div className="relative w-[90%] h-[90%]">
          <Image 
            src={image} 
            alt="Category Hero" 
            fill 
            className="object-contain drop-shadow-xl" 
            priority
          />
        </div>
      </div>
    </section>
  );
};
