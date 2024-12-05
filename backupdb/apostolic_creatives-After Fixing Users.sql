-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 05, 2024 at 03:26 AM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apostolic_creatives`
--

-- --------------------------------------------------------

--
-- Table structure for table `church_profiles`
--

CREATE TABLE `church_profiles` (
  `partner_id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_type` enum('church','ministry','other') COLLATE utf8mb4_unicode_ci DEFAULT 'church',
  `denomination` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size_range` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year_established` int(11) DEFAULT NULL,
  `about_description` text COLLATE utf8mb4_unicode_ci,
  `primary_pastor_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `church_profiles`
--

INSERT INTO `church_profiles` (`partner_id`, `user_id`, `organization_name`, `organization_type`, `denomination`, `website_url`, `size_range`, `year_established`, `about_description`, `primary_pastor_name`, `primary_contact_name`, `primary_contact_email`, `primary_contact_phone`, `tax_id`, `is_verified`) VALUES
('P000001', 'P0000001', 'First Apostolic Church', 'church', NULL, 'www.firstapostolic.org', '200-500', NULL, 'A vibrant Apostolic church seeking talented creatives to help expand our ministry.', NULL, NULL, 'contact@firstapostolic.org', '(555) 123-4567', NULL, 1),
('P123457', 'P1234567', 'Faith Tabernacle', 'church', 'UPCI', NULL, '200-500', NULL, NULL, 'James Peterson', NULL, NULL, NULL, NULL, 1),
('P123458', 'P1234568', 'Living Water Church', 'church', 'ALJC', NULL, '100-200', NULL, NULL, 'Robert Johnson', NULL, NULL, NULL, NULL, 1),
('P123459', 'P1234569', 'Grace Apostolic Church', 'church', 'UPCI', NULL, '500-1000', NULL, NULL, 'William Brown', NULL, NULL, NULL, NULL, 1),
('P123460', 'P1234570', 'New Hope Church', 'church', 'WPF', NULL, '50-100', NULL, NULL, 'Thomas Davis', NULL, NULL, NULL, NULL, 1),
('P123461', 'P1234571', 'Truth Chapel', 'church', 'PAW', NULL, '200-500', NULL, NULL, 'Michael Wilson', NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `creative_profiles`
--

CREATE TABLE `creative_profiles` (
  `creative_id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `current_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portfolio_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `years_experience` int(11) DEFAULT NULL,
  `availability_status` enum('available','not_available','open_to_opportunities') COLLATE utf8mb4_unicode_ci DEFAULT 'available',
  `preferred_location_type` enum('local','remote','hybrid') COLLATE utf8mb4_unicode_ci DEFAULT 'local',
  `willing_to_relocate` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `creative_profiles`
--

INSERT INTO `creative_profiles` (`creative_id`, `user_id`, `bio`, `current_position`, `website_url`, `portfolio_url`, `linkedin_url`, `years_experience`, `availability_status`, `preferred_location_type`, `willing_to_relocate`) VALUES
('C000001', 'C0000001', 'Professional musician and sound engineer with 5 years of experience in ministry.', 'Sound Engineer', NULL, NULL, NULL, 5, 'available', 'hybrid', 1),
('C123457', 'C1234567', 'Experienced worship leader with a passion for modern worship and team development', 'Worship Pastor', 'https://johnsmith.com', 'https://portfolio.johnsmith.com', 'https://linkedin.com/in/johnsmith', 8, 'available', 'local', 1),
('C123458', 'C1234568', 'Professional photographer specializing in event coverage and ministry documentation', 'Freelance Photographer', 'https://sarahwilliams.com', 'https://portfolio.sarahwilliams.com', 'https://linkedin.com/in/sarahwilliams', 5, 'available', 'remote', 0),
('C123459', 'C1234569', 'Sound engineer with extensive live production experience in large church settings', 'Audio Engineer', NULL, 'https://portfolio.michaeldavis.com', 'https://linkedin.com/in/michaeldavis', 10, 'available', 'local', 1),
('C123460', 'C1234570', 'Graphic designer with a focus on church media and branding', 'Media Director', 'https://emilybrown.com', 'https://portfolio.emilybrown.com', NULL, 6, 'not_available', 'hybrid', 0),
('C123461', 'C1234571', 'Musician skilled in multiple instruments and worship team development', 'Music Director', 'https://davidwilson.com', NULL, 'https://linkedin.com/in/davidwilson', 12, 'available', 'local', 1),
('C123462', 'C1234572', 'Video editor and content creator specializing in ministry content', 'Video Producer', NULL, 'https://portfolio.jessicataylor.com', 'https://linkedin.com/in/jessicataylor', 3, 'open_to_opportunities', 'remote', 1),
('C123463', 'C1234573', 'Web developer specializing in church websites and digital solutions', 'Web Developer', 'https://andrewmartinez.com', 'https://portfolio.andrewmartinez.com', 'https://linkedin.com/in/andrewmartinez', 7, 'available', 'remote', 0),
('C123464', 'C1234574', 'Social media manager with church growth expertise', 'Digital Manager', 'https://rachelanderson.com', NULL, 'https://linkedin.com/in/rachelanderson', 4, 'available', 'hybrid', 1),
('C123465', 'C1234575', 'Drummer with extensive worship team experience', 'Drummer', NULL, 'https://portfolio.kevinthomas.com', NULL, 9, 'open_to_opportunities', 'local', 1),
('C123466', 'C1234576', 'Vocalist and choir director with classical training', 'Choir Director', 'https://laurenjackson.com', NULL, 'https://linkedin.com/in/laurenjackson', 15, 'available', 'local', 0),
('C123467', 'C1234577', 'Live stream technician with multi-camera setup experience', 'Technical Director', NULL, 'https://portfolio.christopherwhite.com', 'https://linkedin.com/in/christopherwhite', 5, 'available', 'hybrid', 1),
('C123468', 'C1234578', 'Guitar player and songwriter with recording experience', 'Worship Leader', 'https://amandaharris.com', 'https://portfolio.amandaharris.com', NULL, 8, 'available', 'local', 1),
('C123469', 'C1234579', 'Motion graphics designer specializing in worship environments', 'Creative Director', 'https://brandonclark.com', 'https://portfolio.brandonclark.com', 'https://linkedin.com/in/brandonclark', 6, 'not_available', 'remote', 0),
('C123470', 'C1234580', 'Event coordinator and production manager for large services', 'Production Manager', NULL, NULL, 'https://linkedin.com/in/melissalewis', 11, 'available', 'local', 1),
('C123471', 'C1234581', 'Piano player and music teacher with worship leadership experience', 'Music Minister', 'https://justinwalker.com', 'https://portfolio.justinwalker.com', 'https://linkedin.com/in/justinwalker', 7, 'open_to_opportunities', 'local', 1);

-- --------------------------------------------------------

--
-- Table structure for table `creative_skills`
--

CREATE TABLE `creative_skills` (
  `creative_id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `creative_skills`
--

INSERT INTO `creative_skills` (`creative_id`, `skill_id`) VALUES
('C123457', 1),
('C123457', 2),
('C123461', 3),
('C123461', 4),
('C000001', 5),
('C123462', 5),
('C123460', 6),
('C000001', 7),
('C123459', 7),
('C123458', 8),
('C123464', 9),
('C123463', 10);

-- --------------------------------------------------------

--
-- Table structure for table `partner_subscriptions`
--

CREATE TABLE `partner_subscriptions` (
  `subscription_id` int(11) NOT NULL,
  `partner_id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_customer_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_subscription_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','cancelled','past_due') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
  `last_payment_date` timestamp NULL DEFAULT NULL,
  `next_payment_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pastoral_references`
--

CREATE TABLE `pastoral_references` (
  `reference_id` int(11) NOT NULL,
  `creative_id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pastor_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `church_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_status` enum('pending','approved','expired') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `verification_date` timestamp NULL DEFAULT NULL,
  `expiry_date` timestamp NULL DEFAULT NULL,
  `last_verified` timestamp NULL DEFAULT NULL,
  `verification_notes` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pastoral_references`
--

INSERT INTO `pastoral_references` (`reference_id`, `creative_id`, `pastor_name`, `church_name`, `phone`, `email`, `reference_status`, `verification_date`, `expiry_date`, `last_verified`, `verification_notes`) VALUES
(1, 'C123457', 'Pastor John Doe', 'First Apostolic Church', NULL, 'pastor@firstapostolic.org', 'approved', '2023-01-01 05:00:00', NULL, NULL, NULL),
(2, 'C123458', 'Pastor Mike Johnson', 'Grace Temple', NULL, 'pastor@gracetemple.org', 'approved', '2023-02-01 05:00:00', NULL, NULL, NULL),
(3, 'C123459', 'Pastor David Wilson', 'New Life UPC', NULL, 'pastor@newlifeupc.org', 'pending', '2023-03-01 05:00:00', NULL, NULL, NULL),
(4, 'C123460', 'Pastor Robert Brown', 'Faith Chapel', NULL, 'pastor@faithchapel.org', 'approved', '2023-04-01 04:00:00', NULL, NULL, NULL),
(5, 'C123461', 'Pastor James Smith', 'Truth Tabernacle', NULL, 'pastor@truthtab.org', 'approved', '2023-05-01 04:00:00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int(11) NOT NULL,
  `permission_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_description` text COLLATE utf8mb4_unicode_ci,
  `permission_category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_name`, `permission_description`, `permission_category`) VALUES
(1, 'user.view', 'Can view user profiles', 'user_management'),
(2, 'user.edit', 'Can edit user profiles', 'user_management'),
(3, 'user.delete', 'Can delete users', 'user_management'),
(4, 'verification.manage', 'Can manage verifications', 'verification'),
(5, 'subscription.manage', 'Can manage subscriptions', 'billing'),
(6, 'system.configure', 'Can configure system settings', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission_level` int(11) NOT NULL,
  `role_description` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `department`, `permission_level`, `role_description`) VALUES
(1, 'Platform Administrator', 'Administration', 100, 'Full system access and control'),
(2, 'Partner Development', 'Business', 80, 'Manages church partnerships and subscriptions'),
(3, 'Creative Ambassador', 'Community', 70, 'Manages creative talent and placements'),
(4, 'Technical Lead', 'Engineering', 90, 'Manages platform technical aspects'),
(5, 'Community Manager', 'Community', 60, 'Manages community engagement and moderation'),
(6, 'Platform Support', 'Support', 50, 'Handles user support and basic operations');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `skill_id` int(11) NOT NULL,
  `skill_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`skill_id`, `skill_name`, `skill_category`, `is_active`) VALUES
(1, 'Worship Leading', 'Music', 1),
(2, 'Piano/Keys', 'Music', 1),
(3, 'Drums', 'Music', 1),
(4, 'Guitar', 'Music', 1),
(5, 'Video Production', 'Media', 1),
(6, 'Graphic Design', 'Media', 1),
(7, 'Sound Engineering', 'Technical', 1),
(8, 'Photography', 'Media', 1),
(9, 'Social Media Management', 'Digital', 1),
(10, 'Web Development', 'Technical', 1);

-- --------------------------------------------------------

--
-- Table structure for table `team_profiles`
--

CREATE TABLE `team_profiles` (
  `team_id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hire_date` date NOT NULL,
  `supervisor_id` char(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `team_profiles`
--

INSERT INTO `team_profiles` (`team_id`, `user_id`, `role_id`, `department`, `hire_date`, `supervisor_id`, `emergency_contact_name`, `emergency_contact_phone`) VALUES
('T000001', 'T0000001', 1, 'Administration', '2023-01-01', NULL, NULL, NULL),
('T123457', 'T1234567', 1, 'Administration', '2023-01-01', NULL, NULL, NULL),
('T123458', 'T1234568', 6, 'Support', '2023-02-01', NULL, NULL, NULL),
('T123459', 'T1234569', 4, 'Engineering', '2023-03-01', NULL, NULL, NULL),
('T123460', 'T1234570', 5, 'Community', '2023-04-01', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` enum('creative','partner','team') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive','pending') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `profile_photo_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'UTC',
  `contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`, `first_name`, `last_name`, `user_type`, `status`, `created_at`, `last_login`, `profile_photo_url`, `timezone`, `contact_phone`, `address_line1`, `address_line2`, `city`, `state`, `postal_code`, `country`) VALUES
('C0000001', 'creative@apostoliccreatives.com', '$2a$10$TFRNFGFidnndKvA2DToZ5.9PcqOcgnWKXw0C/vdaQ5t9dhvZ0q5RG', 'John', 'Creative', 'creative', 'active', '2024-12-05 03:08:31', NULL, NULL, 'America/Chicago', NULL, NULL, NULL, 'Dallas', 'TX', NULL, 'USA'),
('C1234567', 'john.smith@gmail.com', '$2a$10$dqsZNndepyi3fXsgeFCB7uYoZ6v8K/FXA5oNDt7mStVNGS/W2phE.', 'John', 'Smith', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/New_York', '555-123-4567', NULL, NULL, 'Atlanta', 'GA', NULL, 'USA'),
('C1234568', 'sarah.williams@gmail.com', '$2a$10$hcBXxBpYjzvzUMmnQor4MOSpho4rWcleGF84OYL.k3fcYfc2HkNDy', 'Sarah', 'Williams', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', '555-234-5678', NULL, NULL, 'Houston', 'TX', NULL, 'USA'),
('C1234569', 'michael.davis@gmail.com', '$2a$10$HNzAMGb2FFqtwxvV.WdZ3eNmsRRyOQuk3TQ4bYVtfXu0MHcauH/hK', 'Michael', 'Davis', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Los_Angeles', '555-345-6789', NULL, NULL, 'Los Angeles', 'CA', NULL, 'USA'),
('C1234570', 'emily.brown@gmail.com', '$2a$10$JU08wm8HrxjbURKQUmRE8.Z.B3uGTyY9m3tXU9jh8r5Fep0d6kQQm', 'Emily', 'Brown', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Phoenix', '555-456-7890', NULL, NULL, 'Phoenix', 'AZ', NULL, 'USA'),
('C1234571', 'david.wilson@gmail.com', '$2a$10$/XYwMoQFH/AwkHT0C6r4VurNQHMtPLuaq9bl3gF7Knrlao1CuxHt.', 'David', 'Wilson', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Denver', '555-567-8901', NULL, NULL, 'Denver', 'CO', NULL, 'USA'),
('C1234572', 'jessica.taylor@gmail.com', '$2a$10$UnlPliLL6tGgcO3uW9/Kx.mRbSii./gKfT5zCkAiLR.kC0MG7PARa', 'Jessica', 'Taylor', 'creative', 'pending', '2024-12-05 03:07:03', NULL, NULL, 'America/New_York', '555-678-9012', NULL, NULL, 'Miami', 'FL', NULL, 'USA'),
('C1234573', 'andrew.martinez@gmail.com', '$2a$10$s5aLjLhdIv8HHP4QoRHdFOsp9YRZ8nrObMY1CDUXThCQVnpk1V54.', 'Andrew', 'Martinez', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', '555-789-0123', NULL, NULL, 'Dallas', 'TX', NULL, 'USA'),
('C1234574', 'rachel.anderson@gmail.com', '$2a$10$m6rXYpxVXPwC16dppTtFm.UQjqTEvK4Pgw4A93H7T3CE3qKJ9A1w6', 'Rachel', 'Anderson', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/New_York', '555-890-1234', NULL, NULL, 'Nashville', 'TN', NULL, 'USA'),
('C1234575', 'kevin.thomas@gmail.com', '$2a$10$GiIhEJpzc8qTHZEvB7soIOvgO3EfR3q.hoLvvIiifUIgohewvDvWW', 'Kevin', 'Thomas', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', '555-901-2345', NULL, NULL, 'Indianapolis', 'IN', NULL, 'USA'),
('C1234576', 'lauren.jackson@gmail.com', '$2a$10$4pnxI5dMopT5UhxI1FAco.hUGCum/SGbKZsn8p0UhuG.kofNBp6kq', 'Lauren', 'Jackson', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Denver', '555-012-3456', NULL, NULL, 'Salt Lake City', 'UT', NULL, 'USA'),
('C1234577', 'christopher.white@gmail.com', '$2a$10$/erj1XjzS2WU/9ngaPocJebvpYkMg3DGpchyFE8LF7rbvM6IlgxQm', 'Christopher', 'White', 'creative', 'pending', '2024-12-05 03:07:03', NULL, NULL, 'America/Los_Angeles', '555-123-4567', NULL, NULL, 'Seattle', 'WA', NULL, 'USA'),
('C1234578', 'amanda.harris@gmail.com', '$2a$10$ihh/EOtrVKBLpYRHzXxOjO5rGsuR5BvqmrBcjIn1w2SFJwzhqvK82', 'Amanda', 'Harris', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', '555-234-5678', NULL, NULL, 'Kansas City', 'MO', NULL, 'USA'),
('C1234579', 'brandon.clark@gmail.com', '$2a$10$1tntBN6kyFZjOoUcPBf3eujnRpxlOwPlzlQVL03BbujzkDRmgi2W6', 'Brandon', 'Clark', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/New_York', '555-345-6789', NULL, NULL, 'Charlotte', 'NC', NULL, 'USA'),
('C1234580', 'melissa.lewis@gmail.com', '$2a$10$PkKsvnUptjG9eCxGhf5m5O0CcmkjfwWx8cBz4h8oECOmRxW8L7pvq', 'Melissa', 'Lewis', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', '555-456-7890', NULL, NULL, 'New Orleans', 'LA', NULL, 'USA'),
('C1234581', 'justin.walker@gmail.com', '$2a$10$cun9Fg2OcTkBHOhwajYBduQggQrCC.AlHwX19zf9WS5VPgzYy6UH2', 'Justin', 'Walker', 'creative', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/New_York', '555-567-8901', NULL, NULL, 'Boston', 'MA', NULL, 'USA'),
('P0000001', 'partner@apostoliccreatives.com', '$2a$10$wnyv/Ezh938xx9cDdYb6zuF4RvrRODlPkEakPIfS0ABB2yszk/b1O', 'Partner', 'Admin', 'partner', 'active', '2024-12-05 03:08:31', NULL, NULL, 'America/Chicago', NULL, NULL, NULL, 'Houston', 'TX', NULL, 'USA'),
('P1234567', 'info@faithtabernacle.org', '$2a$10$hvuQU93cCQ4MIFllCm20w.z1mlb3dacffvlPmKvXsc2fWcG7kUAZm', 'James', 'Peterson', 'partner', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/New_York', NULL, NULL, NULL, 'Richmond', 'VA', NULL, 'USA'),
('P1234568', 'admin@livingwater.church', '$2a$10$ZFhhbs/txwZm.vRZC3ueS.G0Wa0ZIxR0h3JFiRAOwd/fSUOKPvvLO', 'Robert', 'Johnson', 'partner', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', NULL, NULL, NULL, 'St. Louis', 'MO', NULL, 'USA'),
('P1234569', 'info@graceapostolic.org', '$2a$10$6Aq4ysoFXHKy1jYtPebRNeIKPYKpMzwYSECZ1dEsk.eVScjZ1q7Ay', 'William', 'Brown', 'partner', 'active', '2024-12-05 03:07:03', '2024-12-05 03:20:39', NULL, 'America/Los_Angeles', NULL, NULL, NULL, 'San Diego', 'CA', NULL, 'USA'),
('P1234570', 'contact@newhope.church', '$2a$10$0DhavSMPOE9oDtYWnM0qAucJB3Wu2bQfoLU36ExGqxYPZZ5V286Gu', 'Thomas', 'Davis', 'partner', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Denver', NULL, NULL, NULL, 'Colorado Springs', 'CO', NULL, 'USA'),
('P1234571', 'info@truthchapel.org', '$2a$10$QOGQ1k9Lg2t1UINCK5ngR.5GnLJAvtZHa11yQH1lnKqLOazzEXNYG', 'Michael', 'Wilson', 'partner', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', NULL, NULL, NULL, 'Memphis', 'TN', NULL, 'USA'),
('T0000001', 'admin@apostoliccreatives.com', '$2a$10$qu9NTf6r.XB/HfJR/hGATuyER2tqHQhIC0q5AH3zg2y8NIBtePr76', 'Tony', 'Shaw', 'team', 'active', '2024-12-05 03:08:31', '2024-12-05 03:24:40', NULL, 'America/Chicago', NULL, NULL, NULL, 'Dallas', 'TX', NULL, 'USA'),
('T1234567', 'admin2@apostoliccreatives.com', '$2a$10$YSbnHQPRrMlsTJPh/4/O6.paqC1M7BX/Ya.nX/PYc9cynsPsYs12C', 'Admin', 'User', 'team', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/New_York', NULL, NULL, NULL, 'New York', 'NY', NULL, 'USA'),
('T1234568', 'support@apostoliccreatives.com', '$2a$10$ctCEA32gyclAM9OHPOb3Mek36ZeieSl1MpYALPyfm3UhTUhj/EOyy', 'Support', 'Team', 'team', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', NULL, NULL, NULL, 'Chicago', 'IL', NULL, 'USA'),
('T1234569', 'tech@apostoliccreatives.com', '$2a$10$bn5X11kq6TzbOm06C7V48.soWh2r0/6UF/1HqmXDtjbOzwnzFxbGK', 'Tech', 'Lead', 'team', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Los_Angeles', NULL, NULL, NULL, 'San Francisco', 'CA', NULL, 'USA'),
('T1234570', 'community@apostoliccreatives.com', '$2a$10$pna5UAFc8k..IjEHsFsGPu46Lzp5BLFKEa9n7aFAy619xyP6UpEvW', 'Community', 'Manager', 'team', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Denver', NULL, NULL, NULL, 'Denver', 'CO', NULL, 'USA'),
('T1234571', 'partner2@apostoliccreatives.com', '$2a$10$CMcXj/9MyYAt6JPfzDCpUO9KCG4UqFlLLAnBVA2vE3RyskGGk75X6', 'Partner', 'Relations', 'team', 'active', '2024-12-05 03:07:03', NULL, NULL, 'America/Chicago', NULL, NULL, NULL, 'Dallas', 'TX', NULL, 'USA');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `church_profiles`
--
ALTER TABLE `church_profiles`
  ADD PRIMARY KEY (`partner_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_verified` (`is_verified`);

--
-- Indexes for table `creative_profiles`
--
ALTER TABLE `creative_profiles`
  ADD PRIMARY KEY (`creative_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_availability` (`availability_status`);

--
-- Indexes for table `creative_skills`
--
ALTER TABLE `creative_skills`
  ADD PRIMARY KEY (`creative_id`,`skill_id`),
  ADD KEY `skill_id` (`skill_id`);

--
-- Indexes for table `partner_subscriptions`
--
ALTER TABLE `partner_subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD KEY `partner_id` (`partner_id`),
  ADD KEY `idx_subscription_status` (`status`);

--
-- Indexes for table `pastoral_references`
--
ALTER TABLE `pastoral_references`
  ADD PRIMARY KEY (`reference_id`),
  ADD KEY `creative_id` (`creative_id`),
  ADD KEY `idx_status` (`reference_status`),
  ADD KEY `idx_expiry` (`expiry_date`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD UNIQUE KEY `permission_name` (`permission_name`),
  ADD KEY `idx_category` (`permission_category`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`),
  ADD KEY `idx_permission_level` (`permission_level`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`skill_id`),
  ADD UNIQUE KEY `skill_name` (`skill_name`),
  ADD KEY `idx_category` (`skill_category`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `team_profiles`
--
ALTER TABLE `team_profiles`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `supervisor_id` (`supervisor_id`),
  ADD KEY `idx_department` (`department`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_user_type` (`user_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `partner_subscriptions`
--
ALTER TABLE `partner_subscriptions`
  MODIFY `subscription_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pastoral_references`
--
ALTER TABLE `pastoral_references`
  MODIFY `reference_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `skill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `church_profiles`
--
ALTER TABLE `church_profiles`
  ADD CONSTRAINT `church_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `creative_profiles`
--
ALTER TABLE `creative_profiles`
  ADD CONSTRAINT `creative_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `creative_skills`
--
ALTER TABLE `creative_skills`
  ADD CONSTRAINT `creative_skills_ibfk_1` FOREIGN KEY (`creative_id`) REFERENCES `creative_profiles` (`creative_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `creative_skills_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`) ON DELETE CASCADE;

--
-- Constraints for table `partner_subscriptions`
--
ALTER TABLE `partner_subscriptions`
  ADD CONSTRAINT `partner_subscriptions_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `church_profiles` (`partner_id`) ON DELETE CASCADE;

--
-- Constraints for table `pastoral_references`
--
ALTER TABLE `pastoral_references`
  ADD CONSTRAINT `pastoral_references_ibfk_1` FOREIGN KEY (`creative_id`) REFERENCES `creative_profiles` (`creative_id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE;

--
-- Constraints for table `team_profiles`
--
ALTER TABLE `team_profiles`
  ADD CONSTRAINT `team_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `team_profiles_ibfk_2` FOREIGN KEY (`supervisor_id`) REFERENCES `team_profiles` (`team_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
