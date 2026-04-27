export interface Product {
  id: string;
  variantId?: string;
  name: string;
  brand: string;
  price: number;
  description: string;
  features: string[];
  image: string;
  images?: string[];
  reviews: number;
  rating: number;
  category: string;
  variants?: {
    id: string;
    title: string;
    sku: string;
    price: number;
    image?: string;
    thumbnail?: string;
    options: Record<string, string>;
  }[];
  options?: {
    id: string;
    title: string;
    values: string[];
  }[];
  promos?: {
    code: string;
    label: string;
    discount: string;
  }[];
  couponTimer?: string;
  techSpecs?: Record<string, string | number | boolean>;
  // Raw Medusa category IDs — used for server-side related-products filtering
  categoryIds?: string[];
}

export const PRODUCTS: Product[] = [
  {
    id: "io-9",
    name: "Oral-B iO Series 9",
    brand: "Oral-B",
    price: 899.00,
    description: "The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.",
    features: [
      "3D Teeth Tracking with A.I. to monitor your brushing",
      "7 Smart Brushing Modes for personalized cleaning",
      "Interactive Color Display for real-time coaching"
    ],
    image: "https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD",
    reviews: 128,
    rating: 4.8,
    category: "Electric Brushes"
  },
  {
    id: "io-7",
    name: "iO Series 7 White",
    brand: "Oral-B",
    price: 649.00,
    description: "Advanced clean with interactive display.",
    features: ["5 Smart Modes", "Pressure Sensor"],
    image: "/images/io7.jpg",
    reviews: 85,
    rating: 4.6,
    category: "Electric Brushes"
  },
  {
    id: "io-heads",
    name: "iO Gentle Care Heads (4ct)",
    brand: "Oral-B",
    price: 185.00,
    description: "Gentle cleaning for sensitive gums.",
    features: ["Soft bristles", "Compatibility with all iO handles"],
    image: "/images/heads.jpg",
    reviews: 42,
    rating: 4.9,
    category: "Replacement Heads"
  }
];

export const CATEGORIES = [
  "Electric Brushes",
  "Manual Brushes",
  "Floss & Interdental",
  "Mouthwash",
  "Whitening",
  "Kids"
];

export const BRANDS = [
  "Oral-B",
  "Philips Sonicare",
  "Waterpik",
  "Curaprox",
  "Marvis"
];
