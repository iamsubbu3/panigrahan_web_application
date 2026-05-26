module.exports = (sequelize, DataTypes) => {
  const ProfilePreference = sequelize.define(
    "ProfilePreference",
    {
      profileid: {
        type: DataTypes.INTEGER,
        allowNull: false,
        unique: true
      },
      agegap: DataTypes.TINYINT,
      minincome: DataTypes.DECIMAL(10, 2),
      minnetworth: {type: DataTypes.DECIMAL(10, 2), allowNull: true},
      //educationlevel: DataTypes.TINYINT.UNSIGNED,
    },
    {
      tableName: "profilepreference",
      timestamps: false,
    }
  );

  return ProfilePreference;
};
