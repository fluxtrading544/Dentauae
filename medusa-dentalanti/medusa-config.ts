import { loadEnv, defineConfig } from '@medusajs/framework/utils'
import path from 'path'

loadEnv(process.env.NODE_ENV || 'development', process.cwd())

// S3_ENDPOINT is the canonical var name (legacy S3_URL still accepted for local dev)
const s3Endpoint = process.env.S3_ENDPOINT || process.env.S3_URL

// Redis URL – docker-compose injects this; falls back to local for dev
const redisUrl = process.env.REDIS_URL || "redis://localhost:6379"

// ── Admin outDir (CRITICAL FIX) ───────────────────────────────────────────────
// `medusa start` does process.chdir(".medusa/server/") before calling the admin
// loader, so process.cwd() is "/app/.medusa/server/" at runtime — NOT "/app/".
// The default outDir calculation: path.join(cwd, ".medusa/server/public")
// becomes /app/.medusa/server/.medusa/server/public  ← DOES NOT EXIST → crash!
//
// Fix: hardcode the absolute path where medusa build actually puts the admin UI.
// __dirname in compiled medusa-config.js = /app/.medusa/server/
// so path.join(__dirname, "public") = /app/.medusa/server/public  ✅
const adminOutDir = path.join(__dirname, "public")

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
        // secure: false so cookies work over HTTP in the Docker internal network
        // and in development. HTTPS enforcement is handled by Nginx in production.
        session_cookie: {
          sameSite: "lax",
          secure: true,
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
