const multer = require("multer");

// Store uploaded file temporarily in RAM (memory)
const storage = multer.memoryStorage();

// Multer instance
const upload = multer({
  storage,

  limits: {
    fileSize: 10 * 1024 * 1024 // 10 MB per file
  },

  fileFilter: (req, file, cb) => {

    // Allow only image files
    if (!file.mimetype.startsWith("image/")) {

      return cb(
        new Error("Only image files are allowed"),
        false
      );
    }

    cb(null, true);
  }
});

module.exports = upload;