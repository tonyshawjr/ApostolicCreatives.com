import sequelize from '../config/database.js';

async function dropTables() {
  try {
    await sequelize.query(`
      DROP TABLE IF EXISTS pastor_verifications CASCADE;
      DROP TABLE IF EXISTS job_applications CASCADE;
      DROP TABLE IF EXISTS job_listings CASCADE;
      DROP TABLE IF EXISTS church_profiles CASCADE;
      DROP TABLE IF EXISTS creative_profiles CASCADE;
      DROP TABLE IF EXISTS users CASCADE;
      DROP TYPE IF EXISTS enum_users_role CASCADE;
      DROP TYPE IF EXISTS enum_users_status CASCADE;
    `);
    console.log('Successfully dropped all tables');
  } catch (error) {
    console.error('Error dropping tables:', error);
  } finally {
    process.exit(0);
  }
}

dropTables();
