import { CreateInventoryLevelInput, ExecArgs } from "@medusajs/framework/types";
import {
  ContainerRegistrationKeys,
  Modules,
  ProductStatus,
} from "@medusajs/framework/utils";
import {
  createWorkflow,
  transform,
  WorkflowResponse,
} from "@medusajs/framework/workflows-sdk";
import {
  createApiKeysWorkflow,
  createInventoryLevelsWorkflow,
  createProductCategoriesWorkflow,
  createProductsWorkflow,
  createRegionsWorkflow,
  createSalesChannelsWorkflow,
  createShippingOptionsWorkflow,
  createShippingProfilesWorkflow,
  createStockLocationsWorkflow,
  createTaxRegionsWorkflow,
  linkSalesChannelsToApiKeyWorkflow,
  linkSalesChannelsToStockLocationWorkflow,
  updateStoresStep,
  updateStoresWorkflow,
} from "@medusajs/medusa/core-flows";
import { ApiKey } from "../../.medusa/types/query-entry-points";

const updateStoreCurrencies = createWorkflow(
  "update-store-currencies",
  (input: {
    supported_currencies: { currency_code: string; is_default?: boolean }[];
    store_id: string;
  }) => {
    const normalizedInput = transform({ input }, (data) => {
      return {
        selector: { id: data.input.store_id },
        update: {
          supported_currencies: data.input.supported_currencies.map(
            (currency) => {
              return {
                currency_code: currency.currency_code,
                is_default: currency.is_default ?? false,
              };
            }
          ),
        },
      };
    });

    const stores = updateStoresStep(normalizedInput);

    return new WorkflowResponse(stores);
  }
);

export default async function seedDemoData({ container }: ExecArgs) {
  const logger = container.resolve(ContainerRegistrationKeys.LOGGER);
  const link = container.resolve(ContainerRegistrationKeys.LINK);
  const query = container.resolve(ContainerRegistrationKeys.QUERY);
  const fulfillmentModuleService = container.resolve(Modules.FULFILLMENT);
  const salesChannelModuleService = container.resolve(Modules.SALES_CHANNEL);
  const storeModuleService = container.resolve(Modules.STORE);

  const countries = ["ae", "sa", "om", "kw", "bh", "qa"]; // GCC Region

  logger.info("Seeding store data...");
  const [store] = await storeModuleService.listStores();
  let defaultSalesChannel = await salesChannelModuleService.listSalesChannels({
    name: "Default Sales Channel",
  });

  if (!defaultSalesChannel.length) {
    const { result: salesChannelResult } = await createSalesChannelsWorkflow(
      container
    ).run({
      input: {
        salesChannelsData: [
          {
            name: "Default Sales Channel",
          },
        ],
      },
    });
    defaultSalesChannel = salesChannelResult;
  }

  await updateStoreCurrencies(container).run({
    input: {
      store_id: store.id,
      supported_currencies: [
        {
          currency_code: "aed",
          is_default: true,
        },
        {
          currency_code: "usd",
        },
      ],
    },
  });

  await updateStoresWorkflow(container).run({
    input: {
      selector: { id: store.id },
      update: {
        default_sales_channel_id: defaultSalesChannel[0].id,
      },
    },
  });
  logger.info("Seeding region data...");
  const { result: regionResult } = await createRegionsWorkflow(container).run({
    input: {
      regions: [
        {
          name: "Middle East",
          currency_code: "aed",
          countries,
          payment_providers: ["pp_system_default"],
        },
      ],
    },
  });
  const region = regionResult[0];
  logger.info("Finished seeding regions.");

  logger.info("Seeding tax regions...");
  await createTaxRegionsWorkflow(container).run({
    input: countries.map((country_code) => ({
      country_code,
      provider_id: "tp_system",
    })),
  });
  logger.info("Finished seeding tax regions.");

  logger.info("Seeding stock location data...");
  const { result: stockLocationResult } = await createStockLocationsWorkflow(
    container
  ).run({
    input: {
      locations: [
        {
          name: "Dubai Warehouse",
          address: {
            city: "Dubai",
            country_code: "AE",
            address_1: "Al Quoz Industrial Area 3",
          },
        },
      ],
    },
  });
  const stockLocation = stockLocationResult[0];

  await updateStoresWorkflow(container).run({
    input: {
      selector: { id: store.id },
      update: {
        default_location_id: stockLocation.id,
      },
    },
  });

  await link.create({
    [Modules.STOCK_LOCATION]: {
      stock_location_id: stockLocation.id,
    },
    [Modules.FULFILLMENT]: {
      fulfillment_provider_id: "manual_manual",
    },
  });

  logger.info("Seeding fulfillment data...");
  const shippingProfiles = await fulfillmentModuleService.listShippingProfiles({
    type: "default",
  });
  let shippingProfile = shippingProfiles.length ? shippingProfiles[0] : null;

  if (!shippingProfile) {
    const { result: shippingProfileResult } =
      await createShippingProfilesWorkflow(container).run({
        input: {
          data: [
            {
              name: "Default Shipping Profile",
              type: "default",
            },
          ],
        },
      });
    shippingProfile = shippingProfileResult[0];
  }

  const fulfillmentSet = await fulfillmentModuleService.createFulfillmentSets({
    name: "Dubai Warehouse delivery",
    type: "shipping",
    service_zones: [
      {
        name: "Middle East",
        geo_zones: [
          { country_code: "ae", type: "country" },
          { country_code: "sa", type: "country" },
        ],
      },
    ],
  });

  await link.create({
    [Modules.STOCK_LOCATION]: {
      stock_location_id: stockLocation.id,
    },
    [Modules.FULFILLMENT]: {
      fulfillment_set_id: fulfillmentSet.id,
    },
  });

  await createShippingOptionsWorkflow(container).run({
    input: [
      {
        name: "Standard Shipping",
        price_type: "flat",
        provider_id: "manual_manual",
        service_zone_id: fulfillmentSet.service_zones[0].id,
        shipping_profile_id: shippingProfile.id,
        type: {
          label: "Standard",
          description: "Ship in 2-3 days.",
          code: "standard",
        },
        prices: [
          { currency_code: "aed", amount: 20 },
          { region_id: region.id, amount: 20 },
        ],
        rules: [
          { attribute: "enabled_in_store", value: "true", operator: "eq" },
          { attribute: "is_return", value: "false", operator: "eq" },
        ],
      },
      {
        name: "Express Delivery",
        price_type: "flat",
        provider_id: "manual_manual",
        service_zone_id: fulfillmentSet.service_zones[0].id,
        shipping_profile_id: shippingProfile.id,
        type: {
          label: "Express",
          description: "Same Day Delivery (Dubai Only)",
          code: "express",
        },
        prices: [
          { currency_code: "aed", amount: 50 },
          { region_id: region.id, amount: 50 },
        ],
        rules: [
          { attribute: "enabled_in_store", value: "true", operator: "eq" },
          { attribute: "is_return", value: "false", operator: "eq" },
        ],
      },
      {
        name: "Free Clinical Shipping",
        price_type: "flat",
        provider_id: "manual_manual",
        service_zone_id: fulfillmentSet.service_zones[0].id,
        shipping_profile_id: shippingProfile.id,
        type: {
          label: "Free",
          description: "Free shipping for orders over AED 99",
          code: "free",
        },
        prices: [
          { currency_code: "aed", amount: 0 },
          { region_id: region.id, amount: 0 },
        ],
        rules: [
          { attribute: "enabled_in_store", value: "true", operator: "eq" },
          { attribute: "is_return", value: "false", operator: "eq" },
        ],
      }
    ],
  });
  logger.info("Finished seeding fulfillment data.");

  await linkSalesChannelsToStockLocationWorkflow(container).run({
    input: {
      id: stockLocation.id,
      add: [defaultSalesChannel[0].id],
    },
  });

  logger.info("Seeding publishable API key data...");
  let publishableApiKey: ApiKey | null = null;
  const { data } = await query.graph({
    entity: "api_key",
    fields: ["id"],
    filters: {
      type: "publishable",
    },
  });

  publishableApiKey = data?.[0];

  if (!publishableApiKey) {
    const {
      result: [publishableApiKeyResult],
    } = await createApiKeysWorkflow(container).run({
      input: {
        api_keys: [
          {
            title: "Webshop",
            type: "publishable",
            created_by: "",
          },
        ],
      },
    });

    publishableApiKey = publishableApiKeyResult as ApiKey;
  }

  await linkSalesChannelsToApiKeyWorkflow(container).run({
    input: {
      id: publishableApiKey.id,
      add: [defaultSalesChannel[0].id],
    },
  });
  logger.info("Finished seeding publishable API key data.");

  logger.info("Seeding product data (DentaUAE Catalog)...");

  const { result: categoryResult } = await createProductCategoriesWorkflow(
    container
  ).run({
    input: {
      product_categories: [
        { name: "Electric Brushes", is_active: true },
        { name: "Replacement Heads", is_active: true },
        { name: "Floss & Interdental", is_active: true },
      ],
    },
  });

  await createProductsWorkflow(container).run({
    input: {
      products: [
        {
          title: "Oral-B iO Series 9",
          category_ids: [categoryResult.find((cat) => cat.name === "Electric Brushes")!.id],
          description: "The Oral-B iO Series 9 combines powerful but gentle micro-vibrations with Oral-B's unique dentist-inspired round brush head design for a professional clean feeling every day.",
          handle: "io-9",
          weight: 400,
          status: ProductStatus.PUBLISHED,
          shipping_profile_id: shippingProfile.id,
          images: [
            { url: "https://lh3.googleusercontent.com/aida/ADBb0uhlAUaHF0QszhpYsAb2NwGtJKsDpMxykb5wkfRoij7HoPj-zFCasuwUw4vQdeN0waHT3RnL8fSYXaQK8jf9tWd5zQx3OGKABzQGufZ0gErXn1uY2ADm5iXp_f-HedmRq1clyWWfBdONv8Esw5BSNAzycPBi853uoMqh5XWWf35wpBFWLV9FS1MmBoTvJVGSuCP1ryDy5wy-FGZEz3-epVis_Hc-fPqdjIpqKWeJAFYhSKmV23i7u3fBxLWD" }
          ],
          options: [
            { title: "Color", values: ["Onyx Black", "Rose Quartz", "Alabaster White"] },
          ],
          variants: [
            {
              title: "Onyx Black",
              sku: "IO-9-BLK",
              options: { Color: "Onyx Black" },
              prices: [{ amount: 899, currency_code: "aed" }, { amount: 245, currency_code: "usd" }],
              manage_inventory: true,
              allow_backorder: false,
            },
            {
              title: "Rose Quartz",
              sku: "IO-9-PNK",
              options: { Color: "Rose Quartz" },
              prices: [{ amount: 899, currency_code: "aed" }, { amount: 245, currency_code: "usd" }],
              manage_inventory: true,
              allow_backorder: false,
            },
            {
              title: "Alabaster White",
              sku: "IO-9-WHT",
              options: { Color: "Alabaster White" },
              prices: [{ amount: 899, currency_code: "aed" }, { amount: 245, currency_code: "usd" }],
              manage_inventory: true,
              allow_backorder: false,
            },
          ],
          sales_channels: [{ id: defaultSalesChannel[0].id }],
        },
        {
          title: "iO Series 7 White",
          category_ids: [categoryResult.find((cat) => cat.name === "Electric Brushes")!.id],
          description: "Advanced clean with interactive display. Features 5 Smart Modes and a Pressure Sensor.",
          handle: "io-7",
          weight: 350,
          status: ProductStatus.PUBLISHED,
          shipping_profile_id: shippingProfile.id,
          images: [
            { url: "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatshirt-vintage-front.png" } // Temp fallback
          ],
          options: [
            { title: "Color", values: ["White"] },
          ],
          variants: [
            {
              title: "White",
              sku: "IO-7-WHT",
              options: { Color: "White" },
              prices: [{ amount: 649, currency_code: "aed" }, { amount: 175, currency_code: "usd" }],
              manage_inventory: true,
              allow_backorder: false,
            },
          ],
          sales_channels: [{ id: defaultSalesChannel[0].id }],
        },
        {
          title: "iO Gentle Care Heads (4ct)",
          category_ids: [categoryResult.find((cat) => cat.name === "Replacement Heads")!.id],
          description: "Gentle cleaning for sensitive gums. Compatible with all iO handles.",
          handle: "io-heads",
          weight: 100,
          status: ProductStatus.PUBLISHED,
          shipping_profile_id: shippingProfile.id,
          images: [
            { url: "https://medusa-public-images.s3.eu-west-1.amazonaws.com/sweatpants-gray-front.png" } // Temp fallback
          ],
          options: [
            { title: "Pack Size", values: ["4 Count"] },
          ],
          variants: [
            {
              title: "4 Count Pack",
              sku: "IO-HEADS-4CT",
              options: { "Pack Size": "4 Count" },
              prices: [{ amount: 185, currency_code: "aed" }, { amount: 50, currency_code: "usd" }],
              manage_inventory: true,
              allow_backorder: true,
            },
          ],
          sales_channels: [{ id: defaultSalesChannel[0].id }],
        },
      ],
    },
  });

  logger.info("Finished seeding product data (DentaUAE Catalog).");

  logger.info("Seeding inventory levels...");
  
  const inventoryModule = container.resolve(Modules.INVENTORY);
  const inventoryItems = await inventoryModule.listInventoryItems({});
  const inventoryLevels: CreateInventoryLevelInput[] = [];

  for (const item of inventoryItems) {
    inventoryLevels.push({
      location_id: stockLocation.id,
      inventory_item_id: item.id,
      stocked_quantity: 100, // Seed 100 units of each variant
    });
  }

  await createInventoryLevelsWorkflow(container).run({
    input: { inventory_levels: inventoryLevels },
  });

  logger.info("Finished seeding inventory levels.");
}
