import { loadEnv, defineConfig } from '@medusajs/framework/utils'

loadEnv(process.env.NODE_ENV || 'development', process.cwd())

// S3_ENDPOINT is the canonical env var name (also accepts legacy S3_URL for local dev)
const s3Endpoint = process.env.S3_ENDPOINT || process.env.S3_URL

// Redis URL (provided by docker-compose in production, local .env in dev)
const redisUrl = process.env.REDIS_URL || "redis://localhost:6379"

module.exports = defineConfig({
  projectConfig: {
    databaseUrl: process.env.DATABASE_URL,
    // Wire up Redis so Medusa uses a real cache/queue instead of the fake in-memory fallback
    redisUrl,
    workerMode: "shared",
    http: {
      storeCors: process.env.STORE_CORS!,
      adminCors: process.env.ADMIN_CORS!,
      authCors: process.env.AUTH_CORS!,
      jwtSecret: process.env.JWT_SECRET || "supersecret",
      cookieSecret: process.env.COOKIE_SECRET || "supersecret",
      cookieSecure: false,
    }
  },
  modules: [
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
                // FIX: Accept both S3_ENDPOINT (production) and legacy S3_URL (local dev)
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
    backendUrl: process.env.MEDUSA_BACKEND_URL || "http://api.dentauae.com:9000",
  },
})
