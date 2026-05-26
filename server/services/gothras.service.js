const db = require("../models");

const Gothras = db.gothras;
//console.log(db.gothras);

exports.getAllGothras = async () => {
  try {
    const gothras = await Gothras.findAll({
      attributes: ["id", "gothraname", "gothrarushi", "gothranum", "aliases"],
      order: [["gothraname", "ASC"]],
    });
    return gothras;
  } catch (error) {
    throw error;
  }
};

exports.createGothra = async (data) => {
  return Gothras.create({
    gothraname:  data.gothraname,
    gothrarushi: data.gothrarushi || null,
    gothranum:   data.gothranum   || null,
    aliases:     data.aliases?.length > 0 ? data.aliases : null,
  });
};

exports.updateGothra = async (id, data) => {
  const gothra = await Gothras.findByPk(id);
  if (!gothra) throw new Error("Gothra not found");
  return gothra.update({
    gothraname:  data.gothraname,
    gothrarushi: data.gothrarushi || data.gothraname || null,
    gothranum:   data.gothranum   || null,
    aliases:     data.aliases     || [],
  }, {
    fields: ["gothraname", "gothrarushi", "gothranum", "aliases"]
  });
};