import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";
import { 
  FileTypes, 
  Logger, 
  S3FileServiceOptions 
} from "@medusajs/framework/types";
import { 
  AbstractFileProviderService, 
  MedusaError, 
  ModuleProvider, 
  Modules 
} from "@medusajs/framework/utils";
import sharp from "sharp";
import { ulid } from "ulid";
import path from "path";

class S3WebpProviderService extends AbstractFileProviderService {
  static identifier = "s3-webp";
  protected config_: any;
  protected logger_: Logger;
  protected client_: S3Client;

  constructor({ logger }: { logger: Logger }, options: S3FileServiceOptions) {
    super();
    this.logger_ = logger;
    this.config_ = {
      fileUrl: options.file_url,
      accessKeyId: options.access_key_id,
      secretAccessKey: options.secret_access_key,
      region: "auto",
      bucket: options.bucket,
      prefix: options.prefix ?? "",
      endpoint: options.endpoint,
      cacheControl: options.cache_control ?? "public, max-age=31536000",
    };

    this.client_ = new S3Client({
      endpoint: this.config_.endpoint,
      region: this.config_.region,
      credentials: {
        accessKeyId: this.config_.accessKeyId,
        secretAccessKey: this.config_.secretAccessKey,
      },
      forcePathStyle: true,
    });
  }

  async upload(file: FileTypes.ProviderUploadFileDTO): Promise<FileTypes.ProviderFileResultDTO> {
    if (!file) throw new MedusaError(MedusaError.Types.INVALID_DATA, "No file provided");

    let inputBuffer: Buffer;
    try {
      inputBuffer = Buffer.from(file.content, "base64");
    } catch {
      inputBuffer = Buffer.from(file.content, "binary");
    }

    let finalContent: Buffer;
    let finalMimeType = file.mimeType;
    let finalFilename = file.filename;

    if (finalMimeType?.startsWith("image/") && finalMimeType !== "image/webp") {
      try {
        finalContent = await sharp(inputBuffer).webp({ quality: 85 }).toBuffer();
        finalMimeType = "image/webp";
        finalFilename = finalFilename.replace(/\.[^/.]+$/, "") + ".webp";
      } catch (e) {
        finalContent = inputBuffer;
      }
    } else {
      finalContent = inputBuffer;
    }

    const fileKey = `${this.config_.prefix}${path.parse(finalFilename).name}-${ulid()}${path.parse(finalFilename).ext}`;

    try {
      this.logger_.info(`Attempting R2 Upload: ${fileKey} (${finalMimeType})`);
      
      // 1. Generate a pre-signed URL
      const command = new PutObjectCommand({
        Bucket: this.config_.bucket,
        Key: fileKey,
        ContentType: finalMimeType,
        CacheControl: this.config_.cacheControl,
      });

      const signedUrl = await getSignedUrl(this.client_, command, { expiresIn: 3600 });

      // 2. Perform the upload using native Node.js fetch (v20+)
      // This is the cleanest way to handle modern TLS handshakes
      const uploadResponse = await fetch(signedUrl, {
        method: "PUT",
        body: finalContent as any,
        headers: {
          "Content-Type": finalMimeType,
        },
      });

      if (!uploadResponse.ok) {
        const errorText = await uploadResponse.text();
        throw new Error(`R2 Server Error (${uploadResponse.status}): ${errorText}`);
      }

      this.logger_.info(`Successfully uploaded to R2: ${fileKey}`);

      return {
        url: `${this.config_.fileUrl}/${fileKey}`,
        key: fileKey,
      };
    } catch (error) {
      this.logger_.error(`R2 Upload Exception: ${error.message}`);
      throw error;
    }
  }

  async delete(files: any): Promise<void> {}
  async getPresignedDownloadUrl(fileData: any): Promise<string> { return "" }
  async getDownloadStream(fileData: any): Promise<any> { return null }
}

export default ModuleProvider(Modules.FILE, {
  services: [S3WebpProviderService],
});
