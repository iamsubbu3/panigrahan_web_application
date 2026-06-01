const {
  S3Client,
  PutObjectCommand
} = require("@aws-sdk/client-s3");

const crypto = require("crypto");

const s3 = new S3Client({
  region: process.env.AWS_REGION
});

const uploadToS3 = async (file) => {

  // Create unique filename
  const uniqueName =
    Date.now() +
    "-" +
    crypto.randomBytes(4).toString("hex") +
    "-" +
    file.originalname;

  const params = {
    Bucket: "panigrahan-tf-and-logs-backup",

    // uploads/ folder in S3
    Key: `uploads/${uniqueName}`,

    // File buffer from multer memoryStorage
    Body: file.buffer,

    // Content type
    ContentType: file.mimetype
  };

  // Upload to S3
  await s3.send(
    new PutObjectCommand(params)
  );

  // Return uploaded file URL
  return `https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/${uniqueName}`;
};

module.exports = uploadToS3;