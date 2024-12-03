import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

class PartnerProfile extends Model {}

PartnerProfile.init(
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      unique: true,
      references: {
        model: 'users',
        key: 'id',
      },
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    logoUrl: {
      type: DataTypes.STRING,
    },
    location: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    contactInfo: {
      type: DataTypes.JSONB,
      defaultValue: {},
    },
    subscriptionTier: {
      type: DataTypes.ENUM('free', 'basic', 'premium'),
      defaultValue: 'free',
    },
    subscriptionExpiry: {
      type: DataTypes.DATE,
    },
    description: {
      type: DataTypes.TEXT,
    },
    website: {
      type: DataTypes.STRING,
    },
    socialMedia: {
      type: DataTypes.JSONB,
      defaultValue: {},
    },
    verificationStatus: {
      type: DataTypes.ENUM('pending', 'verified', 'rejected'),
      defaultValue: 'pending',
    },
    ministryType: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    size: {
      type: DataTypes.STRING,
    },
    preferences: {
      type: DataTypes.JSONB,
      defaultValue: {},
    },
  },
  {
    sequelize,
    modelName: 'PartnerProfile',
    tableName: 'partner_profiles',
  }
);

export default PartnerProfile;
