import { defineMiddlewares } from "@medusajs/framework/http"
import type { MedusaRequest, MedusaResponse, MedusaNextFunction } from "@medusajs/framework/http"

// FIX: Read backend URL from the environment so CSP works in both dev and production.
// Old code had http://localhost:9000 hardcoded — this blocked all admin panel scripts
// and API connections when running on the production VPS (api.dentauae.com).
const backendUrl = process.env.MEDUSA_BACKEND_URL || "http://localhost:9000"

function buildAdminCSP(): string {
  const extraOrigins: string[] = []

  // In production, backendUrl is https://api.dentauae.com — always include it.
  // In dev, backendUrl is already http://localhost:9000 so no extra entry needed.
  if (backendUrl !== "http://localhost:9000") {
    extraOrigins.push(backendUrl)
  }

  const origins = `'self' http://localhost:9000 ${extraOrigins.join(" ")}`.trim()

  return [
    `default-src 'self' 'unsafe-inline' 'unsafe-eval' ${origins}`,
    `script-src 'self' 'unsafe-inline' 'unsafe-eval' ${origins}`,
    `connect-src 'self' ${origins} ws://localhost:* wss://localhost:*`,
    `style-src 'self' 'unsafe-inline'`,
    `img-src 'self' data: https: blob:`,
    `font-src 'self' data:`,
  ].join("; ")
}

export default defineMiddlewares({
  routes: [
    {
      matcher: "/app*",
      middlewares: [
        (req: MedusaRequest, res: MedusaResponse, next: MedusaNextFunction) => {
          res.setHeader("Content-Security-Policy", buildAdminCSP())
          next()
        }
      ],
    },
  ],
})
