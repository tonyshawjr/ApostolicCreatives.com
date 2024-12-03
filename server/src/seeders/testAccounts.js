import User from '../models/User.js';
import CreativeProfile from '../models/CreativeProfile.js';
import PartnerProfile from '../models/PartnerProfile.js';
import bcrypt from 'bcryptjs';

const createTestAccounts = async () => {
  try {
    // Create Admin Account
    const adminUser = await User.create({
      email: 'admin@apostoliccreatives.com',
      password: 'Admin123!',  // Let the model hooks handle password hashing
      role: 'admin',
      status: 'active'
    });
    console.log('Admin account created:', adminUser.toJSON());

    // Create Creative Account
    const creativeUser = await User.create({
      email: 'creative@apostoliccreatives.com',
      password: 'Creative123!',  // Let the model hooks handle password hashing
      role: 'creative',
      status: 'active'
    });
    console.log('Creative account created:', creativeUser.toJSON());

    // Create Creative Profile
    await CreativeProfile.create({
      userId: creativeUser.id,
      name: 'John Creative',
      skills: ['Music', 'Sound Engineering', 'Video Production'],
      availabilityStatus: 'available',
      isVerified: true,
      serviceType: 'both',
      location: 'Dallas, TX',
      bio: 'Professional musician and sound engineer with 5 years of experience in ministry.',
      qAndA: {
        experience: '5 years in ministry',
        equipment: 'Professional audio and video equipment',
        availability: 'Weekends and evenings'
      }
    });

    // Create Partner Account
    const partnerUser = await User.create({
      email: 'partner@apostoliccreatives.com',
      password: 'Partner123!',  // Let the model hooks handle password hashing
      role: 'partner',
      status: 'active'
    });
    console.log('Partner account created:', partnerUser.toJSON());

    // Create Partner Profile
    await PartnerProfile.create({
      userId: partnerUser.id,
      name: 'First Apostolic Church',
      location: 'Houston, TX',
      ministryType: 'Church',
      size: '200-500',
      description: 'A vibrant Apostolic church seeking talented creatives to help expand our ministry.',
      website: 'www.firstapostolic.org',
      contactInfo: {
        phone: '(555) 123-4567',
        email: 'contact@firstapostolic.org'
      },
      socialMedia: {
        facebook: 'firstapostolic',
        instagram: 'firstapostolic'
      },
      preferences: {
        serviceTypes: ['in-person', 'remote'],
        primaryNeeds: ['music', 'video', 'graphics']
      }
    });

    console.log('Test accounts created successfully');
    console.log('\nTest Account Credentials:');
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
    console.error('Error creating test accounts:', error);
  }
};

// Run the seeder
createTestAccounts();
