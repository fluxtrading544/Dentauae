import { sdk } from "@/lib/medusa";
import { HttpTypes } from "@medusajs/types";

/**
 * Logs in a customer using email and password.
 */
export async function loginCustomer(credentials: any) {
  try {
    const token = await sdk.auth.login("customer", "emailpass", credentials);
    if (typeof token !== "string") {
      throw new Error("Authentication requires additional steps");
    }
    const { customer } = await sdk.store.customer.retrieve();
    return customer;
  } catch (error) {
    console.error("Login failed:", error);
    throw error;
  }
}

/**
 * Registers a new customer.
 */
export async function registerCustomer(data: any) {
  try {
    // 1. Register with Identity
    await sdk.auth.register("customer", "emailpass", {
      email: data.email,
      password: data.password!,
    });

    // 2. Create the customer profile in the store
    const { customer } = await sdk.store.customer.create(data);
    return customer;
  } catch (error) {
    console.error("Registration failed:", error);
    throw error;
  }
}

/**
 * Retrieves the currently authenticated customer.
 */
export async function getCustomer() {
  try {
    const { customer } = await sdk.store.customer.retrieve();
    return customer;
  } catch {
    // Not logged in is a common case, don't flood logs
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
 * Fetches order history for the current customer.
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
