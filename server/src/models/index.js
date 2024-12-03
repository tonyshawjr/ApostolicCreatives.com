import { Model } from 'sequelize';
import User from './User.js';
import CreativeProfile from './CreativeProfile.js';
import PartnerProfile from './PartnerProfile.js';
import JobListing from './JobListing.js';
import JobApplication from './JobApplication.js';
import PastorVerification from './PastorVerification.js';

// User - CreativeProfile relationship
User.hasOne(CreativeProfile, {
  foreignKey: 'userId',
  as: 'creativeProfile',
});
CreativeProfile.belongsTo(User, {
  foreignKey: 'userId',
});

// User - PartnerProfile relationship
User.hasOne(PartnerProfile, {
  foreignKey: 'userId',
  as: 'partnerProfile',
});
PartnerProfile.belongsTo(User, {
  foreignKey: 'userId',
});

// PartnerProfile - JobListing relationship
PartnerProfile.hasMany(JobListing, {
  foreignKey: 'partnerId',
  as: 'jobListings',
});
JobListing.belongsTo(PartnerProfile, {
  foreignKey: 'partnerId',
  as: 'partner',
});

// JobListing - JobApplication relationship
JobListing.hasMany(JobApplication, {
  foreignKey: 'jobId',
  as: 'applications',
});
JobApplication.belongsTo(JobListing, {
  foreignKey: 'jobId',
  as: 'job',
});

// CreativeProfile - JobApplication relationship
CreativeProfile.hasMany(JobApplication, {
  foreignKey: 'creativeId',
  as: 'applications',
});
JobApplication.belongsTo(CreativeProfile, {
  foreignKey: 'creativeId',
  as: 'creative',
});

// PartnerProfile - PastorVerification relationship
PartnerProfile.hasOne(PastorVerification, {
  foreignKey: 'partnerId',
  as: 'verification',
});
PastorVerification.belongsTo(PartnerProfile, {
  foreignKey: 'partnerId',
  as: 'partner',
});

export {
  User,
  CreativeProfile,
  PartnerProfile,
  JobListing,
  JobApplication,
  PastorVerification,
};
