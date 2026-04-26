import { loadEnv, defineConfig } from '@medusajs/framework/utils'

loadEnv(process.env.NODE_ENV || 'development', process.cwd())

module.exports = defineConfig({
  projectConfig: {
    databaseUrl: process.env.DATABASE_URL,
    http: {
      storeCors: process.env.STORE_CORS!,
      adminCors: process.env.ADMIN_CORS!,
      authCors: process.env.AUTH_CORS!,
      jwtSecret: process.env.JWT_SECRET,
      cookieSecret: process.env.COOKIE_SECRET,
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
                  endpoint: process.env.S3_URL,
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
    path: "/admin",
    backendUrl: process.env.MEDUSA_BACKEND_URL || "http://localhost:9000",
  },
})
