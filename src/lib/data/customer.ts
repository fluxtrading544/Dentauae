import { sdk } from "@/lib/medusa";

/**
 * Logs in a customer using email and password.
 */
export async function loginCustomer(credentials: { email: string; password: string }) {
  try {
    const token = await sdk.auth.login("customer", "emailpass", credentials);
    if (typeof token !== "string") {
      throw new Error("Authentication requires additional steps (e.g. 2FA)");
    }
    const { customer } = await sdk.store.customer.retrieve();
    return customer;
  } catch (error) {
    console.error("Login failed:", error);
    throw error;
  }
}

/**
 * Registers a new customer and automatically logs them in.
 *
 * FIX: The old implementation called sdk.auth.register then sdk.store.customer.create
 * but never logged the user in. After registration the user had to manually log in,
 * which is unexpected UX and left the auth state in an inconsistent half-created state.
 * Now we: register identity → log in to get a session → create the customer profile.
 */
export async function registerCustomer(data: {
  email: string;
  password: string;
  first_name?: string;
  last_name?: string;
  phone?: string;
}) {
  try {
    // 1. Register the identity (creates credentials but no session yet)
    await sdk.auth.register("customer", "emailpass", {
      email: data.email,
      password: data.password,
    });

    // 2. Log in immediately to establish a session
    const token = await sdk.auth.login("customer", "emailpass", {
      email: data.email,
      password: data.password,
    });
    if (typeof token !== "string") {
      throw new Error("Login after registration failed — unexpected token type");
    }

    // 3. Create the customer profile now that we have a session
    const { customer } = await sdk.store.customer.create({
      email: data.email,
      first_name: data.first_name,
      last_name: data.last_name,
      phone: data.phone,
    });

    return customer;
  } catch (error) {
    console.error("Registration failed:", error);
    throw error;
  }
}

/**
 * Retrieves the currently authenticated customer.
 * Returns null if not logged in (normal case — not an error).
 */
export async function getCustomer() {
  try {
    const { customer } = await sdk.store.customer.retrieve();
    return customer;
  } catch {
    return null;
  }
}

/**
 * Logs out the current customer.
 */
export async function logoutCustomer() {
  try {
    await sdk.auth.logout();
  } catch (error) {
    console.error("Logout failed:", error);
  }
}

/**
 * Fetches paginated order history for the current customer.
 */
export async function listCustomerOrders(limit = 10, offset = 0) {
  try {
    const { orders, count } = await sdk.store.order.list({
      limit,
      offset,
      fields: "*items,+status,+fulfillment_status,+payment_status",
    });
    return { orders, count };
  } catch (error) {
    console.error("Failed to fetch orders:", error);
    return { orders: [], count: 0 };
  }
}
