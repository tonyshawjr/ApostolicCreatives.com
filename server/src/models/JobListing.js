import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

class JobListing extends Model {}

JobListing.init(
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    churchId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'church_profiles',
        key: 'id',
      },
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    requiredSkills: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      defaultValue: [],
    },
    location: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    jobType: {
      type: DataTypes.ENUM('full-time', 'temporary'),
      allowNull: false,
    },
    duration: {
      type: DataTypes.ENUM('3months', '6months', 'permanent'),
      allowNull: false,
    },
    serviceType: {
      type: DataTypes.ENUM('in-person', 'remote'),
      allowNull: false,
    },
    status: {
      type: DataTypes.ENUM('draft', 'active', 'filled', 'closed'),
      defaultValue: 'draft',
    },
    paymentRange: {
      type: DataTypes.JSONB,
      defaultValue: {},
    },
    startDate: {
      type: DataTypes.DATE,
    },
    applicationDeadline: {
      type: DataTypes.DATE,
    },
    benefits: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      defaultValue: [],
    },
    requirements: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      defaultValue: [],
    },
    views: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
    applications: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
  },
  {
    sequelize,
    modelName: 'JobListing',
  }
);

export default JobListing;
