"use client";

import Image, { ImageProps } from "next/image";
import { useState } from "react";

const FALLBACK = "/images/placeholder-product.svg";

/**
 * Drop-in replacement for next/image that silently swaps to a local
 * placeholder when the upstream URL returns 403/404 (e.g. Google-hosted
 * AI-generated images that block the Next.js image-optimization proxy).
 */
export const SafeImage = ({ src, alt, onError, ...props }: ImageProps) => {
  const [imgSrc, setImgSrc] = useState(src);

  return (
    <Image
      {...props}
      src={imgSrc}
      alt={alt}
      onError={(e) => {
        setImgSrc(FALLBACK);
        onError?.(e);
      }}
    />
  );
};
