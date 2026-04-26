import { defineMiddlewares } from "@medusajs/framework/http"
import type { MedusaRequest, MedusaResponse, MedusaNextFunction } from "@medusajs/framework/http"

export default defineMiddlewares({
  routes: [
    {
      matcher: "/app*",
      middlewares: [
        (req: MedusaRequest, res: MedusaResponse, next: MedusaNextFunction) => {
          res.setHeader("Content-Security-Policy", "default-src 'self' 'unsafe-inline' 'unsafe-eval' http://localhost:9000; script-src 'self' 'unsafe-inline' 'unsafe-eval' http://localhost:9000; connect-src 'self' http://localhost:9000 ws://localhost:*; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:;")
          next()
        }
      ],
    },
  ],
})
