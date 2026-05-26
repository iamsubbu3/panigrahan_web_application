const express = require("express");
const router = express.Router();
const { requireAuth } = require("../middlewares/auth.middleware");
const gothraController = require("../controllers/gothras.controller");

router.get("/", requireAuth, gothraController.getAllGothras);
router.post("/", requireAuth, gothraController.createGothra);
router.put("/:id", requireAuth, gothraController.updateGothra);

module.exports = router;