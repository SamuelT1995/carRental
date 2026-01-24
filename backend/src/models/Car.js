const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Car = sequelize.define("Car", {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  brand: { type: DataTypes.STRING, allowNull: false },
  model: { type: DataTypes.STRING, allowNull: false },
  pricePerDay: { type: DataTypes.FLOAT, allowNull: false },
  imageUrl: { type: DataTypes.STRING },
  isAvailable: { type: DataTypes.BOOLEAN, defaultValue: true },
});

module.exports = Car;
