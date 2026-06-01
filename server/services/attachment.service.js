const { Attachment } = require("../models");
const { Profile } = require("../models");

const uploadToS3 = require("../utils/s3Upload");

exports.createMany = async (
  attachableType,
  attachableId,
  files,
  fileType = "image",
  photoType = null
) => {

  // Upload all files to S3
  const uploadedRows = await Promise.all(

    files.map(async (file) => {

      // Upload file to S3
      const s3Url = await uploadToS3(file);

      return {
        attachable_type: attachableType,
        attachable_id: attachableId,

        file_type: fileType,

        file_name: file.originalname,

        // Store S3 URL instead of local path
        file_url: s3Url,

        mime_type: file.mimetype,

        file_size: file.size,

        category: photoType || null
      };
    })
  );

  // Save records into database
  const attached = await Attachment.bulkCreate(uploadedRows);

  // Update profile picture if needed
  if (photoType === "profile_main") {

    await Profile.update(
      { profilePictureId: attached[0].id },
      { where: { id: attachableId } }
    );
  }

  return attached;
};

exports.findByAttachable = (
  attachableType,
  attachableId,
  fileType = null
) => {

  const where = {
    attachable_type: attachableType,
    attachable_id: attachableId
  };

  if (fileType) {
    where.file_type = fileType;
  }

  return Attachment.findAll({ where });
};

exports.remove = async (id) => {

  const attachment = await Attachment.findByPk(id);

  if (!attachment) return null;

  const usedAsProfile = await Profile.findOne({
    where: { profilePictureId: id }
  });

  if (usedAsProfile) {
    throw new Error("Cannot delete profile picture");
  }

  await attachment.destroy();

  return attachment;
};