import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

class CreativeProfile extends Model {}

CreativeProfile.init(
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
    profilePhotoUrl: {
      type: DataTypes.STRING,
    },
    resumeUrl: {
      type: DataTypes.STRING,
    },
    skills: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      defaultValue: [],
    },
    availabilityStatus: {
      type: DataTypes.ENUM('available', 'unavailable', 'limited'),
      defaultValue: 'available',
    },
    isVerified: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
    verificationExpiry: {
      type: DataTypes.DATE,
    },
    youtubeVideos: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      defaultValue: [],
    },
    serviceType: {
      type: DataTypes.ENUM('in-person', 'remote', 'both'),
      defaultValue: 'both',
    },
    location: {
      type: DataTypes.STRING,
    },
    bio: {
      type: DataTypes.TEXT,
    },
    qAndA: {
      type: DataTypes.JSONB,
      defaultValue: {},
    },
    backgroundCheckStatus: {
      type: DataTypes.ENUM('pending', 'approved', 'rejected'),
      defaultValue: 'pending',
    },
    backgroundCheckDate: {
      type: DataTypes.DATE,
    },
  },
  {
    sequelize,
    modelName: 'CreativeProfile',
  }
);

export default CreativeProfile;
