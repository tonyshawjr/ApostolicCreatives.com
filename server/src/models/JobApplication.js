import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

class JobApplication extends Model {}

JobApplication.init(
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    jobId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'job_listings',
        key: 'id',
      },
    },
    creativeId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'creative_profiles',
        key: 'id',
      },
    },
    status: {
      type: DataTypes.ENUM('pending', 'reviewed', 'shortlisted', 'rejected', 'hired'),
      defaultValue: 'pending',
    },
    coverLetter: {
      type: DataTypes.TEXT,
    },
    portfolioLinks: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      defaultValue: [],
    },
    availability: {
      type: DataTypes.JSONB,
      defaultValue: {},
    },
    expectedCompensation: {
      type: DataTypes.STRING,
    },
    notes: {
      type: DataTypes.TEXT,
    },
    reviewedAt: {
      type: DataTypes.DATE,
    },
    reviewedBy: {
      type: DataTypes.INTEGER,
      references: {
        model: 'users',
        key: 'id',
      },
    },
    churchNotes: {
      type: DataTypes.TEXT,
    },
  },
  {
    sequelize,
    modelName: 'JobApplication',
  }
);

export default JobApplication;
