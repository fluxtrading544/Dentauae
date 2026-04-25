export interface Deal {
  id: string;
  title: string;
  description: string;
  discountTag: string;
  expiryDate: string;
  image: string;
  category: string;
  slug: string;
  isBundle: boolean;
}

export const DEALS: Deal[] = [
  {
    id: "deal-1",
    title: "The Complete Clean",
    description: "A holistic clinical ritual featuring our Sonic Pro, Charcoal Floss, and Hydro-Paste.",
    discountTag: "Save 25%",
    expiryDate: "Clinic Exclusive",
    image: "https://images.unsplash.com/photo-1628177142898-93e36e4e3a40?auto=format&fit=crop&q=80&w=600",
    category: "Featured Bundle",
    slug: "the-complete-clean",
    isBundle: true
  },
  {
    id: "deal-2",
    title: "Luminous Glow Kit",
    description: "Professional grade whitening technology designed for sensitive enamels. 14-day supply.",
    discountTag: "Member pricing",
    expiryDate: "Limited availability",
    image: "https://images.unsplash.com/photo-1559287734-d4b967962ed1?auto=format&fit=crop&q=80&w=600",
    category: "Whitening",
    slug: "luminous-glow-kit",
    isBundle: true
  },
  {
    id: "deal-3",
    title: "Signature Bamboo Brush",
    description: "Eco-conscious innovation meeting clinical standards. 3 for 2 on all varieties.",
    discountTag: "3 for 2",
    expiryDate: "Summer Offer",
    image: "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?auto=format&fit=crop&q=80&w=600",
    category: "DentaElite",
    slug: "bamboo-brush-deal",
    isBundle: false
  }
];

export const BRAND_OFFERS = [
  { brand: "Oral-B", offer: "Up to 25% Off Professional Series" },
  { brand: "Philips Sonicare", offer: "Exclusive Member Pricing" },
  { brand: "Curaprox", offer: "3 for 2 on Ultra Soft Range" }
];
