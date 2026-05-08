module.exports = (sequelize, DataTypes) => {
  const Profile = sequelize.define(
    "Profile",
    {
      id: {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        autoIncrement: true
      },

      firstname: DataTypes.STRING(100),
      lastname: DataTypes.STRING(100),
      middlei: DataTypes.STRING(50),
      familyname: DataTypes.STRING(100),
      nameaddlinfo: DataTypes.STRING(255),

      current_address_id: { type: DataTypes.INTEGER.UNSIGNED, allowNull: true },
      permanent_address_id: { type: DataTypes.INTEGER.UNSIGNED, allowNull: true },
      work_address_id: { type: DataTypes.INTEGER.UNSIGNED, allowNull: true },

      gender: DataTypes.TINYINT.UNSIGNED,

      birthdate: DataTypes.DATEONLY,
      birthtime: DataTypes.TIME,
      birthstar: DataTypes.STRING(50),
      starpada: DataTypes.TINYINT.UNSIGNED,
      birthrasi: DataTypes.STRING(50),
      birthplace: DataTypes.STRING(100),
      birthdist: DataTypes.STRING(100),
      birthstate: DataTypes.STRING(100),
      birthcountry: DataTypes.STRING(100),

      height: DataTypes.DECIMAL(5, 2),
      // height_feet: DataTypes.TINYINT.UNSIGNED,
      // height_inches: DataTypes.TINYINT.UNSIGNED,
      weight: DataTypes.DECIMAL(5, 2),
      color: DataTypes.TINYINT.UNSIGNED,

      broe: DataTypes.TINYINT.UNSIGNED,
      broem: DataTypes.TINYINT.UNSIGNED,
      broy: DataTypes.TINYINT.UNSIGNED,
      borym: DataTypes.TINYINT.UNSIGNED,

      sise: DataTypes.TINYINT.UNSIGNED,
      sisem: DataTypes.TINYINT.UNSIGNED,
      sisy: DataTypes.TINYINT.UNSIGNED,
      sisym: DataTypes.TINYINT.UNSIGNED,

      hastwin: DataTypes.TINYINT,
      workid: DataTypes.INTEGER,

      profilests: DataTypes.TINYINT.UNSIGNED,
      billingsts: DataTypes.TINYINT.UNSIGNED,
      maritalsts: DataTypes.TINYINT.UNSIGNED,
      phonenumber: DataTypes.STRING(20),

      income: { type: DataTypes.INTEGER.UNSIGNED, allowNull: true },
      networth: { type: DataTypes.INTEGER.UNSIGNED, allowNull: true },
      assetdets: DataTypes.TEXT,
      createdby: DataTypes.INTEGER,
      updatedby: DataTypes.INTEGER,
      profilePictureId: DataTypes.INTEGER,

      education1: DataTypes.STRING(30),
      education2: DataTypes.STRING(30),
      almamater: DataTypes.STRING(100),
      udeducation: DataTypes.STRING(30),
      swagothra: DataTypes.TINYINT.UNSIGNED,
      mamagothra: DataTypes.TINYINT.UNSIGNED,
      familygod: DataTypes.STRING(30),
      email: DataTypes.STRING(30),

      createdon: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
      },

      last_interaction: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
      },
      secret_notes: {
        type: DataTypes.JSON,
        defaultValue: []
      }
    },
    {
      tableName: "profiles",
      timestamps: false,
      indexes: [
        { fields: ["birthdate"] },
        { fields: ["gender"] },
        { fields: ["income"] },
        { fields: ["networth"] },
        { fields: ["birthstar"] },
      ]
    }
  );

  return Profile;
};