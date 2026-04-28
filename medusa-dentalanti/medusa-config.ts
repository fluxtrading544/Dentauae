import { loadEnv, defineConfig } from '@medusajs/framework/utils'
import path from 'path'

loadEnv(process.env.NODE_ENV || 'development', process.cwd())

// S3_ENDPOINT is the canonical var name (legacy S3_URL still accepted for local dev)
const s3Endpoint = process.env.S3_ENDPOINT || process.env.S3_URL

// Redis URL – docker-compose injects this; falls back to local for dev
const redisUrl = process.env.REDIS_URL || "redis://localhost:6379"

// ── Admin outDir (DEFINITIVE FIX) ────────────────────────────────────────────
// medusa build ALWAYS emits admin files to: {publicDir}/admin/
// Proof from docker build log tree:
//   /app/.medusa/server/public/admin/assets/
//   /app/.medusa/server/public/admin/index.html   ← actual location
//
// The admin-bundler serve() checks: path.resolve(outDir, "index.html")
// So outDir must point to the admin/ subdirectory, not the parent.
//
// WRONG: "/app/.medusa/server/public"        → checks /public/index.html  ✗
// RIGHT: "/app/.medusa/server/public/admin"  → checks /public/admin/index.html ✓
const adminOutDir = "/app/.medusa/server/public/admin"

module.exports = defineConfig({
  projectConfig: {
    databaseUrl: process.env.DATABASE_URL,
    redisUrl,
    workerMode: "shared",
    http: {
      storeCors: process.env.STORE_CORS!,
      adminCors: process.env.ADMIN_CORS!,
      authCors: process.env.AUTH_CORS!,
      jwtSecret: process.env.JWT_SECRET || "dentauae_super_secret_123",
      cookieSecret: process.env.COOKIE_SECRET || "dentauae_super_secret_123",
    }
  },
  modules: [
    {
      resolve: "@medusajs/medusa/auth",
      options: {
        providers: [
          {
            resolve: "@medusajs/medusa/auth-emailpass",
            id: "emailpass",
            options: {},
          },
        ],
        // secure: false — Nginx terminates TLS and forwards HTTP internally.
        // The backend sees an HTTP connection so "secure: true" prevents session
        // cookies from being set (express/koa honours req.secure before writing Secure).
        // HTTPS is enforced at the Nginx layer — setting secure: false here is safe.
        session_cookie: {
          sameSite: "lax",
          secure: false,
        },
      },
    },
    {
      resolve: "@medusajs/medusa/payment",
      options: {
        providers: [
          {
            resolve: "@medusajs/payment-stripe",
            id: "stripe",
            options: {
              apiKey: process.env.STRIPE_API_KEY,
              webhookSecret: process.env.STRIPE_WEBHOOK_SECRET,
            },
          },
        ],
      },
    },
    {
      resolve: "@medusajs/medusa/file",
      options: {
        providers: [
          process.env.S3_BUCKET
            ? {
              resolve: "./src/modules/file/providers/s3-webp",
              id: "s3",
              options: {
                file_url: process.env.S3_FILE_URL || `https://${process.env.S3_BUCKET}.r2.dev`,
                access_key_id: process.env.S3_ACCESS_KEY_ID,
                secret_access_key: process.env.S3_SECRET_ACCESS_KEY,
                region: process.env.S3_REGION || "auto",
                bucket: process.env.S3_BUCKET,
                endpoint: s3Endpoint,
              },
            }
            : {
              resolve: "@medusajs/file-local",
              id: "local",
              options: {
                upload_dir: "uploads/images",
                backend_url: process.env.MEDUSA_BACKEND_URL || "http://localhost:9000",
              },
            },
        ],
      },
    },
  ],
  admin: {
    disable: false,
    backendUrl: process.env.MEDUSA_BACKEND_URL || "https://api.dentauae.com",
    // CRITICAL: explicit absolute outDir so the admin bundler always finds
    // index.html regardless of what process.cwd() is at startup time.
    outDir: adminOutDir,
  },
})
