import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { Product } from './mock-data';
import { createCart, retrieveCart, addToCart, updateLineItem, deleteLineItem } from './data/cart';
import { getRegionAe } from './data/products';
import { HttpTypes } from '@medusajs/types';

export interface CartItem extends Product {
  quantity: number;
  lineId?: string; // ID from Medusa line item for easy mapping
}

interface CartStore {
  items: CartItem[];
  cartId: string | null;
  regionId: string | null;
  isLoading: boolean;
  
  // Checkout State
  shippingMethods: HttpTypes.StoreFulfillmentOption[];
  selectedShippingOptionId: string | null;
  selectedShippingMethod: HttpTypes.StoreFulfillmentOption | null;
  checkoutEmail: string;
  shippingAddress: Partial<HttpTypes.StoreCartAddress> | null;

  // Auth State
  customer: HttpTypes.StoreCustomer | null;
  
  // Actions
  initializeCart: () => Promise<void>;
  addItem: (product: Product, quantity?: number) => Promise<void>;
  removeItem: (lineId: string) => Promise<void>;
  updateQuantity: (lineId: string, quantity: number) => Promise<void>;
  clearCart: () => void;
  getCartTotal: () => number;
  getCartCount: () => number;
  syncWithMedusa: (medusaCart: HttpTypes.StoreCart) => void;
  
  // Auth Actions
  fetchCustomer: () => Promise<void>;
  login: (credentials: HttpTypes.StoreAuthEmailPassword) => Promise<void>;
  logout: () => Promise<void>;
  
  // Checkout Actions
  updateCheckoutData: (email: string, address: Partial<HttpTypes.StoreCartAddress>) => Promise<void>;
  fetchShippingMethods: () => Promise<void>;
  setShippingOption: (optionId: string) => Promise<void>;
  initPayment: (providerId: string) => Promise<HttpTypes.StorePaymentCollection | undefined>;
  finalizeCheckout: () => Promise<HttpTypes.StoreOrder | null>;
}

export const useCartStore = create<CartStore>()(
  persist(
    (set, get) => ({
      items: [],
      cartId: null,
      regionId: null,
      isLoading: false,
      shippingMethods: [],
      selectedShippingOptionId: null,
      selectedShippingMethod: null,
      checkoutEmail: "",
      shippingAddress: null,
      customer: null,

      syncWithMedusa: (medusaCart: HttpTypes.StoreCart) => {
        if (!medusaCart || !medusaCart.items) return;
        
        const mappedItems: CartItem[] = medusaCart.items.map((item: HttpTypes.StoreCartLineItem) => {
          let brand = (item as Record<string, unknown>).product_subtitle || "Professional Selection";
          if (brand.toLowerCase().includes("imported from amazon")) {
            // Attempt to get brand from metadata if it's passed in the line item
            brand = (item.metadata as Record<string, unknown>)?.tech_specs?.[("Brand" as string)] || "Professional Selection";
          }

          return {
            id: item.product_handle || item.variant_id, // Map back to our handle-based ID
            variantId: item.variant_id,
            lineId: item.id,
            name: item.title,
            brand,
            price: item.unit_price,
            description: "", // Descriptions are usually not in line items
            features: [],
            image: item.thumbnail || "",
            reviews: 128,
            rating: 4.8,
            category: "",
            quantity: item.quantity,
          };
        });

        set({ items: mappedItems, cartId: medusaCart.id });
      },

      initializeCart: async () => {
        const { cartId, syncWithMedusa, fetchCustomer } = get();
        set({ isLoading: true });
        
        try {
          // Attempt to hydrate customer/auth first
          await fetchCustomer();

          const region = await getRegionAe();
          if (!region?.id) throw new Error("Could not fetch region");
          
          const regionId = region.id;
          set({ regionId });

          let cart;
          if (cartId) {
            cart = await retrieveCart(cartId);
          }

          if (!cart) {
            cart = await createCart(regionId);
          }

          if (cart) {
            syncWithMedusa(cart);
          }
        } catch (error) {
          console.error("Store init failed:", error);
        } finally {
          set({ isLoading: false });
        }
      },
      
      addItem: async (product: Product, quantity: number = 1) => {
        const { cartId, initializeCart, syncWithMedusa } = get();
        
        let currentCartId = cartId;
        if (!currentCartId) {
          await initializeCart();
          currentCartId = get().cartId;
        }

        if (!currentCartId || !product.variantId) return;

        set({ isLoading: true });
        const cart = await addToCart({
          cartId: currentCartId,
          variantId: product.variantId,
          quantity
        });

        if (cart) syncWithMedusa(cart);
        set({ isLoading: false });
      },

      removeItem: async (lineId: string) => {
        const { items, cartId, syncWithMedusa } = get();
        if (!cartId || !lineId) return;

        // Optimistic update
        set({ 
          items: items.filter(i => i.lineId !== lineId),
          isLoading: true 
        });

        try {
          const cart = await deleteLineItem(cartId, lineId);
          if (cart) syncWithMedusa(cart);
        } catch (error) {
          console.error("Remove item failed:", error);
          // Revert or refresh
          const { initializeCart } = get();
          await initializeCart();
        } finally {
          set({ isLoading: false });
        }
      },

      updateQuantity: async (lineId: string, quantity: number) => {
        const { items, cartId, syncWithMedusa, removeItem } = get();

        if (quantity <= 0) {
          await removeItem(lineId);
          return;
        }

        if (!cartId || !lineId) return;

        // Optimistic update
        set({
          items: items.map(i => i.lineId === lineId ? { ...i, quantity } : i),
          isLoading: true
        });

        try {
          const cart = await updateLineItem(cartId, lineId, quantity);
          if (cart) syncWithMedusa(cart);
        } catch (error) {
          console.error("Update quantity failed:", error);
          const { initializeCart } = get();
          await initializeCart();
        } finally {
          set({ isLoading: false });
        }
      },

      clearCart: () => set({ items: [], cartId: null }),

      getCartTotal: () => {
        const { items } = get();
        return items.reduce((total, item) => total + (item.price * item.quantity), 0);
      },

      getCartCount: () => {
        const { items } = get();
        return items.reduce((count, item) => count + item.quantity, 0);
      },

      // Checkout Implementation
      updateCheckoutData: async (email: string, address: Partial<HttpTypes.StoreCartAddress>) => {
        const { cartId } = get();
        if (!cartId) return;

        set({ isLoading: true, checkoutEmail: email, shippingAddress: address });
        try {
          const { updateCart } = await import('./data/cart');
          const cart = await updateCart(cartId, {
            email,
            shipping_address: address,
            billing_address: address, // Assume same for now
          });
          if (cart) get().syncWithMedusa(cart);
        } catch (error) {
          console.error("Update checkout data failed:", error);
        } finally {
          set({ isLoading: false });
        }
      },

      fetchShippingMethods: async () => {
        const { cartId } = get();
        if (!cartId) return;

        set({ isLoading: true });
        try {
          const { listCartShippingMethods } = await import('./data/cart');
          const methods = await listCartShippingMethods(cartId);
          set({ shippingMethods: methods || [] });
        } catch (error) {
          console.error("Fetch shipping methods failed:", error);
        } finally {
          set({ isLoading: false });
        }
      },

      setShippingOption: async (optionId: string) => {
        const { cartId, shippingMethods } = get();
        if (!cartId) return;

        const method = shippingMethods.find(m => m.id === optionId);
        set({ isLoading: true, selectedShippingOptionId: optionId, selectedShippingMethod: method });
        
        try {
          const { addCartShippingMethod } = await import('./data/cart');
          const cart = await addCartShippingMethod(cartId, optionId);
          if (cart) get().syncWithMedusa(cart);
        } catch (error) {
          console.error("Set shipping option failed:", error);
        } finally {
          set({ isLoading: false });
        }
      },

      initPayment: async (providerId: string) => {
        const { cartId } = get();
        if (!cartId) return;

        set({ isLoading: true });
        try {
          const { retrieveCart, createPaymentSession } = await import('./data/cart');
          const cart = await retrieveCart(cartId);
          if (!cart) throw new Error("Cart not found");

          const payment_collection = await createPaymentSession(cart, providerId);
          return payment_collection;
        } catch (error) {
          console.error("Init payment failed:", error);
          throw error;
        } finally {
          set({ isLoading: false });
        }
      },

      finalizeCheckout: async () => {
        const { cartId, clearCart } = get();
        if (!cartId) return;

        set({ isLoading: true });
        try {
          const { completeCart } = await import('./data/cart');
          const result = await completeCart(cartId);
          
          if (result.type === "order" || result.order) {
            clearCart();
            return result.order as HttpTypes.StoreOrder;
          }
          return null;
        } catch (error) {
          console.error("Finalize checkout failed:", error);
          throw error;
        } finally {
          set({ isLoading: false });
        }
      },

      // Auth Implementation
      fetchCustomer: async () => {
        const { getCustomer } = await import('./data/customer');
        const customer = await getCustomer();
        set({ customer });
      },

      login: async (credentials: HttpTypes.StoreAuthEmailPassword) => {
        const { loginCustomer } = await import('./data/customer');
        set({ isLoading: true });
        try {
          const customer = await loginCustomer(credentials);
          set({ customer });
        } finally {
          set({ isLoading: false });
        }
      },

      logout: async () => {
        const { logoutCustomer } = await import('./data/customer');
        await logoutCustomer();
        set({ customer: null });
      },
    }),
    {
      name: 'dentauae-cart-storage',
      // Only persist basic cart info, not transient checkout state
      partialize: (state) => ({ 
        items: state.items, 
        cartId: state.cartId, 
        regionId: state.regionId 
      }),
    }
  )
);
