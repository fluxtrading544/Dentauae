import { ExecArgs } from "@medusajs/framework/types";

export default async function updateHeroMetadata({ container }: ExecArgs) {
  const logger = container.resolve("logger");
  logger.info("updateHeroMetadata script is temporarily disabled to fix build errors.");
}
