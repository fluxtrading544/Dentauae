import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
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
      region: options.region,
      bucket: options.bucket,
      prefix: options.prefix ?? "",
      endpoint: options.endpoint,
      cacheControl: options.cache_control ?? "public, max-age=31536000",
    };

    this.client_ = new S3Client({
      credentials: {
        accessKeyId: this.config_.accessKeyId,
        secretAccessKey: this.config_.secretAccessKey,
      },
      region: this.config_.region,
      endpoint: this.config_.endpoint,
    });
  }

  async upload(file: FileTypes.ProviderUploadFileDTO): Promise<FileTypes.ProviderFileResultDTO> {
    if (!file) throw new MedusaError(MedusaError.Types.INVALID_DATA, "No file provided");

    let inputBuffer: Buffer;
    try {
      const decoded = Buffer.from(file.content, "base64");
      if (decoded.toString("base64") === file.content) {
        inputBuffer = decoded;
      } else {
        inputBuffer = Buffer.from(file.content, "utf8");
      }
    } catch {
      inputBuffer = Buffer.from(file.content, "binary");
    }

    let finalContent: Buffer;
    let finalMimeType = file.mimeType;
    let finalFilename = file.filename;

    // 1. Check if the file is an image and not already webp
    if (finalMimeType?.startsWith("image/") && finalMimeType !== "image/webp") {
      try {
        // 2. Convert to WebP using sharp
        const webpBuffer = await sharp(inputBuffer)
          .webp({ quality: 85, effort: 4 })
          .toBuffer();
        
        finalContent = webpBuffer;
        finalMimeType = "image/webp";
        // 3. Change extension to .webp
        finalFilename = finalFilename.replace(/\.[^/.]+$/, "") + ".webp";
        
        this.logger_.info(`Optimized image ${file.filename} to WebP`);
      } catch (e) {
        this.logger_.error(`WebP conversion failed for ${file.filename}: ${e.message}`);
        finalContent = inputBuffer;
      }
    } else {
      finalContent = inputBuffer;
    }

    const parsedFilename = path.parse(finalFilename);
    const fileKey = `${this.config_.prefix}${parsedFilename.name}-${ulid()}${parsedFilename.ext}`;

    const command = new PutObjectCommand({
      Bucket: this.config_.bucket,
      Body: finalContent,
      Key: fileKey,
      ContentType: finalMimeType,
      ACL: "public-read",
      CacheControl: this.config_.cacheControl,
    });

    await this.client_.send(command);

    return {
      url: `${this.config_.fileUrl}/${fileKey}`,
      key: fileKey,
    };
  }

  // Necessary method overrides
  async delete(files: any): Promise<void> {
    // We could implement delete here if needed, but for now we focus on upload
  }

  async getPresignedDownloadUrl(fileData: any): Promise<string> { return "" }
  async getDownloadStream(fileData: any): Promise<any> { return null }
}

// In Medusa v2, we must export the provider using ModuleProvider
export default ModuleProvider(Modules.FILE, {
  services: [S3WebpProviderService],
});
