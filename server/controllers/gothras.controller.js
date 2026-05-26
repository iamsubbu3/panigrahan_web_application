const gothraService = require("../services/gothras.service");

exports.getAllGothras = async (req, res) => {
  try {
    const gothra = await gothraService.getAllGothras();
    res.status(200).json(gothra);
  } catch (error) {
    console.error("Error fetching gothras:", error);
    res.status(500).json({
      message: "Failed to fetch gothras"
    });
  }
};

exports.createGothra = async (req, res) => {
  try {
    const gothra = await gothraService.createGothra(req.body);
    res.status(201).json(gothra);
  } catch (error) {
    console.error("Error creating gothra:", error);
    res.status(500).json({
      message: "Failed to create gothra"
    });
  }
};

exports.updateGothra = async (req, res) => {
  try {
    const gothra = await gothraService.updateGothra(req.params.id, req.body);
    res.status(200).json(gothra);
  } catch (error) {
    console.error("Error updating gothra:", error);
    res.status(500).json({
      message: "Failed to update gothra"
    });
  }
};