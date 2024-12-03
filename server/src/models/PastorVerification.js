import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

class PastorVerification extends Model {}

PastorVerification.init(
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    creativeId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'creative_profiles',
        key: 'id',
      },
    },
    pastorName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    pastorEmail: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        isEmail: true,
      },
    },
    pastorPhone: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    churchName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    churchAddress: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    recommendationLetterUrl: {
      type: DataTypes.STRING,
    },
    status: {
      type: DataTypes.ENUM('pending', 'approved', 'rejected'),
      defaultValue: 'pending',
    },
    verificationDate: {
      type: DataTypes.DATE,
    },
    expiryDate: {
      type: DataTypes.DATE,
    },
    adminNotes: {
      type: DataTypes.TEXT,
    },
    verifiedBy: {
      type: DataTypes.INTEGER,
      references: {
        model: 'users',
        key: 'id',
      },
    },
  },
  {
    sequelize,
    modelName: 'PastorVerification',
  }
);

export default PastorVerification;
