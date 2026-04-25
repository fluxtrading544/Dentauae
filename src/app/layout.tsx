import type { Metadata } from "next";
import { Noto_Serif, Plus_Jakarta_Sans } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/layout/Navbar";
import Footer from "@/components/layout/Footer";
import CartInitializer from "@/components/cart/CartInitializer";
import { JsonLd } from "@/components/seo/JsonLd";

const notoSerif = Noto_Serif({
  variable: "--font-noto-serif",
  subsets: ["latin"],
});

const plusJakartaSans = Plus_Jakarta_Sans({
  variable: "--font-plus-jakarta-sans",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "DentaUAE | Premium Oral Care & Dental Wellness",
  description: "Experience The Clinical Atelier - your premium destination for professional oral care and clinical dental products in the UAE.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const orgSchema = {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "DentaUAE",
    "url": "https://dentauae.com",
    "logo": "https://dentauae.com/logo.png",
    "contactPoint": {
      "@type": "ContactPoint",
      "telephone": "+971-4-123-4567",
      "contactType": "customer service",
      "areaServed": "AE",
      "availableLanguage": ["en", "Arabic"]
    },
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "Al Quoz Industrial Area 3",
      "addressLocality": "Dubai",
      "addressRegion": "Dubai",
      "postalCode": "00000",
      "addressCountry": "AE"
    },
    "sameAs": [
      "https://www.instagram.com/dentauae",
      "https://www.facebook.com/dentauae"
    ]
  };

  return (
    <html
      lang="en"
      className={`${notoSerif.variable} ${plusJakartaSans.variable} h-full antialiased`}
    >
      <head>
        <JsonLd data={orgSchema} />
      </head>
      <body className="min-h-full flex flex-col font-sans">
        <CartInitializer />
        <Navbar />
        <main className="flex-1 pt-[7.5rem]">
          {children}
        </main>
        <Footer />
      </body>
    </html>
  );
}
