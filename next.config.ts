import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Standalone output creates a minimal self-contained build for Docker.
  // Eliminates the need to copy the huge node_modules folder into the image.
  output: "standalone",

  images: {
    remotePatterns: [
      // Google AI-generated images (hero / brand sections)
      {
        protocol: "https",
        hostname: "lh3.googleusercontent.com",
      },
      // Medusa public S3 bucket
      {
        protocol: "https",
        hostname: "medusa-public-images.s3.eu-west-1.amazonaws.com",
      },
      // Amazon product images
      {
        protocol: "https",
        hostname: "*.media-amazon.com",
      },
      {
        protocol: "https",
        hostname: "*.images-amazon.com",
      },
      {
        protocol: "https",
        hostname: "images-na.ssl-images-amazon.com",
      },
      // Unsplash
      {
        protocol: "https",
        hostname: "images.unsplash.com",
      },
      // Cloudflare R2 – public dev subdomain
      {
        protocol: "https",
        hostname: "*.r2.dev",
      },
      // FIX: Cloudflare R2 – S3-compatible custom endpoint used in production
      // Was missing: all uploaded product images rendered as broken in production
      {
        protocol: "https",
        hostname: "*.r2.cloudflarestorage.com",
      },
    ],
  },
};

export default nextConfig;
