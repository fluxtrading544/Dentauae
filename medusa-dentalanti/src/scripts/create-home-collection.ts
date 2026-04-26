import { ExecArgs } from "@medusajs/framework/types";

export default async function createHomeCollection({ container }: ExecArgs) {
  const logger = container.resolve("logger");
  logger.info("createHomeCollection script is temporarily disabled to fix build errors.");
}
