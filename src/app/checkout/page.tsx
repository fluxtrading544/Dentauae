import { CheckoutClient } from "./CheckoutClient";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Secure Checkout | DentaUAE",
  description: "Complete your premium dental care order.",
};

export default function CheckoutPage() {
  return (
    <main className="bg-white min-h-screen">
      <CheckoutClient />
    </main>
  );
}
