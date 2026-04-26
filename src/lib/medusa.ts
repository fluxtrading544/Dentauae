import Medusa from "@medusajs/js-sdk";

// Initialize the Medusa SDK Client.
// This is the global singleton we will use to fetch data from the server.
const MEDUSA_BACKEND_URL = process.env.NEXT_PUBLIC_MEDUSA_BACKEND_URL || "http://localhost:9000";

export const sdk = new Medusa({
  baseUrl: MEDUSA_BACKEND_URL,
  debug: process.env.NODE_ENV === "development",
  publishableKey: process.env.NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY,
  auth: {
    type: "session",
  },
  globalHeaders: {
    "bypass-tunnel-reminder": "true",
  },
});
