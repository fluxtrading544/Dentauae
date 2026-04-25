import { ExecArgs } from "@medusajs/framework/types";
import { Modules } from "@medusajs/framework/utils";

export default async function debugProductModule({ container }: ExecArgs) {
  const productModule = container.resolve(Modules.PRODUCT);
  console.log("Product Module Methods:", Object.keys(productModule));
}
