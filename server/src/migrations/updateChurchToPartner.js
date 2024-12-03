import sequelize from '../config/database.js';

async function updateRoles() {
  try {
    // Update the enum type first
    await sequelize.query(`
      ALTER TYPE "enum_users_role" RENAME TO "enum_users_role_old";
      CREATE TYPE "enum_users_role" AS ENUM ('admin', 'creative', 'partner');
      ALTER TABLE users 
        ALTER COLUMN role TYPE "enum_users_role" 
        USING role::text::"enum_users_role";
      DROP TYPE "enum_users_role_old";
    `);

    // Update existing church roles to partner
    await sequelize.query(`
      UPDATE users 
      SET role = 'partner' 
      WHERE role = 'church';
    `);

    console.log('Successfully updated roles from church to partner');
  } catch (error) {
    console.error('Error updating roles:', error);
  }
}

// Run the migration
updateRoles();
