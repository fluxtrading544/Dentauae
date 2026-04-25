export interface DentalBrand {
  id: string;
  name: string;
  slug: string;
  logo: string;
  description: string;
  specialty: string;
  isAuthorized: boolean;
  integrityScore: number;
}

export const DENTAL_BRANDS: DentalBrand[] = [
  {
    id: "brand-1",
    name: "Oral-B",
    slug: "oral-b",
    logo: "https://images.unsplash.com/photo-1628177142898-93e36e4e3a40?auto=format&fit=crop&q=80&w=400",
    description: "Global leader in professional-grade electric toothbrushes and intelligent oral health tracking technology.",
    specialty: "Smart Oscillating Technology",
    isAuthorized: true,
    integrityScore: 100
  },
  {
    id: "brand-2",
    name: "Philips Sonicare",
    slug: "philips-sonicare",
    logo: "https://images.unsplash.com/photo-1559287734-d4b967962ed1?auto=format&fit=crop&q=80&w=400",
    description: "Pioneers of sonic vibration technology with clinical studies proving superior plaque removal in hard-to-reach areas.",
    specialty: "Sonic Vibrational Drive",
    isAuthorized: true,
    integrityScore: 100
  },
  {
    id: "brand-3",
    name: "Waterpik",
    slug: "waterpik",
    logo: "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?auto=format&fit=crop&q=80&w=400",
    description: "The gold standard in water flossing, recommended by periodontists worldwide for gingival health.",
    specialty: "Water Pressure Hydro-Technology",
    isAuthorized: true,
    integrityScore: 100
  },
  {
    id: "brand-4",
    name: "Colgate Professional",
    slug: "colgate-professional",
    logo: "https://images.unsplash.com/photo-1628177142898-93e36e4e3a40?auto=format&fit=crop&q=80&w=400",
    description: "Science-backed fluoride treatments and professional-grade pastes for long-term enamel fortification.",
    specialty: "Enamel Restoration",
    isAuthorized: true,
    integrityScore: 100
  }
];
