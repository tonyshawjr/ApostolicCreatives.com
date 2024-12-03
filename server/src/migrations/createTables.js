import sequelize from '../config/database.js';
import {
  User,
  CreativeProfile,
  ChurchProfile,
  PastorVerification,
  JobListing,
  JobApplication,
} from '../models/index.js';

const createTables = async () => {
  try {
    // Force: true will drop the table if it already exists
    await sequelize.sync({ force: true });
    console.log('Tables created successfully.');
  } catch (error) {
    console.error('Error creating tables:', error);
  }
};

createTables();
