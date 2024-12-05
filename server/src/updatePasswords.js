import User from './models/User.js';
import sequelize from './config/database.js';

async function updatePasswords() {
  try {
    await sequelize.authenticate();
    console.log('Database connected.');

    // Update admin password
    await User.update(
      { password: 'Admin123!' },
      { 
        where: { email: 'admin@apostoliccreatives.com' },
        individualHooks: true  // This ensures the password is hashed
      }
    );

    // Update creative password
    await User.update(
      { password: 'Creative123!' },
      { 
        where: { email: 'creative@apostoliccreatives.com' },
        individualHooks: true
      }
    );

    // Update partner password
    await User.update(
      { password: 'Partner123!' },
      { 
        where: { email: 'partner@apostoliccreatives.com' },
        individualHooks: true
      }
    );

    console.log('\nPasswords updated successfully!');
    console.log('\nLogin Credentials:');
    console.log('-------------------------');
    console.log('Admin Account:');
    console.log('Email: admin@apostoliccreatives.com');
    console.log('Password: Admin123!');
    console.log('\nCreative Account:');
    console.log('Email: creative@apostoliccreatives.com');
    console.log('Password: Creative123!');
    console.log('\nPartner Account:');
    console.log('Email: partner@apostoliccreatives.com');
    console.log('Password: Partner123!');

  } catch (error) {
    console.error('Error updating passwords:', error);
  } finally {
    await sequelize.close();
  }
}

updatePasswords();
