import User from '../models/User.js';
import sequelize from '../config/database.js';

async function createTestAccounts() {
  try {
    await sequelize.authenticate();
    console.log('Database connected.');

    // Create team (admin) account
    const adminUser = await User.create({
      user_id: 'ADMIN001',
      email: 'admin@test.com',
      password: 'Admin123!',
      first_name: 'Admin',
      last_name: 'User',
      user_type: 'team',
      status: 'active',
      timezone: 'UTC'
    });

    // Create creative account
    const creativeUser = await User.create({
      user_id: 'CRTV001',
      email: 'creative@test.com',
      password: 'Creative123!',
      first_name: 'Creative',
      last_name: 'User',
      user_type: 'creative',
      status: 'active',
      timezone: 'UTC'
    });

    // Create partner account
    const partnerUser = await User.create({
      user_id: 'PRTN001',
      email: 'partner@test.com',
      password: 'Partner123!',
      first_name: 'Partner',
      last_name: 'User',
      user_type: 'partner',
      status: 'active',
      timezone: 'UTC'
    });

    console.log('\nTest accounts created successfully!');
    console.log('\nTest Account Credentials:');
    console.log('-------------------------');
    console.log('Admin Account:');
    console.log('Email: admin@test.com');
    console.log('Password: Admin123!');
    console.log('\nCreative Account:');
    console.log('Email: creative@test.com');
    console.log('Password: Creative123!');
    console.log('\nPartner Account:');
    console.log('Email: partner@test.com');
    console.log('Password: Partner123!');

  } catch (error) {
    console.error('Error creating test accounts:', error);
  } finally {
    await sequelize.close();
  }
}

createTestAccounts();
