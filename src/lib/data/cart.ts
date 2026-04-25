import { sdk } from "@/lib/medusa";
import { HttpTypes } from "@medusajs/types";

/**
 * Cart Service Abstractions for Medusa V2
 * These methods will eventually replace the local Zustand cart persistence.
 */

export async function createCart(regionId: string | { id: string }) {
  try {
    // Robust check: extract ID if a region object was passed
    const id = typeof regionId === "string" ? regionId : regionId?.id;
    
    if (!id) throw new Error("A valid region_id string is required to create a cart");

    const { cart } = await sdk.store.cart.create({
      region_id: id,
    });
    return cart;
  } catch (error) {
    console.error("Failed to create Medusa cart:", error);
    return null;
  }
}

export async function retrieveCart(cartId: string) {
  try {
    const { cart } = await sdk.store.cart.retrieve(cartId, {
      fields: "*items,*region",
    });
    return cart;
  } catch (error) {
    console.error("Failed to retrieve Medusa cart:", error);
    return null;
  }
}

export async function addToCart({
  cartId,
  variantId,
  quantity,
}: {
  cartId: string;
  variantId: string;
  quantity: number;
}) {
  try {
    const { cart } = await sdk.store.cart.createLineItem(cartId, {
      variant_id: variantId,
      quantity,
    });
    return cart;
  } catch (error) {
    console.error("Failed to add to Medusa cart:", error);
    return null;
  }
}

export async function updateLineItem(cartId: string, lineId: string, quantity: number) {
  try {
    const { cart } = await sdk.store.cart.updateLineItem(cartId, lineId, {
      quantity,
    });
    return cart;
  } catch (error) {
    console.error("Failed to update Medusa cart item:", error);
    return null;
  }
}

export async function deleteLineItem(cartId: string, lineId: string) {
  try {
    const { cart } = await sdk.store.cart.deleteLineItem(cartId, lineId);
    return cart;
  } catch (error) {
    console.error("Failed to delete Medusa cart item:", error);
    return null;
  }
}

// --- Checkout Pipeline API ---

export async function updateCart(cartId: string, data: { 
  email?: string; 
  shipping_address?: HttpTypes.StoreCartAddress; 
  billing_address?: HttpTypes.StoreCartAddress;
}) {
  const { cart } = await sdk.store.cart.update(cartId, data);
  return cart;
}

export async function listCartShippingMethods(cartId: string) {
  const { shipping_options } = await sdk.store.fulfillment.listCartOptions({ cart_id: cartId });
  return shipping_options;
}

export async function addCartShippingMethod(cartId: string, optionId: string) {
  const { cart } = await sdk.store.cart.addShippingMethod(cartId, { option_id: optionId });
  return cart;
}

export async function createPaymentSession(cart: HttpTypes.StoreCart, providerId: string) {
  const { payment_collection } = await sdk.store.payment.initiatePaymentSession(cart, {
    provider_id: providerId,
  });
  return payment_collection;
}

export async function completeCart(cartId: string) {
  return await sdk.store.cart.complete(cartId);
}
