-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Aug 28, 2015 at 04:20 AM
-- Server version: 5.5.42
-- PHP Version: 5.6.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `oar_local`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `udf_cleanString`(`in_str` varchar(4096)) RETURNS varchar(4096) CHARSET utf8
BEGIN 
/** 
 * Function will strip all non-ASCII and unwanted ASCII characters in string 
 * 
 * @author Shay Anderson 10.11 
 * 
 * @param VARCHAR in_arg 
 * @return VARCHAR 
 */ 
      DECLARE out_str VARCHAR(4096) DEFAULT ''; 
      DECLARE c VARCHAR(4096) DEFAULT ''; 
      DECLARE pointer INT DEFAULT 1; 

      IF ISNULL(in_str) THEN 
            RETURN NULL; 
      ELSE 
            WHILE pointer <= LENGTH(in_str) DO 
                   
                  SET c = MID(in_str, pointer, 1); 

                  IF ASCII(c) > 31 AND ASCII(c) < 127 THEN 
                        SET out_str = CONCAT(out_str, c); 
                  END IF; 

                  SET pointer = pointer + 1; 
            END WHILE; 
      END IF; 

      RETURN out_str; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `capabilities`
--

CREATE TABLE `capabilities` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `capabilities`
--

INSERT INTO `capabilities` (`id`, `name`, `created_at`, `updated_at`) VALUES
(22, 'site/members:view', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(23, 'site/members:search', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(24, 'site/members:message', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(25, 'site/alarm:view', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(26, 'site/alarm:update', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(27, 'site/group:join', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(28, 'site/group:leave', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(29, 'site/bugs:report', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(30, 'site/language:choose', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(31, 'site/user:add', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(32, 'site/user:delete', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(33, 'site/user:view', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(34, 'site/user:search', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(35, 'group/user:view', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(36, 'group/user:search', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(37, 'site/group:add', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(38, 'site/group:edit', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(39, 'site/group:delete', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(40, 'site/group:changestart', '2014-01-13 18:15:33', '2014-01-13 18:15:33'),
(41, 'site/group:joinmultiple', '2014-01-13 18:15:33', '2014-01-13 18:15:33');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=327 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_user_token`
--

CREATE TABLE `custom_user_token` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `token` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `custom_user_token`
--

INSERT INTO `custom_user_token` (`id`, `user_id`, `token`) VALUES
(1, 53, '123456789'),
(4, 100, '2345'),
(5, 109, '987654321'),
(6, 110, '987654321');

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `device` varchar(50) NOT NULL,
  `player_id` tinytext NOT NULL,
  `tags` varchar(100) NOT NULL,
  `active` int(10) NOT NULL DEFAULT '1',
  `raw_data` text NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `user_id`, `device`, `player_id`, `tags`, `active`, `raw_data`, `date`) VALUES
(105, 387, 'iPhone4,1', '35e12244-2f5d-11e5-a475-db4cb9734d5b', '{"roller":"ios"}', 1, '{"id":"35e12244-2f5d-11e5-a475-db4cb9734d5b","identifier":"e98918c29f77ce2dc880c4082f872a6af0715ee302d891662546f174f20ada2e","session_count":4,"language":"en","timezone":36000,"game_version":"1.0","device_os":"8.3","device_type":0,"device_model":"iPhone4,1","ad_id":"DE43536A-3278-49EA-A420-D6FA0F8F8D48","tags":{"roller":"ios"},"last_active":1437451734,"playtime":31,"amount_spent":"0.0","facebook_id":null,"created_at":1437451308,"invalid_identifier":false,"badge_count":0}', '2015-07-21 04:16:30'),
(106, 387, 'iPad3,3', 'e1424d3e-2f5d-11e5-b721-9b1bcfd3064c', '{"roller":"ios"}', 1, '{"id":"e1424d3e-2f5d-11e5-b721-9b1bcfd3064c","identifier":"115b67d90722ff12a001a532c9a55c3fc8e891458b5a29976a10e69bcedc2387","session_count":6,"language":"en","timezone":36000,"game_version":"1.0","device_os":"7.0.4","device_type":0,"device_model":"iPad3,3","ad_id":"EA5B241C-5152-490B-9CC5-4AFEE263AE5E","tags":{"roller":"ios"},"last_active":1437455156,"playtime":625,"amount_spent":"0.0","facebook_id":null,"created_at":1437451596,"invalid_identifier":false,"badge_count":0}', '2015-07-21 05:13:37');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `feedback` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `final_task`
--

CREATE TABLE `final_task` (
  `outcome_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `final_task`
--

INSERT INTO `final_task` (`outcome_id`, `task_id`) VALUES
(1, 27),
(8, 74),
(9, 96),
(10, 117);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `outcome` int(11) NOT NULL,
  `survey` int(11) DEFAULT NULL,
  `postsurvey` int(11) DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timestart` int(11) NOT NULL,
  `timeend` int(11) NOT NULL,
  `createdby` int(11) NOT NULL,
  `keycode` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`, `outcome`, `survey`, `postsurvey`, `thumbnail`, `timestart`, `timeend`, `createdby`, `keycode`, `created_at`, `updated_at`) VALUES
(17, 'On A Roll 21', 'On A Roll 21', 8, 13, 14, 'L3VwbG9hZHMvcGl4L2dyb3VwL09uX0FfUm9sbF8yMS5wbmc=', 1426510800, 0, 2, 'em001', '2015-03-17 00:24:02', '2015-03-18 00:27:48'),
(25, 'Sydney Uni', '', 8, 13, 14, 'L3VwbG9hZHMvcGl4L2dyb3VwL1N5ZG5leV9VbmkucG5n', 1426770000, 0, 2, 'syduni', '2015-03-19 06:08:58', '2015-03-19 06:57:58'),
(26, 'Beca', 'Beca Engineering', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL0JlY2EucG5n', 1427634000, 0, 2, 'be001', '2015-03-26 02:07:15', '2015-03-27 06:38:24'),
(27, 'Lonely Planet', '', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL0xvbmVseV9QbGFuZXQuanBlZw==', 1427634000, 0, 165, 'lp001', '2015-03-27 06:58:19', '2015-03-27 06:58:19'),
(29, 'Pancake Parlour ', 'Pancake Parlour ', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL1BhbmNha2VfUGFybG91cl8uanBn', 1428242400, 0, 2, 'pp001', '2015-04-01 02:25:38', '2015-04-01 02:25:38'),
(30, 'Randstad', 'Randstad', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL1JhbmRzdGFkLmpwZw==', 1428242400, 0, 2, 'rs001', '2015-04-01 02:26:36', '2015-04-01 02:26:36'),
(31, 'Good Shepherd', 'Good Shepherd', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL0dvb2RfU2hlcGhlcmQuanBn', 1428328800, 0, 2, 'gs001', '2015-04-01 02:27:25', '2015-04-01 02:27:25'),
(32, 'Kildonan', 'Kildonan', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL0tpbGRvbmFuLmpwZw==', 1429452000, 0, 2, 'kn001', '2015-04-01 02:28:05', '2015-04-01 02:28:05'),
(33, 'The Good Guys', 'The Good Guys', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL1RoZV9Hb29kX0d1eXMucG5n', 1429452000, 0, 2, 'gg001', '2015-04-01 02:29:02', '2015-04-01 02:29:21'),
(34, 'ANZ', 'ANZ', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL0FOWi5wbmc=', 1429452000, 0, 2, 'an001', '2015-04-01 02:30:02', '2015-04-01 02:30:02'),
(35, 'St Monica''s School Epping', 'St Monica''s School Epping', 10, 10, 11, 'L3VwbG9hZHMvcGl4L2dyb3VwL1N0X01vbmljYSdzX1NjaG9vbF9FcHBpbmcuanBn', 1430143200, 0, 2, 'stmon', '2015-04-01 06:34:09', '2015-04-27 22:52:04'),
(36, 'test', 'test', 9, 15, 16, 'L3VwbG9hZHMvcGl4L2dyb3VwL3Rlc3QuanBlZw==', 1428415200, 0, 2, 'test', '2015-04-01 06:41:08', '2015-04-01 06:41:08'),
(38, 'Mark''s happy days', 'wooohoooooo!', 10, 10, 11, 'L3VwbG9hZHMvcGl4L2dyb3VwL01hcmsnc19oYXBweV9kYXlzLmpwZw==', 1432562400, 0, 2, 'markyd', '2015-05-25 04:50:03', '2015-05-25 04:50:03'),
(39, 'MIMCO Rollers', '', 10, 15, 15, 'L3VwbG9hZHMvcGl4L2dyb3VwL01JTUlDT19Sb2xsZXJzLnBuZw==', 1436882400, 0, 2, 'mim001', '2015-07-15 05:19:33', '2015-07-15 05:19:33'),
(40, 'Internal Test Team', 'Test Team', 1, 15, 11, 'L3VwbG9hZHMvcGl4L2dyb3VwL1Rlc3RfVGVhbS5qcGVn', 1438869600, 0, 2, 'dev001', '2015-07-22 04:11:24', '2015-08-07 07:00:32');

-- --------------------------------------------------------

--
-- Table structure for table `group_users`
--

CREATE TABLE `group_users` (
  `group_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `group_users`
--

INSERT INTO `group_users` (`group_id`, `user_id`, `created_at`, `updated_at`) VALUES
(17, 2, '2015-03-17 00:24:08', '2015-03-17 00:24:08'),
(40, 417, '2015-08-28 02:18:34', '2015-08-28 02:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL,
  `locale` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `locale`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'en', 'English', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
(2, 'es', 'Spanish', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `language_entries`
--

CREATE TABLE `language_entries` (
  `id` int(10) unsigned NOT NULL,
  `language_id` int(10) unsigned NOT NULL,
  `namespace` varchar(150) COLLATE utf8_unicode_ci NOT NULL DEFAULT '*',
  `group` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `item` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `unstable` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=612 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `language_entries`
--

INSERT INTO `language_entries` (`id`, `language_id`, `namespace`, `group`, `item`, `text`, `unstable`, `locked`, `created_at`, `updated_at`) VALUES
(1, 2, '*', 'capabilities', 'site/members:view', 'View all site members', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(2, 2, '*', 'capabilities', 'site/members:search', 'Search site members', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(3, 2, '*', 'capabilities', 'site/members:message', 'Message a member', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(4, 2, '*', 'capabilities', 'site/alarm:view', 'View alarm', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(5, 2, '*', 'capabilities', 'site/alarm:update', 'Update alarm', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(6, 2, '*', 'capabilities', 'site/group:join', 'Join group', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(7, 2, '*', 'capabilities', 'site/group:leave', 'Leave group', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(8, 2, '*', 'capabilities', 'site/bugs:report', 'Report bugs', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(9, 2, '*', 'capabilities', 'site/language:choose', 'Choose language', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(10, 2, '*', 'capabilities', 'site/user:add', 'Add user', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(11, 2, '*', 'capabilities', 'site/user:delete', 'Delete user', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(12, 2, '*', 'capabilities', 'site/user:view', 'View user', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(13, 2, '*', 'capabilities', 'site/user:search', 'Search a user', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(14, 2, '*', 'capabilities', 'group/user:view', 'View user profile', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(15, 2, '*', 'capabilities', 'group/user:search', 'Search a group', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(16, 2, '*', 'capabilities', 'site/group:add', 'Add a group', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(17, 2, '*', 'capabilities', 'site/group:edit', 'Edit a group', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(18, 2, '*', 'capabilities', 'site/group:delete', 'Delete a group', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(19, 2, '*', 'capabilities', 'site/group:changestart', 'Change group start date', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(20, 2, '*', 'capabilities', 'site/group:joinmultiple', 'Join multiple groups', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(21, 2, '*', 'dice', 'rollthedice', 'Roll', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(22, 2, '*', 'dice', 'rollagain', 'Roll again', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(23, 2, '*', 'dice', 'yourolled', 'You rolled', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(24, 2, '*', 'dice', 'congyourolled', 'Congratulations, you rolled', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(25, 2, '*', 'dice', 'dicerollintro', '<h3>Play</h3>', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(26, 2, '*', 'dice', 'tasksavebtn', 'Accept', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(27, 2, '*', 'dice', 'todaysactivity', 'Today''s mission: ', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(28, 2, '*', 'master', 'welcome', 'Welcome to On A Roll 21', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(29, 2, '*', 'master', 'email', 'Email address', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(30, 2, '*', 'master', 'username', 'Username', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(31, 2, '*', 'master', 'firstname', 'First name', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(32, 2, '*', 'master', 'lastname', 'Last name', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(33, 2, '*', 'master', 'city', 'City', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(34, 2, '*', 'master', 'country', 'Country', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(35, 2, '*', 'master', 'taskname', 'Mission name', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(36, 2, '*', 'master', 'taskauthor', 'Mission author', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(37, 2, '*', 'master', 'tasknameholder', 'Mission name', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(38, 2, '*', 'master', 'taskdescription', 'Mission Description', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(39, 2, '*', 'master', 'didyouknow', 'Did you know', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(40, 2, '*', 'master', 'reference', 'Reference', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(41, 2, '*', 'master', 'password', 'Password', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(42, 2, '*', 'master', 'organisation', 'Organisation', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(43, 2, '*', 'master', 'description', 'Description', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(44, 2, '*', 'master', 'userpicture', 'Picture', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(45, 2, '*', 'master', 'editbtn', 'Edit', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(46, 2, '*', 'master', 'suspendbtn', 'Suspend', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(47, 2, '*', 'master', 'deletebtn', 'Delete', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(48, 2, '*', 'master', 'addnewuser', 'Add a new user', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(49, 2, '*', 'master', 'groupname', 'Team name', 1, 0, '2014-04-13 15:24:08', '2014-06-15 09:52:12'),
(50, 2, '*', 'master', 'groupdescription', 'Team description', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(51, 2, '*', 'master', 'groupstartdate', 'Start date', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(52, 2, '*', 'master', 'grouppicture', 'Picture', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(53, 2, '*', 'master', 'groupoutcome', 'Goal', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(54, 2, '*', 'master', 'addgroup', 'Add Team', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(55, 2, '*', 'master', 'updategroup', 'Update Team', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(56, 2, '*', 'master', 'managegroup', 'Manage Team', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(57, 2, '*', 'master', 'addtask', 'Add Mission', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(58, 2, '*', 'master', 'addnewtask', 'Add a new Mission', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(59, 2, '*', 'master', 'updatetask', 'Update Mission', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(60, 2, '*', 'master', 'loginusername', 'Username', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(61, 2, '*', 'master', 'loginpassword', 'Password', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(62, 2, '*', 'master', 'loginbtn', 'Log in', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(63, 2, '*', 'master', 'emptyusername', 'Username must be supplied', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(64, 2, '*', 'master', 'emptypassword', 'Password must be supplied', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(65, 2, '*', 'master', 'incorrectlogin', 'Oops! We cannot verify the login details. Please try again.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(66, 2, '*', 'master', 'logoutsuccess', 'You have been successfully logged out', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(67, 2, '*', 'master', 'joingroup', 'Join', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(68, 2, '*', 'master', 'leavegroup', 'Leave', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(69, 2, '*', 'master', 'viewgroup', 'View Team', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(70, 2, '*', 'master', 'outcomename', 'Goal name', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(71, 2, '*', 'master', 'outcomedescription', 'Goal description', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(72, 2, '*', 'master', 'addoutcome', 'Add Goal', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(73, 2, '*', 'master', 'activatebtn', 'Activate', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(74, 2, '*', 'master', 'updateoutcome', 'Update', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(75, 2, '*', 'master', 'addbtn', 'Add', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(76, 2, '*', 'master', 'removebtn', 'Remove', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(77, 2, '*', 'master', 'addremoveusers', 'Add/Remove users', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(78, 2, '*', 'master', 'addnewrole', 'Add a new role', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(79, 2, '*', 'master', 'adduserbtn', 'Add', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(80, 2, '*', 'master', 'name', 'Name', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(81, 2, '*', 'master', 'action', 'Action', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(82, 2, '*', 'master', 'upbtn', 'Up', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(83, 2, '*', 'master', 'dwnbtn', 'Down', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(84, 2, '*', 'master', 'signup', 'New to On A Roll 21? :clickhere to get started', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(85, 2, '*', 'master', 'clickhere', 'Click here', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(86, 2, '*', 'master', 'registersuccess', 'Your account has been created successfully.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(87, 2, '*', 'master', 'choose', 'Choose', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(88, 2, '*', 'master', 'sharebtn', 'Share', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(89, 2, '*', 'master', 'lblstatusbox', 'Status:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(90, 2, '*', 'master', 'play', 'Play', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(91, 2, '*', 'master', 'uploadimage', 'Upload image..', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(92, 2, '*', 'master', 'sendreminder', 'Send request', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(93, 2, '*', 'master', 'forgotpasswordtext', 'Please enter the email address you submitted at signup so we can send you a unique link where you can reset your password.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(94, 2, '*', 'master', 'emailfromname', 'On A Roll 21', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(95, 2, '*', 'master', 'comment', 'Comment', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(96, 2, '*', 'master', 'signupbtn', 'Sign up', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(97, 2, '*', 'master', 'createaccount', 'sign up', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(98, 2, '*', 'master', 'unlike', 'Unlike', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(99, 2, '*', 'master', 'like', 'Like', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(100, 2, '*', 'master', 'markcomplete', 'Mark complete', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(101, 2, '*', 'master', 'starttime', 'Start date', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(102, 2, '*', 'master', 'addrole', 'Add role', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(103, 2, '*', 'master', 'updaterole', 'Update role', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(104, 2, '*', 'master', 'markfinalbtn', 'Mark final', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(105, 2, '*', 'master', 'removefinal', 'Remove final mission', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(106, 2, '*', 'master', 'fewtasks', 'Missions < 21', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(107, 2, '*', 'master', 'forgotpassword', 'Forgot password?', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(108, 2, '*', 'master', 'savesurvey', 'Save survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(109, 2, '*', 'master', 'wellbeingsavebtn', 'Accept', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(110, 2, '*', 'master', 'addnewsurvey', 'Add new survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(111, 2, '*', 'master', 'nosurveys', 'There are no surveys for this Team to complete. Please select "Add new survey" if you wish to include.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(112, 2, '*', 'master', 'addfieldsbtn', 'Add/removefields', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(113, 2, '*', 'master', 'login', 'Log in', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(114, 2, '*', 'master', 'noaccount', 'Don''t have an account?', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(115, 2, '*', 'master', 'wanttolearnmore', 'Want to learn more?', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(116, 2, '*', 'master', 'seehow', 'See how On A Roll 21 helps you work better', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(117, 2, '*', 'master', 'haveaccount', 'Already have an account?', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(118, 2, '*', 'master', 'or', 'or', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(119, 2, '*', 'master', 'resetpassword', 'Reset your password', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(120, 2, '*', 'master', 'signupheading', 'Sign up for On A Roll 21', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(121, 2, '*', 'master', 'about', 'About On A Roll 21', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(122, 2, '*', 'master', 'contact', 'Contact Us', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(123, 2, '*', 'master', 'businessbenefits', 'Business benefits', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(124, 2, '*', 'master', 'tos', 'Terms of use', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(125, 2, '*', 'master', 'privacy', 'Privacy policy', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(126, 2, '*', 'master', 'report', 'Report abuse', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(127, 2, '*', 'master', 'register', 'Sign up', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(128, 2, '*', 'master', 'groupsintro', '<br />Hi :name!\n    <br /><br />\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select "Join" to choose which team to play in or "Leave" to remove yourself from the team. Select a team name for further team info.</p><br />', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(129, 2, '*', 'master', 'playintro', '<br />Hi :name!\n    <br /><br />\n    <p>    \n    You are currently a member of more than one team. Select "Play" against the team you want to roll with.</p><br />', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(130, 2, '*', 'master', 'playgroupsintro', '<br />Hi :name!\n    <br /><br />\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select "Join" to choose which team to play in or "Leave" to remove yourself from the team. Select a team name for further team info.</p><br />', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(131, 2, '*', 'master', 'datejoined', 'Date joined:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(132, 2, '*', 'master', 'viewprofile', 'Profile', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(133, 2, '*', 'master', 'message', 'Message', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(134, 2, '*', 'master', 'members', 'Rollers', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(135, 2, '*', 'master', 'membersintro', '<br />Hi :name!\n    <br /><br />\n    <p>Here are the rollers that are in your team. Simply select "Profile" (or their name) to view a roller. You can send a message to a roller by selecting "Message".</p>', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(136, 2, '*', 'master', 'addagroup', 'Add a Team', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(137, 2, '*', 'master', 'getstarted', 'Get started', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(138, 2, '*', 'master', 'sitesettings', 'Site settings', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(139, 2, '*', 'master', 'assigncapabilities', 'Assign capabilities', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(140, 2, '*', 'master', 'roll', 'Roll', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(141, 2, '*', 'master', 'done', 'Done', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(142, 2, '*', 'master', 'statuspagewelcome', 'Hi :name!', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(143, 2, '*', 'master', 'homepageintrotop', 'ON A ROLL 21&TRADE; is a digital behaviour change program that helps promote happiness, wellbeing and productivity in 21 days.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(144, 2, '*', 'master', 'homepageintrobottom', '"Waiting to be happy limits our brain''s potential for success, \n                    whereas if we can help cultivate a positive brain \n                    it makes us more motivated, efficient, resilient, creative and productive,\n                    all of which drive improved health outcomes and performance." <br />- Lisa Mcleod, Clinical Psychologist and On A Roll 21 program inventor', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(145, 2, '*', 'master', 'howdidyouroll', 'How did you roll?', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(146, 2, '*', 'master', 'howtoplay', 'How to play', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(147, 2, '*', 'master', 'aboutus', 'About On A Roll 21', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(148, 2, '*', 'master', 'surveypageintrotop', '<h5>Welcome to On A Roll 21!</h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.</p>\n', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(149, 2, '*', 'master', 'surveypageintrobottom', 'The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program’s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On a Roll 21 program designers.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(150, 2, '*', 'master', 'presurveyhead', 'On A Roll 21 Pre-Survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(151, 2, '*', 'master', 'postsurveyhead', 'On A Roll 21 Post-Survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(152, 2, '*', 'master', 'postsurveypageintrotop', '<h5>Welcome to On A Roll 21!</h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.</p>', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(153, 2, '*', 'master', 'postsurveypageintrobottom', 'The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program’s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On a Roll 21 program designers.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(154, 2, '*', 'master', 'logoalt', 'On A Roll 21 logo', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(155, 2, '*', 'master', 'howareyoufeeling', 'How are you feeling?', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(156, 2, '*', 'master', 'nopresurvey', 'It appears that you have not completed the Pre-Survey. Please complete so we can track how you''re travelling during On A Roll 21.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(157, 2, '*', 'master', 'commentboxplaceholder', 'Write your comment here', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(158, 2, '*', 'master', 'wellbeinghistory', 'Mood Map', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(159, 2, '*', 'master', 'postsurveypopupintro', 'This is where we will put the post survey intro will be explaining what happens after the post survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(160, 2, '*', 'master', 'postsurveypopuphead', 'Post survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(161, 2, '*', 'master', 'presurveypopuphead', 'Pre survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(162, 2, '*', 'master', 'day', 'Day', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(163, 2, '*', 'master', 'daysleft', 'Days left', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(164, 2, '*', 'master', 'acceptedtasks', 'Accepted missions', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(165, 2, '*', 'master', 'signupagreement', 'By selecting "create account" you accept the following <a href="/page/tos">terms and conditions</a> and our <a href="/page/privacy">privacy policy</a>', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(166, 2, '*', 'master', 'anonymous', 'Anonymous', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(167, 2, '*', 'master', 'rollername', 'Roller name', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(168, 2, '*', 'master', 'postsurvey', 'Post survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(169, 2, '*', 'master', 'loading', 'Loading...', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(170, 2, '*', 'master', 'sendmessage', 'Send message', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(171, 2, '*', 'master', 'contactthanks', 'Thank you. You message has been sent successfully', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(172, 2, '*', 'master', 'offender', 'Offender', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(173, 2, '*', 'master', 'group', 'Team', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(174, 2, '*', 'master', 'persontoreport', 'Person to report', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(175, 2, '*', 'master', 'statusareadisabler', 'Please roll the dice and accept your mission before posting.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(176, 2, '*', 'master', 'currenttask', '<b>Your mission in progress</b>', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(177, 2, '*', 'master', 'mood_fantastic', 'Fantastic', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(178, 2, '*', 'master', 'mood_prettygood', 'Pretty good', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(179, 2, '*', 'master', 'mood_neutral', 'Okay', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(180, 2, '*', 'master', 'mood_notgreat', 'Not great', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(181, 2, '*', 'master', 'mood_terrible', 'Terrible', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(182, 2, '*', 'master', 'mood_sel_message', 'Your response will be anonymous and averaged across the team. It will not be visible to other team members.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(183, 2, '*', 'master', 'addanewuser', 'Add a new user', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(184, 2, '*', 'master', 'updateuser', 'Update user', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(185, 2, '*', 'master', 'editprofile', 'Edit profile', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(186, 2, '*', 'master', 'joined', 'Joined', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(187, 2, '*', 'menu', 'home', 'Home', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(188, 2, '*', 'menu', 'instructions', 'Instructions', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(189, 2, '*', 'menu', 'groups', 'Teams', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(190, 2, '*', 'menu', 'surveys', 'Surveys', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(191, 2, '*', 'menu', 'presurvey', 'Pre-survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(192, 2, '*', 'menu', 'postsurvey', 'Post-survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(193, 2, '*', 'menu', 'play', 'Play', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(194, 2, '*', 'menu', 'users', 'Users', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(195, 2, '*', 'menu', 'manageusers', 'Manage users', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(196, 2, '*', 'menu', 'addauser', 'Add a user', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(197, 2, '*', 'menu', 'creategroup', 'Create team', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(198, 2, '*', 'menu', 'tasks', 'Missions', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(199, 2, '*', 'menu', 'createnewtask', 'Create new mission', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(200, 2, '*', 'menu', 'managetasks', 'Manage missions', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(201, 2, '*', 'menu', 'createnewoutcome', 'Create new goal', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(202, 2, '*', 'menu', 'manageoutcomes', 'Manage goals', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(203, 2, '*', 'menu', 'options', 'Options', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(204, 2, '*', 'menu', 'logout', 'Log out', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(205, 2, '*', 'menu', 'editprofile', 'Update profile', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(206, 2, '*', 'menu', 'viewprofile', 'View profile', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(207, 2, '*', 'menu', 'managegroups', 'Manage teams', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(208, 2, '*', 'menu', 'outcomes', 'Goals', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(209, 2, '*', 'menu', 'roles', 'Roles', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(210, 2, '*', 'menu', 'assignroles', 'Assign roles', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(211, 2, '*', 'menu', 'managesurveys', 'Manage surveys', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(212, 2, '*', 'menu', 'addsurvey', 'Add survey', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(213, 2, '*', 'menu', 'roll', 'Roll!', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(214, 2, '*', 'menu', 'getstarted', 'Get started', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(215, 2, '*', 'menu', 'howtoplay', 'How to play On A Roll 21', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(216, 2, '*', 'menu', 'sitesettings', 'Site settings', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(217, 2, '*', 'menu', 'assigncapabilities', 'Assign capabilities', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(218, 2, '*', 'menu', 'messages', 'Messages', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(219, 2, '*', 'menu', 'language', 'Language', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(220, 2, '*', 'menu', 'profile', 'Profile', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(221, 2, '*', 'menu', 'settings', 'Settings', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(222, 2, '*', 'pagination', 'previous', '&laquo; Previous', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(223, 2, '*', 'pagination', 'next', 'Next &raquo;', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(224, 2, '*', 'profile', 'team', 'Team:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(225, 2, '*', 'profile', 'motto', 'Motto:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(226, 2, '*', 'profile', 'phone', 'Ph:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(227, 2, '*', 'profile', 'email', 'Work email:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(228, 2, '*', 'profile', 'contact', 'Contact:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(229, 2, '*', 'profile', 'stats', 'Stats:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(230, 2, '*', 'profile', 'messages', 'Messages:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(231, 2, '*', 'profile', 'taskscompleted', 'Missions completed:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(232, 2, '*', 'profile', 'joined', 'Joined:', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(233, 2, '*', 'profile', 'terrible', 'Terrible', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(234, 2, '*', 'profile', 'notgreat', 'Not great', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(235, 2, '*', 'profile', 'prettygood', 'Pretty good', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(236, 2, '*', 'profile', 'fantastic', 'Fantastic', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(237, 2, '*', 'profile', 'neutral', 'Okay', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(238, 2, '*', 'reminders', 'password', 'Passwords must be at least six characters and match the confirmation.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(239, 2, '*', 'reminders', 'user', 'We can''t find a user with that email address.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(240, 2, '*', 'reminders', 'token', 'This password reset token is invalid.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(241, 2, '*', 'reminders', 'sent', 'Password reminder sent!', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(242, 2, '*', 'survey', 'welcomeheading', '<h3>Welcome to On A Roll 21!</h3>', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(243, 2, '*', 'survey', 'presurveyintro', '<p>Please complete the following brief survey <b>before</b> your \n                        participation in the 21-day program.</p>\n                    <p>The survey has a total of 23 questions, which are all \n                    multiple choice with the opportunity for comments at the end. \n                    It should take you about 3 to 5 minutes to complete. It is \n                    important that you answer each question honestly. Your answers\n                    will be treated with strict confidentiality and respect, and \n                    will be collated for the sole purpose of understanding the \n                    effectiveness of the program’s aims and objectives. Individuals \n                    will not be identified in the information submitted. All data \n                    derived from this survey will be stored in a database, \n                    which is password protected, and can only be accessed \n                    by En Masse program designers.</p>', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(244, 2, '*', 'survey', 'pre_gender', 'Gender', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(245, 2, '*', 'survey', 'pre_age', 'Age', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(246, 2, '*', 'survey', 'pre_employmenttype', 'Employment type', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(247, 2, '*', 'survey', 'pre_fulltime', 'Full time', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(248, 2, '*', 'survey', 'pre_parttime', 'Part time', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(249, 2, '*', 'survey', 'pre_selfemployed', 'Self employed', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(250, 2, '*', 'survey', 'pre_contract', 'Contract', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(251, 2, '*', 'validation', 'accepted', 'The :attribute must be accepted.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(252, 2, '*', 'validation', 'active_url', 'The :attribute is not a valid URL.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(253, 2, '*', 'validation', 'after', 'The :attribute must be a date after :date.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(254, 2, '*', 'validation', 'alpha', 'The :attribute may only contain letters.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(255, 2, '*', 'validation', 'alpha_dash', 'The :attribute may only contain letters, numbers, and dashes.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(256, 2, '*', 'validation', 'alpha_num', 'The :attribute may only contain letters and numbers.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(257, 2, '*', 'validation', 'array', 'The :attribute must be an array.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(258, 2, '*', 'validation', 'before', 'The :attribute must be a date before :date.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(259, 2, '*', 'validation', 'between.numeric', 'The :attribute must be between :min and :max.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(260, 2, '*', 'validation', 'between.file', 'The :attribute must be between :min and :max kilobytes.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(261, 2, '*', 'validation', 'between.string', 'The :attribute must be between :min and :max characters.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(262, 2, '*', 'validation', 'between.array', 'The :attribute must have between :min and :max items.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(263, 2, '*', 'validation', 'confirmed', 'The :attribute confirmation does not match.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(264, 2, '*', 'validation', 'date', 'The :attribute is not a valid date.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(265, 2, '*', 'validation', 'date_format', 'The :attribute does not match the format :format.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(266, 2, '*', 'validation', 'different', 'The :attribute and :other must be different.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(267, 2, '*', 'validation', 'digits', 'The :attribute must be :digits digits.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(268, 2, '*', 'validation', 'digits_between', 'The :attribute must be between :min and :max digits.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(269, 2, '*', 'validation', 'email', 'The :attribute format is invalid.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(270, 2, '*', 'validation', 'exists', 'The selected :attribute is invalid.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(271, 2, '*', 'validation', 'image', 'The :attribute must be an image.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(272, 2, '*', 'validation', 'in', 'The selected :attribute is invalid.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(273, 2, '*', 'validation', 'integer', 'The :attribute must be an integer.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(274, 2, '*', 'validation', 'ip', 'The :attribute must be a valid IP address.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(275, 2, '*', 'validation', 'max.numeric', 'The :attribute may not be greater than :max.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(276, 2, '*', 'validation', 'max.file', 'The :attribute may not be greater than :max kilobytes.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(277, 2, '*', 'validation', 'max.string', 'The :attribute may not be greater than :max characters.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(278, 2, '*', 'validation', 'max.array', 'The :attribute may not have more than :max items.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(279, 2, '*', 'validation', 'mimes', 'The :attribute must be a file of type: :values.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(280, 2, '*', 'validation', 'min.numeric', 'The :attribute must be at least :min.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(281, 2, '*', 'validation', 'min.file', 'The :attribute must be at least :min kilobytes.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(282, 2, '*', 'validation', 'min.string', 'The :attribute must be at least :min characters.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(283, 2, '*', 'validation', 'min.array', 'The :attribute must have at least :min items.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(284, 2, '*', 'validation', 'not_in', 'The selected :attribute is invalid.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(285, 2, '*', 'validation', 'numeric', 'The :attribute must be a number.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(286, 2, '*', 'validation', 'regex', 'The :attribute format is invalid.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(287, 2, '*', 'validation', 'required', 'The :attribute field is required.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(288, 2, '*', 'validation', 'required_if', 'The :attribute field is required when :other is :value.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(289, 2, '*', 'validation', 'required_with', 'The :attribute field is required when :values is present.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(290, 2, '*', 'validation', 'required_without', 'The :attribute field is required when :values is not present.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(291, 2, '*', 'validation', 'same', 'The :attribute and :other must match.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(292, 2, '*', 'validation', 'size.numeric', 'The :attribute must be :size.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(293, 2, '*', 'validation', 'size.file', 'The :attribute must be :size kilobytes.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(294, 2, '*', 'validation', 'size.string', 'The :attribute must be :size characters.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(295, 2, '*', 'validation', 'size.array', 'The :attribute must contain :size items.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(296, 2, '*', 'validation', 'unique', 'The :attribute has already been taken.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(297, 2, '*', 'validation', 'url', 'The :attribute format is invalid.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(298, 2, '*', 'validation', 'recaptcha', 'The :attribute field is not correct.', 1, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:14'),
(299, 1, '*', 'capabilities', 'site/members:view', 'View all site members', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(300, 1, '*', 'capabilities', 'site/members:search', 'Search site members', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(301, 1, '*', 'capabilities', 'site/members:message', 'Message a member', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(302, 1, '*', 'capabilities', 'site/alarm:view', 'View alarm', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(303, 1, '*', 'capabilities', 'site/alarm:update', 'Update alarm', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(304, 1, '*', 'capabilities', 'site/group:join', 'Join group', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(305, 1, '*', 'capabilities', 'site/group:leave', 'Leave group', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(306, 1, '*', 'capabilities', 'site/bugs:report', 'Report bugs', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(307, 1, '*', 'capabilities', 'site/language:choose', 'Choose language', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(308, 1, '*', 'capabilities', 'site/user:add', 'Add user', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(309, 1, '*', 'capabilities', 'site/user:delete', 'Delete user', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(310, 1, '*', 'capabilities', 'site/user:view', 'View user', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(311, 1, '*', 'capabilities', 'site/user:search', 'Search a user', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(312, 1, '*', 'capabilities', 'group/user:view', 'View user profile', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(313, 1, '*', 'capabilities', 'group/user:search', 'Search a group', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(314, 1, '*', 'capabilities', 'site/group:add', 'Add a group', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(315, 1, '*', 'capabilities', 'site/group:edit', 'Edit a group', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(316, 1, '*', 'capabilities', 'site/group:delete', 'Delete a group', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(317, 1, '*', 'capabilities', 'site/group:changestart', 'Change group start date', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(318, 1, '*', 'capabilities', 'site/group:joinmultiple', 'Join multiple groups', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(319, 1, '*', 'dice', 'rollthedice', 'Roll', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(320, 1, '*', 'dice', 'rollagain', 'Roll again', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(321, 1, '*', 'dice', 'yourolled', 'You rolled', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(322, 1, '*', 'dice', 'congyourolled', 'Congratulations, you rolled', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(323, 1, '*', 'dice', 'dicerollintro', '<h3>Play</h3>', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(324, 1, '*', 'dice', 'tasksavebtn', 'Accept', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(325, 1, '*', 'dice', 'todaysactivity', 'Today''s mission: ', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(326, 1, '*', 'master', 'welcome', 'Welcome to On A Roll 21', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(327, 1, '*', 'master', 'email', 'Email address', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(328, 1, '*', 'master', 'username', 'Username', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(329, 1, '*', 'master', 'firstname', 'First name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(330, 1, '*', 'master', 'lastname', 'Last name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(331, 1, '*', 'master', 'city', 'City', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(332, 1, '*', 'master', 'country', 'Country', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(333, 1, '*', 'master', 'taskname', 'Mission name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(334, 1, '*', 'master', 'taskauthor', 'Mission author', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(335, 1, '*', 'master', 'tasknameholder', 'Mission name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(336, 1, '*', 'master', 'taskdescription', 'Mission Description', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(337, 1, '*', 'master', 'didyouknow', 'Did you know', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(338, 1, '*', 'master', 'reference', 'Reference', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(339, 1, '*', 'master', 'password', 'Password', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(340, 1, '*', 'master', 'organisation', 'Organisation', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(341, 1, '*', 'master', 'description', 'Description', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(342, 1, '*', 'master', 'userpicture', 'Picture', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(343, 1, '*', 'master', 'editbtn', 'Edit', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(344, 1, '*', 'master', 'suspendbtn', 'Suspend', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(345, 1, '*', 'master', 'deletebtn', 'Delete', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(346, 1, '*', 'master', 'addnewuser', 'Add a new user', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(347, 1, '*', 'master', 'groupname', 'Team name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(348, 1, '*', 'master', 'groupdescription', 'Team description', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(349, 1, '*', 'master', 'groupstartdate', 'Start date', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(350, 1, '*', 'master', 'grouppicture', 'Picture', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(351, 1, '*', 'master', 'groupoutcome', 'Goal', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(352, 1, '*', 'master', 'groupsurvey', 'Pre-Survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(353, 1, '*', 'master', 'grouppostsurvey', 'Post-Survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(354, 1, '*', 'master', 'addgroup', 'Add Team', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(355, 1, '*', 'master', 'updategroup', 'Update Team', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(356, 1, '*', 'master', 'managegroup', 'Manage Team', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(357, 1, '*', 'master', 'addtask', 'Add Mission', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(358, 1, '*', 'master', 'addnewtask', 'Add a new Mission', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(359, 1, '*', 'master', 'updatetask', 'Update Mission', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(360, 1, '*', 'master', 'loginusername', 'Username', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(361, 1, '*', 'master', 'loginpassword', 'Password', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(362, 1, '*', 'master', 'loginbtn', 'Log in', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(363, 1, '*', 'master', 'emptyusername', 'Username must be supplied', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(364, 1, '*', 'master', 'emptypassword', 'Password must be supplied', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(365, 1, '*', 'master', 'incorrectlogin', 'Oops! We cannot verify the login details. Please try again.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(366, 1, '*', 'master', 'logoutsuccess', 'You have been successfully logged out', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(367, 1, '*', 'master', 'joingroup', 'Join', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(368, 1, '*', 'master', 'leavegroup', 'Leave', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(369, 1, '*', 'master', 'viewgroup', 'View Team', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(370, 1, '*', 'master', 'outcomename', 'Goal name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(371, 1, '*', 'master', 'outcomedescription', 'Goal description', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(372, 1, '*', 'master', 'addoutcome', 'Add Goal', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(373, 1, '*', 'master', 'activatebtn', 'Activate', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(374, 1, '*', 'master', 'updateoutcome', 'Update', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:12'),
(375, 1, '*', 'master', 'addbtn', 'Add', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(376, 1, '*', 'master', 'removebtn', 'Remove', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(377, 1, '*', 'master', 'addremoveusers', 'Add/Remove users', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(378, 1, '*', 'master', 'addnewrole', 'Add a new role', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(379, 1, '*', 'master', 'adduserbtn', 'Add', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(380, 1, '*', 'master', 'name', 'Name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(381, 1, '*', 'master', 'action', 'Action', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(382, 1, '*', 'master', 'upbtn', 'Up', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(383, 1, '*', 'master', 'dwnbtn', 'Down', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(384, 1, '*', 'master', 'signup', 'New to On A Roll 21? :clickhere to get started', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(385, 1, '*', 'master', 'clickhere', 'Click here', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(386, 1, '*', 'master', 'registersuccess', 'Your account has been created successfully.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(387, 1, '*', 'master', 'choose', 'Choose', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(388, 1, '*', 'master', 'sharebtn', 'Share', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(389, 1, '*', 'master', 'lblstatusbox', 'Status:', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(390, 1, '*', 'master', 'play', 'Play', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(391, 1, '*', 'master', 'uploadimage', 'Upload image..', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(392, 1, '*', 'master', 'sendreminder', 'Send request', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(393, 1, '*', 'master', 'forgotpasswordtext', 'Please enter the email address you submitted at signup so we can send you a unique link where you can reset your password.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(394, 1, '*', 'master', 'emailfromname', 'On A Roll 21', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(395, 1, '*', 'master', 'comment', 'Comment', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(396, 1, '*', 'master', 'signupbtn', 'Sign up', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(397, 1, '*', 'master', 'createaccount', 'sign up', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(398, 1, '*', 'master', 'unlike', 'Unlike', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(399, 1, '*', 'master', 'like', 'Like', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(400, 1, '*', 'master', 'markcomplete', 'Mark complete', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(401, 1, '*', 'master', 'starttime', 'Start date', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(402, 1, '*', 'master', 'addrole', 'Add role', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(403, 1, '*', 'master', 'updaterole', 'Update role', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(404, 1, '*', 'master', 'markfinalbtn', 'Mark final', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(405, 1, '*', 'master', 'removefinal', 'Remove final mission', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(406, 1, '*', 'master', 'fewtasks', 'Missions < 21', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(407, 1, '*', 'master', 'forgotpassword', 'Forgot password?', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(408, 1, '*', 'master', 'savesurvey', 'Save survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13');
INSERT INTO `language_entries` (`id`, `language_id`, `namespace`, `group`, `item`, `text`, `unstable`, `locked`, `created_at`, `updated_at`) VALUES
(409, 1, '*', 'master', 'wellbeingsavebtn', 'Accept', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(410, 1, '*', 'master', 'addnewsurvey', 'Add new survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(411, 1, '*', 'master', 'nosurveys', 'There are no surveys for this Team to complete. Please select "Add new survey" if you wish to include.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(412, 1, '*', 'master', 'addfieldsbtn', 'Add/removefields', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(413, 1, '*', 'master', 'login', 'Log in', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(414, 1, '*', 'master', 'noaccount', 'Don''t have an account?', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(415, 1, '*', 'master', 'wanttolearnmore', 'Want to learn more?', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(416, 1, '*', 'master', 'seehow', 'See how On A Roll 21 helps you work better', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(417, 1, '*', 'master', 'haveaccount', 'Already have an account?', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(418, 1, '*', 'master', 'or', 'or', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(419, 1, '*', 'master', 'resetpassword', 'Reset your password', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(420, 1, '*', 'master', 'signupheading', 'Sign up for On A Roll 21', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(421, 1, '*', 'master', 'about', 'About On A Roll 21', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(422, 1, '*', 'master', 'contact', 'Contact Us', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(423, 1, '*', 'master', 'businessbenefits', 'Business benefits', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(424, 1, '*', 'master', 'tos', 'Terms of use', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(425, 1, '*', 'master', 'privacy', 'Privacy policy', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(426, 1, '*', 'master', 'report', 'Report abuse', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(427, 1, '*', 'master', 'register', 'Sign up', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(428, 1, '*', 'master', 'groupsintro', '<br />Hi :name!\n    <br /><br />\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select "Join" to choose which team to play in or "Leave" to remove yourself from the team. Select a team name for further team info.</p><br />', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(429, 1, '*', 'master', 'playintro', '<br />Hi :name!\n    <br /><br />\n    <p>    \n    You are currently a member of more than one team. Select "Play" against the team you want to roll with.</p><br />', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(430, 1, '*', 'master', 'playgroupsintro', '<br />Hi :name!\n    <br /><br />\n    <p>    \n    Here are the teams that are available for you to join. \n    Simply select "Join" to choose which team to play in or "Leave" to remove yourself from the team. Select a team name for further team info.</p><br />', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(431, 1, '*', 'master', 'datejoined', 'Date joined:', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(432, 1, '*', 'master', 'viewprofile', 'Profile', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(433, 1, '*', 'master', 'message', 'Message', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(434, 1, '*', 'master', 'members', 'Rollers', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(435, 1, '*', 'master', 'membersintro', '<br />Hi :name!\n    <br /><br />\n    <p>Here are the rollers that are in your team. Simply select "Profile" (or their name) to view a roller. You can send a message to a roller by selecting "Message".</p>', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(436, 1, '*', 'master', 'addagroup', 'Add a Team', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(437, 1, '*', 'master', 'getstarted', 'Get started', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(438, 1, '*', 'master', 'sitesettings', 'Site settings', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(439, 1, '*', 'master', 'assigncapabilities', 'Assign capabilities', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(440, 1, '*', 'master', 'roll', 'Roll', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(441, 1, '*', 'master', 'done', 'Done', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(442, 1, '*', 'master', 'statuspagewelcome', 'Hi :name!', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(443, 1, '*', 'master', 'homepageintrotop', 'ON A ROLL 21&TRADE; is a digital behaviour change program that helps promote happiness, wellbeing and productivity in 21 days.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(444, 1, '*', 'master', 'homepageintrobottom', '"Waiting to be happy limits our brain''s potential for success, \n                    whereas if we can help cultivate a positive brain \n                    it makes us more motivated, efficient, resilient, creative and productive,\n                    all of which drive improved health outcomes and performance." <br />- Lisa Mcleod, Clinical Psychologist and On A Roll 21 program inventor', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(445, 1, '*', 'master', 'howdidyouroll', 'How did you roll?', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(446, 1, '*', 'master', 'howtoplay', 'How to play', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(447, 1, '*', 'master', 'aboutus', 'About On A Roll 21', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(448, 1, '*', 'master', 'surveypageintrotop', '<h5>Welcome to On A Roll 21!</h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.</p>\n', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(449, 1, '*', 'master', 'surveypageintrobottom', 'The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program’s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On a Roll 21 program designers.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(450, 1, '*', 'master', 'presurveyhead', 'On A Roll 21 Pre-Survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(451, 1, '*', 'master', 'postsurveyhead', 'On A Roll 21 Post-Survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(452, 1, '*', 'master', 'postsurveypageintrotop', '<h5>Welcome to On A Roll 21!</h5>\n        <p>Please complete the following brief survey before your participation in the 21-day program.</p>', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(453, 1, '*', 'master', 'postsurveypageintrobottom', 'The survey has a total of 23 questions, which are all multiple \n        choice with the opportunity for comments at the end. It should take \n        you about 3 to 5 minutes to complete. It is important that you answer \n        each question honestly. Your answers will be treated with strict \n        confidentiality and respect, and will be collated for the sole purpose \n        of understanding the effectiveness of the program’s aims and objectives. \n        Individuals will not be identified in the information submitted. All data \n        derived from this survey will be stored in a database, \n        which is password protected, and can only be accessed \n        by On a Roll 21 program designers.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(454, 1, '*', 'master', 'logoalt', 'On A Roll 21 logo', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(455, 1, '*', 'master', 'howareyoufeeling', 'How are you feeling?', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(456, 1, '*', 'master', 'nopresurvey', 'It appears that you have not completed the Pre-Survey. Please complete so we can track how you''re travelling during On A Roll 21.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(457, 1, '*', 'master', 'commentboxplaceholder', 'Write your comment here', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(458, 1, '*', 'master', 'wellbeinghistory', 'Mood Map', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(459, 1, '*', 'master', 'postsurveypopupintro', 'Congratulations! You have now reached day 21. One last surprise mission awaits. We ask that you first complete this post-survey to help us track how you progressed during the program. Thank you!', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(460, 1, '*', 'master', 'postsurveypopuphead', 'Post survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(461, 1, '*', 'master', 'presurveypopuphead', 'Pre survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(462, 1, '*', 'master', 'day', 'Day', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(463, 1, '*', 'master', 'daysleft', 'Days left', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(464, 1, '*', 'master', 'acceptedtasks', 'Accepted missions', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(465, 1, '*', 'master', 'signupagreement', 'By selecting "create account" you accept the following <a href="/page/tos">terms and conditions</a> and our <a href="/page/privacy">privacy policy</a>', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(466, 1, '*', 'master', 'anonymous', 'Anonymous', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(467, 1, '*', 'master', 'rollername', 'Roller name', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(468, 1, '*', 'master', 'postsurvey', 'Post survey', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(469, 1, '*', 'master', 'loading', 'Loading...', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(470, 1, '*', 'master', 'sendmessage', 'Send message', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(471, 1, '*', 'master', 'contactthanks', 'Thank you. You message has been sent successfully', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(472, 1, '*', 'master', 'offender', 'Offender', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(473, 1, '*', 'master', 'group', 'Team', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(474, 1, '*', 'master', 'persontoreport', 'Person to report', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(475, 1, '*', 'master', 'statusareadisabler', 'Please roll the dice and accept your mission before posting.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(476, 1, '*', 'master', 'currenttask', '<b>Your mission in progress</b>', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(477, 1, '*', 'master', 'mood_fantastic', 'Fantastic', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(478, 1, '*', 'master', 'mood_prettygood', 'Pretty good', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(479, 1, '*', 'master', 'mood_neutral', 'Okay', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(480, 1, '*', 'master', 'mood_notgreat', 'Not great', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(481, 1, '*', 'master', 'mood_terrible', 'Terrible', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(482, 1, '*', 'master', 'mood_sel_message', 'Your response will be anonymous and averaged across the team. It will not be visible to other team members.', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(483, 1, '*', 'master', 'addanewuser', 'Add a new user', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(484, 1, '*', 'master', 'updateuser', 'Update user', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(485, 1, '*', 'master', 'editprofile', 'Edit profile', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(486, 1, '*', 'master', 'joined', 'Joined', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(487, 1, '*', 'master', 'addmessagesbtn', 'Messages', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(488, 1, '*', 'master', 'ok', 'OK', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(489, 1, '*', 'master', 'thankyou', 'Thank you!', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(490, 1, '*', 'master', 'systemlanguages', 'System languages', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(491, 1, '*', 'master', 'language', 'Language', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(492, 1, '*', 'master', 'langshortcode', 'Shortcode', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(493, 1, '*', 'master', 'edit', 'Edit', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(494, 1, '*', 'master', 'editinglanguage', 'Editing :lang language', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(495, 1, '*', 'menu', 'home', 'Home', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(496, 1, '*', 'menu', 'instructions', 'Instructions', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(497, 1, '*', 'menu', 'groups', 'Teams', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(498, 1, '*', 'menu', 'surveys', 'Surveys', 0, 0, '2014-04-13 15:24:09', '2014-06-15 09:52:13'),
(499, 1, '*', 'menu', 'presurvey', 'Pre-survey', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(500, 1, '*', 'menu', 'postsurvey', 'Post-survey', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(501, 1, '*', 'menu', 'play', 'Play', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(502, 1, '*', 'menu', 'users', 'Users', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(503, 1, '*', 'menu', 'manageusers', 'Manage users', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(504, 1, '*', 'menu', 'addauser', 'Add a user', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(505, 1, '*', 'menu', 'creategroup', 'Create team', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(506, 1, '*', 'menu', 'tasks', 'Missions', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(507, 1, '*', 'menu', 'createnewtask', 'Create new mission', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(508, 1, '*', 'menu', 'managetasks', 'Manage missions', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(509, 1, '*', 'menu', 'createnewoutcome', 'Create new goal', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(510, 1, '*', 'menu', 'manageoutcomes', 'Manage goals', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(511, 1, '*', 'menu', 'options', 'Options', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(512, 1, '*', 'menu', 'logout', 'Log out', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(513, 1, '*', 'menu', 'editprofile', 'Update profile', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(514, 1, '*', 'menu', 'viewprofile', 'View profile', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(515, 1, '*', 'menu', 'managegroups', 'Manage teams', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(516, 1, '*', 'menu', 'outcomes', 'Goals', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(517, 1, '*', 'menu', 'roles', 'Roles', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(518, 1, '*', 'menu', 'assignroles', 'Assign roles', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(519, 1, '*', 'menu', 'managesurveys', 'Manage surveys', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(520, 1, '*', 'menu', 'addsurvey', 'Add survey', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(521, 1, '*', 'menu', 'roll', 'Roll!', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(522, 1, '*', 'menu', 'getstarted', 'Get started', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(523, 1, '*', 'menu', 'howtoplay', 'How to play On A Roll 21', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(524, 1, '*', 'menu', 'sitesettings', 'Site settings', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(525, 1, '*', 'menu', 'assigncapabilities', 'Assign capabilities', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(526, 1, '*', 'menu', 'messages', 'Messages', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(527, 1, '*', 'menu', 'language', 'Language', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(528, 1, '*', 'menu', 'profile', 'Profile', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(529, 1, '*', 'menu', 'settings', 'Settings', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(530, 1, '*', 'pagination', 'previous', '&laquo; Previous', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(531, 1, '*', 'pagination', 'next', 'Next &raquo;', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(532, 1, '*', 'profile', 'team', 'Team:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(533, 1, '*', 'profile', 'motto', 'Motto:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(534, 1, '*', 'profile', 'phone', 'Ph:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(535, 1, '*', 'profile', 'email', 'Work email:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(536, 1, '*', 'profile', 'contact', 'Contact:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(537, 1, '*', 'profile', 'stats', 'Stats:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(538, 1, '*', 'profile', 'messages', 'Messages:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(539, 1, '*', 'profile', 'taskscompleted', 'Missions completed:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(540, 1, '*', 'profile', 'joined', 'Joined:', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(541, 1, '*', 'profile', 'terrible', 'Terrible', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(542, 1, '*', 'profile', 'notgreat', 'Not great', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(543, 1, '*', 'profile', 'prettygood', 'Pretty good', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(544, 1, '*', 'profile', 'fantastic', 'Fantastic', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(545, 1, '*', 'profile', 'neutral', 'Okay', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(546, 1, '*', 'reminders', 'password', 'Passwords must be at least six characters and match the confirmation.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(547, 1, '*', 'reminders', 'user', 'We can''t find a user with that email address.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(548, 1, '*', 'reminders', 'token', 'This password reset token is invalid.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(549, 1, '*', 'reminders', 'sent', 'Password reminder sent!', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(550, 1, '*', 'survey', 'welcomeheading', '<h3>Welcome to On A Roll 21!</h3>', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(551, 1, '*', 'survey', 'presurveyintro', '<p>Please complete the following brief survey <b>before</b> your \n                        participation in the 21-day program.</p>\n                    <p>The survey has a total of 23 questions, which are all \n                    multiple choice with the opportunity for comments at the end. \n                    It should take you about 3 to 5 minutes to complete. It is \n                    important that you answer each question honestly. Your answers\n                    will be treated with strict confidentiality and respect, and \n                    will be collated for the sole purpose of understanding the \n                    effectiveness of the program’s aims and objectives. Individuals \n                    will not be identified in the information submitted. All data \n                    derived from this survey will be stored in a database, \n                    which is password protected, and can only be accessed \n                    by En Masse program designers.</p>', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(552, 1, '*', 'survey', 'pre_gender', 'Gender', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(553, 1, '*', 'survey', 'pre_age', 'Age', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(554, 1, '*', 'survey', 'pre_employmenttype', 'Employment type', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(555, 1, '*', 'survey', 'pre_fulltime', 'Full time', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(556, 1, '*', 'survey', 'pre_parttime', 'Part time', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(557, 1, '*', 'survey', 'pre_selfemployed', 'Self employed', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(558, 1, '*', 'survey', 'pre_contract', 'Contract', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(559, 1, '*', 'survey', 'surveyintro', 'Survey introduction', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(560, 1, '*', 'survey', 'surveyconclusion', 'Survey conclusion', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(561, 1, '*', 'survey', 'savemsgbtn', 'Save', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(562, 1, '*', 'survey', 'updatesurveybtn', 'Update survey', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(563, 1, '*', 'survey', 'prepostmessageheading', 'Survey Introduction and conclusion messages', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(564, 1, '*', 'validation', 'accepted', 'The :attribute must be accepted.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(565, 1, '*', 'validation', 'active_url', 'The :attribute is not a valid URL.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(566, 1, '*', 'validation', 'after', 'The :attribute must be a date after :date.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(567, 1, '*', 'validation', 'alpha', 'The :attribute may only contain letters.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(568, 1, '*', 'validation', 'alpha_dash', 'The :attribute may only contain letters, numbers, and dashes.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(569, 1, '*', 'validation', 'alpha_num', 'The :attribute may only contain letters and numbers.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(570, 1, '*', 'validation', 'array', 'The :attribute must be an array.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(571, 1, '*', 'validation', 'before', 'The :attribute must be a date before :date.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(572, 1, '*', 'validation', 'between.numeric', 'The :attribute must be between :min and :max.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(573, 1, '*', 'validation', 'between.file', 'The :attribute must be between :min and :max kilobytes.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(574, 1, '*', 'validation', 'between.string', 'The :attribute must be between :min and :max characters.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(575, 1, '*', 'validation', 'between.array', 'The :attribute must have between :min and :max items.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(576, 1, '*', 'validation', 'confirmed', 'The :attribute confirmation does not match.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(577, 1, '*', 'validation', 'date', 'The :attribute is not a valid date.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(578, 1, '*', 'validation', 'date_format', 'The :attribute does not match the format :format.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(579, 1, '*', 'validation', 'different', 'The :attribute and :other must be different.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(580, 1, '*', 'validation', 'digits', 'The :attribute must be :digits digits.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(581, 1, '*', 'validation', 'digits_between', 'The :attribute must be between :min and :max digits.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(582, 1, '*', 'validation', 'email', 'The :attribute format is invalid.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(583, 1, '*', 'validation', 'exists', 'The selected :attribute is invalid.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(584, 1, '*', 'validation', 'image', 'The :attribute must be an image.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(585, 1, '*', 'validation', 'in', 'The selected :attribute is invalid.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(586, 1, '*', 'validation', 'integer', 'The :attribute must be an integer.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(587, 1, '*', 'validation', 'ip', 'The :attribute must be a valid IP address.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(588, 1, '*', 'validation', 'max.numeric', 'The :attribute may not be greater than :max.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(589, 1, '*', 'validation', 'max.file', 'The :attribute may not be greater than :max kilobytes.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(590, 1, '*', 'validation', 'max.string', 'The :attribute may not be greater than :max characters.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:13'),
(591, 1, '*', 'validation', 'max.array', 'The :attribute may not have more than :max items.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(592, 1, '*', 'validation', 'mimes', 'The :attribute must be a file of type: :values.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(593, 1, '*', 'validation', 'min.numeric', 'The :attribute must be at least :min.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(594, 1, '*', 'validation', 'min.file', 'The :attribute must be at least :min kilobytes.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(595, 1, '*', 'validation', 'min.string', 'The :attribute must be at least :min characters.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(596, 1, '*', 'validation', 'min.array', 'The :attribute must have at least :min items.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(597, 1, '*', 'validation', 'not_in', 'The selected :attribute is invalid.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(598, 1, '*', 'validation', 'numeric', 'The :attribute must be a number.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(599, 1, '*', 'validation', 'regex', 'The :attribute format is invalid.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(600, 1, '*', 'validation', 'required', 'The :attribute field is required.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(601, 1, '*', 'validation', 'required_if', 'The :attribute field is required when :other is :value.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(602, 1, '*', 'validation', 'required_with', 'The :attribute field is required when :values is present.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(603, 1, '*', 'validation', 'required_without', 'The :attribute field is required when :values is not present.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(604, 1, '*', 'validation', 'same', 'The :attribute and :other must match.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(605, 1, '*', 'validation', 'size.numeric', 'The :attribute must be :size.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(606, 1, '*', 'validation', 'size.file', 'The :attribute must be :size kilobytes.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(607, 1, '*', 'validation', 'size.string', 'The :attribute must be :size characters.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(608, 1, '*', 'validation', 'size.array', 'The :attribute must contain :size items.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(609, 1, '*', 'validation', 'unique', 'The :attribute has already been taken.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(610, 1, '*', 'validation', 'url', 'The :attribute format is invalid.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14'),
(611, 1, '*', 'validation', 'recaptcha', 'The :attribute field is not correct.', 0, 0, '2014-04-13 15:24:10', '2014-06-15 09:52:14');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `post_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 583, 135, '2015-03-18 12:02:53', '2015-03-18 12:02:53'),
(2, 583, 134, '2015-03-18 12:02:57', '2015-03-18 12:02:57'),
(4, 595, 141, '2015-03-19 06:19:06', '2015-03-19 06:19:06'),
(5, 602, 144, '2015-03-20 04:42:37', '2015-03-20 04:42:37'),
(6, 601, 143, '2015-03-20 04:42:38', '2015-03-20 04:42:38'),
(7, 603, 149, '2015-03-20 04:47:26', '2015-03-20 04:47:26'),
(8, 602, 149, '2015-03-20 04:47:29', '2015-03-20 04:47:29'),
(9, 605, 152, '2015-03-20 04:55:31', '2015-03-20 04:55:31'),
(10, 612, 142, '2015-03-21 00:10:36', '2015-03-21 00:10:36'),
(11, 612, 158, '2015-03-21 04:26:00', '2015-03-21 04:26:00'),
(12, 610, 158, '2015-03-21 04:26:31', '2015-03-21 04:26:31'),
(14, 617, 166, '2015-03-29 23:42:32', '2015-03-29 23:42:32'),
(15, 618, 178, '2015-03-30 21:18:26', '2015-03-30 21:18:26'),
(16, 624, 192, '2015-03-31 05:29:12', '2015-03-31 05:29:12'),
(17, 624, 193, '2015-03-31 05:45:36', '2015-03-31 05:45:36'),
(18, 625, 190, '2015-03-31 07:43:49', '2015-03-31 07:43:49'),
(19, 626, 178, '2015-03-31 21:18:03', '2015-03-31 21:18:03'),
(20, 622, 178, '2015-03-31 21:18:10', '2015-03-31 21:18:10'),
(21, 628, 178, '2015-04-01 10:36:24', '2015-04-01 10:36:24'),
(22, 627, 178, '2015-04-01 10:38:04', '2015-04-01 10:38:04'),
(23, 633, 178, '2015-04-02 22:11:45', '2015-04-02 22:11:45'),
(24, 639, 178, '2015-04-02 22:12:02', '2015-04-02 22:12:02'),
(25, 640, 178, '2015-04-07 22:50:48', '2015-04-07 22:50:48'),
(26, 638, 224, '2015-04-08 03:31:36', '2015-04-08 03:31:36'),
(27, 625, 224, '2015-04-08 03:31:36', '2015-04-08 03:31:36'),
(28, 624, 224, '2015-04-08 03:31:39', '2015-04-08 03:31:39'),
(29, 614, 237, '2015-04-08 09:45:37', '2015-04-08 09:45:37'),
(30, 608, 237, '2015-04-08 09:46:04', '2015-04-08 09:46:04'),
(31, 643, 242, '2015-04-08 21:45:01', '2015-04-08 21:45:01'),
(32, 645, 224, '2015-04-08 22:56:56', '2015-04-08 22:56:56'),
(33, 648, 224, '2015-04-08 22:57:16', '2015-04-08 22:57:16'),
(34, 645, 193, '2015-04-09 06:45:33', '2015-04-09 06:45:33'),
(35, 638, 193, '2015-04-09 06:45:45', '2015-04-09 06:45:45'),
(37, 643, 193, '2015-04-09 07:21:16', '2015-04-09 07:21:16'),
(38, 648, 193, '2015-04-09 09:44:16', '2015-04-09 09:44:16'),
(39, 655, 232, '2015-04-09 10:10:13', '2015-04-09 10:10:13'),
(40, 651, 190, '2015-04-09 22:47:02', '2015-04-09 22:47:02'),
(41, 645, 190, '2015-04-09 22:47:12', '2015-04-09 22:47:12'),
(42, 643, 190, '2015-04-09 22:47:16', '2015-04-09 22:47:16'),
(43, 655, 190, '2015-04-09 22:48:54', '2015-04-09 22:48:54'),
(44, 659, 193, '2015-04-09 22:56:10', '2015-04-09 22:56:10'),
(45, 655, 224, '2015-04-09 23:23:08', '2015-04-09 23:23:08'),
(46, 658, 248, '2015-04-09 23:42:21', '2015-04-09 23:42:21'),
(47, 657, 248, '2015-04-09 23:42:31', '2015-04-09 23:42:31'),
(48, 656, 248, '2015-04-09 23:42:39', '2015-04-09 23:42:39'),
(49, 662, 193, '2015-04-10 00:24:49', '2015-04-10 00:24:49'),
(50, 661, 193, '2015-04-10 00:24:59', '2015-04-10 00:24:59'),
(51, 662, 190, '2015-04-10 00:34:37', '2015-04-10 00:34:37'),
(52, 651, 234, '2015-04-10 05:51:56', '2015-04-10 05:51:56'),
(53, 652, 234, '2015-04-10 05:52:01', '2015-04-10 05:52:01'),
(54, 662, 234, '2015-04-10 05:52:12', '2015-04-10 05:52:12'),
(55, 658, 258, '2015-04-10 10:51:45', '2015-04-10 10:51:45'),
(56, 665, 258, '2015-04-10 10:51:47', '2015-04-10 10:51:47'),
(57, 656, 258, '2015-04-10 10:52:01', '2015-04-10 10:52:01'),
(58, 667, 193, '2015-04-12 22:05:16', '2015-04-12 22:05:16'),
(59, 667, 224, '2015-04-12 22:06:25', '2015-04-12 22:06:25'),
(60, 672, 193, '2015-04-12 22:13:35', '2015-04-12 22:13:35'),
(61, 670, 258, '2015-04-12 22:57:51', '2015-04-12 22:57:51'),
(62, 669, 258, '2015-04-12 22:57:58', '2015-04-12 22:57:58'),
(63, 668, 258, '2015-04-12 22:58:08', '2015-04-12 22:58:08'),
(64, 671, 248, '2015-04-12 23:47:49', '2015-04-12 23:47:49'),
(65, 670, 248, '2015-04-12 23:47:58', '2015-04-12 23:47:58'),
(66, 669, 248, '2015-04-12 23:48:07', '2015-04-12 23:48:07'),
(67, 668, 248, '2015-04-12 23:48:14', '2015-04-12 23:48:14'),
(68, 665, 259, '2015-04-13 00:24:28', '2015-04-13 00:24:28'),
(69, 673, 180, '2015-04-13 00:27:48', '2015-04-13 00:27:48'),
(70, 652, 228, '2015-04-13 02:09:32', '2015-04-13 02:09:32'),
(71, 681, 259, '2015-04-13 22:38:11', '2015-04-13 22:38:11'),
(72, 676, 274, '2015-04-13 22:51:41', '2015-04-13 22:51:41'),
(73, 671, 274, '2015-04-13 22:51:44', '2015-04-13 22:51:44'),
(74, 670, 274, '2015-04-13 22:51:49', '2015-04-13 22:51:49'),
(75, 669, 274, '2015-04-13 22:51:56', '2015-04-13 22:51:56'),
(76, 665, 274, '2015-04-13 22:52:10', '2015-04-13 22:52:10'),
(77, 691, 234, '2015-04-14 22:28:01', '2015-04-14 22:28:01'),
(78, 692, 274, '2015-04-14 23:58:52', '2015-04-14 23:58:52'),
(79, 692, 292, '2015-04-15 03:50:02', '2015-04-15 03:50:02'),
(80, 669, 292, '2015-04-15 03:51:51', '2015-04-15 03:51:51'),
(81, 668, 292, '2015-04-15 03:52:06', '2015-04-15 03:52:06'),
(82, 693, 281, '2015-04-16 00:57:07', '2015-04-16 00:57:07'),
(83, 615, 281, '2015-04-16 00:57:38', '2015-04-16 00:57:38'),
(84, 707, 193, '2015-04-16 05:32:19', '2015-04-16 05:32:19'),
(85, 708, 282, '2015-04-16 06:14:46', '2015-04-16 06:14:46'),
(86, 711, 259, '2015-04-17 03:02:52', '2015-04-17 03:02:52'),
(87, 715, 193, '2015-04-17 22:04:24', '2015-04-17 22:04:24'),
(88, 714, 193, '2015-04-17 22:04:27', '2015-04-17 22:04:27'),
(89, 716, 291, '2015-04-18 01:26:36', '2015-04-18 01:26:36'),
(90, 710, 224, '2015-04-19 22:34:43', '2015-04-19 22:34:43'),
(91, 708, 224, '2015-04-19 22:35:07', '2015-04-19 22:35:07'),
(92, 713, 248, '2015-04-20 00:40:45', '2015-04-20 00:40:45'),
(93, 717, 248, '2015-04-20 00:40:49', '2015-04-20 00:40:49'),
(94, 719, 248, '2015-04-20 00:41:13', '2015-04-20 00:41:13'),
(95, 711, 248, '2015-04-20 00:43:29', '2015-04-20 00:43:29'),
(96, 702, 248, '2015-04-20 00:43:40', '2015-04-20 00:43:40'),
(97, 701, 248, '2015-04-20 00:44:00', '2015-04-20 00:44:00'),
(98, 696, 248, '2015-04-20 00:44:07', '2015-04-20 00:44:07'),
(99, 689, 248, '2015-04-20 00:45:33', '2015-04-20 00:45:33'),
(100, 681, 248, '2015-04-20 00:46:22', '2015-04-20 00:46:22'),
(101, 692, 301, '2015-04-20 02:48:51', '2015-04-20 02:48:51'),
(102, 689, 301, '2015-04-20 02:48:57', '2015-04-20 02:48:57'),
(103, 719, 301, '2015-04-20 02:55:46', '2015-04-20 02:55:46'),
(104, 718, 301, '2015-04-20 02:55:52', '2015-04-20 02:55:52'),
(105, 717, 301, '2015-04-20 02:56:00', '2015-04-20 02:56:00'),
(106, 720, 259, '2015-04-20 03:13:42', '2015-04-20 03:13:42'),
(108, 720, 300, '2015-04-20 04:43:00', '2015-04-20 04:43:00'),
(109, 723, 280, '2015-04-20 04:55:47', '2015-04-20 04:55:47'),
(110, 721, 316, '2015-04-20 06:22:59', '2015-04-20 06:22:59'),
(111, 647, 243, '2015-04-20 07:20:19', '2015-04-20 07:20:19'),
(112, 723, 288, '2015-04-20 22:52:06', '2015-04-20 22:52:06'),
(113, 723, 274, '2015-04-21 10:06:23', '2015-04-21 10:06:23'),
(114, 732, 193, '2015-04-22 01:27:25', '2015-04-22 01:27:25'),
(115, 724, 304, '2015-04-22 01:41:27', '2015-04-22 01:41:27'),
(116, 734, 318, '2015-04-22 03:24:34', '2015-04-22 03:24:34'),
(117, 736, 308, '2015-04-23 07:03:10', '2015-04-23 07:03:10'),
(118, 724, 323, '2015-04-23 23:21:29', '2015-04-23 23:21:29'),
(119, 746, 248, '2015-04-24 06:03:23', '2015-04-24 06:03:23'),
(120, 742, 248, '2015-04-24 06:04:12', '2015-04-24 06:04:12'),
(121, 740, 248, '2015-04-24 06:04:43', '2015-04-24 06:04:43'),
(122, 739, 248, '2015-04-24 06:04:47', '2015-04-24 06:04:47'),
(123, 734, 248, '2015-04-24 06:04:58', '2015-04-24 06:04:58'),
(124, 730, 248, '2015-04-24 06:05:23', '2015-04-24 06:05:23'),
(125, 727, 248, '2015-04-24 06:05:44', '2015-04-24 06:05:44'),
(126, 723, 248, '2015-04-24 06:05:48', '2015-04-24 06:05:48'),
(127, 738, 193, '2015-04-24 07:09:16', '2015-04-24 07:09:16'),
(128, 752, 299, '2015-04-25 01:36:11', '2015-04-25 01:36:11'),
(129, 760, 259, '2015-04-27 19:39:43', '2015-04-27 19:39:43'),
(130, 767, 325, '2015-04-27 23:26:58', '2015-04-27 23:26:58'),
(131, 771, 342, '2015-04-28 20:49:30', '2015-04-28 20:49:30'),
(132, 767, 320, '2015-04-28 22:15:01', '2015-04-28 22:15:01'),
(133, 775, 342, '2015-04-29 02:50:09', '2015-04-29 02:50:09'),
(134, 782, 342, '2015-04-29 22:30:02', '2015-04-29 22:30:02'),
(135, 781, 342, '2015-04-29 22:33:43', '2015-04-29 22:33:43'),
(136, 782, 354, '2015-04-30 00:07:04', '2015-04-30 00:07:04'),
(137, 783, 299, '2015-04-30 00:33:38', '2015-04-30 00:33:38'),
(138, 785, 353, '2015-04-30 02:19:53', '2015-04-30 02:19:53'),
(139, 785, 342, '2015-04-30 03:34:36', '2015-04-30 03:34:36'),
(140, 787, 342, '2015-04-30 05:58:41', '2015-04-30 05:58:41'),
(141, 792, 353, '2015-04-30 22:43:49', '2015-04-30 22:43:49'),
(142, 792, 342, '2015-04-30 23:49:32', '2015-04-30 23:49:32'),
(143, 793, 342, '2015-04-30 23:49:48', '2015-04-30 23:49:48'),
(144, 793, 344, '2015-05-01 00:16:16', '2015-05-01 00:16:16'),
(145, 792, 344, '2015-05-01 00:16:21', '2015-05-01 00:16:21'),
(146, 790, 344, '2015-05-01 00:16:26', '2015-05-01 00:16:26'),
(147, 789, 344, '2015-05-01 00:16:31', '2015-05-01 00:16:31'),
(148, 785, 344, '2015-05-01 00:16:42', '2015-05-01 00:16:42'),
(149, 782, 344, '2015-05-01 00:16:45', '2015-05-01 00:16:45'),
(150, 781, 344, '2015-05-01 00:16:52', '2015-05-01 00:16:52'),
(151, 774, 344, '2015-05-01 00:16:58', '2015-05-01 00:16:58'),
(152, 771, 344, '2015-05-01 00:17:02', '2015-05-01 00:17:02'),
(153, 794, 353, '2015-05-01 01:38:20', '2015-05-01 01:38:20'),
(154, 794, 354, '2015-05-01 02:17:34', '2015-05-01 02:17:34'),
(155, 798, 344, '2015-05-01 04:21:54', '2015-05-01 04:21:54'),
(156, 799, 353, '2015-05-01 05:34:17', '2015-05-01 05:34:17'),
(157, 798, 353, '2015-05-01 05:34:25', '2015-05-01 05:34:25'),
(158, 794, 342, '2015-05-01 07:45:49', '2015-05-01 07:45:49'),
(159, 798, 342, '2015-05-01 07:46:12', '2015-05-01 07:46:12'),
(160, 799, 342, '2015-05-01 07:46:30', '2015-05-01 07:46:30'),
(161, 799, 354, '2015-05-03 23:58:47', '2015-05-03 23:58:47'),
(162, 799, 344, '2015-05-04 00:17:14', '2015-05-04 00:17:14'),
(163, 800, 344, '2015-05-04 00:17:33', '2015-05-04 00:17:33'),
(164, 801, 344, '2015-05-04 00:17:38', '2015-05-04 00:17:38'),
(165, 807, 344, '2015-05-04 05:14:12', '2015-05-04 05:14:12'),
(166, 805, 342, '2015-05-04 06:12:34', '2015-05-04 06:12:34'),
(167, 818, 342, '2015-05-05 04:17:21', '2015-05-05 04:17:21'),
(168, 817, 353, '2015-05-05 05:10:51', '2015-05-05 05:10:51'),
(169, 819, 354, '2015-05-05 05:13:00', '2015-05-05 05:13:00'),
(170, 818, 354, '2015-05-05 05:13:18', '2015-05-05 05:13:18'),
(171, 817, 354, '2015-05-05 05:13:40', '2015-05-05 05:13:40'),
(172, 804, 354, '2015-05-05 05:15:43', '2015-05-05 05:15:43'),
(173, 819, 342, '2015-05-05 05:23:44', '2015-05-05 05:23:44'),
(174, 821, 342, '2015-05-05 05:28:00', '2015-05-05 05:28:00'),
(175, 826, 354, '2015-05-06 03:25:20', '2015-05-06 03:25:20'),
(176, 826, 358, '2015-05-06 03:29:34', '2015-05-06 03:29:34'),
(177, 828, 342, '2015-05-06 05:21:12', '2015-05-06 05:21:12'),
(178, 830, 342, '2015-05-06 05:44:26', '2015-05-06 05:44:26'),
(179, 829, 353, '2015-05-06 22:07:34', '2015-05-06 22:07:34'),
(180, 833, 344, '2015-05-07 02:35:52', '2015-05-07 02:35:52'),
(181, 832, 344, '2015-05-07 02:35:59', '2015-05-07 02:35:59'),
(182, 831, 344, '2015-05-07 02:36:16', '2015-05-07 02:36:16'),
(183, 830, 344, '2015-05-07 02:36:28', '2015-05-07 02:36:28'),
(184, 829, 344, '2015-05-07 02:36:36', '2015-05-07 02:36:36'),
(185, 828, 344, '2015-05-07 02:36:48', '2015-05-07 02:36:48'),
(186, 826, 366, '2015-05-07 03:44:44', '2015-05-07 03:44:44'),
(187, 830, 354, '2015-05-07 04:17:32', '2015-05-07 04:17:32'),
(188, 834, 353, '2015-05-07 05:44:34', '2015-05-07 05:44:34'),
(189, 833, 353, '2015-05-07 05:44:39', '2015-05-07 05:44:39'),
(190, 833, 366, '2015-05-07 08:18:31', '2015-05-07 08:18:31'),
(191, 819, 366, '2015-05-07 08:20:05', '2015-05-07 08:20:05'),
(192, 836, 342, '2015-05-07 12:25:01', '2015-05-07 12:25:01'),
(193, 838, 367, '2015-05-08 00:18:47', '2015-05-08 00:18:47'),
(194, 834, 367, '2015-05-08 00:19:03', '2015-05-08 00:19:03'),
(195, 838, 354, '2015-05-08 00:21:03', '2015-05-08 00:21:03'),
(196, 836, 354, '2015-05-08 00:21:31', '2015-05-08 00:21:31'),
(197, 834, 354, '2015-05-08 00:22:55', '2015-05-08 00:22:55'),
(198, 839, 342, '2015-05-08 00:28:28', '2015-05-08 00:28:28'),
(199, 840, 342, '2015-05-08 03:06:08', '2015-05-08 03:06:08'),
(200, 839, 366, '2015-05-08 04:57:49', '2015-05-08 04:57:49'),
(201, 838, 366, '2015-05-08 04:58:27', '2015-05-08 04:58:27'),
(202, 843, 354, '2015-05-08 06:06:08', '2015-05-08 06:06:08'),
(203, 842, 354, '2015-05-08 06:06:47', '2015-05-08 06:06:47'),
(204, 840, 354, '2015-05-08 06:07:02', '2015-05-08 06:07:02'),
(205, 846, 366, '2015-05-08 06:39:17', '2015-05-08 06:39:17'),
(206, 846, 342, '2015-05-08 07:04:14', '2015-05-08 07:04:14'),
(207, 843, 342, '2015-05-08 07:04:29', '2015-05-08 07:04:29'),
(208, 850, 342, '2015-05-11 06:57:38', '2015-05-11 06:57:38'),
(209, 848, 342, '2015-05-11 06:58:14', '2015-05-11 06:58:14'),
(210, 849, 366, '2015-05-11 07:56:49', '2015-05-11 07:56:49'),
(211, 851, 342, '2015-05-12 03:21:27', '2015-05-12 03:21:27'),
(212, 856, 342, '2015-05-12 10:26:44', '2015-05-12 10:26:44'),
(213, 853, 342, '2015-05-12 10:27:36', '2015-05-12 10:27:36'),
(214, 860, 358, '2015-05-13 03:00:49', '2015-05-13 03:00:49'),
(215, 856, 358, '2015-05-13 03:01:01', '2015-05-13 03:01:01'),
(216, 852, 358, '2015-05-13 03:01:39', '2015-05-13 03:01:39'),
(217, 851, 358, '2015-05-13 03:01:46', '2015-05-13 03:01:46'),
(218, 849, 358, '2015-05-13 03:02:41', '2015-05-13 03:02:41'),
(219, 848, 358, '2015-05-13 03:11:52', '2015-05-13 03:11:52'),
(220, 843, 358, '2015-05-13 03:12:10', '2015-05-13 03:12:10'),
(221, 842, 358, '2015-05-13 03:12:17', '2015-05-13 03:12:17'),
(222, 840, 358, '2015-05-13 03:12:23', '2015-05-13 03:12:23'),
(223, 839, 358, '2015-05-13 03:12:38', '2015-05-13 03:12:38'),
(224, 834, 358, '2015-05-13 03:14:03', '2015-05-13 03:14:03'),
(225, 830, 358, '2015-05-13 03:15:53', '2015-05-13 03:15:53'),
(226, 860, 342, '2015-05-13 04:27:54', '2015-05-13 04:27:54'),
(227, 863, 342, '2015-05-13 06:14:40', '2015-05-13 06:14:40'),
(228, 862, 342, '2015-05-13 06:14:47', '2015-05-13 06:14:47'),
(229, 862, 358, '2015-05-13 06:29:26', '2015-05-13 06:29:26'),
(230, 863, 358, '2015-05-13 06:30:14', '2015-05-13 06:30:14'),
(231, 864, 358, '2015-05-13 06:30:41', '2015-05-13 06:30:41'),
(232, 861, 342, '2015-05-15 02:55:56', '2015-05-15 02:55:56'),
(233, 865, 354, '2015-05-15 04:15:37', '2015-05-15 04:15:37'),
(234, 864, 354, '2015-05-15 04:15:56', '2015-05-15 04:15:56'),
(235, 863, 354, '2015-05-15 04:18:15', '2015-05-15 04:18:15'),
(236, 860, 354, '2015-05-15 04:19:37', '2015-05-15 04:19:37'),
(237, 868, 342, '2015-05-19 12:20:56', '2015-05-19 12:20:56'),
(238, 869, 342, '2015-05-20 05:10:36', '2015-05-20 05:10:36'),
(239, 870, 353, '2015-05-20 05:26:49', '2015-05-20 05:26:49'),
(240, 872, 342, '2015-05-20 05:41:41', '2015-05-20 05:41:41'),
(241, 871, 342, '2015-05-20 05:41:52', '2015-05-20 05:41:52'),
(242, 869, 358, '2015-05-20 06:47:20', '2015-05-20 06:47:20'),
(243, 871, 358, '2015-05-20 06:48:21', '2015-05-20 06:48:21'),
(244, 872, 358, '2015-05-20 06:48:28', '2015-05-20 06:48:28'),
(245, 865, 358, '2015-05-20 06:50:25', '2015-05-20 06:50:25'),
(246, 869, 373, '2015-05-20 08:20:45', '2015-05-20 08:20:45'),
(247, 873, 342, '2015-05-20 09:27:45', '2015-05-20 09:27:45'),
(249, 870, 373, '2015-05-21 20:36:11', '2015-05-21 20:36:11'),
(250, 875, 342, '2015-05-21 22:39:30', '2015-05-21 22:39:30'),
(251, 871, 354, '2015-05-25 22:57:28', '2015-05-25 22:57:28'),
(252, 869, 354, '2015-05-25 22:59:32', '2015-05-25 22:59:32'),
(253, 870, 354, '2015-05-25 23:00:39', '2015-05-25 23:00:39'),
(254, 883, 378, '2015-05-25 23:46:13', '2015-05-25 23:46:13'),
(255, 884, 387, '2015-05-26 00:18:26', '2015-05-26 00:18:26'),
(256, 883, 387, '2015-05-26 00:18:29', '2015-05-26 00:18:29'),
(257, 884, 379, '2015-05-26 01:33:57', '2015-05-26 01:33:57'),
(258, 887, 379, '2015-05-26 08:53:38', '2015-05-26 08:53:38'),
(259, 883, 379, '2015-05-26 08:53:42', '2015-05-26 08:53:42'),
(260, 894, 379, '2015-05-26 08:53:47', '2015-05-26 08:53:47'),
(261, 883, 385, '2015-05-26 09:52:29', '2015-05-26 09:52:29'),
(262, 887, 378, '2015-05-26 22:57:00', '2015-05-26 22:57:00'),
(263, 901, 379, '2015-05-27 11:04:09', '2015-05-27 11:04:09'),
(264, 900, 379, '2015-05-27 11:04:12', '2015-05-27 11:04:12'),
(265, 896, 379, '2015-05-27 11:04:15', '2015-05-27 11:04:15'),
(266, 902, 378, '2015-05-28 07:46:19', '2015-05-28 07:46:19'),
(267, 900, 378, '2015-05-28 07:46:35', '2015-05-28 07:46:35'),
(268, 905, 379, '2015-05-29 02:58:50', '2015-05-29 02:58:50'),
(269, 903, 379, '2015-05-29 02:59:04', '2015-05-29 02:59:04'),
(270, 907, 378, '2015-05-29 04:19:27', '2015-05-29 04:19:27'),
(271, 903, 378, '2015-05-29 04:19:47', '2015-05-29 04:19:47'),
(272, 901, 378, '2015-05-29 04:19:52', '2015-05-29 04:19:52'),
(273, 913, 379, '2015-05-29 10:21:53', '2015-05-29 10:21:53'),
(274, 906, 379, '2015-05-29 10:23:01', '2015-05-29 10:23:01'),
(275, 909, 385, '2015-05-29 12:03:00', '2015-05-29 12:03:00'),
(276, 907, 385, '2015-05-29 12:03:12', '2015-05-29 12:03:12'),
(277, 902, 385, '2015-05-29 12:03:47', '2015-05-29 12:03:47'),
(278, 901, 385, '2015-05-29 12:03:56', '2015-05-29 12:03:56'),
(279, 908, 382, '2015-05-29 21:54:02', '2015-05-29 21:54:02'),
(280, 907, 382, '2015-05-29 21:54:08', '2015-05-29 21:54:08'),
(281, 906, 382, '2015-05-29 21:54:16', '2015-05-29 21:54:16'),
(282, 907, 384, '2015-05-30 07:03:35', '2015-05-30 07:03:35'),
(283, 915, 388, '2015-05-30 09:01:38', '2015-05-30 09:01:38'),
(284, 913, 388, '2015-05-30 09:01:49', '2015-05-30 09:01:49'),
(286, 909, 388, '2015-05-30 09:01:57', '2015-05-30 09:01:57'),
(287, 908, 388, '2015-05-30 09:02:05', '2015-05-30 09:02:05'),
(288, 907, 388, '2015-05-30 09:02:08', '2015-05-30 09:02:08'),
(289, 905, 388, '2015-05-30 09:02:17', '2015-05-30 09:02:17'),
(290, 916, 384, '2015-05-30 09:05:55', '2015-05-30 09:05:55'),
(291, 905, 384, '2015-05-30 09:06:54', '2015-05-30 09:06:54'),
(292, 918, 379, '2015-05-31 01:12:01', '2015-05-31 01:12:01'),
(293, 915, 379, '2015-05-31 01:25:15', '2015-05-31 01:25:15'),
(294, 919, 385, '2015-05-31 06:05:25', '2015-05-31 06:05:25'),
(295, 906, 387, '2015-06-01 02:35:58', '2015-06-01 02:35:58'),
(296, 922, 389, '2015-06-01 02:42:02', '2015-06-01 02:42:02'),
(297, 920, 378, '2015-06-01 03:32:01', '2015-06-01 03:32:01'),
(298, 919, 378, '2015-06-01 03:32:15', '2015-06-01 03:32:15'),
(299, 918, 378, '2015-06-01 03:32:29', '2015-06-01 03:32:29'),
(300, 917, 378, '2015-06-01 03:32:34', '2015-06-01 03:32:34'),
(301, 916, 378, '2015-06-01 03:32:36', '2015-06-01 03:32:36'),
(302, 915, 378, '2015-06-01 03:32:44', '2015-06-01 03:32:44'),
(303, 914, 378, '2015-06-01 03:32:57', '2015-06-01 03:32:57'),
(304, 913, 378, '2015-06-01 03:33:09', '2015-06-01 03:33:09'),
(305, 909, 378, '2015-06-01 03:33:17', '2015-06-01 03:33:17'),
(306, 922, 383, '2015-06-01 03:52:34', '2015-06-01 03:52:34'),
(307, 920, 383, '2015-06-01 03:53:03', '2015-06-01 03:53:03'),
(308, 923, 354, '2015-06-01 04:28:33', '2015-06-01 04:28:33'),
(309, 921, 354, '2015-06-01 04:29:00', '2015-06-01 04:29:00'),
(310, 899, 354, '2015-06-01 04:29:08', '2015-06-01 04:29:08'),
(311, 931, 388, '2015-06-02 00:03:22', '2015-06-02 00:03:22'),
(312, 930, 388, '2015-06-02 00:04:04', '2015-06-02 00:04:04'),
(313, 926, 388, '2015-06-02 00:05:17', '2015-06-02 00:05:17'),
(314, 922, 388, '2015-06-02 00:05:32', '2015-06-02 00:05:32'),
(315, 920, 388, '2015-06-02 00:05:44', '2015-06-02 00:05:44'),
(316, 919, 388, '2015-06-02 00:05:53', '2015-06-02 00:05:53'),
(317, 932, 378, '2015-06-02 00:08:49', '2015-06-02 00:08:49'),
(318, 931, 378, '2015-06-02 00:08:54', '2015-06-02 00:08:54'),
(319, 930, 378, '2015-06-02 00:09:06', '2015-06-02 00:09:06'),
(320, 929, 378, '2015-06-02 00:09:18', '2015-06-02 00:09:18'),
(321, 928, 342, '2015-06-02 05:02:04', '2015-06-02 05:02:04'),
(322, 925, 342, '2015-06-02 05:02:08', '2015-06-02 05:02:08'),
(323, 924, 342, '2015-06-02 05:02:18', '2015-06-02 05:02:18'),
(324, 921, 342, '2015-06-02 05:02:55', '2015-06-02 05:02:55'),
(325, 933, 384, '2015-06-02 09:03:29', '2015-06-02 09:03:29'),
(326, 936, 389, '2015-06-03 05:30:14', '2015-06-03 05:30:14'),
(327, 939, 378, '2015-06-03 07:49:16', '2015-06-03 07:49:16'),
(328, 937, 378, '2015-06-03 07:49:21', '2015-06-03 07:49:21'),
(329, 940, 382, '2015-06-03 11:30:13', '2015-06-03 11:30:13'),
(330, 940, 379, '2015-06-03 11:31:59', '2015-06-03 11:31:59'),
(331, 939, 379, '2015-06-03 11:32:05', '2015-06-03 11:32:05'),
(332, 941, 379, '2015-06-03 11:41:46', '2015-06-03 11:41:46'),
(333, 943, 378, '2015-06-03 23:23:40', '2015-06-03 23:23:40'),
(334, 942, 378, '2015-06-03 23:23:50', '2015-06-03 23:23:50'),
(335, 938, 354, '2015-06-04 02:19:45', '2015-06-04 02:19:45'),
(336, 946, 342, '2015-06-04 08:03:03', '2015-06-04 08:03:03'),
(337, 948, 378, '2015-06-05 01:43:29', '2015-06-05 01:43:29'),
(338, 947, 378, '2015-06-05 01:43:31', '2015-06-05 01:43:31'),
(339, 945, 378, '2015-06-05 01:43:33', '2015-06-05 01:43:33'),
(340, 948, 379, '2015-06-05 02:28:31', '2015-06-05 02:28:31'),
(341, 947, 379, '2015-06-05 02:28:34', '2015-06-05 02:28:34'),
(342, 948, 389, '2015-06-05 02:50:58', '2015-06-05 02:50:58'),
(343, 950, 378, '2015-06-05 05:18:56', '2015-06-05 05:18:56'),
(344, 950, 382, '2015-06-09 04:02:56', '2015-06-09 04:02:56'),
(345, 954, 378, '2015-06-11 02:32:07', '2015-06-11 02:32:07'),
(346, 955, 354, '2015-06-12 01:44:34', '2015-06-12 01:44:34'),
(347, 957, 354, '2015-06-12 01:44:54', '2015-06-12 01:44:54'),
(349, 962, 379, '2015-06-13 22:42:24', '2015-06-13 22:42:24'),
(350, 961, 379, '2015-06-13 22:42:29', '2015-06-13 22:42:29'),
(351, 956, 379, '2015-06-13 22:43:21', '2015-06-13 22:43:21'),
(352, 963, 382, '2015-06-14 04:34:05', '2015-06-14 04:34:05'),
(353, 974, 378, '2015-06-17 04:33:15', '2015-06-17 04:33:15'),
(354, 973, 378, '2015-06-17 04:33:22', '2015-06-17 04:33:22'),
(355, 972, 378, '2015-06-17 04:33:24', '2015-06-17 04:33:24'),
(356, 976, 391, '2015-06-17 11:30:06', '2015-06-17 11:30:06'),
(357, 977, 378, '2015-06-17 23:19:58', '2015-06-17 23:19:58'),
(358, 975, 378, '2015-06-17 23:20:02', '2015-06-17 23:20:02'),
(359, 978, 378, '2015-06-19 02:03:23', '2015-06-19 02:03:23'),
(360, 981, 378, '2015-06-19 06:32:43', '2015-06-19 06:32:43'),
(361, 984, 378, '2015-06-23 07:44:05', '2015-06-23 07:44:05'),
(362, 971, 378, '2015-07-02 05:56:17', '2015-07-02 05:56:17'),
(363, 970, 378, '2015-07-02 05:56:20', '2015-07-02 05:56:20'),
(364, 969, 378, '2015-07-02 05:56:24', '2015-07-02 05:56:24'),
(365, 968, 378, '2015-07-02 05:56:28', '2015-07-02 05:56:28'),
(366, 967, 378, '2015-07-02 05:56:30', '2015-07-02 05:56:30'),
(367, 966, 378, '2015-07-02 05:56:33', '2015-07-02 05:56:33'),
(368, 949, 378, '2015-07-03 06:40:07', '2015-07-03 06:40:07'),
(369, 944, 378, '2015-07-03 06:40:16', '2015-07-03 06:40:16'),
(370, 941, 378, '2015-07-03 06:40:24', '2015-07-03 06:40:24'),
(371, 940, 378, '2015-07-03 06:40:29', '2015-07-03 06:40:29'),
(373, 933, 378, '2015-07-03 07:04:36', '2015-07-03 07:04:36'),
(375, 1005, 387, '2015-07-16 05:16:18', '2015-07-16 05:16:18'),
(376, 1000, 399, '2015-07-16 05:19:33', '2015-07-16 05:19:33'),
(377, 1005, 399, '2015-07-16 05:19:53', '2015-07-16 05:19:53'),
(379, 1006, 399, '2015-07-16 05:21:59', '2015-07-16 05:21:59'),
(385, 1009, 398, '2015-07-21 03:08:32', '2015-07-21 03:08:32'),
(386, 1007, 398, '2015-07-21 05:16:38', '2015-07-21 05:16:38'),
(387, 1010, 401, '2015-08-07 07:18:43', '2015-08-07 07:18:43'),
(388, 1017, 403, '2015-08-07 23:26:42', '2015-08-07 23:26:42'),
(389, 1014, 403, '2015-08-07 23:27:30', '2015-08-07 23:27:30'),
(390, 1018, 407, '2015-08-08 00:31:57', '2015-08-08 00:31:57'),
(391, 1017, 407, '2015-08-08 00:32:10', '2015-08-08 00:32:10'),
(392, 1016, 407, '2015-08-08 00:32:29', '2015-08-08 00:32:29'),
(393, 1019, 403, '2015-08-08 00:56:38', '2015-08-08 00:56:38'),
(394, 1021, 402, '2015-08-08 03:07:18', '2015-08-08 03:07:18'),
(395, 1023, 407, '2015-08-08 07:27:26', '2015-08-08 07:27:26'),
(396, 1022, 407, '2015-08-08 07:27:38', '2015-08-08 07:27:38'),
(397, 1020, 407, '2015-08-08 07:29:05', '2015-08-08 07:29:05'),
(398, 1024, 403, '2015-08-09 02:30:03', '2015-08-09 02:30:03'),
(399, 1020, 404, '2015-08-09 02:30:50', '2015-08-09 02:30:50'),
(400, 1019, 404, '2015-08-09 02:30:57', '2015-08-09 02:30:57'),
(401, 1024, 407, '2015-08-09 03:52:50', '2015-08-09 03:52:50'),
(402, 1024, 402, '2015-08-09 06:48:09', '2015-08-09 06:48:09'),
(403, 1022, 402, '2015-08-09 06:48:54', '2015-08-09 06:48:54'),
(404, 1028, 407, '2015-08-09 09:00:23', '2015-08-09 09:00:23'),
(405, 1029, 401, '2015-08-09 23:09:16', '2015-08-09 23:09:16'),
(407, 1035, 408, '2015-08-10 01:14:03', '2015-08-10 01:14:03'),
(408, 1034, 408, '2015-08-10 01:14:05', '2015-08-10 01:14:05'),
(409, 1024, 408, '2015-08-10 23:57:51', '2015-08-10 23:57:51'),
(410, 1074, 401, '2015-08-11 00:54:44', '2015-08-11 00:54:44'),
(411, 1073, 401, '2015-08-11 00:54:47', '2015-08-11 00:54:47'),
(412, 1072, 401, '2015-08-11 00:54:48', '2015-08-11 00:54:48'),
(413, 1081, 416, '2015-08-26 06:41:52', '2015-08-26 06:41:52'),
(414, 1080, 415, '2015-08-26 07:11:42', '2015-08-26 07:11:42'),
(415, 1090, 416, '2015-08-27 23:45:24', '2015-08-27 23:45:24'),
(416, 1089, 416, '2015-08-27 23:45:25', '2015-08-27 23:45:25'),
(417, 1088, 416, '2015-08-27 23:45:27', '2015-08-27 23:45:27');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL,
  `from` int(10) unsigned NOT NULL,
  `to` int(10) unsigned NOT NULL,
  `message` varchar(5000) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_01_05_033804_create_users_table', 1),
('2014_01_08_020326_create_tasks_table', 1),
('2014_01_08_020342_create_outcomes_table', 1),
('2014_01_08_020353_create_groups_table', 1),
('2014_01_08_020421_create_group_users_table', 1),
('2014_01_08_020432_create_outcome_tasks_table', 1),
('2014_01_08_020441_create_posts_table', 1),
('2014_01_08_020449_create_role_table', 1),
('2014_01_08_020455_create_role_assignments_table', 1),
('2014_01_08_020639_create_user_tasks_table', 1),
('2014_01_13_050426_create_outcome_tasks_sorting_table', 2),
('2014_01_14_044357_create_capabilties_table', 3),
('2014_01_14_044556_create_role_capabilties_table', 3),
('2014_01_18_021001_create_password_reminders_table', 4),
('2014_01_19_103140_create_comments_table', 5),
('2014_01_19_104051_create_likes_table', 6),
('2014_01_21_111455_create_final_tasks_table', 7),
('2014_01_21_220145_create_surveys_table', 8),
('2014_01_23_024327_create_messages_table', 9),
('2014_01_23_024444_create_user_messages_table', 9),
('2014_01_27_102005_create_site_settings_table', 9),
('2014_02_06_224557_create_survey_responses_table', 10),
('2014_02_07_051249_create_wellbeing_tracker_table', 11),
('2014_02_12_004902_add_screenhandle_to_users', 12),
('2014_02_18_162722_add_additional_info_posts', 13),
('2014_03_04_070201_create_user_login_table', 14),
('2014_03_04_070401_update_settings_table_value_field', 14),
('2014_03_21_214636_create_survey_message_table', 15),
('2014_03_13_151512_add_survey_field_to_groups', 16),
('2014_04_02_235416_add_post_survey_field_to_groups', 16),
('2013_07_25_145943_create_languages_table', 17),
('2013_07_25_145958_create_language_entries_table', 17),
('2013_08_05_142504_add_soft_delete_to_languages', 17),
('2013_10_25_140034_user_edited', 17),
('2013_10_25_180009_rename_overwrite_to_locked', 17),
('2014_10_16_120640_add_private_column_posts', 18),
('2014_11_24_124627_create_task_score_table', 19),
('2014_11_24_131213_create_feedback_table', 19);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(15) NOT NULL,
  `user_id` int(10) NOT NULL,
  `source_user_id` int(10) NOT NULL,
  `type` varchar(20) NOT NULL,
  `source_id` int(15) NOT NULL,
  `message` varchar(100) NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `outcomes`
--

CREATE TABLE `outcomes` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `taskcount` int(11) NOT NULL,
  `createdby` int(11) NOT NULL,
  `suspended` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `outcomes`
--

INSERT INTO `outcomes` (`id`, `name`, `description`, `type`, `taskcount`, `createdby`, `suspended`, `created_at`, `updated_at`) VALUES
(1, 'Sample outcome', 'Sample outcome description', 1, 0, 1, 0, '2014-01-09 03:06:06', '2014-01-09 03:13:51'),
(2, 'New outcome', 'Description for new outcome', 1, 0, 1, 0, '2014-01-15 12:02:16', '2014-01-15 12:02:16'),
(8, 'syduni', '', 1, 0, 2, 0, '2015-03-17 02:31:41', '2015-03-17 02:31:41'),
(9, 'VicHealth', '', 1, 0, 2, 0, '2015-03-26 00:33:04', '2015-03-26 00:33:04'),
(10, 'stmon', 'St Monica School (Epping) Missions', 1, 0, 2, 0, '2015-04-27 22:36:11', '2015-04-27 22:36:11');

-- --------------------------------------------------------

--
-- Table structure for table `outcome_history`
--

CREATE TABLE `outcome_history` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `group_id` int(10) NOT NULL,
  `outcome_id` int(10) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `outcome_tasks`
--

CREATE TABLE `outcome_tasks` (
  `outcome_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `outcome_tasks`
--

INSERT INTO `outcome_tasks` (`outcome_id`, `task_id`, `created_at`, `updated_at`) VALUES
(1, 11, '2015-08-07 07:02:27', '2015-08-07 07:02:27'),
(1, 23, '2015-08-07 07:02:11', '2015-08-07 07:02:11'),
(1, 27, '2015-08-07 07:01:55', '2015-08-07 07:01:55'),
(1, 28, '2015-08-07 07:02:36', '2015-08-07 07:02:36'),
(8, 54, '2015-03-19 06:54:42', '2015-03-19 06:54:42'),
(8, 55, '2015-03-19 06:54:49', '2015-03-19 06:54:49'),
(8, 56, '2015-03-19 06:54:55', '2015-03-19 06:54:55'),
(8, 57, '2015-03-19 06:54:59', '2015-03-19 06:54:59'),
(8, 58, '2015-03-19 06:55:07', '2015-03-19 06:55:07'),
(8, 59, '2015-03-19 06:55:15', '2015-03-19 06:55:15'),
(8, 60, '2015-03-19 06:55:19', '2015-03-19 06:55:19'),
(8, 61, '2015-03-19 06:55:23', '2015-03-19 06:55:23'),
(8, 62, '2015-03-19 06:55:27', '2015-03-19 06:55:27'),
(8, 63, '2015-03-19 06:55:31', '2015-03-19 06:55:31'),
(8, 64, '2015-03-19 06:55:36', '2015-03-19 06:55:36'),
(8, 65, '2015-03-19 06:55:40', '2015-03-19 06:55:40'),
(8, 66, '2015-03-19 06:55:44', '2015-03-19 06:55:44'),
(8, 67, '2015-03-26 00:23:42', '2015-03-26 00:23:42'),
(8, 68, '2015-03-26 00:23:59', '2015-03-26 00:23:59'),
(8, 69, '2015-03-26 00:23:56', '2015-03-26 00:23:56'),
(8, 70, '2015-03-26 00:23:54', '2015-03-26 00:23:54'),
(8, 71, '2015-03-26 00:23:52', '2015-03-26 00:23:52'),
(8, 72, '2015-03-26 00:23:50', '2015-03-26 00:23:50'),
(8, 73, '2015-03-26 00:23:48', '2015-03-26 00:23:48'),
(8, 74, '2015-03-17 02:32:05', '2015-03-17 02:32:05'),
(9, 76, '2015-03-26 01:09:24', '2015-03-26 01:09:24'),
(9, 77, '2015-03-26 01:09:17', '2015-03-26 01:09:17'),
(9, 78, '2015-03-26 01:09:13', '2015-03-26 01:09:13'),
(9, 79, '2015-03-26 01:09:08', '2015-03-26 01:09:08'),
(9, 80, '2015-03-26 01:09:04', '2015-03-26 01:09:04'),
(9, 81, '2015-03-26 01:09:01', '2015-03-26 01:09:01'),
(9, 82, '2015-03-26 01:08:55', '2015-03-26 01:08:55'),
(9, 83, '2015-03-26 01:08:52', '2015-03-26 01:08:52'),
(9, 84, '2015-03-26 01:08:48', '2015-03-26 01:08:48'),
(9, 85, '2015-03-26 01:08:44', '2015-03-26 01:08:44'),
(9, 86, '2015-03-26 01:08:34', '2015-03-26 01:08:34'),
(9, 87, '2015-03-26 01:08:30', '2015-03-26 01:08:30'),
(9, 88, '2015-03-26 01:08:27', '2015-03-26 01:08:27'),
(9, 89, '2015-03-26 01:08:20', '2015-03-26 01:08:20'),
(9, 90, '2015-03-26 01:08:17', '2015-03-26 01:08:17'),
(9, 91, '2015-03-26 01:08:15', '2015-03-26 01:08:15'),
(9, 92, '2015-03-26 01:08:12', '2015-03-26 01:08:12'),
(9, 93, '2015-03-26 01:08:08', '2015-03-26 01:08:08'),
(9, 94, '2015-03-26 01:08:06', '2015-03-26 01:08:06'),
(9, 95, '2015-03-26 01:08:04', '2015-03-26 01:08:04'),
(9, 96, '2015-03-26 01:08:00', '2015-03-26 01:08:00'),
(10, 97, '2015-04-27 22:37:57', '2015-04-27 22:37:57'),
(10, 98, '2015-04-27 22:38:07', '2015-04-27 22:38:07'),
(10, 99, '2015-04-27 22:38:02', '2015-04-27 22:38:02'),
(10, 100, '2015-04-27 22:37:48', '2015-04-27 22:37:48'),
(10, 101, '2015-04-27 22:37:52', '2015-04-27 22:37:52'),
(10, 102, '2015-04-27 22:37:43', '2015-04-27 22:37:43'),
(10, 103, '2015-04-27 22:37:33', '2015-04-27 22:37:33'),
(10, 104, '2015-04-27 22:37:38', '2015-04-27 22:37:38'),
(10, 105, '2015-04-27 22:37:28', '2015-04-27 22:37:28'),
(10, 106, '2015-04-27 22:37:20', '2015-04-27 22:37:20'),
(10, 107, '2015-04-27 22:37:23', '2015-04-27 22:37:23'),
(10, 108, '2015-04-27 22:37:17', '2015-04-27 22:37:17'),
(10, 109, '2015-04-27 22:37:13', '2015-04-27 22:37:13'),
(10, 110, '2015-04-27 22:37:06', '2015-04-27 22:37:06'),
(10, 111, '2015-04-27 22:37:03', '2015-04-27 22:37:03'),
(10, 112, '2015-04-27 22:37:00', '2015-04-27 22:37:00'),
(10, 113, '2015-04-27 22:36:57', '2015-04-27 22:36:57'),
(10, 114, '2015-04-27 22:36:53', '2015-04-27 22:36:53'),
(10, 115, '2015-04-27 22:36:49', '2015-04-27 22:36:49'),
(10, 116, '2015-04-27 22:36:46', '2015-04-27 22:36:46'),
(10, 117, '2015-04-27 22:36:39', '2015-04-27 22:36:39');

-- --------------------------------------------------------

--
-- Table structure for table `outcome_tasks_sorting`
--

CREATE TABLE `outcome_tasks_sorting` (
  `outcome_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `sortorder` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reminders`
--

CREATE TABLE `password_reminders` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `password_reminders`
--

INSERT INTO `password_reminders` (`email`, `token`, `created_at`) VALUES
('sandeepgill4u@gmail.com', 'd83ddfab8d9f844c9e8a47c35528aed1b8482c47', '2014-01-17 16:28:57'),
('sandeepgill4u@gmail.com', '2f64fe9a25cbd58acc63b12acb641d34d3bf26bb', '2014-01-17 16:46:22'),
('barry.jenkin@enmasse.com.au', 'd287e4becc826918eeee628d6d207f65ed3716a1', '2014-02-11 02:19:18'),
('sandeep.gill@justaboutmachines.com.au', 'f2d9ab56037e234e8e4fe70b98c6da8ee368b072', '2014-05-07 06:40:51'),
('sandeep.gill@justaboutmachines.com.au', '069361baf549cfa4540e47c120481eea74365742', '2014-05-07 06:42:01');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `statustype` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'text',
  `private` tinyint(1) NOT NULL,
  `display_mission` int(1) NOT NULL DEFAULT '1',
  `status` blob NOT NULL,
  `thumbnail` blob,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=1097 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'prouser', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'enduser', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `role_assignments`
--

CREATE TABLE `role_assignments` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `role_assignments`
--

INSERT INTO `role_assignments` (`user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(2, 1, '2014-01-20 04:30:36', '2014-01-20 04:30:36');

-- --------------------------------------------------------

--
-- Table structure for table `role_capabilities`
--

CREATE TABLE `role_capabilities` (
  `id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `capability_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` longblob NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(1, 'sitetitle', 0x4f6e204120526f6c6c203231, '2014-02-06 15:02:54', '2014-02-19 22:41:26'),
(2, 'punchline', 0x32312064617973206f662077656c6c6265696e67, '2014-02-06 15:02:54', '2014-02-17 23:52:37'),
(3, 'maxgroupmembers', 0x3138, '2014-02-06 15:02:54', '2014-03-12 23:02:00'),
(4, 'sitedescription', 0x54686973206973207468652073697465206465736372697074696f6e, '2014-02-06 15:02:54', '2014-02-17 23:52:37');
INSERT INTO `site_settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(5, 'tos', 0x3c68343e3c7374726f6e673e4f6e204120526f6c6c2032313c2f7374726f6e673e3c7374726f6e673e266e6273703b5061727469636970616e742041677265656d656e743c2f7374726f6e673e3c2f68343e0d0a0d0a3c703e546869732041677265656d656e7420776173206c6173742072657669736564206f6e2046656272756172792031382c20323031342e3c2f703e0d0a0d0a3c703e3c7374726f6e673e31205445524d53204f46205553453c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e3120416363657074616e6365204f66205465726d733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5468652077656220706167657320617661696c61626c65206174204f6e206120526f6c6c2032312c20616c6c206c696e6b65642073657276696365732c206170706c69636174696f6e7320616e6420736f66747761726520696e636c7564696e6720266c7371756f3b4f6e204120526f6c6c20323126727371756f3b2028266c6471756f3b5365727669636526726471756f3b292c20617265206f776e656420616e64206f70657261746564206279204f6e206120526f6c6c20323120507479204c7464202841434e203135322038313920313430292028266c6471756f3b4f4152323126726471756f3b2920776869636820697320616e204175737472616c69616e20636f72706f726174696f6e2c20616e642061726520616363657373656420627920796f7520756e64657220746865205465726d73206f6620557365206465736372696265642062656c6f772028266c6471756f3b5465726d7326726471756f3b292e20506c656173652072656164207468657365205465726d73206361726566756c6c79206265666f7265207573696e67207468652053657276696365732e20427920616363657373696e672074686520536572766963657320796f7520617265206167726565696e6720746f20626520626f756e64206279207468657365205465726d7320287468617420696e636c756465206f7572205072697661637920506f6c6963792920776869636820676f7665726e206f75722072656c6174696f6e73686970207769746820796f752e20496620796f75206469736167726565207769746820616e792070617274206f6620746865207465726d73207468656e20796f75206d6179206e6f74206163636573732074686520536572766963652e3c2f703e0d0a0d0a3c703e4f6e636520796f752061636365707420746865207465726d73206f662074686973207061727469636970616e742061677265656d656e742028266c6471756f3b41677265656d656e7426726471756f3b29204f41523231206772616e747320746f20796f75206173207061727469636970616e742028266c6471756f3b5061727469636970616e7426726471756f3b292c2061206e6f6e2d6578636c75736976652c206e6f6e2d7472616e736665727261626c652c20776f726c6477696465206c6963656e636520746f2075736520746865205365727669636520666f7220796f757220757365206f6e6c792c2070726f766964656420796f752072656d61696e207375626a65637420746f207468697320676f7665726e696e67206c6963656e73652061677265656d656e7420616e6420666f7220746865206475726174696f6e207468617420686173206265656e20616772656564207769746820796f75722067726f75702061646d696e6973747261746f722e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e32205465726d73204f66205573653c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f41523231206772616e747320746865205061727469636970616e74207065726d697373696f6e20746f207573652074686520536572766963652061732073657420666f72746820696e207468657365205465726d732c2070726f766964656420746861743a2028692920746865205061727469636970616e742077696c6c206e6f7420636f70792c20646973747269627574652c206f7220646973636c6f736520616e792070617274206f6620746865205365727669636520696e20616e79206d656469756d3b202869692920746865205061727469636970616e742077696c6c206e6f7420616c746572206f72206d6f6469667920616e792070617274206f66207468652053657276696365206f74686572207468616e206173206d617920626520726561736f6e61626c79206e656365737361727920746f2075736520746865205365727669636520666f722069747320696e74656e64656420707572706f73653b20616e6420286969692920746865205061727469636970616e742077696c6c206f746865727769736520636f6d706c79207769746820746865207465726d7320616e6420636f6e646974696f6e73206f6620746869732041677265656d656e742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e322e3120496e646976696475616c205061727469636970616e74204163636f756e74733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4561636820696e646976696475616c205061727469636970616e742077696c6c206e65656420746f2072656769737465722077697468204f4152323120616e64206372656174652061205061727469636970616e74206163636f756e742e20596f7572206163636f756e7420676976657320796f752061636365737320746f2074686520736572766963657320616e642066756e6374696f6e616c6974792074686174207765206d61792065737461626c69736820616e64206d61696e7461696e2066726f6d2074696d6520746f2074696d6520616e6420696e206f757220736f6c652064697363726574696f6e2e3c2f703e0d0a0d0a3c703e596f75206d6179206e657665722075736520616e6f74686572205061727469636970616e7426727371756f3b73206163636f756e7420776974686f7574207065726d697373696f6e2e205768656e206372656174696e6720796f7572206163636f756e742c20796f75206d7573742070726f7669646520616363757261746520616e6420636f6d706c65746520696e666f726d6174696f6e2e20596f752061726520736f6c656c7920726573706f6e7369626c6520666f72207468652061637469766974792074686174206f6363757273206f6e20796f7572206163636f756e742c20616e6420796f75206d757374206b65657020796f7572206163636f756e742070617373776f7264207365637572652e20596f75206d757374206e6f74696679204f4152323120696d6d6564696174656c79206f6620616e7920627265616368206f66207365637572697479206f7220756e617574686f726973656420757365206f6620796f7572206163636f756e742e20416c74686f756768204f415232312077696c6c206e6f74206265206c6961626c6520666f7220796f7572206c6f737365732063617573656420627920616e7920756e617574686f726973656420757365206f6620796f7572206163636f756e742c20796f75207368616c6c206265206c6961626c6520666f7220746865206c6f73736573206f66204f41523231206f72206f74686572732064756520746f207375636820616e7920756e617574686f72697365642075736520627920796f752e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e322e3220496e646976696475616c205061727469636970616e7420456d61696c733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e596f75206d61792075736520796f7572204163636f756e742053657474696e677320746f20636f6e74726f6c20796f7572205061727469636970616e742050726f66696c652e2042792070726f766964696e67204f4152323120796f757220656d61696c206164647265737320796f7520636f6e73656e7420746f206f7572207573696e672074686520656d61696c206164647265737320746f2073656e6420796f7520536572766963652d72656c61746564206e6f74696365732c20696e636c7564696e6720616e79206e6f7469636573207265717569726564206279206c61772c20696e206c696575206f6620636f6d6d756e69636174696f6e20627920706f7374616c206d61696c2e20596f75206d61792075736520796f7572204e6f74696669636174696f6e732053657474696e677320746f206f7074206f7574206f66206d616e7920536572766963652d72656c6174656420636f6d6d756e69636174696f6e732e205765206d617920616c736f2075736520796f757220656d61696c206164647265737320746f2073656e6420796f75206f74686572206d657373616765732c20696e636c7564696e67206368616e67657320746f206665617475726573206f6620746865205365727669636520616e64207370656369616c206f66666572732e20496620796f7520646f206e6f742077616e7420746f2072656365697665207375636820656d61696c206d657373616765732c20796f75206d6179206f7074206f7574206279206368616e67696e672074686520707265666572656e63657320696e20796f7572204e6f74696669636174696f6e732053657474696e67732e204f7074696e67206f7574206d61792070726576656e7420796f752066726f6d20726563656976696e6720656d61696c206d6573736167657320726567617264696e6720757064617465732c20696d70726f76656d656e74732c206f72206f66666572732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e322e3320456d61696c205370616d3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e596f75206167726565206e6f7420746f20757365206f72206c61756e636820616e79206175746f6d617465642073797374656d2c20696e636c7564696e6720776974686f7574206c696d69746174696f6e2c20266c6471756f3b726f626f74732c26726471756f3b20266c6471756f3b737069646572732c26726471756f3b20266c6471756f3b6f66666c696e6520726561646572732c26726471756f3b206574632e2c207468617420616363657373657320746865205365727669636520696e2061206d616e6e657220746861742073656e6473206d6f72652072657175657374206d6573736167657320746f20746865204f415232312073657276657273207468616e20612068756d616e2063616e20726561736f6e61626c792070726f6475636520696e207468652073616d6520706572696f64206f662074696d65206279207573696e67206120636f6e76656e74696f6e616c206f6e2d6c696e65207765622062726f777365722e20596f75206167726565206e6f7420746f20636f6c6c656374206f72206861727665737420616e7920706572736f6e616c6c79206964656e7469666961626c6520696e666f726d6174696f6e2c20696e636c7564696e67206163636f756e74206e616d65732c2066726f6d207468652053657276696365206e6f7220746f207573652074686520636f6d6d756e69636174696f6e2073797374656d732070726f766964656420627920746865205365727669636520666f7220616e7920636f6d6d65726369616c20736f6c696369746174696f6e20707572706f7365732e20596f75206167726565206e6f7420746f2075736520616e7920706f7274696f6e206f6620746865205365727669636520617320612064657374696e6174696f6e206c696e6b656420746f20616e7920756e736f6c6963697465642062756c6b206d65737361676573206f7220756e736f6c69636974656420636f6d6d65726369616c206d657373616765732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e322e342056696f6c6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f41523231206d6179207065726d616e656e746c79206f722074656d706f726172696c79207465726d696e6174652c2073757370656e642c206f72206f74686572776973652072656675736520746f207065726d697420796f75722061636365737320746f20746865205365727669636520776974686f7574206e6f7469636520616e64206c696162696c6974792c2069662c20696e204f4152323126727371756f3b7320736f6c652064657465726d696e6174696f6e2c20796f752076696f6c61746520616e79206f6620746865205465726d732c20696e636c7564696e672074686520666f6c6c6f77696e672070726f6869626974656420616374696f6e733a2028692920617474656d7074696e6720746f20696e7465726665726520776974682c20636f6d70726f6d697365207468652073797374656d20696e74656772697479206f72207365637572697479206f7220646563697068657220616e79207472616e736d697373696f6e7320746f206f722066726f6d2074686520736572766572732072756e6e696e672074686520536572766963653b20286969292074616b696e6720616e7920616374696f6e207468617420696d706f7365732c206f72206d617920696d706f7365206174206f757220736f6c652064697363726574696f6e20616e20756e726561736f6e61626c65206f722064697370726f706f7274696f6e6174656c79206c61726765206c6f6164206f6e206f757220696e6672617374727563747572653b2028696969292075706c6f6164696e6720696e76616c696420646174612c20766972757365732c20776f726d732c206f72206f7468657220736f667477617265206167656e7473207468726f7567682074686520536572766963653b202869762920696d706572736f6e6174696e6720616e6f7468657220706572736f6e206f72206f7468657277697365206d6973726570726573656e74696e6720796f757220616666696c696174696f6e2077697468206120706572736f6e206f7220656e746974792c20636f6e64756374696e672066726175642c20686964696e67206f7220617474656d7074696e6720746f206869646520796f7572206964656e746974793b2028762920696e746572666572696e672077697468207468652070726f70657220776f726b696e67206f662074686520536572766963653b206f722c202876692920627970617373696e6720746865206d65617375726573207765206d61792075736520746f2070726576656e74206f722072657374726963742061636365737320746f2074686520536572766963652c20696e636c7564696e672c20627574206e6f74206c696d6974656420746f2c207265676973746572696e6720666f7220746865205365727669636520776974682061206e6f6e2d4e6574776f726b20656d61696c20616464726573732e2055706f6e207465726d696e6174696f6e20666f7220616e7920726561736f6e2c20796f7520636f6e74696e756520746f20626520626f756e6420627920746869732041677265656d656e742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e322e3520556e617574686f7269736564205061727469636970616e74733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e496620796f75206c6561726e20746861742061205061727469636970616e74206973206e6f7420617574686f726973656420746f2062652061206d656d626572206f6620612067726f7570206f72206973206f74686572776973652076696f6c6174696e67207468657365205465726d732c20776520656e636f757261676520796f7520746f206e6f746966792075732e20596f7520616772656520796f752077696c6c206e6f742061636375736520616e79205061727469636970616e74206f66206265696e6720756e617574686f7269736564206f72206f662076696f6c6174696e6720746869732041677265656d656e7420756e6c65737320796f7520686176652061637475616c206b6e6f776c656467652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e33204465736372697074696f6e204f6620536572766963653c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f6e204120526f6c6c2032312674726164653b20697320616e20656e74657270726973652062617365642061206469676974616c206265686176696f72206368616e67652070726f6772616d20746861742068656c7073206275696c642070726f64756374697669747920616e642077656c6c6265696e6720696e207465616d732e204f6e204120526f6c6c2032312674726164653b2061637469766174657320746865207072696e6369706c6573206f6620706f7369746976652070737963686f6c6f677920766961206120736f6369616c206d6564696120616e642067616d696e672064656c697665727920706c6174666f726d2e204974206173736973747320696e646976696475616c7320746f20696e637265617365206265686176696f727320746861742068617665206120706f73697469766520696e666c75656e6365206f6e2070726f6475637469766974792c2061732077656c6c20617320706879736963616c20616e64206d656e74616c2077656c6c6265696e672e204f6e204120526f6c6c2032312674726164653b2063616e206265207573656420696e207072697661746520736f6369616c2067726f75707320616e6420696e206f7267616e69736174696f6e616c2073657474696e67732c20776865726520636f6c6c61626f726174696f6e20616e6420636f6e6e65637465646e657373206265747765656e207465616d206d656d626572732c20636f75706c656420776974682074686520696d7061637473206f6620696d70726f7665642077656c6c6265696e672c20736572766520746f2064656372656173652070656f706c652072656c61746564207269736b73207768696c6520696d70726f76696e672077656c6c6265696e6720616e642070726f6475637469766974792e3c2f703e0d0a0d0a3c703e536572766963657320696e636c7564652c2062757420617265206e6f74206c696d6974656420746f2c20616e79205365727669636520616e642f6f7220436f6e74656e74204f41523231206d616b657320617661696c61626c6520746f206f7220706572666f726d7320666f7220796f752c2061732077656c6c20617320746865206f66666572696e67206f6620616e79206d6174657269616c7320646973706c617965642c207472616e736d6974746564206f7220706572666f726d6564207468726f756768207468652053657276696365732e20436f6e74656e7420696e636c756465732c20627574206973206e6f74206c696d6974656420746f20746578742c205061727469636970616e7420616374697669746965732c2074686520726f6c6c696e6720646963652c20737572766579732c207265706f7274732c205061727469636970616e7420636f6d6d656e74732c206d657373616765732c20696e666f726d6174696f6e2c20646174612c2067726170686963732c206e6577732061727469636c65732c2070686f746f6772617068732c20696d616765732c20696c6c757374726174696f6e7320616e6420736f6674776172652e20596f75722061636365737320746f20616e6420757365206f6620746865205365727669636573206d617920626520696e7465727275707465642066726f6d2074696d6520746f2074696d65206173206120726573756c74206f662065717569706d656e74206d616c66756e6374696f6e2c207570646174696e672c206d61696e74656e616e6365206f7220726570616972206f6620746865205365727669636573206f7220616e79206f7468657220726561736f6e2077697468696e206f72206f7574736964652074686520636f6e74726f6c206f66204f415232312e204f415232312072657365727665732074686520726967687420746f2073757370656e64206f7220646973636f6e74696e75652074686520617661696c6162696c697479206f662074686520536572766963657320616e642f6f722072656d6f766520616e7920436f6e74656e7420617420616e792074696d652061742069747320736f6c652064697363726574696f6e20616e6420776974686f7574207072696f72206e6f746963652e204f41523231206d617920616c736f20696d706f7365206c696d697473206f6e206365727461696e20666561747572657320616e64205365727669636573206f7220726573747269637420796f75722061636365737320746f207061727473206f66206f7220616c6c206f662074686520536572766963657320776974686f7574206e6f74696365206f72206c696162696c6974792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e34205061727469636970616e7420436f6e647563743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e416c6c20436f6e74656e7420706f73746564206f72206f7468657277697365207375626d697474656420746f2074686520536572766963652069732074686520736f6c6520726573706f6e736962696c697479206f6620746865206163636f756e7420686f6c6465722066726f6d207768696368207375636820436f6e74656e74206f726967696e6174657320616e6420796f752061636b6e6f776c6564676520616e64206167726565207468617420796f752c20616e64206e6f74204f415232312c2061726520656e746972656c7920726573706f6e7369626c6520666f7220616c6c20436f6e74656e74207468617420796f7520706f73742c206f72206f7468657277697365207375626d697420746f2074686520536572766963652e204f4152323120646f6573206e6f7420636f6e74726f6c205061727469636970616e74207375626d697474656420436f6e74656e7420616e642c20617320737563682c20646f6573206e6f742067756172616e746565207468652061636375726163792c20696e74656772697479206f72207175616c697479206f66207375636820436f6e74656e742e20596f7520756e6465727374616e642074686174206279207573696e6720746865205365727669636520796f75206d6179206265206578706f73656420746f20436f6e74656e742074686174206973206f6666656e736976652c20696e646563656e74206f72206f626a656374696f6e61626c652e204173206120636f6e646974696f6e206f66207573652c20796f752070726f6d697365206e6f7420746f207573652074686520536572766963657320666f7220616e7920707572706f7365207468617420697320756e6c617766756c206f722070726f68696269746564206279207468657365205465726d732c206f7220616e79206f7468657220707572706f7365206e6f7420726561736f6e61626c7920696e74656e646564206279204f415232312e20427920776179206f66206578616d706c652c20616e64206e6f742061732061206c696d69746174696f6e2c20796f75206167726565206e6f7420746f20757365207468652053657276696365733a20546f2061627573652c206861726173732c20746872656174656e2c20696d706572736f6e617465206f7220696e74696d696461746520616e7920706572736f6e3b20546f20706f7374206f72207472616e736d69742c206f7220636175736520746f20626520706f73746564206f72207472616e736d69747465642c20616e7920436f6e74656e742074686174206973206c6962656c6c6f75732c20646566616d61746f72792c206f627363656e652c20706f726e6f677261706869632c20616275736976652c206f6666656e736976652c2070726f66616e652c206f72207468617420696e6672696e67657320616e7920636f70797269676874206f72206f74686572207269676874206f6620616e7920706572736f6e3b20466f7220616e7920707572706f73652028696e636c7564696e6720706f7374696e67206f722076696577696e6720436f6e74656e74292074686174206973206e6f74207065726d697474656420756e64657220746865206c617773206f6620746865206a7572697364696374696f6e20776865726520796f7520757365207468652053657276696365733b20546f20706f7374206f72207472616e736d69742c206f7220636175736520746f20626520706f73746564206f72207472616e736d69747465642c20616e7920636f6d6d756e69636174696f6e206f7220736f6c696369746174696f6e2064657369676e6564206f7220696e74656e64656420746f206f627461696e2070617373776f72642c206163636f756e742c206f72207072697661746520696e666f726d6174696f6e2066726f6d20616e79204f41523231205061727469636970616e743b20546f20637265617465206f72207472616e736d697420756e77616e74656420266c7371756f3b7370616d26727371756f3b20746f20616e7920706572736f6e206f7220616e792055524c3b20546f20637265617465206d756c7469706c65206163636f756e747320666f722074686520707572706f7365206f6620656e68616e63696e6720766f6c756e74656572696e6720616e642f6f7220646f6e6174696f6e20696e666f726d6174696f6e3b20546f20706f737420636f70797269676874656420436f6e74656e7420776869636820646f65736e26727371756f3b742062656c6f6e6720746f20796f752c207769746820657863657074696f6e206f6620426c6f67732c20776865726520796f75206d617920706f7374207375636820436f6e74656e742077697468206578706c69636974206d656e74696f6e206f662074686520617574686f7226727371756f3b73206e616d6520616e642061206c696e6b20746f2074686520736f75726365206f662074686520436f6e74656e743b20576974682074686520657863657074696f6e206f6620616363657373696e67205253532066656564732c20796f752077696c6c206e6f742075736520616e7920726f626f742c207370696465722c2073637261706572206f72206f74686572206175746f6d61746564206d65616e7320746f206163636573732074686520536572766963657320666f7220616e7920707572706f736520776974686f7574206f75722065787072657373207772697474656e207065726d697373696f6e2e3c2f703e0d0a0d0a3c703e4164646974696f6e616c6c792c20796f75206167726565207468617420796f752077696c6c206e6f743a202869292074616b6520616e7920616374696f6e207468617420696d706f7365732c206f72206d617920696d706f736520696e206f757220736f6c652064697363726574696f6e20616e20756e726561736f6e61626c65206f722064697370726f706f7274696f6e6174656c79206c61726765206c6f6164206f6e204f4152323126727371756f3b7320696e6672617374727563747572653b202869692920696e74657266657265206f7220617474656d707420746f20696e746572666572652077697468207468652070726f70657220776f726b696e67206f66207468652053657276696365206f7220616e79206163746976697469657320636f6e647563746564206f6e2074686520536572766963653b206f722028696969292062797061737320616e79206d65617375726573207765206d61792075736520746f2070726576656e74206f722072657374726963742061636365737320746f2074686520536572766963653b20546f206172746966696369616c6c7920696eefac82617465206f7220616c74657220766f746520636f756e74732c20626c6f6720636f756e74732c20636f6d6d656e74732c206f7220616e79206f746865722053657276696365206f7220666f722074686520707572706f7365206f6620676976696e67206f7220726563656976696e67206d6f6e6579206f72206f7468657220636f6d70656e736174696f6e20696e2065786368616e676520666f7220766f7465732c206f7220666f722070617274696369706174696e6720696e20616e79206f74686572206f7267616e69736564206566666f7274207468617420696e20616e7920776179206172746966696369616c6c7920616c746572732074686520726573756c7473206f662053657276696365733b20546f2061647665727469736520746f2c206f7220736f6c696369742c20616e79205061727469636970616e7420746f20627579206f722073656c6c20616e792070726f6475637473206f722073657276696365732c206f7220746f2075736520616e7920696e666f726d6174696f6e206f627461696e65642066726f6d2074686520536572766963657320696e206f7264657220746f20636f6e746163742c2061647665727469736520746f2c20736f6c696369742c206f722073656c6c20746f20616e79205061727469636970616e7420776974686f7574207468656972207072696f72206578706c6963697420636f6e73656e743b20546f2070726f6d6f7465206f722073656c6c20436f6e74656e74206f6620616e6f7468657220706572736f6e3b206f7220546f2073656c6c206f72206f7468657277697365207472616e7366657220796f75722070726f66696c652e3c2f703e0d0a0d0a3c703e596f75206167726565206e6f7420746f20706f7374205061727469636970616e7420436f6e74656e7420746861743a20286929206d6179206372656174652061207269736b206f66206861726d2c206c6f73732c20706879736963616c206f72206d656e74616c20696e6a7572792c20656d6f74696f6e616c2064697374726573732c2064656174682c206469736162696c6974792c206469736669677572656d656e742c206f7220706879736963616c206f72206d656e74616c20696c6c6e65737320746f20796f752c20746f20616e79206f7468657220706572736f6e2c206f7220746f20616e7920616e696d616c3b2028696929206d6179206372656174652061207269736b206f6620616e79206f74686572206c6f7373206f722064616d61676520746f20616e7920706572736f6e206f722070726f70657274793b202869696929206d617920636f6e73746974757465206f7220636f6e7472696275746520746f2061206372696d65206f7220746f72743b202869762920636f6e7461696e7320616e7920696e666f726d6174696f6e206f7220636f6e74656e74207468617420697320756e6c617766756c2c206861726d66756c2c20616275736976652c2072616369616c6c79206f72206574686e6963616c6c79206f6666656e736976652c20646566616d61746f72792c20696e6672696e67696e672c20696e766173697665206f6620706572736f6e616c2070726976616379206f72207075626c6963697479207269676874732c20686172617373696e672c2068756d696c696174696e6720746f206f746865722070656f706c6520287075626c69636c79206f72206f7468657277697365292c206c6962656c6c6f75732c20746872656174656e696e672c206f72206f7468657277697365206f626a656374696f6e61626c653b2028762920636f6e7461696e7320616e7920696e666f726d6174696f6e206f7220636f6e74656e74207468617420697320696c6c6567616c3b202876692920636f6e7461696e7320616e7920696e666f726d6174696f6e206f7220636f6e74656e74207468617420796f7520646f206e6f742068617665206120726967687420746f206d616b6520617661696c61626c6520756e64657220616e79206c6177206f7220756e64657220636f6e747261637475616c206f72206669647563696172792072656c6174696f6e73686970733b206f7220287669692920636f6e7461696e7320616e7920696e666f726d6174696f6e206f7220636f6e74656e74207468617420796f75206b6e6f77206973206e6f7420636f727265637420616e642063757272656e742e20596f75206167726565207468617420616e79205061727469636970616e7420436f6e74656e74207468617420796f7520706f737420646f6573206e6f7420616e642077696c6c206e6f742076696f6c6174652074686972642d706172747920726967687473206f6620616e79206b696e642c20696e636c7564696e6720776974686f7574206c696d69746174696f6e20616e7920496e74656c6c65637475616c2050726f7065727479205269676874732c20726967687473206f66207075626c696369747920616e6420707269766163792e20596f7520756e6465727374616e642074686174207075626c697368696e6720796f7572205061727469636970616e7420436f6e74656e74206f6e207468652053657276696365206973206e6f742061207375627374697475746520666f72207265676973746572696e6720697420617320796f7572206f776e2e3c2f703e0d0a0d0a3c703e546f207265706f7274206120737573706563746564206162757365206f66207468652053657276696365206f72206120627265616368206f6620746865205465726d7320706c656173652073656e64207772697474656e206e6f7469636520746f204f41523231207573696e67203c6120687265663d222f7265706f7274223e74686973206f6e6c696e6520666f726d3c2f613e2e266e6273703b596f752061726520736f6c656c7920726573706f6e7369626c6520666f7220796f757220696e746572616374696f6e732077697468206f74686572205061727469636970616e7473206f662074686520536572766963652e204f41523231207265736572766573207468652072696768742c2062757420686173206e6f206f626c69676174696f6e2c20746f206d6f6e69746f72206469737075746573206265747765656e20796f7520616e64206f74686572205061727469636970616e74732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e35205265737472696374696f6e73203c2f7374726f6e673e3c2f703e0d0a0d0a3c703e546865205061727469636970616e74206d6179206e6f743a202861292052656e742c206c656173652c206c656e642c20686f7374206f72206f746865727769736520646973747269627574652053657276696365733b206f7220286229205265766572736520656e67696e6565722c20726570726f647563652c2064652d636f6d70696c65206f7220646973617373656d626c65207468652053657276696365732c2065786365707420746f2074686520657874656e7420657870726573736c79207065726d6974746564206279206170706c696361626c65206c617720646573706974652074686973206c696d69746174696f6e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e3620526567697374726174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4173206120636f6e646974696f6e20746f207573696e672053657276696365732c20796f752061726520726571756972656420746f206f70656e20616e206163636f756e742077697468204f4152323120616e642073656c65637420612070617373776f726420616e6420757365726e616d652c20616e6420746f2070726f7669646520726567697374726174696f6e20696e666f726d6174696f6e2e2054686520726567697374726174696f6e20696e666f726d6174696f6e20796f752070726f76696465206d7573742062652061636375726174652c20636f6d706c6574652c20616e642063757272656e7420617420616c6c2074696d65732e204661696c75726520746f20646f20736f20636f6e7374697475746573206120627265616368206f6620746865205465726d732c207768696368206d617920726573756c7420696e20696d6d656469617465207465726d696e6174696f6e206f6620796f7572204f41523231206163636f756e742e20596f75206d6179206e6f7420757365206173206120757365726e616d6520746865206e616d65206f6620616e6f7468657220706572736f6e206f7220656e74697479206f722074686174206973206e6f74206c617766756c6c7920617661696c61626c6520666f72207573652c2061206e616d65206f72207472616465206d61726b2074686174206973207375626a65637420746f20616e7920726967687473206f6620616e6f7468657220706572736f6e206f7220656e74697479206f74686572207468616e20796f7520776974686f757420617070726f70726961746520617574686f7269736174696f6e2c206f722061206e616d652074686174206973206f7468657277697365206f6666656e736976652c2076756c676172206f72206f627363656e652e20596f752061726520726573706f6e7369626c6520666f72206d61696e7461696e696e672074686520636f6e666964656e7469616c697479206f6620796f75722070617373776f726420616e642061726520736f6c656c7920726573706f6e7369626c6520666f7220616c6c206163746976697469657320726573756c74696e672066726f6d2074686520757365206f6620796f75722070617373776f726420616e6420636f6e647563746564207468726f75676820796f7572204f41523231206163636f756e742e2053657276696365732061726520617661696c61626c65206f6e6c7920746f20696e646976696475616c732077686f206172652065697468657220286929206174206c65617374203135207965617273206f6c642c206f722028696929206174206c65617374203138207965617273206f6c642c20616e642077686f2061726520617574686f726973656420746f20616363657373207468652053657276696365206279206120706172656e74206f72206c6567616c20677561726469616e2e20496620796f75206861766520617574686f72697365642061206d696e6f7220746f207573652074686520536572766963652c20796f752061726520726573706f6e7369626c6520666f7220746865206f6e6c696e6520636f6e64756374206f662073756368206d696e6f722c20616e642074686520636f6e73657175656e636573206f6620616e79206d6973757365206f6620746865205365727669636520627920746865206d696e6f722e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e37204164646974696f6e616c20526570726573656e746174696f6e7320416e642057617272616e746965733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e596f75207368616c6c20626520736f6c656c7920726573706f6e7369626c6520666f7220796f7572206f776e205061727469636970616e7420436f6e74656e7420616e642074686520636f6e73657175656e636573206f6620706f7374696e67206f72207075626c697368696e672069742e20496e20636f6e6e656374696f6e2077697468205061727469636970616e7420436f6e74656e742c20796f752061666669726d2c20726570726573656e7420616e642077617272616e742c20696e206164646974696f6e20746f20746865206f7468657220726570726573656e746174696f6e7320616e642077617272616e7469657320696e20746869732041677265656d656e742c2074686520666f6c6c6f77696e673a3c2f703e0d0a0d0a3c703e28612920596f7520617265206174206c65617374203138207965617273206f66206167652c206f7220696620796f752061726520756e646572203138207965617273206f662061676520796f75206172652065697468657220616e20656d616e63697061746564206d696e6f722c206f7220706f7373657373206c6567616c20706172656e74616c206f7220677561726469616e20636f6e73656e742c20616e64206172652066756c6c792061626c6520616e6420636f6d706574656e7420746f20656e74657220696e746f20746865207465726d732c20636f6e646974696f6e732c206f626c69676174696f6e732c2061666669726d6174696f6e732c20726570726573656e746174696f6e732c20616e642077617272616e746965732073657420666f72746820696e20746869732041677265656d656e742c20616e6420746f20616269646520627920616e6420636f6d706c79207769746820746869732041677265656d656e742e3c2f703e0d0a0d0a3c703e28622920596f75206861766520746865207772697474656e20636f6e73656e74206f66206561636820616e64206576657279206964656e7469666961626c65206e61747572616c20706572736f6e20696e20796f7572204e6574776f726b20746f20757365207375636820706572736f6e26727371756f3b73206e616d65206f72206c696b656e65737320696e20746865206d616e6e657220636f6e74656d706c6174656420627920746865205365727669636520616e6420746869732041677265656d656e742c20616e642065616368207375636820706572736f6e206861732072656c656173656420796f752066726f6d20616e79206c696162696c6974792074686174206d617920617269736520696e2072656c6174696f6e20746f2073756368207573652e3c2f703e0d0a0d0a3c703e28632920596f7572205061727469636970616e7420436f6e74656e7420616e64204f4152323126727371756f3b73207573652074686572656f6620617320636f6e74656d706c6174656420627920746869732041677265656d656e7420616e642074686520536572766963652077696c6c206e6f7420696e6672696e676520616e7920726967687473206f6620616e792074686972642070617274792c20696e636c7564696e6720627574206e6f74206c696d6974656420746f20616e7920496e74656c6c65637475616c2050726f7065727479205269676874732c20707269766163792072696768747320616e6420726967687473206f66207075626c69636974792e3c2f703e0d0a0d0a3c703e28642920596f752068617665207468652066756c6c20706f77657220616e6420617574686f7269747920746f20656e74657220696e746f20746869732041677265656d656e7420616e6420746f2074686520657874656e74207468617420616e7920656e7469747920697320626f756e64206865726562792c20746f2062696e64207375636820656e746974792c20746869732041677265656d656e7420616e6420706572666f726d616e6365206f66206f626c69676174696f6e7320756e64657220746869732041677265656d656e7420646f206e6f7420616e642077696c6c206e6f742076696f6c61746520616e79206f746865722061677265656d656e7420746f20776869636820796f75206f72207375636820656e7469747920697320612070617274793b20616e6420746869732041677265656d656e7420636f6e73746974757465732061206c6567616c2c2076616c696420616e642062696e64696e67206f626c69676174696f6e206f6620796f75206f7220616e79207375636820656e746974792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e312e38204d6f64696669636174696f6e7320546f20546869732041677265656d656e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f41523231207265736572766573207468652072696768742c20696e2069747320736f6c652064697363726574696f6e20746f206d6f64696679207468657365205465726d7320617420616e792074696d6520627920706f7374696e672061206e6f7469636520746f204f4152323120616e6420796f7572204e6574776f726b2041646d696e6973747261746f722e20596f75207368616c6c20626520726573706f6e7369626c6520666f7220726576696577696e6720616e64206265636f6d696e672066616d696c696172207769746820616e792073756368206d6f64696669636174696f6e2e2053756368206d6f64696669636174696f6e7320617265206566666563746976652075706f6e20666972737420706f7374696e67206f72206e6f74696669636174696f6e20616e6420757365206f66207468652053657276696365206279205061727469636970616e7420666f6c6c6f77696e6720616e792073756368206e6f74696669636174696f6e20636f6e7374697475746573205061727469636970616e7426727371756f3b7320616363657074616e6365206f6620746865207465726d7320616e6420636f6e646974696f6e73206f66207468657365205465726d73206173206d6f6469666965642e20496620796f7520646f206e6f7420616772656520746f20616e79206f66207468657365205465726d7320646f206e6f7420757365206f722061636365737320286f7220636f6e74696e756520746f20616363657373292074686520536572766963652e20546869732041677265656d656e74206170706c69657320746f20616c6c2076697369746f72732c205061727469636970616e74732c20616e64206f74686572732077686f206163636573732074686520536572766963652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e20505249564143592026616d703b20434f4e464944454e5449414c495459266e6273703b203c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e4f415232313c2f7374726f6e673e20726573706563747320616e642077696c6c2074616b6520616c6c20726561736f6e61626c65206d6561737572657320746f2070726f7465637420796f75722070726976616379207768656e20796f7520757365206f757220736572766963657320616e6420696e7465726163742077697468206f757220636f6d70616e792e2057652077616e7420796f7520746f206665656c20736563757265207768656e20796f7520696e74657261637420776974682075732e3c2f703e0d0a0d0a3c703e5468697320507269766163792053746174656d656e74206170706c69657320746f20746865205365727669636573206d656e74696f6e656420616e6420746f20616c6c20627573696e6573732061637469766974696573206f66204f4152323120616e642069747320616666696c696174657320746f2074686520657874656e742074686174207468657920616666656374206f7220696e766f6c76652074686520636f6c6c656374696f6e2c207573652c20646973636c6f73757265206f722068616e646c696e67206f6620706572736f6e616c20696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e4f4152323120726573706563747320616e6420636f6d706c69657320776974682074686520726571756972656d656e7473206f6620746865205072697661637920416374203139383820616e6420746865204e6174696f6e616c2050726976616379205072696e6369706c657320636f6e7461696e656420696e20746861742041637420696e20616c6c206f66206f757220616374697669746965732e20546865736520696e636c7564652077697468207265737065637420746f2074686520636f6c6c656374696f6e2c207573652c20646973636c6f7375726520616e642068616e646c696e67206f6620706572736f6e616c20696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e496e207468697320507269766163792053746174656d656e742c20706572736f6e616c20696e666f726d6174696f6e206d65616e7320696e666f726d6174696f6e206f7220616e206f70696e696f6e2028696e636c7564696e6720696e666f726d6174696f6e206f7220616e206f70696e696f6e20666f726d696e672070617274206f662061206461746162617365292c20776865746865722074727565206f72206e6f742c20616e642077686574686572207265636f7264656420696e2061206d6174657269616c20666f726d206f72206e6f742c2061626f757420616e20696e646976696475616c2077686f7365206964656e74697479206973206170706172656e742c206f722063616e20726561736f6e61626c792062652061736365727461696e65642c2066726f6d2074686520696e666f726d6174696f6e206f72206f70696e696f6e2028736f757263653a2050726976616379204163742031393838292e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e3120506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e266e6273703b266e6273703b266e6273703b266e6273703b266e6273703b266e6273703b266e6273703b3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e3120436f6c6c656374696f6e204f6620506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3a3c2f703e0d0a0d0a3c703e57652077696c6c206f6e6c7920636f6c6c65637420706572736f6e616c20696e666f726d6174696f6e2061626f757420796f75206279206c617766756c20616e642066616972206d65616e7320616e64206e6f7420696e20616e20756e726561736f6e61626c7920696e74727573697665206d616e6e65722e20546865207479706573206f6620706572736f6e616c20696e666f726d6174696f6e207765206d617920636f6c6c65637420696e636c7564653a206964656e74696679696e6720616e6420636f6e7461637420696e666f726d6174696f6e2c2073756368206173206e616d652c206167652c20656d706c6f796d656e742064657461696c732c20656d61696c206164647265737320616e64206d6f62696c652070686f6e65206e756d6265723b2066696e616e6369616c20696e666f726d6174696f6e2c20737563682061732062616e6b206163636f756e742064657461696c733b2073656e73697469766520696e666f726d6174696f6e2c20696e636c7564696e6720696e666f726d6174696f6e2061626f7574206865616c746820616e642077656c6c6265696e672070726f6475637469766974792070726f766964656420746f20796f753b20616e6420696e666f726d6174696f6e2061626f757420796f757220616374697669746965732c20696e636c7564696e672073706f7274696e6720616e64206f74686572206c6966657374796c6520696e746572657374732e3c2f703e0d0a0d0a3c703e576520636f6c6c65637420796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e20746f2070726f7669646520796f7520776974682070726f647563747320616e642073657276696365732c20696e636c7564696e67206865616c74682072656c617465642073657276696365732c20696e666f726d6174696f6e206f6e206f746865722070726f647563747320616e64207365727669636573206f6666657265642062792075732c206f6e65206f66206f757220737562736964696172696573206f7220612074686972642070617274792c20616e6420746f20666163696c697461746520616e6420617373657373207468652070726f766973696f6e206f66206865616c74682072656c6174656420736572766963657320746f20796f752062792075732c206f75722073756273696469617269657320616e6420746869726420706172746965732e3c2f703e0d0a0d0a3c703e5765206d617920636f6c6c65637420796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e2066726f6d20796f752c206f722066726f6d206120706572736f6e20617574686f726973656420746f2070726f76696465207573207468697320696e666f726d6174696f6e206f6e20796f757220626568616c662e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e3220557365204f6620506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312077696c6c206e6f742075736520706572736f6e616c20696e666f726d6174696f6e20636f6e6365726e696e6720616e20696e646976696475616c20666f72206120707572706f7365206f74686572207468616e20746865207072696d61727920707572706f736520666f722077686963682069742077617320636f6c6c65637465642c20756e6c657373204f41523231206f7220697473205061727469636970616e7420686173206f627461696e656420796f757220636f6e73656e7420746f2074686520757365206f66207468617420696e666f726d6174696f6e20666f722061207365636f6e64617279207573652c207375636820617320646972656374206d61726b6574696e672e20416e7920706572736f6e616c20696e666f726d6174696f6e20636f6c6c656374656420616e642f6f722073746f72656420666f72206f6e65205061727469636970616e74206973206e65766572207573656420666f72206f7220646973636c6f73656420746f20616e6f74686572205061727469636970616e74206f7220746f20616e79206f746865722074686972642070617274792c20616e642077652077696c6c206e6f74206964656e7469667920796f7520696e20616e792077617920746f20616e7920746869726420706172747920657863657074206173207265717569726564206279206c61772e3c2f703e0d0a0d0a3c703e57652077696c6c2075736520796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e20666f722074686520707572706f73657320666f7220776869636820776520636f6c6c656374206974206173206465736372696265642061626f76652c20696e636c7564696e6720746f3a206d616e616765206f7572206f6e676f696e672072656c6174696f6e73686970207769746820796f753b2061646d696e69737465722c2070726f6365737320616e6420617564697420636c61696d733b206d616e6167652c207265766965772c20646576656c6f7020616e6420696d70726f7665206f75722070726f647563747320616e642072656c6174656420736572766963657320776865746865722070726f7669646564206279207573206f72206f746865722070617274696573206f6e206f757220626568616c663b206d616e6167652c207265766965772c20646576656c6f7020616e6420696d70726f7665206f757220627573696e65737320616e64206f7065726174696f6e616c2070726f63657373657320616e642073797374656d732c20696e636c7564696e67207468652073657276696365732070726f766964656420746f20796f75206279206f757220636f6e7472616374656420736572766963652070726f766964657273202873756368206173206f7572207375627369646961726965732920616e64206f7468657220706172746965733b207265736f6c766520616e79206c6567616c20616e642f6f7220636f6d6d65726369616c20636f6d706c61696e7473206f72206973737565733b20616e6420706572666f726d20616e79206f66206f7572206f746865722066756e6374696f6e7320616e6420616374697669746965732072656c6174696e6720746f206f757220627573696e6573732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e3320446973636c6f73696e6720506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e496e206f7264657220746f206361727279206f7574207468652061626f766520707572706f7365732c204f41523231206d617920646973636c6f736520796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e20746f20706572736f6e73206f72206f7267616e69736174696f6e7320287768696368206d6179206265206c6f6361746564206f766572736561732920737563682061733a206f7572207375627369646961726965733b206f7572206167656e747320616e6420736572766963652070726f7669646572733b206f75722070726f66657373696f6e616c2061647669736f72733b207061727469657320696e766f6c76656420696e20612070726f7370656374697665206f722061637475616c207472616e73666572206f6620616e79207061727473206f66206f757220617373657473206f7220627573696e6573733b207061796d656e742073797374656d206f70657261746f727320616e642066696e616e6369616c20696e737469747574696f6e733b20706572736f6e7320617574686f7269736564206279206f7220726573706f6e7369626c6520666f7220796f752c20696e636c7564696e6720796f7572206167656e747320616e642061647669736f72733b20676f7665726e6d656e74206167656e636965733b20616e64206f74686572207061727469657320746f2077686f6d2077652061726520617574686f7269736564206f72207265717569726564206279206c617720746f20646973636c6f736520696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e57652077696c6c2068616e646c6520616c6c20706572736f6e616c2028696e636c7564696e672073656e73697469766520696e666f726d6174696f6e2920776520636f6c6c6563742066726f6d20746869726420706172746965732061626f757420796f7520666f722074686520707572706f7365732064657363726962656420696e2074686973205072697661637920506f6c6963792e204f75722072616e6765206f662070726f647563747320616e6420736572766963657320616e64206f75722066756e6374696f6e7320616e6420616374697669746965732c2061732077656c6c2061732074686f7365206f66206f757220636f6e7472616374656420736572766963652070726f7669646572732c206d6179206368616e67652066726f6d2074696d6520746f2074696d652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e34205365637572697479206f6620506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e546f2074686520657874656e74207265717569726564206279207468652050726976616379204163742c204f415232312077696c6c2074616b6520726561736f6e61626c6520737465707320746f3a206d616b65207375726520746861742074686520706572736f6e616c20696e666f726d6174696f6e207468617420776520636f6c6c6563742c2075736520616e6420646973636c6f73652069732061636375726174652c20636f6d706c65746520616e6420757020746f20646174653b2070726f746563742074686520706572736f6e616c20696e666f726d6174696f6e207468617420776520686f6c642066726f6d206d697375736520616e64206c6f737320616e642066726f6d20756e617574686f7269736564206163636573732c206d6f64696669636174696f6e206f7220646973636c6f737572653b20616e64207768657265207065726d6974746564206279206c61772c2064657374726f79206f72207065726d616e656e746c792064652d6964656e7469667920706572736f6e616c20696e666f726d6174696f6e2074686174206973206e6f206c6f6e676572206e656564656420666f7220616e7920707572706f73652074686174206973207065726d6974746564206279207468652050726976616379204163742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e352053656e73697469766520506572736f6e616c20446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e53656e73697469766520706572736f6e616c206461746120696e636c7564657320706572736f6e616c2064617461207472656174656420627920612072616e6765206f662068756d616e207269676874732062617365642070726976616379206c61777320617320726571756972696e67207370656369616c2074726561746d656e742c20696e636c7564696e6720696e20736f6d652063697263756d7374616e63657320746865206e65656420746f206f627461696e206578706c6963697420636f6e73656e742e2054686573652063617465676f7269657320636f6d707269736520706572736f6e616c206964656e74697479206e756d626572732c20706572736f6e616c20646174612061626f757420706572736f6e616c69747920616e642070726976617465206c6966652c2072616369616c206f72206574686e6963206f726967696e2c206e6174696f6e616c6974792c20706f6c69746963616c206f70696e696f6e732c206d656d62657273686970206f6620706f6c69746963616c2070617274696573206f72206d6f76656d656e74732c2072656c6967696f75732c207068696c6f736f70686963616c206f72206f746865722073696d696c61722062656c696566732c206d656d62657273686970206f66206120747261646520756e696f6e206f722070726f66657373696f6e206f72207472616465206173736f63696174696f6e2c20706879736963616c206f72206d656e74616c206865616c74682c2067656e6574696320636f64652c20616464696374696f6e732c2073657875616c206c6966652c2070726f7065727479206d617474657273206f72206372696d696e616c207265636f72642028696e636c7564696e6720696e666f726d6174696f6e2061626f757420737573706563746564206372696d696e616c2061637469766974696573292e3c2f703e0d0a0d0a3c703e42792070726f766964696e67207573207769746820756e736f6c6963697465642073656e73697469766520706572736f6e616c20696e666f726d6174696f6e2c20796f7520636f6e73656e7420746f206f7572207573696e67207468652064617461207375626a65637420746f206170706c696361626c65206c61772061732064657363726962656420696e207468697320507269766163792053746174656d656e742e2053686f756c64207765206265207365656b696e6720746f20636f6c6c65637420706572736f6e616c2073656e736974697665206461746120666f722074686520707572706f736573206f6620726573656172636820616e642f6f7220737572766579732c2077652077696c6c206e6f74206964656e7469667920796f7520696e2072656c6174696f6e20746f20616e79207468697264207061727469657320657863657074206173207265717569726564206279206c617720616e642077696c6c20646f20616c6c207468696e677320726561736f6e61626c6520746f2070726f7465637420796f757220707269766163792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e3620537562636f6e74726163746f72733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312072657175697265732073747269637420636f6d706c69616e6365207769746820746865204e6174696f6e616c2050726976616379205072696e6369706c657320627920616c6c206f662069747320737562636f6e74726163746f72732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e3720416363657373696e6720596f757220496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e596f752068617665206120726967687420746f206b6e6f77207768657468657220776520686176652072657461696e656420616e7920706572736f6e616c20696e666f726d6174696f6e2061626f757420796f7520616e642c20696620776520646f2c20746f2061636365737320796f757220706572736f6e616c20696e666f726d6174696f6e2e20596f752063616e20646f20736f20627920656d61696c696e67207573207573696e67206f7572206f6e6c696e6520666f726d203c6120687265663d222f636f6e74616374223e686572653c2f613e2e204f415232312072657365727665732069747320726967687420746f2063686172676520612066656520666f7220616e7920706172746963756c61722074696d6520636f6e73756d696e67206f72206f6e65726f75732072657175657374732c20686f77657665722073686f756c642073756368206120666565206170706c79207468656e2077652077696c6c2061647669736520796f75206f662074686973206265666f726520796f7520696e63757220616e7920636861726765732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e312e3820416e6f6e796d6974793c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312077696c6c2067656e6572616c6c792070726f7669646520696e646976696475616c73207769746820746865206f7074696f6e206f66206e6f74206964656e74696679696e67207468656d73656c766573207768656e20656e746572696e67207472616e73616374696f6e73207768656e206974206973206c617766756c20616e64207072616374696361626c6520746f20646f20736f2e20486f77657665722c206f6e206d616e79206f63636173696f6e732077652077696c6c206e6f742062652061626c6520746f20646f20746869732e20466f72206578616d706c652c2077652077696c6c206e65656420796f7572206e616d6520616e64206164647265737320696e206f7264657220746f2070726f7669646520796f75207769746820616e206163636f756e742e3c2f703e0d0a0d0a3c703e4f415232312077696c6c206e6f742075736520436f6d6d6f6e7765616c746820676f7665726e6d656e74206964656e7469666965727320617320697473206f776e206964656e746966696572206f6620696e646976696475616c732e2057652077696c6c206f6e6c7920757365206f7220646973636c6f73652073756368206964656e7469666965727320696e207468652063697263756d7374616e636573207065726d6974746564206279207468652050726976616379204163742e3c2f703e0d0a0d0a3c703e4966204f41523231207472616e736665727320796f757220706572736f6e616c20696e666f726d6174696f6e206f757473696465204175737472616c69612c2077652077696c6c20636f6d706c7920776974682074686520726571756972656d656e7473206f662074686520507269766163792041637420746861742072656c61746520746f207472616e732d626f72646572206461746120666c6f77732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e3220496e7465726e616c205061727469636970616e7420557361676520446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e322e31205061727469636970616e7420446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e536f6d65206172656173206f66207468652053657276696365206d617920616c6c6f77205061727469636970616e747320746f20706f737420666565646261636b2c20636f6d6d656e74732c207175657374696f6e732c20646174612c20616e64206f7468657220696e666f726d6174696f6e2028266c6471756f3b5061727469636970616e7420436f6e74656e7426726471756f3b292e20596f752061726520736f6c656c7920726573706f6e7369626c6520666f7220796f7572205061727469636970616e7420436f6e74656e74207468617420796f752075706c6f61642c207075626c6973682c20646973706c61792c206c696e6b20746f206f72206f7468657277697365206d616b6520617661696c61626c65202868657265696e61667465722c20266c6471756f3b706f737426726471756f3b29206f6e2074686520536572766963652c20616e6420796f75206167726565207468617420776520617265206f6e6c7920616374696e672061732061207061737369766520636f6e6475697420666f7220796f7572206f6e6c696e6520646973747269627574696f6e20616e64207075626c69636174696f6e206f6620796f7572205061727469636970616e7420436f6e74656e742e204f415232312077696c6c206e6f74207265766965772c2073686172652c20646973747269627574652c206f72207265666572656e636520616e792073756368205061727469636970616e7420436f6e74656e74206578636570742061732070726f76696465642068657265696e206f7220696e206f7572205072697661637920506f6c696379206f72206173206d6179206265207265717569726564206279206c61772e20416273656e742061204e6574776f726b2041646d696e6973747261746f722c20616c6c2073756368205061727469636970616e7420436f6e74656e74206973206f776e656420627920746865205061727469636970616e742077686f20706f7374656420697420746f2074686520536572766963652c20616c74686f7567682065616368205061727469636970616e742061636b6e6f776c656467657320616e6420636f6e73656e747320746861742075706f6e2074686520696e74726f64756374696f6e206f662061204e6574776f726b2041646d696e6973747261746f7220696e746f2074686174205061727469636970616e7426727371756f3b73206e6574776f726b2c20616c6c2072656c61746564205061727469636970616e7420436f6e74656e742077696c6c206175746f6d61746963616c6c79206265636f6d65207468652070726f7065727479206f662074686520636f6d70616e7920746f20776869636820746865204e6574776f726b2062656c6f6e677320776974686f757420616e79206e6f7469636520746f205061727469636970616e7473206f662074686174204e6574776f726b2e2049662061204e6574776f726b206861732061204e6574776f726b2041646d696e6973747261746f722c20616c6c2073756368205061727469636970616e7420436f6e74656e74206973207468652070726f7065727479206f662074686520636f6d70616e7920746f20776869636820746865204e6574776f726b2062656c6f6e67732028696e636c7564696e6720616c6c205061727469636970616e7420436f6e74656e7420706f7374656420746f20612073706563696669632047726f7570206f722047726f7570732077697468696e2061204e6574776f726b20616e6420616c6c205061727469636970616e7420436f6e74656e742063726561746564207072696f7220746f20746865206578697374656e6365206f6620746865204e6574776f726b2041646d696e6973747261746f72292e20496e2065697468657220636173652c204f4152323120646f6573206e6f7420686176652c206e6f7220646f657320697420636c61696d2c20616e79206f776e6572736869702072696768747320696e20616e79205061727469636970616e7420436f6e74656e742e20496e206164646974696f6e2c20796f752073686f756c64206e6f7465207468617420696620796f7520617265206e6f206c6f6e67657220616e20656c696769626c65206d656d626572206f6620612067726f75702028652e672e2c20796f7520636561736520746f20626520656d706c6f796564206279207468652072656c6576616e7420636f6d70616e792074686174206861732073706f6e736f72656420796f7520746f20706172746963697061746520696e20616e204f415232312070726f6772616d292c20796f75722061636365737320746f20616c6c205061727469636970616e7420436f6e74656e7420796f752075706c6f61646564206d6179206265207465726d696e617465642c207265676172646c657373206f66207768657468657220746865206e6574776f726b206861732061204e6574776f726b2041646d696e6973747261746f722e204f6e63652061205061727469636970616e742069732072656d6f7665642066726f6d2061204e6574776f726b2c2074686520636f6e74656e74206f662074686174205061727469636970616e742072656d61696e73206f6e20746865204e6574776f726b20616e642069732074686520736f6c652070726f7065727479206f662074686520636f6d70616e792077686963682061646d696e6973746572732074686174204e6574776f726b2e3c2f703e0d0a0d0a3c703e546865205061727469636970616e74204461746120697320616c6c2074686520646174612c20696e636c7564696e6720616c6c20746578742c20736f756e642c20736f667477617265206f7220696d6167652066696c6573207468617420796f752070726f766964652c206f72206172652070726f7669646564206f6e20796f757220626568616c662c20746f207573207468726f75676820796f757220757365206f66207468652053657276696365732e205765206d616b65206e6f20636c61696d206f66206f776e65727368697020696e20796f757220746865205061727469636970616e7420446174612e204578636570742061732070726f766964656420696e207468697320707269766163792073746174656d656e74206f722064657363726962656420696e20796f75722061677265656d656e74732c207765206f6e6c792075736520746865205061727469636970616e74204461746120746f2070726f7669646520616e6420656e68616e6365207468652053657276696365732e20576520646f6e26727371756f3b7420736861726520796f7572205061727469636970616e74204461746120776974682061647665727469736572732c206f72207769746820616e79626f647920656c73652065786365707420696e207468652076657279206c696d697465642063697263756d7374616e636573206465736372696265642061626f76652e3c2f703e0d0a0d0a3c703e4279207574696c6973696e672074686520536572766963652c20796f7520616772656520746f20686176652074686520646f6d61696e20706f7274696f6e206f6620796f757220656d61696c20616464726573732028266c6471756f3b40796f7572636f72702e636f6d26726471756f3b2920616e642f6f722074686520636f6d70616e792c207363686f6f6c2c206f72206f7267616e69736174696f6e206e616d6520726570726573656e746564206279207375636820646f6d61696e20706f7274696f6e206f6620796f757220656d61696c20616464726573732c206c6973746564206f6e20746865204f41523231205365727669636520696e206120636f6d70616e79206469726563746f7279206c697374696e672028266c6471756f3b4469726563746f727926726471756f3b292e2054686520437573746f6d6572732028617320646566696e65642062656c6f77292077686f20646f206e6f742077616e7420746f20626520696e636c7564656420696e2073756368207075626c6973686564204469726563746f7279206d61792073656e642061207772697474656e207265717565737420766961203c6120687265663d222f636f6e74616374223e6f7572206f6e6c696e6520666f726d3c2f613e20746f2072656d6f766520746865697220636f6d70616e792c207363686f6f6c2c206f72206f7267616e69736174696f6e206e616d652066726f6d20746865204469726563746f72792e204365727461696e20436f72706f72617465204e6574776f726b732068617665206e65676f7469617465642066757274686572206d6f64696669636174696f6e7320746f20776861742077652077696c6c2070757420696e746f20746865204469726563746f72792e3c2f703e0d0a0d0a3c703e4f415232312074616b6573206e6f20726573706f6e736962696c69747920616e6420617373756d6573206e6f206c696162696c69747920666f7220616e79205061727469636970616e7420436f6e74656e74207468617420796f75206f7220616e79206f74686572205061727469636970616e7473206f72207468697264207061727469657320706f7374206f722073656e64206f7665722074686520536572766963652e20596f7520756e6465727374616e6420616e64206167726565207468617420616e79206c6f7373206f722064616d616765206f6620616e79206b696e642074686174206f6363757273206173206120726573756c74206f662074686520757365206f6620616e79205061727469636970616e7420436f6e74656e74207468617420796f752073656e642c2075706c6f61642c20646f776e6c6f61642c2073747265616d2c20706f73742c207472616e736d69742c20646973706c61792c206f72206f7468657277697365206d616b6520617661696c61626c65206f7220616363657373207468726f75676820796f757220757365206f662074686520536572766963652c20697320736f6c656c7920796f757220726573706f6e736962696c6974792e204f41523231206973206e6f7420726573706f6e7369626c6520666f7220616e79207075626c696320646973706c6179206f72206d6973757365206f6620796f7572205061727469636970616e7420436f6e74656e742e20596f7520756e6465727374616e6420616e642061636b6e6f776c65646765207468617420796f75206d6179206265206578706f73656420746f205061727469636970616e7420436f6e74656e74207468617420697320696e61636375726174652c206f6666656e736976652c20696e646563656e742c206f72206f626a656374696f6e61626c652c20616e6420796f752061677265652074686174204f41523231207368616c6c206e6f74206265206c6961626c6520666f7220616e792064616d6167657320796f7520616c6c65676520746f20696e637572206173206120726573756c74206f662073756368205061727469636970616e7420436f6e74656e742e3c2f703e0d0a0d0a3c703e596f752061726520736f6c656c7920726573706f6e7369626c6520666f7220796f757220696e746572616374696f6e732077697468206f74686572205061727469636970616e74732e2057652072657365727665207468652072696768742c206275742068617665206e6f206f626c69676174696f6e2c20746f206d6f6e69746f72206469737075746573206265747765656e20796f7520616e64206f74686572205061727469636970616e74732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e322e323c2f7374726f6e673e203c7374726f6e673e436f6e7461637420446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e436f6e74616374204461746120696e636c75646573206e616d652c20616464726573732c2070686f6e65206e756d6265722c2070726f66696c6520696e666f726d6174696f6e2c20656d61696c20616464726573732c207469746c652c2074696d65207a6f6e6520616e64206f7468657220636f6e7461637420696e666f726d6174696f6e2074686174207765206d617920636f6c6c656374207468726f75676820796f75722061646d696e697374726174696f6e206f662074686520536572766963657320616e6420757365206f662074686520536572766963657320627920796f7520616e64206f74686572732e20436f6e74616374204461746120796f752070726f766964652061732070617274206f6620796f7572204f415232312070726f66696c6520697320617661696c61626c6520746f206f74686572205061727469636970616e7473206f6620796f7572204e6574776f726b2873292e3c2f703e0d0a0d0a3c703e4f4152323120776f726b7320626574746572207768656e206d6f72652070656f706c652074616b65207061727420696e20636f6d6d756e69636174696e6720616e642073686172696e67206f6e206f75722053657276696365732e20466f72207468697320726561736f6e2c20746865205365727669636520656e636f7572616765732070656f706c6520746f2073656e6420696e7669746174696f6e7320746f206f74686572732077686f20617265206e6f742079657420636f6e6e656374656420746f206f75722053657276696365732e20496620796f752063686f6f736520746f2070726f76696465207573207769746820656d61696c20616464726573736573206f72206f7468657220436f6e746163742044617461206f662070656f706c6520696e73696465206f72206f75747369646520796f7572206f7267616e69736174696f6e2c2077652077696c6c20757365207468617420696e666f726d6174696f6e20746f20656e61626c6520796f7520616e64206f74686572205061727469636970616e747320746f20696e766974652074686f73652070656f706c6520746f206a6f696e2074686520617070726f707269617465204f4152323120536572766963652e3c2f703e0d0a0d0a3c703e5765206d617920616c736f207375676765737420636f6e7461637473207468617420796f75206d61792077616e7420746f2061646420746f20796f7572204e6574776f726b2e20496620796f752063686f6f736520746f20616464207468656d20746f20796f7572204e6574776f726b2c2077652077696c6c2073656e64207468656d20616e20696e7669746174696f6e20746f206a6f696e20796f7572204e6574776f726b2062792073656e64696e6720616e20656d61696c206f6e20796f757220626568616c66207768696368206d617920696e636c75646520796f7572206e616d652c207069637475726520616e64206f746865722070726f66696c6520696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e496e206164646974696f6e2c204f41523231207573657320436f6e74616374204461746120746f20636f6d706c65746520746865207472616e73616374696f6e7320796f7520726571756573742c2061646d696e697374657220796f7572206163636f756e742c20696d70726f76652074686520536572766963657320616e642064657465637420616e642070726576656e742066726175642e3c2f703e0d0a0d0a3c703e5765206d617920616c736f2075736520436f6e74616374204461746120746f20636f6e7461637420796f7520746f2070726f7669646520696e666f726d6174696f6e2061626f7574206e657720737562736372697074696f6e732c2062696c6c696e6720616e6420696d706f7274616e7420757064617465732061626f7574207468652053657276696365732c20696e636c7564696e6720696e666f726d6174696f6e2061626f7574207365637572697479206f72206f7468657220746563686e6963616c206973737565732e205765206d617920616c736f20636f6e7461637420796f7520726567617264696e672074686972642d706172747920696e717569726965732061732064657363726962656420696e207468697320707269766163792073746174656d656e74206f7220796f75722061677265656d656e742873292e20496620796f752061726520612076657269666965642061646d696e6973747261746f7220666f722074686520536572766963652c20796f75206d6179206e6f742062652061626c6520746f20756e7375627363726962652066726f6d20736f6d65206f6620746865736520636f6d6d756e69636174696f6e732e3c2f703e0d0a0d0a3c703e5375626a65637420746f20796f757220636f6e7461637420707265666572656e6365732c207765206d617920616c736f2075736520436f6e74616374204461746120746f20636f6e7461637420796f7520726567617264696e6720696e666f726d6174696f6e20616e64206f66666572732061626f75742074686520536572766963652c206f746865722070726f647563747320616e64207365727669636573206f7220746f207265717565737420796f757220666565646261636b2e20496620796f7520646f206e6f74207769736820746f207265636569766520746865736520636f6d6d756e69636174696f6e732c20706c65617365203c6120687265663d222f636f6e74616374223e656d61696c2075733c2f613e266e6273703b666f7220696e666f726d6174696f6e206f6e20686f7720746f2073746f70207468656d20616e6420636f6e666967757265206f74686572206e6f74696669636174696f6e20707265666572656e6365732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e322e333c2f7374726f6e673e203c7374726f6e673e557361676520446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5765206d61792075736520737461746973746963616c20646174612c20616e616c79746963732c207472656e647320616e6420757361676520696e666f726d6174696f6e20646572697665642066726f6d20796f757220757365206f66207468652053657276696365732028266c6471756f3b7573616765206461746126726471756f3b292e205573616765206461746120696e636c756465732c20666f72206578616d706c652c2061676772656761746564207175616e746974617469766520696e666f726d6174696f6e2061626f757420616374697665205061727469636970616e74732c2061637469766974792c20746f706963732c20616e642067726f7570732e20536f6d6520776179732077652075736520746865207573616765206461746120696e636c7564652070726f766964696e672064652d6964656e7469666965642c20616767726567617465642064617461207265706f72747320746f20796f75722061646d696e6973747261746f7220616e642f6f722073706f6e736f72696e67206f7267616e69736174696f6e20616e6420666f722074686520707572706f736573206f66206f7065726174696e672c20696d70726f76696e6720616e6420706572736f6e616c6973696e672074686520536572766963657320616e64206f7572206f66666572696e67732c2061732077656c6c206173206f74686572204f415232312070726f647563747320616e642073657276696365732e2045786365707420746f2070726f76696465207265706f72747320746f20796f75206f72206f746865727320696e20796f7572206f7267616e69736174696f6e2c20776520646f206e6f7420646973636c6f7365207573616765206461746120696e206120776179207768696368206973206964656e7469666961626c6520746f20796f7572206f7267616e69736174696f6e206f72205061727469636970616e747320696e20796f7572204e6574776f726b2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e322e343c2f7374726f6e673e203c7374726f6e673e537570706f727420446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e537570706f727420446174612069732074686520696e666f726d6174696f6e20776520636f6c6c656374207768656e20796f75207375626d6974206120737570706f72742072657175657374206f722072756e20616e206175746f6d617465642074726f75626c6573686f6f7465722c20696e636c7564696e6720696e666f726d6174696f6e2061626f75742068617264776172652c20736f6674776172652c20616e64206f746865722064657461696c732072656c6174656420746f2074686520737570706f727420696e636964656e742c20737563682061733a20636f6e74616374206f722061757468656e7469636174696f6e20696e666f726d6174696f6e2c20636861742073657373696f6e20706572736f6e616c69736174696f6e2c20696e666f726d6174696f6e2061626f75742074686520636f6e646974696f6e206f662074686520636f6d707574657220616e6420746865206170706c69636174696f6e207768656e20746865206661756c74206f6363757272656420616e6420647572696e6720646961676e6f73746963732c2073797374656d20616e6420726567697374727920646174612061626f757420736f66747761726520696e7374616c6c6174696f6e7320616e6420686172647761726520636f6e66696775726174696f6e732c20616e64206572726f722d747261636b696e672066696c65732e3c2f703e0d0a0d0a3c703e537570706f7274206d61792062652070726f7669646564207468726f7567682070686f6e652c20652d6d61696c2c206f72206f6e6c696e6520636861742e205765206d6179207573652052656d6f74652041636365737320285241292c207769746820796f7572207065726d697373696f6e2c20746f2074656d706f726172696c79206e6176696761746520796f7572206465736b746f702e2050686f6e6520636f6e766572736174696f6e732c206f6e6c696e6520636861742073657373696f6e732c206f722052412073657373696f6e73207769746820737570706f72742070726f66657373696f6e616c73206d6179206265207265636f7264656420616e642f6f72206d6f6e69746f7265642e20466f722052412c20796f75206d617920616c736f2061636365737320746865207265636f7264696e6720616674657220796f75722073657373696f6e2e20466f72204f6e6c696e652043686174206f722052412c20796f75206d617920656e6420612073657373696f6e20617420616e792074696d65206f6620796f75722063686f6f73696e672e2057652075736520537570706f7274204461746120696e207468652073616d65207761792061732077652075736520796f757220696e666f726d6174696f6e2e204164646974696f6e616c6c792c2077652075736520697420746f207265736f6c766520796f757220737570706f727420696e636964656e7420616e6420666f7220747261696e696e6720707572706f7365732e3c2f703e0d0a0d0a3c703e466f6c6c6f77696e67206120737570706f727420696e636964656e742c207765206d61792073656e6420796f752061207375727665792061626f757420796f757220657870657269656e636520616e64206f66666572696e67732e20596f75206d757374206f70742d6f7574206f6620737570706f727420737572766579732073657061726174656c792066726f6d206f7468657220636f6d6d756e69636174696f6e732070726f7669646564206279204f415232312c20627920636f6e74616374696e6720537570706f7274206f72207468726f756768203c6120687265663d222f636f6e74616374223e656d61696c696e67207573207573696e672074686973206f6e6c696e6520666f726d3c2f613e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e322e353c2f7374726f6e673e203c7374726f6e673e436f6f6b6965732026616d703b204f7468657220496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5468652053657276696365207573657320266c6471756f3b636f6f6b6965732671756f743b2c2077686963682061726520736d616c6c20746578742066696c657320706c61636564206f6e20612064657669636526727371756f3b732068617264206469736b206279206120776562207365727665722e205765206d61792075736520636f6f6b69657320616e642073696d696c617220746563686e6f6c6f6769657320666f722073746f72696e67205061727469636970616e747326727371756f3b20707265666572656e63657320616e642073657474696e67732c20746f2061757468656e746963617465205061727469636970616e74732c20746f20636f6c6c656374207573616765206461746120616e64206f7065726174652074686520536572766963652e3c2f703e0d0a0d0a3c703e536f6d65206f662074686520636f6f6b69657320776520636f6d6d6f6e6c792075736520617265206c697374656420696e2074686520666f6c6c6f77696e672063686172742e2054686973206c697374206973206e6f7420657868617573746976652c2062757420697420697320696e74656e64656420746f20696c6c7573747261746520736f6d65206f662074686520726561736f6e732077652073657420636f6f6b6965732e205768656e2061205061727469636970616e7420766973697473207468652053657276696365206974206d61792073657420736f6d65206f7220616c6c206f662074686520666f6c6c6f77696e6720636f6f6b6965733a3c2f703e0d0a0d0a3c7461626c6520626f726465723d2231222063656c6c70616464696e673d2230222063656c6c73706163696e673d2230223e0d0a093c74626f64793e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e3c7374726f6e673e436f6f6b6965206e616d653c2f7374726f6e673e3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e3c7374726f6e673e4465736372697074696f6e3c2f7374726f6e673e266e6273703b3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e62726f777365725f746f6b656e3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e4964656e74696669657320756e697175652062726f777365727320746f2074686520536572766963652e204974206973207573656420666f72205365727669636520616e616c797469637320616e64206f74686572206f7065726174696f6e616c20707572706f7365732e3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e617574685f746f6b656e2c20617574685f746f6b656e5f73736f3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e53746f726520696e666f726d6174696f6e2061626f75742061757468656e7469636174696f6e20707265666572656e6365733c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e5f776f726b666565645f73657373696f6e3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e53657473206120756e69717565204944206964656e74696679696e6720746865205061727469636970616e742073657373696f6e2e204974206973207573656420666f72205365727669636520616e616c797469637320616e64206f74686572206f7065726174696f6e616c20707572706f7365732e3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e79616d7472616b5f69643c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e4120636f6f6b6965207573656420666f722067656e65726174696e6720616e616c79746963616c20696e666f726d6174696f6e3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e756e76657269666965645f656d61696c3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e53746f72657320746865206c6f67696e206f6620616e2061757468656e74696361746564205061727469636970616e743c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a093c2f74626f64793e0d0a3c2f7461626c653e0d0a0d0a3c703e3c6272202f3e0d0a3c7374726f6e673e322e322e363c2f7374726f6e673e203c7374726f6e673e53686172696e6720596f757220496e666f726d6174696f6e3c2f7374726f6e673e266e6273703b3c6272202f3e0d0a57652077696c6c206e6f7420646973636c6f736520746865205061727469636970616e742044617461206f7220436f6e7461637420446174612028266c6471756f3b796f757220696e666f726d6174696f6e26726471756f3b29206f757473696465206f66204f41523231206f722069747320636f6e74726f6c6c65642073756273696469617269657320616e6420616666696c69617465732065786365707420617320796f75206469726563742c206f722061732064657363726962656420696e20796f75722061677265656d656e74287329206f72207468697320707269766163792073746174656d656e742e3c2f703e0d0a0d0a3c756c3e0d0a093c6c693e576520646f6e26727371756f3b7420736861726520616e79206f6620796f757220696e666f726d6174696f6e20776974682061647665727469736572732e3c2f6c693e0d0a093c6c693e5765206f63636173696f6e616c6c7920636f6e74726163742077697468206f7468657220636f6d70616e69657320746f2070726f7669646520736572766963657320287375636820617320746865205061727469636970616e7420737570706f72742c2064617461206d616e6167656d656e742c20616e6420746563686e6963616c20696e66726173747275637475726520736572766963657329206f6e206f757220626568616c662e205765206d61792070726f7669646520746865736520636f6d70616e69657320776974682061636365737320746f20796f757220696e666f726d6174696f6e207768657265206e656365737361727920666f7220746865697220656e676167656d656e742e20546865736520636f6d70616e6965732061726520726571756972656420746f206d61696e7461696e2074686520636f6e666964656e7469616c697479206f6620796f757220696e666f726d6174696f6e20616e64206172652070726f686962697465642066726f6d207573696e6720697420666f7220616e7920707572706f7365206f74686572207468616e207468617420666f7220776869636820746865792061726520656e6761676564206279204f415232312e3c2f6c693e0d0a093c6c693e57652077696c6c206e6f7420646973636c6f736520796f757220696e666f726d6174696f6e20746f20612074686972642070617274792028696e636c7564696e67206c617720656e666f7263656d656e742c206f7468657220676f7665726e6d656e7420656e746974792c206f7220636976696c206c69746967616e743b206578636c7564696e67206f757220737562636f6e74726163746f7273292065786365707420617320796f7520646972656374206f7220756e6c657373206e656365737361727920746f2061646472657373206120736572696f75732074687265617420746f206c6966652c206865616c7468206f72207361666574792c206f72206f7468657277697365206173207265717569726564206279206c61772e2053686f756c64206120746869726420706172747920636f6e74616374204f4152323120776974682061207265717565737420666f7220796f757220696e666f726d6174696f6e2c2077652077696c6c20617474656d707420746f2072656469726563742074686520746869726420706172747920746f2072657175657374207468652064617461206469726563746c792066726f6d20796f752e2041732070617274206f6620746861742070726f636573732c207765206d61792070726f7669646520796f757220626173696320636f6e7461637420696e666f726d6174696f6e20746f207468652074686972642070617274792e204966206c6567616c6c7920636f6d70656c6c656420746f20646973636c6f736520796f757220696e666f726d6174696f6e20746f20612074686972642070617274792c2077652077696c6c2075736520636f6d6d65726369616c6c7920726561736f6e61626c65206566666f72747320746f206e6f7469667920796f7520696e20616476616e6365206f66206120646973636c6f7375726520756e6c657373206c6567616c6c792070726f686962697465642e3c2f6c693e0d0a093c6c693e4f41523231206d617920736861726520436f6e7461637420446174612077697468207468697264207061727469657320666f7220707572706f736573206f662066726175642070726576656e74696f6e206f7220746f2070726f63657373207061796d656e74207472616e73616374696f6e732c20617320667572746865722064657363726962656420696e20746869732073746174656d656e742e3c2f6c693e0d0a093c6c693e546865205365727669636573206d617920656e61626c6520796f7520746f2070757263686173652c2073756273637269626520746f2c206f72207573652073657276696365732c20736f6674776172652c20616e6420636f6e74656e742066726f6d20636f6d70616e696573206f74686572207468616e204f415232312028266c6471756f3b5468697264205061727479204f66666572696e677326726471756f3b292e20496620796f752063686f6f736520746f2070757263686173652c2073756273637269626520746f2c206f72207573652061205468697264205061727479204f66666572696e672c207765206d61792070726f7669646520746865207468697264207061727479207769746820796f757220436f6e74616374204461746120746f20656e61626c652074686520746869726420706172747920746f2070726f7669646520697473206f66666572696e6720746f20796f752028616e64207769746820796f757220636f6e73656e742c2073656e6420796f752070726f6d6f74696f6e616c20636f6d6d756e69636174696f6e73292e2054686174206461746120616e6420796f757220757365206f662061205468697264205061727479204f66666572696e672077696c6c20626520676f7665726e656420627920746865206170706c696361626c6520746869726420706172747920707269766163792073746174656d656e7428732920616e6420706f6c69636965732e3c2f6c693e0d0a093c6c693e57652077696c6c206e6f74207375627374616e746976656c7920726573706f6e6420746f20646174612070726f74656374696f6e20616e6420707269766163792072657175657374732066726f6d205061727469636970616e747320776974686f757420796f7572207072696f72207772697474656e20636f6e73656e742c20756e6c657373207265717569726564206279206170706c696361626c65206c61772e3c2f6c693e0d0a3c2f756c3e0d0a0d0a3c703e506c65617365206e6f7465207468617420746865205365727669636573206d617920696e636c756465206c696e6b7320746f206f7220616c6c6f7720796f7520746f20696e7374616c6c2074686972642d7061727479206f72206f74686572204f415232312070726f647563747320616e642073657276696365732077686f7365207072697661637920707261637469636573206d6179206469666665722066726f6d207468652053657276696365732e20596f757220757365206f6620737563682070726f6475637473206f722073657276696365732c20616e6420616e7920696e666f726d6174696f6e20796f752070726f7669646520746f20612074686972642070617274792c20697320676f7665726e656420627920746865697220707269766163792073746174656d656e74732e20576520656e636f757261676520796f7520746f20726576696577207468657365206f7468657220707269766163792073746174656d656e74732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e322e37205365637572697479206f6620496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5765206861766520696d706c656d656e74656420636f6d6d65726369616c6c7920726561736f6e61626c6520746563686e6963616c20616e64206f7267616e69736174696f6e616c206d656173757265732064657369676e656420746f2073656375726520796f757220706572736f6e616c20696e666f726d6174696f6e20616e64205061727469636970616e7420436f6e74656e742066726f6d206163636964656e74616c206c6f737320616e642066726f6d20756e617574686f7269736564206163636573732c207573652c20616c7465726174696f6e206f7220646973636c6f737572652e20486f77657665722c2077652063616e6e6f742067756172616e746565207468617420756e617574686f726973656420746869726420706172746965732077696c6c206e657665722062652061626c6520746f206465666561742074686f7365206d65617375726573206f722075736520796f757220706572736f6e616c20696e666f726d6174696f6e20616e64205061727469636970616e7420436f6e74656e7420666f7220696d70726f70657220707572706f7365732e20596f752061636b6e6f776c65646765207468617420796f752070726f7669646520796f757220706572736f6e616c20696e666f726d6174696f6e20617420796f7572206f776e207269736b2e3c2f703e0d0a0d0a3c703e5765206861766520696d706c656d656e74656420616e642077696c6c206d61696e7461696e20617070726f70726961746520746563686e6963616c20616e64206f7267616e69736174696f6e616c206d656173757265732c20696e7465726e616c20636f6e74726f6c732c20616e6420696e666f726d6174696f6e20736563757269747920726f7574696e657320696e74656e64656420746f2070726f7465637420796f757220696e666f726d6174696f6e20616761696e7374206163636964656e74616c206c6f73732c206465737472756374696f6e2c206f7220616c7465726174696f6e3b20756e617574686f726973656420646973636c6f73757265206f72206163636573733b206f7220756e6c617766756c206465737472756374696f6e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e33266e6273703b20436f6e666964656e7469616c6974793c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e332e3120436f6e666964656e7469616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e436f6e666964656e7469616c20696e666f726d6174696f6e206d65616e7320696e666f726d6174696f6e206d61726b6564206f72206f7468657277697365206964656e74696669656420696e2077726974696e6720627920612050617274792061732070726f7072696574617279206f7220636f6e666964656e7469616c206f7220746861742c20756e646572207468652063697263756d7374616e63657320737572726f756e64696e672074686520646973636c6f737572652c206f7567687420696e20676f6f6420666169746820746f20626520747265617465642061732070726f7072696574617279206f7220636f6e666964656e7469616c2e20497420696e636c756465732c20627574206973206e6f74206c696d6974656420746f2c206e6f6e2d7075626c696320696e666f726d6174696f6e20726567617264696e672065697468657220506172747926727371756f3b732070726f64756374732c2066656174757265732c206d61726b6574696e6720616e642070726f6d6f74696f6e732c20616e6420746865206e65676f746961746564207465726d73206f6620746869732041677265656d656e7420616e6420616e79204f7264657220466f726d2873292e20436f6e666964656e7469616c20696e666f726d6174696f6e20646f6573206e6f7420696e636c75646520696e666f726d6174696f6e2077686963683a202869292074686520726563697069656e7420646576656c6f70656420696e646570656e64656e746c793b20286969292074686520726563697069656e74206b6e6577206265666f726520726563656976696e672069742066726f6d20746865206f746865722050617274793b206f722028696969292069732c206f722073756273657175656e746c79206265636f6d65732c207075626c69636c7920617661696c61626c652c206f722069732072656365697665642066726f6d20616e6f7468657220736f757263652c20696e20626f7468206361736573206f74686572207468616e206279206120627265616368206f6620616e206f626c69676174696f6e206f6620636f6e666964656e7469616c6974792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e332e323c2f7374726f6e673e266e6273703b3c7374726f6e673e557365206f6620436f6e666964656e7469616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e466f72206120706572696f64206f6620666976652028352920796561727320616674657220696e697469616c20646973636c6f737572652c206e6569746865722050617274792077696c6c2075736520746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20776974686f757420746865206f7468657226727371756f3b73207772697474656e20636f6e73656e742065786365707420696e2066757274686572616e6365206f66207468697320627573696e6573732072656c6174696f6e73686970206f7220617320657870726573736c79207065726d697474656420627920746869732041677265656d656e742e20466f72206120706572696f64206f6620666976652028352920796561727320616674657220696e697469616c20646973636c6f737572652c206e6569746865722050617274792077696c6c20646973636c6f736520746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e206578636570742028692920746f206f627461696e206164766963652066726f6d206c6567616c206f722066696e616e6369616c20636f6e73756c74616e74732c206f72202869692920696620636f6d70656c6c6564206279206c61772c20696e20776869636820636173652074686520506172747920636f6d70656c6c656420746f206d616b652074686520646973636c6f737572652077696c6c20757365206974732062657374206566666f72747320746f206769766520746865206f74686572205061727479206e6f74696365206f662074686520726571756972656d656e7420736f20746861742074686520646973636c6f737572652063616e20626520636f6e7465737465642e20456163682050617274792077696c6c2074616b6520726561736f6e61626c652070726563617574696f6e7320746f2073616665677561726420746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e2e20537563682070726563617574696f6e732077696c6c206265206174206c656173742061732067726561742061732074686f736520656163682070617274792074616b657320746f2070726f7465637420697473206f776e20636f6e666964656e7469616c20696e666f726d6174696f6e2e20456163682050617274792077696c6c20646973636c6f736520746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20746f2069747320656d706c6f796565732c20636f6e73756c74616e74732c206f7220737562636f6e74726163746f7273206f6e6c79206f6e2061206e6565642d746f2d6b6e6f772062617369732c2070726f76696465642074686174207375636820656d706c6f79656573206f7220737562636f6e74726163746f727320617265207375626a65637420746f20636f6e666964656e7469616c697479206f626c69676174696f6e73206e6f206c657373207265737472696374697665207468616e2074686f736520636f6e7461696e65642068657265696e2e205768656e20636f6e666964656e7469616c20696e666f726d6174696f6e206973206e6f206c6f6e676572206e656365737361727920746f20706572666f726d20616e79206f626c69676174696f6e20756e64657220616e79204f7264657220466f726d2873292c20656163682050617274792077696c6c2072657475726e20697420746f20746865206f74686572206f722064657374726f7920697420617420746865206f7468657226727371756f3b7320726571756573742e20456974686572205061727479206d61792070726f766964652073756767657374696f6e732c20636f6d6d656e7473206f72206f7468657220666565646261636b20746f20746865206f746865722050617274792077697468207265737065637420746f20746865206f7468657226727371756f3b732070726f647563747320616e642053657276696365732e20466565646261636b20697320766f6c756e7461727920616e642074686520506172747920726563656976696e6720666565646261636b206d61792075736520697420666f7220616e7920707572706f736520776974686f7574206f626c69676174696f6e206f6620616e79206b696e642065786365707420746861742074686520506172747920726563656976696e6720666565646261636b2077696c6c206e6f7420646973636c6f73652074686520736f75726365206f6620666565646261636b20776974686f75742074686520636f6e73656e74206f66207468652050617274792070726f766964696e672069742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e332e3320436f6f7065726174696f6e20696e20746865204576656e74206f6620446973636c6f737572653c2f7374726f6e673e3c2f703e0d0a0d0a3c703e456163682050617274792077696c6c20696d6d6564696174656c79206e6f7469667920746865206f746865722075706f6e20646973636f76657279206f6620616e7920756e617574686f726973656420757365206f7220646973636c6f73757265206f6620746865206f7468657220506172747926727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20616e642077696c6c20636f6f70657261746520696e20616e7920726561736f6e61626c652077617920746f2068656c7020746865206f746865722072656761696e20706f7373657373696f6e206f662074686520636f6e666964656e7469616c20696e666f726d6174696f6e20616e642070726576656e74206675727468657220756e617574686f726973656420757365206f7220646973636c6f737572652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e332e34204b6e6f776c6564676520426173653c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f41523231206d61792075736520616e7920746563686e6963616c20696e666f726d6174696f6e204f4152323120646572697665732066726f6d2070726f766964696e672053657276696365732072656c6174656420746f204f4152323126727371756f3b732070726f647563747320666f722070726f626c656d207265736f6c7574696f6e2c2074726f75626c6573686f6f74696e672c2070726f647563742066756e6374696f6e616c69747920656e68616e63656d656e747320616e642066697865732c20666f72204f4152323126727371756f3b73206b6e6f776c6564676520626173652e204f4152323120616772656573206e6f7420746f206964656e7469667920746865205061727469636970616e74206f7220646973636c6f736520616e79206f6620746865205061727469636970616e7426727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20696e20616e79206974656d20696e204f4152323126727371756f3b73206b6e6f776c6564676520626173652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e332e35266e6273703b203c2f7374726f6e673e3c7374726f6e673e4368616e67657320746f207468697320507269766163792026616d703b20436f6e666964656e7469616c6974792053746174656d656e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e57652077696c6c206f63636173696f6e616c6c7920757064617465207468697320707269766163792073746174656d656e7420746f207265666c65637420746865205061727469636970616e7420666565646261636b2c206368616e67657320696e206f75722053657276696365732c20616e64207570646174657320746f206170706c696361626c6520646174612070726976616379206c61777320616e6420726567756c6174696f6e732e205768656e20776520706f7374206368616e67657320746f20746869732073746174656d656e742c2077652077696c6c207265766973652074686520266c6471756f3b6c617374207570646174656426726471756f3b20646174652061742074686520746f70206f66207468652073746174656d656e742e20496620746865726520617265206d6174657269616c206368616e67657320746f20746869732073746174656d656e74206f7220696e20686f77204f415232312077696c6c2075736520796f757220696e666f726d6174696f6e2c2077652077696c6c206e6f7469667920796f752062792065697468657220706f7374696e672061206e6f74696365206f662073756368206368616e676573206265666f726520746865792074616b6520656666656374206f7220627920646972656374206e6f74696669636174696f6e2e20576520656e636f757261676520796f7520746f20706572696f646963616c6c7920726576696577207468697320707269766163792073746174656d656e7420746f206c6561726e20686f77204f415232312069732070726f74656374696e6720796f757220696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e34203c2f7374726f6e673e3c7374726f6e673e4675727468657220696e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4675727468657220696e666f726d6174696f6e2061626f757420746865206170706c69636174696f6e206f66207468652050726976616379204163742063616e20626520666f756e64206174207468652077656273697465206f6620746865204f6666696365206f6620746865204175737472616c69616e20496e666f726d6174696f6e20436f6d6d697373696f6e6572206174207777772e707269766163792e676f762e61752e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e342e31203c2f7374726f6e673e3c7374726f6e673e486f772077652068616e646c6520636f6d706c61696e74733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e496620796f75206861766520616e7920636f6e6365726e73206f7220636f6d706c61696e74732061626f757420746865206d616e6e657220696e20776869636820796f757220706572736f6e616c20696e666f726d6174696f6e20686173206265656e20636f6c6c6563746564206f722068616e646c6564206279204f415232312c20706c65617365203c6120687265663d222f636f6e74616374223e636f6e7461637420757320766961206f7572206f6e6c696e6520656e7175697269657320666f726d3c2f613e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e322e322e34205769746864726177616c206f6620636f6e73656e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e596f75206d617920616c736f20776974686472617720796f757220636f6e73656e7420746f2074686520757365206f6620706572736f6e616c20696e666f726d6174696f6e20666f7220616e79207365636f6e6461727920707572706f73657320287768657468657220666f7220796f757273656c66206f7220616e7920646570656e64616e74206167656420756e646572203136207965617273292062792072696e67696e67207573206f6e2028303329203938323720313338382e3c2f703e0d0a0d0a3c703e3c7374726f6e673e332057415252414e544945532c204c494142494c49545920414e4420434f5059524947485420434f4d504c41494e54533c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e332e312057617272616e746965733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e54686520736572766963652069732070726f7669646564206f6e20616e20266c6471756f3b617320697326726471756f3b20616e6420266c6471756f3b617320617661696c61626c6526726471756f3b2062617369732e20557365206f6620746865207365727669636520697320617420796f7572206f776e207269736b2e2054686520736572766963652069732070726f766964656420776974686f75742077617272616e74696573206f6620616e79206b696e642c20776865746865722065787072657373206f7220696d706c6965642c20696e636c7564696e672c20627574206e6f74206c696d6974656420746f2c20696d706c6965642077617272616e74696573206f66206d65726368616e746162696c6974792c206669746e65737320666f72206120706172746963756c617220707572706f73652c206f72206e6f6e2d696e6672696e67656d656e742e20576974686f7574206c696d6974696e672074686520666f7265676f696e672c204f415232312c20697473207375627369646961726965732c20616e6420697473206c6963656e736f727320646f206e6f742077617272616e7420746861742074686520636f6e74656e742069732061636375726174652c2072656c6961626c65206f7220636f72726563743b20746861742074686520736572766963652077696c6c206d65657420796f757220726571756972656d656e74733b20746861742074686520736572766963652077696c6c20626520617661696c61626c6520617420616e7920706172746963756c61722074696d65206f72206c6f636174696f6e2c20756e696e746572727570746564206f72207365637572653b207468617420616e792064656665637473206f72206572726f72732077696c6c20626520636f727265637465643b206f7220746861742074686520536572766963652069732066726565206f662076697275736573206f72206f74686572206861726d66756c20636f6d706f6e656e74732e20416e7920636f6e74656e7420646f776e6c6f61646564206f72206f7468657277697365206f627461696e6564207468726f7567682074686520757365206f6620746865205365727669636520697320646f776e6c6f6164656420617420796f7572206f776e207269736b20616e6420796f752077696c6c20626520736f6c656c7920726573706f6e7369626c6520666f7220616e792064616d61676520746f20796f757220636f6d70757465722073797374656d206f72206c6f7373206f662064617461207468617420726573756c74732066726f6d207375636820646f776e6c6f61642e204f415232312077696c6c206e6f74206265206c6961626c6520666f7220616e792073657276696365287329206f722070726f647563742873292070726f76696465642062792074686972642070617274792076656e646f72732c20646576656c6f70657273206f7220636f6e73756c74616e7473206964656e746966696564206f7220726566657272656420746f20746865205061727469636970616e74206279204f4152323120756e6c65737320737563682074686972642070617274792070726f64756374287329206f722073657276696365287329206172652070726f766964656420756e646572207772697474656e2061677265656d656e74206265747765656e20746865205061727469636970616e7420616e64204f415232312c20616e64207468656e206f6e6c7920746f2074686520657874656e7420657870726573736c792070726f766964656420696e20746869732061677265656d656e742e3c2f703e0d0a0d0a3c703e4f4152323120646f6573206e6f742077617272616e742c20656e646f7273652c2067756172616e7465652c206f7220617373756d6520726573706f6e736962696c69747920666f7220616e792070726f64756374206f7220736572766963652061647665727469736564206f72206f6666657265642062792061207468697264207061727479207468726f75676820746865204f415232312073657276696365206f7220616e792068797065726c696e6b65642077656273697465206f7220736572766963652c206f7220666561747572656420696e20616e792062616e6e6572206f72206f74686572206164766572746973696e672c20616e64204f415232312077696c6c206e6f74206265206120706172747920746f206f7220696e20616e7920776179206d6f6e69746f7220616e79207472616e73616374696f6e206265747765656e20796f7520616e642074686972642d70617274792070726f766964657273206f662070726f6475637473206f722073657276696365732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e332e32204c696d69746174696f6e73204f66204c696162696c697479203c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5265676172646c657373206f66207768657468657220616e792072656d6564792073657420666f7274682068657265696e206661696c73206f662069747320657373656e7469616c20707572706f7365206f72206f74686572776973652c20616e642065786365707420666f7220626f64696c7920696e6a7572792c20696e206e6f206576656e742077696c6c204f41523231206f72206974732076656e646f72732c206265206c6961626c6520746f205061727469636970616e74206f7220746f20616e7920746869726420706172747920756e64657220616e7920746f72742c20636f6e74726163742c206e65676c6967656e63652c20737472696374206c696162696c697479206f72206f74686572206c6567616c206f7220657175697461626c65207468656f727920666f7220616e79206c6f73742070726f666974732c206c6f7374206f7220636f7272757074656420646174612c20636f6d7075746572206661696c757265206f72206d616c66756e6374696f6e2c20696e74657272757074696f6e206f6620627573696e6573732c206f72206f74686572207370656369616c2c20696e6469726563742c20696e636964656e74616c206f7220636f6e73657175656e7469616c2064616d61676573206f6620616e79206b696e642061726973696e67206f7574206f662074686520757365206f7220696e6162696c69747920746f207573652074686520536572766963652c206576656e206966204f4152323120686173206265656e2061647669736564206f662074686520706f73736962696c697479206f662073756368206c6f7373206f722064616d6167657320616e642077686574686572206f72206e6f742073756368206c6f7373206f722064616d616765732061726520666f726573656561626c652e20416e7920636c61696d2061726973696e67206f7574206f66206f722072656c6174696e6720746f20746869732061677265656d656e74206d7573742062652062726f756768742077697468696e206f6e6520283129207965617220616674657220746865206f6363757272656e6365206f6620746865206576656e7420676976696e67207269736520746f207375636820636c61696d2e20496e206164646974696f6e2c204f4152323120646973636c61696d7320616c6c206c696162696c697479206f6620616e79206b696e64206f66204f41523231262333393b732076656e646f72732e3c2f703e0d0a0d0a3c703e5061727469636970616e74206167726565732074686174204f41523231207368616c6c2068617665206e6f206c696162696c6974792077686174736f6576657220666f7220616e7920757365205061727469636970616e74206d616b6573206f662074686520536572766963652e205061727469636970616e74207368616c6c20696e64656d6e69667920616e6420686f6c64206861726d6c657373204f415232312066726f6d20616e7920616e6420616c6c20636c61696d732c2064616d616765732c206c696162696c69746965732c20636f73747320616e6420666565732028696e636c7564696e6720726561736f6e61626c65206174746f726e657973262333393b2066656573292061726973696e672066726f6d205061727469636970616e74262333393b7320757365206f662074686520536572766963652e205468697320696e636c756465732065766572797468696e672072656c6174656420746f20616e79206163746976697479207468617420697320636f6d706c657465642077697468696e207468652073797374656d2077697468206120726570657263757373696f6e20696e207265616c206c6966652e3c2f703e0d0a0d0a3c703e546f20746865206d6178696d756d20657874656e74207065726d6974746564206279206170706c696361626c65206c61772c20696e206e6f206576656e74207368616c6c204f415232312c2069747320616666696c69617465732c206469726563746f72732c20656d706c6f79656573206f7220697473206c6963656e736f7273206265206c6961626c6520666f7220616e79206469726563742c20696e6469726563742c2070756e69746976652c20696e636964656e74616c2c207370656369616c2c20636f6e73657175656e7469616c206f72206578656d706c6172792064616d616765732c20696e636c7564696e6720776974686f7574206c696d69746174696f6e2064616d6167657320666f72206c6f7373206f662070726f666974732c20676f6f6477696c6c2c207573652c2064617461206f72206f7468657220696e74616e6769626c65206c6f737365732c207468617420726573756c742066726f6d2074686520757365206f662c206f7220696e6162696c69747920746f207573652c207468697320736572766963652e20556e646572206e6f2063697263756d7374616e6365732077696c6c204f4152323120626520726573706f6e7369626c6520666f7220616e792064616d6167652c206c6f7373206f7220696e6a75727920726573756c74696e672066726f6d206861636b696e672c2074616d706572696e67206f72206f7468657220756e617574686f726973656420616363657373206f7220757365206f66207468652073657276696365206f7220796f7572206163636f756e74206f722074686520696e666f726d6174696f6e20636f6e7461696e6564207468657265696e2e3c2f703e0d0a0d0a3c703e546f20746865206d6178696d756d20657874656e74207065726d6974746564206279206170706c696361626c65206c61772c204f4152323120617373756d6573206e6f206c696162696c697479206f7220726573706f6e736962696c69747920666f7220616e7920286929206572726f72732c206d697374616b65732c206f7220696e61636375726163696573206f6620636f6e74656e743b202869692920706572736f6e616c20696e6a757279206f722070726f70657274792064616d6167652c206f6620616e79206e61747572652077686174736f657665722c20726573756c74696e672066726f6d20796f75722061636365737320746f20616e6420757365206f66206f757220736572766963653b20286969692920616e7920756e617574686f72697365642061636365737320746f206f7220757365206f66206f757220736563757265207365727665727320616e642f6f7220616e7920616e6420616c6c20706572736f6e616c20696e666f726d6174696f6e2073746f726564207468657265696e3b202869762920616e7920696e74657272757074696f6e206f7220636573736174696f6e206f66207472616e736d697373696f6e20746f206f722066726f6d2074686520736572766963653b2028762920616e7920627567732c20766972757365732c2074726f6a616e20686f727365732c206f7220746865206c696b652074686174206d6179206265207472616e736d697474656420746f206f72207468726f756768206f7572207365727669636520627920616e792074686972642070617274793b202876692920616e79206572726f7273206f72206f6d697373696f6e7320696e20616e7920636f6e74656e74206f7220666f7220616e79206c6f7373206f722064616d61676520696e637572726564206173206120726573756c74206f662074686520757365206f6620616e7920636f6e74656e7420706f737465642c20656d61696c65642c207472616e736d69747465642c206f72206f7468657277697365206d61646520617661696c61626c65207468726f7567682074686520536572766963653b20616e642f6f72202876696929205061727469636970616e7420636f6e74656e74206f722074686520646566616d61746f72792c206f6666656e736976652c206f7220696c6c6567616c20636f6e64756374206f6620616e792074686972642070617274792e20496e206e6f206576656e74207368616c6c204f415232312c2069747320616666696c69617465732c206469726563746f72732c20656d706c6f796565732c206f72206c6963656e736f7273206265206c6961626c6520746f20796f7520666f7220616e7920636c61696d732c2070726f63656564696e67732c206c696162696c69746965732c206f626c69676174696f6e732c2064616d616765732c206c6f73736573206f7220636f73747320696e20616e20616d6f756e7420657863656564696e672074686520616d6f756e7420796f75207061696420746f204f415232312068657265756e6465722e3c2f703e0d0a0d0a3c703e54686973206c696d69746174696f6e206f66206c696162696c6974792073656374696f6e206170706c69657320776865746865722074686520616c6c65676564206c696162696c697479206973206261736564206f6e20636f6e74726163742c20746f72742c206e65676c6967656e63652c20737472696374206c696162696c6974792c206f7220616e79206f746865722062617369732c206576656e206966204f4152323120686173206265656e2061647669736564206f662074686520706f73736962696c697479206f6620737563682064616d6167652e2054686520666f7265676f696e67206c696d69746174696f6e206f66206c696162696c697479207368616c6c206170706c7920746f207468652066756c6c65737420657874656e74207065726d6974746564206279206c617720696e20746865206170706c696361626c65206a7572697364696374696f6e2e204365727461696e20427573696e657373205465726d73206d61792070726f7669646520736c696768746c7920646966666572656e742072696768747320746f207468652070617274696573207468657265746f2c2062757420616e79207375636820427573696e657373205465726d7320646f206e6f74206368616e6765207468652072756c6573206170706c696361626c6520746f205061727469636970616e747320636f76657265642062792074686520666f7265676f696e672e3c2f703e0d0a0d0a3c703e3c7374726f6e673e332e33205465726d20416e64205465726d696e6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e546869732041677265656d656e742077696c6c2072656d61696e20696e206566666563742070726f766964656420746865726520697320612063757272656e7420636f6e747261637420696e20706c616365207769746820796f7572206f7267616e69736174696f6e206f7220796f7572206e6574776f726b2061646d696e6973747261746f7220666f7220536572766963657320756e64657220746869732041677265656d656e742e20546865205061727469657320746f20746869732041677265656d656e7420286578636c7564696e6720616e7920706172747920616666696c6961746529206d6179207465726d696e61746520697420617420616e792074696d6520627920676976696e6720746865206f74686572205061727479206174206c6561737420736978747920283630292063616c656e6461722064617926727371756f3b73207072696f72207772697474656e206e6f746963652e20456974686572205061727479206d6179207465726d696e61746520746869732041677265656d656e7420696620746865206f7468657220506172747920697320696e206d6174657269616c20627265616368206f722064656661756c74206f6620616e79206f626c69676174696f6e2074686174206973206e6f742063757265642077697468696e2074686972747920283330292063616c656e646172206461797326727371756f3b206e6f74696365206f662073756368206272656163682e3c2f703e0d0a0d0a3c703e5465726d696e6174696f6e206f6620746869732041677265656d656e742077696c6c206e6f742c20627920697473656c662c20726573756c7420696e20746865207465726d696e6174696f6e206f6620616e7920636f6e7472616374732070726576696f75736c7920656e746572656420696e746f20286f7220657874656e73696f6e73206f66207468652073616d6529207468617420696e636f72706f7261746520746865207465726d73206f6620746869732041677265656d656e742c20616e6420746865207465726d73206f6620746869732041677265656d656e742077696c6c20636f6e74696e756520696e2065666665637420666f7220707572706f736573206f66207375636820636f6e74726163747320756e6c65737320616e6420756e74696c207468652072656c6576616e7420636f6e747261637420697473656c66206973207465726d696e61746564206f7220657870697265732e3c2f703e0d0a0d0a3c703e546f2074686520657874656e74206e656365737361727920746f20696d706c656d656e7420746865207465726d696e6174696f6e2070726f766973696f6e73206f6620746869732041677265656d656e742c2065616368206f662074686520506172746965732077616976657320616e79207269676874206974206861732c206f72206f626c69676174696f6e207468617420746865206f74686572205061727479206d617920686176652c206e6f77206f7220696e207468652066757475726520756e64657220616e79206170706c696361626c65206c6177206f7220726567756c6174696f6e2c20746f2072657175657374206f72206f627461696e2074686520617070726f76616c2c206f726465722c206465636973696f6e206f72206a7564676d656e74206f6620616e7920636f75727420746f207465726d696e61746520746869732041677265656d656e742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e332e32204c6963656e7365204772616e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5375626a65637420746f20746865207465726d7320616e6420636f6e646974696f6e73206f6620746869732041677265656d656e742c20796f752061726520686572656279206772616e7465642061206e6f6e2d6578636c75736976652c206c696d697465642c20706572736f6e616c206c6963656e736520746f207573652074686520536572766963652e204f4152323120726573657276657320616c6c20726967687473206e6f7420657870726573736c79206772616e7465642068657265696e20696e20746865205365727669636520616e6420746865204f4152323120436f6e74656e742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e332e3320436f7079726967687420436f6d706c61696e74733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312072657370656374732074686520696e74656c6c65637475616c2070726f706572747920726967687473206f66206f74686572732e204974206973206f757220706f6c69637920746f20726573706f6e642070726f6d70746c7920746f20616e7920636c61696d20726567617264696e6720636f6e74656e7420706f73746564206f6e20746865205365727669636520776869636820696e6672696e6765732074686520636f70797269676874206f72206f7468657220696e74656c6c65637475616c2070726f706572747920696e6672696e67656d656e742028266c6471756f3b496e6672696e67656d656e7426726471756f3b29206f6620616e7920706572736f6e2e204f415232312077696c6c2075736520726561736f6e61626c65206566666f72747320746f20696e766573746967617465206e6f7469636573206f6620616c6c6567656420496e6672696e67656d656e7420616e642077696c6c2074616b6520617070726f70726961746520616374696f6e20756e646572206170706c696361626c6520696e74656c6c65637475616c2070726f7065727479206c617720616e64207468657365205465726d732077686572652069742062656c696576657320616e20496e6672696e67656d656e74206861732074616b656e20706c6163652c20696e636c7564696e672072656d6f76696e67206f722064697361626c696e672061636365737320746f2074686520636f6e74656e7420636c61696d656420746f20626520696e6672696e67696e6720616e642f6f72207465726d696e6174696e67206163636f756e747320616e642061636365737320746f2074686520536572766963652e20546f206e6f74696679204f41523231206f66206120706f737369626c6520496e6672696e67656d656e7420796f75206d757374207375626d697420796f7572206e6f7469636520696e2077726974696e6720746f2074686520617474656e74696f6e206f6620266c6471756f3b436f7079726967687420496e6672696e67656d656e7426726471756f3b20766961206f7572203c6120687265663d222f636f6e74616374223e6f6e6c696e6520656e7175697269657320666f726d3c2f613e266e6273703b616e6420696e636c75646520696e20796f7572206e6f7469636520612064657461696c6564206465736372697074696f6e206f662074686520616c6c6567656420496e6672696e67656d656e742073756666696369656e7420746f20656e61626c65204f4152323120746f206d616b65206120726561736f6e61626c652064657465726d696e6174696f6e2e20506c65617365206e6f7465207468617420796f75206d61792062652068656c64206163636f756e7461626c6520666f722064616d616765732028696e636c7564696e6720636f73747320616e64206174746f726e65797326727371756f3b20666565732920666f72206d6973726570726573656e74696e67207468617420616e7920436f6e74656e7420697320696e6672696e67696e6720796f757220636f707972696768742e2049662077652072656d6f7665206f722064697361626c652061636365737320746f20636f6e74656e7420696e20726573706f6e736520746f2061206e6f74696365206f6620496e6672696e67656d656e742c2077652077696c6c206d616b6520726561736f6e61626c6520617474656d70747320746f20636f6e7461637420746865205061727469636970616e742077686f20706f737465642074686520616666656374656420636f6e74656e742e20496620796f75206665656c207468617420796f757220636f6e74656e74206973206e6f7420696e6672696e67696e672c20796f75206d61792070726f76696465204f415232312077697468206120636f756e746572206e6f7469636520696e2077726974696e6720746f2074686520617474656e74696f6e206f6620266c6471756f3b436f7079726967687420496e6672696e67656d656e7420436f756e746572204e6f74696669636174696f6e26726471756f3b20766961206f7572203c6120687265663d222f636f6e74616374223e6f6e6c696e6520636f6e7461637420666f726d3c2f613e2e20596f75206d75737420696e636c75646520696e20796f757220636f756e746572206e6f746963652073756666696369656e7420696e666f726d6174696f6e20746f20656e61626c65204f4152323120746f206d616b65206120726561736f6e61626c652064657465726d696e6174696f6e2e20506c65617365206e6f7465207468617420796f75206d61792062652068656c64206163636f756e7461626c6520666f722064616d616765732028696e636c7564696e6720636f73747320616e64206174746f726e657973262333393b20666565732920696620796f75206d6174657269616c6c79206d6973726570726573656e74207468617420796f757220436f6e74656e74206973206e6f7420696e6672696e67696e672074686520636f7079726967687473206f66206f74686572732e20496620796f752061726520756e6365727461696e207768657468657220616e20616374697669747920636f6e737469747574657320496e6672696e67656d656e742c207765207265636f6d6d656e646564207365656b696e6720616476696365206f6620616e206174746f726e65792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e34204f5552205249474854533c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e342e31204f75722050726f70726965746172792052696768747320616e642054726164656d61726b733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f4152323120616e64206f74686572204f415232312067726170686963732c206c6f676f732c2064657369676e732c207061676520686561646572732c20627574746f6e2069636f6e732c20736372697074732c20616e642073657276696365206e616d65732061726520726567697374657265642074726164656d61726b732c2074726164656d61726b73206f72207472616465206472657373206f66204f415232312e204f4152323126727371756f3b732074726164656d61726b7320616e64207472616465206472657373206d6179206e6f74206265207573656420696e20636f6e6e656374696f6e207769746820616e792070726f64756374206f72207365727669636520776974686f757420746865207072696f72207772697474656e20636f6e73656e74206f66204f415232312e2054686520696d6167657320616e642069636f6e7320617661696c61626c6520696e20746865204f415232312069636f6e207061636b206d6179206265207573656420627920706172746e65727320616e6420746869726420706172747920536572766963657320696e20636f6e6e656374696f6e20776974682070726f766964696e6720617070726f707269617465206c696e6b7320746f20746865204f4152323120536572766963652e3c2f703e0d0a0d0a3c703e45786365707420666f7220796f7572205061727469636970616e7420436f6e74656e742c20746865205365727669636520616e6420697473206d6174657269616c732c20696e636c7564696e672c20776974686f7574206c696d69746174696f6e2c20736f6674776172652c20436f6e74656e742c20696d616765732c20746578742c2067726170686963732c20696c6c757374726174696f6e732c206c6f676f732c20706174656e74732c2074726164656d61726b732c2073657276696365206d61726b732c20636f70797269676874732c2070686f746f6772617068732c20617564696f2c20766964656f7320616e64206d75736963202874686520266c6471756f3b4f4152323120436f6e74656e7426726471756f3b292c20616e6420616c6c20496e74656c6c65637475616c2050726f7065727479205269676874732072656c61746564207468657265746f2c2061726520746865206578636c75736976652070726f7065727479206f66204f4152323120616e6420697473206c6963656e736f72732e20457863657074206173206578706c696369746c792070726f76696465642068657265696e2c206e6f7468696e6720696e20746869732041677265656d656e74207368616c6c206265206465656d656420746f206372656174652061206c6963656e736520696e206f7220756e64657220616e79207375636820496e74656c6c65637475616c2050726f7065727479205269676874732c20616e6420796f75206167726565206e6f7420746f2073656c6c2c206c6963656e73652c2072656e742c206d6f646966792c20646973747269627574652c20636f70792c20726570726f647563652c207472616e736d69742c207075626c69636c7920646973706c61792c207075626c69636c7920706572666f726d2c207075626c6973682c2061646170742c2065646974206f7220637265617465206465726976617469766520776f726b732066726f6d20616e79206d6174657269616c73206f7220636f6e74656e742061636365737369626c65206f6e2074686520536572766963652e20557365206f6620746865204f4152323120436f6e74656e74206f72206d6174657269616c73206f6e20746865205365727669636520666f7220616e7920707572706f7365206e6f7420657870726573736c79207065726d697474656420627920746869732041677265656d656e74206973207374726963746c792070726f686962697465642e3c2f703e0d0a0d0a3c703e596f75206d61792063686f6f736520746f206f72207765206d617920696e7669746520796f7520746f207375626d697420636f6d6d656e7473206f722069646561732061626f75742074686520536572766963652c20696e636c7564696e6720776974686f7574206c696d69746174696f6e2061626f757420686f7720746f20696d70726f7665207468652053657276696365206f72206f75722070726f64756374732028266c6471756f3b496465617326726471756f3b292e204279207375626d697474696e6720616e7920496465612c20796f75206167726565207468617420796f757220646973636c6f7375726520697320677261747569746f75732c20756e736f6c69636974656420616e6420776974686f7574207265737472696374696f6e20616e642077696c6c206e6f7420706c616365204f4152323120756e64657220616e7920666964756369617279206f72206f74686572206f626c69676174696f6e2c207468617420776520617265206672656520746f20646973636c6f736520746865204964656173206f6e2061206e6f6e2d636f6e666964656e7469616c20626173697320746f20616e796f6e65206f72206f7468657277697365207573652074686520496465617320776974686f757420616e79206164646974696f6e616c20636f6d70656e736174696f6e20746f20796f752e20596f752061636b6e6f776c6564676520746861742c20627920616363657074616e6365206f6620796f7572207375626d697373696f6e2c204f4152323120646f6573206e6f7420776169766520616e792072696768747320746f207573652073696d696c6172206f722072656c617465642069646561732070726576696f75736c79206b6e6f776e20746f204f415232312c206f7220646576656c6f7065642062792069747320656d706c6f796565732c206f72206f627461696e65642066726f6d20736f7572636573206f74686572207468616e20796f752e3c2f703e0d0a0d0a3c703e3c7374726f6e673e342e3220496e64656d6e6974793c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5061727469636970616e74206167726565732074686174204f41523231207368616c6c2068617665206e6f206c696162696c6974792077686174736f6576657220666f7220616e7920757365205061727469636970616e74206d616b6573206f662074686520536572766963652e205061727469636970616e74207368616c6c20696e64656d6e69667920616e6420686f6c64206861726d6c657373204f415232312066726f6d20616e7920616e6420616c6c20636c61696d732c2064616d616765732c206c696162696c69746965732c20636f73747320616e6420666565732028696e636c7564696e6720726561736f6e61626c65206174746f726e657973262333393b2066656573292061726973696e672066726f6d205061727469636970616e74262333393b7320757365206f662074686520536572766963652e3c2f703e0d0a0d0a3c703e596f7520616772656520746f20646566656e642c20696e64656d6e69667920616e6420686f6c64206861726d6c657373204f4152323120616e6420697473207375627369646961726965732c206167656e74732c206d616e61676572732c20616e64206f7468657220616666696c696174656420636f6d70616e6965732c20616e6420746865697220656d706c6f796565732c20636f6e74726163746f72732c206167656e74732c206f6666696365727320616e64206469726563746f72732c2066726f6d20616e6420616761696e737420616e7920616e6420616c6c20636c61696d732c2064616d616765732c206f626c69676174696f6e732c206c6f737365732c206c696162696c69746965732c20636f737473206f7220646562742c20616e6420657870656e7365732028696e636c7564696e6720627574206e6f74206c696d6974656420746f206174746f726e657926727371756f3b732066656573292061726973696e672066726f6d3a2028692920796f757220757365206f6620616e642061636365737320746f2074686520536572766963652c20696e636c7564696e6720616e792064617461206f7220776f726b207472616e736d6974746564206f7220726563656976656420627920796f753b202869692920796f75722076696f6c6174696f6e206f6620616e79207465726d206f6620746869732041677265656d656e742c20696e636c7564696e6720776974686f7574206c696d69746174696f6e2c20796f757220627265616368206f6620616e79206f662074686520726570726573656e746174696f6e7320616e642077617272616e746965732061626f76653b20286969692920796f75722076696f6c6174696f6e206f6620616e792074686972642d70617274792072696768742c20696e636c7564696e6720776974686f7574206c696d69746174696f6e20616e79207269676874206f6620707269766163792c207075626c696369747920726967687473206f7220496e74656c6c65637475616c2050726f7065727479205269676874733b202869762920796f75722076696f6c6174696f6e206f6620616e79206c61772c2072756c65206f7220726567756c6174696f6e206f662074686520556e6974656420537461746573206f7220616e79206f7468657220636f756e7472793b2028762920616e7920636c61696d206f722064616d616765732074686174206172697365206173206120726573756c74206f6620616e79206f6620796f7572205061727469636970616e7420436f6e74656e74206f7220616e79207468617420617265207375626d69747465642076696120796f7572206163636f756e743b206f72202876692920616e79206f7468657220706172747926727371756f3b732061636365737320616e6420757365206f66207468652053657276696365207769746820796f757220756e6971756520757365726e616d652c2070617373776f7264206f72206f7468657220617070726f70726961746520736563757269747920636f64652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e35204d495343454c4c414e454f55533c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e352e3120526967687420746f20537562636f6e747261637420616e642041737369676e6d656e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4e656974686572205061727479206d61792061737369676e20746869732041677265656d656e74206f7220616e79204f7264657220466f726d28732920776974686f757420746865207772697474656e20636f6e73656e74206f6620746865206f746865722e204f41523231206d61792075736520636f6e74726163746f727320746f20706572666f726d20536572766963657320616e64204f415232312077696c6c20626520726573706f6e7369626c6520666f7220746865697220706572666f726d616e6365207375626a65637420746f20746865207465726d73206f6620746869732041677265656d656e742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e352e32204170706c696361626c65204c617720616e64204a7572697364696374696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e546869732041677265656d656e7420746f676574686572207769746820746865206170706c696361626c65204f7264657220466f726d2873292077696c6c20626520676f7665726e656420627920746865206c617773206f6620746865207374617465206f6620566963746f72696120696e204175737472616c69612e20546865203139383020556e69746564204e6174696f6e7320436f6e76656e74696f6e206f6e20436f6e74726163747320666f722074686520496e7465726e6174696f6e616c2053616c65206f6620476f6f647320616e64206974732072656c6174656420696e737472756d656e74732077696c6c206e6f74206170706c7920746f20746869732041677265656d656e742e3c2f703e0d0a0d0a3c703e546865205365727669636520697320636f6e74726f6c6c656420616e64206f706572617465642066726f6d2069747320666163696c697469657320696e204175737472616c69612e204f41523231206d616b6573206e6f20726570726573656e746174696f6e73207468617420746865205365727669636520697320617070726f707269617465206f7220617661696c61626c6520666f722075736520696e206f74686572206c6f636174696f6e732e2054686f73652077686f20616363657373206f72207573652074686520536572766963652066726f6d206f74686572206a7572697364696374696f6e7320646f20736f206174207468656972206f776e20766f6c6974696f6e20616e642061726520656e746972656c7920726573706f6e7369626c6520666f7220636f6d706c69616e63652077697468206c6f63616c206c61772c20696e636c7564696e6720627574206e6f74206c696d6974656420746f206578706f727420616e6420696d706f727420726567756c6174696f6e732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e352e3420456e746972652041677265656d656e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e546869732041677265656d656e7420636f6e7374697475746520746865205061727469657326727371756f3b20656e746972652041677265656d656e7420636f6e6365726e696e672074686520536572766963652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e352e3520537572766976616c3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5468652073656374696f6e7320726567617264696e67206f776e65727368697020616e64206c6963656e73652c207265737472696374696f6e73206f6e207573652c20666565732c20636f6e666964656e7469616c6974792c2077617272616e746965732c206c696d69746174696f6e73206f66206c696162696c6974792c207465726d20616e64207465726d696e6174696f6e2c206e6f74696365732c20616e64206d697363656c6c616e656f7573206f6620746869732041677265656d656e742077696c6c207375727669766520616e79207465726d696e6174696f6e206f722065787069726174696f6e206f6620746869732041677265656d656e74206f7220616e79204f7264657220466f726d2873292e204164646974696f6e616c6c7920696620746869732041677265656d656e74206973207465726d696e617465642c20616c6c20697473207465726d73207368616c6c2073757276697665207465726d696e6174696f6e20666f7220707572706f736573206f6620616e792072656d61696e696e67204f7264657220466f726d28732920696e206578697374656e6365206174207468652074696d6520746869732041677265656d656e74206973207465726d696e617465642e3c2f703e0d0a0d0a3c703e3c7374726f6e673e352e362053657665726162696c6974793c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4966206120636f75727420686f6c647320616e792070726f766973696f6e206f6620746869732041677265656d656e7420746f20626520696c6c6567616c2c20696e76616c6964206f7220756e656e666f72636561626c652c207468652072656d61696e696e672070726f766973696f6e732077696c6c2072656d61696e20696e2066756c6c20666f72636520616e642065666665637420616e642074686520506172746965732077696c6c20616d656e64207468652041677265656d656e7420746f20676976652065666665637420746f207468652073747269636b656e20636c6175736520746f20746865206d6178696d756d20657874656e7420706f737369626c652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e352e37205761697665723c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4e6f20776169766572206f6620616e7920627265616368206f6620746869732041677265656d656e742077696c6c206265206120776169766572206f6620616e79206f74686572206272656163682c20616e64206e6f207761697665722077696c6c2062652065666665637469766520756e6c657373206d61646520696e2077726974696e6720616e64207369676e656420627920616e20617574686f726973656420726570726573656e746174697665206f66207468652077616976696e672050617274792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e352e3820466f726365204d616a657572653c2f7374726f6e673e3c2f703e0d0a0d0a3c703e546f2074686520657874656e7420746861742065697468657220506172747926727371756f3b7320706572666f726d616e63652069732070726576656e746564206f722064656c617965642c2065697468657220746f74616c6c79206f7220696e20706172742c20666f7220726561736f6e73206265796f6e64207468617420506172747926727371756f3b7320636f6e74726f6c2c207468656e20746861742050617274792077696c6c206e6f74206265206c6961626c652c20736f206c6f6e6720617320697420726573756d657320706572666f726d616e636520617320736f6f6e206173207072616374696361626c652061667465722074686520726561736f6e2070726576656e74696e67206f722064656c6179696e6720706572666f726d616e6365206e6f206c6f6e676572206578697374732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e3620434f4e544143543c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312077656c636f6d657320796f757220636f6d6d656e74732e20496620796f752068617665207175657374696f6e732061626f7574204f4152323126727371756f3b73207072697661637920616e6420736563757269747920636f6d6d69746d656e74732c206f7220696620796f752068617665206f7468657220746563686e6963616c206f72206f7468657220637573746f6d657220737570706f7274207175657374696f6e732c20706c6561736520636f6e74616374207573207573696e6720746865206f6e6c696e6520666f726d266e6273703b3c6120687265663d222f636f6e74616374223e686572653c2f613e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e6f723a3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e3c7374726f6e673e4f6e204120526f6c6c20323120507479204c74643c2f7374726f6e673e3c6272202f3e0d0a5375697465203130322c20392d313120436c6172656d6f6e74205374726565743c6272202f3e0d0a536f7574682059617272612056494320333134313c6272202f3e0d0a4175737472616c69613c2f703e0d0a0d0a3c703e506c65617365203c6120687265663d222f636f6e74616374223e636f6e746163742075733c2f613e266e6273703b7769746820616e79207175657374696f6e7320726567617264696e6720746869732041677265656d656e742e3c2f703e0d0a, '2014-02-06 15:02:54', '2014-03-04 00:50:54');
INSERT INTO `site_settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(6, 'privacy', 0x3c703e3c7374726f6e673e5468697320507269766163792053746174656d656e7420616c736f20666f726d732070617274206f6620746865203c6120687265663d222f706167652f746f73223e5465726d73206f6620536572766963653c2f613e20616e64205061727469636970616e742041677265656d656e7420666f72266e6273703b4f6e204120526f6c6c20323120507479204c74643c2f7374726f6e673e266e6273703b284f41523231292e3c2f703e0d0a0d0a3c703e4f4152323120726573706563747320616e642077696c6c2074616b6520616c6c20726561736f6e61626c65206d6561737572657320746f2070726f7465637420796f75722070726976616379207768656e20796f7520757365206f757220736572766963657320616e6420696e7465726163742077697468206f757220636f6d70616e792e2057652077616e7420796f7520746f206665656c20736563757265207768656e20796f7520696e74657261637420776974682075732e3c2f703e0d0a0d0a3c703e5468697320507269766163792053746174656d656e74206170706c69657320746f20746865205365727669636573206d656e74696f6e656420616e6420746f20616c6c20627573696e6573732061637469766974696573206f66204f4152323120616e642069747320616666696c696174657320746f2074686520657874656e742074686174207468657920616666656374206f7220696e766f6c76652074686520636f6c6c656374696f6e2c207573652c20646973636c6f73757265206f722068616e646c696e67206f6620706572736f6e616c20696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e4f4152323120726573706563747320616e6420636f6d706c69657320776974682074686520726571756972656d656e7473206f6620746865205072697661637920416374203139383820616e6420746865204e6174696f6e616c2050726976616379205072696e6369706c657320636f6e7461696e656420696e20746861742041637420696e20616c6c206f66206f757220616374697669746965732e20546865736520696e636c7564652077697468207265737065637420746f2074686520636f6c6c656374696f6e2c207573652c20646973636c6f7375726520616e642068616e646c696e67206f6620706572736f6e616c20696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e496e207468697320507269766163792053746174656d656e742c20706572736f6e616c20696e666f726d6174696f6e206d65616e7320696e666f726d6174696f6e206f7220616e206f70696e696f6e2028696e636c7564696e6720696e666f726d6174696f6e206f7220616e206f70696e696f6e20666f726d696e672070617274206f662061206461746162617365292c20776865746865722074727565206f72206e6f742c20616e642077686574686572207265636f7264656420696e2061206d6174657269616c20666f726d206f72206e6f742c2061626f757420616e20696e646976696475616c2077686f7365206964656e74697479206973206170706172656e742c206f722063616e20726561736f6e61626c792062652061736365727461696e65642c2066726f6d2074686520696e666f726d6174696f6e206f72206f70696e696f6e2028736f757263653a2050726976616379204163742031393838292e3c2f703e0d0a0d0a3c703e3c753e3c7374726f6e673e506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f753e266e6273703b266e6273703b266e6273703b266e6273703b266e6273703b266e6273703b266e6273703b3c2f703e0d0a0d0a3c703e3c7374726f6e673e436f6c6c656374696f6e204f6620506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3a3c2f703e0d0a0d0a3c703e57652077696c6c206f6e6c7920636f6c6c65637420706572736f6e616c20696e666f726d6174696f6e2061626f757420796f75206279206c617766756c20616e642066616972206d65616e7320616e64206e6f7420696e20616e20756e726561736f6e61626c7920696e74727573697665206d616e6e65722e20546865207479706573206f6620706572736f6e616c20696e666f726d6174696f6e207765206d617920636f6c6c65637420696e636c7564653a206964656e74696679696e6720616e6420636f6e7461637420696e666f726d6174696f6e2c2073756368206173206e616d652c206167652c20656d706c6f796d656e742064657461696c732c20656d61696c206164647265737320616e64206d6f62696c652070686f6e65206e756d6265723b2066696e616e6369616c20696e666f726d6174696f6e2c20737563682061732062616e6b206163636f756e742064657461696c733b2073656e73697469766520696e666f726d6174696f6e2c20696e636c7564696e6720696e666f726d6174696f6e2061626f7574206865616c746820616e642077656c6c6265696e672070726f6475637469766974792070726f766964656420746f20796f753b20616e6420696e666f726d6174696f6e2061626f757420796f757220616374697669746965732c20696e636c7564696e672073706f7274696e6720616e64206f74686572206c6966657374796c6520696e746572657374732e3c2f703e0d0a0d0a3c703e576520636f6c6c65637420796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e20746f2070726f7669646520796f7520776974682070726f647563747320616e642073657276696365732c20696e636c7564696e67206865616c74682072656c617465642073657276696365732c20696e666f726d6174696f6e206f6e206f746865722070726f647563747320616e64207365727669636573206f6666657265642062792075732c206f6e65206f66206f757220737562736964696172696573206f7220612074686972642070617274792c20616e6420746f20666163696c697461746520616e6420617373657373207468652070726f766973696f6e206f66206865616c74682072656c6174656420736572766963657320746f20796f752062792075732c206f75722073756273696469617269657320616e6420746869726420706172746965732e3c2f703e0d0a0d0a3c703e5765206d617920636f6c6c65637420796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e2066726f6d20796f752c206f722066726f6d206120706572736f6e20617574686f726973656420746f2070726f76696465207573207468697320696e666f726d6174696f6e206f6e20796f757220626568616c662e3c2f703e0d0a0d0a3c703e3c7374726f6e673e557365204f6620506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312077696c6c206e6f742075736520706572736f6e616c20696e666f726d6174696f6e20636f6e6365726e696e6720616e20696e646976696475616c20666f72206120707572706f7365206f74686572207468616e20746865207072696d61727920707572706f736520666f722077686963682069742077617320636f6c6c65637465642c20756e6c657373204f41523231206f7220697473205061727469636970616e7420686173206f627461696e656420796f757220636f6e73656e7420746f2074686520757365206f66207468617420696e666f726d6174696f6e20666f722061207365636f6e64617279207573652c207375636820617320646972656374206d61726b6574696e672e20416e7920706572736f6e616c20696e666f726d6174696f6e20636f6c6c656374656420616e642f6f722073746f72656420666f72206f6e65205061727469636970616e74206973206e65766572207573656420666f72206f7220646973636c6f73656420746f20616e6f74686572205061727469636970616e74206f7220746f20616e79206f746865722074686972642070617274792c20616e642077652077696c6c206e6f74206964656e7469667920796f7520696e20616e792077617920746f20616e7920746869726420706172747920657863657074206173207265717569726564206279206c61772e3c2f703e0d0a0d0a3c703e57652077696c6c2075736520796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e20666f722074686520707572706f73657320666f7220776869636820776520636f6c6c656374206974206173206465736372696265642061626f76652c20696e636c7564696e6720746f3a206d616e616765206f7572206f6e676f696e672072656c6174696f6e73686970207769746820796f753b2061646d696e69737465722c2070726f6365737320616e6420617564697420636c61696d733b206d616e6167652c207265766965772c20646576656c6f7020616e6420696d70726f7665206f75722070726f647563747320616e642072656c6174656420736572766963657320776865746865722070726f7669646564206279207573206f72206f746865722070617274696573206f6e206f757220626568616c663b206d616e6167652c207265766965772c20646576656c6f7020616e6420696d70726f7665206f757220627573696e65737320616e64206f7065726174696f6e616c2070726f63657373657320616e642073797374656d732c20696e636c7564696e67207468652073657276696365732070726f766964656420746f20796f75206279206f757220636f6e7472616374656420736572766963652070726f766964657273202873756368206173206f7572207375627369646961726965732920616e64206f7468657220706172746965733b207265736f6c766520616e79206c6567616c20616e642f6f7220636f6d6d65726369616c20636f6d706c61696e7473206f72206973737565733b20616e6420706572666f726d20616e79206f66206f7572206f746865722066756e6374696f6e7320616e6420616374697669746965732072656c6174696e6720746f206f757220627573696e6573732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e446973636c6f73696e6720506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e496e206f7264657220746f206361727279206f7574207468652061626f766520707572706f7365732c204f41523231206d617920646973636c6f736520796f757220706572736f6e616c2028696e636c7564696e672073656e7369746976652920696e666f726d6174696f6e20746f20706572736f6e73206f72206f7267616e69736174696f6e7320287768696368206d6179206265206c6f6361746564206f766572736561732920737563682061733a206f7572207375627369646961726965733b206f7572206167656e747320616e6420736572766963652070726f7669646572733b206f75722070726f66657373696f6e616c2061647669736f72733b207061727469657320696e766f6c76656420696e20612070726f7370656374697665206f722061637475616c207472616e73666572206f6620616e79207061727473206f66206f757220617373657473206f7220627573696e6573733b207061796d656e742073797374656d206f70657261746f727320616e642066696e616e6369616c20696e737469747574696f6e733b20706572736f6e7320617574686f7269736564206279206f7220726573706f6e7369626c6520666f7220796f752c20696e636c7564696e6720796f7572206167656e747320616e642061647669736f72733b20676f7665726e6d656e74206167656e636965733b20616e64206f74686572207061727469657320746f2077686f6d2077652061726520617574686f7269736564206f72207265717569726564206279206c617720746f20646973636c6f736520696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e57652077696c6c2068616e646c6520616c6c20706572736f6e616c2028696e636c7564696e672073656e73697469766520696e666f726d6174696f6e2920776520636f6c6c6563742066726f6d20746869726420706172746965732061626f757420796f7520666f722074686520707572706f7365732064657363726962656420696e2074686973205072697661637920506f6c6963792e204f75722072616e6765206f662070726f647563747320616e6420736572766963657320616e64206f75722066756e6374696f6e7320616e6420616374697669746965732c2061732077656c6c2061732074686f7365206f66206f757220636f6e7472616374656420736572766963652070726f7669646572732c206d6179206368616e67652066726f6d2074696d6520746f2074696d652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e5365637572697479206f6620506572736f6e616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e546f2074686520657874656e74207265717569726564206279207468652050726976616379204163742c204f415232312077696c6c2074616b6520726561736f6e61626c6520737465707320746f3a206d616b65207375726520746861742074686520706572736f6e616c20696e666f726d6174696f6e207468617420776520636f6c6c6563742c2075736520616e6420646973636c6f73652069732061636375726174652c20636f6d706c65746520616e6420757020746f20646174653b2070726f746563742074686520706572736f6e616c20696e666f726d6174696f6e207468617420776520686f6c642066726f6d206d697375736520616e64206c6f737320616e642066726f6d20756e617574686f7269736564206163636573732c206d6f64696669636174696f6e206f7220646973636c6f737572653b20616e64207768657265207065726d6974746564206279206c61772c2064657374726f79206f72207065726d616e656e746c792064652d6964656e7469667920706572736f6e616c20696e666f726d6174696f6e2074686174206973206e6f206c6f6e676572206e656564656420666f7220616e7920707572706f73652074686174206973207065726d6974746564206279207468652050726976616379204163742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e53656e73697469766520506572736f6e616c20446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e53656e73697469766520706572736f6e616c206461746120696e636c7564657320706572736f6e616c2064617461207472656174656420627920612072616e6765206f662068756d616e207269676874732062617365642070726976616379206c61777320617320726571756972696e67207370656369616c2074726561746d656e742c20696e636c7564696e6720696e20736f6d652063697263756d7374616e63657320746865206e65656420746f206f627461696e206578706c6963697420636f6e73656e742e2054686573652063617465676f7269657320636f6d707269736520706572736f6e616c206964656e74697479206e756d626572732c20706572736f6e616c20646174612061626f757420706572736f6e616c69747920616e642070726976617465206c6966652c2072616369616c206f72206574686e6963206f726967696e2c206e6174696f6e616c6974792c20706f6c69746963616c206f70696e696f6e732c206d656d62657273686970206f6620706f6c69746963616c2070617274696573206f72206d6f76656d656e74732c2072656c6967696f75732c207068696c6f736f70686963616c206f72206f746865722073696d696c61722062656c696566732c206d656d62657273686970206f66206120747261646520756e696f6e206f722070726f66657373696f6e206f72207472616465206173736f63696174696f6e2c20706879736963616c206f72206d656e74616c206865616c74682c2067656e6574696320636f64652c20616464696374696f6e732c2073657875616c206c6966652c2070726f7065727479206d617474657273206f72206372696d696e616c207265636f72642028696e636c7564696e6720696e666f726d6174696f6e2061626f757420737573706563746564206372696d696e616c2061637469766974696573292e3c2f703e0d0a0d0a3c703e42792070726f766964696e67207573207769746820756e736f6c6963697465642073656e73697469766520706572736f6e616c20696e666f726d6174696f6e2c20796f7520636f6e73656e7420746f206f7572207573696e67207468652064617461207375626a65637420746f206170706c696361626c65206c61772061732064657363726962656420696e207468697320507269766163792053746174656d656e742e2053686f756c64207765206265207365656b696e6720746f20636f6c6c65637420706572736f6e616c2073656e736974697665206461746120666f722074686520707572706f736573206f6620726573656172636820616e642f6f7220737572766579732c2077652077696c6c206e6f74206964656e7469667920796f7520696e2072656c6174696f6e20746f20616e79207468697264207061727469657320657863657074206173207265717569726564206279206c617720616e642077696c6c20646f20616c6c207468696e677320726561736f6e61626c6520746f2070726f7465637420796f757220707269766163792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e537562636f6e74726163746f72733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312072657175697265732073747269637420636f6d706c69616e6365207769746820746865204e6174696f6e616c2050726976616379205072696e6369706c657320627920616c6c206f662069747320737562636f6e74726163746f72732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e416363657373696e6720596f757220496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e596f752068617665206120726967687420746f206b6e6f77207768657468657220776520686176652072657461696e656420616e7920706572736f6e616c20696e666f726d6174696f6e2061626f757420796f7520616e642c20696620776520646f2c20746f2061636365737320796f757220706572736f6e616c20696e666f726d6174696f6e2e20596f752063616e20646f20736f20627920656d61696c696e672075732076696120746865203c6120687265663d222f636f6e74616374223e6f6e6c696e6520666f726d3c2f613e2e204f415232312072657365727665732069747320726967687420746f2063686172676520612066656520666f7220616e7920706172746963756c61722074696d6520636f6e73756d696e67206f72206f6e65726f75732072657175657374732c20686f77657665722073686f756c642073756368206120666565206170706c79207468656e2077652077696c6c2061647669736520796f75206f662074686973206265666f726520796f7520696e63757220616e7920636861726765732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e416e6f6e796d6974793c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f415232312077696c6c2067656e6572616c6c792070726f7669646520696e646976696475616c73207769746820746865206f7074696f6e206f66206e6f74206964656e74696679696e67207468656d73656c766573207768656e20656e746572696e67207472616e73616374696f6e73207768656e206974206973206c617766756c20616e64207072616374696361626c6520746f20646f20736f2e20486f77657665722c206f6e206d616e79206f63636173696f6e732077652077696c6c206e6f742062652061626c6520746f20646f20746869732e20466f72206578616d706c652c2077652077696c6c206e65656420796f7572206e616d6520616e64206164647265737320696e206f7264657220746f2070726f7669646520796f75207769746820616e206163636f756e742e3c2f703e0d0a0d0a3c703e4f415232312077696c6c206e6f742075736520436f6d6d6f6e7765616c746820676f7665726e6d656e74206964656e7469666965727320617320697473206f776e206964656e746966696572206f6620696e646976696475616c732e2057652077696c6c206f6e6c7920757365206f7220646973636c6f73652073756368206964656e7469666965727320696e207468652063697263756d7374616e636573207065726d6974746564206279207468652050726976616379204163742e3c2f703e0d0a0d0a3c703e4966204f41523231207472616e736665727320796f757220706572736f6e616c20696e666f726d6174696f6e206f757473696465204175737472616c69612c2077652077696c6c20636f6d706c7920776974682074686520726571756972656d656e7473206f662074686520507269766163792041637420746861742072656c61746520746f207472616e732d626f72646572206461746120666c6f77732e3c2f703e0d0a0d0a3c703e3c753e3c7374726f6e673e496e7465726e616c205061727469636970616e7420557361676520446174613c2f7374726f6e673e3c2f753e3c2f703e0d0a0d0a3c703e3c7374726f6e673e5061727469636970616e7420446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e536f6d65206172656173206f66207468652053657276696365206d617920616c6c6f77205061727469636970616e747320746f20706f737420666565646261636b2c20636f6d6d656e74732c207175657374696f6e732c20646174612c20616e64206f7468657220696e666f726d6174696f6e2028266c6471756f3b5061727469636970616e7420436f6e74656e7426726471756f3b292e20596f752061726520736f6c656c7920726573706f6e7369626c6520666f7220796f7572205061727469636970616e7420436f6e74656e74207468617420796f752075706c6f61642c207075626c6973682c20646973706c61792c206c696e6b20746f206f72206f7468657277697365206d616b6520617661696c61626c65202868657265696e61667465722c20266c6471756f3b706f737426726471756f3b29206f6e2074686520536572766963652c20616e6420796f75206167726565207468617420776520617265206f6e6c7920616374696e672061732061207061737369766520636f6e6475697420666f7220796f7572206f6e6c696e6520646973747269627574696f6e20616e64207075626c69636174696f6e206f6620796f7572205061727469636970616e7420436f6e74656e742e204f415232312077696c6c206e6f74207265766965772c2073686172652c20646973747269627574652c206f72207265666572656e636520616e792073756368205061727469636970616e7420436f6e74656e74206578636570742061732070726f76696465642068657265696e206f7220696e206f7572205072697661637920506f6c696379206f72206173206d6179206265207265717569726564206279206c61772e20416273656e742061204e6574776f726b2041646d696e6973747261746f722c20616c6c2073756368205061727469636970616e7420436f6e74656e74206973206f776e656420627920746865205061727469636970616e742077686f20706f7374656420697420746f2074686520536572766963652c20616c74686f7567682065616368205061727469636970616e742061636b6e6f776c656467657320616e6420636f6e73656e747320746861742075706f6e2074686520696e74726f64756374696f6e206f662061204e6574776f726b2041646d696e6973747261746f7220696e746f2074686174205061727469636970616e7426727371756f3b73206e6574776f726b2c20616c6c2072656c61746564205061727469636970616e7420436f6e74656e742077696c6c206175746f6d61746963616c6c79206265636f6d65207468652070726f7065727479206f662074686520636f6d70616e7920746f20776869636820746865204e6574776f726b2062656c6f6e677320776974686f757420616e79206e6f7469636520746f205061727469636970616e7473206f662074686174204e6574776f726b2e2049662061204e6574776f726b206861732061204e6574776f726b2041646d696e6973747261746f722c20616c6c2073756368205061727469636970616e7420436f6e74656e74206973207468652070726f7065727479206f662074686520636f6d70616e7920746f20776869636820746865204e6574776f726b2062656c6f6e67732028696e636c7564696e6720616c6c205061727469636970616e7420436f6e74656e7420706f7374656420746f20612073706563696669632047726f7570206f722047726f7570732077697468696e2061204e6574776f726b20616e6420616c6c205061727469636970616e7420436f6e74656e742063726561746564207072696f7220746f20746865206578697374656e6365206f6620746865204e6574776f726b2041646d696e6973747261746f72292e20496e2065697468657220636173652c204f4152323120646f6573206e6f7420686176652c206e6f7220646f657320697420636c61696d2c20616e79206f776e6572736869702072696768747320696e20616e79205061727469636970616e7420436f6e74656e742e20496e206164646974696f6e2c20796f752073686f756c64206e6f7465207468617420696620796f7520617265206e6f206c6f6e67657220616e20656c696769626c65206d656d626572206f6620612067726f75702028652e672e2c20796f7520636561736520746f20626520656d706c6f796564206279207468652072656c6576616e7420636f6d70616e792074686174206861732073706f6e736f72656420796f7520746f20706172746963697061746520696e20616e204f415232312070726f6772616d292c20796f75722061636365737320746f20616c6c205061727469636970616e7420436f6e74656e7420796f752075706c6f61646564206d6179206265207465726d696e617465642c207265676172646c657373206f66207768657468657220746865206e6574776f726b206861732061204e6574776f726b2041646d696e6973747261746f722e204f6e63652061205061727469636970616e742069732072656d6f7665642066726f6d2061204e6574776f726b2c2074686520636f6e74656e74206f662074686174205061727469636970616e742072656d61696e73206f6e20746865204e6574776f726b20616e642069732074686520736f6c652070726f7065727479206f662074686520636f6d70616e792077686963682061646d696e6973746572732074686174204e6574776f726b2e3c2f703e0d0a0d0a3c703e546865205061727469636970616e74204461746120697320616c6c2074686520646174612c20696e636c7564696e6720616c6c20746578742c20736f756e642c20736f667477617265206f7220696d6167652066696c6573207468617420796f752070726f766964652c206f72206172652070726f7669646564206f6e20796f757220626568616c662c20746f207573207468726f75676820796f757220757365206f66207468652053657276696365732e205765206d616b65206e6f20636c61696d206f66206f776e65727368697020696e20796f757220746865205061727469636970616e7420446174612e204578636570742061732070726f766964656420696e207468697320707269766163792073746174656d656e74206f722064657363726962656420696e20796f75722061677265656d656e74732c207765206f6e6c792075736520746865205061727469636970616e74204461746120746f2070726f7669646520616e6420656e68616e6365207468652053657276696365732e20576520646f6e26727371756f3b7420736861726520796f7572205061727469636970616e74204461746120776974682061647665727469736572732c206f72207769746820616e79626f647920656c73652065786365707420696e207468652076657279206c696d697465642063697263756d7374616e636573206465736372696265642061626f76652e3c2f703e0d0a0d0a3c703e4279207574696c6973696e672074686520536572766963652c20796f7520616772656520746f20686176652074686520646f6d61696e20706f7274696f6e206f6620796f757220656d61696c20616464726573732028266c6471756f3b40796f7572636f72702e636f6d26726471756f3b2920616e642f6f722074686520636f6d70616e792c207363686f6f6c2c206f72206f7267616e69736174696f6e206e616d6520726570726573656e746564206279207375636820646f6d61696e20706f7274696f6e206f6620796f757220656d61696c20616464726573732c206c6973746564206f6e20746865204f41523231205365727669636520696e206120636f6d70616e79206469726563746f7279206c697374696e672028266c6471756f3b4469726563746f727926726471756f3b292e2054686520437573746f6d6572732028617320646566696e65642062656c6f77292077686f20646f206e6f742077616e7420746f20626520696e636c7564656420696e2073756368207075626c6973686564204469726563746f7279206d61792073656e642061207772697474656e207265717565737420766961266e6273703b3c6120687265663d22687474703a2f2f6f6e61726f6c6c32312e636f6d2f636f6e7461637422207374796c653d22626f782d73697a696e673a20626f726465722d626f783b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b20636f6c6f723a2072676228302c203134302c20313836293b20746578742d6465636f726174696f6e3a206e6f6e653b206261636b67726f756e642d706f736974696f6e3a20696e697469616c20696e697469616c3b206261636b67726f756e642d7265706561743a20696e697469616c20696e697469616c3b22207469746c653d22223e6f7572206f6e6c696e6520666f726d3c2f613e266e6273703b746f2072656d6f766520746865697220636f6d70616e792c207363686f6f6c2c206f72206f7267616e69736174696f6e206e616d652066726f6d20746865204469726563746f72792e204365727461696e20436f72706f72617465204e6574776f726b732068617665206e65676f7469617465642066757274686572206d6f64696669636174696f6e7320746f20776861742077652077696c6c2070757420696e746f20746865204469726563746f72792e3c2f703e0d0a0d0a3c703e4f415232312074616b6573206e6f20726573706f6e736962696c69747920616e6420617373756d6573206e6f206c696162696c69747920666f7220616e79205061727469636970616e7420436f6e74656e74207468617420796f75206f7220616e79206f74686572205061727469636970616e7473206f72207468697264207061727469657320706f7374206f722073656e64206f7665722074686520536572766963652e20596f7520756e6465727374616e6420616e64206167726565207468617420616e79206c6f7373206f722064616d616765206f6620616e79206b696e642074686174206f6363757273206173206120726573756c74206f662074686520757365206f6620616e79205061727469636970616e7420436f6e74656e74207468617420796f752073656e642c2075706c6f61642c20646f776e6c6f61642c2073747265616d2c20706f73742c207472616e736d69742c20646973706c61792c206f72206f7468657277697365206d616b6520617661696c61626c65206f7220616363657373207468726f75676820796f757220757365206f662074686520536572766963652c20697320736f6c656c7920796f757220726573706f6e736962696c6974792e204f41523231206973206e6f7420726573706f6e7369626c6520666f7220616e79207075626c696320646973706c6179206f72206d6973757365206f6620796f7572205061727469636970616e7420436f6e74656e742e20596f7520756e6465727374616e6420616e642061636b6e6f776c65646765207468617420796f75206d6179206265206578706f73656420746f205061727469636970616e7420436f6e74656e74207468617420697320696e61636375726174652c206f6666656e736976652c20696e646563656e742c206f72206f626a656374696f6e61626c652c20616e6420796f752061677265652074686174204f41523231207368616c6c206e6f74206265206c6961626c6520666f7220616e792064616d6167657320796f7520616c6c65676520746f20696e637572206173206120726573756c74206f662073756368205061727469636970616e7420436f6e74656e742e3c2f703e0d0a0d0a3c703e596f752061726520736f6c656c7920726573706f6e7369626c6520666f7220796f757220696e746572616374696f6e732077697468206f74686572205061727469636970616e74732e2057652072657365727665207468652072696768742c206275742068617665206e6f206f626c69676174696f6e2c20746f206d6f6e69746f72206469737075746573206265747765656e20796f7520616e64206f74686572205061727469636970616e74732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e436f6e7461637420446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e436f6e74616374204461746120696e636c75646573206e616d652c20616464726573732c2070686f6e65206e756d6265722c2070726f66696c6520696e666f726d6174696f6e2c20656d61696c20616464726573732c207469746c652c2074696d65207a6f6e6520616e64206f7468657220636f6e7461637420696e666f726d6174696f6e2074686174207765206d617920636f6c6c656374207468726f75676820796f75722061646d696e697374726174696f6e206f662074686520536572766963657320616e6420757365206f662074686520536572766963657320627920796f7520616e64206f74686572732e20436f6e74616374204461746120796f752070726f766964652061732070617274206f6620796f7572204f415232312070726f66696c6520697320617661696c61626c6520746f206f74686572205061727469636970616e7473206f6620796f7572204e6574776f726b2873292e3c2f703e0d0a0d0a3c703e4f4152323120776f726b7320626574746572207768656e206d6f72652070656f706c652074616b65207061727420696e20636f6d6d756e69636174696e6720616e642073686172696e67206f6e206f75722053657276696365732e20466f72207468697320726561736f6e2c20746865205365727669636520656e636f7572616765732070656f706c6520746f2073656e6420696e7669746174696f6e7320746f206f74686572732077686f20617265206e6f742079657420636f6e6e656374656420746f206f75722053657276696365732e20496620796f752063686f6f736520746f2070726f76696465207573207769746820656d61696c20616464726573736573206f72206f7468657220436f6e746163742044617461206f662070656f706c6520696e73696465206f72206f75747369646520796f7572206f7267616e69736174696f6e2c2077652077696c6c20757365207468617420696e666f726d6174696f6e20746f20656e61626c6520796f7520616e64206f74686572205061727469636970616e747320746f20696e766974652074686f73652070656f706c6520746f206a6f696e2074686520617070726f707269617465204f4152323120536572766963652e3c2f703e0d0a0d0a3c703e5765206d617920616c736f207375676765737420636f6e7461637473207468617420796f75206d61792077616e7420746f2061646420746f20796f7572204e6574776f726b2e20496620796f752063686f6f736520746f20616464207468656d20746f20796f7572204e6574776f726b2c2077652077696c6c2073656e64207468656d20616e20696e7669746174696f6e20746f206a6f696e20796f7572204e6574776f726b2062792073656e64696e6720616e20656d61696c206f6e20796f757220626568616c66207768696368206d617920696e636c75646520796f7572206e616d652c207069637475726520616e64206f746865722070726f66696c6520696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e496e206164646974696f6e2c204f41523231207573657320436f6e74616374204461746120746f20636f6d706c65746520746865207472616e73616374696f6e7320796f7520726571756573742c2061646d696e697374657220796f7572206163636f756e742c20696d70726f76652074686520536572766963657320616e642064657465637420616e642070726576656e742066726175642e3c2f703e0d0a0d0a3c703e5765206d617920616c736f2075736520436f6e74616374204461746120746f20636f6e7461637420796f7520746f2070726f7669646520696e666f726d6174696f6e2061626f7574206e657720737562736372697074696f6e732c2062696c6c696e6720616e6420696d706f7274616e7420757064617465732061626f7574207468652053657276696365732c20696e636c7564696e6720696e666f726d6174696f6e2061626f7574207365637572697479206f72206f7468657220746563686e6963616c206973737565732e205765206d617920616c736f20636f6e7461637420796f7520726567617264696e672074686972642d706172747920696e717569726965732061732064657363726962656420696e207468697320707269766163792073746174656d656e74206f7220796f75722061677265656d656e742873292e20496620796f752061726520612076657269666965642061646d696e6973747261746f7220666f722074686520536572766963652c20796f75206d6179206e6f742062652061626c6520746f20756e7375627363726962652066726f6d20736f6d65206f6620746865736520636f6d6d756e69636174696f6e732e3c2f703e0d0a0d0a3c703e5375626a65637420746f20796f757220636f6e7461637420707265666572656e6365732c207765206d617920616c736f2075736520436f6e74616374204461746120746f20636f6e7461637420796f7520726567617264696e6720696e666f726d6174696f6e20616e64206f66666572732061626f75742074686520536572766963652c206f746865722070726f647563747320616e64207365727669636573206f7220746f207265717565737420796f757220666565646261636b2e20496620796f7520646f206e6f74207769736820746f207265636569766520746865736520636f6d6d756e69636174696f6e732c20706c65617365266e6273703b3c6120687265663d22687474703a2f2f6f6e61726f6c6c32312e636f6d2f636f6e7461637422207374796c653d22626f782d73697a696e673a20626f726465722d626f783b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b20636f6c6f723a2072676228302c203134302c20313836293b20746578742d6465636f726174696f6e3a206e6f6e653b206261636b67726f756e642d706f736974696f6e3a20696e697469616c20696e697469616c3b206261636b67726f756e642d7265706561743a20696e697469616c20696e697469616c3b22207469746c653d22223e656d61696c2075733c2f613e266e6273703b666f7220696e666f726d6174696f6e206f6e20686f7720746f2073746f70207468656d20616e6420636f6e666967757265206f74686572206e6f74696669636174696f6e20707265666572656e6365732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e557361676520446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5765206d61792075736520737461746973746963616c20646174612c20616e616c79746963732c207472656e647320616e6420757361676520696e666f726d6174696f6e20646572697665642066726f6d20796f757220757365206f66207468652053657276696365732028266c6471756f3b7573616765206461746126726471756f3b292e205573616765206461746120696e636c756465732c20666f72206578616d706c652c2061676772656761746564207175616e746974617469766520696e666f726d6174696f6e2061626f757420616374697665205061727469636970616e74732c2061637469766974792c20746f706963732c20616e642067726f7570732e20536f6d6520776179732077652075736520746865207573616765206461746120696e636c7564652070726f766964696e672064652d6964656e7469666965642c20616767726567617465642064617461207265706f72747320746f20796f75722061646d696e6973747261746f7220616e642f6f722073706f6e736f72696e67206f7267616e69736174696f6e20616e6420666f722074686520707572706f736573206f66206f7065726174696e672c20696d70726f76696e6720616e6420706572736f6e616c6973696e672074686520536572766963657320616e64206f7572206f66666572696e67732c2061732077656c6c206173206f74686572204f415232312070726f647563747320616e642073657276696365732e2045786365707420746f2070726f76696465207265706f72747320746f20796f75206f72206f746865727320696e20796f7572206f7267616e69736174696f6e2c20776520646f206e6f7420646973636c6f7365207573616765206461746120696e206120776179207768696368206973206964656e7469666961626c6520746f20796f7572206f7267616e69736174696f6e206f72205061727469636970616e747320696e20796f7572204e6574776f726b2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e537570706f727420446174613c2f7374726f6e673e3c2f703e0d0a0d0a3c703e537570706f727420446174612069732074686520696e666f726d6174696f6e20776520636f6c6c656374207768656e20796f75207375626d6974206120737570706f72742072657175657374206f722072756e20616e206175746f6d617465642074726f75626c6573686f6f7465722c20696e636c7564696e6720696e666f726d6174696f6e2061626f75742068617264776172652c20736f6674776172652c20616e64206f746865722064657461696c732072656c6174656420746f2074686520737570706f727420696e636964656e742c20737563682061733a20636f6e74616374206f722061757468656e7469636174696f6e20696e666f726d6174696f6e2c20636861742073657373696f6e20706572736f6e616c69736174696f6e2c20696e666f726d6174696f6e2061626f75742074686520636f6e646974696f6e206f662074686520636f6d707574657220616e6420746865206170706c69636174696f6e207768656e20746865206661756c74206f6363757272656420616e6420647572696e6720646961676e6f73746963732c2073797374656d20616e6420726567697374727920646174612061626f757420736f66747761726520696e7374616c6c6174696f6e7320616e6420686172647761726520636f6e66696775726174696f6e732c20616e64206572726f722d747261636b696e672066696c65732e3c2f703e0d0a0d0a3c703e537570706f7274206d61792062652070726f7669646564207468726f7567682070686f6e652c20652d6d61696c2c206f72206f6e6c696e6520636861742e205765206d6179207573652052656d6f74652041636365737320285241292c207769746820796f7572207065726d697373696f6e2c20746f2074656d706f726172696c79206e6176696761746520796f7572206465736b746f702e2050686f6e6520636f6e766572736174696f6e732c206f6e6c696e6520636861742073657373696f6e732c206f722052412073657373696f6e73207769746820737570706f72742070726f66657373696f6e616c73206d6179206265207265636f7264656420616e642f6f72206d6f6e69746f7265642e20466f722052412c20796f75206d617920616c736f2061636365737320746865207265636f7264696e6720616674657220796f75722073657373696f6e2e20466f72204f6e6c696e652043686174206f722052412c20796f75206d617920656e6420612073657373696f6e20617420616e792074696d65206f6620796f75722063686f6f73696e672e2057652075736520537570706f7274204461746120696e207468652073616d65207761792061732077652075736520796f757220696e666f726d6174696f6e2e204164646974696f6e616c6c792c2077652075736520697420746f207265736f6c766520796f757220737570706f727420696e636964656e7420616e6420666f7220747261696e696e6720707572706f7365732e3c2f703e0d0a0d0a3c703e466f6c6c6f77696e67206120737570706f727420696e636964656e742c207765206d61792073656e6420796f752061207375727665792061626f757420796f757220657870657269656e636520616e64206f66666572696e67732e20596f75206d757374206f70742d6f7574206f6620737570706f727420737572766579732073657061726174656c792066726f6d206f7468657220636f6d6d756e69636174696f6e732070726f7669646564206279204f415232312c20627920636f6e74616374696e6720537570706f7274206f72207468726f756768266e6273703b3c6120687265663d22687474703a2f2f6f6e61726f6c6c32312e636f6d2f636f6e7461637422207374796c653d22626f782d73697a696e673a20626f726465722d626f783b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b20636f6c6f723a2072676228302c203134302c20313836293b20746578742d6465636f726174696f6e3a206e6f6e653b206261636b67726f756e642d706f736974696f6e3a20696e697469616c20696e697469616c3b206261636b67726f756e642d7265706561743a20696e697469616c20696e697469616c3b22207469746c653d22223e656d61696c696e67207573207573696e672074686973206f6e6c696e6520666f726d3c2f613e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e436f6f6b6965732026616d703b204f7468657220496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5468652053657276696365207573657320266c6471756f3b636f6f6b6965732671756f743b2c2077686963682061726520736d616c6c20746578742066696c657320706c61636564206f6e20612064657669636526727371756f3b732068617264206469736b206279206120776562207365727665722e205765206d61792075736520636f6f6b69657320616e642073696d696c617220746563686e6f6c6f6769657320666f722073746f72696e67205061727469636970616e747326727371756f3b20707265666572656e63657320616e642073657474696e67732c20746f2061757468656e746963617465205061727469636970616e74732c20746f20636f6c6c656374207573616765206461746120616e64206f7065726174652074686520536572766963652e3c2f703e0d0a0d0a3c703e536f6d65206f662074686520636f6f6b69657320776520636f6d6d6f6e6c792075736520617265206c697374656420696e2074686520666f6c6c6f77696e672063686172742e2054686973206c697374206973206e6f7420657868617573746976652c2062757420697420697320696e74656e64656420746f20696c6c7573747261746520736f6d65206f662074686520726561736f6e732077652073657420636f6f6b6965732e205768656e2061205061727469636970616e7420766973697473207468652053657276696365206974206d61792073657420736f6d65206f7220616c6c206f662074686520666f6c6c6f77696e6720636f6f6b6965733a3c2f703e0d0a0d0a3c7461626c6520626f726465723d2231222063656c6c70616464696e673d2230222063656c6c73706163696e673d223022207374796c653d226261636b67726f756e642d636f6c6f723a726762283233392c203233392c20323339293b20626f726465722d636f6c6c617073653a636f6c6c617073653b20626f726465722d73706163696e673a3070783b20626f782d73697a696e673a626f726465722d626f783b20636f6c6f723a726762283130322c203130322c20313032293b20666f6e742d66616d696c793a6f70656e2073616e732c68656c766574696361206e6575652c68656c7665746963612c617269616c2c73616e732d73657269663b20666f6e742d73697a653a313270783b206d61782d77696474683a31303025223e0d0a093c74626f64793e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e3c7374726f6e673e436f6f6b6965206e616d653c2f7374726f6e673e3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e3c7374726f6e673e4465736372697074696f6e3c2f7374726f6e673e266e6273703b3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e62726f777365725f746f6b656e3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e4964656e74696669657320756e697175652062726f777365727320746f2074686520536572766963652e204974206973207573656420666f72205365727669636520616e616c797469637320616e64206f74686572206f7065726174696f6e616c20707572706f7365732e3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e617574685f746f6b656e2c20617574685f746f6b656e5f73736f3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e53746f726520696e666f726d6174696f6e2061626f75742061757468656e7469636174696f6e20707265666572656e6365733c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e5f776f726b666565645f73657373696f6e3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e53657473206120756e69717565204944206964656e74696679696e6720746865205061727469636970616e742073657373696f6e2e204974206973207573656420666f72205365727669636520616e616c797469637320616e64206f74686572206f7065726174696f6e616c20707572706f7365732e3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e79616d7472616b5f69643c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e4120636f6f6b6965207573656420666f722067656e65726174696e6720616e616c79746963616c20696e666f726d6174696f6e3c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a09093c74723e0d0a0909093c7464207374796c653d2277696474683a3138357078223e0d0a0909093c703e756e76657269666965645f656d61696c3c2f703e0d0a0909093c2f74643e0d0a0909093c7464207374796c653d2277696474683a3433377078223e0d0a0909093c703e53746f72657320746865206c6f67696e206f6620616e2061757468656e74696361746564205061727469636970616e743c2f703e0d0a0909093c2f74643e0d0a09093c2f74723e0d0a093c2f74626f64793e0d0a3c2f7461626c653e0d0a0d0a3c703e3c6272202f3e0d0a3c7374726f6e673e53686172696e6720596f757220496e666f726d6174696f6e3c2f7374726f6e673e266e6273703b3c6272202f3e0d0a57652077696c6c206e6f7420646973636c6f736520746865205061727469636970616e742044617461206f7220436f6e7461637420446174612028266c6471756f3b796f757220696e666f726d6174696f6e26726471756f3b29206f757473696465206f66204f41523231206f722069747320636f6e74726f6c6c65642073756273696469617269657320616e6420616666696c69617465732065786365707420617320796f75206469726563742c206f722061732064657363726962656420696e20796f75722061677265656d656e74287329206f72207468697320707269766163792073746174656d656e742e3c2f703e0d0a0d0a3c756c3e0d0a093c6c693e576520646f6e26727371756f3b7420736861726520616e79206f6620796f757220696e666f726d6174696f6e20776974682061647665727469736572732e3c2f6c693e0d0a093c6c693e5765206f63636173696f6e616c6c7920636f6e74726163742077697468206f7468657220636f6d70616e69657320746f2070726f7669646520736572766963657320287375636820617320746865205061727469636970616e7420737570706f72742c2064617461206d616e6167656d656e742c20616e6420746563686e6963616c20696e66726173747275637475726520736572766963657329206f6e206f757220626568616c662e205765206d61792070726f7669646520746865736520636f6d70616e69657320776974682061636365737320746f20796f757220696e666f726d6174696f6e207768657265206e656365737361727920666f7220746865697220656e676167656d656e742e20546865736520636f6d70616e6965732061726520726571756972656420746f206d61696e7461696e2074686520636f6e666964656e7469616c697479206f6620796f757220696e666f726d6174696f6e20616e64206172652070726f686962697465642066726f6d207573696e6720697420666f7220616e7920707572706f7365206f74686572207468616e207468617420666f7220776869636820746865792061726520656e6761676564206279204f415232312e3c2f6c693e0d0a093c6c693e57652077696c6c206e6f7420646973636c6f736520796f757220696e666f726d6174696f6e20746f20612074686972642070617274792028696e636c7564696e67206c617720656e666f7263656d656e742c206f7468657220676f7665726e6d656e7420656e746974792c206f7220636976696c206c69746967616e743b206578636c7564696e67206f757220737562636f6e74726163746f7273292065786365707420617320796f7520646972656374206f7220756e6c657373206e656365737361727920746f2061646472657373206120736572696f75732074687265617420746f206c6966652c206865616c7468206f72207361666574792c206f72206f7468657277697365206173207265717569726564206279206c61772e2053686f756c64206120746869726420706172747920636f6e74616374204f4152323120776974682061207265717565737420666f7220796f757220696e666f726d6174696f6e2c2077652077696c6c20617474656d707420746f2072656469726563742074686520746869726420706172747920746f2072657175657374207468652064617461206469726563746c792066726f6d20796f752e2041732070617274206f6620746861742070726f636573732c207765206d61792070726f7669646520796f757220626173696320636f6e7461637420696e666f726d6174696f6e20746f207468652074686972642070617274792e204966206c6567616c6c7920636f6d70656c6c656420746f20646973636c6f736520796f757220696e666f726d6174696f6e20746f20612074686972642070617274792c2077652077696c6c2075736520636f6d6d65726369616c6c7920726561736f6e61626c65206566666f72747320746f206e6f7469667920796f7520696e20616476616e6365206f66206120646973636c6f7375726520756e6c657373206c6567616c6c792070726f686962697465642e3c2f6c693e0d0a093c6c693e4f41523231206d617920736861726520436f6e7461637420446174612077697468207468697264207061727469657320666f7220707572706f736573206f662066726175642070726576656e74696f6e206f7220746f2070726f63657373207061796d656e74207472616e73616374696f6e732c20617320667572746865722064657363726962656420696e20746869732073746174656d656e742e3c2f6c693e0d0a093c6c693e546865205365727669636573206d617920656e61626c6520796f7520746f2070757263686173652c2073756273637269626520746f2c206f72207573652073657276696365732c20736f6674776172652c20616e6420636f6e74656e742066726f6d20636f6d70616e696573206f74686572207468616e204f415232312028266c6471756f3b5468697264205061727479204f66666572696e677326726471756f3b292e20496620796f752063686f6f736520746f2070757263686173652c2073756273637269626520746f2c206f72207573652061205468697264205061727479204f66666572696e672c207765206d61792070726f7669646520746865207468697264207061727479207769746820796f757220436f6e74616374204461746120746f20656e61626c652074686520746869726420706172747920746f2070726f7669646520697473206f66666572696e6720746f20796f752028616e64207769746820796f757220636f6e73656e742c2073656e6420796f752070726f6d6f74696f6e616c20636f6d6d756e69636174696f6e73292e2054686174206461746120616e6420796f757220757365206f662061205468697264205061727479204f66666572696e672077696c6c20626520676f7665726e656420627920746865206170706c696361626c6520746869726420706172747920707269766163792073746174656d656e7428732920616e6420706f6c69636965732e3c2f6c693e0d0a093c6c693e57652077696c6c206e6f74207375627374616e746976656c7920726573706f6e6420746f20646174612070726f74656374696f6e20616e6420707269766163792072657175657374732066726f6d205061727469636970616e747320776974686f757420796f7572207072696f72207772697474656e20636f6e73656e742c20756e6c657373207265717569726564206279206170706c696361626c65206c61772e3c2f6c693e0d0a3c2f756c3e0d0a0d0a3c703e506c65617365206e6f7465207468617420746865205365727669636573206d617920696e636c756465206c696e6b7320746f206f7220616c6c6f7720796f7520746f20696e7374616c6c2074686972642d7061727479206f72206f74686572204f415232312070726f647563747320616e642073657276696365732077686f7365207072697661637920707261637469636573206d6179206469666665722066726f6d207468652053657276696365732e20596f757220757365206f6620737563682070726f6475637473206f722073657276696365732c20616e6420616e7920696e666f726d6174696f6e20796f752070726f7669646520746f20612074686972642070617274792c20697320676f7665726e656420627920746865697220707269766163792073746174656d656e74732e20576520656e636f757261676520796f7520746f20726576696577207468657365206f7468657220707269766163792073746174656d656e74732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e5365637572697479206f6620496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e5765206861766520696d706c656d656e74656420636f6d6d65726369616c6c7920726561736f6e61626c6520746563686e6963616c20616e64206f7267616e69736174696f6e616c206d656173757265732064657369676e656420746f2073656375726520796f757220706572736f6e616c20696e666f726d6174696f6e20616e64205061727469636970616e7420436f6e74656e742066726f6d206163636964656e74616c206c6f737320616e642066726f6d20756e617574686f7269736564206163636573732c207573652c20616c7465726174696f6e206f7220646973636c6f737572652e20486f77657665722c2077652063616e6e6f742067756172616e746565207468617420756e617574686f726973656420746869726420706172746965732077696c6c206e657665722062652061626c6520746f206465666561742074686f7365206d65617375726573206f722075736520796f757220706572736f6e616c20696e666f726d6174696f6e20616e64205061727469636970616e7420436f6e74656e7420666f7220696d70726f70657220707572706f7365732e20596f752061636b6e6f776c65646765207468617420796f752070726f7669646520796f757220706572736f6e616c20696e666f726d6174696f6e20617420796f7572206f776e207269736b2e3c2f703e0d0a0d0a3c703e5765206861766520696d706c656d656e74656420616e642077696c6c206d61696e7461696e20617070726f70726961746520746563686e6963616c20616e64206f7267616e69736174696f6e616c206d656173757265732c20696e7465726e616c20636f6e74726f6c732c20616e6420696e666f726d6174696f6e20736563757269747920726f7574696e657320696e74656e64656420746f2070726f7465637420796f757220696e666f726d6174696f6e20616761696e7374206163636964656e74616c206c6f73732c206465737472756374696f6e2c206f7220616c7465726174696f6e3b20756e617574686f726973656420646973636c6f73757265206f72206163636573733b206f7220756e6c617766756c206465737472756374696f6e2e3c2f703e0d0a0d0a3c703e3c753e3c7374726f6e673e436f6e666964656e7469616c6974793c2f7374726f6e673e3c2f753e3c2f703e0d0a0d0a3c703e3c7374726f6e673e436f6e666964656e7469616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e436f6e666964656e7469616c20696e666f726d6174696f6e206d65616e7320696e666f726d6174696f6e206d61726b6564206f72206f7468657277697365206964656e74696669656420696e2077726974696e6720627920612050617274792061732070726f7072696574617279206f7220636f6e666964656e7469616c206f7220746861742c20756e646572207468652063697263756d7374616e63657320737572726f756e64696e672074686520646973636c6f737572652c206f7567687420696e20676f6f6420666169746820746f20626520747265617465642061732070726f7072696574617279206f7220636f6e666964656e7469616c2e20497420696e636c756465732c20627574206973206e6f74206c696d6974656420746f2c206e6f6e2d7075626c696320696e666f726d6174696f6e20726567617264696e672065697468657220506172747926727371756f3b732070726f64756374732c2066656174757265732c206d61726b6574696e6720616e642070726f6d6f74696f6e732c20616e6420746865206e65676f746961746564207465726d73206f6620746869732041677265656d656e7420616e6420616e79204f7264657220466f726d2873292e20436f6e666964656e7469616c20696e666f726d6174696f6e20646f6573206e6f7420696e636c75646520696e666f726d6174696f6e2077686963683a202869292074686520726563697069656e7420646576656c6f70656420696e646570656e64656e746c793b20286969292074686520726563697069656e74206b6e6577206265666f726520726563656976696e672069742066726f6d20746865206f746865722050617274793b206f722028696969292069732c206f722073756273657175656e746c79206265636f6d65732c207075626c69636c7920617661696c61626c652c206f722069732072656365697665642066726f6d20616e6f7468657220736f757263652c20696e20626f7468206361736573206f74686572207468616e206279206120627265616368206f6620616e206f626c69676174696f6e206f6620636f6e666964656e7469616c6974792e3c2f703e0d0a0d0a3c703e3c7374726f6e673e557365206f6620436f6e666964656e7469616c20496e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e466f72206120706572696f64206f6620666976652028352920796561727320616674657220696e697469616c20646973636c6f737572652c206e6569746865722050617274792077696c6c2075736520746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20776974686f757420746865206f7468657226727371756f3b73207772697474656e20636f6e73656e742065786365707420696e2066757274686572616e6365206f66207468697320627573696e6573732072656c6174696f6e73686970206f7220617320657870726573736c79207065726d697474656420627920746869732041677265656d656e742e20466f72206120706572696f64206f6620666976652028352920796561727320616674657220696e697469616c20646973636c6f737572652c206e6569746865722050617274792077696c6c20646973636c6f736520746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e206578636570742028692920746f206f627461696e206164766963652066726f6d206c6567616c206f722066696e616e6369616c20636f6e73756c74616e74732c206f72202869692920696620636f6d70656c6c6564206279206c61772c20696e20776869636820636173652074686520506172747920636f6d70656c6c656420746f206d616b652074686520646973636c6f737572652077696c6c20757365206974732062657374206566666f72747320746f206769766520746865206f74686572205061727479206e6f74696365206f662074686520726571756972656d656e7420736f20746861742074686520646973636c6f737572652063616e20626520636f6e7465737465642e20456163682050617274792077696c6c2074616b6520726561736f6e61626c652070726563617574696f6e7320746f2073616665677561726420746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e2e20537563682070726563617574696f6e732077696c6c206265206174206c656173742061732067726561742061732074686f736520656163682070617274792074616b657320746f2070726f7465637420697473206f776e20636f6e666964656e7469616c20696e666f726d6174696f6e2e20456163682050617274792077696c6c20646973636c6f736520746865206f7468657226727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20746f2069747320656d706c6f796565732c20636f6e73756c74616e74732c206f7220737562636f6e74726163746f7273206f6e6c79206f6e2061206e6565642d746f2d6b6e6f772062617369732c2070726f76696465642074686174207375636820656d706c6f79656573206f7220737562636f6e74726163746f727320617265207375626a65637420746f20636f6e666964656e7469616c697479206f626c69676174696f6e73206e6f206c657373207265737472696374697665207468616e2074686f736520636f6e7461696e65642068657265696e2e205768656e20636f6e666964656e7469616c20696e666f726d6174696f6e206973206e6f206c6f6e676572206e656365737361727920746f20706572666f726d20616e79206f626c69676174696f6e20756e64657220616e79204f7264657220466f726d2873292c20656163682050617274792077696c6c2072657475726e20697420746f20746865206f74686572206f722064657374726f7920697420617420746865206f7468657226727371756f3b7320726571756573742e20456974686572205061727479206d61792070726f766964652073756767657374696f6e732c20636f6d6d656e7473206f72206f7468657220666565646261636b20746f20746865206f746865722050617274792077697468207265737065637420746f20746865206f7468657226727371756f3b732070726f647563747320616e642053657276696365732e20466565646261636b20697320766f6c756e7461727920616e642074686520506172747920726563656976696e6720666565646261636b206d61792075736520697420666f7220616e7920707572706f736520776974686f7574206f626c69676174696f6e206f6620616e79206b696e642065786365707420746861742074686520506172747920726563656976696e6720666565646261636b2077696c6c206e6f7420646973636c6f73652074686520736f75726365206f6620666565646261636b20776974686f75742074686520636f6e73656e74206f66207468652050617274792070726f766964696e672069742e3c2f703e0d0a0d0a3c703e3c7374726f6e673e436f2d6f7065726174696f6e20696e20746865204576656e74206f6620446973636c6f737572653c2f7374726f6e673e3c2f703e0d0a0d0a3c703e456163682050617274792077696c6c20696d6d6564696174656c79206e6f7469667920746865206f746865722075706f6e20646973636f76657279206f6620616e7920756e617574686f726973656420757365206f7220646973636c6f73757265206f6620746865206f7468657220506172747926727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20616e642077696c6c20636f6f70657261746520696e20616e7920726561736f6e61626c652077617920746f2068656c7020746865206f746865722072656761696e20706f7373657373696f6e206f662074686520636f6e666964656e7469616c20696e666f726d6174696f6e20616e642070726576656e74206675727468657220756e617574686f726973656420757365206f7220646973636c6f737572652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e4b6e6f776c6564676520426173653c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4f41523231206d61792075736520616e7920746563686e6963616c20696e666f726d6174696f6e204f4152323120646572697665732066726f6d2070726f766964696e672053657276696365732072656c6174656420746f204f4152323126727371756f3b732070726f647563747320666f722070726f626c656d207265736f6c7574696f6e2c2074726f75626c6573686f6f74696e672c2070726f647563742066756e6374696f6e616c69747920656e68616e63656d656e747320616e642066697865732c20666f72204f4152323126727371756f3b73206b6e6f776c6564676520626173652e204f4152323120616772656573206e6f7420746f206964656e7469667920746865205061727469636970616e74206f7220646973636c6f736520616e79206f6620746865205061727469636970616e7426727371756f3b7320636f6e666964656e7469616c20696e666f726d6174696f6e20696e20616e79206974656d20696e204f4152323126727371756f3b73206b6e6f776c6564676520626173652e3c2f703e0d0a0d0a3c703e3c7374726f6e673e4368616e67657320746f207468697320507269766163792026616d703b20436f6e666964656e7469616c6974792053746174656d656e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e57652077696c6c206f63636173696f6e616c6c7920757064617465207468697320707269766163792073746174656d656e7420746f207265666c65637420746865205061727469636970616e7420666565646261636b2c206368616e67657320696e206f75722053657276696365732c20616e64207570646174657320746f206170706c696361626c6520646174612070726976616379206c61777320616e6420726567756c6174696f6e732e205768656e20776520706f7374206368616e67657320746f20746869732073746174656d656e742c2077652077696c6c207265766973652074686520266c6471756f3b6c617374207570646174656426726471756f3b20646174652061742074686520746f70206f66207468652073746174656d656e742e20496620746865726520617265206d6174657269616c206368616e67657320746f20746869732073746174656d656e74206f7220696e20686f77204f415232312077696c6c2075736520796f757220696e666f726d6174696f6e2c2077652077696c6c206e6f7469667920796f752062792065697468657220706f7374696e672061206e6f74696365206f662073756368206368616e676573206265666f726520746865792074616b6520656666656374206f7220627920646972656374206e6f74696669636174696f6e2e20576520656e636f757261676520796f7520746f20706572696f646963616c6c7920726576696577207468697320707269766163792073746174656d656e7420746f206c6561726e20686f77204f415232312069732070726f74656374696e6720796f757220696e666f726d6174696f6e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e4675727468657220696e666f726d6174696f6e3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e4675727468657220696e666f726d6174696f6e2061626f757420746865206170706c69636174696f6e206f66207468652050726976616379204163742063616e20626520666f756e64206174207468652077656273697465206f6620746865204f6666696365206f6620746865204175737472616c69616e20496e666f726d6174696f6e20436f6d6d697373696f6e6572206174207777772e707269766163792e676f762e61752e3c2f703e0d0a0d0a3c703e3c7374726f6e673e486f772077652068616e646c6520636f6d706c61696e74733c2f7374726f6e673e3c2f703e0d0a0d0a3c703e496620796f75206861766520616e7920636f6e6365726e73206f7220636f6d706c61696e74732061626f757420746865206d616e6e657220696e20776869636820796f757220706572736f6e616c20696e666f726d6174696f6e20686173206265656e20636f6c6c6563746564206f722068616e646c6564206279204f415232312c20706c65617365266e6273703b3c6120687265663d22687474703a2f2f6f6e61726f6c6c32312e636f6d2f636f6e7461637422207374796c653d22626f782d73697a696e673a20626f726465722d626f783b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b20636f6c6f723a2072676228302c203134302c20313836293b20746578742d6465636f726174696f6e3a206e6f6e653b206261636b67726f756e642d706f736974696f6e3a20696e697469616c20696e697469616c3b206261636b67726f756e642d7265706561743a20696e697469616c20696e697469616c3b22207469746c653d22223e636f6e7461637420757320766961206f7572206f6e6c696e6520656e7175697269657320666f726d3c2f613e2e3c2f703e0d0a0d0a3c703e3c7374726f6e673e5769746864726177616c206f6620636f6e73656e743c2f7374726f6e673e3c2f703e0d0a0d0a3c703e596f75206d617920616c736f20776974686472617720796f757220636f6e73656e7420746f2074686520757365206f6620706572736f6e616c20696e666f726d6174696f6e20666f7220616e79207365636f6e6461727920707572706f73657320287768657468657220666f7220796f757273656c66206f7220616e7920646570656e64616e74206167656420756e646572203136207965617273292062792070686f6e696e67207573206f6e202b36312033203938323720313338382e3c2f703e0d0a, '2014-02-06 15:02:54', '2014-03-04 00:48:28');
INSERT INTO `site_settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(7, 'businessbenefits', 0x3c703e3c7374726f6e673e4f4e204120524f4c4c2032312674726164653b2069732061206469676974616c206265686176696f7572206368616e67652070726f6772616d20746861742070726f7669646573206d656173757261626c65206c6966747320696e20616c6c20746865206b6579206172656173206f662077656c6c6265696e6720766974616c20666f722070726f6475637469766974792e203c2f7374726f6e673e3c7374726f6e673e266e6273703b3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e446576656c6f7065642062792061207465616d206f662070737963686f6c6f67697374732c206e6575726f736369656e6365206578706572747320616e64206265686176696f7572206368616e6765207370656369616c697374732c204f4e204120524f4c4c2032312674726164653b20697320612066726573682c20656e7465727461696e696e6720627265616b206f6620726f7574696e65207468617420696e766974657320796f75722070656f706c6520746f2074616b65206f6e206120736572696573206f662072616e646f6d20616374697669746965732c20616c6c206261736564206f6e20506f7369746976652050737963686f6c6f67792e205061727469636970616e7473206361727279206f7574206f6e6520352d3130206d696e757465206163746976697479207065722064617920666f72203231206461797320266e646173683b20746865207265636f6d6d656e6465642074696d652069742074616b657320746f20666f726d2061206e65772068616269742e266e6273703b3c2f703e0d0a0d0a3c703e4f4e204120524f4c4c2032312674726164653b207573657320736f6369616c206e6574776f726b696e672070726f647563746976656c7920696e2074686520776f726b706c61636520746f2068656c70206275696c6420612063756c74757265206f6620636f6c6c61626f726174696f6e20616e642067657420796f75722070656f706c6520746f2074616b6520616476616e74616765206f662065616368206461792e205573696e67207468656972206d6f62696c65206f72206465736b746f7020636f6d70757465722c207061727469636970616e747320706f73742061626f75742074686569722061637469766974792065616368206461792077697468696e20736d616c6c2067726f7570732c206275696c64696e6720636f6e6e65637465646e6573732077697468696e20746865206f7267616e69736174696f6e20616e642070726f766964696e6720757320776974682076616c7561626c652064617461206f6e206f7267616e69736174696f6e616c2077656c6c6265696e672e3c2f703e0d0a0d0a3c703e4f4e204120524f4c4c2032312674726164653b2070726f7669646573206120686967686c7920656e676167696e6720746f6f6c20666f7220616c69676e696e6720796f75722070656f706c6526727371756f3b73206265686176696f75727320746f206f7267616e69736174696f6e616c2076616c7565732e266e6273703b3c2f703e0d0a0d0a3c68343e3c7374726f6e673e576865726520646f65732068617070696e65737320636f6d6520696e746f2069743f3c2f7374726f6e673e3c2f68343e0d0a0d0a3c703e466f72206d6f7374206f662075732c20746865206d616a6f72697479206f66206f75722074696d65206973207370656e7420617420776f726b2e20536f20646f65736e26727371756f3b74206974206d616b652073656e736520746f20646576656c6f7020612063756c7475726520616e6420656e7669726f6e6d656e74207468617420697320617320656e6a6f7961626c6520617320706f737369626c6520616e6420636f6e747269627574657320746f206f7572206f766572616c6c2068617070696e6573733f3c2f703e0d0a0d0a3c703e57616974696e6720746f206265206861707079206c696d697473206f757220627261696e26727371756f3b7320706f74656e7469616c20666f7220737563636573732e20576865726561732069662077652063616e2068656c702063756c746976617465206120706f73697469766520627261696e2c206974206d616b6573207573206d6f7265206d6f746976617465642c20656666696369656e742c20726573696c69656e742c20637265617469766520616e642070726f647563746976653b20616c6c206f6620776869636820647269766520706572666f726d616e636520616e64206120706f73697469766520776f726b2063756c747572652e3c2f703e0d0a0d0a3c68343e3c7374726f6e673e486f7720646f2049206372656174652068617070696e6573733f3c2f7374726f6e673e3c2f68343e0d0a0d0a3c703e45766572796f6e65206b6e6f7773207468617420696620796f7520776f726b206861726420796f7526727371756f3b6c6c206265206d6f7265207375636365737366756c20616e6420696620796f7520617265206d6f7265207375636365737366756c20796f7526727371756f3b6c6c2062652068617070792c2072696768743f20526563656e7420646973636f76657269657320696e20746865206669656c6473206f6620706f7369746976652070737963686f6c6f677920616e64206e6575726f736369656e636520686176652073686f776e207468617420746865206f70706f73697465206973206d6f72652061636375726174653a2068617070696e657373206675656c7320737563636573732c206e6f7420746865206f74686572207761792061726f756e643c656d3e2e3c2f656d3e205468616e6b7320746f20736369656e63652c207765206b6e6f7720746861742068617070696e6573732069732074686520707265637572736f7220746f20737563636573732c206e6f74206d6572656c792074686520726573756c742e2048617070696e65737320616e64206f7074696d69736d2061637475616c6c79206675656c20706572666f726d616e636520616e6420616368696576656d656e7420676976696e67207573207468653c6272202f3e0d0a636f6d706574697469766520656467652e3c2f703e0d0a0d0a3c68343e3c7374726f6e673e486f7720646f6573204f4e204120524f4c4c2032312674726164653b20776f726b3f3c2f7374726f6e673e3c2f68343e0d0a0d0a3c703e4f4e204120524f4c4c2032312674726164653b2069732061207765627369746520616e6420617070207468617420636f6e6e65637473207061727469636970616e74732077697468206f74686572732066726f6d20746865697220776f726b706c616365202831302d31322070656f706c65207065722067726f7570292e2050726f66696c65732063616e2072656d61696e20636f6d706c6574656c7920616e6f6e796d6f757320266e646173683b207061727469636970616e74732063616e2063726561746520612070726f66696c65206e616d6520616e6420617661746172206f662074686569722063686f6963652e266e6273703b3c2f703e0d0a0d0a3c703e45616368206461792c20616e2061637469766974792069732067656e6572617465642061742074686520726f6c6c206f6620612032312d7369646564206469676974616c20646963652e2045616368206163746976697479206973207265666572656e636564207769746820737570706f72746976652065766964656e636520696e20746865206669656c6473206f6620506f7369746976652050737963686f6c6f67792c204e6575726f736369656e636520616e642041707072656369617469766520496e71756972792e205061727469636970616e7473206172652061736b656420746f2075706c6f616420612070686f746f206f7220636f6d6d656e7420617320266c6471756f3b70726f6f6626726471756f3b206f6620686176696e6720706572666f726d6564207468656972207461736b2c2073686172696e6720746865697220657870657269656e63652077697468206f746865722067726f7570206d656d626572732e204c696b657320616e6420696e737069726174696f6e616c20636f6d6d656e74732063616e20626520706f7374656420696e20726573706f6e73652c20616e6420612070726f6772657373697665206d6f6f64206d61702069732067656e6572617465642c20747261636b696e6720746865207573657226727371756f3b732077656c6c6265696e67207468726f7567686f7574207468652070726f6772616d2e20266e6273703b3c2f703e0d0a0d0a3c703e416c6c206163746976697469657320616e6420737572766579207175657374696f6e73206265666f726520616e64206166746572207468652070726f6772616d2063616e20626520637573746f6d6973656420746f207375697420796f75722070656f706c6520616e642063756c7475726520696e6974696174697665732e3c2f703e0d0a0d0a3c68343e3c7374726f6e673e44696420796f75206b6e6f773f3c2f7374726f6e673e3c2f68343e0d0a0d0a3c703e497426727371756f3b73206e6f74206a75737420746865206e756d626572206f6620686f757273207765207369742061742061206465736b20746861742064657465726d696e6573207468652076616c75652077652067656e65726174652e2049742069732074686520656e65726779207765206272696e6720746f2074686520686f75727320776520776f726b2e20266e6273703b3c2f703e0d0a0d0a3c703e50656f706c65206172652064657369676e656420746f2070756c73652072687974686d6963616c6c79206265747765656e207370656e64696e6720616e642072656e6577696e6720656e657267792e205468617420697320686f77207765206f706572617465206174206f757220626573742e204d61696e7461696e696e67206120737465616479207265736572766f6972206f6620656e657267792c20706879736963616c6c792c206d656e74616c6c792c20656d6f74696f6e616c6c7920616e64206576656e2073706972697475616c6c792c2072657175697265732072656675656c6c696e67266e6273703b697420696e7465726d697474656e746c792e266e6273703b3c2f703e0d0a0d0a3c703e496e6372656173696e6720796f75722070656f706c6526727371756f3b732068617070696e65737320616e642077656c6c6265696e6720617420776f726b2063616e2068656c703a3c2f703e0d0a0d0a3c756c3e0d0a093c6c693e5265647563652074686520636f7374206f6620656d706c6f796565207475726e6f766572206279203436253c7375703e313c2f7375703e3c2f6c693e0d0a093c6c693e5265647563652074686520636f7374206f66207369636b206c65617665206279203139253c7375703e313c2f7375703e3c2f6c693e0d0a093c6c693e496e6372656173652070726f647563746976697479206279207570266e6273703b746f203430253c7375703e323c2f7375703e3c2f6c693e0d0a3c2f756c3e0d0a0d0a3c68343e3c7374726f6e673e54686520756e6971756520616476616e746167653c2f7374726f6e673e3c2f68343e0d0a0d0a3c703e536f6d65206265686176696f7572206368616e676520657870657274732062656c696576652069742074616b6573203231206461797320746f2063726561746520612068616269742e20486f7765766572206c6f6e672069742074616b65732c2073747275637475726520616e642072657065746974696f6e20617265206b657920666f72206b69636b7374617274696e67206368616e67652e204f4e204120524f4c4c2032312674726164653b2070726f7669646573207468652073747275637475726520666f722070656f706c6520746f207374617274206275696c64696e672061206c6966652074686174206665656c73206d6f726520616c65727420616e6420616c6976652e3c2f703e0d0a0d0a3c703e4174204f4e204120524f4c4c2032312674726164653b20776520736861726520612070617373696f6e20666f72206d616b696e67207468696e67732068617070656e20616e64206d616b696e67207468696e67732066756e2e20536f206a6f696e20696e20746865206d6f6d656e74756d20616e6420676574203c656d3e6f6e206120726f6c6c3c2f656d3e2c206d6178696d6973696e6720796f75722070656f706c6526727371756f3b7320706f74656e7469616c20617420776f726b2c20616e642068656c70696e67207468656d206d61696e7461696e2061206d6f726520706f736974697665206d696e6473657420696e20657665727920617370656374206f66207468656972206c697665732e3c2f703e0d0a0d0a3c703e3c7374726f6e673e3c6120687265663d222f636f6e74616374223e436f6e746163742075733c2f613e20746f64617920746f206469736375737320686f7720746f2067657420796f75722070656f706c65204f4e204120524f4c4c20746f77617264732068617070696e6573732c2077656c6c6e65737320616e642070726f6475637469766974792e3c2f7374726f6e673e3c2f703e0d0a, '2014-02-06 15:02:54', '2014-03-03 08:19:07'),
(8, 'aboutus', 0x3c703e3c7374726f6e673e49742074616b6573203231206461797320746f206368616e676520796f757220776179732e20266e6273703b3c2f7374726f6e673e3c2f703e0d0a0d0a3c703e536f20776879206e6f74206861766520736f6d652066756e20616c6f6e6720746865207761793f266e6273703b3c2f703e0d0a0d0a3c703e4f6e204120526f6c6c2032312674726164653b206973266e6273703b6120736f6369616c206e6574776f726b266e6273703b67616d652074686174262333393b732064657369676e656420746f206d616b65206865616c7468792068616269747320737469636b2e266e6273703b4f6e204120526f6c6c2032312674726164653b266e6273703b636f6e6e6563747320796f752077697468206f746865727320696e20796f757220776f726b706c6163652c207363686f6f6c206f7220636f6d6d756e6974792c20617320796f75206361727279206f757420323120736563726574206d697373696f6e73206f662067656e65726f736974792c2077656c6c6e6573732c266e6273703b6d696e6466756c6e65737320616e64206772617469747564652e266e6273703b3c2f703e0d0a0d0a3c703e41742074686520726f6c6c206f66206120646963652c206f6e6520352d3130206d696e757465266e6273703b616374697669747920656163682064617920627265616b7320796f757220726f7574696e6520616e64206765747320796f75206f6e652064617920636c6f73657220746f206265696e672061206865616c74686965722c206d6f726520616c65727420616e6420616c6976652076657273696f6e206f6620796f752120476f20756e646572636f766572206f72206a75737420626520796f757273656c662c206173266e6273703b796f75266e6273703b73686172652073746f726965732061626f757420796f757220676f6f642064656564732077697468206120736d616c6c2067726f7570206f6620667269656e6473206f7220636f6c6c6561677565732e3c2f703e0d0a0d0a3c703e546865206163746976697469657320617265266e6273703b6261736564206f6e20746865207072696e6369706c6573206f66203c656d3e6e6575726f736369656e63653c2f656d3e20616e64203c656d3e706f7369746976652070737963686f6c6f67793c2f656d3e2c20616e64206172652064657369676e656420746f2074617020696e206f6e206172656173206f662074686520627261696e20746861742070726f6d6f74652068617070696e6573732c2070726f64756374697669747920616e642077656c6c6265696e672e204f76657220323120646179732c204f6e204120526f6c6c2032312674726164653b2068656c7073266e6273703b666f726d20746865206e657572616c20706174687761797320726571756972656420666f72207475726e696e67206265686176696f75727320696e746f266e6273703b6861626974732e3c2f703e0d0a0d0a3c703e4f6e204120526f6c6c2032312674726164653b2069732074686520627261696e206368696c64206f66266e6273703b61207465616d206f662070737963686f6c6f67697374732c206e6575726f736369656e6365206578706572747320616e64206265686176696f7572206368616e6765207370656369616c697374732e20266e6273703b3c2f703e0d0a0d0a3c703e4c65742074686520676f6f642074696d657320726f6c6c213c6272202f3e0d0a266e6273703b3c2f703e0d0a, '2014-02-06 15:02:54', '2014-03-03 08:02:07'),
(9, 'getstarted', 0x3c6f6c3e0d0a093c6c693e456e7375726520796f752075736520746865207265636f6d6d656e6465642062726f7773657220666f72204f6e204120526f6c6c203231206f6e20796f757220707265666572726564206465766963652e205468652070726f6772616d2069732061636365737369626c65206f6e20626f7468206465736b746f7020616e64206d6f62696c652c2062757420776f726b73206265737420696e20746865206c617465737420476f6f676c65204368726f6d652c2046697265666f782c205361666172692c204578706c6f726572203920616e64204578706c6f726572203130202877652061726520636f6e74696e75696e6720746f206f7074696d69736520696e204578706c6f726572203820616e6420416e64726f696420496e7465726e6574292e266e6273703b3c7374726f6e673e496620796f75722070686f6e65206f72207461626c6574207573657320416e64726f69642c207765207265636f6d6d656e64207573696e6720476f6f676c65204368726f6d6520286e6f7420496e7465726e657429206173207468652062726f777365722e3c2f7374726f6e673e266e6273703b506c6561736520646f776e6c6f6164207468652066726565204368726f6d6520617070206f6e746f20796f7572206465766963652e266e6273703b546f2063726561746520616e20617070206f722073686f727463757420746f204f6e204120526f6c6c203231206f6e20796f75722073637265656e2c2073696d706c79206f70656e20746865206c696e6b20696e20796f75722064657669636520616e642073746570207468726f7567682074686520666f6c6c6f77696e6720646972656374696f6e733a0d0a093c756c3e0d0a09093c6c693e0d0a09093c756c3e0d0a0909093c6c693e3c6120687265663d22687474703a2f2f74656163686d65696f732e636f6d2f686f772d746f2d6164642d612d776562706167652d626f6f6b6d61726b2d61732d616e2d69636f6e2d6f6e2d686f6d652d73637265656e2d6f662d6970686f6e652d697061642d6d696e692d616e642d69706f642d746f7563682f22207374796c653d22636f6c6f723a207267622833312c203137392c20323231293b206d617267696e3a203070783b2070616464696e673a203070783b20626f726465723a203070783b206f75746c696e653a203070783b20766572746963616c2d616c69676e3a20626173656c696e653b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b223e6970686f6e652f697061643c2f613e3c2f6c693e0d0a0909093c6c693e3c6120687265663d22687474703a2f2f637261636b62657272792e636f6d2f686f772d6164642d686f6d652d73637265656e2d73686f72746375742d616e792d776562736974652d626c61636b62657272792d313022207374796c653d22636f6c6f723a207267622833312c203137392c20323231293b206d617267696e3a203070783b2070616464696e673a203070783b20626f726465723a203070783b206f75746c696e653a203070783b20766572746963616c2d616c69676e3a20626173656c696e653b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b223e426c61636b62657272793c2f613e3c2f6c693e0d0a0909093c6c693e3c6120687265663d22687474703a2f2f686f77746f2e636e65742e636f6d2f383330312d31313331305f33392d32303036303632342d3238352f616464696e672d6f6e652d746f7563682d626f6f6b6d61726b732d746f2d796f75722d616e64726f6964732d686f6d652d73637265656e2f22207374796c653d22636f6c6f723a207267622833312c203137392c20323231293b206d617267696e3a203070783b2070616464696e673a203070783b20626f726465723a203070783b206f75746c696e653a203070783b20766572746963616c2d616c69676e3a20626173656c696e653b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b223e416e64726f69643c2f613e3c2f6c693e0d0a0909093c6c693e3c6120687265663d22687474703a2f2f74656368626c6f672e67696e6b746167652e636f6d2f323031312f30312f686f772d746f2d6164642d617070732d616e642d776562706167652d746f2d7468652d686f6d652d73637265656e2d696e2d77696e646f77732d70686f6e652d372f22207374796c653d22636f6c6f723a207267622833312c203137392c20323231293b206d617267696e3a203070783b2070616464696e673a203070783b20626f726465723a203070783b206f75746c696e653a203070783b20766572746963616c2d616c69676e3a20626173656c696e653b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b223e57696e646f777320372050686f6e653c2f613e3c2f6c693e0d0a0909093c6c693e3c6120687265663d22687474703a2f2f62726f77736572732e61626f75742e636f6d2f6f642f696e7465726e65746578706c6f7265727475746f7269616c732f73732f486f772d546f2d4164642d412d576562736974652d546f2d5468652d57696e646f77732d382d53746172742d53637265656e2d5573696e672d496531302e68746d22207374796c653d22636f6c6f723a207267622833312c203137392c20323231293b206d617267696e3a203070783b2070616464696e673a203070783b20626f726465723a203070783b206f75746c696e653a203070783b20766572746963616c2d616c69676e3a20626173656c696e653b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b223e57696e646f77732038205461626c65743c2f613e3c2f6c693e0d0a09093c2f756c3e0d0a09093c2f6c693e0d0a093c2f756c3e0d0a093c2f6c693e0d0a093c6c693e4d616b65207375726520796f75206861766520636f6d706c6574656420746865266e6273703b526f6c6c65727320537572766579266e6273703b6265666f726520796f7520737461727420726f6c6c696e673c2f6c693e0d0a093c6c693e55706461746520796f75722070726f66696c652f61766174617220696620796f75206c696b653a2063726561746520796f7572206f776e206e616d65206f72207069632c206368616e676520796f75722070617373776f726420746f20736f6d657468696e672065617369657220746f2072656d656d6265723c2f6c693e0d0a093c6c693e456e204d617373652c2074686520646576656c6f70657273206f66204f6e204120526f6c6c2032312c2076616c756520796f757220707269766163792c206865616c746820616e642073656375726974792e2042792070617274696369706174696e6720696e204f6e204120526f6c6c2032312c20796f7520616772656520746f206f7572266e6273703b7765627369746520706f6c6963792c266e6273703b7465726d7320616e6420636f6e646974696f6e732e20506c6561736520726576696577207468697320696e666f726d6174696f6e2e3c2f6c693e0d0a3c2f6f6c3e0d0a, '2014-02-06 15:02:54', '2014-02-13 00:13:03'),
(10, 'howtoplay', 0x3c68353e3c7374726f6e673e496e737472756374696f6e733c2f7374726f6e673e3c2f68353e0d0a0d0a3c6f6c3e0d0a093c6c693e476f20746f203c6120687265663d222f757365722f70726f66696c652f76696577223e50726f66696c653c2f613e20746f206564697420796f757220726f6c6c6572206e616d6520616e6420706963747572652e266e6273703b426520617320636c6576657220616e64266e6273703b646576696f757320617320796f752077697368213c2f6c693e0d0a093c6c693e476f20746f203c6120687265663d222f706c6179223e506c61793c2f613e20746f20737461727420726f6c6c696e672e20596f75206d61792062652070726f6d7074656420746f20636f6d706c6574652061207375727665792061742074686520626567696e6e696e6720616e6420656e64206f66207468652070726f6772616d20266e646173683b20706c6561736520636f6d706c65746520736f2077652063616e20747261636b20686f7720796f7520726f6c6c2e266e6273703b3c2f6c693e0d0a093c6c693e45616368206461792c20696e2074686520506c617920617265612c2073656c656374266e6273703b3c7374726f6e673e526f6c6c3c2f7374726f6e673e266e6273703b746f2067656e657261746520612072616e646f6d206163746976697479202877686963682077696c6c2061707065617220756e646572207468652064696365292e20596f752063616e203c7374726f6e673e526f6c6c20616761696e3c2f7374726f6e673e20696620796f7520776973682e266e6273703b3c2f6c693e0d0a093c6c693e4f6e636520796f75262333393b76652064656369646564206f6e20796f757220616374697669747920666f7220746865206461792c2073656c656374203c7374726f6e673e536176653c2f7374726f6e673e2e20546869732077696c6c2061637469766174652074686520706f737420617265612e3c2f6c693e0d0a093c6c693e506f73742061207069632c206c696e6b206f7220636f6d6d656e742061626f757420796f75722061637469766974792e205265616420796f7572206f74686572207465616d206d656d62657273262333393b20706f73747320616e64206c696b65206f7220636f6d6d656e74206f6e207468656d2e266e6273703b3c2f6c693e0d0a093c6c693e4f6e636520796f75262333393b766520706f737465642061626f757420796f75722061637469766974792c2073656c656374203c7374726f6e673e446f6e653c2f7374726f6e673e2e20546869732077696c6c206d61726b206f666620796f757220616374697669747920617320636f6d706c65746520616e642072652d61637469766174652074686520646963652e266e6273703b3c2f6c693e0d0a093c6c693e596f752077696c6c2062652070726f6d70746564206f6e20646179203231207768656e20796f75262333393b7665207265616368656420796f7572206c6173742061637469766974792e20436f6d706c657465207468652073757276657920696620617070706c696361626c65266e6273703b616e64266e6273703b636865636b20796f75722070726f66696c65207061676520746f2073656520686f7720796f7520726f6c6c6564207468726f7567686f757420746865207468726565207765656b732e3c2f6c693e0d0a093c6c693e476f20666f72746820616e6420726f6c6c206f75742068617070696e65737320616e64206a6f7920746f20746865206661722072656163686573206f662074686520756e697665727365213c2f6c693e0d0a3c2f6f6c3e0d0a0d0a3c68353e3c7374726f6e673e496d706f7274616e7420746970733c2f7374726f6e673e3c2f68353e0d0a0d0a3c756c3e0d0a093c6c693e5765262333393b7665206865617264266e6273703b796f752063616e20626520696e20686f742064656d616e642e2e2e20736f2073657420736f6d652072656d696e6465727320696e20796f75722063616c656e6461723a2061206d6f726e696e672072656d696e64657220746f20726f6c6c20616e642061266e6273703b35706d2072656d696e64657220746f20706f73742061626f757420796f757220616374697669747920736f20796f752063616e206d616b652069742070617274206f66266e6273703b796f7572206c6f6767696e672d6f666620726f7574696e65206174266e6273703b74686520656e64206f6620746865206461792e266e6273703b3c2f6c693e0d0a093c6c693e526f6c6c20616674657220796f752067657420757020696e20746865206d6f726e696e672c266e6273703b736f20796f752063616e20706c616e20616e64207363616e20666f72206f70706f7274756e697469657320647572696e67207468652064617920746f206361727279206f757420796f75722061637469766974792e266e6273703b3c2f6c693e0d0a093c6c693e5468652061637469766974696573206172652064657369676e656420746f2062652068616269742d666f726d696e672c20736f20776520656e636f757261676520796f7520746f20726f6c6c206f6e207765656b656e64732061732077656c6c206173207765656b206461797320736f20796f752063616e206b65657020757020746865206d6f6d656e74756d2e266e6273703b3c2f6c693e0d0a093c6c693e496620796f75262333393b7665206d6973736564206120646179206f72207765656b656e642c20796f752063616e20636174636820757020627920726f6c6c696e6720616e6420636f6d706c6574696e67206d6f7265207468616e203120616374697669747920706572206461792028757020746f20616e6420696e636c7564696e6720646179203230292e3c2f6c693e0d0a093c6c693e5768656e206361727279696e67206f757420796f757220616374697669747920666f7220746865206461792c20706c65617365206b65657020696e206d696e6420736f6d6520676f6c64656e2072756c6573206f6620736f6369616c206d65646961206574697175657474653a0d0a093c756c3e0d0a09093c6c693e52657370656374207072697661637920617420616c6c2074696d65733a20652e672e206f627461696e207065726d697373696f6e206265666f726520706f7374696e672072657665616c696e67207069637475726573206f66206f74686572732c20657370656369616c6c7920636f6c6c6561677565732c206f722061766f696420706f7374696e6720696e666f726d6174696f6e2074686174206d6179206265206465656d65642073656e736974697665206279206f74686572732e205468697320696e636c756465732072657370656374696e6720796f7572206f776e2070726976616379206279206e6f74206f76657273686172696e67206f722072657665616c696e6720696e666f726d6174696f6e2074686174206d6179206875727420796f75722072657075746174696f6e3c2f6c693e0d0a09093c6c693e4b65657020697420706f73697469766520616e6420636f6e7374727563746976653a20796f752061726520696e206120736d616c6c2067726f75702c20736f206265206d696e6466756c207468617420796f757220696e746572616374696f6e73206172652076657279206c696b656c7920746f20696e7370697265206f74686572733c2f6c693e0d0a09093c6c693e446f6e26727371756f3b742067657420746f6f20646973747261637465642120456163682061637469766974792069732064657369676e656420746f2074616b6520352d3130206d696e75746573206d6178696d756d2e2049662069742074616b657320616e79206c6f6e6765722c20656974686572207468696e6b206f6620616e206561736965722077617920746f20617070726f61636820746865206368616c6c656e6765206f7220736176652074686520616374697669747920666f7220746865207765656b656e6420616e64207265726f6c6c20666f7220746f6461793c2f6c693e0d0a09093c6c693e4f62736572766520796f7572206f7267616e69736174696f6e26727371756f3b7320736f6369616c206d6564696120706f6c69637920616e642f6f72206f7267616e69736174696f6e616c2076616c75657320616e6420636f6465206f6620636f6e647563743c2f6c693e0d0a09093c6c693e5265706f727420616e7920696e617070726f707269617465206265686176696f7572206f72206469737472657373696e6720636f6e74656e7420696e20746865203c6120687265663d222f7265706f7274223e5265706f72742041627573653c2f613e2073656374696f6e20696e2074686520666f6f7465722062656c6f772e2054686520737570706f7274207465616d266e6273703b77696c6c2070726f6d70746c7920616464726573732e3c2f6c693e0d0a093c2f756c3e0d0a093c2f6c693e0d0a093c6c693e456d61696c20746865266e6273703b3c6120687265663d222f636f6e7461637422207374796c653d22636f6c6f723a207267622833312c203137392c20323231293b206d617267696e3a203070783b2070616464696e673a203070783b20626f726465723a203070783b206f75746c696e653a203070783b20766572746963616c2d616c69676e3a20626173656c696e653b206261636b67726f756e642d636f6c6f723a207472616e73706172656e743b223e737570706f7274207465616d3c2f613e266e6273703b6f722070686f6e65202b363120332039383237203133383820696620796f7520657870657269656e636520616e7920746563686e6963616c20697373756573206f72207769736820746f207375626d697420616e7920666565646261636b2e20486170707920726f6c6c696e67213c2f6c693e0d0a3c2f756c3e0d0a, '2014-02-06 15:02:55', '2014-02-25 00:34:16');

-- --------------------------------------------------------

--
-- Table structure for table `surveys`
--

CREATE TABLE `surveys` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `surveys`
--

INSERT INTO `surveys` (`id`, `name`, `description`, `data`, `created_at`, `updated_at`) VALUES
(10, 'Westpac pre-survey (new)', 'Please complete the following brief positive psychology survey which will help us measure group wellbeing throughout the 21-day program. You will be asked the same questions at the end of the program. No individuals will be identified in the results; all ', 0x613a313a7b693a303b733a333139393a227b226669656c6473223a5b7b226c6162656c223a225c2249206c656164206120707572706f736566756c20616e64206d65616e696e6766756c206c6966652e5c22222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226332227d2c7b226c6162656c223a225c224d7920736f6369616c2072656c6174696f6e73686970732061726520737570706f727469766520616e6420726577617264696e672e5c22222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226336227d2c7b226c6162656c223a225c224920616d20656e676167656420616e6420696e746572657374656420696e206d79206461696c7920616374697669746965732e5c22222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633132227d2c7b226c6162656c223a225c2249206163746976656c7920636f6e7472696275746520746f207468652068617070696e65737320616e642077656c6c6265696e67206f66206f74686572732ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633138227d2c7b226c6162656c223a225c224920616d20636f6d706574656e7420616e642063617061626c6520696e20746865206163746976697469657320746861742061726520696d706f7274616e7420746f206d652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633234227d2c7b226c6162656c223a225c224920616d206120676f6f6420706572736f6e20616e64206c697665206120676f6f64206c6966652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633330227d2c7b226c6162656c223a225c224920616d206f7074696d69737469632061626f7574206d79206675747572652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633336227d2c7b226c6162656c223a225c2250656f706c652072657370656374206d652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633432227d2c7b226c6162656c223a225c22492063616e206964656e7469667920616e64206170706c7920736f6d65207761797320746f206275696c642075706f6e206d792077656c6c6265696e672ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633438227d5d7d223b7d, '2014-04-16 00:16:32', '2014-04-29 10:30:29'),
(11, 'Westpac post-survey (new)', 'Please complete this brief post-survey. These are the same questions asked at the commencement of the program, however your responses may have changed. We thank you again for your honest contribution.\r\n\r\nRate how you identify with the following statements', 0x613a313a7b693a303b733a333539363a227b226669656c6473223a5b7b226c6162656c223a22e2809c49206c656164206120707572706f736566756c20616e64206d65616e696e6766756c206c6966652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226332227d2c7b226c6162656c223a22e2809c4d7920736f6369616c2072656c6174696f6e73686970732061726520737570706f727469766520616e6420726577617264696e672ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226336227d2c7b226c6162656c223a22e2809c4920616d20656e676167656420616e6420696e746572657374656420696e206d79206461696c7920616374697669746965732ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633132227d2c7b226c6162656c223a22e2809c49206163746976656c7920636f6e7472696275746520746f207468652068617070696e65737320616e642077656c6c6265696e67206f66206f74686572732ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633138227d2c7b226c6162656c223a22e2809c4920616d20636f6d706574656e7420616e642063617061626c6520696e20746865206163746976697469657320746861742061726520696d706f7274616e7420746f206d652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633234227d2c7b226c6162656c223a22e2809c4920616d206120676f6f6420706572736f6e20616e64206c697665206120676f6f64206c6966652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633330227d2c7b226c6162656c223a22e2809c4920616d206f7074696d69737469632061626f7574206d79206675747572652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633336227d2c7b226c6162656c223a22e2809c50656f706c652072657370656374206d652ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633432227d2c7b226c6162656c223a22e2809c492063616e206964656e7469667920616e64206170706c7920736f6d65207761797320746f206275696c642075706f6e206d792077656c6c6265696e672ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633438227d2c7b226c6162656c223a22e2809c4920656e6a6f7965642070617274696369706174696e6720696e204f6e204120526f6c6c20323120616e6420776f756c64207265636f6d6d656e6420697420746f206d7920667269656e64732ee2809d222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633534227d5d7d223b7d, '2014-04-16 00:24:48', '2015-03-18 00:05:44'),
(13, 'syduni-pre', 'Please complete the following brief positive psychology survey which will help us measure group wellbeing throughout the 21-day program. You will be asked the same questions at the end of the program. No individuals will be identified in the results. ', 0x613a313a7b693a303b733a373235343a227b226669656c6473223a5b7b226c6162656c223a2249206665656c2063616c6d20616e6420706f7369746976652061626f7574206d792073747564792064617920616e64206c69666520617420556e69766572736974792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226332227d2c7b226c6162656c223a225768656e204920616d20776f726b696e672f7374756479696e67204920616d2067656e6572616c6c792076657279206d696e6466756c20616e64206162736f7262656420696e20776861742049e280996d20646f696e672e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226336227d2c7b226c6162656c223a2249206665656c20746861742074686520636f75727365204920616d207374756479696e6720697320776f7274687768696c652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633132227d2c7b226c6162656c223a224920686176652062616c616e6365206265747765656e20616c6c206172656173206f66206d79206c69666520696e636c7564696e672073747564792c2066616d696c792f667269656e647320616e642073656c662e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633138227d2c7b226c6162656c223a2249206c6f6f6b206174206d792066757475726520636172656572206f7074696f6e732077697468206f7074696d69736d2e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633234227d2c7b226c6162656c223a224920636f6d706c65746520616c6c20746865207461736b732074686174206172652061737369676e656420746f206d6520617420556e69766572736974792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633330227d2c7b226c6162656c223a2249206665656c20636f6e6e656374656420746f206d7920556e69766572736974793b206974e28099732070656f706c6520616e6420737572726f756e64696e67732e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633336227d2c7b226c6162656c223a2249206272696e6720612068696768206c6576656c206f6620656e746875736961736d20746f206d7920556e6976657273697479206c6966652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633338227d2c7b226c6162656c223a22492062656c69657665206275696c64696e672072656c6174696f6e736869707320776974682066656c6c6f772073747564656e747320616e64207374616666206973207265616c6c7920696d706f7274616e742e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633432227d2c7b226c6162656c223a22492063616e2073657420616e64206163686965766520676f616c7320746f206c6f6f6b206166746572206d79206865616c74682e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633438227d2c7b226c6162656c223a225468652070726f67726573732049206d616b65206f6e207461736b7320617420556e69766572736974792069732076697369626c6520746f206d652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633434227d2c7b226c6162656c223a2249206f6674656e206665656c2077656c6c2d737570706f7274656420616e64206d6f74697661746564206279206f7468657273206174206d7920556e69766572736974792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633439227d2c7b226c6162656c223a2249206665656c206f746865727320636172652061626f7574206d792077656c6c6265696e672e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633534227d2c7b226c6162656c223a2250656f706c6520726567756c61726c79207265636f676e697365206d7920737472656e6774687320616e6420746865206566666f727420492070757420696e2e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633539227d2c7b226c6162656c223a22492074656e6420746f20666f637573206d6f7265206f6e2074686520706f7369746976657320636f6d706172656420746f20746865206e656761746976657320696e206c6966652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633634227d2c7b226c6162656c223a22492063616e206c6175676820616e642073656520746865206c696768746572207369646520746f207468696e67732e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633639227d2c7b226c6162656c223a224920616d2061626c6520746f20656e6a6f79207468652070726573656e74206d6f6d656e742e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633734227d2c7b226c6162656c223a2249206665656c206c696b65206d79206461792068617320612073656e7365206f6620707572706f73652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633739227d2c7b226c6162656c223a2249206665656c2070726f7564206f66206d79206163636f6d706c6973686d656e747320696e206d79206c69666520736f206661722e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633834227d2c7b226c6162656c223a224920616d2061626c6520746f2072656c61782061742074686520656e64206f6620656163682064617920696e2061206865616c746879207761792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633839227d5d7d223b7d, '2014-04-15 14:16:32', '2015-03-18 00:32:29'),
(14, 'syduni-post', 'Please complete the following brief positive psychology survey which will help us measure group wellbeing throughout the 21-day program. These are the same questions at the start of the program, but your choices may have changed. No individuals will be id', 0x613a313a7b693a303b733a373235343a227b226669656c6473223a5b7b226c6162656c223a2249206665656c2063616c6d20616e6420706f7369746976652061626f7574206d792073747564792064617920616e64206c69666520617420556e69766572736974792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226332227d2c7b226c6162656c223a225768656e204920616d20776f726b696e672f7374756479696e67204920616d2067656e6572616c6c792076657279206d696e6466756c20616e64206162736f7262656420696e20776861742049e280996d20646f696e672e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a226336227d2c7b226c6162656c223a2249206665656c20746861742074686520636f75727365204920616d207374756479696e6720697320776f7274687768696c652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633132227d2c7b226c6162656c223a224920686176652062616c616e6365206265747765656e20616c6c206172656173206f66206d79206c69666520696e636c7564696e672073747564792c2066616d696c792f667269656e647320616e642073656c662e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633138227d2c7b226c6162656c223a2249206c6f6f6b206174206d792066757475726520636172656572206f7074696f6e732077697468206f7074696d69736d2e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633234227d2c7b226c6162656c223a224920636f6d706c65746520616c6c20746865207461736b732074686174206172652061737369676e656420746f206d6520617420556e69766572736974792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633330227d2c7b226c6162656c223a2249206665656c20636f6e6e656374656420746f206d7920556e69766572736974793b206974e28099732070656f706c6520616e6420737572726f756e64696e67732e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633336227d2c7b226c6162656c223a2249206272696e6720612068696768206c6576656c206f6620656e746875736961736d20746f206d7920556e6976657273697479206c6966652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633338227d2c7b226c6162656c223a22492062656c69657665206275696c64696e672072656c6174696f6e736869707320776974682066656c6c6f772073747564656e747320616e64207374616666206973207265616c6c7920696d706f7274616e742e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633432227d2c7b226c6162656c223a22492063616e2073657420616e64206163686965766520676f616c7320746f206c6f6f6b206166746572206d79206865616c74682e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633438227d2c7b226c6162656c223a225468652070726f67726573732049206d616b65206f6e207461736b7320617420556e69766572736974792069732076697369626c6520746f206d652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633434227d2c7b226c6162656c223a2249206f6674656e206665656c2077656c6c2d737570706f7274656420616e64206d6f74697661746564206279206f7468657273206174206d7920556e69766572736974792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633439227d2c7b226c6162656c223a2249206665656c206f746865727320636172652061626f7574206d792077656c6c6265696e672e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633534227d2c7b226c6162656c223a2250656f706c6520726567756c61726c79207265636f676e697365206d7920737472656e6774687320616e6420746865206566666f727420492070757420696e2e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633539227d2c7b226c6162656c223a22492074656e6420746f20666f637573206d6f7265206f6e2074686520706f7369746976657320636f6d706172656420746f20746865206e656761746976657320696e206c6966652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633634227d2c7b226c6162656c223a22492063616e206c6175676820616e642073656520746865206c696768746572207369646520746f207468696e67732e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633639227d2c7b226c6162656c223a224920616d2061626c6520746f20656e6a6f79207468652070726573656e74206d6f6d656e742e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633734227d2c7b226c6162656c223a2249206665656c206c696b65206d79206461792068617320612073656e7365206f6620707572706f73652e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633739227d2c7b226c6162656c223a2249206665656c2070726f7564206f66206d79206163636f6d706c6973686d656e747320696e206d79206c69666520736f206661722e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633834227d2c7b226c6162656c223a224920616d2061626c6520746f2072656c61782061742074686520656e64206f6620656163682064617920696e2061206865616c746879207761792e222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a2231222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2232222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2233222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2234222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2235222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2236222c22636865636b6564223a66616c73657d2c7b226c6162656c223a2237222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633839227d5d7d223b7d, '2014-04-15 04:16:32', '2015-03-18 00:33:51'),
(15, 'EmptySurvey', 'No questions, for companies that wish not to do a survey. ie. VicHealth clients', NULL, '2015-03-26 02:01:25', '2015-03-26 02:01:25'),
(16, 'Feedback survey', '', 0x613a313a7b693a303b733a3833303a227b226669656c6473223a5b7b226c6162656c223a2244696420796f752066696e6420746865204f6e204120526f6c6c20323120657870657269656e63652075736566756c3f222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a22596573222c22636865636b6564223a66616c73657d2c7b226c6162656c223a224e6f222c22636865636b6564223a66616c73657d5d7d2c22636964223a226332227d2c7b226c6162656c223a22576f756c6420796f7520706c617920616761696e2077697468204e7574726974696f6e206d697373696f6e733f222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a22596573222c22636865636b6564223a66616c73657d2c7b226c6162656c223a224e6f222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633133227d2c7b226c6162656c223a22576f756c6420796f7520706c617920616761696e207769746820536f6369616c20436f6e6e656374696f6e206d697373696f6e733f222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a22596573222c22636865636b6564223a66616c73657d2c7b226c6162656c223a224e6f222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633432227d2c7b226c6162656c223a22576f756c6420796f7520706c617920616761696e207769746820506f736974697665205468696e6b696e67206d697373696f6e733f222c226669656c645f74797065223a22726164696f222c227265717569726564223a747275652c226669656c645f6f7074696f6e73223a7b226f7074696f6e73223a5b7b226c6162656c223a22596573222c22636865636b6564223a66616c73657d2c7b226c6162656c223a224e6f222c22636865636b6564223a66616c73657d5d7d2c22636964223a22633438227d5d7d223b7d, '2015-03-27 06:26:34', '2015-03-27 06:35:57');

-- --------------------------------------------------------

--
-- Table structure for table `survey_messages`
--

CREATE TABLE `survey_messages` (
  `id` int(10) unsigned NOT NULL,
  `survey_id` int(10) unsigned NOT NULL,
  `premessage` blob NOT NULL,
  `postmessage` blob NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_response`
--

CREATE TABLE `survey_response` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `survey_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `response` varchar(10000) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=468 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `survey_response`
--

INSERT INTO `survey_response` (`id`, `user_id`, `group_id`, `survey_id`, `type`, `response`, `created_at`, `updated_at`) VALUES
(182, 2, 17, 10, 'pre', 'a:13:{s:8:"surveyid";s:2:"10";s:7:"groupid";s:2:"17";s:6:"userid";s:1:"2";s:4:"type";s:3:"pre";s:2:"c2";s:1:"4";s:2:"c6";s:1:"4";s:3:"c12";s:1:"4";s:3:"c18";s:1:"4";s:3:"c24";s:1:"4";s:3:"c30";s:1:"4";s:3:"c36";s:1:"4";s:3:"c42";s:1:"4";s:3:"c48";s:1:"4";}', '2015-03-17 00:25:32', '2015-03-17 00:25:32'),
(451, 2, 29, 10, 'pre', 's:0:"";', '2015-08-07 02:37:26', '2015-08-07 02:37:26');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL,
  `number` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `didyouknow` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `reference` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `createdby` int(11) NOT NULL,
  `author` int(11) NOT NULL,
  `suspended` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `number`, `name`, `description`, `didyouknow`, `reference`, `createdby`, `author`, `suspended`, `created_at`, `updated_at`) VALUES
(0, 0, '', '', '', '', 1, 1, 0, '2015-08-06 14:00:00', '2015-08-06 14:00:00'),
(4, 0, 'Sample task', 'Sample description', 'Sample did you know', 'Sample reference', 0, 1, 0, '2014-01-08 13:12:42', '2014-01-08 13:26:12'),
(5, 0, 'Sample new task', 'Sample new task description', 'Sample did you know for this one', 'Sample reference for this one', 0, 2, 0, '2014-01-08 13:13:15', '2014-01-08 13:13:15'),
(6, 0, 'Task Name 3', 'Make a list of five things you’re most passionate about or simply your five favourite things in life. Choose one of these things and find a photo that represents this (if you’ve re-rolled this activity, choose something you haven’t chosen before). Make it your desktop or phone wallpaper for the day or print it out and keep beside your desk or bed to remind you that passions count. Post the pic and comment describing what it means to you.', 'The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.', 'Irene Ross. A Consistent Gratitude Practice Makes You Happier and Healthier. Tuesday, February 19, 2013 retrieved from, http://www.wellnesstoday.com/lifestyle/consistent-gratitude-practice-makes-you-happier-and-healthier', 0, 2, 0, '2014-01-12 18:51:55', '2014-01-12 18:51:55'),
(7, 0, 'The energy booster', 'Today, it''s time to put your creative hat on and come up with a random act of ENERGY!  Think of something that will provide your team, a colleague or your boss with a healthy, energy-boosting surprise. This could be an item of food or drink that you know will put a smile on their face, a happy surprise for the team or even a big acknowledgement of something that someone’s done recently that will be a welcome booster. Upload a picture of your surprise and a description of its energy boosting impact.', 'Kindness can make you happier, help alleviate depression and help improve your relationships. It’s good for your heart and your immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. It trumped good looks and financial prospects in women and men, without exception in all cultures.', 'Buss, D.M. (1989). "Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries", Behavioral & Brain Sciences, 12, 1-49.', 0, 1, 0, '2014-02-05 20:36:23', '2014-03-07 00:07:08'),
(8, 0, 'Congratulate your quiet achiever', 'Today, think of someone at Pacific Hydro who is a “quiet achiever”, or someone who is a role model of the Pacific Hydro values and behaviours, and come up with a way to recognise their contribution to the team. You might send them a happy card, or find out what their favourite song, fruit or flower is, and send it to them! Even a big thank you (with some examples of the wonderful things they do) would be wonderful. Then, upload a picture that represents what you’ve done, or a link to a song, and a description explaining how they behave and how this makes them a role model, or just the positive impact they had today.', 'Positive reinforcement not only improves self-image, it can shape our behaviour. Recognising and rewarding desirable behaviour is a key to motivating us to work more productively. ', 'http://www.alnmag.com/articles/2010/04/using-positive-reinforcement-employee-motivation', 0, 1, 0, '2014-02-05 20:42:25', '2014-02-28 01:24:21'),
(9, 0, 'Be a "can do" person', 'Today, think of three things that you have either been putting off doing at work, or things that you know will make other people’s lives easier. Then, make a plan to do at least one of these things. How does it feel when you’ve achieved it? Upload a picture or song that captures the positive impact of your “can do” approach today.', 'Gaining a sense of accomplishment or achievement can contribute immensely to your overall send of wellbeing, while helping you to increase your productivity.', 'Seligman, M.E.  Flourish.  (2011)  New York Press: New York.', 0, 1, 0, '2014-02-05 20:45:08', '2014-02-05 20:45:08'),
(10, 0, 'Bring the Values to life', 'Well it’s going to be a big day today! It’s time to get really creative. Come up with a small activity that demonstrates at least three of the Values. Then, describe what you did to bring these three Values to life today. You could then describe how this made you feel, or the positive impacts that your activity today had on someone else or the company as a whole.', 'When you act in a manner that is consistent with your values, you are more likely to sustain your energy levels, and ultimately be more successful.', 'Schwartz, T etc al.  Manage Your Energy, Not Your Time.  Harvard Business Review, October 2007.', 0, 1, 0, '2014-02-05 20:49:23', '2014-02-05 20:49:23'),
(11, 0, 'Hello stranger', 'Strike up a conversation with someone you regularly cross paths with, but have never spoken to in depth. It may be a colleague, someone in your building, a neighbour, a barista, a shopkeeper. Without naming them specifically, comment on how you cross paths with each other and mention one random, interesting fact you learned about them.', 'One of the most important things for physical and mental wellbeing is a feeling of control over your surroundings. It could be as simple as talking to someone you’ve never talked to before. This can also improve confidence, which is a precursor to action.', 'Cooper, C.L, Field, J. Goswami, U. Jenkins, R. & Sahahian, B.J. (2009).  Mental Capital and Wellbeing.  Wiley: Blackwell. UK.', 0, 1, 0, '2014-02-05 20:56:08', '2014-02-05 20:56:08'),
(12, 0, 'Time to reflect', 'Don’t you just love a performance review when you’re the one reviewing yourself? Reflecting on your work day today (or yesterday), describe one thing you did that made a positive difference and what Pacific Hydro values and behaviours this is aligned with. Or, if you’d prefer, write down five qualities that you would like to be remembered for by others. Choose one of these things and practise it today. Post a photo of something that represents the task, quality or outcome and describe it.', 'When 577 volunteers were encouraged to practise a signature strength and use it each day for a week, they became significantly happier and less depressed than control groups.', 'Loehr, J., & Schwartz, T. (2003). The Power of Full Engagement: Managing Energy, Not Time, Is the Key to Performance and Personal Renewal. New York: Free Press, at 65.', 0, 1, 0, '2014-02-05 21:10:44', '2014-02-28 01:29:38'),
(13, 0, 'Remember me?', 'Reconnect with a friend, colleague or relative you haven’t spoken to in a long time and surprise them today with an email, letter, card, phone call or visit. Post a pic of that person (if you have their permission) or something you associate with them, explaining their connection to you and what you like about them the most.', 'When intrinsic recognition is specific and deliberately delivered, it is even more motivating than money. It takes approximately three positive comments, expressions or experiences to fend off the languishing effects of one negative one. Dip below this and workplace performance suffers. Rise above it and teams produce their very best work.', 'Grant AM. (2008) Does Intrinsic Motivation Fuel the Prosocial Fire? Motivational Synergy in Predicting Persistence, Performance, and Productivity. Journal of Applied Psychology. 93(1):48-58.', 0, 1, 0, '2014-02-05 21:13:27', '2014-02-05 21:13:27'),
(14, 0, 'The gentle nudge', 'Do you know someone at work who has some big aspirations? Think of something that you can do that is positively encouraging (it could be an email, a card, an extra effort you make) that will let the person know that you notice and value their aspirations, and encourage them to pursue them with excitement and vigour!  Post something that doesn''t identify the individual, and comment on their reaction to your support.', 'Providing encouragement can have positive impacts on dopamine levels within the recipient’s brain. Dopamine, in turn, helps turn on the reward centre of the brain and also assists in cognitive functioning, decision making and motivation.', 'Shiner T, et al.  Dopamine and performance in a reinforcement learning task.  Brain: a Journal of Neurology. London: Oxford Journals. 2012: 135; 1871-1883.', 0, 1, 0, '2014-02-05 21:16:09', '2014-02-05 21:16:09'),
(15, 0, 'The Cone of Silence', 'Time to enter your own Cone of Silence! Using your calendar and/or phone, find a moment in your day to set aside an uninterrupted half hour, where you do not check nor respond to any emails or phone calls. Try to knock over a task that you need some quiet time to finish. Lock it in now before you get swept into the momentum of today’s demands. Briefly describe what you were able to achieve during that time and, if possible, a photo of what you achieved.', 'Gaining a sense of accomplishment or achievement can contribute immensely to your overall sense of wellbeing, while helping you to increase your productivity.', 'Seligman, M.E.  Flourish.  (2011)  New York Press: New York.', 0, 1, 0, '2014-02-05 21:18:52', '2014-03-05 06:01:31'),
(17, 0, 'Can''t complain about that', 'Wouldn’t you know, today happens to be International No Complaints Day. Be extra attentive to how you communicate today and try your best to get through the whole day without complaining. At the end of the day, review how you went as honestly as you can. Post a comment describing one moment when you caught yourself complaining. What on earth could you have been complaining about?', 'Excess and/or ineffective complaining can harm our mental health by promoting feelings of being helpless, hopeless, victimised, and generally bad about ourselves. Obviously, a one-off complaint won''t harm our mental health and there are effective, helpful ways to complain which can in fact be beneficial for mental health. But when the complaints accumulate through the day, our sense of helplessness can add up over time and impact our mood and self-esteem.', 'http://www.psychologytoday.com/blog/the-squeaky-wheel/201201/does-complaining-damage-our-mental-health', 0, 1, 0, '2014-02-05 21:24:37', '2014-02-05 21:24:37'),
(18, 0, 'The smile maker', 'Okay, it’s time to have some real fun! Today, think of an activity that will put a smile on people’s faces – it could be in your team, or somewhere else like a café nearby, and watch the invigorating, energy lifting effects take off! Take a photo or upload an image or song that captures the feeling you’ve created, describing what you did and how it made you feel too.', 'In a study at the University of Nottingham, psychologists found that it’s the simple things in life that impact most positively on our sense of wellbeing. The study compared the “happiness levels” of lottery jackpot winners with a control group, using a Satisfaction With Life Scale developed by the University of Illinois. Surprisingly, it wasn’t flashy cars and luxury mansions that upped the jackpot winners’ happiness quotient. It was listening to music, reading a book, or enjoying a bottle of wine with a takeaway that made a more significant difference.', 'http://www.sciencedaily.com/releases/2007/11/071130224158.htm', 0, 1, 0, '2014-02-05 21:28:14', '2014-02-05 21:28:14'),
(19, 0, 'What floats your boat?', 'Make a list of five things you’re most passionate about or simply your five favourite things in life. Choose one of these things and find a photo that represents this. Make it your desktop or phone wallpaper for the day or print it out and keep beside your desk or bed to remind you that passions count. Post the pic and comment, describing what it means to you.', 'Scientists have found that remembering the good times may be the secret to happiness and could be effective for increasing life satisfaction. This is good news because although it may be difficult to change your personality, you may be able to alter your view of time and boost your happiness.', 'Zhang, J. & Howell, R. T. (2011). Do time perspectives predict unique variance in life satisfaction beyond personality traits? Personality and Individual Differences, 50, 1261 – 1266.', 0, 1, 0, '2014-02-05 21:30:09', '2014-02-05 21:30:09'),
(20, 0, 'The crystal ball', 'Gaze into your crystal ball and picture yourself being more successful three years from now. Visualise in detail not only what your life would look like in that state, but the steps and tasks you would be performing in order to attain this outcome. Post a photo of something this outcome represents: a place you might be or something that represents the feeling, commenting on what success would look like for you.', 'While athletes have long practised visualising a successful outcome in order to attain their goals, psychologists have found that visualising the process is actually more effective as it helps focus attention on the steps needed to reach our goal, while also leading to reduced anxiety.', 'Pham LB, Taylor SE. From Thought to Action: Effects of Process-Versus Outcome-Based Mental Simulations on Performance. Pers Soc Psychol Bull February 1999 vol. 25 no. 2 250-260.', 0, 1, 0, '2014-02-05 21:31:38', '2014-02-05 21:31:38'),
(21, 0, 'Fashion police', 'What skeletons do you have in your closet? Upload a photo of an item of clothing you really should throw out but just can’t. Explain why you’re so attached to this article of clothing.', 'According to psychologists from the University of Southampton, nostalgia is a psychological resource that protects and fosters mental health. It strengthens feelings of social connectedness and belongingness, and can reduce the feelings and repercussions of loneliness.', 'http://www.southampton.ac.uk/mediacentre/news/2008/nov/08_212.shtml', 0, 1, 0, '2014-02-05 21:35:03', '2014-02-05 21:35:03'),
(22, 0, 'Just relax!', 'Time for a well-earned relaxation exercise. If you’re working today, and you’re not averse to attracting a few puzzled stares, you can do this in your office. \r\n\r\n(1)	Stand up if possible, if not, sitting up straight is also okay;\r\n(2)	Lips closed, jaw relaxed, breathe slow and low in your stomach; \r\n(3)	Breathe in for 2 seconds and out for 3 seconds. Be aware of your breathing for the whole exercise and keep it slow and deep;\r\n(4)	Cross one of your legs over the other leg, keeping your feet firmly placed on the ground. Try to place your feet even with each other; \r\n(5)	Put both your hands behind your back and grasp your hands. Now turn twist your hands so that your palms are facing the floor;\r\n(6)	Keeping your hands together and your arms straight, gently raise your arms toward your head;\r\n(7)	Notice the increase in tension in ALL of your different muscles. Hold all this for a count of 5;\r\n(8)	Now uncross your legs and return your arms to your sides. Take two or three breaths to let go of all the tension;\r\n(9)	Repeat steps 3 to 8 until you feel relaxed.\r\n\r\nPost a pic of something that gives you a feeling of relaxation.\r\n', 'Research shows that during relaxed abdominal breathing, brain waves show a pattern of relaxation. When you take a deep breath, relax and expand your diaphragm, your vagus nerve is stimulated. This instantly turns on the parasympathetic nervous system, which in turn reduces cortisol (stress hormone) levels and revitalises the brain. ', 'http://www.psychologytoday.com/blog/the-athletes-way/201302/the-neurobiology-grace-under-pressure', 0, 1, 0, '2014-02-05 21:36:26', '2014-03-02 06:24:21'),
(23, 0, 'Something to look forward to', 'As your day begins, note down three things that you''re looking forward to the most. They can be any three things, work or non-work related. Then upload a picture that represents at least one of these things with a few words describing what it is.', 'Thinking about the things you are looking forward to the most promotes optimism. Research suggests that optimism – the decision to view things in a positive or hopeful light – helps manage stress hormones and optimise wellbeing. Pessimists, by contrast, tend to have a higher stress baseline than optimists and had greater trouble dealing with stressful situations. Optimists are more protected in these circumstances.', 'Posted by Rick Nauert PhD, July 24, 2013 at Psych Central. Optimism helps manage stress hormones. http://psychcentral.com/news/2013/07/24/optimism-helps-manage-stress-hormones/57543.html', 0, 1, 0, '2014-02-05 21:38:05', '2014-02-05 21:38:05'),
(24, 0, 'Thought of the day', 'Share your favourite meme or inspirational quote that gave you a kick when you came across it.', 'About 60 to 80 percent of people favour a visual learning style, and we are increasingly trained to utilise visual learning as technology adapts to meet busy lifestyles. Not surprisingly we are more likely be moved by or find meaning in a message if it is presented in a short, sharp, pictorial format.', 'Patricia Vakos. Why the Blank Stare? Strategies for Visual Learners.  Pearson Education, Inc from, http://www.phschool.com/eteach/social_studies/2003_05/essay.html', 0, 1, 0, '2014-02-05 21:39:44', '2014-02-05 21:39:44'),
(25, 0, 'Today''s greatest hits', 'At the end of the day, note down three of the most positive things that happened today. They can be any three things. Then upload a picture that represents at least one of these things with a few words describing what it was.', 'The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.', 'Irene Ross. A Consistent Gratitude Practice Makes You Happier and Healthier. Tuesday, February 19, 2013 retrieved from, http://www.wellnesstoday.com/lifestyle/consistent-gratitude-practice-makes-you-happier-and-healthier', 0, 1, 0, '2014-02-05 21:41:30', '2014-02-05 21:41:30'),
(26, 0, 'The simple things', 'Let’s get back to basics. Today, take a photo of something that represents a simple pleasure in your working life and comment on why this makes you happy.', 'In a study at the University of Nottingham, psychologists found that it’s the simple things in life that impact most positively on our sense of wellbeing. The study compared the “happiness levels” of lottery jackpot winners with a control group, using a Satisfaction With Life Scale developed by the University of Illinois. Surprisingly, it wasn’t flashy cars and luxury mansions that upped the jackpot winners’ happiness quotient. It was listening to music, reading a book, or enjoying a bottle of wine with a takeaway that made a more significant difference.', 'http://www.sciencedaily.com/releases/2007/11/071130224158.htm', 0, 1, 0, '2014-02-05 21:42:31', '2014-02-05 21:42:31'),
(27, 0, 'Last roll of the dice', 'Okay, it’s your last day of On a Roll 21! Time to appreciate some of the things you’ve seen in your group over the past 21 days. Did you notice someone who enacted all of the Values? What is it about their posts that you admire the most? Upload a picture that represents your appreciation and a brief explanation of what the picture represents. Don’t be afraid to think outside the box!', 'Thinking about the things you enjoy the most promotes optimism. Research suggests that optimism – the decision to view things in a positive or hopeful light – helps manage stress hormones and optimise wellbeing. Pessimists, by contrast, tend to have a higher stress baseline than optimists and had greater trouble dealing with stressful situations. Optimists are more protected in these circumstances.', 'Posted by Rick Nauert PhD, July 24, 2013 at Psych Central. Optimism helps manage stress hormones. http://psychcentral.com/news/2013/07/24/optimism-helps-manage-stress-hormones/57543.html', 0, 1, 0, '2014-02-05 21:44:59', '2014-02-05 21:44:59'),
(28, 0, 'Stage a kindness ambush', 'Find the opportunity today to unleash some random generosity on an unsuspecting person you work with, perhaps someone you don''t know very well or who is new to Pacific Hydro. You might offer to shout them a coffee, give something away to them, offer to assist with a small task, etc. Comment on what you did and post a photo if you can. ', 'Kindness can make you happier, help alleviate depression and help improve your relationships. It''s good for your heart and immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. Kindness trumped good looks and financial prospects in women and men, without exception, in all cultures studied. ', 'Buss, D.M. (1989) "Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries." Behavioural and Brain Sciences, 12:1-49.', 0, 0, 0, '2014-02-28 01:57:27', '2014-03-05 06:06:13'),
(29, 0, 'Congratulate a quiet achiever (generic)', 'Today, think of someone you know who is a “quiet achiever”, and come up with a way to recognise their contribution. You might send them a happy card, or find out what their favourite song, fruit or flower is, and send it to them! Even a big thank you (with some examples of the wonderful things they do) would be wonderful. Then, upload a picture that represents what you’ve done, or a link to a song, and a description explaining the positive impact they made.', 'Positive reinforcement not only improves self-image, it can shape our behaviour. Recognising and rewarding desirable behaviour is a key to motivating us to work more productively.', 'http://www.alnmag.com/articles/2010/04/using-positive-reinforcement-employee-motivation', 0, 2, 0, '2014-03-02 04:00:02', '2014-03-02 04:00:02'),
(30, 0, 'Performance review (generic)', 'Don’t you just love a performance review when you’re the one reviewing yourself? Reflecting on your work day today (or yesterday), describe one thing you did that made a positive difference. Or, if you’d prefer, write down five qualities that you would like to be remembered for by others. Choose one of these things and practise it today. Post a photo of something that represents the task, quality or outcome and describe it.', 'When 577 volunteers were encouraged to practise a signature strength and use it each day for a week, they became significantly happier and less depressed than control groups.	', 'Loehr, J., & Schwartz, T. (2003). The Power of Full Engagement: Managing Energy, Not Time, Is the Key to Performance and Personal Renewal. New York: Free Press, at 65.	\r\n', 0, 0, 0, '2014-03-02 04:04:07', '2014-03-02 06:18:58'),
(31, 0, 'Stage a kindness ambush (generic)', 'Find the opportunity today to unleash some random generosity on an unsuspecting person, perhaps someone you don''t know very well, someone at work you haven''t gotten to know very well or someone who is new to your team or circle of friends. You might offer to shout them a coffee, give something away to them, offer to assist with a small task, etc. Comment on what you did and post a photo if you can.', 'Kindness can make you happier, help alleviate depression and help improve your relationships. It''s good for your heart and immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. Kindness trumped good looks and financial prospects in women and men, without exception, in all cultures studied.	', 'Buss, D.M. (1989) "Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries." Behavioural and Brain Sciences, 12:1-49.	\r\n', 0, 0, 0, '2014-03-02 04:07:09', '2014-03-05 06:06:50'),
(32, 0, 'Reconnect (Westpac version)', 'Reconnect with a work colleague you haven’t spoken to in a long time and surprise them today with an email, note, card, phone call or visit to their desk. Post a pic of that person (if you have their permission) or something you associate with them, explaining their connection to you and what you like about them the most.', 'Reconnect with a work colleague you haven’t spoken to in a long time and surprise them today with an email, note, card, phone call or visit to their desk. Post a pic of that person (if you have their permission) or something you associate with them, explaining their connection to you and what you like about them the most.', 'Grant AM. (2008) Does Intrinsic Motivation Fuel the Prosocial Fire? Motivational Synergy in Predicting Persistence, Performance, and Productivity. Journal of Applied Psychology. 93(1): 48-58.', 0, 2, 0, '2014-03-05 06:00:21', '2014-03-05 06:00:21'),
(33, 0, 'Kindness ambush (Westpac version)', 'Find the opportunity today to bestow some random generosity on an unsuspecting person you work with, and (if possible), someone you don’t know very well or who is new to Westpac. You might offer to shout them a coffee, give something away to them, offer to assist with a small task, etc. Comment on what you did and post a photo if you can.', 'Kindness can make you happier, help alleviate depression, and help improve your relationships. It’s good for your heart and your immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. Kindness trumped good looks and financial prospects in women and men, without exception, in all cultures studied.', 'Buss, D.M. (1989). “Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries”, Behavioural and Brain Sciences, 12. 1-49.', 0, 0, 0, '2014-03-05 06:05:17', '2014-03-05 06:07:29'),
(34, 0, 'Energy booster (Westpac version)', 'Okay, it’s time to have some real fun!  Today, think of an activity that will put a smile on people’s faces at work, eg: leave a (clean) joke on their desk, stick a poem on their coffee cup, send them a funny animal photo, and watch the invigorating, energy lifting effects take off!  Take a photo or upload an image or song that captures the feeling you’ve created, describing what you did, and how it made you feel, too.', 'In a study at the University of Nottingham, psychologists found that it’s the simple things in life that impacts most positively on our sense of wellbeing. The study compared the “happiness levels” of lottery jackpot winners with a control group, using a Satisfaction With Life Scale developed by the University of Illinois. Surprisingly, it wasn’t flashy cars and luxury mansions that upped the jackpot winners’ happiness quotient. It was listening to music, reading a book, or enjoying a bottle of wine with a takeaway that made a more significant difference.', 'http://www.sciencedaily.com/releases/2007/11/071130224158.htm', 0, 1, 0, '2014-03-05 06:09:48', '2014-03-05 06:09:48'),
(35, 0, 'Top 5 passions (Westpac version)', 'Make a list of five things you’re most passionate about or simply your five favourite things in life outside of work. Choose one of these things and find a photo that represents this (if you’ve re-rolled this activity, choose something you haven’t chosen before). Make it your desktop or phone wallpaper for the day or print it out and keep beside your desk or bed to remind you that passions count – in fact, they are integral to success. Post the pic and comment describing what it means to you.', 'Scientists have found that remembering the good times may be the secret to happiness and could be effective for increasing life satisfaction. This is good news because although it may be difficult to change your personality, you may be able to alter your view of time and boost your happiness.  Evidence also shows that focusing on your passions, even when doing tasks you wouldn’t otherwise enjoy (eg if you’re into nature, then try reading that report you’ve been putting off while sitting under a tree or down by the river at lunchtime), helps you get things completed quickly and with fewer mistakes.', 'Zhang, J. & Howell, R. T. (2011). Do time perspectives predict unique variance in life satisfaction beyond personality traits? Personality and Individual Differences, 50, 1261 – 1266. \r\nAlso, read about “Engagement” in the PERMA model espoused by Seligman, M in  Flourish.  (2011) New York Press: New York.', 0, 1, 0, '2014-03-05 06:11:49', '2014-03-05 06:11:49'),
(36, 0, 'Keepsakes (Westpac version)', 'What’s something you’re really attached to on your desk that has some history for you?  If there’s nothing you can think of, then try to find something else at work or at home that you feel positively attached to and use this instead.  Upload a photo of the item and explain why you’re so attached to it or like it so much.', 'According to psychologists from the University of Southampton, nostalgia is a psychological resource that protects and fosters mental health. It strengthens feelings of social connectedness and belongingness, and can reduce the feelings and repercussions of loneliness.', 'http://www.southampton.ac.uk/mediacentre/news/2008/nov/08_212.shtml', 0, 1, 0, '2014-03-05 06:13:19', '2014-03-05 06:13:19'),
(37, 0, 'Just relax (Westpac version)', 'Time for a well-earned relaxation exercise. If you’re working today, and you’re not averse to attracting a few puzzled stares, you can do this in your office. \r\n(1) Put your mobile on silent and put your desk phone on ‘do not disturb''; (2) Lips closed, jaw relaxed, breathe slow and low in your stomach; (3)	Breathe in for 2 seconds and out for 3 seconds. Be aware of your breathing for the whole exercise and keep it slow and deep; (4)	Cross one of your legs over the other leg, keeping your feet firmly placed on the ground. Try to place your feet even with each other; (5)	Put both your hands behind your back and grasp your hands. Now turn twist your hands so that your palms are facing the floor; (6)	Keeping your hands together and your arms straight, gently raise your arms toward your head; (7)	Notice the increase in tension in ALL of your different muscles. Hold all this for a count of 5; (8)	Now uncross your legs and return your arms to your sides. Take two or three breaths to let go of all the tension; (9)	Repeat steps 3 to 8 until you feel relaxed. Post a pic of something that gives you a feeling of relaxation.', 'Research shows that during relaxed abdominal breathing, brain waves show a pattern of relaxation. When you take a deep breath, relax and expand your diaphragm, your vagus nerve is stimulated. This instantly turns on the parasympathetic nervous system, which in turn reduces cortisol (stress hormone) levels and revitalises the brain.', 'http://www.psychologytoday.com/blog/the-athletes-way/201302/the-neurobiology-grace-under-pressure', 0, 2, 0, '2014-03-05 06:15:48', '2014-03-05 06:15:48'),
(38, 0, '3 things to look forward to (Westpac version)', 'As your day begins, note down three things that you''re looking forward to the most. They can be any three things, work or non-work related. Then upload a picture that represents at least one of these things with a few words describing what it is.  This will help improve your optimism, a key ingredient to reducing the negative impacts that stress can have on your body and mind.', 'Thinking about the things you are looking forward to the most promotes optimism. Research suggests that optimism – the decision to view things in a positive or hopeful light – helps manage stress hormones and optimise wellbeing. Pessimists, by contrast, tend to have a higher stress baseline than optimists and had greater trouble dealing with stressful situations. Optimists are more protected in these circumstances.', 'Posted by Rick Nauert PhD, July 24, 2013 at Psych Central. Optimism helps manage stress hormones. http://psychcentral.com/news/2013/07/24/optimism-helps-manage-stress-hormones/57543.html', 0, 1, 0, '2014-03-05 06:17:06', '2014-03-05 06:17:06'),
(39, 0, '3 positive things from today (Westpac version)', 'At the end of the day, note down three of the most positive things that happened today. They can be any three things. Then upload a picture that represents at least one of these things with a few words describing what it was, and how you think the thing you’ve chosen, or its positive impacts, reflects Westpac''s 5 wellbeing factors.', 'The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.', 'Irene Ross. A Consistent Gratitude Practice Makes You Happier and Healthier. Tuesday, February 19, 2013 retrieved from, http://www.wellnesstoday.com/lifestyle/consistent-gratitude-practice-makes-you-happier-and-healthier', 0, 2, 0, '2014-03-05 06:18:30', '2014-03-05 06:18:30'),
(40, 0, 'Thank someone (Westpac version)', 'Find at least one opportunity to thank someone today for their efforts in front of another person. Remember to follow the elements of positive feedback. It must: (a) be task specific, (b) outline what they did and how they did it, and (c) be accurate and upbeat. Post about what you thanked them for and how they responded. \r\n', 'When recognition is specific and deliberately delivered, it is even more motivating than money. It takes approximately three positive comments, expressions, or experiences to fend off the languishing effects of one negative. Dip below this and workplace performance suffers. Rise above it and teams produce their very best work.', 'Deci, E.L (1996). Why we do what we do. New York: Penguin.', 0, 1, 0, '2014-03-05 06:31:24', '2014-03-07 00:37:41'),
(41, 0, 'Reconnect (Pacific Hydro version)', 'Reconnect with a work colleague you haven’t spoken to in a long time and surprise them today with an email, note, card, phone call or visit to their desk. Post a pic of that person (if you have their permission) or something you associate with them, explaining their connection to you and what you like about them the most.', 'When intrinsic recognition is specific and deliberately delivered, it is even more motivating than money. It takes approximately three positive comments, expressions or experiences to fend off the languishing effects of one negative one. Dip below this and workplace performance suffers. Rise above it and teams produce their very best work.', 'Grant AM. (2008) Does Intrinsic Motivation Fuel the Prosocial Fire? Motivational Synergy in Predicting Persistence, Performance, and Productivity. Journal of Applied Psychology. 93(1):48-58.', 0, 1, 0, '2014-03-07 00:12:10', '2014-03-07 00:12:10'),
(42, 0, 'Losada ratio', 'What you focus on grows. So it''s not surprising that people who develop a habit of thinking, speaking or acting negatively just get better at it. However, it''s not a good habit because negative mindsets are strongly linked to many undesirable outcomes including anger, sadness, hopelessness, anxiety and depression. Try this 3:1 ratio. For every negative thing you think, say or do today, balance it out with 3 positive thoughts, comments or actions. Don''t be mechanical about it. Recognise that you are doing this exercise to stimulate neuron growth, so be considered, intentional and authentic. Describe or post a picture that represents one positive thought you were able to introduce.', 'In 2005 a team of scientists developed a simple formula (also known as the Losada ratio) where the ratio of three good thoughts to every negative thought that one experiences would produce a state of "flourishing" and limit the state of "languishing". ', 'Fredrickson BL, Losada M. (2005). Positive affect and the complex dynamics of human flourishing. American Psychologist, 60(7), 678–686.', 0, 1, 0, '2014-03-07 00:21:04', '2014-03-07 00:27:12'),
(43, 0, 'End of the day (Pacific Hydro version)', 'At the end of the day, note down three of the most positive things that happened today. They can be any three things. Then upload a picture that represents at least one of these things with a few words describing what it was, and how you think the thing you’ve chosen, or its positive impacts, reflects Pacific Hydro’s Values and Behaviours.', 'The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.', 'The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.', 0, 1, 0, '2014-03-07 00:34:31', '2014-03-07 00:34:31'),
(44, 0, 'Pilot - M1', '<p>Pablo Picasso: "Every child is an artist. The problem is how to remain an artist once we grow up." Sketch a stick figure of someone in your workplace doing something they either love or are good at. Put it on their desk anonymously and upload a photo of it.</p>', 'DYK-Children really have a gift. They are creative gods, always seeing options and having fun with what they''ve got. Somehow, one day someone switched on a "Life is Serious Sign" and we believed them. When you have fun, you achieve a different state that engages more of your brain because you get access to your subconscious.', 'http://www.sciencedaily.com/releases/2007/11/071130224158', 0, 1, 0, '2014-11-13 00:26:37', '2014-11-19 05:55:15'),
(45, 0, 'Pilot - M2', '<p>Today you are playing a game called "How was your day?". When you sit down for your evening meal tonight, go around the table and ask each person to share one challenging thing that happened and the best thing that happened that day. Upload a picture and a brief explanation of something that represents one of these things. It could be interesting some of the stuff you may discover about your family.</p>\r\n', '<p>It is crucial to recognise that individual psychological flourishing is not something that can be cultivated without any relation to others. We do not exist independently of others, so our well-being cannot arise independently of others either.</p>\r\n', '<p>Fredrickson BL, Losada M. (2005). Positive affect and the complex dynamics of human flourishing. American Psychologist, 60(7), 678-686.</p>\r\n', 0, 1, 0, '2014-11-13 00:27:32', '2014-11-19 05:47:02'),
(46, 0, 'Pilot - M3', '<p>If you have 3 or more good friends (that doesn''t mean Facebook buddies), you are 96% more likely to be very satisfied with your life. Your mission today is to send a thank-you note or message to a friend telling them what makes them so awesome in your eyes. Upload a photo of something this represents.</p>\r\n', '<p>When recognition is specific and deliberately delivered, it is even more motivating than money. It takes approximately three positive comments, expressions, or experiences to fend off the languishing effects of one negative. Dip below this and workplace performance suffers. Rise above it and teams produce their very best work.</p>\r\n', '<p>Deci, E.L (1996). Why we do what we do. New York: Penguin.</p>\r\n', 0, 1, 0, '2014-11-13 00:28:26', '2014-11-13 00:28:26'),
(47, 0, 'Pilot - M4', '<p>When you open your lunchbox today or collect your lunch from the school canteen; rather than scoffing it down in record time, select your favourite piece of food available and take time to really savour it. This means taking small bite size pieces and really concentrating on the taste, smell and texture. Upload a photo of what you choose.</p>\r\n', '<p>There has been great interest in determining if mindfulness can be cultivated and if this cultivation leads to well-being. College undergraduates were randomly allocated between training in two distinct meditation-based interventions, Mindfulness Based Stress Reduction (MBSR; J. Kabat-Zinn,<a href="http://onlinelibrary.wiley.com/doi/10.1002/jclp.20491/full#bib29" title="Link to bibliographic citation">1978</a>/1991) Eight Point Program (EPP;<em>n</em>=14), or a waitlist control (n=15). Pretest, posttest, and 8-week follow-up data were gathered on self-report outcome measures. Compared to controls, participants in both treatment groups (<em>n</em>=29) demonstrated increases in mindfulness at 8-week follow-up. Further, increases in mindfulness mediated reductions in perceived stress and rumination. These results suggest that distinct meditation-based practices can increase mindfulness as measured by the MAAS.</p>\r\n', '<p>Shapiro, S. L., Oman, D., Thoresen, C. E., Plante, T. G. and Flinders, T. (2008), Cultivating mindfulness: effects on well-being. J. Clin. Psychol., 64:840-862. doi:10.1002/jclp.20491</p>\r\n', 0, 1, 0, '2014-11-13 00:29:19', '2014-11-19 05:44:59'),
(48, 0, 'Pilot - M5', '<p>Have you ever stopped to wonder why sometimes kids that live in countries much poorer than our own, often seem so happy? Try recording something you are grateful for in your personal On A Roll 21 diary everyday. They don''t have to be big things at all. Post a picture of something that you recorded today.</p>\r\n', '<p>Did you know the practice of gratitude can increase happiness levels by around 25%?</p>\r\n', '<p>Posted by Rick Nauert PhD, July 24, 2013 at Psych Central. Optimism helps manage stress hormones. http://psychcentral.com/news/2013/07/24/optimism-helps-manage-stress-hormones/57543.html</p>\r\n', 0, 1, 0, '2014-11-13 00:30:11', '2014-11-19 05:44:04'),
(49, 0, 'Sydney Uni Staff Pilot #1', '<p>Strike up a conversation with someone you regularly cross paths with at Uni, but have never spoken to in depth. It may be a fellow staff member, someone in your building, a lecturer, a barista, a shopkeeper. Without naming them specifically, comment on how you cross paths with each other and mention one random, interesting fact you learned about them. Eg: their proudest accomplishment ot bravest thing they''ve ever done, greatest fear etc. Post a picture of them if you have their permission.</p>', '<p>One of the most important things for physical and mental wellbeing is a feeling of control over your surroundings. It could be as simple as talking to someone you''ve never talked to before. This can also improve confidence, which is a precursor to action.</p>', '<p>Cooper, C.L, Field, J. Goswami, U. Jenkins, R. & Sahahian, B.J. (2009). Mental Capital and Wellbeing. Wiley: Blackwell</p>', 0, 1, 0, '2015-01-19 00:40:40', '2015-01-19 00:40:40'),
(50, 0, 'Sydney Uni Staff Pilot #2', '<p>Wouldn''t you know, today happens to be International No Complaints Day. Be extra attentive to how you communicate today and try your best to get through the whole day without complaining. At the end of the day, review how you went as honestly as you can. Post a comment describing one moment when you caught yourself or someone else complaining. What on earth could you or they have been complaining about?<br />Without mentioning names what''s the lamest complaint you''ve heard recently?</p>', '<p>Excess and/or ineffective complaining can harm our mental health by promoting feelings of being helpless, hopeless, victimised, and generally bad about ourselves. Obviously, a one-off complaint won''t harm our mental health and there are effective, helpful ways to complain which can in fact be beneficial for mental health. But when the complaints accumulate through the day, our sense of helplessness can add up over time and impact our mood and self-esteem.</p>', '<p>http://www.psychologytoday.com/blog/the-squeaky-wheel/201201/does-complaining-damage-our-mental-health</p>\r\n', 0, 1, 0, '2015-01-19 00:41:52', '2015-01-19 00:41:52'),
(51, 0, 'Sydney Uni Staff Pilot #3', '<p>Today is Get Off The Couch Day. Time to leave your chair, or other cosy confines, and do something physical. (LIST of interesting and unknown places to explore or find at the University of Sydney to be used to help students become more familiar with the University - for example, find the bell tower. Also if a queue forms - students can meet one another. Examples: climb the bell tower or find the transient building at the top of Physics Road, have a snack under the Jacaranda tree, find a specific book in the library) (Draw up list of interesting and unknown places at the University of Sydney) You may walk up the stairs instead of taking the lift, go for a lunchtime walk somewhere new and interesting, or invite someone for a coffee or snack to a different cafe.</p><p>Post a pic of something you encountered during your mini-escape and describe what you did.</p>', '<p>Dr Ron Peterson, director of the Mayo Clinic''s Alzhiemer''s Disease Research Centre in the USA, says that any exercise that gets the heart pumping, assists with the prevention of Alzheimer''s disease, Parkinson''s disease and cognitive impairment itself. According to Peterson, if one exercises 150 minutes a week, 50 minutes 3 times per week (a brisk walk alone will suffice) this will reduce the risk of cognitive decline for up to 18 months.</p>\r\n', '<p>Mayo Clinic FAQ Diseases and Conditions: Alzheimer''s Disease, "Can exercise prevent memory loss and improve cognitive function?" by Dr Ronald Petersen MD. Retrieved 2 May 2014</p>\r\n', 0, 1, 0, '2015-01-19 00:44:23', '2015-01-19 00:47:24'),
(52, 0, 'Sydney Uni Staff Pilot #4', '<p>What''s the most useful thing you''ve discovered to keep you going? Maybe from the late nights you''ve realised no more coffees after 2pm? Have you discovered a nice corner to get some last minute quiet work done? Let us know your 1 useful tip/advice for living the life at USyd!</p>\r\n', '<p>...</p>\r\n', '<p>...</p>\r\n', 0, 1, 0, '2015-01-19 00:48:06', '2015-01-19 00:48:06'),
(53, 0, 'Sydney Uni Staff Pilot #5', '<p>Find the opportunity today to unleash some random generosity on an unsuspecting person you go to Uni with. You might offer to shout them a coffee, give something away to them, offer to assist with a small task, etc. Comment on what you did and post a photo if you can.</p>\r\n', '<p>Kindness can make you happier, help alleviate depression and help improve your relationships. It''s good for your heart and immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. Kindness trumped good looks and financial prospects in women and men, without exception, in all cultures studied.</p>\r\n', '<p>Buss, D.M. (1989) "Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries." Behavioural and Brain Sciences, 12:1-49.</p>\r\n', 0, 1, 0, '2015-01-19 00:49:30', '2015-01-19 00:49:30'),
(54, 0, 'syduni-1', '<p>Grab a coffee/snack with someone you don''t know very well today. Post a picture of your cafe experience and comment whether you have just discovered the best coffee or taste sensation in town.</p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:08:44', '2015-03-17 02:08:44'),
(55, 0, 'syduni-2', '<p>Strike up a conversation with someone you regularly cross paths with at uni, but have never spoken to in depth. It may be a fellow student, someone in your building, a lecturer, a barista, a shopkeeper. Without naming them specifically, comment on how you cross paths with each other and mention one random, interesting fact you learned about them. These people make up your university community so let''s celebrate them!</p>', '<p>One of the most important things for physical and mental wellbeing is a feeling of control over your surroundings. It could be as simple as talking to someone you''ve never talked to before. This can also improve confidence, which is a precursor to action.</p>', '<p>Cooper, C.L, Field, J. Goswami, U. Jenkins, R. & Sahahian, B.J. (2009). Mental Capital and Wellbeing. Wiley: Blackwell. UK.</p>', 0, 1, 0, '2015-03-17 02:09:56', '2015-03-17 02:09:56'),
(56, 0, 'syduni-3', '<p>Today is Get Off The Couch Day. Time to leave your chair, or other cosy confines, and do something physical. Universities have many interesting nooks and areas you don''t even know about so go for a wander. You may walk up the stairs instead of taking the lift, go for a lunchtime walk somewhere new and interesting, or invite someone for a coffee or snack to a different cafe. Post a pic of something you encountered during your mini-escape and describe what you did.</p>', '<p>Dr Ron Peterson, director of the Mayo Clinic''s Alzhiemer''s Disease Research Centre in the USA, says that any exercise that gets the heart pumping, assists with the prevention of Alzheimer''s disease, Parkinson''s disease and cognitive impairment itself. According to Peterson, if one exercises 150 minutes a week, 50 minutes 3 times per week (a brisk walk alone will suffice) this will reduce the risk of cognitive decline for up to 18 months.</p>', '<p>Mayo Clinic FAQ Diseases and Conditions: Alzheimer''s Disease, "Can exercise prevent memory loss and improve cognitive function?" by Dr Ronald Petersen MD. Retrieved 2 May 2014.</p>', 0, 1, 0, '2015-03-17 02:10:46', '2015-03-17 02:10:46');
INSERT INTO `tasks` (`id`, `number`, `name`, `description`, `didyouknow`, `reference`, `createdby`, `author`, `suspended`, `created_at`, `updated_at`) VALUES
(57, 0, 'syduni-4', '<p>Look for something beautiful outside today and pause to appreciate it. It doesn''t have to be anything super big or significant. In fact we know that small happy things bring us more lasting joy than big things, so go with whatever strikes you.The world is full of really cool stuff so this is a perfect challenge to try everyday this week. At the end of the day, upload a photo of what struck you.</p>', '<p>Savouring is a quick and easy way to boost optimism and reduce stress and negative emotions. It''s the practice of noticing the good stuff around you and taking the extra time to prolong and intensify your enjoyment of the moment, making pleasurable experiences last as long as possible. So whether it''s preparing a meal, pausing to admire the sunset or sharing good news with a friend; the idea is to linger, take it in and enjoy the experience.</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:11:36', '2015-03-17 02:11:36'),
(58, 0, 'syduni-5', '<p>Wouldn''t you know, today happens to be International No Complaints Day. Be extra attentive to how you communicate today and try your best to get through the whole day without complaining. At the end of the day, review how you went as honestly as you can. Post a comment describing one moment when you caught yourself complaining. If you do catch yourself, try reframing your whinging into a challenge rather than something that''s stressing you out. What''s the lamest excuse you''ve ever heard? </p>', '<p>Excess and/or ineffective complaining can harm our mental health by promoting feelings of being helpless, hopeless, victimised, and generally bad about ourselves. Obviously, a one-off complaint won''t harm our mental health and there are effective, helpful ways to complain which can in fact be beneficial for mental health. But when the complaints accumulate through the day, our sense of helplessness can add up over time and impact our mood and self-esteem.</p>', '<p>http://www.psychologytoday.com/blog/the-squeaky-wheel/201201/does-complaining-damage-our-mental-health</p>', 0, 1, 0, '2015-03-17 02:12:56', '2015-03-17 02:12:56'),
(59, 0, 'syduni-6', '<p>Gaze into your crystal ball and picture yourself being more successful three years from now. Visualise in detail not only what your life would look like in that state, but the steps and tasks you would be performing in order to attain this outcome. Post a photo of something this outcome represents: a place you might be or something that represents the feeling, commenting on what success would look like for you.</p>', '<p>While athletes have long practised visualising a successful outcome in order to attain their goals, psychologists have found that visualising the process is actually more effective as it helps focus attention on the steps needed to reach our goal, while also leading to reduced anxiety.</p>', '<p>Pham LB, Taylor SE. From Thought to Action: Effects of Process-Versus Outcome-Based Mental Simulations on Performance. Pers Soc Psychol Bull February 1999 vol. 25 no. 2 250-260.</p>', 0, 1, 0, '2015-03-17 02:13:54', '2015-03-17 02:13:54'),
(60, 0, 'syduni-7', '<p>What is the one thing you really like doing that perhaps doesn''t fit with traditional gender roles or stereotypes for men and women in Australia? (eg. something a male loves doing that isn''t normally associated with blokes)</p>', '<p>Putting people in boxes and labelling them can be limiting. The old fashioned ideas about''what men should do" and "women should do" are not helpful. They stop us from living and working together respectfully and contribute to bigger problems such as mental illness, bullying and even violence against women.</p>', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:15:13', '2015-03-17 02:15:13'),
(61, 0, 'syduni-8', '<p>Find the opportunity today to unleash some random generosity on an unsuspecting person you go to uni with. You might offer to shout them a coffee, give something away to them, offer to assist with a small task, etc. Comment on what you did and post a photo if you can.</p>\r\n', '<p>Kindness can make you happier, help alleviate depression and help improve your relationships. It''s good for your heart and immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. Kindness trumped good looks and financial prospects in women and men, without exception, in all cultures studied.</p>', '<p>Buss, D.M. (1989) "Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries." Behavioural and Brain Sciences, 12:1-49.</p>\r\n', 0, 1, 0, '2015-03-17 02:16:07', '2015-03-17 02:16:07'),
(62, 0, 'syduni-9', '<p>Okay, it''s time to have some real fun! Today, think of an activity that will put a smile on people''s faces at uni (eg. leave a [clean] joke on a noticeboard, stick a poem on their coffee cup, send them a funny animal photo), and watch the invigorating, energy lifting effects take off! Take a photo or upload an image or song that captures the feeling you''ve created, describing what you did, and how it made you feel, too.</p>\r\n', '<p>In a study at the University of Nottingham, psychologists found that it''s the simple things in life that impacts most positively on our sense of wellbeing. The study compared the "happiness levels" of lottery jackpot winners with a control group, using a Satisfaction With Life Scale developed by the University of Illinois. Surprisingly, it wasn''t flashy cars and luxury mansions that upped the jackpot winners'' happiness quotient. It was listening to music, reading a book, or enjoying a bottle of wine with a takeaway that made a more significant difference.</p>\r\n', '<p>http://www.sciencedaily.com/releases/2007/11/071130224158.htm</p>', 0, 1, 0, '2015-03-17 02:18:54', '2015-03-17 02:18:54'),
(63, 0, 'syduni-10', '<p>Make a list of five things you''re most passionate about or simply your five favourite things in life. Choose one of these things and find a photo that represents this. Make it your desktop or phone wallpaper for the day or print it out and keep beside your desk or bed to remind you that passions count - in fact, they are integral to success! Post the picture and comment describing what it means to you.</p>', '<p>Scientists have found that remembering the good times may be the secret to happiness and could be effective for increasing life satisfaction. This is good news because although it may be difficult to change your personality, you may be able to alter your view of time and boost your happiness. Evidence also shows that focusing on your passions, even when doing tasks you wouldn''t otherwise enjoy (eg if you''re into nature, then try reading that report you''ve been putting off while sitting under a tree or down by the river at lunchtime), helps you get things completed quickly and with fewer mistakes.</p>', '<p>Zhang, J. & Howell, R. T. (2011). Do time perspectives predict unique variance in life satisfaction beyond personality traits? Personality and Individual Differences, 50, 1261 - 1266. Also, read about "Engagement" in the PERMA model espoused by Seligman, M in Flourish. (2011) New York Press: New York.</p>', 0, 1, 0, '2015-03-17 02:20:08', '2015-03-17 02:20:08'),
(64, 0, 'syduni-11', '<p>Think of one thing that has happened this week that wasn''t a great experince and think about how you can reframe it as a learning opportunity. Comment on how this experince now feels.</p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:20:50', '2015-03-17 02:20:50'),
(65, 0, 'syduni-12', '<p>Follow your nose - today head off down the well-worn path and follow your nose in a new direction. It might literally be heading down a new street, drinking at a new cafe, reading an article in a different part of the newspaper, listening to a different radio station, reading a book instead of watching TV, talking to someone on the train instead of hiding behind headphones. Whatever comes to mind that takes you away from your usual patterns, just do it. Post a picture of what you tried.</p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:21:28', '2015-03-17 02:21:28'),
(66, 0, 'syduni-13', '<p>As your day begins, note down three things that you''re looking forward to the most. They can be any three things. Then upload a picture that represents at least one of these things with a few words describing what it is. This will help improve your optimism, a key ingredient to reducing the negative impacts that stress can have on your body and mind.</p>', '<p>Thinking about the things you are looking forward to the most promotes optimism. Research suggests that optimism - the decision to view things in a positive or hopeful light - helps manage stress hormones and optimise wellbeing. Pessimists, by contrast, tend to have a higher stress baseline than optimists and had greater trouble dealing with stressful situations. Optimists are more protected in these circumstances.</p>', '<p>Posted by Rick Nauert PhD, July 24, 2013 at Psych Central. Optimism helps manage stress hormones. http://psychcentral.com/news/2013/07/24/optimism-helps-manage-stress-hormones/57543.html</p>', 0, 1, 0, '2015-03-17 02:22:10', '2015-03-17 02:22:10'),
(67, 0, 'syduni-14', '<p>Find at least one opportunity to thank someone today for their efforts in front of another person. Remember to follow the elements of positive feedback. It must: (a) be task specific; (b) outline what they did and how they did it; and, (c) be accurate and upbeat. Post about what you thanked them for and how they responded.</p>', '<p>When recognition is specific and deliberately delivered, it is even more motivating than money. It takes approximately three positive comments, expressions, or experiences to fend off the languishing effects of one negative. Dip below this and workplace performance suffers. Rise above it and teams produce their very best work.</p>', '<p>Deci, E.L (1996). Why we do what we do. New York: Penguin.</p>\r\n', 0, 1, 0, '2015-03-17 02:22:48', '2015-03-17 02:22:48'),
(68, 0, 'syduni-15', '<p>Find someone who has been at uni for a while such as a third year student or a member of staff and pick their brains for their Number 1 piece of life advice for hanging in there and staying resilient during your time at Sydney Uni. </p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:23:19', '2015-03-17 02:23:19'),
(69, 0, 'syduni-16', '<p>Share and upload one of your favourite musical tracks. It could even be your own version of a song or playing an instrument so please share the joy!</p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:24:01', '2015-03-17 02:24:01'),
(70, 0, 'syduni-17', '<p>Find someone from a different cultural background to your own. Ask them what they think is one of the best things about where they were born. Post a picture of something that represents this.</p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:26:25', '2015-03-17 02:26:25'),
(71, 0, 'syduni-18', '<p>What''s the most heroic thing you''ve ever done or witnessed? Post of picture of something that represents this.</p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:27:42', '2015-03-17 02:27:42'),
(72, 0, 'syduni-19', '<p>Each day throws us curve balls and victories. At the end of the day, note down three of the most positive things that happened today. They don''t have to be earth shattering events but just any experience that put a smile on your face.Then upload a picture that represents at least one of these things with a few words describing what it was.</p>', '<p>The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.</p>', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:28:21', '2015-03-17 02:28:40'),
(73, 0, 'syduni-20', '<p>Share your favourite meme or inspirational quote that gave you a kick when you came across it.</p>\r\n', '<p>About 60 to 80 percent of people favour a visual learning style, and we are increasingly trained to utilise visual learning as technology adapts to meet busy lifestyles. Not surprisingly we are more likely be moved by or find meaning in a message if it is presented in a short, sharp, pictorial format.</p>', '<p>Patricia Vakos. Why the Blank Stare? Strategies for Visual Learners. Pearson Education, Inc from, http://www.phschool.com/eteach/social_studies/2003_05/essay.html</p>', 0, 1, 0, '2015-03-17 02:29:25', '2015-03-17 02:29:25'),
(74, 0, 'syduni-21', '<p>Who is a good role model that represents one of the things you value in life? This person maybe in the public realm or they maybe part of your family or social circle. Post a photo of who they are or what they stand for. </p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:30:02', '2015-03-17 02:30:02'),
(75, 0, 'syduni-22', '<p>Okay, it''s your last day of On A Roll 21. Time to appreciate some of the things you have seen over the past 21 days. What is it about some posts that you admired most or gave you a real kick. Upload a picture that represents your appreciation and a brief explanation of what that picture represents. Don''t be afraid to think outside the box.</p>', '<p>No more info...</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-17 02:30:36', '2015-03-17 02:30:36'),
(76, 0, 'VicHealth-1', '<p>A simple challenge for you today. At work, make sure you greet everyone with a smile and give eye contact. Notice how this is received by others and post your comments, or post a photo of something that makes you smile in your workplace.</p>\r\n', '<p>Smiling is a great way to connect with colleagues and improve your self image. We tend to think of smiling as a reaction or result of feeling good, but in his facial feedback theory, Charles Darwin argued that the self-initiated act of smiling actually makes you feel better.In terms of creating a respectful environment at work-a simple smile is a great place to start!</p>\r\n', '<p>No more info...</p>\r\n', 0, 1, 0, '2015-03-26 00:36:24', '2015-03-26 00:36:24'),
(77, 0, 'VicHealth-2', 'Share a favourite picture, quote  or meme that sums up your attitude when you think of getting along with your colleagues...', 'We all know that when we get along well and respect others in the workplace, it has a ripple effect. By sharing your philosophy you can help others develop their own approach and enhance workplace relationships.', 'No more info...', 0, 1, 0, '2015-03-26 00:37:18', '2015-03-26 00:37:18'),
(78, 0, 'VicHealth-3', 'Today think of three benefits associated with gender equality - at home, at work and in society. Post your list and maybe a photo of something that represents this if you can.', 'Gender equality is achieved when people''s rights, access and opportunities aren''t affected by such things as people''s traditional gender beliefs, whether they are male or female or the stereotypes of what men and women "should" be like.', 'No more info...', 0, 1, 0, '2015-03-26 00:38:39', '2015-03-26 00:38:39'),
(79, 0, 'VicHealth-4', 'Today ask a colleague about what equality in the workplace means to them. Without revealing who the person is, post about how this conversation went, what does equality mean to this person?', 'The best gender equality and respect programs initiate changes in workplaces as a result of having conversations. It''s often helpful to have different opinions and debate them so we can progress and learn over time. So get the conversations started.', 'No more info...', 0, 1, 0, '2015-03-26 00:39:28', '2015-03-26 00:39:28'),
(80, 0, 'VicHealth-5', 'Find the opportunity today to unleash some random generosity on an unsuspecting person you work with, perhaps someone you don''t know very well. You might offer to shout them a coffee, give something to them, offer to assist with a small task, etc. Comment on what you did and post a photo if you can.', 'Kindness can make you happier, help alleviate depression and help improve your relationships. It''s good for your heart and immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. Kindness trumped good looks and financial prospects in women and men, without exception, in all cultures studied.', 'Buss, D.M. (1989) "Sex differences in human mate preference: evolutionary hypotheses tested in 37 countries." Behavioural and Brain Sciences, 12:1-49.', 0, 1, 0, '2015-03-26 00:40:08', '2015-03-26 00:40:08'),
(81, 0, 'VicHealth-6', 'Make a list of five favourite things in life outside of work. Choose one of these things and find a photo that represents this. Post the pic and comment describing what it means to you.', 'We can''t effectively support people, understand their needs or even connect if we don''t know something about what makes them tick. This kind of activity boosts our interests in others and helps us to understand one another better, which leads to more respectful relationships.', 'No more info...', 0, 1, 0, '2015-03-26 00:41:09', '2015-03-26 00:41:09'),
(82, 0, 'VicHealth-7', 'Find an opportunity to thank someone at work today who has had a positive influence on you. Be creative in how you thank them e.g. a card, letter, face to face etc.Post about how you thanked them and how they responded.', 'When gratitude and recognition is specific and deliberately delivered, it is even more motivating than money. It''s important to acknowledge the people who make a difference to our work life-it costs nothing to say thank you and the benefits are significant.', 'No more info...', 0, 1, 0, '2015-03-26 00:41:47', '2015-03-26 00:41:47'),
(83, 0, 'VicHealth-8', 'Take a photo of one thing that you think represents "juggling the demands of work and home life" and attach a caption to your picture. ', 'We all have a complex life outside of work and it can be difficult to manage the demands of both worlds. This activity helps people appreciate the various challenges we are all juggling in order to turn up and do a good job each day.', 'No more info...', 0, 1, 0, '2015-03-26 00:55:18', '2015-03-26 00:55:18'),
(84, 0, 'VicHealth-9', 'Think about what it means to TREAT EACH OTHER RESPECTFULLY AT WORK.  Complete this sentence below and post it on the On a Roll site: I really appreciate when my colleagues...take a photo of something that represents this.', 'Respect is a word that is often used-but what does it really mean day to day? Every workplace is different so it''s helpful for you to consider how respect is displayed where you work?', 'No more info...', 0, 1, 0, '2015-03-26 00:55:56', '2015-03-26 00:55:56'),
(85, 0, 'VicHealth-10', 'Think of an influential women in your life and post a sentence about what she means to you and why.', 'It''s helpful to consider the impact women have had on your life- as a son or a daughter, a student, a friend an employee or a partner. it''s important to broaden our view of the contributions women have made in the world.', 'No more info...', 0, 1, 0, '2015-03-26 00:56:30', '2015-03-26 00:56:30'),
(86, 0, 'VicHealth-11', 'Name something that shows FAIRNESS in your workplace or team. Upload a photo of what that looks like.', 'We all have different ideas about what constitutes fairness. For some it is treating people in the same way or helping with particular challenges to access the same opportunities. These are important things to think about and the basis of productive workplace conversations.', 'No more info...', 0, 1, 0, '2015-03-26 00:57:02', '2015-03-26 00:57:02'),
(87, 0, 'VicHealth-12', 'Think of a SUPPORTIVE comment you have heard someone make at work. Post something about what you thought, said or how you acted in this situation.', 'People respond a lot better to acknowledgement and support than they do to criticism.  People who offer support can make a huge difference in workplaces and assist in building an environment where everyone gets a fair go. Sometimes we just need some practice in being supportive.', 'No more info...', 0, 1, 0, '2015-03-26 00:57:38', '2015-03-26 00:57:38'),
(88, 0, 'VicHealth-13', 'What is one thing you really like doing that perhaps doesn''t fit with traditional gender roles or stereotypes of men and women in Australia? For example, something a man loves doing that usually isn''t associated with blokes.', 'Putting people in boxes and labelling them can be limiting. The old fashioned ideas about "what men should do" and "what women should do" are not helpful. They stop us from living and working together respectfully and they contribute to bigger problems such as mental illness, bullying and even violence against women.', 'No more info...', 0, 1, 0, '2015-03-26 00:58:11', '2015-03-26 00:58:11'),
(89, 0, 'VicHealth-14', 'Name one thing that your work could do more of to achieve equality and respect across the board, post what this is and why you have chosen this?  ', 'This is a chance to identify an area for improvement, not to lodge complaints. There are lots of small changes that could be made in any workplace to help generate solutions.', 'No more info...', 0, 1, 0, '2015-03-26 00:58:49', '2015-03-26 00:58:49'),
(90, 0, 'VicHealth-15', 'Tell us about the greatest parent you know, why are they so great? ', 'This is a chance to consider the contribution and extra effort that some parents make in changing the lives of those around them. It builds empathy and understanding that many people have many things to juggle in their home environment too.', 'No more info...', 0, 1, 0, '2015-03-26 01:03:01', '2015-03-26 01:03:01'),
(91, 0, 'VicHealth-16', 'Find an advertisement or article on gender equality that you really think makes a difference and post the link.  Also tell us why you choose this? ', 'This activity asks us to notice the impact of the media and journalism (even academia) on how we think about gender. It''s good to develop a critical eye when it comes to the messages we are sent about men and women.', 'No more info...', 0, 1, 0, '2015-03-26 01:03:40', '2015-03-26 01:03:40'),
(92, 0, 'VicHealth-17', 'What is one comment you could make in response to a sexist joke that doesn''t amuse you OR what are some of the best responses you have heard as a comeback to sexist comments?', 'What is one comment you could make in response to a sexist joke that doesn''t amuse you OR what are some of the best responses you have heard as a comeback to sexist comments?', 'No more info...', 0, 1, 0, '2015-03-26 01:04:17', '2015-03-26 01:04:17'),
(93, 0, 'VicHealth-18', 'What types of excuses do people give for making purely gender based decisions around who does what? EG: "That''s just what men and women are like." What else have you heard?', 'Many of the problems around gender come from inaccurate assumptions. It is useful to identify these and be on the look out for them in the workplace and beyond.', 'No more info...', 0, 1, 0, '2015-03-26 01:05:02', '2015-03-26 01:05:02'),
(94, 0, 'VicHealth-19', 'Think of a champion for gender equality in public life? Post a pic if you can and explain what they have done to inspire you.', 'We need positive role models and they come in all shapes and sizes. This activity can open people''s eyes to those in public life who are making a positive difference.', 'No more info...', 0, 1, 0, '2015-03-26 01:05:41', '2015-03-26 01:05:41'),
(95, 0, 'VicHealth-20', 'If someone makes a sexist comment, what is the likely reaction of the average person in your organisation?', 'We know that people are more likely to take action when they 1: Regard the incident as serious enough.2: See it as their responsibility to intervene 3: have confidence in their capacity 4: believe that their action will actually make a positive difference. This activity helps us step up and take some action when we see something unfair.', 'No more info...', 0, 1, 0, '2015-03-26 01:06:15', '2015-03-26 01:06:15'),
(96, 0, 'VicHealth-21', 'What are some of the most noticeable things you have got out of doing On A Roll 21? Was there a standout post from someone that you really enjoyed or got you thinking?', 'Thinking about the things you enjoy the most promotes optimism. Research suggests that optimism – the decision to view things in a positive or hopeful light – helps manage stress hormones and optimise wellbeing. Pessimists, by contrast, tend to have a higher stress baseline than optimists and had greater trouble dealing with stressful situations. Optimists are more protected in these circumstances.', 'No more info...', 0, 1, 0, '2015-03-26 01:06:58', '2015-03-26 01:06:58'),
(97, 0, 'stmon-1', '<p><span style="font-family:arial,sans,sans-serif">Today, it''s time to put your creative hat on and come up with a random act of ENERGY! Think of something that will provide your team, a colleague or your boss with a healthy, energy-boosting surprise. This could be an item of food or drink that you know will put a smile on their face, a happy surprise for the team or even a big acknowledgement of something that someone''s done recently that will be a welcome booster. Upload a picture of your surprise and a description of its energy boosting impact.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Kindness can make you happier, help alleviate depression and help improve your relationships. It''s good for your heart and your immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. It trumped good looks and financial prospects in women and men, without exception in all cultures.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Buss, D.M. (1989). "Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries", Behavioral & Brain Sciences, 12, 1-49.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:14:09', '2015-04-27 22:15:01'),
(98, 0, 'stmon-2', '<p><span style="font-family:arial,sans,sans-serif">Today, think of someone at St Monica''s who is a "quiet achiever", or someone who is a role model of the St Monica''s values and behaviours, and come up with a way to recognise their contribution to the team. You might send them a happy card, or find out what their favourite song, fruit or flower is, and send it to them! Even a big thank you (with some examples of the wonderful things they do) would be wonderful. Then, upload a picture that represents what you''ve done, or a link to a song, and a description explaining how they behave and how this makes them a role model, or just the positive impact they had today.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Positive reinforcement not only improves self-image, it can shape our behaviour. Recognising and rewarding desirable behaviour is a key to motivating us to work more productively.</span></p>\r\n', '<p><u><a class="in-cell-link" href="http://www.alnmag.com/articles/2010/04/using-positive-reinforcement-employee-motivation" target="_blank">http://www.alnmag.com/articles/2010/04/using-positive-reinforcement-employee-motivation</a></u></p>\r\n', 0, 1, 0, '2015-04-27 22:15:55', '2015-04-27 22:15:55'),
(99, 0, 'stmon-3', '<p><span style="font-family:arial,sans,sans-serif">Today, think of three things that you have either been putting off doing at work, or things that you know will make other people''s lives easier. Then, make a plan to do at least one of these things. How does it feel when you''ve achieved it? Upload a picture or song that captures the positive impact of your "can do" approach today.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Gaining a sense of accomplishment or achievement can contribute immensely to your overall send of wellbeing, while helping you to increase your productivity.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Seligman, M.E. Flourish. (2011) New York Press: New York.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:17:00', '2015-04-27 22:17:00'),
(100, 0, 'stmon-4', '<p><span style="font-family:arial,sans,sans-serif">Don''t you just love a performance review when you''re the one reviewing yourself? Reflecting on your work day today (or yesterday), describe one thing you did that made a positive difference and what St Monica''s values and behaviours this is aligned with. Or, if you''d prefer, write down five qualities that you would like to be remembered for by others. Choose one of these things and practise it today. Post a photo of something that represents the task, quality or outcome and describe it.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">When 577 volunteers were encouraged to practise a signature strength and use it each day for a week, they became significantly happier and less depressed than control groups.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Loehr, J., & Schwartz, T. (2003). The Power of Full Engagement: Managing Energy, Not Time, Is the Key to Performance and Personal Renewal. New York: Free Press, at 65.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:18:43', '2015-04-27 22:18:43'),
(101, 0, 'stmon-5', '<p><span style="font-family:arial,sans,sans-serif">Time to enter your own Cone of Silence! Using your calendar and/or phone, find a moment in your day to set aside an uninterrupted half hour, where you do not check nor respond to any emails or phone calls. Try to knock over a task that you need some quiet time to finish. Lock it in now before you get swept into the momentum of today''s demands. Briefly describe what you were able to achieve during that time and, if possible, a photo of what you achieved.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Gaining a sense of accomplishment or achievement can contribute immensely to your overall sense of wellbeing, while helping you to increase your productivity.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Seligman, M.E. Flourish. (2011) New York Press: New York.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:19:55', '2015-04-27 22:19:55'),
(102, 0, 'stmon-6', '<p><span style="font-family:arial,sans,sans-serif">Wouldn''t you know, today happens to be International No Complaints Day. Be extra attentive to how you communicate today and try your best to get through the whole day without complaining. At the end of the day, review how you went as honestly as you can. Post a comment describing one moment when you caught yourself complaining. What on earth could you have been complaining about?</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Excess and/or ineffective complaining can harm our mental health by promoting feelings of being helpless, hopeless, victimised, and generally bad about ourselves. Obviously, a one-off complaint won''t harm our mental health and there are effective, helpful ways to complain which can in fact be beneficial for mental health. But when the complaints accumulate through the day, our sense of helplessness can add up over time and impact our mood and self-esteem.</span></p>\r\n', '<p><u><a class="in-cell-link" href="http://www.psychologytoday.com/blog/the-squeaky-wheel/201201/does-complaining-damage-our-mental-health" target="_blank">http://www.psychologytoday.com/blog/the-squeaky-wheel/201201/does-complaining-damage-our-mental-health</a></u></p>\r\n', 0, 1, 0, '2015-04-27 22:20:46', '2015-04-27 22:20:46'),
(103, 0, 'stmon-7', '<p><span style="font-family:arial,sans,sans-serif">Gaze into your crystal ball and picture yourself being more successful three years from now. Visualise in detail not only what your life would look like in that state, but the steps and tasks you would be performing in order to attain this outcome. Post a photo of something this outcome represents: a place you might be or something that represents the feeling, commenting on what success would look like for you.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">While athletes have long practised visualising a successful outcome in order to attain their goals, psychologists have found that visualising the process is actually more effective as it helps focus attention on the steps needed to reach our goal, while also leading to reduced anxiety.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Pham LB, Taylor SE. From Thought to Action: Effects of Process-Versus Outcome-Based Mental Simulations on Performance. Pers Soc Psychol Bull February 1999 vol. 25 no. 2 250-260.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:22:01', '2015-04-27 22:22:01'),
(104, 0, 'stmon-8', '<p><span style="font-family:arial,sans,sans-serif">Share your favourite meme or inspirational quote that gave you a kick when you came across it.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">About 60 to 80 percent of people favour a visual learning style, and we are increasingly trained to utilise visual learning as technology adapts to meet busy lifestyles. Not surprisingly we are more likely be moved by or find meaning in a message if it is presented in a short, sharp, pictorial format.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Patricia Vakos. Why the Blank Stare? Strategies for Visual Learners. Pearson Education, Inc from, http://www.phschool.com/eteach/social_studies/2003_05/essay.html</span></p>\r\n', 0, 1, 0, '2015-04-27 22:23:08', '2015-04-27 22:23:08'),
(105, 0, 'stmon-9', '<p><span style="font-family:arial,sans,sans-serif">Find the opportunity today to unleash some random generosity on an unsuspecting person you work with, perhaps someone you don''t know very well or who is new to St Monica''s. You might offer to make them a coffee, give something away to them, offer to assist with a small task, etc. Comment on what you did and post a photo if you can.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Kindness can make you happier, help alleviate depression and help improve your relationships. It''s good for your heart and immune system, even helping you live longer. Studies also show that kindness is more attractive than good looks! That is the conclusion of a large study of 10,047 young people aged 20-25 from 33 different countries. Kindness trumped good looks and financial prospects in women and men, without exception, in all cultures studied.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Buss, D.M. (1989) "Sex differences in human mate preference: evolutionary hypothesis tested in 37 countries." Behavioural and Brain Sciences, 12:1-49.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:23:56', '2015-04-27 22:23:56'),
(106, 0, 'stmon-10', '<p><span style="font-family:arial,sans,sans-serif">Okay, it''s time to have some real fun! Today, think of an activity that will put a smile on people''s faces at work, eg: leave a (clean) joke on their desk, stick a poem on their coffee cup, send them a funny animal photo, and watch the invigorating, energy lifting effects take off! Take a photo or upload an image or song that captures the feeling you''ve created, describing what you did, and how it made you feel, too.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">In a study at the University of Nottingham, psychologists found that it''s the simple things in life that impacts most positively on our sense of wellbeing. The study compared the "happiness levels" of lottery jackpot winners with a control group, using a Satisfaction With Life Scale developed by the University of Illinois. Surprisingly, it wasn''t flashy cars and luxury mansions that upped the jackpot winners'' happiness quotient. It was listening to music, reading a book, or enjoying a bottle of wine with a takeaway that made a more significant difference.</span></p>\r\n', '<p><u><a class="in-cell-link" href="http://www.sciencedaily.com/releases/2007/11/071130224158.htm" target="_blank">http://www.sciencedaily.com/releases/2007/11/071130224158.htm</a></u></p>\r\n', 0, 1, 0, '2015-04-27 22:24:48', '2015-04-27 22:24:48'),
(107, 0, 'stmon-11', '<p><span style="font-family:arial,sans,sans-serif">Make a list of five things you''re most passionate about or simply your five favourite things in life outside of work. Choose one of these things and find a photo that represents this. Make it your desktop or phone wallpaper for the day or print it out and keep beside your desk or bed to remind you that passions count - in fact, they are integral to success. Post the pic and comment describing what it means to you.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Scientists have found that remembering the good times may be the secret to happiness and could be effective for increasing life satisfaction. This is good news because although it may be difficult to change your personality, you may be able to alter your view of time and boost your happiness. Evidence also shows that focusing on your passions, even when doing tasks you wouldn''t otherwise enjoy (eg if you''re into nature, then try reading that report you''ve been putting off while sitting under a tree or down by the river at lunchtime), helps you get things completed quickly and with fewer mistakes.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Zhang, J. & Howell, R. T. (2011). Do time perspectives predict unique variance in life satisfaction beyond personality traits? Personality and Individual Differences, 50, 1261 - 1266. Also, read about "Engagement" in the PERMA model espoused by Seligman, M in Flourish. (2011) New York Press: New York.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:25:50', '2015-04-27 22:25:50'),
(108, 0, 'stmon-12', '<p><span style="font-family:arial,sans,sans-serif">What''s something you''re really attached to on your desk that has some history for you? If there''s nothing you can think of, then try to find something else at work or at home that you feel positively attached to and use this instead. Upload a photo of the item and explain why you''re so attached to it or like it so much.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">According to psychologists from the University of Southampton, nostalgia is a psychological resource that protects and fosters mental health. It strengthens feelings of social connectedness and belongingness, and can reduce the feelings and repercussions of loneliness.</span></p>\r\n', '<p><u><a class="in-cell-link" href="http://www.southampton.ac.uk/mediacentre/news/2008/nov/08_212.shtml" target="_blank">http://www.southampton.ac.uk/mediacentre/news/2008/nov/08_212.shtml</a></u></p>\r\n', 0, 1, 0, '2015-04-27 22:26:37', '2015-04-27 22:26:37'),
(109, 0, 'stmon-13', '<p><span style="font-family:arial,sans,sans-serif">As your day begins, note down three things that you''re looking forward to the most. They can be any three things, work or non-work related. Then upload a picture that represents at least one of these things with a few words describing what it is. This will help improve your optimism, a key ingredient to reducing the negative impacts that stress can have on your body and mind.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Thinking about the things you are looking forward to the most promotes optimism. Research suggests that optimism - the decision to view things in a positive or hopeful light - helps manage stress hormones and optimise wellbeing. Pessimists, by contrast, tend to have a higher stress baseline than optimists and had greater trouble dealing with stressful situations. Optimists are more protected in these circumstances.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Posted by Rick Nauert PhD, July 24, 2013 at Psych Central. Optimism helps manage stress hormones. http://psychcentral.com/news/2013/07/24/optimism-helps-manage-stress-hormones/57543.html</span></p>', 0, 1, 0, '2015-04-27 22:27:30', '2015-04-27 22:27:30'),
(110, 0, 'stmon-14', '<p><span style="font-family:arial,sans,sans-serif">Find at least one opportunity to thank someone today for their efforts in front of another person. Remember to follow the elements of positive feedback. It must: (a) be task specific, (b) outline what they did and how they did it, and (c) be accurate and upbeat. Post about what you thanked them for and how they responded.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">When recognition is specific and deliberately delivered, it is even more motivating than money. It takes approximately three positive comments, expressions, or experiences to fend off the languishing effects of one negative. Dip below this and workplace performance suffers. Rise above it and teams produce their very best work.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Deci, E.L (1996). Why we do what we do. New York: Penguin.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:28:36', '2015-04-27 22:28:36'),
(111, 0, 'stmon-15', '<p><span style="font-family:arial,sans,sans-serif">Reconnect with a work colleague you haven''t spoken to in a long time and surprise them today with an email, note, card, phone call or visit to their desk. Post a pic of that person (if you have their permission) or something you associate with them, explaining their connection to you and what you like about them the most.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">When intrinsic recognition is specific and deliberately delivered, it is even more motivating than money. It takes approximately three positive comments, expressions or experiences to fend off the languishing effects of one negative one. Dip below this and workplace performance suffers. Rise above it and teams produce their very best work.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Grant AM. (2008) Does Intrinsic Motivation Fuel the Prosocial Fire? Motivational Synergy in Predicting Persistence, Performance, and Productivity. Journal of Applied Psychology. 93(1):48-58.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:29:27', '2015-04-27 22:29:27'),
(112, 0, 'stmon-16', '<p><span style="font-family:arial,sans,sans-serif">What you focus on grows. So it''s not surprising that people who develop a habit of thinking, speaking or acting negatively just get better at it. However, it''s not a good habit because negative mindsets are strongly linked to many undesirable outcomes including anger, sadness, hopelessness, anxiety and depression. Try this 3:1 ratio. For every negative thing you think, say or do today, balance it out with 3 positive thoughts, comments or actions. Don''t be mechanical about it. Recognise that you are doing this exercise to stimulate neuron growth, so be considered, intentional and authentic. Describe or post a picture that represents one positive thought you were able to introduce.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">In 2005 a team of scientists developed a simple formula (also known as the Losada ratio) where the ratio of three good thoughts to every negative thought that one experiences would produce a state of "flourishing" and limit the state of "languishing".</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Fredrickson BL, Losada M. (2005). Positive affect and the complex dynamics of human flourishing. American Psychologist, 60(7), 678-686.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:30:01', '2015-04-27 22:30:01'),
(113, 0, 'stmon-17', '<p><span style="font-family:arial,sans,sans-serif">At the end of the day, note down three of the most positive things that happened today. They can be any three things. Then upload a picture that represents at least one of these things with a few words describing what it was, and how you think the thing you''ve chosen, or its positive impacts, reflects Geelong Grammar''s Values and Behaviours.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">The science behind stopping to smell the roses is all to do with gratitude. To feel grateful for things in our lives is extremely health giving when practised with consistency. Gratitude helps alleviate depression, makes us happier and improves the quality of our relationships.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:30:43', '2015-04-27 22:30:43'),
(114, 0, 'stmon-18', '<p><span style="font-family:arial,sans,sans-serif">Ask a colleague what they identify as your Top 5 character strengths. Take a photo of something that represents one of them and put it in on obvious place on your workstation.</span></p>\r\n', '<p>...</p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Myers, D. (2000) The funds,friends and faith of happy people. American Psychologist, 55, 56-57.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:32:04', '2015-04-27 22:32:04'),
(115, 0, 'stmon-19', '<p><span style="font-family:arial,sans,sans-serif">Today is get off the couch or office chair and do something physical. (eg: walk up the stairs instead of taking the lift, go for a lunchtime walk, create a walking meeting etc.)</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Dr Ron Peterson, director of the Mayo Clinic''s Alzhiemer''s Disease Research Centre in the USA, says that any exercise that gets the heart pumping, assists with the prevention of Alzheimer''s disease, Parkinson''s disease and cognitive impairment itself.<br />\r\nAccording to Peterson, if one exercises 150 minutes a week, 50 minutes 3 times per week (a brisk walk alone will suffice) this will reduce the risk of cognitive decline for up to 18 months. (ref)</span></p>\r\n', '<p><u><a class="in-cell-link" href="http://www.nia.nih.gov/alzheimers/news" target="_blank">www.nia.nih.gov/alzheimers/news</a></u></p>\r\n', 0, 1, 0, '2015-04-27 22:32:37', '2015-04-27 22:32:37'),
(116, 0, 'stmon-20', '<p><span style="font-family:arial,sans,sans-serif">Name one thing you did that made a difference at work today. Take a photo of something that represents the benefit.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Employees in high performance organisations know their role and actions contribute to the organisation''s success and makes them better equipped to set priorities and make decisions.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Straw, B, Sutton, R & Pelled, L (1994) Employee positive emotion and favourable outcomes at the workplace. Organizational Science, 5, 51-71.</span></p>\r\n', 0, 1, 0, '2015-04-27 22:33:24', '2015-04-27 22:33:24'),
(117, 0, 'stmon-21', '<p><span style="font-family:arial,sans,sans-serif">Okay, it''s your last day of On a Roll 21! Time to appreciate some of the things you''ve seen in your group over the past 21 days. What is it about their posts that you admire the most? Upload a picture that represents your appreciation and a brief explanation of what the picture represents. Don''t be afraid to think outside the box!</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Thinking about the things you enjoy the most promotes optimism. Research suggests that optimism - the decision to view things in a positive or hopeful light - helps manage stress hormones and optimise wellbeing. Pessimists, by contrast, tend to have a higher stress baseline than optimists and had greater trouble dealing with stressful situations. Optimists are more protected in these circumstances.</span></p>\r\n', '<p><span style="font-family:arial,sans,sans-serif">Posted by Rick Nauert PhD, July 24, 2013 at Psych Central. Optimism helps manage stress hormones. http://psychcentral.com/news/2013/07/24/optimism-helps-manage-stress-hormones/57543.html</span></p>\r\n', 0, 1, 0, '2015-04-27 22:34:08', '2015-04-27 22:34:08');

-- --------------------------------------------------------

--
-- Table structure for table `task_score`
--

CREATE TABLE `task_score` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `score` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `task_score`
--

INSERT INTO `task_score` (`id`, `user_id`, `task_id`, `score`, `created_at`, `updated_at`) VALUES
(34, 2, 50, 4, '2015-01-20 04:35:02', '2015-01-20 04:35:02'),
(35, 2, 51, 4, '2015-01-20 04:39:00', '2015-01-20 04:39:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `screenhandle` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'VIC',
  `country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `organisation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L3VwbG9hZHMvcGl4L3VzZXIvZGVmYXVsdC5naWY=',
  `suspended` tinyint(1) NOT NULL,
  `suspend_after` int(1) NOT NULL DEFAULT '1',
  `warning_email_sent` int(1) NOT NULL,
  `notification` tinyint(1) NOT NULL DEFAULT '1',
  `notification_email` tinyint(1) NOT NULL DEFAULT '1',
  `notification_web` tinyint(1) NOT NULL DEFAULT '1',
  `push_notification` int(1) NOT NULL DEFAULT '1',
  `keycode` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` int(20) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `screenhandle`, `firstname`, `lastname`, `email`, `city`, `state`, `country`, `organisation`, `description`, `picture`, `suspended`, `suspend_after`, `warning_email_sent`, `notification`, `notification_email`, `notification_web`, `push_notification`, `keycode`, `last_login`, `created_at`, `updated_at`) VALUES
(2, 'barry.jenkin', '$2y$10$RdGnJgdpWAoAXRHCMSvHle44SALGbnY/ujjALI5TXo36JOzTUtnC2', 'Eddie', 'Barry', 'Jenkin', 'barry.jenkin@enmasse.com.au', 'South Yarra', 'VIC', 'AU', 'En Masse Pty Ltd', 'Sample description for barry updated once', 'L3VwbG9hZHMvcGl4L3VzZXIvYmFycnkuamVua2luLmpwZWc=', 0, 0, 1, 1, 0, 1, 0, '', 1438915074, '2014-01-07 22:10:14', '2015-08-07 22:00:08'),
(417, 'oar.test.01', '$2y$10$evvw8oz5UyJ0YpScJv0ls.VD.hLW9pvK1uiMkm6so0TBdJc9FmkcK', 'Roller 414', 'Test', '01', 'john.le@enmasse.com.au', '', 'VIC', '', '', '', 'L3VwbG9hZHMvcGl4L3VzZXIvZGVmYXVsdC5naWY=', 0, 1, 0, 1, 1, 1, 1, 'dev001', 0, '2015-08-28 02:18:34', '2015-08-28 02:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE `user_log` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_log`
--

INSERT INTO `user_log` (`id`, `user_id`, `type`, `created_at`, `updated_at`) VALUES
(3, 2, 'login', '2014-03-05 01:28:28', '2014-03-05 01:28:28'),
(12, 2, 'login', '2014-03-05 03:47:57', '2014-03-05 03:47:57'),
(15, 2, 'login', '2014-03-05 05:11:21', '2014-03-05 05:11:21'),
(21, 2, 'login', '2014-03-05 06:47:10', '2014-03-05 06:47:10'),
(50, 2, 'login', '2014-03-06 04:51:49', '2014-03-06 04:51:49'),
(55, 2, 'login', '2014-03-06 21:57:57', '2014-03-06 21:57:57'),
(61, 2, 'login', '2014-03-06 22:56:03', '2014-03-06 22:56:03'),
(99, 2, 'login', '2014-03-10 22:12:29', '2014-03-10 22:12:29'),
(100, 2, 'login', '2014-03-10 22:17:47', '2014-03-10 22:17:47'),
(107, 2, 'login', '2014-03-11 07:50:49', '2014-03-11 07:50:49'),
(110, 2, 'login', '2014-03-11 08:55:36', '2014-03-11 08:55:36'),
(118, 2, 'login', '2014-03-11 21:31:25', '2014-03-11 21:31:25'),
(121, 2, 'login', '2014-03-11 22:35:25', '2014-03-11 22:35:25'),
(128, 2, 'login', '2014-03-12 01:07:11', '2014-03-12 01:07:11'),
(132, 2, 'login', '2014-03-12 03:45:45', '2014-03-12 03:45:45'),
(154, 2, 'login', '2014-03-12 21:49:57', '2014-03-12 21:49:57'),
(160, 2, 'login', '2014-03-12 22:43:05', '2014-03-12 22:43:05'),
(162, 2, 'login', '2014-03-12 23:15:10', '2014-03-12 23:15:10'),
(168, 2, 'login', '2014-03-13 02:37:34', '2014-03-13 02:37:34'),
(174, 2, 'login', '2014-03-13 05:41:09', '2014-03-13 05:41:09'),
(190, 2, 'login', '2014-03-25 00:27:19', '2014-03-25 00:27:19'),
(192, 2, 'login', '2014-03-25 03:16:14', '2014-03-25 03:16:14'),
(193, 2, 'login', '2014-03-25 03:18:40', '2014-03-25 03:18:40'),
(195, 2, 'login', '2014-03-25 04:57:48', '2014-03-25 04:57:48'),
(198, 2, 'login', '2014-03-25 22:27:25', '2014-03-25 22:27:25'),
(199, 2, 'login', '2014-03-25 22:29:00', '2014-03-25 22:29:00'),
(201, 2, 'login', '2014-03-26 08:53:00', '2014-03-26 08:53:00'),
(202, 2, 'login', '2014-03-26 12:36:18', '2014-03-26 12:36:18'),
(205, 2, 'login', '2014-03-27 01:54:49', '2014-03-27 01:54:49'),
(206, 2, 'login', '2014-03-27 01:57:40', '2014-03-27 01:57:40'),
(211, 2, 'login', '2014-03-27 22:18:23', '2014-03-27 22:18:23'),
(212, 2, 'login', '2014-03-27 22:21:12', '2014-03-27 22:21:12'),
(214, 2, 'login', '2014-03-31 03:49:05', '2014-03-31 03:49:05'),
(215, 2, 'login', '2014-03-31 03:58:26', '2014-03-31 03:58:26'),
(217, 2, 'login', '2014-03-31 04:16:55', '2014-03-31 04:16:55'),
(226, 2, 'login', '2014-03-31 22:34:18', '2014-03-31 22:34:18'),
(235, 2, 'login', '2014-04-01 03:12:16', '2014-04-01 03:12:16'),
(236, 2, 'login', '2014-04-01 22:47:09', '2014-04-01 22:47:09'),
(239, 2, 'login', '2014-04-03 04:58:15', '2014-04-03 04:58:15'),
(240, 2, 'login', '2014-04-04 06:28:49', '2014-04-04 06:28:49'),
(242, 2, 'login', '2014-04-04 07:12:20', '2014-04-04 07:12:20'),
(250, 2, 'login', '2014-04-29 06:59:39', '2014-04-29 06:59:39'),
(254, 2, 'login', '2014-05-03 01:37:15', '2014-05-03 01:37:15'),
(266, 2, 'login', '2014-06-12 02:31:10', '2014-06-12 02:31:10'),
(269, 2, 'login', '2014-07-04 00:01:51', '2014-07-04 00:01:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_messages`
--

CREATE TABLE `user_messages` (
  `user_id` int(10) unsigned NOT NULL,
  `message_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_tasks`
--

CREATE TABLE `user_tasks` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `outcome_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `complete` int(11) NOT NULL DEFAULT '0',
  `times` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wellbeing_tracks`
--

CREATE TABLE `wellbeing_tracks` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `mood` int(2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=1435 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `wellbeing_tracks`
--

INSERT INTO `wellbeing_tracks` (`id`, `user_id`, `group_id`, `task_id`, `mood`, `created_at`, `updated_at`) VALUES
(797, 2, 17, 0, 4, '2015-03-19 09:36:26', '2015-03-19 09:36:26'),
(1234, 2, 17, 0, 3, '2015-05-12 06:43:53', '2015-05-12 06:43:53'),
(1409, 2, 29, 0, 5, '2015-08-07 02:37:54', '2015-08-07 02:37:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `capabilities`
--
ALTER TABLE `capabilities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_post_id_foreign` (`post_id`),
  ADD KEY `comments_user_id_foreign` (`user_id`);

--
-- Indexes for table `custom_user_token`
--
ALTER TABLE `custom_user_token`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feedback_user_id_foreign` (`user_id`);

--
-- Indexes for table `final_task`
--
ALTER TABLE `final_task`
  ADD UNIQUE KEY `task_id` (`outcome_id`),
  ADD KEY `final_task_task_id_foreign` (`task_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group_users`
--
ALTER TABLE `group_users`
  ADD PRIMARY KEY (`group_id`,`user_id`),
  ADD KEY `group_users_user_id_foreign` (`user_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `languages_locale_unique` (`locale`),
  ADD UNIQUE KEY `languages_name_unique` (`name`);

--
-- Indexes for table `language_entries`
--
ALTER TABLE `language_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `language_entries_language_id_namespace_group_item_unique` (`language_id`,`namespace`,`group`,`item`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_foreign` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_from_foreign` (`from`),
  ADD KEY `messages_to_foreign` (`to`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `outcomes`
--
ALTER TABLE `outcomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `outcome_history`
--
ALTER TABLE `outcome_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `outcome_tasks`
--
ALTER TABLE `outcome_tasks`
  ADD PRIMARY KEY (`outcome_id`,`task_id`),
  ADD KEY `outcome_tasks_task_id_foreign` (`task_id`);

--
-- Indexes for table `outcome_tasks_sorting`
--
ALTER TABLE `outcome_tasks_sorting`
  ADD KEY `outcome_tasks_sorting_outcome_id_foreign` (`outcome_id`),
  ADD KEY `outcome_tasks_sorting_task_id_foreign` (`task_id`);

--
-- Indexes for table `password_reminders`
--
ALTER TABLE `password_reminders`
  ADD KEY `password_reminders_email_index` (`email`),
  ADD KEY `password_reminders_token_index` (`token`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_group_id_foreign` (`group_id`),
  ADD KEY `posts_user_id_foreign` (`user_id`),
  ADD KEY `posts_task_id_foreign` (`task_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_assignments`
--
ALTER TABLE `role_assignments`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_assignments_role_id_foreign` (`role_id`);

--
-- Indexes for table `role_capabilities`
--
ALTER TABLE `role_capabilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_capabilities_role_id_foreign` (`role_id`),
  ADD KEY `role_capabilities_capability_id_foreign` (`capability_id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `surveys`
--
ALTER TABLE `surveys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey_messages`
--
ALTER TABLE `survey_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_messages_survey_id_foreign` (`survey_id`);

--
-- Indexes for table `survey_response`
--
ALTER TABLE `survey_response`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_response_user_id_foreign` (`user_id`),
  ADD KEY `survey_response_group_id_foreign` (`group_id`),
  ADD KEY `survey_response_survey_id_foreign` (`survey_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_score`
--
ALTER TABLE `task_score`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_score_user_id_foreign` (`user_id`),
  ADD KEY `task_score_task_id_foreign` (`task_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_log_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_messages`
--
ALTER TABLE `user_messages`
  ADD KEY `user_messages_user_id_foreign` (`user_id`),
  ADD KEY `user_messages_message_id_foreign` (`message_id`);

--
-- Indexes for table `user_tasks`
--
ALTER TABLE `user_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_tasks_group_id_foreign` (`group_id`),
  ADD KEY `user_tasks_outcome_id_foreign` (`outcome_id`),
  ADD KEY `user_tasks_task_id_foreign` (`task_id`);

--
-- Indexes for table `wellbeing_tracks`
--
ALTER TABLE `wellbeing_tracks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wellbeing_tracks_user_id_foreign` (`user_id`),
  ADD KEY `wellbeing_tracks_group_id_foreign` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `capabilities`
--
ALTER TABLE `capabilities`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=42;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=327;
--
-- AUTO_INCREMENT for table `custom_user_token`
--
ALTER TABLE `custom_user_token`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=107;
--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `language_entries`
--
ALTER TABLE `language_entries`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=612;
--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=418;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=153;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `outcomes`
--
ALTER TABLE `outcomes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `outcome_history`
--
ALTER TABLE `outcome_history`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1097;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `role_capabilities`
--
ALTER TABLE `role_capabilities`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `surveys`
--
ALTER TABLE `surveys`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `survey_messages`
--
ALTER TABLE `survey_messages`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `survey_response`
--
ALTER TABLE `survey_response`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=468;
--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=118;
--
-- AUTO_INCREMENT for table `task_score`
--
ALTER TABLE `task_score`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=418;
--
-- AUTO_INCREMENT for table `user_log`
--
ALTER TABLE `user_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=270;
--
-- AUTO_INCREMENT for table `user_tasks`
--
ALTER TABLE `user_tasks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `wellbeing_tracks`
--
ALTER TABLE `wellbeing_tracks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1435;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `final_task`
--
ALTER TABLE `final_task`
  ADD CONSTRAINT `final_task_outcome_id_foreign` FOREIGN KEY (`outcome_id`) REFERENCES `outcomes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `final_task_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_users`
--
ALTER TABLE `group_users`
  ADD CONSTRAINT `group_users_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `language_entries`
--
ALTER TABLE `language_entries`
  ADD CONSTRAINT `language_entries_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_from_foreign` FOREIGN KEY (`from`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_to_foreign` FOREIGN KEY (`to`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `outcome_tasks`
--
ALTER TABLE `outcome_tasks`
  ADD CONSTRAINT `outcome_tasks_outcome_id_foreign` FOREIGN KEY (`outcome_id`) REFERENCES `outcomes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `outcome_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `outcome_tasks_sorting`
--
ALTER TABLE `outcome_tasks_sorting`
  ADD CONSTRAINT `outcome_tasks_sorting_outcome_id_foreign` FOREIGN KEY (`outcome_id`) REFERENCES `outcomes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `outcome_tasks_sorting_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_assignments`
--
ALTER TABLE `role_assignments`
  ADD CONSTRAINT `role_assignments_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_assignments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_capabilities`
--
ALTER TABLE `role_capabilities`
  ADD CONSTRAINT `role_capabilities_capability_id_foreign` FOREIGN KEY (`capability_id`) REFERENCES `capabilities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_capabilities_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `survey_messages`
--
ALTER TABLE `survey_messages`
  ADD CONSTRAINT `survey_messages_survey_id_foreign` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `survey_response`
--
ALTER TABLE `survey_response`
  ADD CONSTRAINT `survey_response_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `survey_response_survey_id_foreign` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `survey_response_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `task_score`
--
ALTER TABLE `task_score`
  ADD CONSTRAINT `task_score_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_score_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_log`
--
ALTER TABLE `user_log`
  ADD CONSTRAINT `user_log_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_messages`
--
ALTER TABLE `user_messages`
  ADD CONSTRAINT `user_messages_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wellbeing_tracks`
--
ALTER TABLE `wellbeing_tracks`
  ADD CONSTRAINT `wellbeing_tracks_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wellbeing_tracks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
