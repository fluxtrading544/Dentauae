import { ExecArgs } from "@medusajs/framework/types";

import { 
  createProductCollectionsWorkflow,
  updateProductCollectionsWorkflow,
  updateProductsWorkflow 
} from "@medusajs/medusa/core-flows";

export default async function createHomeCollection({ container }: ExecArgs) {
  const logger = container.resolve("logger");
  const query = container.resolve("query");

  logger.info("Creating Home Page Collection via Workflows...");

  // 1. Find Collection
  const { data: collections } = await query.graph({
    entity: "product_collection",
    fields: ["id", "handle"],
    filters: { handle: "home-page" }
  });

  const heroMetadata = {
    hero_title: "Smile Brighter,\nEvery Single Day",
    hero_subtitle: "Curated professional dental solutions delivered to your doorstep. Experience the gold standard of oral hygiene in the UAE.",
    hero_image_url: "https://lh3.googleusercontent.com/aida/ADBb0uiE-ozOqwpi0w-26G3Qg0zLr_2rlTjRSfjslrnklBTKUwBdy92UdQmDdym3D8516b18WxslpgFyJdQg7na8CO9ct99YPiGuhPkW61KpS_BPv7ZlOUjrfXuK1t9jN4xbPYPAmLegLGRoRMTFFcCkblpIYPUcLpmz8qIpl4ddCysSrwmxBbpIyeuVftuJkJ23eYjv8kutoNPetqHrSANDYuoP6c5pfm_da8zZ5vGEnG07BXuSsBqcz9TCpTQb"
  };

  let collectionId;

  if (collections.length === 0) {
    const { result } = await createProductCollectionsWorkflow(container).run({
      input: {
        product_collections: [
          {
            title: "Home Page",
            handle: "home-page",
            metadata: heroMetadata
          }
        ]
      }
    });
    collectionId = result[0].id;
    logger.info(`Collection created: ${collectionId}`);
  } else {
    collectionId = collections[0].id;
    await updateProductCollectionsWorkflow(container).run({
      input: {
        selector: { id: collectionId },
        update: { metadata: heroMetadata }
      }
    });
    logger.info(`Collection updated: ${collectionId}`);
  }

  // 2. Link Products
  const { data: products } = await query.graph({
    entity: "product",
    fields: ["id", "handle"],
    filters: { handle: ["io-9", "sonicare-9900"] }
  });

  if (products.length > 0) {
    await updateProductsWorkflow(container).run({
      input: {
        selector: { id: products.map(p => p.id) },
        update: { collection_id: collectionId }
      }
    });
    logger.info(`Linked ${products.length} products to Home Page collection.`);
  }
}
