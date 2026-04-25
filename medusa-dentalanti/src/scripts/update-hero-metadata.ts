import { ExecArgs } from "@medusajs/framework/types";
import {
  Modules,
  ProductStatus,
} from "@medusajs/framework/utils";
import {
  createProductsWorkflow,
} from "@medusajs/medusa/core-flows";

export default async function updateHeroData({ container }: ExecArgs) {
  const logger = container.resolve("logger");
  const regionModule = container.resolve(Modules.REGION);
  const salesChannelModule = container.resolve(Modules.SALES_CHANNEL);

  logger.info("Updating Hero Metadata...");

  // 1. Update Region Metadata
  const [region] = await regionModule.listRegions({ name: "Middle East" });
  if (region) {
    await regionModule.updateRegions({
      id: region.id,
      metadata: {
        ...region.metadata,
        hero_title: "Smile Brighter,\nEvery Single Day",
        hero_subtitle: "Curated professional dental solutions delivered to your doorstep. Experience the gold standard of oral hygiene in the UAE.",
        hero_image_url: "https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb"
      }
    });
    logger.info("Region metadata updated.");
  }

  // 2. Create Sonicare 9900 Product if it doesn't exist
  const productModule = container.resolve(Modules.PRODUCT);
  const [existing] = await productModule.listProducts({ handle: "sonicare-9900" });

  if (!existing) {
    logger.info("Creating Sonicare 9900...");
    const [salesChannel] = await salesChannelModule.listSalesChannels({ name: "Default Sales Channel" });
    
    await createProductsWorkflow(container).run({
      input: {
        products: [
          {
            title: "Sonicare Prestige 9900",
            handle: "sonicare-9900",
            subtitle: "Philips Sonicare",
            description: "Our most advanced electric toothbrush yet. Senses your brushing style and adapts in real-time.",
            status: ProductStatus.PUBLISHED,
            images: [
              { url: "https://lh3.googleusercontent.com/aida/ADBb0ujhg6XcViiOJWfNFXFt5ZK8drfuYHWrTxxr8mmggNIPI09rya-gnHhaQGz_-K0IZ4pp6wb84V_NBcIh2g96fHzroIXWd3xCNhmD4kv9jU3eCJEwfFIFG1V0LCqlb5l3kDNK7PKdVpMcjW_Vvxe58gDmjrcp_gzbyCqN6J44VuumTRu1G041LBfWx30Sk3Za6K_-MGX5tvsYkcHzASBO6dVzE_aSLE_Plw2OQPq1NfyNLzGmITJhZl25H19G" }
            ],
            options: [{ title: "Color", values: ["Midnight Blue"] }],
            variants: [
              {
                title: "Midnight Blue",
                sku: "SONICARE-9900-BLU",
                options: { Color: "Midnight Blue" },
                prices: [
                  { amount: 1349, currency_code: "aed" }
                ],
                manage_inventory: false
              }
            ],
            sales_channels: [{ id: salesChannel.id }]
          }
        ]
      }
    });
    logger.info("Sonicare 9900 created.");
  } else {
    logger.info("Sonicare 9900 already exists.");
  }
}
