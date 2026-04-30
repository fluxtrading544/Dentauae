import { defineMiddlewares } from "@medusajs/framework/http"
import type { MedusaRequest, MedusaResponse, MedusaNextFunction } from "@medusajs/framework/http"

const backendUrl = process.env.MEDUSA_BACKEND_URL || "http://localhost:9000"

function buildAdminCSP(): string {
  const extraOrigins: string[] = []

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
      matcher: "/*",
      middlewares: [
        (req: MedusaRequest, res: MedusaResponse, next: MedusaNextFunction) => {
          // Force Express to recognize the request as secure (HTTPS) when behind a proxy
          // This is critical for Medusa v2 to set the session cookie with `Secure: true`
          if (process.env.NODE_ENV === "production" || backendUrl.includes("https")) {
            // Access the underlying express app to set trust proxy
            // This is the most reliable way to handle Nginx/Cloudflare SSL termination
            if (req.app) {
              req.app.set("trust proxy", true)
            }
            req.headers["x-forwarded-proto"] = "https"
          }
          next()
        }
      ],
    },
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

