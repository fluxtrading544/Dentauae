import { ContactPageClient } from "./ContactPageClient";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Contact & Support | DentaUAE",
  description: "Get in touch with DentaUAE for professional clinical support, order tracking, and dental wellness inquiries.",
};

export default function ContactPage() {
  return (
    <main className="bg-white min-h-screen">
      <ContactPageClient />
    </main>
  );
}
