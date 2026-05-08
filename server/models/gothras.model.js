module.exports = (sequelize, DataTypes) => {
  const gothra = sequelize.define("gothra", {
    id: {
        type: DataTypes.BIGINT,
        autoIncrement: true,
        primaryKey: true
      },

      gothraname: {
        type: DataTypes.STRING(30),
      },

      gothrarushi: {
        type: DataTypes.STRING(40),
      },

      gothranum: {
        type: DataTypes.TINYINT.UNSIGNED,
      },
  },
  {
    tableName: "gothra",
    timestamps: false,
  }
  );

  return gothra;
};
