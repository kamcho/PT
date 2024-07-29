-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2024 at 03:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kevin254$default`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 6, 'add_logentry'),
(2, 'Can change log entry', 6, 'change_logentry'),
(3, 'Can delete log entry', 6, 'delete_logentry'),
(4, 'Can view log entry', 6, 'view_logentry'),
(5, 'Can add permission', 7, 'add_permission'),
(6, 'Can change permission', 7, 'change_permission'),
(7, 'Can delete permission', 7, 'delete_permission'),
(8, 'Can view permission', 7, 'view_permission'),
(9, 'Can add group', 8, 'add_group'),
(10, 'Can change group', 8, 'change_group'),
(11, 'Can delete group', 8, 'delete_group'),
(12, 'Can view group', 8, 'view_group'),
(13, 'Can add content type', 9, 'add_contenttype'),
(14, 'Can change content type', 9, 'change_contenttype'),
(15, 'Can delete content type', 9, 'delete_contenttype'),
(16, 'Can view content type', 9, 'view_contenttype'),
(17, 'Can add session', 10, 'add_session'),
(18, 'Can change session', 10, 'change_session'),
(19, 'Can delete session', 10, 'delete_session'),
(20, 'Can view session', 10, 'view_session'),
(21, 'Can add grade', 11, 'add_grade'),
(22, 'Can change grade', 11, 'change_grade'),
(23, 'Can delete grade', 11, 'delete_grade'),
(24, 'Can view grade', 11, 'view_grade'),
(25, 'Can add my user', 1, 'add_myuser'),
(26, 'Can change my user', 1, 'change_myuser'),
(27, 'Can delete my user', 1, 'delete_myuser'),
(28, 'Can view my user', 1, 'view_myuser'),
(29, 'Can add personal profile', 12, 'add_personalprofile'),
(30, 'Can change personal profile', 12, 'change_personalprofile'),
(31, 'Can delete personal profile', 12, 'delete_personalprofile'),
(32, 'Can view personal profile', 12, 'view_personalprofile'),
(33, 'Can add academic profile', 13, 'add_academicprofile'),
(34, 'Can change academic profile', 13, 'change_academicprofile'),
(35, 'Can delete academic profile', 13, 'delete_academicprofile'),
(36, 'Can view academic profile', 13, 'view_academicprofile'),
(37, 'Can add guardian', 2, 'add_guardian'),
(38, 'Can change guardian', 2, 'change_guardian'),
(39, 'Can delete guardian', 2, 'delete_guardian'),
(40, 'Can view guardian', 2, 'view_guardian'),
(41, 'Can add student', 3, 'add_student'),
(42, 'Can change student', 3, 'change_student'),
(43, 'Can delete student', 3, 'delete_student'),
(44, 'Can view student', 3, 'view_student'),
(45, 'Can add supervisor', 4, 'add_supervisor'),
(46, 'Can change supervisor', 4, 'change_supervisor'),
(47, 'Can delete supervisor', 4, 'delete_supervisor'),
(48, 'Can view supervisor', 4, 'view_supervisor'),
(49, 'Can add teacher', 5, 'add_teacher'),
(50, 'Can change teacher', 5, 'change_teacher'),
(51, 'Can delete teacher', 5, 'delete_teacher'),
(52, 'Can view teacher', 5, 'view_teacher'),
(53, 'Can add course', 14, 'add_course'),
(54, 'Can change course', 14, 'change_course'),
(55, 'Can delete course', 14, 'delete_course'),
(56, 'Can view course', 14, 'view_course'),
(57, 'Can add subject', 15, 'add_subject'),
(58, 'Can change subject', 15, 'change_subject'),
(59, 'Can delete subject', 15, 'delete_subject'),
(60, 'Can view subject', 15, 'view_subject'),
(61, 'Can add my subjects', 16, 'add_mysubjects'),
(62, 'Can change my subjects', 16, 'change_mysubjects'),
(63, 'Can delete my subjects', 16, 'delete_mysubjects'),
(64, 'Can view my subjects', 16, 'view_mysubjects'),
(65, 'Can add topic', 17, 'add_topic'),
(66, 'Can change topic', 17, 'change_topic'),
(67, 'Can delete topic', 17, 'delete_topic'),
(68, 'Can view topic', 17, 'view_topic'),
(69, 'Can add subtopic', 18, 'add_subtopic'),
(70, 'Can change subtopic', 18, 'change_subtopic'),
(71, 'Can delete subtopic', 18, 'delete_subtopic'),
(72, 'Can view subtopic', 18, 'view_subtopic'),
(73, 'Can add progress', 19, 'add_progress'),
(74, 'Can change progress', 19, 'change_progress'),
(75, 'Can delete progress', 19, 'delete_progress'),
(76, 'Can view progress', 19, 'view_progress'),
(77, 'Can add topic exam notifications', 20, 'add_topicexamnotifications'),
(78, 'Can change topic exam notifications', 20, 'change_topicexamnotifications'),
(79, 'Can delete topic exam notifications', 20, 'delete_topicexamnotifications'),
(80, 'Can view topic exam notifications', 20, 'view_topicexamnotifications'),
(81, 'Can add topical exam results', 21, 'add_topicalexamresults'),
(82, 'Can change topical exam results', 21, 'change_topicalexamresults'),
(83, 'Can delete topical exam results', 21, 'delete_topicalexamresults'),
(84, 'Can view topical exam results', 21, 'view_topicalexamresults'),
(85, 'Can add payment notifications', 22, 'add_paymentnotifications'),
(86, 'Can change payment notifications', 22, 'change_paymentnotifications'),
(87, 'Can delete payment notifications', 22, 'delete_paymentnotifications'),
(88, 'Can view payment notifications', 22, 'view_paymentnotifications'),
(89, 'Can add account inquiries', 23, 'add_accountinquiries'),
(90, 'Can change account inquiries', 23, 'change_accountinquiries'),
(91, 'Can delete account inquiries', 23, 'delete_accountinquiries'),
(92, 'Can view account inquiries', 23, 'view_accountinquiries'),
(93, 'Can add prompt', 24, 'add_prompt'),
(94, 'Can change prompt', 24, 'change_prompt'),
(95, 'Can delete prompt', 24, 'delete_prompt'),
(96, 'Can view prompt', 24, 'view_prompt'),
(97, 'Can add completion', 25, 'add_completion'),
(98, 'Can change completion', 25, 'change_completion'),
(99, 'Can delete completion', 25, 'delete_completion'),
(100, 'Can view completion', 25, 'view_completion'),
(101, 'Can add rate limiter', 26, 'add_ratelimiter'),
(102, 'Can change rate limiter', 26, 'change_ratelimiter'),
(103, 'Can delete rate limiter', 26, 'delete_ratelimiter'),
(104, 'Can view rate limiter', 26, 'view_ratelimiter'),
(105, 'Can add topical quizes', 27, 'add_topicalquizes'),
(106, 'Can change topical quizes', 27, 'change_topicalquizes'),
(107, 'Can delete topical quizes', 27, 'delete_topicalquizes'),
(108, 'Can view topical quizes', 27, 'view_topicalquizes'),
(109, 'Can add topical quiz answers', 28, 'add_topicalquizanswers'),
(110, 'Can change topical quiz answers', 28, 'change_topicalquizanswers'),
(111, 'Can delete topical quiz answers', 28, 'delete_topicalquizanswers'),
(112, 'Can view topical quiz answers', 28, 'view_topicalquizanswers'),
(113, 'Can add student test', 29, 'add_studenttest'),
(114, 'Can change student test', 29, 'change_studenttest'),
(115, 'Can delete student test', 29, 'delete_studenttest'),
(116, 'Can view student test', 29, 'view_studenttest'),
(117, 'Can add general test', 30, 'add_generaltest'),
(118, 'Can change general test', 30, 'change_generaltest'),
(119, 'Can delete general test', 30, 'delete_generaltest'),
(120, 'Can view general test', 30, 'view_generaltest'),
(121, 'Can add class test', 31, 'add_classtest'),
(122, 'Can change class test', 31, 'change_classtest'),
(123, 'Can delete class test', 31, 'delete_classtest'),
(124, 'Can view class test', 31, 'view_classtest'),
(125, 'Can add class test student test', 32, 'add_classteststudenttest'),
(126, 'Can change class test student test', 32, 'change_classteststudenttest'),
(127, 'Can delete class test student test', 32, 'delete_classteststudenttest'),
(128, 'Can view class test student test', 32, 'view_classteststudenttest'),
(129, 'Can add students answers', 33, 'add_studentsanswers'),
(130, 'Can change students answers', 33, 'change_studentsanswers'),
(131, 'Can delete students answers', 33, 'delete_studentsanswers'),
(132, 'Can view students answers', 33, 'view_studentsanswers'),
(133, 'Can add my kids', 34, 'add_mykids'),
(134, 'Can change my kids', 34, 'change_mykids'),
(135, 'Can delete my kids', 34, 'delete_mykids'),
(136, 'Can view my kids', 34, 'view_mykids'),
(137, 'Can add teacher profile', 35, 'add_teacherprofile'),
(138, 'Can change teacher profile', 35, 'change_teacherprofile'),
(139, 'Can delete teacher profile', 35, 'delete_teacherprofile'),
(140, 'Can view teacher profile', 35, 'view_teacherprofile'),
(141, 'Can add teacher ranking', 36, 'add_teacherranking'),
(142, 'Can change teacher ranking', 36, 'change_teacherranking'),
(143, 'Can delete teacher ranking', 36, 'delete_teacherranking'),
(144, 'Can view teacher ranking', 36, 'view_teacherranking'),
(145, 'Can add student list', 37, 'add_studentlist'),
(146, 'Can change student list', 37, 'change_studentlist'),
(147, 'Can delete student list', 37, 'delete_studentlist'),
(148, 'Can view student list', 37, 'view_studentlist'),
(149, 'Can add session booking', 38, 'add_sessionbooking'),
(150, 'Can change session booking', 38, 'change_sessionbooking'),
(151, 'Can delete session booking', 38, 'delete_sessionbooking'),
(152, 'Can view session booking', 38, 'view_sessionbooking'),
(153, 'Can add updates', 39, 'add_updates'),
(154, 'Can change updates', 39, 'change_updates'),
(155, 'Can delete updates', 39, 'delete_updates'),
(156, 'Can view updates', 39, 'view_updates'),
(157, 'Can add file model', 40, 'add_filemodel'),
(158, 'Can change file model', 40, 'change_filemodel'),
(159, 'Can delete file model', 40, 'delete_filemodel'),
(160, 'Can view file model', 40, 'view_filemodel'),
(161, 'Can add question count', 41, 'add_questioncount'),
(162, 'Can change question count', 41, 'change_questioncount'),
(163, 'Can delete question count', 41, 'delete_questioncount'),
(164, 'Can view question count', 41, 'view_questioncount'),
(165, 'Can add quiz assignment', 42, 'add_quizassignment'),
(166, 'Can change quiz assignment', 42, 'change_quizassignment'),
(167, 'Can delete quiz assignment', 42, 'delete_quizassignment'),
(168, 'Can view quiz assignment', 42, 'view_quizassignment'),
(169, 'Can add inquire', 43, 'add_inquire'),
(170, 'Can change inquire', 43, 'change_inquire'),
(171, 'Can delete inquire', 43, 'delete_inquire'),
(172, 'Can view inquire', 43, 'view_inquire'),
(173, 'Can add log entry', 44, 'add_logentry'),
(174, 'Can change log entry', 44, 'change_logentry'),
(175, 'Can delete log entry', 44, 'delete_logentry'),
(176, 'Can view log entry', 44, 'view_logentry'),
(177, 'Can add subscriptions', 45, 'add_subscriptions'),
(178, 'Can change subscriptions', 45, 'change_subscriptions'),
(179, 'Can delete subscriptions', 45, 'delete_subscriptions'),
(180, 'Can view subscriptions', 45, 'view_subscriptions'),
(181, 'Can add my subscription', 46, 'add_mysubscription'),
(182, 'Can change my subscription', 46, 'change_mysubscription'),
(183, 'Can delete my subscription', 46, 'delete_mysubscription'),
(184, 'Can view my subscription', 46, 'view_mysubscription'),
(185, 'Can add stripe card payments', 47, 'add_stripecardpayments'),
(186, 'Can change stripe card payments', 47, 'change_stripecardpayments'),
(187, 'Can delete stripe card payments', 47, 'delete_stripecardpayments'),
(188, 'Can view stripe card payments', 47, 'view_stripecardpayments'),
(189, 'Can add mpesa payments', 48, 'add_mpesapayments'),
(190, 'Can change mpesa payments', 48, 'change_mpesapayments'),
(191, 'Can delete mpesa payments', 48, 'delete_mpesapayments'),
(192, 'Can view mpesa payments', 48, 'view_mpesapayments'),
(193, 'Can add pending payment', 49, 'add_pendingpayment'),
(194, 'Can change pending payment', 49, 'change_pendingpayment'),
(195, 'Can delete pending payment', 49, 'delete_pendingpayment'),
(196, 'Can view pending payment', 49, 'view_pendingpayment');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-07-06 20:24:55.754713', '1', 'teacher1@gmail.com', 2, '[]', 1, 2),
(3, '2024-07-06 20:28:50.043583', '1', 'teacher1@gmail.com', 3, '', 1, 2),
(4, '2024-07-06 20:36:58.881551', '1', 'teacher1@gmail.com', 1, '[{\"added\": {}}]', 42, 2),
(5, '2024-07-13 15:01:20.940295', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(6, '2024-07-16 11:51:39.685391', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(7, '2024-07-16 19:03:34.723556', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(8, '2024-07-16 19:59:04.548070', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(9, '2024-07-18 00:50:53.320979', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(10, '2024-07-18 01:12:41.796113', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(11, '2024-07-19 10:35:27.248432', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(12, '2024-07-19 12:16:59.925780', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(13, '2024-07-19 13:13:11.363521', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(14, '2024-07-22 00:44:12.788949', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(15, '2024-07-22 12:10:56.844140', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(16, '2024-07-23 21:51:08.985689', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(17, '2024-07-23 21:51:16.022312', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(18, '2024-07-23 22:56:19.916771', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(19, '2024-07-24 10:04:54.587596', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(20, '2024-07-24 10:27:30.121973', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(21, '2024-07-24 12:25:35.628067', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(22, '2024-07-25 08:17:39.545600', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(23, '2024-07-25 10:38:45.679913', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(24, '2024-07-25 11:01:57.658933', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(25, '2024-07-25 11:45:29.683319', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(26, '2024-07-25 12:39:06.405912', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(27, '2024-07-26 08:26:00.113169', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(28, '2024-07-29 09:53:41.650102', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(29, '2024-07-29 10:32:54.633291', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2),
(30, '2024-07-29 11:06:17.567024', '1', 'teacher1@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Topic\"]}}]', 42, 2);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(6, 'admin', 'logentry'),
(8, 'auth', 'group'),
(7, 'auth', 'permission'),
(9, 'contenttypes', 'contenttype'),
(31, 'Exams', 'classtest'),
(32, 'Exams', 'classteststudenttest'),
(30, 'Exams', 'generaltest'),
(33, 'Exams', 'studentsanswers'),
(29, 'Exams', 'studenttest'),
(28, 'Exams', 'topicalquizanswers'),
(27, 'Exams', 'topicalquizes'),
(34, 'Guardian', 'mykids'),
(44, 'Logs', 'logentry'),
(10, 'sessions', 'session'),
(23, 'SubjectList', 'accountinquiries'),
(25, 'SubjectList', 'completion'),
(14, 'SubjectList', 'course'),
(16, 'SubjectList', 'mysubjects'),
(22, 'SubjectList', 'paymentnotifications'),
(19, 'SubjectList', 'progress'),
(24, 'SubjectList', 'prompt'),
(26, 'SubjectList', 'ratelimiter'),
(15, 'SubjectList', 'subject'),
(18, 'SubjectList', 'subtopic'),
(17, 'SubjectList', 'topic'),
(21, 'SubjectList', 'topicalexamresults'),
(20, 'SubjectList', 'topicexamnotifications'),
(48, 'Subscription', 'mpesapayments'),
(46, 'Subscription', 'mysubscription'),
(49, 'Subscription', 'pendingpayment'),
(47, 'Subscription', 'stripecardpayments'),
(45, 'Subscription', 'subscriptions'),
(40, 'Supervisor', 'filemodel'),
(43, 'Supervisor', 'inquire'),
(41, 'Supervisor', 'questioncount'),
(42, 'Supervisor', 'quizassignment'),
(39, 'Supervisor', 'updates'),
(38, 'Teacher', 'sessionbooking'),
(37, 'Teacher', 'studentlist'),
(35, 'Teacher', 'teacherprofile'),
(36, 'Teacher', 'teacherranking'),
(13, 'Users', 'academicprofile'),
(11, 'Users', 'grade'),
(2, 'Users', 'guardian'),
(1, 'Users', 'myuser'),
(12, 'Users', 'personalprofile'),
(3, 'Users', 'student'),
(4, 'Users', 'supervisor'),
(5, 'Users', 'teacher');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'Users', '0001_initial', '2024-07-06 13:40:19.248999'),
(2, 'contenttypes', '0001_initial', '2024-07-06 13:40:20.076868'),
(3, 'admin', '0001_initial', '2024-07-06 13:40:22.962286'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-07-06 13:40:23.030716'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-07-06 13:40:23.163331'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-07-06 13:40:25.184165'),
(7, 'auth', '0001_initial', '2024-07-06 13:40:29.819096'),
(8, 'auth', '0002_alter_permission_name_max_length', '2024-07-06 13:40:30.898002'),
(9, 'auth', '0003_alter_user_email_max_length', '2024-07-06 13:40:31.121952'),
(10, 'auth', '0004_alter_user_username_opts', '2024-07-06 13:40:31.218392'),
(11, 'auth', '0005_alter_user_last_login_null', '2024-07-06 13:40:31.289120'),
(12, 'auth', '0006_require_contenttypes_0002', '2024-07-06 13:40:31.327646'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2024-07-06 13:40:31.399049'),
(14, 'auth', '0008_alter_user_username_max_length', '2024-07-06 13:40:31.463119'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2024-07-06 13:40:31.503450'),
(16, 'auth', '0010_alter_group_name_max_length', '2024-07-06 13:40:31.611270'),
(17, 'auth', '0011_update_proxy_permissions', '2024-07-06 13:40:31.879113'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2024-07-06 13:40:31.935715'),
(19, 'sessions', '0001_initial', '2024-07-06 13:40:32.721504'),
(20, 'SubjectList', '0001_initial', '2024-07-06 13:41:56.517209'),
(21, 'Exams', '0001_initial', '2024-07-06 20:17:32.586046'),
(22, 'Teacher', '0001_initial', '2024-07-06 20:18:34.276582'),
(23, 'Supervisor', '0001_initial', '2024-07-06 20:20:12.250128'),
(24, 'Users', '0002_alter_myuser_is_active', '2024-07-06 20:23:40.269434'),
(25, 'Exams', '0002_alter_classtest_class_id', '2024-07-06 20:25:54.851084'),
(26, 'Guardian', '0001_initial', '2024-07-06 20:26:42.966771'),
(27, 'Subscription', '0001_initial', '2024-07-06 20:27:41.142237'),
(28, 'Logs', '0001_initial', '2024-07-06 20:28:39.974287');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0oxaykv3sva3p2oy616wpd6i2fvvzgc8', '.eJxVjEEOwiAQRe_C2pCKMB1cuu8ZyMAwUjU0Ke3KeHdD0oVu_3vvv1WgfSthb3kNM6urMur0u0VKz1w74AfV-6LTUrd1jror-qBNTwvn1-1w_w4KtdLr8QKeIyE4SziwoPOE5ARsTgKjlYHPLAZIxEdAQTQoTiJ4b9GA-nwB-Lk4Qg:1sQBxJ:yz4n22thVo_ZgkWIwEDrtYRE5udqtlx5T4oyLDS0uxs', '2024-07-20 20:24:25.948222'),
('6b2uxadd3z4fqqqb6j6bj9uuimdtj8qi', '.eJxVjEEOwiAQRe_C2pCKMB1cuu8ZyMAwUjU0Ke3KeHdD0oVu_3vvv1WgfSthb3kNM6urMur0u0VKz1w74AfV-6LTUrd1jror-qBNTwvn1-1w_w4KtdLr8QKeIyE4SziwoPOE5ARsTgKjlYHPLAZIxEdAQTQoTiJ4b9GA-nwB-Lk4Qg:1sSeF7:YdSEh0QE1jafo-LQdX0ULJvN5gI_oZWr7MZ7Oe0PM5w', '2024-07-27 15:00:57.860268'),
('enne5thbgoaj9k18zua99z6c04f4atj5', '.eJxVj0tvwjAQhP8K8rmO_I7h2HvPvVSKdv0ogRBTEkttEf-9GymocFt9OzM7e2Ud1Hnf1Slduj6yHdPs5ZEhhGMal0U8wPhZmlDG-dJjs0iadTs1byWm4XXVPgXsYdqTG0Ggkj46DwZVMABWWKsiTVZvZXSy9YjBIBqpjVQCrA_KK_CwRZcdhX7V_rfrx1zY7sqmiocU5rXwXM59oFl6lXLQkm-9itwE6zg6aLnI2WjUpvUeSE7mu6OFaJVpIw8ieW4wRu6BHNJ6q3MWXsq83ib1e7kcN6XOG6k-qqCPGtqlbzh18885sd1Yh-FG-Wmgbn0Z_-veiVxaGsMeRIqQeiJ6ecs9EkPEsdvtD0Fwhlo:1sWNjl:lFRzXZQliGu8P2VVGPwdNS_QykLO45r1d8U_i8B95JU', '2024-08-06 22:12:01.445937'),
('fyxb4wroc5hdtmwl8rbzb7j3bi1hk45a', '.eJxVjDsOwjAQRO_iGln-s6GkzxmsXa_BAWRLcVIh7k4ipYBuNO_NvEXEdSlx7XmOE4uLsOL02xGmZ6474AfWe5Op1WWeSO6KPGiXY-P8uh7u30HBXrY1oSKjgQOgI5McolfeG96St4PmoM9AlByR09Zpo9BDMmAQcKBwC-LzBeN4N64:1sWN6o:jUp9QbBOPYqlGlsIKH5p6nE3mznv7Fx8VaJRqWPpAB8', '2024-08-06 21:31:46.215531'),
('oqcrbwv27bnjhms8r9zvrps0l1poai4k', '.eJxVj0FOwzAQRa8SeY0j23ESuxsQezZcIBrbkyYltUviSEDVuzOBVtCd9eb9P54zO8I4sR3LCH7AWT7tN1D6dGQPrIM1D9264NyNgaTqnjnwbxi3QThA3CdKxTyPrtyU8jpdypcUcHq-uncFAywDpR0Ip6QJjQHtlNcAtahrFehVV1aGRrbGOa-d07LSUgmojVdGgQHrmr6h0vd1_OrG2Ce2O7NldQf0mZoljXI6jX7boqDRAVre9uC5tlZyq73kQVAvaNlApUmn8C2B2FqnWuTaO8t1CJZbExyHVjjvahOkuu0m-zWtMRSpL2QhpChyKvKARUSYcclFxrgUj2TjBxy7_HlCtovrNF1oI0702zHFvwNuRG43bHXsn6Z-obqDFcFts7ij-keVBC-XbxCVmIw:1sR6Xk:OlACiKo4PFJyhAI8l5A8Z30UjWmzAO9V0ejpxpioK-0', '2024-07-23 08:49:48.508627'),
('qvbpxdfdm7h65dpumtc5dge0p1qevtsm', '.eJxVjEEOwiAQRe_C2pCKMB1cuu8ZyMAwUjU0Ke3KeHdD0oVu_3vvv1WgfSthb3kNM6urMur0u0VKz1w74AfV-6LTUrd1jror-qBNTwvn1-1w_w4KtdLr8QKeIyE4SziwoPOE5ARsTgKjlYHPLAZIxEdAQTQoTiJ4b9GA-nwB-Lk4Qg:1sWNNb:pR_CExzvDPt9OoNrFss4Z7HOZZsce959H7a1TzXOXqU', '2024-08-06 21:49:07.445010'),
('w862shidraoy1xxf4kck99sq7r6z7p6q', '.eJxVkElSwzAQRa-i0hq5LFmS5WwoWLHhDK7WYFvgSMFDIKRyd9pFGLLrev3_7-FMW1iXoV3nMLXR0x2t6N1_ZsG9hrQ1_AukPhcup2WKttgkxbU7F8_Zh_Hxqr0JGGAe0G2htIIbrw1IK5wEUKVSwmOlqoZ7zWtjrZPWSl5JLkpQxgkjwEBjdacx9G2Nn21MXaa7M51X-xLcgskcW0s-RLdNEaClh5rVHTgmm4azRjrOfIm5ILmGSqIczT-ORtUlh1owGWzHJLeaGdUZ1gEH4E45Z_11NqofyAGmkBaCV5E5HEMiboijR1aQp0B6OAYSwA3fmBhDZizGmPqZdHkifc6e2DDAMeYJLfmd7FeU73MKJ_KOqX3cUvO6kHucGz5g3y6nQ6C7tI7jBXcPI94dc_p7xQ_huKHm26t-kUCkblGFqL5FEpHh9HL5ArmuqLU:1sXGOr:IticZxIsDO6lSUYfe3or7cRnCeHTGt3ZMy9v7x1OjV4', '2024-08-09 08:34:05.643732'),
('yit7xm1d3075v7i6ndul9vubi4shuyul', '.eJxdkUuP3CAQhP8K4hyPDMavuUTKPbkk0h6tBpqBXQITg_ep-e9pKzPKJLdWU_VVtfjgC2zVL1vBdQmWH3nHP93vNJgnTPuDfYR0ygeTU12DPuySw_W1HL5mi_HLVfsPwEPx5NbQaikmO0ygtDQKoG_7Xlqa-m4WdhDjpLVRWivRKSFb6CcjJwkTzHpwA0F_beF9CcllfvzgZdOPaCqR96eaz8HQ3DuDvTS2MWpUjZJj22jZzs0obUdRDlonSE7mm2NoOwCFbYNm7BrVDdjMs-ibGYzQiMYNCNdsUj_4YDzLjlWPzOUY80tIJxYKcxALMtB5q6zEfMbCPpMPX-HnUt_OyI9pi_FC2Ripd8jp7ym3jaCEbznhLYBoz8jvLJIEPzy-sZDMikCBNpQKySBbkSquaFnNNAO13AkhVfoQ2noMJ1_vWd2NRabN7Nes_2EIEvCZarAK5eneq8j7_c-RsJIg7YViSOQ7R0jIL5ffvKjHlg:1sYOuH:KBKv1YXlHmI0RvKy5rTMnSBozLmr95vyZLpu3IDLNdQ', '2024-08-12 11:51:13.397032');

-- --------------------------------------------------------

--
-- Table structure for table `exams_classtest`
--

CREATE TABLE `exams_classtest` (
  `uuid` char(32) NOT NULL,
  `test_size` int(10) UNSIGNED NOT NULL CHECK (`test_size` >= 0),
  `duration` int(10) UNSIGNED NOT NULL CHECK (`duration` >= 0),
  `date` datetime(6) NOT NULL,
  `expiry` date DEFAULT NULL,
  `class_id_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_classteststudenttest`
--

CREATE TABLE `exams_classteststudenttest` (
  `id` bigint(20) NOT NULL,
  `uuid` varchar(100) NOT NULL,
  `date` datetime(6) NOT NULL,
  `marks` int(11) NOT NULL,
  `is_done` tinyint(1) NOT NULL,
  `finished` tinyint(1) NOT NULL,
  `test_id` char(32) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_classtest_quiz`
--

CREATE TABLE `exams_classtest_quiz` (
  `id` bigint(20) NOT NULL,
  `classtest_id` char(32) NOT NULL,
  `topicalquizes_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_generaltest`
--

CREATE TABLE `exams_generaltest` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `date` datetime(6) NOT NULL,
  `marks` int(11) NOT NULL,
  `exam_type` varchar(10) NOT NULL,
  `test_size` int(10) UNSIGNED NOT NULL CHECK (`test_size` >= 0),
  `duration` int(10) UNSIGNED NOT NULL CHECK (`duration` >= 0),
  `is_done` tinyint(1) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_generaltest_quiz`
--

CREATE TABLE `exams_generaltest_quiz` (
  `id` bigint(20) NOT NULL,
  `generaltest_id` bigint(20) NOT NULL,
  `topicalquizes_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_studentsanswers`
--

CREATE TABLE `exams_studentsanswers` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `test_object_id` char(32) NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `quiz_id` char(32) NOT NULL,
  `selection_id` bigint(20) NOT NULL,
  `test_content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_studenttest`
--

CREATE TABLE `exams_studenttest` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `date` datetime(6) NOT NULL,
  `marks` int(11) NOT NULL,
  `exam_type` varchar(10) NOT NULL,
  `test_size` int(10) UNSIGNED NOT NULL CHECK (`test_size` >= 0),
  `duration` int(10) UNSIGNED NOT NULL CHECK (`duration` >= 0),
  `subject_id` bigint(20) NOT NULL,
  `topic_id` char(32) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_studenttest_quiz`
--

CREATE TABLE `exams_studenttest_quiz` (
  `id` bigint(20) NOT NULL,
  `studenttest_id` bigint(20) NOT NULL,
  `topicalquizes_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams_topicalquizanswers`
--

CREATE TABLE `exams_topicalquizanswers` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `choice` varchar(600) NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `quiz_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exams_topicalquizanswers`
--

INSERT INTO `exams_topicalquizanswers` (`id`, `uuid`, `choice`, `is_correct`, `quiz_id`) VALUES
(1, '1ad8ba6880704d77873e7c56b9607b0f', 'Thousands', 1, '081124b34c4248f991c24f113e745402'),
(2, '2035492af46944e89d851c8eaf660041', 'Hundreds', 0, '081124b34c4248f991c24f113e745402'),
(3, 'e22fe0db3e8047619b19b7368ac156dd', 'Seven Thousand', 0, '081124b34c4248f991c24f113e745402'),
(4, '3aad940120624d4d9edc86b99c2b7fe2', 'Tens of Thousands', 0, '081124b34c4248f991c24f113e745402'),
(5, '85e03c81d74c4e3eb958837982dbd03b', '60 000', 1, '5e4cd1ba51634cca807c44883b43b694'),
(6, '15b69ee753bd471096851010e1a91538', 'Tens of thousands', 0, '5e4cd1ba51634cca807c44883b43b694'),
(7, '0cca80d2c5924d0396f55ca1f2648109', '6 000', 0, '5e4cd1ba51634cca807c44883b43b694'),
(8, '279127dfad4046fba66d5da0f95c0ad0', 'Hundreds of Thousands', 0, '5e4cd1ba51634cca807c44883b43b694'),
(9, '8fdd2342c6344817bad68a01ffc51dd3', '38 303', 1, 'fe814c43e68946f1ac588f4998ce461c'),
(10, '3788f19240214c659d0f218c0b8c928f', '38 3003', 0, 'fe814c43e68946f1ac588f4998ce461c'),
(11, 'd3ebf80fc7eb4f2ead85e847250944da', '38 003', 0, 'fe814c43e68946f1ac588f4998ce461c'),
(12, 'e5e43dcaddbb44ff807ae3d21958be46', '38 033', 0, 'fe814c43e68946f1ac588f4998ce461c'),
(13, '2095e155919b4247bce51d972f576d48', 'one thousand and eight , one thousand and eighty,  one thousand eight hundred ', 1, '60d7d97791ef40fbafba174c32085863'),
(14, '0a073bf924ee4d9f8b8138638fb60b18', 'one thousand eight hundred , one thousand and eighty, one thousand and eight', 0, '60d7d97791ef40fbafba174c32085863'),
(15, '2ecd8ab9c4aa4a7da38b7a98002c7044', 'one thousand and eighty, one thousand and eight, one thousand eight hundred', 0, '60d7d97791ef40fbafba174c32085863'),
(16, '1e8b07b88d3b448bbe96af3cfbb98d3c', 'one thousand and eighty, one thousand eight hundred , one thousand and eight.', 0, '60d7d97791ef40fbafba174c32085863'),
(17, '8115907a645446d1875e14be5dd011e9', '1 010', 1, '770798a97a3c4052b4f2702a7f3aa2ed'),
(18, '80aaca33b13643f997eb0a121d9dd845', '1 020', 0, '770798a97a3c4052b4f2702a7f3aa2ed'),
(19, '10bdb71560ae4b8b99dd8cc45a57eabf', ' 1 000', 0, '770798a97a3c4052b4f2702a7f3aa2ed'),
(20, '17fb746017c9498f881020921b696273', '1 100', 0, '770798a97a3c4052b4f2702a7f3aa2ed'),
(21, 'f5f8a9cd94b947a3a026ce60bbe13474', 'They die, they reproduce, they respond to environmental changes.', 1, 'ce39060b925f49a39446805b572f2f00'),
(22, '68e8f1d482c246ab91e7a0f5cf686721', 'They move, they grow, they are living.', 0, 'ce39060b925f49a39446805b572f2f00'),
(23, '38eac4085e7d4af3b71489dc62ddffc4', 'They die, they reproduce, they move.', 0, 'ce39060b925f49a39446805b572f2f00'),
(24, 'd3e711b90b9648f197d9e1ee2aa05a1a', 'They feed, they reproduce they are non living.', 0, 'ce39060b925f49a39446805b572f2f00'),
(25, '2048190ea76b4b00bd53ce7c81634446', 'A log of tree', 1, 'db719b73283c431cb9f1ed4aa7596b19'),
(26, '893e811f27b64786b35c61bb4e5b03e0', 'Algae', 0, 'db719b73283c431cb9f1ed4aa7596b19'),
(27, '548b9a470dfb4df2bfdad166ba7b8e6d', 'Mushroom', 0, 'db719b73283c431cb9f1ed4aa7596b19'),
(28, 'c8a2c2aac3e54370ae950b56e1bf199a', 'Seedling', 0, 'db719b73283c431cb9f1ed4aa7596b19'),
(33, '8aa4d4a0f4854789bd558c7b9463efa9', 'They move.', 1, '4ef011d4580d4fb18432480018300853'),
(34, 'b27f7868ccda40a08430e57284ef4bf1', 'Plants reproduce', 0, '4ef011d4580d4fb18432480018300853'),
(35, '6d0ee4a2a0e943d7877bd376a9b0a2b0', 'Plants die.', 0, '4ef011d4580d4fb18432480018300853'),
(36, 'ca2344bcfbb4467c9228090c07d22efa', 'They remove waste', 0, '4ef011d4580d4fb18432480018300853'),
(37, '88c8754c21e94f1d9ba9d0e485e75d40', 'To protect our eyes.', 1, '0bc31e7162424c6bb31fa39a53842d7f'),
(38, '8974769bb7b74757bfb57da3d1cb52f6', 'To protect our nose.', 0, '0bc31e7162424c6bb31fa39a53842d7f'),
(39, 'd037c7eff31447a895b88b7d7716f36c', 'To shield sunlight', 0, '0bc31e7162424c6bb31fa39a53842d7f'),
(40, 'bdcd6c1a02b74755a72acb638d17bd05', 'Goggles protects our faces.', 0, '0bc31e7162424c6bb31fa39a53842d7f'),
(41, '553add90d85440bb8628dd9aa911a0af', 'Gloves and masks.', 1, '9ab68f6eb4fa4f0fb5d5e6a227fba31d'),
(42, 'a40c5227d20a4ef9b0e70d7269c5b2f7', 'Masks and gloves.', 0, '9ab68f6eb4fa4f0fb5d5e6a227fba31d'),
(43, '6e8375f42b334744acb43fc8540a21f3', 'Gumboots and forceps', 0, '9ab68f6eb4fa4f0fb5d5e6a227fba31d'),
(44, 'cd52d40533b64f248f02bbb41a6df9b9', 'Goggles and gloves.', 0, '9ab68f6eb4fa4f0fb5d5e6a227fba31d'),
(45, 'ef48ff76db004f8ca5a7181e68af4965', 'Handkerchief', 1, 'b1aeb5a1d7ec4582aaaf00ae22748afc'),
(46, '150dd34d2e394b899e67424373f91f33', 'Forceps', 0, 'b1aeb5a1d7ec4582aaaf00ae22748afc'),
(47, 'dbe6c84846df4bd4ad9a78ef04ce9b0f', 'Mask', 0, 'b1aeb5a1d7ec4582aaaf00ae22748afc'),
(48, '1bc166be55484983bc05c853ef4f97a9', 'Gumboots', 0, 'b1aeb5a1d7ec4582aaaf00ae22748afc'),
(49, 'e17cba3b052a43bfb52e63b76cd07707', 'They move, they die, they reproduce.', 1, '59119f894c4b45178af6ce0d1606c31b'),
(50, '9a6d4138bcfd44b58cc639b8b9d2f75a', 'They do not move, they die they remove waste material.', 0, '59119f894c4b45178af6ce0d1606c31b'),
(51, '9db98fe007b44db28aa01c16bd6774b5', 'They feed, they breath, they do not respond to environmental changes.', 0, '59119f894c4b45178af6ce0d1606c31b'),
(52, '135507852b0045b6a54cbec0dbb35367', 'They do not remove waste material, they breath, they reproduce.', 0, '59119f894c4b45178af6ce0d1606c31b'),
(53, '21100aff43b34f9d9da87b3d66d16687', 'They do not remove waste material.', 1, 'b5ecadd5d83b44a284abb34107eba355'),
(54, '495ad469c4604ddfb0ebd1a4745ac221', 'They breath', 0, 'b5ecadd5d83b44a284abb34107eba355'),
(55, '37febe0eea6045bf8b7a2a6b9bebf415', 'They excrete', 0, 'b5ecadd5d83b44a284abb34107eba355'),
(56, '6313668a4f0f4724b36f39f091dcf184', 'They reproduce.', 0, 'b5ecadd5d83b44a284abb34107eba355'),
(57, 'bb3876f540e449da8ccf63e24a6b67db', 'Vertebrates and Invertebrates.', 1, 'bd93ba2fb6674b468517f24c8b93e28e'),
(58, '7ab76f2be0e6403395a5769fa056aeca', 'Living and non-living', 0, 'bd93ba2fb6674b468517f24c8b93e28e'),
(59, 'ace2ab4c9a3940feaf3271cc622ead0b', 'Mammals and non mammals', 0, 'bd93ba2fb6674b468517f24c8b93e28e'),
(60, '7fe3ca9ca3ef4d87867f9b47372ccbc8', 'Humans and livestock', 0, 'bd93ba2fb6674b468517f24c8b93e28e'),
(61, '547b65fcb4a54844b54f30e286846799', 'Fish, mammals and birds', 1, '60a1590834ee4841b6fec6ba384b43a5'),
(62, '67bd1fb3e3cf4df0acba7a559a7a5b80', 'Fish worms and birds', 0, '60a1590834ee4841b6fec6ba384b43a5'),
(63, '13ec38ab1b244e9c8cff32000710caeb', 'butterfly, fish and amphibians', 0, '60a1590834ee4841b6fec6ba384b43a5'),
(64, '5deb28d6e26d40888551c711e5611277', 'Frogs, centipedde and amphibians.', 0, '60a1590834ee4841b6fec6ba384b43a5'),
(65, '83f803b0cfa84114ae8bb4b88af4bcab', 'wash our hands', 1, '8812b50fd83b4bac8fa63e4b7f495c4a'),
(66, 'b7ffdc3d9bd34e4ea7841f088827b023', 'wash hands', 0, '8812b50fd83b4bac8fa63e4b7f495c4a'),
(67, '1a735c320ea8477e8e5161fb95ec0209', 'Kill them so that they dont bite us', 0, '8812b50fd83b4bac8fa63e4b7f495c4a'),
(68, 'c12f1df52a754061a31f4db06de8fcdf', 'wear gloves', 0, '8812b50fd83b4bac8fa63e4b7f495c4a'),
(69, '235ed3c60a81475eae76e0b4a9f023a1', 'Reproduce', 1, '571b66ca48244b93b7e8fbfe9dba045f'),
(70, 'b64e8b3795f845d8ba1538e89ef1934e', 'Excrete', 0, '571b66ca48244b93b7e8fbfe9dba045f'),
(71, '79e65f7184bb4f99a8b5b6e2acc2b333', 'Die', 0, '571b66ca48244b93b7e8fbfe9dba045f'),
(72, '7ab4da51fb4d40e599f3c2c60be8c5d0', 'Respond to environmental changes', 0, '571b66ca48244b93b7e8fbfe9dba045f'),
(73, '46652b4540654b2687807492dbc6b9ed', 'Bladder', 1, 'dbc4bea5778240b58b1b027ff10e1376'),
(74, '052a54ada8ed466ebe6f96d23efc0fa8', 'Mouth', 0, 'dbc4bea5778240b58b1b027ff10e1376'),
(75, '9812b944d97f46a190f1f894c38e9ee0', 'Rectum', 0, 'dbc4bea5778240b58b1b027ff10e1376'),
(76, 'add5bbd4ed4242f8860f3716fa320caa', 'Small Intestines.', 0, 'dbc4bea5778240b58b1b027ff10e1376'),
(77, 'ec2c17ec4ead4f9fb693462ba16d5b2f', 'To chew food', 1, 'cd1d54879294492fb072509e642bcf6d'),
(78, '27f504eb7681418c8744ec07515d35cb', 'To absorb minerals', 0, 'cd1d54879294492fb072509e642bcf6d'),
(79, '47550f76cf6d42b49f2073d7acc74aa7', 'To swallow food', 0, 'cd1d54879294492fb072509e642bcf6d'),
(80, '51001fba3eb9477a81924d1ba244f645', 'To moisten food', 0, 'cd1d54879294492fb072509e642bcf6d'),
(81, 'b72914692d3b418e89842958677f959e', 'Bladder', 1, '0a0582091aa24528a84a3aec8f599ef7'),
(82, '00b56ada63fb42b58285f337851ac465', 'Pancrease', 0, '0a0582091aa24528a84a3aec8f599ef7'),
(83, '5971526ab93e4166b2c5d714018f58ee', 'Gut', 0, '0a0582091aa24528a84a3aec8f599ef7'),
(84, 'acaed37222444fabbad8626b95d2ada3', 'Rectum', 0, '0a0582091aa24528a84a3aec8f599ef7'),
(85, '671cee3d9cfb47608ea9e99f7fa028b6', 'Animals that have a backbone.', 1, '44c204a96514485f895de122a73a56d6'),
(86, 'fcf68ea65b4d4980957ad8807a508488', 'Animals that do not have a back bone.', 0, '44c204a96514485f895de122a73a56d6'),
(87, '0ab987413b6b4e3e95ee9aa25c29518b', 'Animals that eat grass', 0, '44c204a96514485f895de122a73a56d6'),
(88, 'd72c748b66ef4b158eed37c55021fde7', 'Animals that eat meat.', 0, '44c204a96514485f895de122a73a56d6'),
(89, 'c20fe2767f53407aba92f634af2edc0f', 'Animals that do not have a backbone', 1, '208b3186bddc42ac80eefa67cc5a1483'),
(90, '94ab46d803944262a759a0c2af765dff', 'Animals that have a backbone', 0, '208b3186bddc42ac80eefa67cc5a1483'),
(91, '91b4810221eb489dad1bb7b3b5e6be5d', 'Animals that eat grass and plants', 0, '208b3186bddc42ac80eefa67cc5a1483'),
(92, 'e4598fa7fa9542d5818863f2c3956120', 'Animals that eat other animals', 0, '208b3186bddc42ac80eefa67cc5a1483'),
(93, '1f7bbde5c7c24401ab43552971630791', 'To handle small animals.', 1, '80958ab35c2e4e50882e96385edaccc8'),
(94, '6a95066e5d844561a95a269470818de1', 'To cover our hands', 0, '80958ab35c2e4e50882e96385edaccc8'),
(95, '4e9ac04acfc247a6ac66a504186b34f2', 'To kill animals so they dont hurt us', 0, '80958ab35c2e4e50882e96385edaccc8'),
(96, '1d0cca565da84c4ea07f29768adfbc43', 'To protect our eyes from dangerous animals ?', 0, '80958ab35c2e4e50882e96385edaccc8'),
(97, 'a4d7723c6c0c4527b5d3cd76e7cd10b2', 'Make bile for food digestion', 1, '5d772de1b1d74daca61e3835ccae12e8'),
(98, 'a183e996d81b488cbfb7384490aa77f0', 'Moves food from stomach to small intestines', 0, '5d772de1b1d74daca61e3835ccae12e8'),
(99, 'e1af5c1cf5a74f6fafdc1993e7734585', 'Purify blood', 0, '5d772de1b1d74daca61e3835ccae12e8'),
(100, 'b8a2fa6173e940378abea54127c067c6', 'Separate food from saliva', 0, '5d772de1b1d74daca61e3835ccae12e8'),
(101, 'e86f6b61a75c43d8874adf49c42cfb73', 'Pollution is the introduction of harmful materials to our environment.', 1, 'bb6ac8c0265846419b8e73d224d7a8d8'),
(102, '8a030b4c478c4a5ab8e466299f17087b', 'Pollution is the act of pouring of sewages to our water sources.', 0, 'bb6ac8c0265846419b8e73d224d7a8d8'),
(103, '5a0e642af00e4a4e8a930ceea946bfd1', 'Pollution is the act of burning trees for charcoal', 0, 'bb6ac8c0265846419b8e73d224d7a8d8'),
(104, '10b4b6697b704302839e45f9c05cea20', 'Pollution is the releasing of chemicals into rivers.', 0, 'bb6ac8c0265846419b8e73d224d7a8d8'),
(105, '5da3f6dc4e644cc78721510c5b35e221', 'It is the introduction of harmful materials into earths atmosphere.', 1, '488f9e9463d74e64ba6d50a1034618d5'),
(106, '8601b88c4f1b4e31a9bab444301c7b78', 'It is the burning of charcoal', 0, '488f9e9463d74e64ba6d50a1034618d5'),
(107, '9257a1d755d14031bc0d891f6ddc3e8d', 'It is the release of waste materials into our water sources', 0, '488f9e9463d74e64ba6d50a1034618d5'),
(108, '7ce2d098768849338381ddf2132eb560', 'It is the release of smoke by cars that use petrol ?', 0, '488f9e9463d74e64ba6d50a1034618d5'),
(109, 'ca6652c179554c5ba379cb6db3e64681', 'Burning of charcoal ', 1, '4488a126eff843bd9c068096641c7d9c'),
(110, '2eeb97b3e0c248efb7c9aaeb698671b7', 'Throwing wastes to our water bodies.', 0, '4488a126eff843bd9c068096641c7d9c'),
(111, '81b8c4a7c03c411d9c020a913162d1e2', 'Throwing of polythene papers on our streets', 0, '4488a126eff843bd9c068096641c7d9c'),
(112, 'f472df19064e49dea92c4b3809a7378c', 'Afforestation', 0, '4488a126eff843bd9c068096641c7d9c'),
(113, '56f50f450e41481ebe64c981a0d57fa6', 'Driving of electric vehicles', 1, '9c215a0901794c18a8bc98fc88fbe87c'),
(114, '4e9658fe5e374019aef55bc90306d126', 'Driving of cars that use fuel', 0, '9c215a0901794c18a8bc98fc88fbe87c'),
(115, 'ce016f1d40424f0093ddeeae23180f0f', 'Cooking with jikos', 0, '9c215a0901794c18a8bc98fc88fbe87c'),
(116, '8d19dc15c49244ada2b143337fd8cc0c', 'Throwing of teargas', 0, '9c215a0901794c18a8bc98fc88fbe87c'),
(117, '2883c4b794e2400faf7ac105f994dc0a', 'Contaminated water', 1, '3b10a10c569c478ca6fbb9a6661080b1'),
(118, 'a4292e0c180d4aa4aadb07f9d25d764a', 'Dust', 0, '3b10a10c569c478ca6fbb9a6661080b1'),
(119, '1d1028c422ac4df3919975d90ed467f3', 'Spraying pesticide chemicals', 0, '3b10a10c569c478ca6fbb9a6661080b1'),
(120, '491314fd60a34fbb9626d670f372c787', 'Smoke', 0, '3b10a10c569c478ca6fbb9a6661080b1'),
(121, '22669d5ed39c43d4b2c7b008ddc34c7b', 'Polluted air causes diseases like TB which can cause death.', 1, 'e05cb6714b9d4578b8d3546d7d2d72b7'),
(122, 'a2ba80b45f4942a483f10e1adc498a69', 'Polluted air causes diseases like typhoid', 0, 'e05cb6714b9d4578b8d3546d7d2d72b7'),
(123, '64cf7bcbd5454deb94672927159cd10b', 'Polluted air makes our soils infertile.', 0, 'e05cb6714b9d4578b8d3546d7d2d72b7'),
(124, '74532a43c68a4c118e4f982367e83267', 'Polluted air can kill the fish in the seas', 0, 'e05cb6714b9d4578b8d3546d7d2d72b7'),
(125, '3b76d6c845804dceb954d61837cd214b', 'The use of gas cookers for cooking.', 1, '07b20456082749f7ae717411087e6f52'),
(126, '4abf822d546344f8b70ff863b198e7aa', 'Burning of charcoal away from peoples houses.', 0, '07b20456082749f7ae717411087e6f52'),
(127, '07189dd7f81a4a87b1d27c65fb0bbfbd', 'Use of kerosene stoves for cooking', 0, '07b20456082749f7ae717411087e6f52'),
(128, 'd6f9407f92454de5ae7ffde74f5809f1', 'Using cars that run on diesel and not petrol', 0, '07b20456082749f7ae717411087e6f52'),
(129, '33ba4805b5bc42b3b867c841384e5aa9', 'Water pollution is the introduction of harmful elements into our water sources', 1, '820d96ac346f4641ad794dc3e7612707'),
(130, '395b12c324cb4031bcfefa964051aded', 'Water pollution is the drinking of dirty water', 0, '820d96ac346f4641ad794dc3e7612707'),
(131, 'ed9691c2b0f2467284628628722b987b', 'Water pollution is the pouring of oil in our oceans', 0, '820d96ac346f4641ad794dc3e7612707'),
(132, 'f6c286e39ac84642be725b128f362880', 'It is the introduction of harmful elements into earths atmosphere.', 0, '820d96ac346f4641ad794dc3e7612707'),
(133, '2532147cf889484cbfd61c655b2b76a3', 'Pouring of oil into our water bodies', 1, '47170450874f427da1a36c4e06123bd8'),
(134, '94ddf844414f434bbf055b521cb973bc', 'water filtration', 0, '47170450874f427da1a36c4e06123bd8'),
(135, '86b622b2fae44e0b945cb93ab2425f4a', 'Water purification', 0, '47170450874f427da1a36c4e06123bd8'),
(136, '560450420bb24b649c2f52b0e00b2d9c', 'Pouring of detergent into washing water', 0, '47170450874f427da1a36c4e06123bd8'),
(137, 'c4c201d3fb9b4c4493de8957eff3efaa', 'Causes water born diseases', 1, 'd75c27413db642aca3d1d507493a5f0a'),
(138, '01193196663e4dc2ba3ec6ae6ddcc159', 'Kills bacteria in water', 0, 'd75c27413db642aca3d1d507493a5f0a'),
(139, '97abe10b445e4fe5aaa7f9255cce1965', 'Makes water safe for swimming', 0, 'd75c27413db642aca3d1d507493a5f0a'),
(140, 'ece8d768735e40ebb5e1cadafdc50a99', 'Causes air born diseases.', 0, 'd75c27413db642aca3d1d507493a5f0a'),
(141, '3ddf63014d7c442b8daa445e17c001b9', 'Purifying water with detergent', 1, 'e39e614da75a4736af0e4ccedb922956'),
(142, 'b5afb25844e646f0983e8f83890ede12', 'Not washing our clothes near water bodies', 0, 'e39e614da75a4736af0e4ccedb922956'),
(143, '47953aad4dc34c55af0346f36e855097', 'Safely throwing waste products away from water bodies', 0, 'e39e614da75a4736af0e4ccedb922956'),
(144, 'e7186e6dcbb54e81b499fcfe8a56d887', 'Avoid misuse of water like pouring water on the ground.', 0, 'e39e614da75a4736af0e4ccedb922956'),
(145, '7269c5ebbc274a64bcafc9f0b799fabe', 'Water', 1, 'ed9a7930040d4066a61ab401dd6622df'),
(146, '75d5777fde0a4f07bd2b4c31e9810b8d', 'Liquid', 0, 'ed9a7930040d4066a61ab401dd6622df'),
(147, 'e4ec34aea9f5488bbb9eb190eb1a3fd4', 'Gases', 0, 'ed9a7930040d4066a61ab401dd6622df'),
(148, '43f63a54c976409c8145abdfabaec99a', 'Solids', 0, 'ed9a7930040d4066a61ab401dd6622df'),
(149, 'e8704c995d0040f5b626587d683d24ef', 'Liquids', 1, '22c76b4b3aed46e8b969c3d37f4a898b'),
(150, '71d6814eb7e74fbda03d95f813626c0b', 'Water', 0, '22c76b4b3aed46e8b969c3d37f4a898b'),
(151, '2e40d03da11443efb97d5c1a92437a7c', 'Oxygen', 0, '22c76b4b3aed46e8b969c3d37f4a898b'),
(152, '6332642f71ac4d429a4dc695ad6987db', 'Mass', 0, '22c76b4b3aed46e8b969c3d37f4a898b'),
(153, '82e89d2695c44007939154e4645869d7', 'Masks and goggles', 1, '2bb050dadae84953b3f093f01b19184b'),
(154, '7e424374b0d54fd9bc98b3291b524e5e', 'Masks and Gumboots', 0, '2bb050dadae84953b3f093f01b19184b'),
(155, '01e5835e0b5b404ca9a071e0f03c1b67', 'Tongs and goggles', 0, '2bb050dadae84953b3f093f01b19184b'),
(156, '464d0e9d6025483bab6071a93499237f', 'Dust coat and tongs', 0, '2bb050dadae84953b3f093f01b19184b'),
(157, '9a68f8c581df491fa0c074a05b4b127e', 'Argon', 1, '73403ce5fdbb40efb88c7c20c3a0dded'),
(158, 'bae9250810a34e1ca7ec1804027e8a8f', 'Coal', 0, '73403ce5fdbb40efb88c7c20c3a0dded'),
(159, '24c8c3496d0744deb1b7089a8e20ba42', 'Pebbles', 0, '73403ce5fdbb40efb88c7c20c3a0dded'),
(160, '0bb3cfb3946b433692c6d4678a34d22f', 'Ice cubes', 0, '73403ce5fdbb40efb88c7c20c3a0dded'),
(161, '2e760cde32474a3c9849f629249fc67d', 'Rubber stopper', 1, '3cef548d8fbe4dad97e32685502bb65b'),
(162, '4a66169659314852af2cf7e36cc77372', 'Needle', 0, '3cef548d8fbe4dad97e32685502bb65b'),
(163, 'f6d65e481b6e431f8c33efc80b8507e8', 'Pebble', 0, '3cef548d8fbe4dad97e32685502bb65b'),
(164, '70f978d078f24dc3b1341da8e76db423', 'Steel Spoon', 0, '3cef548d8fbe4dad97e32685502bb65b'),
(165, '609b8858926b402f904ebd90dfb0c7e9', 'Pebbles and steel spoons', 1, '07bf7129229342d08c701fc69056e7ed'),
(166, '3020766836bb45bfa5d3a7d41d01c055', 'Rubber and a stick', 0, '07bf7129229342d08c701fc69056e7ed'),
(167, '8884b366e4bc48c8adf5a1d769a24102', 'Plastic spoon and plates', 0, '07bf7129229342d08c701fc69056e7ed'),
(168, 'f64a4272f673444885f614c6f3c86549', 'a closed plastic can and cock', 0, '07bf7129229342d08c701fc69056e7ed'),
(169, '2c5fff49ddc748918d20ef5c69e767c3', 'They are used as life savers', 1, '36c8ed1a8dd84b909ad915826c61df76'),
(170, 'ddfa01bb6e044ed4a865e820d7cdfccd', 'They are used as anchors for ships', 0, '36c8ed1a8dd84b909ad915826c61df76'),
(171, '9f808861d07847658a84b93f5d7bb0dc', 'They are used to protect fish', 0, '36c8ed1a8dd84b909ad915826c61df76'),
(172, '0c81a2738dd148b3adff2f437259f98b', 'None of the above', 0, '36c8ed1a8dd84b909ad915826c61df76'),
(173, '69cda2fb01ac4333a22e58c5d0517fcf', 'Density', 1, 'e434557584eb4f16a446bc9d785cff9a'),
(174, '8c1a91704f1a404eac039ed0a6646e24', 'Height', 0, 'e434557584eb4f16a446bc9d785cff9a'),
(175, 'af3ca5cbe06a4b2bb8b361056cd9676c', 'Waves', 0, 'e434557584eb4f16a446bc9d785cff9a'),
(176, 'ada3cc7478d645cf9c87093fc1eac0a4', 'Gases in the water', 0, 'e434557584eb4f16a446bc9d785cff9a'),
(177, '780c64e70b3b4cba8cdb9967d8cf15a8', 'A push or a pull', 1, '34e456e84c544cf684b654d50d3a2669'),
(178, '977a41c1ff4f4281947e4420fb003a8a', 'The force of gravity', 0, '34e456e84c544cf684b654d50d3a2669'),
(179, '047d85db24d24021adc15af0728e6e4a', 'A force is something that causes objects to only move', 0, '34e456e84c544cf684b654d50d3a2669'),
(180, '89d73d99733b4cbf96c0d01062cf0fc3', 'None of the above', 0, '34e456e84c544cf684b654d50d3a2669'),
(181, '96534668702e454ba7c2961d598b3c2d', 'Force of gravity makes objects to float', 1, '87f095bdfe694724b64a57892d960ae6'),
(182, 'b51ed2d95102471ca196bd5f5192071f', 'Force can make an object to start moving', 0, '87f095bdfe694724b64a57892d960ae6'),
(183, '8f69e4bdc0e64ea8b89e0bf23b2d8e23', 'Force can make an object change shape', 0, '87f095bdfe694724b64a57892d960ae6'),
(184, '5e7aca23d88b4039a402b327a25db8fb', 'Force can cause heat', 0, '87f095bdfe694724b64a57892d960ae6'),
(185, '0456383edb0e494d8d1eacd6aa03a677', 'Force can make objects move faster', 1, 'a7b12fef2d8c4c5aafab0819fc572139'),
(186, '12e74186c40b4f5b9865b79eb7218447', 'Force cannot make objects to change shape', 0, 'a7b12fef2d8c4c5aafab0819fc572139'),
(187, '370723275be84e1bb59d6fcd14177f30', 'Force of gravity only affects living things', 0, 'a7b12fef2d8c4c5aafab0819fc572139'),
(188, '7223342e90fb498d9fc664e3774c23e3', 'Force does not affect non living things', 0, 'a7b12fef2d8c4c5aafab0819fc572139'),
(189, '6bdb12f124524be5843c453c14938ddb', 'Sound travels in all directions', 1, '7646acc52a1e4007a132ef4a4ad75824'),
(190, 'a2be423f8c474c2280b2eed225a3f564', 'Sound travels in one direction', 0, '7646acc52a1e4007a132ef4a4ad75824'),
(191, '79cb840f98f744139fec4736b11431e6', 'Sound is a type of force', 0, '7646acc52a1e4007a132ef4a4ad75824'),
(192, '549224c692494eac84f049d1a68b2944', 'None of the above', 0, '7646acc52a1e4007a132ef4a4ad75824'),
(193, '6d7d29937d884c72a4329b37c8d309e9', 'Sound cannot be reflected', 1, 'de2a762672db43ae8c9e6f12ffe44399'),
(194, '27e90dcb67034ef5859ec5a68bbf48e3', 'sound travels in all directions', 0, 'de2a762672db43ae8c9e6f12ffe44399'),
(195, '1c5354ea050b4f06a89e703071b93d78', 'Sound is a form of energy', 0, 'de2a762672db43ae8c9e6f12ffe44399'),
(196, 'e71cff5002c44a65b5e4c9fa02c6715a', 'Sound travels from source to other directions', 0, 'de2a762672db43ae8c9e6f12ffe44399'),
(197, '563c1ad73aac48b1a9769290b7c5813d', 'In a straight line', 1, '2d300d1904cf44bea4aceb1733a98360'),
(198, 'c46da6be6c584198b2f0b4d7c536bec7', 'In all directions', 0, '2d300d1904cf44bea4aceb1733a98360'),
(199, '93ceed8a76e14e83ac8784625933f5aa', 'In two directions', 0, '2d300d1904cf44bea4aceb1733a98360'),
(200, 'a482035e17da4627ba32c42e7d78bae4', 'None of the above', 0, '2d300d1904cf44bea4aceb1733a98360'),
(201, 'ee24141f46364247ac9d78cf697e73ed', 'An opaque enclosing', 1, 'f31321329c6d4cd3bc5fb675434a71d4'),
(202, '9c952a0715b043fb9a7b60fa7598cde4', 'Translucent object', 0, 'f31321329c6d4cd3bc5fb675434a71d4'),
(203, '16885b06aced49ea8fbb0796fe70c077', 'A transparent window', 0, 'f31321329c6d4cd3bc5fb675434a71d4'),
(204, '9a51b827d7f346c58348c50974829d69', 'None of the above', 0, 'f31321329c6d4cd3bc5fb675434a71d4'),
(205, 'db8cdb1b4a5646ce968481c5b2f9fef3', 'An object that does not allow light to pass through', 1, '23fc3fd62641425fbee1ae8db0556714'),
(206, '0a030b8f1bda4edaa53bc26f2f10f0bf', 'An object that allow some light to pass through', 0, '23fc3fd62641425fbee1ae8db0556714'),
(207, '1e39f1e54ab04db1a314c8bc256477df', 'An object that allows all the light to pass through', 0, '23fc3fd62641425fbee1ae8db0556714'),
(208, '0abde00b105f46ebbf8a350f85967ebe', 'None of the above', 0, '23fc3fd62641425fbee1ae8db0556714'),
(209, '9a1e70194a7042b8b41d7278958023ff', 'it allows some light to pass through', 1, 'f36a955ffc3a40ca832819a11d3b3d0d'),
(210, 'ebc1c56f3d0445da8b88e8f534ebc950', 'It allows all the light to pass through', 0, 'f36a955ffc3a40ca832819a11d3b3d0d'),
(211, 'ef5b05b83e404b3baf3c80351ff82344', 'It does not allow any light to pass through', 0, 'f36a955ffc3a40ca832819a11d3b3d0d'),
(212, '78c22973290b4730bf3e5c7c994d77b4', 'None of the above', 0, 'f36a955ffc3a40ca832819a11d3b3d0d'),
(213, 'ac6f57e3b06c49d7aff603422a92fe4c', 'Wood', 1, '72da7c47ae5c4df89da5e27a83945617'),
(214, '2796646cf5754d70aaec2d99d821c21c', 'Steel', 0, '72da7c47ae5c4df89da5e27a83945617'),
(215, 'b976d9071fb641c0b9d14a418df629be', 'Iron', 0, '72da7c47ae5c4df89da5e27a83945617'),
(216, '836b7c3150424cb487e915d92760ffc5', 'Copper wire', 0, '72da7c47ae5c4df89da5e27a83945617'),
(217, '68b1fa576ff94dfbb6e967c1a07384a3', 'Metallic spoon', 1, '298a980824cc4dee8271468f038f3e67'),
(218, 'bf24819e9945484f92a4b0ab2d60b119', 'Wood', 0, '298a980824cc4dee8271468f038f3e67'),
(219, '0c0a0c870b47429f95f2c21f8122ea8a', 'Gas', 0, '298a980824cc4dee8271468f038f3e67'),
(220, 'c670fba8b4734be49500277449c2a1cd', 'Glass', 0, '298a980824cc4dee8271468f038f3e67'),
(221, 'c7ebd14625ef4c1f9b71f06df95224ed', 'Make handle for cooking pans', 1, 'c0177e292a31464cae33197eea39c410'),
(222, '7a2c0a6d5cb041ed822e927c992ffb46', 'Make cooking pots', 0, 'c0177e292a31464cae33197eea39c410'),
(223, '45438e756d034f4883e6fb52fa4292e2', 'None of the above\r\n', 0, 'c0177e292a31464cae33197eea39c410'),
(224, 'a9b76641993142ea9642f5b4ef30966a', 'Make heaters', 0, 'c0177e292a31464cae33197eea39c410'),
(225, 'e371f4458e3041fc9cbdd488bec35516', 'Earthquake', 1, 'bb35b2133042451f9c2e240af9828a4f'),
(226, 'cc74978de44a4ca28b307b4241765caa', 'Sunny', 0, 'bb35b2133042451f9c2e240af9828a4f'),
(227, 'b7bdd8ae4cab40f5a7651d4611fc1776', 'Windy', 0, 'bb35b2133042451f9c2e240af9828a4f'),
(228, 'f6d2550dae374f09a11f4a529cf66fe0', 'CLoudy', 0, 'bb35b2133042451f9c2e240af9828a4f'),
(229, '99a1aaeb8e374c029efa40bfa789b6be', 'Farming', 1, 'e0838c38f0c248728d378427a9f5f43e'),
(230, 'a6f50670bd86406fa6e886d53fad12d3', 'Crop drying', 0, 'e0838c38f0c248728d378427a9f5f43e'),
(231, 'a58ad80bbcba4a248cc3120b5c3e1a55', 'Winnowing', 0, 'e0838c38f0c248728d378427a9f5f43e'),
(232, 'b7bbf3d9e29f4d56812ed278ee168172', 'Harvesting', 0, 'e0838c38f0c248728d378427a9f5f43e'),
(233, '4d4aaf1b9ff74045ac59894d3208d761', 'Windy', 1, 'ef0ae91db36145ebbd7777416063d562'),
(234, '3c6f22845fa14674b32c5cf00340a078', 'Sunny', 0, 'ef0ae91db36145ebbd7777416063d562'),
(235, 'a46e59eddb464676a99e22c39e707163', 'Rainy', 0, 'ef0ae91db36145ebbd7777416063d562'),
(236, '5f30f2010bc54e50b1ef09060a6d1022', 'Calm', 0, 'ef0ae91db36145ebbd7777416063d562'),
(237, 'd3ce1a0c6b57474eaa0fc109a3766c63', 'Crop harvest drying', 1, 'ab3e806ce084470a8e7d70ade91fda40'),
(238, 'c151c5bd5e6a40e8b23796d63e836bf8', 'Planting', 0, 'ab3e806ce084470a8e7d70ade91fda40'),
(239, '6fdbb57ef63d420b9a30fe7c683a6f61', 'Weeding', 0, 'ab3e806ce084470a8e7d70ade91fda40'),
(240, '262093957be84c328087b0514b21671b', 'None of the above', 0, 'ab3e806ce084470a8e7d70ade91fda40'),
(241, '6115656f74914d24b64033cfb09066c6', 'Nimbus', 1, 'bde5f8a9c05448eb8293b62059211655'),
(242, 'ac61f57784314d8091154092838061e0', 'Stratus', 0, 'bde5f8a9c05448eb8293b62059211655'),
(243, 'd397f94c32ea4b988429d6517365e59f', 'Cirrus', 0, 'bde5f8a9c05448eb8293b62059211655'),
(244, '5703afa94a784480816bc2a7454fc8db', 'Floods', 0, 'bde5f8a9c05448eb8293b62059211655'),
(245, '10b93c1b3af04055847c8e73180dc267', 'Cirrus', 1, '5f14e2c389c44203b252bc92811df7c5'),
(246, '3b060a34593a425ca74c16d0e4677d00', 'Nimbus', 0, '5f14e2c389c44203b252bc92811df7c5'),
(247, 'a5782f240d464d9ba0177b16ff6c2a1a', 'Stratus', 0, '5f14e2c389c44203b252bc92811df7c5'),
(248, '49ae6b9ab3c34253958aca7ca5b95b5f', 'Nimbostratus', 0, '5f14e2c389c44203b252bc92811df7c5'),
(249, '451f6a67ef724822a6d94c9efdb76dc1', 'A number that is divisible by 2', 1, '2dffc82a38cf4a89879c98c62bbc0486'),
(250, '6f9f83cc5d184870b7c84c4ab57bfc44', 'A number that is not divisible by 2', 0, '2dffc82a38cf4a89879c98c62bbc0486'),
(251, '980dc19d998644998bef7eb19cd5b75a', 'A number that has a remainder when divided by 2', 0, '2dffc82a38cf4a89879c98c62bbc0486'),
(252, '58dabfb1a41b43aeb85d51802aeb471e', 'None of the above', 0, '2dffc82a38cf4a89879c98c62bbc0486'),
(253, '9b87be2790c545b9a1e4bc9d1a081a91', '24, 36, 22', 1, '83c2791b100a4350ab937ee1f0c7e12d'),
(254, '07ac434cd11c40658c35c04cdaa93ef8', '24, 36, 221', 0, '83c2791b100a4350ab937ee1f0c7e12d'),
(255, 'f555a3361e4140559385f7d2456af9c5', '31, 19, 9', 0, '83c2791b100a4350ab937ee1f0c7e12d'),
(256, '9ec164418d1047ef89f15f4851231a07', '42.9, 35.6, 12.3', 0, '83c2791b100a4350ab937ee1f0c7e12d'),
(257, '8165df159ed54220bed22df5846bb08f', 'Numbers that are not divisible by 2', 1, 'fe155121d1224686b0357d4c786c56b4'),
(258, '4bf39c6f10024b9594c94218a43f07af', 'Numbers that have fractions', 0, 'fe155121d1224686b0357d4c786c56b4'),
(259, '0bff2a6dfb5a4e47b5f290a2eb99e174', 'Numbers that are divisible by 2', 0, 'fe155121d1224686b0357d4c786c56b4'),
(260, 'dd7dee502c1c4571b6f3d3011c8ae23c', 'None of the above', 0, 'fe155121d1224686b0357d4c786c56b4'),
(261, '6473b6e27b744acd8882ec283c9dacf9', '25', 1, 'd385540b2f8f44ef80ccaf2d6cc0509a'),
(262, 'c5e50bf1c71d4cc3a3ad5d9d3143e823', '24', 0, 'd385540b2f8f44ef80ccaf2d6cc0509a'),
(263, '132e5e5cd46a4b398b7147a0c546fb6e', '23', 0, 'd385540b2f8f44ef80ccaf2d6cc0509a'),
(264, '1380c6ae871f4c189fc271bbe1064ed7', 'None of the above', 0, 'd385540b2f8f44ef80ccaf2d6cc0509a'),
(265, '5c4e473d7d6c41229611fcf3b9411be3', 'Each received 3, the teacher was left with 9', 1, '087d6ce6562e40ebb8dca35f3a626553'),
(266, '5221d05e935d46a897868c2755ed0929', 'each received  3 , the teacher was left with none', 0, '087d6ce6562e40ebb8dca35f3a626553'),
(267, 'a65e010db0be420c8e4b8e69ed183a6a', 'Each received 11, the teacher was left with 9', 0, '087d6ce6562e40ebb8dca35f3a626553'),
(268, 'cba30e898279408581db7658dcea227d', 'None of the above', 0, '087d6ce6562e40ebb8dca35f3a626553'),
(269, '79a26aec0b3e4e35abbd23dc8b6d077f', '8 844', 1, 'f720c4dc640f45f38e87efa7df8bf2c6'),
(270, '60fe27c2463e47e7b079d5b72c585b47', '8 834', 0, 'f720c4dc640f45f38e87efa7df8bf2c6'),
(271, '5b61ac035c254ceeae638d6a2e669eb2', '8 734', 0, 'f720c4dc640f45f38e87efa7df8bf2c6'),
(272, '0fb8c23b90e14b78aade2ca73f2cfb76', '8 744', 0, 'f720c4dc640f45f38e87efa7df8bf2c6'),
(273, 'd3217929b1ca4807b14db550c4c20354', '5 293', 1, '3653712b762a4aa487a68460cea7e557'),
(274, '123d0c1f6ed4426e8ea386adb80429fc', '5 283', 0, '3653712b762a4aa487a68460cea7e557'),
(275, 'f3d532c3997e4b7a8021f9d3ca66aee9', '6 303', 0, '3653712b762a4aa487a68460cea7e557'),
(276, '1c3db8f3ec3b4bcaae82278c679f6d20', '239', 0, '3653712b762a4aa487a68460cea7e557'),
(277, 'af9b62488cb44c319fdfa8b2ee7846d1', '436', 1, '2a95c1cdff4b4ae6a3208b0d2cf2df60'),
(278, '0c04330fa22c433f9620dd360daf4bb9', '426', 0, '2a95c1cdff4b4ae6a3208b0d2cf2df60'),
(279, 'a46104b949c34b51825d0d5983038722', '446', 0, '2a95c1cdff4b4ae6a3208b0d2cf2df60'),
(280, '381df93b169f4653a284952f5b4cd715', '456', 0, '2a95c1cdff4b4ae6a3208b0d2cf2df60'),
(281, 'b3a25eb4c575408991030c79165cd71f', '2 396', 1, '91d6f0b0f4c54297b90da37fe1687d8b'),
(282, '1422d8e6463f423e8255597acc544498', '2 386', 0, '91d6f0b0f4c54297b90da37fe1687d8b'),
(283, '89a52a35983944ac9bc36bac4a67d6ff', '2 406 ', 0, '91d6f0b0f4c54297b90da37fe1687d8b'),
(284, '1e0e76f2a37a4bd89bee39fbf22f8e3d', '3 610', 0, '91d6f0b0f4c54297b90da37fe1687d8b'),
(285, 'dec0ad61ce784ad58cecbb2d01ed4f4f', '929', 1, '9e3a2706772d4c38ae8012494f172029'),
(286, 'e6c30311c28c4e8a946e544fbd06e3a2', '939', 0, '9e3a2706772d4c38ae8012494f172029'),
(287, '5d2df8c5f4b843f9855b75de21742869', '949', 0, '9e3a2706772d4c38ae8012494f172029'),
(288, '37a0e7180e7a4f84aefd0cedbc6a339c', '3 685', 0, '9e3a2706772d4c38ae8012494f172029'),
(289, 'ad17c52a19984594b9fa322e5521c55d', '298', 1, '3c232aa573164a408611828e66f033d8'),
(290, '44c84c7fdaac47548140c64f7042bec4', '288', 0, '3c232aa573164a408611828e66f033d8'),
(291, 'bfd26b34b9074e3a8f92613d33e3e3c0', '302', 0, '3c232aa573164a408611828e66f033d8'),
(292, '17ddab019203467eb1669c93241ef1d0', '1 316', 0, '3c232aa573164a408611828e66f033d8'),
(293, '5fad28366f2749a69d86b4adc73e957c', '121', 1, '62fbd25232f04e7e8c24fabcaaa20c64'),
(294, '81470cff33c34259bb210b1f93022a7f', '111', 0, '62fbd25232f04e7e8c24fabcaaa20c64'),
(295, 'dc369e04adac43eaac3153d38dcae76a', '131', 0, '62fbd25232f04e7e8c24fabcaaa20c64'),
(296, '556b1d49eb1d4aada148fbd036a69069', '101', 0, '62fbd25232f04e7e8c24fabcaaa20c64'),
(297, 'a273bf12f56b4bb18a7997ec7e7b38ef', '120', 1, '1779d56524a24535bfdecca2b38ff637'),
(298, '889cb185b7594402a8edff3a1d56d84e', '22', 0, '1779d56524a24535bfdecca2b38ff637'),
(299, '495c9b245d5542b7bd194dffe9164f14', '2', 0, '1779d56524a24535bfdecca2b38ff637'),
(300, 'bcbe4af75c1e477cbf926af9dfcd0767', '12', 0, '1779d56524a24535bfdecca2b38ff637'),
(301, '06e00f9cbb9e45c29078eb15e5d78093', '300', 1, 'a1c336714cde432e988cd05c6490af2d'),
(302, 'acc3cbb07ef1409c985828e22df24014', '44', 0, 'a1c336714cde432e988cd05c6490af2d'),
(303, '3f96dc89d0e944c59e7da7c259c6edde', '56', 0, 'a1c336714cde432e988cd05c6490af2d'),
(304, '02e019b074024408aa108b3289a01cf8', 'None of the above ?', 0, 'a1c336714cde432e988cd05c6490af2d'),
(305, '7c10529e98bd4e689f986549fba2dea7', '81', 1, '09a9b6ec849541319bd025374801312f'),
(306, 'e4906a75c1104866811178ea0b319fd4', '30', 0, '09a9b6ec849541319bd025374801312f'),
(307, 'cef244a52c9340289dc0bec58925d556', '36', 0, '09a9b6ec849541319bd025374801312f'),
(308, '0e5383375f484fdb8a9433c49cefe6ef', '71', 0, '09a9b6ec849541319bd025374801312f'),
(313, 'e9c6f76f6012468ead270e2782cb221b', '6', 1, 'a6f6210be3f541949e84b895e29abf38'),
(314, 'f61db49526a9464489c5ec453d21154e', '35', 0, 'a6f6210be3f541949e84b895e29abf38'),
(315, '01ccad5ef15e489ebdd6855e893dd475', '294', 0, 'a6f6210be3f541949e84b895e29abf38'),
(316, '63546c5937bf48fbae5fcf6da0de4278', '49', 0, 'a6f6210be3f541949e84b895e29abf38'),
(317, '5dbdfbc1c29a43238fb8886be845979a', '9 2/6', 1, '4c92863673a940f3bf2fd8d5949b1f3d'),
(318, 'fae866e5f8774fc59e186b3c4b0464b2', '336', 0, '4c92863673a940f3bf2fd8d5949b1f3d'),
(319, 'c81bb54db6af4c8fb40fa851272fd054', '62', 0, '4c92863673a940f3bf2fd8d5949b1f3d'),
(320, '34ad839f41004a5bb278fe28dd836988', '50', 0, '4c92863673a940f3bf2fd8d5949b1f3d'),
(321, '1840502a43674e1698cec13ad8cd2470', 'Ten thousand three hundred seven,  Forty three thousand seven hundred ten', 1, '697575f9a2174ef091c6fc72916fe46a'),
(322, '8e33af5e74e8407ba727a84a16ca5e2a', 'Forty three thousand seven hundred ten, Ten thousand three hundred seven.', 0, '697575f9a2174ef091c6fc72916fe46a'),
(323, 'a3315566ebee4bd183fb0c0d632eaf42', 'Ten thousand three hundred and seventy, Forty three thousand seven hundred ten', 0, '697575f9a2174ef091c6fc72916fe46a'),
(324, '98a8bf8cb1094a0c8b3c3485b1232044', 'One thousand three hundred and seven, Four thousand three hundred seventy and ten', 0, '697575f9a2174ef091c6fc72916fe46a'),
(325, 'b9dcedc880c34ffbaed5faedf327f5df', '6 057, 209', 1, '093ec5f0b5cc4710a6c0147fb2e5e2c8'),
(326, 'ad3cd3dacc164ffc910c8d6a24b65eb7', '6 057, 710', 0, '093ec5f0b5cc4710a6c0147fb2e5e2c8'),
(327, '6f5b7052530946c7a795c30f4c2902a1', '36, 710', 0, '093ec5f0b5cc4710a6c0147fb2e5e2c8'),
(328, 'b4aab903418e44f7923776777e6efc98', '209, 36', 0, '093ec5f0b5cc4710a6c0147fb2e5e2c8'),
(329, '458b51b61d134783b036b6999483f581', '12 457', 1, '9b0f474fc1904f86b1e72f9affce0834'),
(330, 'a64e783c691d44d99972e46010551576', '12 447', 0, '9b0f474fc1904f86b1e72f9affce0834'),
(331, '630e81c934c848fd8b0e491ba3eeddc7', '12 466', 0, '9b0f474fc1904f86b1e72f9affce0834'),
(332, '6f7c66a9bc18432c95374898bb1ff123', '12 467', 0, '9b0f474fc1904f86b1e72f9affce0834'),
(333, 'cb277aa0cfe74eff9380a6fc746cb13d', '3 513', 1, 'b3c585af71d94dcebea3209a7514c0ab'),
(334, '796c712f7a2c46e6b054843f37bf9929', '3 403', 0, 'b3c585af71d94dcebea3209a7514c0ab'),
(335, '8095dbf778f64216a89c4195785ea580', '3 523', 0, 'b3c585af71d94dcebea3209a7514c0ab'),
(336, 'd1ecf98c58fa4a9f95582345717f24b6', '3 503', 0, 'b3c585af71d94dcebea3209a7514c0ab'),
(341, 'e50ee0b9a26b488d8bd2ce1e2828a918', '916\r\n', 1, '8cc305c0038244418d3bb73ced14e7aa'),
(342, '16c3d6af36a74ef99c10df6866b2a56e', '906', 0, '8cc305c0038244418d3bb73ced14e7aa'),
(343, 'efc78ddc70ae4272bff96f099f629c2e', '826', 0, '8cc305c0038244418d3bb73ced14e7aa'),
(344, 'c4c62da7ceb54e338ca9e6d58e8ef975', '936\r\n', 0, '8cc305c0038244418d3bb73ced14e7aa'),
(345, '98ddaee1086843e391f4e2a23cbaa481', '734', 1, '994258f0adb149fda94a3703ee852bd7'),
(346, '83edad94f74e47978ab780740e1d18d2', '724', 0, '994258f0adb149fda94a3703ee852bd7'),
(347, '3ad4ede6c1f94f5f98a5c65926413d30', '744', 0, '994258f0adb149fda94a3703ee852bd7'),
(348, '3f1bcb94ca814fad8cc2f42ffcb4fe2a', '276', 0, '994258f0adb149fda94a3703ee852bd7'),
(353, '4f8e7a02922648c0b6313586b6407a56', '4, 020 , 30 010', 1, 'fb182ae69e8549658ee6d2429e9a69e2'),
(354, '95729b2ecb524e27b05398af8c161498', '30 010 only', 0, 'fb182ae69e8549658ee6d2429e9a69e2'),
(355, '82a105912e3d4b39a8f56a3c5007c23c', '30 009, 40 015', 0, 'fb182ae69e8549658ee6d2429e9a69e2'),
(356, '32d9ad8c89bf43ed9d0a25c23e1f221c', 'All of the above', 0, 'fb182ae69e8549658ee6d2429e9a69e2'),
(357, '0cfbf35911464060887240afcc076a4d', '3 005, 2 010', 1, '6cb8c3104d394a5584c6a39b47e56948'),
(358, 'd006b5258cc341b29af2813c585d19ce', '2 010 only', 0, '6cb8c3104d394a5584c6a39b47e56948'),
(359, 'c698c06df6794b5e841dcd07ea8a4d5e', '6 754', 0, '6cb8c3104d394a5584c6a39b47e56948'),
(360, '9c0d7c4075454de1b48d13da28cdaa6a', '6 751', 0, '6cb8c3104d394a5584c6a39b47e56948'),
(361, '37e9d5f499c1408b8e4caf294e0e6f9c', '3 010, 650', 1, 'e21b521e94da4ea5adfbfe32825e5fea'),
(362, '4a920d06e0eb45aea760a66cd31d3417', '3 010 only', 0, 'e21b521e94da4ea5adfbfe32825e5fea'),
(363, 'd59b53a17d9b42dab8840f9a6d5da144', '1 002, 412', 0, 'e21b521e94da4ea5adfbfe32825e5fea'),
(364, 'f6f85dafd71243b59c2c6ed01baad132', '412, 3010', 0, 'e21b521e94da4ea5adfbfe32825e5fea'),
(365, '848fae0623f842b0b6e9c95bd255cd4f', '1, 2, 4, 7, 8, 14, 28, and 56', 1, 'd7be68b36b824dfda359b8a530f08b64'),
(366, '9e7201a2a0854b60aa5bbf7f2be5a3df', '1, 2, 4, 8, 28, and 56', 0, 'd7be68b36b824dfda359b8a530f08b64'),
(367, 'c4fe49513768480a9197215f8abc7a27', '1, 2, 4, 7, 28, and 56', 0, 'd7be68b36b824dfda359b8a530f08b64'),
(368, '3258f2560d8742aea2f12b3dcabae809', ' 2, 4, 7, 8, 14, 28', 0, 'd7be68b36b824dfda359b8a530f08b64'),
(369, 'b26012172d924a9bbd4edf50c2bf0b0c', 'Seven', 1, '30b93ea91e3146bdbbdcc5395010f73c'),
(370, 'df563438b9b541e287e1a9e8fa890a67', 'Eight', 0, '30b93ea91e3146bdbbdcc5395010f73c'),
(371, 'e6d2d10cc2034c21bd0ab2f344a876af', 'Six', 0, '30b93ea91e3146bdbbdcc5395010f73c'),
(372, 'b75416776397479c9418af11a05bf712', '9', 0, '30b93ea91e3146bdbbdcc5395010f73c'),
(373, 'b3d17b19ca2448f19421e076d70b2bcd', '9', 1, '439d91f58e284a9ab2413e062664fa52'),
(374, '789a2c1f020b46a58bf502f681fc22fc', '10', 0, '439d91f58e284a9ab2413e062664fa52'),
(375, '005f874e5ae44809982a80d30041a27a', '11', 0, '439d91f58e284a9ab2413e062664fa52'),
(376, '00d1087c074d4fd19ff192f6a1ddb2f1', 'Eight', 0, '439d91f58e284a9ab2413e062664fa52'),
(377, '62bd1133b1c24430aff633497e50ac37', '10 6/7', 1, 'a688e5484dc0417ba2f623469c8e58a4'),
(378, '444eb42481ee45c6b974a4e62d86b5f2', '10 7/6', 0, 'a688e5484dc0417ba2f623469c8e58a4'),
(379, '4e960c5ee01a4cd4a840a2be86c5aa0c', '10', 0, 'a688e5484dc0417ba2f623469c8e58a4'),
(380, 'f5f0637bdff048aa8b2d399a0096fc81', '6/7', 0, 'a688e5484dc0417ba2f623469c8e58a4'),
(381, 'c8f4988a5b42454b9dcfb0064a03066d', '0.6', 1, '26475a9fcd58472e85d833b3897dc978'),
(382, '12ce70d2bcc74288ab73180486164bfe', '1.6', 0, '26475a9fcd58472e85d833b3897dc978'),
(383, 'ff5149db3c454ef0979890e3f1e1bfc3', '6.0', 0, '26475a9fcd58472e85d833b3897dc978'),
(384, 'bbb4124b6ead49bfae89143644bd0726', '6.10', 0, '26475a9fcd58472e85d833b3897dc978'),
(385, '3ee2bed6fffa422eb6d4b9d494a02ed4', '0.17', 1, '3fdc62cbde0e45bdb94722095c9d2b55'),
(386, '7f3cf50161c94e768663a4f0eddccf1e', '0.0017', 0, '3fdc62cbde0e45bdb94722095c9d2b55'),
(387, 'abfdba180a0148acafa04df71bb6e087', '0.017', 0, '3fdc62cbde0e45bdb94722095c9d2b55'),
(388, '15a046a3b8144bbaae4b6a5bf27ac584', '1.7', 0, '3fdc62cbde0e45bdb94722095c9d2b55'),
(389, '361e2790dfd647da8ca9d27ca4f58482', 'Hundredths', 1, '119f393bc8fc4540be145b2db3fa1732'),
(390, '6aad61bf5da548f5852af47f3f11739f', 'Hundreds', 0, '119f393bc8fc4540be145b2db3fa1732'),
(391, 'b8410cc3518e40e092f7a90231d821f7', 'Tenths', 0, '119f393bc8fc4540be145b2db3fa1732'),
(392, 'c35a6c356bce428c95c88fa2bcb149c0', 'Tens', 0, '119f393bc8fc4540be145b2db3fa1732'),
(393, '46766ac95eaf4afd9311feb35cbb7dcf', '0', 1, '768e1342bad54d90a7001a3311f121e0'),
(394, 'fa926489226040c5b82fe94f56b16ae1', '9', 0, '768e1342bad54d90a7001a3311f121e0'),
(395, 'c062c30ee49c48c19b5c8976f5be2336', '4', 0, '768e1342bad54d90a7001a3311f121e0'),
(396, '7845fa2ef9c9431f9ad2988286b316f0', '3', 0, '768e1342bad54d90a7001a3311f121e0'),
(397, 'd9e310bdaa0d4ed7840cb4294fdeeb73', '3 000 cm', 1, 'ad1c84dec6e44f28ab6284edccc3c0cc'),
(398, '3b06521ad2be4ee0a82178a9674d054a', '0.30 cm', 0, 'ad1c84dec6e44f28ab6284edccc3c0cc'),
(399, 'bc854f41943b4029bc82ac2983708e5c', '300 cm', 0, 'ad1c84dec6e44f28ab6284edccc3c0cc'),
(400, 'dedd334af2b64d8e89e921d0bdb6becc', '30 000', 0, 'ad1c84dec6e44f28ab6284edccc3c0cc'),
(401, '724596fb89074037ac3c504ff4f43052', '3 035 cm', 1, '366f66b75f064b37b4077b96107b412a'),
(402, '9a77417c72f64dfeae4505dba99d3dc7', '335 cm', 0, '366f66b75f064b37b4077b96107b412a'),
(403, '3f446be05a6345d88b365ec1bc7dad2b', '1 035 cm', 0, '366f66b75f064b37b4077b96107b412a'),
(404, '96da4bbfb5ca43728d5e0c6ef7bd23cc', '10 350 cm', 0, '366f66b75f064b37b4077b96107b412a'),
(405, '0645364acd964da3b9d53b90d02ecf3b', '43 m 75 cm', 1, 'a1393dc954874bce8463b971625747c5'),
(406, '87229adfc6f6422aba20f01392847357', '4 m 375 cm', 0, 'a1393dc954874bce8463b971625747c5'),
(407, '1f11b215e8b549ed9ae52b5aa7b9124d', '403 m  75 cm', 0, 'a1393dc954874bce8463b971625747c5'),
(408, '4b396bebb61548fc92a7bdc5f17de6c5', '43 m 750 cm', 0, 'a1393dc954874bce8463b971625747c5'),
(409, '21ea64ea64604b76a876ec0b850d33c1', '108 m 2 cm', 1, 'a25025fb21c74b79b11aa52d562faa44'),
(410, '6f1da5779ddb48b9997c3a49ded50878', '108 m 20 cm', 0, 'a25025fb21c74b79b11aa52d562faa44'),
(411, '286db24f735e4cd9a8dab98845027cd1', '118 m 2 cm', 0, 'a25025fb21c74b79b11aa52d562faa44'),
(412, 'ee8defc0fc3a47cfa2851f92d429131a', '118 m 20 cm', 0, 'a25025fb21c74b79b11aa52d562faa44'),
(413, '4c766c753b5548c898f14f49aa9cbfe2', '21 m  32 cm', 1, 'd9fd4e7f42044339b3987453c9fe487f'),
(414, '34c032ba6f0c4b4c8632433bc5a1a656', '21 m 42 cm', 0, 'd9fd4e7f42044339b3987453c9fe487f'),
(415, '8d20d5e232fa4dadbd973fd3c745262d', '20 m 32 cm', 0, 'd9fd4e7f42044339b3987453c9fe487f'),
(416, '6fc8a125ac9e4abeb1281aaa41cbe5f2', '20 m 132 cm', 0, 'd9fd4e7f42044339b3987453c9fe487f'),
(417, '0a962d3000de466ebfc17ca65d680194', '1 m 9 cm', 1, '02b7ac47c567464d81244ff876146ae2'),
(418, '8955d4a331744af7a90a85f5f19efc80', '1 m 8 cm', 0, '02b7ac47c567464d81244ff876146ae2'),
(419, '323f6be2fa314355988bfbe60576285b', '0m 90cm', 0, '02b7ac47c567464d81244ff876146ae2'),
(420, '31d85646118c4fe6bdef629875e78658', '1 m 190 cm', 0, '02b7ac47c567464d81244ff876146ae2'),
(421, '06d460d63dda47a0957e2b1968908770', '2', 1, 'a65360e2cf5d40539d1c09957efb2ee2'),
(422, '7551401948e54149ac24cc2e08937719', '4', 0, 'a65360e2cf5d40539d1c09957efb2ee2'),
(423, '7981015fd7fa4cdba044b8cedfd00da2', 'one and a half', 0, 'a65360e2cf5d40539d1c09957efb2ee2'),
(424, '2dd7983134c64b6895dfb6a61d2751bb', '3', 0, 'a65360e2cf5d40539d1c09957efb2ee2'),
(425, 'e23eb0e0cd3f473b9ec411b2e245d79d', '12', 1, '15a26398b7fd49339afba8043556b62e'),
(426, '21d8c50b4c524b5cb4a8445ceb8a9c04', '3', 0, '15a26398b7fd49339afba8043556b62e'),
(427, '821819e9df8645a8860dd1f79f16c3c6', '24', 0, '15a26398b7fd49339afba8043556b62e'),
(428, '3781f18aa8e143b4b5073a1dac80465e', '8', 0, '15a26398b7fd49339afba8043556b62e'),
(429, '398f8754557e4a3999ba435b5b6bbd7c', 'They are equally heavy', 1, '6feea713e84945a0b77485d6479416e1'),
(430, '5df873319064482b814e6fbe7e997f2a', 'Fertilizer', 0, '6feea713e84945a0b77485d6479416e1'),
(431, 'c8b133afc12344d9b85a3613eeb993b1', 'Feathers', 0, '6feea713e84945a0b77485d6479416e1'),
(432, '6e4d6158b8fe47b785b3d932bcc8e429', 'None of the above', 0, '6feea713e84945a0b77485d6479416e1'),
(433, 'c9d1d1e9964a44fc91876716594cc237', '8', 1, 'c79c3b7fc31e4f0da3a85b799840d551'),
(434, 'c569a7f10ac2432b99a3e3585b1a901f', '4', 0, 'c79c3b7fc31e4f0da3a85b799840d551'),
(435, '8c5a745367854f25a2f000c6e336a943', '1/2', 0, 'c79c3b7fc31e4f0da3a85b799840d551'),
(436, '0f208a66c45f4e06b50af17015a0d3a4', '6', 0, 'c79c3b7fc31e4f0da3a85b799840d551'),
(437, 'caed402f5d534442a6149bb8a064d5db', '4', 1, 'b5f310dfb3ce4e6495787ad1470f968b'),
(438, '4db88d3b16154075a30071047c239251', '3', 0, 'b5f310dfb3ce4e6495787ad1470f968b'),
(439, 'dd2011a3e0af433592acc6c4de896daa', '7', 0, 'b5f310dfb3ce4e6495787ad1470f968b'),
(440, '0b691a0f079f494c96977eab7d5344a4', '10', 0, 'b5f310dfb3ce4e6495787ad1470f968b'),
(441, '601070e1c4c448f38c6f0f57d5f4614f', '9 3/4 kg', 1, '8be4212e46384c7c9f635346b4d38e91'),
(442, '36b18bf75dfe4512ab520aa393bf344a', '9 1/2 kg', 0, '8be4212e46384c7c9f635346b4d38e91'),
(443, '09ef608de6954f46adb502caf1648a0e', '10 kg', 0, '8be4212e46384c7c9f635346b4d38e91'),
(444, '45e2c241901248aaa26a24f87bdfdbd3', 'None of the above', 0, '8be4212e46384c7c9f635346b4d38e91'),
(445, '0dfed2ffc123436988ad23bff6c52bbd', '10', 1, '5fbe37ddf05e47dea877754e189edfd2'),
(446, '50968c04b8b1466e9e6d356f7467e4b8', '2.5', 0, '5fbe37ddf05e47dea877754e189edfd2'),
(447, 'eeb169e3d9074839b5b5bd00bbf3407d', '20', 0, '5fbe37ddf05e47dea877754e189edfd2'),
(448, 'e579b7a549d74e3fa81fa965b17ad651', '25', 0, '5fbe37ddf05e47dea877754e189edfd2'),
(449, '3c493d3ff9814932b847e7d1d767b9fd', '2 3/4 litres', 1, '1f45262543f14871a9b8fc627f924b92'),
(450, 'b1cee41a85e644e99457188f3b31056f', '3 1/2 litres', 0, '1f45262543f14871a9b8fc627f924b92'),
(451, 'f04f8b67f1f74518aedc377161fcc0be', '2 1/2 litres', 0, '1f45262543f14871a9b8fc627f924b92'),
(452, 'a4da23d15442444b90e28f390d5a5428', '3 litres', 0, '1f45262543f14871a9b8fc627f924b92'),
(453, '9d28bd29886848a691831f6034c3e05d', '9 1/4 litres', 1, 'ce2f100c5adf4113a1819bba406ab998'),
(454, '450eef0d09c449b194d22983321f9113', '8 1/4 litres', 0, 'ce2f100c5adf4113a1819bba406ab998'),
(455, 'a388c5a0768544d5912d78fbb6d6f14f', '9  1/2 litres', 0, 'ce2f100c5adf4113a1819bba406ab998'),
(456, '799984c9363047d3b722892be2aa969f', '9 3/4 litres', 0, 'ce2f100c5adf4113a1819bba406ab998'),
(457, '88e3c2fa009c44ccb954978fe4837f52', '6', 1, '6a591ef4c2854d3c8fedc9face95302f'),
(458, '031834b6988944748e7bee4b90dc34e5', '8', 0, '6a591ef4c2854d3c8fedc9face95302f'),
(459, 'a202055fc60643ecbe182de45c4cba1a', '4', 0, '6a591ef4c2854d3c8fedc9face95302f'),
(460, '15d10e3fc10c4d7fb97f1a9585df5f8a', '10', 0, '6a591ef4c2854d3c8fedc9face95302f'),
(461, 'f3da7ab125114d4aba6ad3b6991bc653', '21', 1, '9bacbe07c976454aae7560ba58f7f847'),
(462, '51ceb83f55804a369a5d7ca09408d708', '10', 0, '9bacbe07c976454aae7560ba58f7f847'),
(463, 'a74db9c892bd42bdb450bc80ced0e5b5', 'A month', 0, '9bacbe07c976454aae7560ba58f7f847'),
(464, 'ae7c06781a504898a0a4f1d59dda6ae3', '22', 0, '9bacbe07c976454aae7560ba58f7f847'),
(465, '8489c674def642d8b60d83c287c37f9d', '28 days', 1, '6eff4299369a4932ac95906cba951fd5'),
(466, '409a0a082f37401ea8baec9e73dedc23', 'I month', 0, '6eff4299369a4932ac95906cba951fd5'),
(467, 'e7aeeb576e3e4359ac51f81c3b6e3979', '21 days', 0, '6eff4299369a4932ac95906cba951fd5'),
(468, '62d7e3a5837845189501cc453c1c6f9b', '31 days', 0, '6eff4299369a4932ac95906cba951fd5'),
(469, 'd8d5808a0cd649098e716d8cb7c2d880', 'P.M', 1, '5973546bc4334ae8a5b347dacfd19527'),
(470, '4354c9461aa24a7d98f24afdff9187d4', 'A.M', 0, '5973546bc4334ae8a5b347dacfd19527'),
(471, '971accba041e4748a06a353b863bb48f', '24 Hours ', 0, '5973546bc4334ae8a5b347dacfd19527'),
(472, '255f60f6469a49af940707812fc0ba15', 'Night Time (N.T)', 0, '5973546bc4334ae8a5b347dacfd19527'),
(473, 'f0528d7a034a4f999949ca417a2bf1f3', 'p.m', 1, 'db4f14314f8c4a22b9b473593d83240e'),
(474, '22d3fb67a3444baa86011df2bd960ee3', 'a.m', 0, 'db4f14314f8c4a22b9b473593d83240e'),
(475, '4895fa8683514c56a0e5727598375775', 'all of the above ', 0, 'db4f14314f8c4a22b9b473593d83240e'),
(476, 'c0dbc68ddd204759ae6af4dadc9d8d45', 'none of the above', 0, 'db4f14314f8c4a22b9b473593d83240e'),
(477, 'a78ddbcc63304ab0942d83fb87a0f812', '49 minutes', 1, '37dc94bf57614fd593a10284dd27d641'),
(478, '74cb76a3c6664bee82f8e92bd724e527', '39 minutes', 0, '37dc94bf57614fd593a10284dd27d641'),
(479, '89d9953d13164818bc453ca1fe15a6e3', '89 minutes', 0, '37dc94bf57614fd593a10284dd27d641'),
(480, 'b3bd5c6be9854382aa45ee8ac4e8ab2c', ' 59 minutes', 0, '37dc94bf57614fd593a10284dd27d641'),
(481, '283fc966806a487c952924522390eeec', '237', 1, '1e5b987848344faf804289cd1d520471'),
(482, '1764e458a576448ba259f51b3375f3f4', '337', 0, '1e5b987848344faf804289cd1d520471'),
(483, '4629ac34551347afb171068040de7e38', '357', 0, '1e5b987848344faf804289cd1d520471'),
(484, 'ab0ca84a97bf427887db82be90729a98', '227', 0, '1e5b987848344faf804289cd1d520471'),
(485, '7257602cc5014c57ae4dee6049ca0471', '3 hours 38 minutes', 1, '474650dc884d431cbb3225ebd18348fa'),
(486, '0ad7b125c6b74084907b3261d5342f1c', '2 hours 18 minutes', 0, '474650dc884d431cbb3225ebd18348fa'),
(487, '4b545f21db9947919e1bc6c4abdb46a6', '3 hours 28 minutes', 0, '474650dc884d431cbb3225ebd18348fa'),
(488, '8e95972242674522abd92adbca21e097', '3 hours  48 minutes', 0, '474650dc884d431cbb3225ebd18348fa'),
(489, '133327b56e3d4e5a94c3899ba8c6399e', '4', 1, '8330b2648f514ebc8dc977023e38f91e'),
(490, '8463a1ec6c2647308153aa705f7a80e9', '1 month', 0, '8330b2648f514ebc8dc977023e38f91e'),
(491, '423c917e81f64ebf95287aed14467aed', '6 weeks', 0, '8330b2648f514ebc8dc977023e38f91e'),
(492, '24d545012e934d7796d993c95a554d78', 'None of the above', 0, '8330b2648f514ebc8dc977023e38f91e'),
(493, '3652c619630b433e8a8aa153a90cbe2b', '72', 1, '98e24a665bf3455a9b267e41ecc64b11'),
(494, '19d01207d7334db584913dc4ef5f190a', '62', 0, '98e24a665bf3455a9b267e41ecc64b11'),
(495, '63900e9202c34d9382090fa3881ab958', '84', 0, '98e24a665bf3455a9b267e41ecc64b11'),
(496, 'ad976da63ea44c7fa021f4a33e557529', '82', 0, '98e24a665bf3455a9b267e41ecc64b11'),
(497, '4f605b1f0b01409f828f4de9570b7658', '4 days', 1, 'c400b758ab5d49498ae7b93ec16c43dc'),
(498, '62c09449ef9443e5beb14dedc0582aa0', '5 days', 0, 'c400b758ab5d49498ae7b93ec16c43dc'),
(499, '875cc74f1f204411a806336a1174933a', '3 days', 0, 'c400b758ab5d49498ae7b93ec16c43dc'),
(500, 'ee9322802a304f2688cae8dc31cb9300', '1 week', 0, 'c400b758ab5d49498ae7b93ec16c43dc'),
(501, 'fb7b0c728046464eb9869ba3e2b1fac8', '31', 1, '562eceb3ad1a4416923681a0ea8c4212'),
(502, '5e1c9858986d47a5abc6943aee6ddd98', '30', 0, '562eceb3ad1a4416923681a0ea8c4212'),
(503, '9e5a69be0f194fe9b08038367e12c2f5', '29 on a leap year', 0, '562eceb3ad1a4416923681a0ea8c4212'),
(504, '7d4af672ca38466c9551cb40c3ae82a0', '32', 0, '562eceb3ad1a4416923681a0ea8c4212'),
(505, '6cef2814e6084e53922a66b02b0ed372', '29', 1, 'c639ac0e12c64a71bc5e1bfffa35deb0'),
(506, '294fc14b89934c549ea81a530fce035c', '28', 0, 'c639ac0e12c64a71bc5e1bfffa35deb0'),
(507, '01da4028a8df41369ba192f60d73797d', '31', 0, 'c639ac0e12c64a71bc5e1bfffa35deb0'),
(508, 'a4b2819d76824abc8538a555d0fe8f5e', '30', 0, 'c639ac0e12c64a71bc5e1bfffa35deb0'),
(509, '409dfccad19b45168719d826daac2ffa', '28', 1, '8e77e3b475ec4d2ca2bdca12d1c0fce1'),
(510, 'd86e1b148ce441beba9e84eab63762b3', '29', 0, '8e77e3b475ec4d2ca2bdca12d1c0fce1'),
(511, 'd49a2fb604f949bc9f86d2c55b757c1d', '31', 0, '8e77e3b475ec4d2ca2bdca12d1c0fce1'),
(512, 'e200e52008d3474c889123da5ae8caa7', '30', 0, '8e77e3b475ec4d2ca2bdca12d1c0fce1'),
(513, '01b8ddfa3c5947f1b9324837d0b98f34', 'January, July, August', 1, '4f48ed6576964f0595db33cb525a26cf'),
(514, '3067bc730b5e48fc835bea6f49db1c67', 'December, June, May', 0, '4f48ed6576964f0595db33cb525a26cf'),
(515, '255bd48c2aa94710a577faa308a9add7', 'November, July, January', 0, '4f48ed6576964f0595db33cb525a26cf'),
(516, 'c25a0bec4b48424bb3b1010c97802177', 'February, June, September', 0, '4f48ed6576964f0595db33cb525a26cf'),
(517, '7f66dab089eb42eaa509b03eccdd2818', 'June, November, September', 1, '6a9c340f3d674830909a2f2286aedc43');
INSERT INTO `exams_topicalquizanswers` (`id`, `uuid`, `choice`, `is_correct`, `quiz_id`) VALUES
(518, 'b1cdd9c8a8a449ff93f99357e2460c8a', 'February, November, June', 0, '6a9c340f3d674830909a2f2286aedc43'),
(519, '3375b1b103cb42d0be21c665dc555aae', 'April, July, November', 0, '6a9c340f3d674830909a2f2286aedc43'),
(520, '5286eae9ca794de59b9a4b2cf8a308e2', 'October, August, June', 0, '6a9c340f3d674830909a2f2286aedc43'),
(521, '1ac8f925462a493dba138ee73c5fcd29', '2012 and 2016', 1, 'fde2905c9d804f3a928f011f80d2c7ac'),
(522, 'fc2af2fbf32047ee829db71c3bd97049', '2010 and 2012', 0, 'fde2905c9d804f3a928f011f80d2c7ac'),
(523, 'f5049995e2104d36be02fa5008e20de8', '2012 and 2014', 0, 'fde2905c9d804f3a928f011f80d2c7ac'),
(524, '8d87e3a4828b4610a320c0188c842fd9', '2016 and 2024', 0, 'fde2905c9d804f3a928f011f80d2c7ac'),
(525, 'b08dc426c7884689a8b1c7b0eea36927', '1 year 10 months', 1, 'bf36149cc4234205906a286776f6a0b7'),
(526, '312f9b550174441ea8d5c44dae855b5c', '2 years', 0, 'bf36149cc4234205906a286776f6a0b7'),
(527, 'abb3e3a18f6041f6a0700348ea082422', '1 year 11 months', 0, 'bf36149cc4234205906a286776f6a0b7'),
(528, '4491ca1638004efca457ddf722ae754e', '1 year 2 months', 0, 'bf36149cc4234205906a286776f6a0b7'),
(529, 'edf1234578c441b3969989c07c0c13aa', '41', 1, 'd81c525d95364c13abe5c20bd9406877'),
(530, '4c04fb85ce2547d981ac69af5e618049', '35', 0, 'd81c525d95364c13abe5c20bd9406877'),
(531, '406ac87acd3b4ce0b7620fc72a2a8858', '38', 0, 'd81c525d95364c13abe5c20bd9406877'),
(532, '04ac09236dd6448580020d0345c8eae4', '31', 0, 'd81c525d95364c13abe5c20bd9406877'),
(533, 'd707441027484437980c0723003ea6f6', '700 cents', 1, '2949177d863a490bbb94b47538817048'),
(534, '9a81aca095bc47be9b61659d3d49b747', '70 cents', 0, '2949177d863a490bbb94b47538817048'),
(535, 'ca97fb0d89884aa29cf6def6fc828835', '0.007 cents', 0, '2949177d863a490bbb94b47538817048'),
(536, '30fcf40b4c33484d8abc4b75b9d8d428', '0.07 cents', 0, '2949177d863a490bbb94b47538817048'),
(537, 'acf554ba651c4c4e813b39bf95b0c588', '6.77 sh', 1, '6493c957b09941f498442def6f3b071b'),
(538, '7fc2a978bca64c88ab980b36c2cfc488', '67.7 sh', 0, '6493c957b09941f498442def6f3b071b'),
(539, '88af04f76f1144b893a804af23fde514', '0.677 sh', 0, '6493c957b09941f498442def6f3b071b'),
(540, 'b416691c222442ce9b0d8b694c80b132', '6770 sh', 0, '6493c957b09941f498442def6f3b071b'),
(541, 'c1eb8163030f4b8a9344733ce74a341e', '100', 1, '531423fd6cc34d5ea84d8e62f3155c98'),
(542, 'a229869204e94a1bb8db8e78e3104948', '10', 0, '531423fd6cc34d5ea84d8e62f3155c98'),
(543, 'ff444d37554e46d7bb63adc65047a55b', '1000', 0, '531423fd6cc34d5ea84d8e62f3155c98'),
(544, '384707ca53ec478ca00b5cb9914cdfa8', '1', 0, '531423fd6cc34d5ea84d8e62f3155c98'),
(545, 'd04dfc4309364ab98ed7595362c42b5e', '100', 1, '3f6d18d432414b9b83dc5bdb895e5312'),
(546, '828e09f535c043af88f376184868a8f8', '10', 0, '3f6d18d432414b9b83dc5bdb895e5312'),
(547, 'c4ffe998580949c99eacf7492dc73860', '1000', 0, '3f6d18d432414b9b83dc5bdb895e5312'),
(548, 'd70e9508f0c1430e9da176c930f07fa0', '0.001', 0, '3f6d18d432414b9b83dc5bdb895e5312'),
(549, '03023003c61b4634802b356fa3006cbd', '66 shillings 7 cents', 1, 'e28135f8b5c54355a6cac8f39fdbd1bb'),
(550, '9854337200e44e6cab68b4a422244491', '65 shillings 7 cents', 0, 'e28135f8b5c54355a6cac8f39fdbd1bb'),
(551, 'bf5f6511a3ad416f8a5ca4fce34472a5', '65 shillings 107 cents', 0, 'e28135f8b5c54355a6cac8f39fdbd1bb'),
(552, 'cb8a78ede2a04153b14a1b283dd1e883', '66 shillings 107 cents', 0, 'e28135f8b5c54355a6cac8f39fdbd1bb'),
(553, '123ca80d09d94402a861f25913e32545', '78 shillings 68 cents', 1, '3a52bc7ad0e342af9d59ee83ee694010'),
(554, '4fed8d00d24c460d9688a2bf41880d34', '77 shillings 68 cents', 0, '3a52bc7ad0e342af9d59ee83ee694010'),
(555, 'e0f1a4e7206b4c30a2cb09a9ded6fe5d', '79 shillings 68 cents', 0, '3a52bc7ad0e342af9d59ee83ee694010'),
(556, 'd69fd7b303dc4c5fa0e29f9aab47e947', '78 shillings 58 cents', 0, '3a52bc7ad0e342af9d59ee83ee694010'),
(557, 'd9c7f4d939674779bf58b8f207edfa8c', 'Clockwise', 1, '99d73d7b89d74ae18d7b848cce65aa00'),
(558, 'fd1806c96ab146a19dd1e6c9688ceeea', 'Anti-clockwise', 0, '99d73d7b89d74ae18d7b848cce65aa00'),
(559, '1e3c91134b3f42158bd7c74237b32457', 'Circle', 0, '99d73d7b89d74ae18d7b848cce65aa00'),
(560, 'ddb268502abd4eb59725b3888f078cf7', 'Straight line', 0, '99d73d7b89d74ae18d7b848cce65aa00'),
(561, 'eaa658ad0d724d96ae81ef9a50ce5381', 'Triangle', 1, 'fe53534dc9b249f4b0933896f445ffe1'),
(562, 'bd25c9954bd84582bd7882458bae1041', 'Obtuse', 0, 'fe53534dc9b249f4b0933896f445ffe1'),
(563, 'd6ac9b634e70478da87d4f5b24f02155', 'Acute', 0, 'fe53534dc9b249f4b0933896f445ffe1'),
(564, 'c2d666df6f4143929230588bb6785517', 'Right', 0, 'fe53534dc9b249f4b0933896f445ffe1'),
(565, '62ea3690446c475bb55bc17b9dcd3017', 'Obtuse', 1, 'e444ce0be4d6430e8724efd89bc78777'),
(566, 'bc1a7d94823448b9aef4b69261ecbc40', 'Acute', 0, 'e444ce0be4d6430e8724efd89bc78777'),
(567, 'c207367c298c455d80fe61a75ec0fc53', 'Right', 0, 'e444ce0be4d6430e8724efd89bc78777'),
(568, '2d936c38ffb249e1a38cc5dd730e7141', 'Left', 0, 'e444ce0be4d6430e8724efd89bc78777'),
(569, 'bf4039f47b254810a933ce57afa07bf0', '90', 1, 'ea5a7302adba4abe871e81d792a2d138'),
(570, 'ccaedd22dab449f1b16aaf54af0e8ef7', 'Less than 90', 0, 'ea5a7302adba4abe871e81d792a2d138'),
(571, 'dfd3ab23be97493fa2fa88db3ad5a77d', 'Bigger than 90', 0, 'ea5a7302adba4abe871e81d792a2d138'),
(572, '1dd78462e81e4bebba3aebad3b83518b', '180', 0, 'ea5a7302adba4abe871e81d792a2d138'),
(573, '1dbd673125c7478a90eb52cbda2c8809', 'Acute, Right, Obtuse', 1, '84dbb9a84d7d4657aad03e8eacb4df12'),
(574, '4520d1e2bee84c538a16aa6d44e0a6b5', 'Obtuse, Right, Acute', 0, '84dbb9a84d7d4657aad03e8eacb4df12'),
(575, '24ddfacdff5342da82c9443cfa797db0', 'Acute, Obtuse, Right', 0, '84dbb9a84d7d4657aad03e8eacb4df12'),
(576, 'e8c9f612f7a944499b67908ab1c66ccc', 'Right, Acute, Obtuse', 0, '84dbb9a84d7d4657aad03e8eacb4df12'),
(577, 'a6922037e58e493f9a61c270f7ddc1b0', 'Angles greater than 180 but less than 360', 1, '345721e95ce448fdb1aaa9f9e9d4d3f4'),
(578, '4980b463823e4c03956d709256b0c6f0', 'Angles Greater than 180', 0, '345721e95ce448fdb1aaa9f9e9d4d3f4'),
(579, '24434424c7704028b68977657e0a53f3', 'Angles less than 180', 0, '345721e95ce448fdb1aaa9f9e9d4d3f4'),
(580, 'ec9da6a7212f46c4ad7471ecddb0e14f', 'None of the above', 0, '345721e95ce448fdb1aaa9f9e9d4d3f4'),
(581, 'ff3335d8d4674d2984a4c4b2144abb58', 'Acute', 1, '637caacf57be4fc985082f8b2bfa2265'),
(582, 'd700d40946794975b7aa9c2df0e1ff24', 'Obtuse', 0, '637caacf57be4fc985082f8b2bfa2265'),
(583, '1d6a1bcd6bfc4c7ba9be17eac39d8fb9', 'Reflex', 0, '637caacf57be4fc985082f8b2bfa2265'),
(584, 'd234b29090814c29ab2d830060870d4d', 'Right', 0, '637caacf57be4fc985082f8b2bfa2265'),
(585, '4c51a64394934e15a945f70788108ae8', 'Square', 1, '7ad8837394eb4fb2bf8bc5e3ab205d1f'),
(586, '9501d6881a534d52b82844fccb030029', 'Rectangle', 0, '7ad8837394eb4fb2bf8bc5e3ab205d1f'),
(587, '22f170bd807a45fb9f8dd35c306d1e99', 'Triangle', 0, '7ad8837394eb4fb2bf8bc5e3ab205d1f'),
(588, '32d2fc3989694c3bb32489d965c7c366', 'Straight line', 0, '7ad8837394eb4fb2bf8bc5e3ab205d1f'),
(589, 'deeae00e327b4e0ea6395a9d846a076a', 'Straight line', 1, 'ab644f06314c43438043188ce17b2987'),
(590, '3918d00e6c7642d68b44e1c2ae759bbc', 'Horizontal line', 0, 'ab644f06314c43438043188ce17b2987'),
(591, '68d10b4ef8064c34a89f2931ef497335', 'Vertical line', 0, 'ab644f06314c43438043188ce17b2987'),
(592, 'a74c3decf9244e9eb4ac0a18f0071e1b', 'Diagonal line', 0, 'ab644f06314c43438043188ce17b2987'),
(593, '49e98972e8bd4cf3a42db5f6aad7cf68', 'Vertical', 1, 'e666cb5875b14025a17b151af5526ffa'),
(594, '0653c521205b4cdab4ff98589aae2fe2', 'Horizontal', 0, 'e666cb5875b14025a17b151af5526ffa'),
(595, '4c80e792626346348a90ef7a1555ef24', 'Straight line', 0, 'e666cb5875b14025a17b151af5526ffa'),
(596, '40b99e332da3413da7000be72b689b62', 'Diagonal', 0, 'e666cb5875b14025a17b151af5526ffa'),
(597, '1812799a80f049c0b572ec0d4653d8ed', 'All sides are equal', 1, 'f6925e7b51764d3291e5ad1e33ac592e'),
(598, '2af9eb180c9e4fb3b692b7beb048a33d', 'The height and width are different from each other', 0, 'f6925e7b51764d3291e5ad1e33ac592e'),
(599, 'c5e322429c154042bac8c79be004da94', 'All angles add up to 360', 0, 'f6925e7b51764d3291e5ad1e33ac592e'),
(600, '09cb98b0fe4f46d4942a76ee601016d5', 'All lines intersect to form right angle', 0, 'f6925e7b51764d3291e5ad1e33ac592e'),
(601, '2fa11698b9d7486c98f5c9413fc230b7', 'All angles are equal', 1, '8e50fc4d5da14a4385fcaa58d3da428f'),
(602, '8af6d4b5934c4078a3f60c8d5f4d78f1', 'All angles add up to 360', 0, '8e50fc4d5da14a4385fcaa58d3da428f'),
(603, 'bcd047c9820c428bbfc401003b424949', 'It has three sides', 0, '8e50fc4d5da14a4385fcaa58d3da428f'),
(604, 'a6caaf6517db450f8266e926045d6b9b', 'all of the above ?', 0, '8e50fc4d5da14a4385fcaa58d3da428f'),
(605, '28ced2c67b9a4990884e63a45bcc0757', 'Hundreds of thousands and  Thousands', 1, 'f05314291b91449cbe1a1d5daefc6600'),
(606, 'be4f15710f8f4fcc98a3a077a268be2e', 'Hundredth of thousands and tens of thousands', 0, 'f05314291b91449cbe1a1d5daefc6600'),
(607, 'ddf8c770200949ba94d53a44a0e0d911', 'Tens of thousands and Thousands', 0, 'f05314291b91449cbe1a1d5daefc6600'),
(608, '5b386263a026438389a9af28b44e8f1d', 'Thousands and Hundreds of thousands', 0, 'f05314291b91449cbe1a1d5daefc6600'),
(609, '07e1c2d2e8ce4e56bc027f66f8ee9eb7', '303 003', 1, 'cae318703dba40d2af826672b8366b80'),
(610, 'b0cc4d416e334a5ab615f6ea70185894', '300 003', 0, 'cae318703dba40d2af826672b8366b80'),
(611, '0f99c4dbde1c4eb9b5fc68b0b1703f04', '033, 003', 0, 'cae318703dba40d2af826672b8366b80'),
(612, '6703fdad74c645b4834b4916dc40e88d', 'None of the above', 0, 'cae318703dba40d2af826672b8366b80'),
(613, '91bce5eb72e04a9cbd53563ae4022e7d', '715 101', 1, '809af93a20724e37b2aec6dae1f3aa48'),
(614, 'f7f85b0eba444190887b5f28b2fb672d', '715 001', 0, '809af93a20724e37b2aec6dae1f3aa48'),
(615, '08e290e0920948189fdec0f8f460aeaa', '750 101', 0, '809af93a20724e37b2aec6dae1f3aa48'),
(616, 'a03875fdfde54917a396a7960eac9c15', '701 151', 0, '809af93a20724e37b2aec6dae1f3aa48'),
(617, '17955b77d88948b78c5f8c24abf72c78', '270', 1, '3a27382f9c4940b588449e30fcbd2897'),
(618, '4a93901d33474ac8ad6adaa31ff54612', '265', 0, '3a27382f9c4940b588449e30fcbd2897'),
(619, 'eb667c4758e34ed69645bcd6aca93865', '260', 0, '3a27382f9c4940b588449e30fcbd2897'),
(620, 'cb1219b0aef647eab44784d513af7f61', '300', 0, '3a27382f9c4940b588449e30fcbd2897'),
(621, 'a4695772c060453b9f2c4e93eab49f02', '4 190', 1, '754bff2331fc41a797b8353ad37f092c'),
(622, 'aac430f632ad45e99aad05f41a98eaa1', '4 200', 0, '754bff2331fc41a797b8353ad37f092c'),
(623, '692fa89728b24ccd89aea76915ec1e89', '4 195', 0, '754bff2331fc41a797b8353ad37f092c'),
(624, 'cb9a9a5fd45a4bcfa6a3e61574d3c269', '4 199', 0, '754bff2331fc41a797b8353ad37f092c'),
(625, '0f427e83baf44f01b10fcf35a9dfc307', '7 000', 1, '01dfd877879444c481548df6452d5c95'),
(626, '10d7fec4305a40f79542b0ffc6573152', '6 999', 0, '01dfd877879444c481548df6452d5c95'),
(627, '2efed86ebb254aa18fd5d6ec0c005647', '6 990', 0, '01dfd877879444c481548df6452d5c95'),
(628, 'd09a65c82fba4b07aedbe00e8263a55b', '6 900', 0, '01dfd877879444c481548df6452d5c95'),
(629, '2400c7817b654bfc8129a026e226f456', '8 500', 1, '00ea73b3472e4c28b26914b19b508a66'),
(630, '0f1a19332f4b4c279adeec6eb273b357', '8 400', 0, '00ea73b3472e4c28b26914b19b508a66'),
(631, '023380656294497fac637f1c4b1457ad', '8 450', 0, '00ea73b3472e4c28b26914b19b508a66'),
(632, 'b71addc40ff44d65bf6b9ba1d30170f3', '8 460', 0, '00ea73b3472e4c28b26914b19b508a66'),
(633, 'c02e70d4ebc54bb2abe7c918a519af95', '67 000', 1, '024863521d044198a5c26ecea7ba54b1'),
(634, 'b10de9fd112c4d9095bc7c175e11cd1f', '68 000', 0, '024863521d044198a5c26ecea7ba54b1'),
(635, '6117dbe5384140158c09fe1ff01dcdc8', '67 400', 0, '024863521d044198a5c26ecea7ba54b1'),
(636, '7f12ac17ae274ccdb156a9a5acadcb0a', '67 500', 0, '024863521d044198a5c26ecea7ba54b1'),
(637, '9f5bfa6bf90d45b4857f0e228b04bbc6', '600 000', 1, 'b72e64949672452797593ff86d526e67'),
(638, '513bbb4c3709439b88cbdf6601fadd5b', '60 000', 0, 'b72e64949672452797593ff86d526e67'),
(639, 'bd2387508a9a40aa92f62bf8c78bd5c4', '6 000 000', 0, 'b72e64949672452797593ff86d526e67'),
(640, '5c388b2c4cf5422491f17532d0072eeb', '6000', 0, 'b72e64949672452797593ff86d526e67'),
(641, 'b6a4d9885b344f23a2320d6fa2462f86', 'five hundred and sixty seven thousand seven hundred and eighty nine', 1, '87da34be53f8416085d17bab89e7be3e'),
(642, '6050b1daff524d9690dcf9e98d750145', 'Five hundred thousand sixty seven seven hundred and eighty nine', 0, '87da34be53f8416085d17bab89e7be3e'),
(643, '7f3a1af74e154eb5a77da4c7924ca8e9', 'Ffty six thousand seven seven hundred and eighty nine', 0, '87da34be53f8416085d17bab89e7be3e'),
(644, 'eff467335f8946c4a130892071ae54c6', 'None of the above', 0, '87da34be53f8416085d17bab89e7be3e'),
(645, 'e9f1185b2db9469a8df5c56e8114a56e', '67 802, 6 626, 43 060', 1, '919855e6a33e4ed18287ce434173649b'),
(646, '88b1355ff67b4d328764f07e7e2353d3', '5 789, 5 678, 8 456', 0, '919855e6a33e4ed18287ce434173649b'),
(647, 'de7375fb5bff44efad60465fc236cbd6', '5 322, 678, 105', 0, '919855e6a33e4ed18287ce434173649b'),
(648, '5c2a527fcc82452cb5c6c4b568e5f97c', '678, 8904, 9 873', 0, '919855e6a33e4ed18287ce434173649b'),
(649, '3e0099cf0d4b44e5aaafcc676d6dcd36', '560, 5 670, 23 670', 1, '9632c14549a04b6a89c71ed25c15dabb'),
(650, '502cefb4664449c29230eb1061896e2f', '155, 7320, 5 670', 0, '9632c14549a04b6a89c71ed25c15dabb'),
(651, '9cd422e5d3ad4f0995279b358760eeed', 'None of the above ', 0, '9632c14549a04b6a89c71ed25c15dabb'),
(652, '47c1ff3adeb14ff2b4fb707e35056b31', 'All of the above', 0, '9632c14549a04b6a89c71ed25c15dabb'),
(653, '8374268f01664ac0968bddb4f4d415fc', 'its last digit is 0 or 5', 1, '7c7ec322969d42bd83562df89c373f7d'),
(654, 'aab564e6182a41e8aac6cbf11e8e2cab', 'the last digit is an odd number', 0, '7c7ec322969d42bd83562df89c373f7d'),
(655, '699a5325366b4576b996b4c9caff5366', 'the last digit is an even number', 0, '7c7ec322969d42bd83562df89c373f7d'),
(656, '4cea0166fb3b4852a749ef514fce8e3e', 'the last 2 digits are divisible by 5', 0, '7c7ec322969d42bd83562df89c373f7d'),
(657, '6e318522edbe4d80940f823742a5163e', '934 492', 1, '81b5afc7301048b595bdd87718926c43'),
(658, 'bbf4a81e74974894b2602910485a610f', '924 482', 0, '81b5afc7301048b595bdd87718926c43'),
(659, '54d504f4df9341498e526b65829523ff', '934 482', 0, '81b5afc7301048b595bdd87718926c43'),
(660, '79ed7cf9d1ea41c19003473abcd78499', '944 492', 0, '81b5afc7301048b595bdd87718926c43'),
(661, '8212e350357c4bf38b61a2b3d2bfef7a', '505 816', 1, '3016c264f4d84d53a35e2533b2004ce5'),
(662, '5108582a6c9b4061b1c6f26e5d558024', '504 716', 0, '3016c264f4d84d53a35e2533b2004ce5'),
(663, '1cc00a7138614086876ca2951fa9004a', '505 716', 0, '3016c264f4d84d53a35e2533b2004ce5'),
(664, '6339301325974d2aab9d3328f7e4356b', '504 816', 0, '3016c264f4d84d53a35e2533b2004ce5'),
(665, '5cfaf43338c3423b8d7195a1572cb9cf', '169 435', 1, '2e6a890e2c8343e79a63a3d09ffdda04'),
(666, 'bb471b33f055452a8d4d02862593c164', '179 445', 0, '2e6a890e2c8343e79a63a3d09ffdda04'),
(667, 'fa31c924bc2140f5a97914ea5eda8df4', '179 435', 0, '2e6a890e2c8343e79a63a3d09ffdda04'),
(668, '4cbd1b8332324180ac1b49aa5b022ae5', '863 013', 0, '2e6a890e2c8343e79a63a3d09ffdda04'),
(669, '892ff502bc7e4e319bc60d7362f7a164', '479 496', 1, '1dd1b0e4910643e4a052a5b7b400bd7e'),
(670, '35355305e52f40b19eb1d19e1861fd95', '479 486', 0, '1dd1b0e4910643e4a052a5b7b400bd7e'),
(671, 'd6fa9d691f8b431b9d8a06c17ea1f427', '489 486', 0, '1dd1b0e4910643e4a052a5b7b400bd7e'),
(672, 'cd5f7dd70f184f889693581ccd617725', '1 136 504', 0, '1dd1b0e4910643e4a052a5b7b400bd7e'),
(673, 'db991fe28eb64dc5a471f3e6e742cfb3', '92 613', 1, 'f9cccaf95eec409da5d467e64a3dc16f'),
(674, '87851c18b78e40b7a6dd4d616c924da3', '93 713', 0, 'f9cccaf95eec409da5d467e64a3dc16f'),
(675, '42128c635783436f93feddde83c98215', '92  623', 0, 'f9cccaf95eec409da5d467e64a3dc16f'),
(676, 'fdf331edc1fb4c1e834133b2c8f349e4', '93 613', 0, 'f9cccaf95eec409da5d467e64a3dc16f'),
(677, '5ff0692b72a14ca79ede796cf5b24f92', '4 312', 1, '933716cd8fa44920811ff616ba68be37'),
(678, '9e2ed6be99804632bc57ceda50dbe900', '22', 0, '933716cd8fa44920811ff616ba68be37'),
(679, 'da3b0591fba544d3b6d515f6dd19acd3', '4 212', 0, '933716cd8fa44920811ff616ba68be37'),
(680, 'ceba10f7c41747fda8156de36f8f80ba', '294', 0, '933716cd8fa44920811ff616ba68be37'),
(681, '0878ca294b62442cb04b32ae590d6f9b', '189', 1, '791cc430a8af4d41b20f86e3267a2f78'),
(682, '23b5caca89aa44cbb77cc955f983066c', '70', 0, '791cc430a8af4d41b20f86e3267a2f78'),
(683, '459385279469430b98a5f9e914875031', '77', 0, '791cc430a8af4d41b20f86e3267a2f78'),
(684, 'd78b90f2636749688971bd6dfc74486e', '179', 0, '791cc430a8af4d41b20f86e3267a2f78'),
(685, '17d54708d1584da59aa52a8ebffe0b50', '37', 1, '2d693ff4f1d1487786f7197ab46bf9d8'),
(686, '8e79d0ec9a1148ebbf858af39e070b68', '504', 0, '2d693ff4f1d1487786f7197ab46bf9d8'),
(687, '7c421b9dce0741918b05b57a6d0b8847', '38', 0, '2d693ff4f1d1487786f7197ab46bf9d8'),
(688, '60d7daa57ee54cf4a89704d9588ea6f3', 'I dont know', 0, '2d693ff4f1d1487786f7197ab46bf9d8'),
(689, '87bbe5b6f0dd471bbf8a561adfac85d2', 'Thousandth', 1, '8947722779ec4754a2264fc2a35f0b74'),
(690, 'fcd1b97eb2f74e20b965403e39d7eb01', 'Thousands', 0, '8947722779ec4754a2264fc2a35f0b74'),
(691, '2a76eb2956d145d180c604eb8ff23241', 'Hundredth', 0, '8947722779ec4754a2264fc2a35f0b74'),
(692, '151dca00931148969d5124471289af98', '0.0', 0, '8947722779ec4754a2264fc2a35f0b74'),
(693, '1ae4c068ca6244a498e75cea18028f83', '251.442', 1, '3a90baa35627433388ec9a9bfb6b9097'),
(694, 'c9a7e8a482f649f7bb2c4eb674f7f4d8', '250.332', 0, '3a90baa35627433388ec9a9bfb6b9097'),
(695, '1d03b32861974b3a9971f35805619f73', '250.442', 0, '3a90baa35627433388ec9a9bfb6b9097'),
(696, 'ca05bb5421b64d0194f1975d7c389f3f', '251.332', 0, '3a90baa35627433388ec9a9bfb6b9097'),
(697, 'c970dca48b46495dbcdb1184ac5d5652', '654.884', 1, 'e04a598350a84254870f56f8eb3c0114'),
(698, '89f4f2d65b604ca8b58e92fd2b9e595e', '653.884', 0, 'e04a598350a84254870f56f8eb3c0114'),
(699, '739f7f8b6bfb40d98601f5e42145d6a1', '654.784', 0, 'e04a598350a84254870f56f8eb3c0114'),
(700, '36e3aa04a73347cbad9f69a7d91794e9', '654,884', 0, 'e04a598350a84254870f56f8eb3c0114'),
(701, '9216a17d9df0445cbd1f035083be95dd', 'kilometer', 1, 'a884e92341284db288ac927a7814b0b3'),
(702, 'dffe44f79bcc43bdba015ba74e939356', 'kilograms', 0, 'a884e92341284db288ac927a7814b0b3'),
(703, '38a374a4101b47bd83cc1162c43bc199', 'ruler', 0, 'a884e92341284db288ac927a7814b0b3'),
(704, '8ea0778764aa47b698d7bfaba237ebb0', 'distance', 0, 'a884e92341284db288ac927a7814b0b3'),
(705, '8da54387fe0e4d57b63392024f469a16', '1 000', 1, '68b63c28f77a4d7da710bc0335a9d653'),
(706, 'fbbe2d3f11cd4508bae30fbd8cc17ab3', '100', 0, '68b63c28f77a4d7da710bc0335a9d653'),
(707, '4cb2e122110042b59e1f69d3414c147c', '10', 0, '68b63c28f77a4d7da710bc0335a9d653'),
(708, '84ce9a4c2f2848cfa7f82e3f78eb54e0', '0.1', 0, '68b63c28f77a4d7da710bc0335a9d653'),
(709, 'e65e4a9519d04cb2b5a93e3263de0e4a', '12 750', 1, '1af9dadec92b409ea98f236154599c14'),
(710, '64bebd36a33a425ab4a5d0ad41c5dec3', ' 1 275', 0, '1af9dadec92b409ea98f236154599c14'),
(711, '90004cf6813d449e902d3769f8adbe2f', '12 7500', 0, '1af9dadec92b409ea98f236154599c14'),
(712, '25d421b40fe3404b9db4b385e12d201a', '12.75', 0, '1af9dadec92b409ea98f236154599c14'),
(713, '820e0497c5634f5a8938171389fa09ff', '3 km 650 m', 1, '5269b37638d1423aa0c64d10becb44e0'),
(714, '7eeab7d4402d4c36bc5c8498b3cc7410', '3 km', 0, '5269b37638d1423aa0c64d10becb44e0'),
(715, '2057168674ed4f6182b85a74ca488a97', '3 km 65 m', 0, '5269b37638d1423aa0c64d10becb44e0'),
(716, '8a1566c826d6467cad390ed195385afb', '3 650 000 km', 0, '5269b37638d1423aa0c64d10becb44e0'),
(717, '67e48e76b57d422381b7ef5dd4b8939e', '10 km 066 m', 1, '4c2d1e6d07d54cb2af3fad1a29fe8d0e'),
(718, '1c92b9d762c547f393cc7f6d2107b3e4', '10 km 56 m', 0, '4c2d1e6d07d54cb2af3fad1a29fe8d0e'),
(719, 'd371abdc747a49b5b47d41362f44fa3a', '9km 66m', 0, '4c2d1e6d07d54cb2af3fad1a29fe8d0e'),
(720, '105ec9c8503046d79bf10711feff857a', 'none of the above', 0, '4c2d1e6d07d54cb2af3fad1a29fe8d0e'),
(721, '5d7e9eacfcf54334963a72aa1ce45bf4', '3 km 770 m', 1, '069472379bcb4e88a990132287037bde'),
(722, 'cb9befb77458493dad45b7f8e3c1fa1e', '3 km 77 m', 0, '069472379bcb4e88a990132287037bde'),
(723, 'db288776899743ba82f891cbb330e94a', '4 km 770 m', 0, '069472379bcb4e88a990132287037bde'),
(724, '785789fd17ff401ba69e68ee4cf01e8f', '4 km 77m', 0, '069472379bcb4e88a990132287037bde'),
(725, '60617bf0fde14acd98934f80a6f7c134', '14 km 488 m', 1, '3713827d6b794881a31c0c593cf9eb24'),
(726, 'e2f79fd2505b48bf993bbac160d3d6f0', '6 km 244 m', 0, '3713827d6b794881a31c0c593cf9eb24'),
(727, '06ded1a34af14ffbb2c516159dbeda6a', '6 km 344 m', 0, '3713827d6b794881a31c0c593cf9eb24'),
(728, '31eae34bd2044c76b42ff35a5a2610fb', 'none of the above', 0, '3713827d6b794881a31c0c593cf9eb24'),
(729, '4036749ab21e4d89a45ce040478592f5', '144 cm2', 1, 'be2fb7f698d4467fad9624c49cb632b7'),
(730, 'c5aab53278c34d81ab4cc7b845a5372c', '48', 0, 'be2fb7f698d4467fad9624c49cb632b7'),
(731, 'd76b778706e74b12b48c91652b56f352', '144 ', 0, 'be2fb7f698d4467fad9624c49cb632b7'),
(732, '60c72f35f93744cd85cb1ff7fe6e49ff', '24', 0, 'be2fb7f698d4467fad9624c49cb632b7'),
(733, '737b162de01642d9b7c8494c1dfda9c5', '330', 1, '33957668a75f46b59458462ddcc59dea'),
(734, 'e5166e6184924b13bc0d3b4313fb8244', '74', 0, '33957668a75f46b59458462ddcc59dea'),
(735, '5bc3914491694f5e9d860a636295c188', '37', 0, '33957668a75f46b59458462ddcc59dea'),
(736, 'e041bc8263904b818d08f3698eb32626', '230', 0, '33957668a75f46b59458462ddcc59dea'),
(737, 'e23cee95d31d467e8926d1fba19a1284', '432', 1, '078292ffc1344431a2a6cb8c52ffc14b'),
(738, 'f8635ea2ad5f4a008ba19bbb1f8740ad', '422', 0, '078292ffc1344431a2a6cb8c52ffc14b'),
(739, '3588bd9912d14752b0ac88da36d3f048', '1 296', 0, '078292ffc1344431a2a6cb8c52ffc14b'),
(740, 'c823c3582c7444c8a670c7b681e8d8c3', '1 286', 0, '078292ffc1344431a2a6cb8c52ffc14b'),
(741, '08f08a092a8b465297416d1cd03f0c09', '1 728', 1, '151da5fee22247e4836cb1b9ee7cb922'),
(742, '5ac1242e60724a17b3c5a28997a7a20d', '36', 0, '151da5fee22247e4836cb1b9ee7cb922'),
(743, '657b862cf2d14483af66f6f84557a3ec', '1 618', 0, '151da5fee22247e4836cb1b9ee7cb922'),
(744, 'a87aefaed1ca4fbf9ccc1e4d42f0fb0c', '1 628', 0, '151da5fee22247e4836cb1b9ee7cb922'),
(745, '7af09467d2ad4d59baba3ba9e531d51e', 'v = l × w × h', 1, '560bb0a11aa743629884aea031125701'),
(746, '64c569d4f2ef455cab301272314659e3', 'V = l × w × t', 0, '560bb0a11aa743629884aea031125701'),
(747, '6fbe3234834f45d5a686b891b2a18f2b', 'V = l × h × t', 0, '560bb0a11aa743629884aea031125701'),
(748, 'dafed29e58a74a83abcaca86ce87932c', 'V=s × s × s\r\n', 0, '560bb0a11aa743629884aea031125701'),
(749, '2c9a0d3565914cf1a8f526b4c27e1914', '7', 1, 'd9e61d950a6941d3b62abfbdc9a31411'),
(750, '70f23c7e35384785add2c0908c30feec', '5', 0, 'd9e61d950a6941d3b62abfbdc9a31411'),
(751, 'a172e35294754126a17512b1cf14c1f8', '6', 0, 'd9e61d950a6941d3b62abfbdc9a31411'),
(752, 'e7ed250243df4883b87868c4082e583e', '360', 0, 'd9e61d950a6941d3b62abfbdc9a31411'),
(753, '906f9d078ce047e5b78a6a29e939b85e', '13', 1, '6f02ac3324d34590996f0dd898ab3527'),
(754, '5bed5ba1e48b4019ba7a61c35993183f', '84.5', 0, '6f02ac3324d34590996f0dd898ab3527'),
(755, '9974f97b435c4acaa7008a643687e294', '156', 0, '6f02ac3324d34590996f0dd898ab3527'),
(756, '7611f25c4f4a478e870db6fc1d5c79a2', '12', 0, '6f02ac3324d34590996f0dd898ab3527'),
(757, '9438da7e85d341efba30e698b2354fc1', 'Litres and millilitre', 1, '222d1def85b24ff6b537b87cd9b7fd7a'),
(758, 'fc1db837d5f34f41adf84903100b0418', 'Litres and capacitance', 0, '222d1def85b24ff6b537b87cd9b7fd7a'),
(759, '27feb1f48ec34f73935ed46434818738', 'millilitre and grams', 0, '222d1def85b24ff6b537b87cd9b7fd7a'),
(760, 'dc3b829b68394830bdbb9caff1a15ce2', 'kilograms and kilometres', 0, '222d1def85b24ff6b537b87cd9b7fd7a'),
(761, '899c8ca3615544b7b791ad9311fef6bb', '13 litres 750 ml', 1, 'f8a7e8f39be34aa1947d9a2cc1f41545'),
(762, 'b52f19b0d136416b80eb074ecd44b4ff', '1 litres 750 ml', 0, 'f8a7e8f39be34aa1947d9a2cc1f41545'),
(763, 'c797d7f8328c4c4495f8f55a1a9c864a', '13 litres 75 ml', 0, 'f8a7e8f39be34aa1947d9a2cc1f41545'),
(764, 'b04ba6d728984881b405928f402d7b68', '137 litres 75 ml', 0, 'f8a7e8f39be34aa1947d9a2cc1f41545'),
(765, '31e421859a424bce890c0324204e0c24', '4 250 ml', 1, 'c220a35ca0a34fc295af096e0ae5e247'),
(766, '36d3008962a548f9a4f6908cd3656f39', '425 ml', 0, 'c220a35ca0a34fc295af096e0ae5e247'),
(767, 'f2ef42c4c29444a395aa5f631296c730', '4 250 000 ml', 0, 'c220a35ca0a34fc295af096e0ae5e247'),
(768, 'ec6660770aec4e868a075486c5647de0', '42.5 ml', 0, 'c220a35ca0a34fc295af096e0ae5e247'),
(769, '657da24f0147453ea992ee6635fd96dc', '7 000 ml', 1, 'b285ab92f5f041cfaf478b2f1172c375'),
(770, '09509e4fdb5847a887a244293eb37ba9', '7 litres', 0, 'b285ab92f5f041cfaf478b2f1172c375'),
(771, '945b5b67bf144887ae956303dbc43d1f', '7 ml', 0, 'b285ab92f5f041cfaf478b2f1172c375'),
(772, '5f1f4d2aaee5480dbed7413923578057', 'None of the above', 0, 'b285ab92f5f041cfaf478b2f1172c375'),
(773, 'c4696f9cd7bc4278a366cf175d6ef6b5', '13 litres', 1, '19628957bc5546be83e0e7b5170d89ef'),
(774, 'd8e0ab4657904558af113694d980467c', '13 000 ml', 0, '19628957bc5546be83e0e7b5170d89ef'),
(775, '5e713fa1e4644c2298eb0d1d70d25ce4', '12 litres', 0, '19628957bc5546be83e0e7b5170d89ef'),
(776, 'ad6482a2d48c4b6d899f1448e2fc49be', '156 litres', 0, '19628957bc5546be83e0e7b5170d89ef'),
(777, 'd8f16fa6e78a49d695d8aa8462fa8ca0', '17 litres 262 ml', 1, '46975a7fb082430a91c4e5ae1399a32e'),
(778, '482e8555cdc54ed3b2afedaac51357ab', '17 litres 26.2 ml', 0, '46975a7fb082430a91c4e5ae1399a32e'),
(779, '81e4b7773f54437a81eb2170f861bf7f', '1 litre 7262 ml', 0, '46975a7fb082430a91c4e5ae1399a32e'),
(780, 'cd440b7486b44cbcb2f6934f4462418d', '1 litre 726.2 ml', 0, '46975a7fb082430a91c4e5ae1399a32e'),
(781, '024c88201b9c4e72a280c83f3f09f4fb', '57 litres 856 ml', 1, 'dcfc4add8a2543889287dff5f7a9afff'),
(782, 'ed327acc216847298686f9f37f0b34e3', '56 litres 856 ml', 0, 'dcfc4add8a2543889287dff5f7a9afff'),
(783, 'a84fc9a7656646328189e39ad8e1c528', '56 litres 756 ml', 0, 'dcfc4add8a2543889287dff5f7a9afff'),
(784, 'd20339b992644dd38fa1f3fbddd781af', '57 litres 846 ml', 0, 'dcfc4add8a2543889287dff5f7a9afff'),
(785, '21a7ee5d47074d05b7fbcedee75d58d8', 'kg and g', 1, '1d5ec5456ab1431a9620daae5501ef00'),
(786, '8cad4da2616248e5af5b84541feba71a', 'kilogram and millilitre', 0, '1d5ec5456ab1431a9620daae5501ef00'),
(787, '96e031b04bd1467f9239fa3dfe2dee52', 'kilogram and kilometre', 0, '1d5ec5456ab1431a9620daae5501ef00'),
(788, 'f33bba0e89204c8bb2a2e9f1c4c5c704', 'grams and weight', 0, '1d5ec5456ab1431a9620daae5501ef00'),
(789, 'e022d69486e74b55bcc252cc52615d91', '3 500 g', 1, 'ccacf7047be546a6b09ba5384a6967e0'),
(790, 'd27e52269a66490ea4bb57b5c451f7ba', '350 g', 0, 'ccacf7047be546a6b09ba5384a6967e0'),
(791, '45429c1d91234afd913e3da9fe66dec2', '0.0035 g', 0, 'ccacf7047be546a6b09ba5384a6967e0'),
(792, '2dc3e5e7f26c4d8bb416d300156d169e', '0.035 g', 0, 'ccacf7047be546a6b09ba5384a6967e0'),
(793, '935b6f36128348d39af7ee17f71c4d5c', '13 kg 656 g', 1, '786a1c5cc3b6462e8e5d61a6e052d800'),
(794, 'b0146dd7167940b7916975b8c0898404', '136 kg 56 g', 0, '786a1c5cc3b6462e8e5d61a6e052d800'),
(795, 'ee758e96b2f045c7aca8f502d7250b77', '1kg 365.6 g', 0, '786a1c5cc3b6462e8e5d61a6e052d800'),
(796, '48bbb388f249400d9196c941f98a4fec', '13 kg 65 g', 0, '786a1c5cc3b6462e8e5d61a6e052d800'),
(797, '38a85443b557496ea5460ccf960ac5c6', '16', 1, '5342b95185ec4218a02a3b4630d635d8'),
(798, '9f3012ce2f1747799c9ef336fb17f307', '1000', 0, '5342b95185ec4218a02a3b4630d635d8'),
(799, 'd6e13ab3d34d4c38957b8b267cbaa54b', '100', 0, '5342b95185ec4218a02a3b4630d635d8'),
(800, 'c4747b542f6f477491d85cf321ffe503', '26', 0, '5342b95185ec4218a02a3b4630d635d8'),
(801, '9c73888d35074099aab062b54e13c58d', '30 kg 232 g', 1, 'a03c63855ea043d7983374ddf4c02130'),
(802, '3e8cc44c2da149f6a297c7bdbee834a1', '29 kg 232 g', 0, 'a03c63855ea043d7983374ddf4c02130'),
(803, '957e972e68734ec4936d33dfb7f0ee63', '29 kg 1232 g', 0, 'a03c63855ea043d7983374ddf4c02130'),
(804, 'a5453ab3f9ab48eea59e6afb807c3138', '30 kg 1232 g', 0, 'a03c63855ea043d7983374ddf4c02130'),
(805, 'bc0a2d96fa0c445e8c1e8748482c689d', '228  kg 400 g', 1, '368366c2155341eeada5799c4773deba'),
(806, '835529723f7049d8bd77cdf91bbc2a31', '213 kg 400 g', 0, '368366c2155341eeada5799c4773deba'),
(807, '859e26b0b2a145edbe5758a84bbdb1ff', '153 kg 400 g', 0, '368366c2155341eeada5799c4773deba'),
(808, 'e185634f24ce464b845f27c6bb9c057b', '173 kg 400 g', 0, '368366c2155341eeada5799c4773deba'),
(809, '6073bc8ecbea4308b598f6279ba996b5', '5 kg 73 g', 1, 'a688674c5a8d463e8bd09b80160fa18b'),
(810, '1ac6e02eda4a4722b7f798c39927ebe8', '5kg 173 g', 0, 'a688674c5a8d463e8bd09b80160fa18b'),
(811, 'f8250b64bada4a7e9bea57f664661936', '15 kg 73 g', 0, 'a688674c5a8d463e8bd09b80160fa18b'),
(812, '11bb3cbc7a294fd4a76b85bdf95c0a99', 'None of the above', 0, 'a688674c5a8d463e8bd09b80160fa18b'),
(813, '77763109515644dbae2439628dad8254', '926 s', 1, 'f90452cfe6c7418f8935acd9655f4b2a'),
(814, '600c925ab803485aa46445843c664975', '916 s', 0, 'f90452cfe6c7418f8935acd9655f4b2a'),
(815, 'cf9d8cc09a2c4d3f848a684fbbb015e6', '9 260 s', 0, 'f90452cfe6c7418f8935acd9655f4b2a'),
(816, '37a35622bfe14260b345c00e77caf3cd', '900 m 26 s', 0, 'f90452cfe6c7418f8935acd9655f4b2a'),
(817, '6740b00c0b364141aac86b1a6b89ddf5', '16 m 36 s', 1, 'bfa8ed3d55ee4fe3be38380060fb8fae'),
(818, '4cdac0f6727d46b6a29fbb93ae54a6f3', '16m 360 s', 0, 'bfa8ed3d55ee4fe3be38380060fb8fae'),
(819, 'c1515d2956aa415c8a7b4146d4c940cf', '163 m 60 s', 0, 'bfa8ed3d55ee4fe3be38380060fb8fae'),
(820, '3216d4aecab14728ad113aef9fb2e56e', '1 m 636 s', 0, 'bfa8ed3d55ee4fe3be38380060fb8fae'),
(821, '22b3a16106f940569934aecb2149e909', '12:06:16 pm', 1, '2ca0d2dd52b74bce9e40d856670baa43'),
(822, '9f8d300e029043338126b1ad071c7b81', '12:06 pm', 0, '2ca0d2dd52b74bce9e40d856670baa43'),
(823, '7c6e976e45f74de8a3cbddb1a8105193', '12:06:16 ', 0, '2ca0d2dd52b74bce9e40d856670baa43'),
(824, 'c2f5b98d3d3440948bd9ac8b628e9001', '12:06', 0, '2ca0d2dd52b74bce9e40d856670baa43'),
(825, '22d2db7ed7fd46b292b0c0cf4659261c', '9:36 am', 1, 'afcb0e3698ea42b9877d01f4bb395fa6'),
(826, '72a0d4f645724acbba4d1c83af74fa6b', '9:36 pm', 0, 'afcb0e3698ea42b9877d01f4bb395fa6'),
(827, '33e6947d18f442b3bcd9b67ed9fe4985', '9:26 am', 0, 'afcb0e3698ea42b9877d01f4bb395fa6'),
(828, 'da6248c47c5c4fb2b4a425e49337c9b4', '10:36 am', 0, 'afcb0e3698ea42b9877d01f4bb395fa6'),
(829, '9e760bd94bce428d8efeec0cbe17e7cb', '18 h 12 m', 1, 'fcc1d122d0bf493eaa1e992fa13d4b44'),
(830, '774b401ca5714dcc9d26eecf69353942', '17 h 22 m', 0, 'fcc1d122d0bf493eaa1e992fa13d4b44'),
(831, '888ab24968e047a1a0be9e42ff0a276d', '9 hr 6 m', 0, 'fcc1d122d0bf493eaa1e992fa13d4b44'),
(832, 'a70240f9608e41ab8cd84e81a5851bbc', '8 h 66 m', 0, 'fcc1d122d0bf493eaa1e992fa13d4b44'),
(833, '82fa5234f31e428eb44bf85cc8904218', '91 h 18 m 00 s', 1, 'd50f4c8a044b4025bead701230f5b9d1'),
(834, 'b7941ec8b5384a08880e67e1c274701e', '90 hr 17 m 60 s', 0, 'd50f4c8a044b4025bead701230f5b9d1'),
(835, '8c32181ededb4a13b2a3c6dea3895c86', '91 h 17 m 360 s', 0, 'd50f4c8a044b4025bead701230f5b9d1'),
(836, 'd0dc73420c30437887df266cd13e932e', 'None of the above', 0, 'd50f4c8a044b4025bead701230f5b9d1'),
(837, '77a63d5e5172413ab8b49ed0d3032f02', '39 m', 1, 'ae37f6bd3d82457c9c9aed3b5d34eec2'),
(838, '39265356ad024606b3f84468b399a647', '30 m 90 s', 0, 'ae37f6bd3d82457c9c9aed3b5d34eec2'),
(839, 'a604a77ca39f4ac4a5bd5f4649900197', '3m 90 s', 0, 'ae37f6bd3d82457c9c9aed3b5d34eec2'),
(840, '1dd06565bdb74ab5832339c6149fcbfd', '3m 9 s', 0, 'ae37f6bd3d82457c9c9aed3b5d34eec2'),
(841, 'b1268025eee44ea895e0da948af5ae03', '1 310', 1, '69d04d1c4eae422caca47a42ff50fe7c'),
(842, 'a5778902c0274083a5a3c379229af106', '1.31', 0, '69d04d1c4eae422caca47a42ff50fe7c'),
(843, 'fa224bade8e24608b26b3a8a71db945b', '1 3010', 0, '69d04d1c4eae422caca47a42ff50fe7c'),
(844, '49cb8113e257440da46619ec96b77da3', '130', 0, '69d04d1c4eae422caca47a42ff50fe7c'),
(845, '132281e116f648cc9ff57c90d1659ca3', '22', 1, 'f80be5a61123499fa21b5eb691dd0ef8'),
(846, '4e2dc4ff44f44a85951cae1b9fde9f53', '20', 0, 'f80be5a61123499fa21b5eb691dd0ef8'),
(847, '945aefc1b3d14075b14b1fa6efb6071e', '220', 0, 'f80be5a61123499fa21b5eb691dd0ef8'),
(848, '17ce532e752c4955bdb6d1f821cf1a33', '21', 0, 'f80be5a61123499fa21b5eb691dd0ef8'),
(849, '176772ef8d5643c0afa30d6d54225592', 'None of the above', 1, '85810a6b060247cca390fce72f8e5a8f'),
(850, '4ae3b0383655409599a5b7feb74ed8d8', '8 650', 0, '85810a6b060247cca390fce72f8e5a8f'),
(851, 'a323bcaa9cc94109b1fe2ab2e1ec363f', '7 750', 0, '85810a6b060247cca390fce72f8e5a8f'),
(852, '450e1c361fbc41f19cbf343937f25208', '7 650', 0, '85810a6b060247cca390fce72f8e5a8f'),
(853, '43053f57e89a40ffaa896633379c7249', '11 346 sh 07 ct', 1, 'c02ea1bedfc04309ba34eb8f0b45872d'),
(854, 'c87f0157bd2f4b5c9e3eb12665c70d1f', '11 345 sh 107 ct', 0, 'c02ea1bedfc04309ba34eb8f0b45872d'),
(855, '7ce1d48cbaba4dd7b1c3a07e5ec127f8', '11 346 107 ct', 0, 'c02ea1bedfc04309ba34eb8f0b45872d'),
(856, '46d753d617824ea2a24c0fdf1cc18171', 'None of the above ', 0, 'c02ea1bedfc04309ba34eb8f0b45872d'),
(857, 'c54458bc0ad044eabd0044ad86a501bb', '2 254 sh 20 ct', 1, '21f56fc4bd8241a18ee885f667fe132e'),
(858, '8f7f8cabcd7f4897a9f53aa58b36afc7', '2 244 sh 1020 ct', 0, '21f56fc4bd8241a18ee885f667fe132e'),
(859, 'e25c77850ba24700b45eae370476571a', '2 255 sh 20 ct', 0, '21f56fc4bd8241a18ee885f667fe132e'),
(860, 'a6fbf636db9346c699135b4a8b74d75a', '2 254  sh 1020 ct', 0, '21f56fc4bd8241a18ee885f667fe132e'),
(861, '463b65c431474dccb4c23122d24ddc4e', '3x - 2x', 1, '0f97ae1ee4ab4905bbc0eae7729118b5'),
(862, 'b1617520302842dc835257ed77b028f7', '4x', 0, '0f97ae1ee4ab4905bbc0eae7729118b5'),
(863, '3613a4f83a8a4b83b64ad7071e3576c2', '6x -4x', 0, '0f97ae1ee4ab4905bbc0eae7729118b5'),
(864, '2defdbcda3d74b7e87e96478b46b5a98', '3x - x', 0, '0f97ae1ee4ab4905bbc0eae7729118b5'),
(865, '5986f2698edb479397cbb5b98d5898bd', '6a + d', 1, '8a41569231db4bfbb83a32c0a1b59e79'),
(866, 'a89e019d229941b080f45c53b9dbf05c', '6a + 1d', 0, '8a41569231db4bfbb83a32c0a1b59e79'),
(867, '5b17539e0d474f7b8748849608c7ea26', '6a', 0, '8a41569231db4bfbb83a32c0a1b59e79'),
(868, '1735458688af42a5b61935c10516dbea', '6a + 7d', 0, '8a41569231db4bfbb83a32c0a1b59e79'),
(869, '2c560b508d3e4398b2ea4d841cf04c70', '22', 1, '8faff50822134b69838209f09b820e26'),
(870, '498853647c4948fc95f7fe3221715c15', '14', 0, '8faff50822134b69838209f09b820e26'),
(871, 'c5b8a316bce84fafb456bdb3d1697f41', '11', 0, '8faff50822134b69838209f09b820e26'),
(872, '3c405f3a098e41e3ad0f61603cff38a5', 'x - 14', 0, '8faff50822134b69838209f09b820e26'),
(873, 'ac2490c28a8a4119817f3ca5aeff008d', 'x=12', 1, 'fdbfaf4d1c464839b272379745c19668'),
(874, 'd83bb17022354aafa067c194978bfbcb', 'x = 54', 0, 'fdbfaf4d1c464839b272379745c19668'),
(875, '2b2ad2764199449587fad67daa4f2af0', 'x= 21', 0, 'fdbfaf4d1c464839b272379745c19668'),
(876, '3e967bedb03f41588da3372aa491fe1a', 'None of the above', 0, 'fdbfaf4d1c464839b272379745c19668'),
(877, 'caea8efff7af495bb4e25c119fc0849c', '6 3/8', 1, 'd49d6b91dccf4ca7ac359023c8df16ef'),
(878, '69f98dc706a1478db082d09d14ef7794', '7 5/8', 0, 'd49d6b91dccf4ca7ac359023c8df16ef'),
(879, 'de765140149f48fb99fab1f70c4f6075', 'none of the above', 0, 'd49d6b91dccf4ca7ac359023c8df16ef'),
(880, '4cc8d93000654ad2b0dfb863a6823a2a', '6 5/8', 0, 'd49d6b91dccf4ca7ac359023c8df16ef'),
(881, 'f2849d3940364049bb6248f08dbc844f', 'x = 2', 1, '1dcfccba03244784a83b0b92e361ffd9'),
(882, 'ae4aed855cf549d5941955cae200e922', 'x = 17', 0, '1dcfccba03244784a83b0b92e361ffd9'),
(883, 'fc514d0f5a004afc92159a37eeb4994f', 'x = 34', 0, '1dcfccba03244784a83b0b92e361ffd9'),
(884, 'dd33a769960240d4b601caa04d535c45', 'x = 22', 0, '1dcfccba03244784a83b0b92e361ffd9'),
(885, 'e4d7179e810147a59d5161c41efe38b5', 'Tens of thousands, Millions', 1, '7cb93156965348ea83ee006c454b4d6a'),
(886, '0b34ed5174604ac182718a3595d72fc3', 'Millions, Tens of thousands', 0, '7cb93156965348ea83ee006c454b4d6a'),
(887, '8fbc98ac6d4e4c61bc09d2e8793f3598', 'Hundreds of Thousands, Millions', 0, '7cb93156965348ea83ee006c454b4d6a'),
(888, 'aaf4509083894b1b91b8dd8b9207a5bc', ' Millions, Hundreds of thousands,', 0, '7cb93156965348ea83ee006c454b4d6a'),
(889, 'c3b67db7482c498abd3a2ad8c9dcc5e1', '7 000 000', 1, '85502e2321c042f8bd78e03fd8cc0920'),
(890, '981f2b4773034ad9a18047cb493966d5', '1 000 000', 0, '85502e2321c042f8bd78e03fd8cc0920'),
(891, '318466faabe44097b0936ebef447030b', '700 000', 0, '85502e2321c042f8bd78e03fd8cc0920'),
(892, '895a0d2c7f474563a0d778be13f47593', '700 000 000', 0, '85502e2321c042f8bd78e03fd8cc0920'),
(893, '2d672932ebcb447a86b6c1024795a83e', '316 016', 1, 'acb2945be5fe40d78eeae16e2541b3d3'),
(894, '81ee84e405e74a92a326b078b7d0c16d', '360 016', 0, 'acb2945be5fe40d78eeae16e2541b3d3'),
(895, '0368848690d2414f9e1885d34b7e900e', '300 016 016', 0, 'acb2945be5fe40d78eeae16e2541b3d3'),
(896, '7f601938e9564438a8462b5ce5a847b6', '316 16', 0, 'acb2945be5fe40d78eeae16e2541b3d3'),
(897, '6dc6afa7b7c14c1cb2905b782350a9da', '1 600 000', 1, 'eb3896ca3d9547f58febd2e4a2ee95e6'),
(898, 'cea81ea7c1ce40ec80b41c2732251c63', '2 000 000', 0, 'eb3896ca3d9547f58febd2e4a2ee95e6'),
(899, '5f3d519d55a54047a7795ab19b301ec1', '1 666 099', 0, 'eb3896ca3d9547f58febd2e4a2ee95e6'),
(900, 'f88775e853af4ea4814c7104dfcb42cd', '1 600 100', 0, 'eb3896ca3d9547f58febd2e4a2ee95e6'),
(901, '296cf4e24e244a9786e158f05a512dd6', '169', 1, 'c87ba4b7ae83487096013a2aa0d2f8ed'),
(902, '2da1fdf8de9c4631860deb93bcac4f63', '42', 0, 'c87ba4b7ae83487096013a2aa0d2f8ed'),
(903, '22d24a94a89644ce83d6fbe486846909', '26', 0, 'c87ba4b7ae83487096013a2aa0d2f8ed'),
(904, 'b80bbba5dc0645379832d6c4b6ab96c6', '143', 0, 'c87ba4b7ae83487096013a2aa0d2f8ed'),
(905, '85efef166ec54e6b904d086a27b9cf5d', '256', 1, 'bffff8c69b264434a7589c82c8df0686'),
(906, '23fbcc46577143c4a251c74a573b1455', '64', 0, 'bffff8c69b264434a7589c82c8df0686'),
(907, '781b2f8c260840e9afd7bd835e3572fc', '32', 0, 'bffff8c69b264434a7589c82c8df0686'),
(908, '7adb6ab4d0444435a33a5d523b1186b8', '128', 0, 'bffff8c69b264434a7589c82c8df0686'),
(909, '813d7cf0d96e4ea69926c98a9760ec19', '11', 1, 'db866d88699f4731a132fcc335a22748'),
(910, '8e9eade959264067b5b73a1dc2c06836', '62.5', 0, 'db866d88699f4731a132fcc335a22748'),
(911, '5cd423f825ba470795a31590a459909b', 'None of the above', 0, 'db866d88699f4731a132fcc335a22748'),
(912, '4a996ead173a4b5d811295893f67cf27', '12', 0, 'db866d88699f4731a132fcc335a22748'),
(913, '9acaac06091f4facbb8eae8c064fd028', '16, 25', 1, '4173738447534872968b5de85b4bf013'),
(914, '57879aedc2ef4d059612a708a6e78e3a', '128, 312.5', 0, '4173738447534872968b5de85b4bf013'),
(915, '607399699c7f45fab7d3c686ba1df8ab', '26, 35', 0, '4173738447534872968b5de85b4bf013'),
(916, 'da6b8cd8ccdf4598a6a358de9fa42f8f', 'None of the above', 0, '4173738447534872968b5de85b4bf013'),
(917, '2928a09913d644c5b6f48cd25dd53ded', '144', 1, '642da40ee05b4515ae2f40fb09bf1692'),
(918, '9ba38c38dd954028a23b451b5e608ee0', '24', 0, '642da40ee05b4515ae2f40fb09bf1692'),
(919, '5da010187582430cb91de97fdaff8941', '36', 0, '642da40ee05b4515ae2f40fb09bf1692'),
(920, '4728a35398584eb2a3add68ed7bb9491', '6', 0, '642da40ee05b4515ae2f40fb09bf1692'),
(921, 'ccca7aa51c4a413ab49b05e370794e34', '22 048', 1, '31ba1a2cab414fa5adffbdf12c35c687'),
(922, '98d257d628fa4408a4fca0687454a9e6', '11 024', 0, '31ba1a2cab414fa5adffbdf12c35c687'),
(923, '2296e3445b9342d683e73a7c1c767390', '10 024', 0, '31ba1a2cab414fa5adffbdf12c35c687'),
(924, '029980df7c9744d8a86ed5661e930dae', '11 014', 0, '31ba1a2cab414fa5adffbdf12c35c687'),
(925, '7530ee40659d4767b20ef9cbb5ad5a52', '750, 3 750', 1, '37cb6337e2164278940eacaba661e48d'),
(926, 'efdf7a288e40424883d8766d8fdfea99', '300, 900', 0, '37cb6337e2164278940eacaba661e48d'),
(927, '005aeb4bd3f442ee8b506fd604606f65', '186, 372', 0, '37cb6337e2164278940eacaba661e48d'),
(928, '2e53b704ba064c20b29b2957c1f4f625', '500, 1000', 0, '37cb6337e2164278940eacaba661e48d'),
(929, '1bcfbbe210e74526b99a9b6c416b20e5', '44 694', 1, 'a59c528ca15f43a294fb9ed4d41add1e'),
(930, '2bcd730bb29640f89c23b15c292d01fc', '44 684', 0, 'a59c528ca15f43a294fb9ed4d41add1e'),
(931, 'af35547fcaa0402bb57680cc5092c253', '43 684', 0, 'a59c528ca15f43a294fb9ed4d41add1e'),
(932, 'c09ec388602949d080e081ed69cbf635', '43 594', 0, 'a59c528ca15f43a294fb9ed4d41add1e'),
(933, 'e26556777d094abe88cf04f42bff6e32', '36', 1, '0e42455ff2264b038419f2b1a3c342b4'),
(934, 'b9da608d6f344fff86e59b145d3efa04', '306', 0, '0e42455ff2264b038419f2b1a3c342b4'),
(935, '9b65b217235249078a30eb3c72918f0b', '46', 0, '0e42455ff2264b038419f2b1a3c342b4'),
(936, 'f1362f2ade0148bd967aecb32a6a13fb', '37', 0, '0e42455ff2264b038419f2b1a3c342b4'),
(937, '773cba597d684e6cac37fc098fe19a2f', '16', 1, '926e3ec885e3420eaece115fa94929fe'),
(938, '3bc490dbc27a48168e39ae343194e8ef', '26', 0, '926e3ec885e3420eaece115fa94929fe'),
(939, '2c391e8c1bba46f7bef830be56368b3f', '36', 0, '926e3ec885e3420eaece115fa94929fe'),
(940, '99a293ee3ab34fc49bb48c165e829bf7', '260', 0, '926e3ec885e3420eaece115fa94929fe'),
(941, 'eb76a5dc5bd24fd2a9d1c73fa3ace6f2', '8', 1, '1a4f53a7316640fea92d84da11f84ff2'),
(942, '21b53d0af9454817bfafa59d719f67c3', '5', 0, '1a4f53a7316640fea92d84da11f84ff2'),
(943, '81942e2b9a3240a883759e37a9bd56a3', '2', 0, '1a4f53a7316640fea92d84da11f84ff2'),
(944, '9e50830b03cd476e957c7a3d91f3b5cc', '3', 0, '1a4f53a7316640fea92d84da11f84ff2'),
(945, 'dad50acee18643478a080079303b75ff', '456.458', 1, 'bcb8c8523fb841c0adb2e29caf3ba3b8'),
(946, '083a73b8412f46de9891ed0527bc54ce', '456.457', 0, 'bcb8c8523fb841c0adb2e29caf3ba3b8'),
(947, '378656c3911249c0bcc59f5b776442dc', '456.458000', 0, 'bcb8c8523fb841c0adb2e29caf3ba3b8'),
(948, 'a8084ecbe56847218e2bfe283fa03d5e', '457.458', 0, 'bcb8c8523fb841c0adb2e29caf3ba3b8'),
(949, 'c31f9d5bad8041f883e12ba54e7d24e4', '82.567', 1, 'af6fba400cee4e0093d13568a7dcb4a4'),
(950, '815dcd2c7ab540cd94cdc0be168c0b58', '82.568', 0, 'af6fba400cee4e0093d13568a7dcb4a4'),
(951, 'df1dc1380ec54b4a92be522bd3dd824c', '82.56700', 0, 'af6fba400cee4e0093d13568a7dcb4a4'),
(952, 'b9fd1b85f5d440ecbc5947ce7ed83695', '83.567', 0, 'af6fba400cee4e0093d13568a7dcb4a4'),
(953, '81bd2ecfe55a49448b1daef5d50c250c', '1072.311', 1, '11820b7260c4407fa61401085331c89a'),
(954, '6cfa8b2988844a699f871554de75f612', '1 072.3112', 0, '11820b7260c4407fa61401085331c89a'),
(955, 'cfeba5bdef634fd1b8cb6fd6240a63ab', '1 072.312', 0, '11820b7260c4407fa61401085331c89a'),
(956, '69c31838ac154f7c8b45b01c450de0d7', '107.31120', 0, '11820b7260c4407fa61401085331c89a'),
(957, '3fa1aeb25791417daf64e49a5fd3014a', '48.83', 1, 'cb1ac97db2104d05b88b404b3349883a'),
(958, '912db2f101d34d6fafd5de233f08cc06', '48.8255', 0, 'cb1ac97db2104d05b88b404b3349883a'),
(959, '9acdd72fa62d434bbcbb3d03c68c6939', '48.82', 0, 'cb1ac97db2104d05b88b404b3349883a'),
(960, '3d838370a3334f43823394b5d4453b7d', '48.826', 0, 'cb1ac97db2104d05b88b404b3349883a'),
(961, '9050b2ef3c0d4af9bf84ab807bf4a208', 'Macrogram', 1, 'feb6c5e214fc48abb2bf78622e9a9cd8'),
(962, '9f3f01b464ec4249a670d0c79fd440e1', 'Grams', 0, 'feb6c5e214fc48abb2bf78622e9a9cd8'),
(963, '8b919b55842c418e848c97fcc7ac8ee1', 'Killograms', 0, 'feb6c5e214fc48abb2bf78622e9a9cd8'),
(964, '8b1657c44c454d9ebee35ed1a7d6286c', 'Tonnes', 0, 'feb6c5e214fc48abb2bf78622e9a9cd8'),
(965, '87bc203b74f349fc9ff7873a6c7e97ad', '0.036700', 1, 'a40bdfaf34004fc984cebe267d6dfc78'),
(966, 'e81c293148e64547ac30e03eebda87f8', '0.36700', 0, 'a40bdfaf34004fc984cebe267d6dfc78'),
(967, 'eece9c7f0a2a405792aa48312abdc410', '36 700 000', 0, 'a40bdfaf34004fc984cebe267d6dfc78'),
(968, 'e8a6ce3869774257b9bcb0cd73abcd40', '367 000', 0, 'a40bdfaf34004fc984cebe267d6dfc78'),
(969, '6cf1761dfacc4356973131c5bac41300', '2000.79', 1, 'cfbeed45abb549a0b9805df8dac14974'),
(970, 'd6928d5efc4c4d0991474562db962591', '0.2790', 0, 'cfbeed45abb549a0b9805df8dac14974'),
(971, '54751e5afa994ead8b612788ca2fc78d', '2.790', 0, 'cfbeed45abb549a0b9805df8dac14974'),
(972, '9d252a09048341bea3845daccc69d516', '27 900', 0, 'cfbeed45abb549a0b9805df8dac14974'),
(973, '5f041947d4204cae9c71321a177256da', '20:36 ', 1, 'fd617d4892c8460cbc2d3f186c47e9fa'),
(974, '5dfde76b9a08458f96096839681d7485', '32:36', 0, 'fd617d4892c8460cbc2d3f186c47e9fa'),
(975, 'c020e1ab3b5c48db963f696baddcf3aa', '24:36 pm', 0, 'fd617d4892c8460cbc2d3f186c47e9fa'),
(976, '8efdfd9f65bd46fdb26c420da7907d4c', 'None of the above', 0, 'fd617d4892c8460cbc2d3f186c47e9fa'),
(977, '6cb5f9717c764397a98d8c1f586d6be3', '5:56 pm', 1, 'fb97a08e39c043c9a56f678f48ae7d54'),
(978, '6e21f83f6f2d4d1081d7b6607da5addf', '5:56 am', 0, 'fb97a08e39c043c9a56f678f48ae7d54'),
(979, '83271a4e30bb4dec8cfc662e0cdf1890', '29:56 pm', 0, 'fb97a08e39c043c9a56f678f48ae7d54'),
(980, '6b80c8f383554f79bc86ed096cf14799', '17:56 am', 0, 'fb97a08e39c043c9a56f678f48ae7d54'),
(981, '2311aaeb0030445995bbaeb300f522e1', '00:15 am', 1, '4e5361a539444bdfbb702b5d18ea408c'),
(982, '8f3ee6e5105a4a179681e1eef29dcd0f', '00:15 pm', 0, '4e5361a539444bdfbb702b5d18ea408c'),
(983, '7054fc9ac8b14cfeb48c0e6e65d9ca0d', '11:45 pm', 0, '4e5361a539444bdfbb702b5d18ea408c'),
(984, '1e3e920f26d54a47adc15167d99b0394', '12:15 am', 0, '4e5361a539444bdfbb702b5d18ea408c'),
(985, 'f46fe699401f4bdcae2f96ad76249db1', '0.168', 1, '34c6a17805a34102926d54fd5dc7f3bf'),
(986, 'c2c4cf90188e4fddae74e46851efa050', '0.1679', 0, '34c6a17805a34102926d54fd5dc7f3bf'),
(987, '87ccfa9ae3834d55a535a17a1ccbe6d9', '0.167', 0, '34c6a17805a34102926d54fd5dc7f3bf'),
(988, '425166f2b02b4a07aab8c5218eb1e5e2', '0.1670', 0, '34c6a17805a34102926d54fd5dc7f3bf'),
(989, 'c62d56b8a25c4561a9a228f4fd4d3e0d', '0.48', 1, '9cff816c9ece4871849b01ebb0e8e874'),
(990, '2ba3f97e11f94515aff6adeeb66c868f', '0.5', 0, '9cff816c9ece4871849b01ebb0e8e874'),
(991, '078ea223097545018a301adc25477708', '0.50', 0, '9cff816c9ece4871849b01ebb0e8e874'),
(992, '29aad878f716435e998c81d1af707a67', '0.49', 0, '9cff816c9ece4871849b01ebb0e8e874'),
(993, '1aa672a976554287964ea795c8addaaf', '64/1000', 1, '3adf418f999440048d36f2990161ea8b'),
(994, '1786c288ae944ba781093506ef8f3540', '18/125', 0, '3adf418f999440048d36f2990161ea8b'),
(995, 'f3d71a8f3ea2464b94811f9d23dbedb3', '64/100', 0, '3adf418f999440048d36f2990161ea8b'),
(996, '0d305291d2c140aa8da4a96eabd975e0', '64/ 10 000', 0, '3adf418f999440048d36f2990161ea8b'),
(997, 'd8888808cd654f4baa8cff4f7922e10b', '1/4 , 37/100', 1, '467ca0bb399a4e7e8bdb69954562188f'),
(998, '61d20be89232473587408a93e74d7b58', '25/100, 37/100', 0, '467ca0bb399a4e7e8bdb69954562188f'),
(999, '7a0fcf8db4af472c81da3cb7554e55ba', '0.25, 0.37', 0, '467ca0bb399a4e7e8bdb69954562188f'),
(1000, 'f4865ef0b39a4cdea223ee91ff653cae', '25/100, 37/1000', 0, '467ca0bb399a4e7e8bdb69954562188f'),
(1001, 'f817284b54f14c3abf24e40cb7f2881e', '75% and 50%', 1, '3406e79a65844fcea9c41eadfa8e6663'),
(1002, 'ef13d363fa11492dbf4d226009642717', '50% and 75%', 0, '3406e79a65844fcea9c41eadfa8e6663'),
(1003, '649b1af60b9a44c7b969ca4d7f842aae', '25% and 50%', 0, '3406e79a65844fcea9c41eadfa8e6663'),
(1004, '1a58282c758541469cf82d9a493571a2', '75% and 5%', 0, '3406e79a65844fcea9c41eadfa8e6663'),
(1005, 'ab98f1e7e7c94fb38ef8972c1384e1e7', '360', 1, '2aa9f0c457134b6fad2cc761fe40757b'),
(1006, '2dda226d089b409ca82bb20eebb724a1', '3 600', 0, '2aa9f0c457134b6fad2cc761fe40757b'),
(1007, '51cdc69a21e94f66bdb5bdc743d2df9a', '0.36', 0, '2aa9f0c457134b6fad2cc761fe40757b'),
(1008, '5eda6755070c4d0c8c668bf00bb276a7', '3.6', 0, '2aa9f0c457134b6fad2cc761fe40757b'),
(1009, '39a74f14f970413c85e923ded99e68b6', '7 cm 5 mm', 1, 'faacbdba2ba341e69ea9fe0f98550313'),
(1010, '22b3d7bfb6804fc48185ca2d1463f7a8', '0.75 cm', 0, 'faacbdba2ba341e69ea9fe0f98550313'),
(1011, '083ab56034b14cf0b45eb47fc357e5d4', '7.05 cm', 0, 'faacbdba2ba341e69ea9fe0f98550313'),
(1012, 'cc36f589e57840eab418bb68439566bc', '750 cm', 0, 'faacbdba2ba341e69ea9fe0f98550313'),
(1013, '7df2b766deff416a838629ad690746f1', '49 m 51 cm 6 mm', 1, 'b6955ff81cf541ca8bb7898be3c0beaf'),
(1014, '44b52388895f45519fbb0e6488de6e21', '48 m 150 cm 16 mm', 0, 'b6955ff81cf541ca8bb7898be3c0beaf'),
(1015, 'c8910ef37641482b9f359f93bcaf849c', '48 m 151 cm 6 mm', 0, 'b6955ff81cf541ca8bb7898be3c0beaf'),
(1016, 'a2970846444a4be5b36cb39aa6bb4fb6', '49 mm 151 cm 16 mm', 0, 'b6955ff81cf541ca8bb7898be3c0beaf'),
(1017, '7168d7049671453588db42a973efe88b', '29 m 67 cm 2mm', 1, 'f3a8280f48dc460298f09f16faf03b4f'),
(1018, 'a89952a23b3e4b4ebbde7678ca8fba78', '30 m 57 cm 2 mm', 0, 'f3a8280f48dc460298f09f16faf03b4f'),
(1019, 'e0c261e809ab4d6f9e7bfa66f7b667d5', '29 m 68 cm 2mm', 0, 'f3a8280f48dc460298f09f16faf03b4f'),
(1020, '410717b776e748e89614b0b6092a8894', 'None of the above', 0, 'f3a8280f48dc460298f09f16faf03b4f'),
(1021, 'f35d87e1e3ea441d869d3d612f9c0b32', '227m 52 cm 5mm', 1, 'd7bbaff6988c4c19aff6ceffeb41ab7c'),
(1022, '37affd70a2444ba1b04cc2e644b6bbbe', '225 m 250 cm 25 mm', 0, 'd7bbaff6988c4c19aff6ceffeb41ab7c'),
(1023, 'a7582912166943dcb5d4b5bdef4a342e', '225 m 252 cm 25 mm', 0, 'd7bbaff6988c4c19aff6ceffeb41ab7c'),
(1024, 'ade5c27f21344c7caa45af9bb4f5ac35', '227 m 50 cm 5 mm', 0, 'd7bbaff6988c4c19aff6ceffeb41ab7c'),
(1025, '3ef7d58bc1e54208bc3ecc703fc0ae06', '50 m 7 cm 1 mm', 1, 'd54341c94e014140b52503dad80eaa2a'),
(1026, 'f8efc5d1eabe439f97737d7d83b0b00d', '50 m 8 cm 1 mm', 0, 'd54341c94e014140b52503dad80eaa2a'),
(1027, '36b1a19c17f84e2a8130446fc536ebc4', '50 m 6 cm 1 mm', 0, 'd54341c94e014140b52503dad80eaa2a'),
(1028, '55e0b653570e4e43834d0bab4f8591c8', 'Impossible', 0, 'd54341c94e014140b52503dad80eaa2a'),
(1029, 'b1c1bbcee75444218910772d7b11d0f9', '66', 1, '3386b4431c53418dbe7dd1ac98eff2c6'),
(1030, 'e9d0290cbf524f719ba313063eb72b0f', '24', 0, '3386b4431c53418dbe7dd1ac98eff2c6'),
(1031, '855af2dbf3d54f9db5b53baa8869f27e', '56', 0, '3386b4431c53418dbe7dd1ac98eff2c6'),
(1032, '889d48421e0c4edc8a9f6ba8516c5cf6', '76', 0, '3386b4431c53418dbe7dd1ac98eff2c6'),
(1033, '4e82a0cae8a744efa83f8f2774cbee3c', '14', 1, '966793791c78437495b87109c1d780fb'),
(1034, 'e5fe5a7227494a4c90fb26afa39dfb81', '23', 0, '966793791c78437495b87109c1d780fb'),
(1035, '031a7fbb2ae743c2a98557af63131423', '7', 0, '966793791c78437495b87109c1d780fb'),
(1036, '9d91b18256ab484a87419da99120e60c', '21', 0, '966793791c78437495b87109c1d780fb'),
(1037, '24f4d06c209c43aa8a30d2045ac428bd', '256', 1, '3f03654d0cfa4e9b895cb0f09cf9222e'),
(1038, '0a03ac75632048af800bda9faf9f6a78', '156', 0, '3f03654d0cfa4e9b895cb0f09cf9222e'),
(1039, '6375192b923f49aa8d2da59acc03a438', '64', 0, '3f03654d0cfa4e9b895cb0f09cf9222e'),
(1040, '5038e9224cc34bd99eebf8dc52182871', 'Impossible', 0, '3f03654d0cfa4e9b895cb0f09cf9222e'),
(1041, '153351a129f64c4280be4ab412485cf1', '2 688 metre squared', 1, '19a4ca73f92c450d99d9904ff3d87c76'),
(1042, 'f10a248ac66f433287c886be2a58b111', '2 688 centimetre squared', 0, '19a4ca73f92c450d99d9904ff3d87c76'),
(1043, '66710ceab23b490baea5a84bf6aeeef8', '212 metre squared', 0, '19a4ca73f92c450d99d9904ff3d87c76'),
(1044, 'f0016e1ed5504040be561a3e3a1ca2fe', '212 centimetre squared', 0, '19a4ca73f92c450d99d9904ff3d87c76'),
(1045, '6c80fbca869647cb9968f6c7f2c2d605', '144', 1, '0bff63aadc1a44f09e5a7b67bd513559'),
(1046, '6a1e8d96e51c4afea4f192f37cf43ae9', '288', 0, '0bff63aadc1a44f09e5a7b67bd513559'),
(1047, '9e5ee417b2a7478198781eb079e6fd8d', '88', 0, '0bff63aadc1a44f09e5a7b67bd513559'),
(1048, 'a8439129e1f54c27baf7d82366c8d59b', '44', 0, '0bff63aadc1a44f09e5a7b67bd513559'),
(1049, 'fa10b1817994483a960171781ede4757', '9 700 ml', 1, 'd586e5dc29ea4947bb0405b0dad814f5'),
(1050, 'b64d2dcee35145489bb1cdd533dce0e3', '970 ml', 0, 'd586e5dc29ea4947bb0405b0dad814f5');
INSERT INTO `exams_topicalquizanswers` (`id`, `uuid`, `choice`, `is_correct`, `quiz_id`) VALUES
(1051, 'd8bdaf2a72d94433b7427d36cb001d52', '90 700 ml', 0, 'd586e5dc29ea4947bb0405b0dad814f5'),
(1052, '1cc6309f11a34011a5204809a171cee0', '97 ml', 0, 'd586e5dc29ea4947bb0405b0dad814f5'),
(1053, '8659ecbee068433b9f5b50da19f1c5ac', '78.054 l', 1, 'b6ae7c4f060b4626b082e831071c18de'),
(1054, 'dd616147612e49168fb64b7b3e755bce', '780.54 l', 0, 'b6ae7c4f060b4626b082e831071c18de'),
(1055, '4dff3a1db27c445dbbe4237751d435b3', '7. 8054 l', 0, 'b6ae7c4f060b4626b082e831071c18de'),
(1056, '78290d5bc78f43c6b01a7756c5d173d4', '7805.4 l', 0, 'b6ae7c4f060b4626b082e831071c18de'),
(1057, 'c7d21393524140d59c00955d0c498900', '1 000 000', 1, 'ad6e725d989a4d6d8bd038ef474e8035'),
(1058, '16cef77150774b35817d98e554f9dfdc', '100 000', 0, 'ad6e725d989a4d6d8bd038ef474e8035'),
(1059, '82f700f932344688bc11b1f43904a2f9', '10 000', 0, 'ad6e725d989a4d6d8bd038ef474e8035'),
(1060, '759ba15c3ca44573aa5e9aaa900b8273', 'Impossible', 0, 'ad6e725d989a4d6d8bd038ef474e8035'),
(1061, '3024ee9cf0a249d3a9e79fb11950dedf', '1 cubic metre', 1, '4e357098bb9e4112921bfc6a0706e59d'),
(1062, '0436368ebb714e1da5b041363c88f872', '100 cubic metre', 0, '4e357098bb9e4112921bfc6a0706e59d'),
(1063, '0d68a0f57d894917a5bba205a2926a8d', '1 000 cubic metre', 0, '4e357098bb9e4112921bfc6a0706e59d'),
(1064, 'e6685a9cea0b476fbbcb70885ca310c2', '10 000 cubic metre.', 0, '4e357098bb9e4112921bfc6a0706e59d'),
(1065, '9a620beb81c34e6a8d7a01dc7c01d409', '5 760 000', 1, 'b8f54098ec6b4a988f489f367bbd4fe5'),
(1066, 'd08ee95826874371b9843fc621a06645', '5.76', 0, 'b8f54098ec6b4a988f489f367bbd4fe5'),
(1067, 'ae3fe4f99af040aca2ec97f2b2045574', '576 000', 0, 'b8f54098ec6b4a988f489f367bbd4fe5'),
(1068, '75004c3087df42a192d8c7be13462ed2', '57 600', 0, 'b8f54098ec6b4a988f489f367bbd4fe5'),
(1069, '705c5cb6b1d74b40bbd9e90347181bdc', '12 cm', 1, '65944ca657ce469aab984ece26a2b619'),
(1070, 'e776b3567ab040dd968902339686f622', '24 cm', 0, '65944ca657ce469aab984ece26a2b619'),
(1071, '9ca3ad2d15d048d9ab0e2919295bdfc1', '13 cm', 0, '65944ca657ce469aab984ece26a2b619'),
(1072, '349dd072ac6348b3b1509d9a09ac310b', '26 cm', 0, '65944ca657ce469aab984ece26a2b619'),
(1073, '4e3dfbbafe8445bda1539122a8e7bae8', '10 cm', 1, '68a6b59b2ce04b648fe38b24daebcb8e'),
(1074, 'a5979cd151d741c5aba3f4d54ead9021', '0.5 cm', 0, '68a6b59b2ce04b648fe38b24daebcb8e'),
(1075, '78c23ca0b8214688bd6d28939dc521f7', '6 cm', 0, '68a6b59b2ce04b648fe38b24daebcb8e'),
(1076, '7e9d1047841e4f34b7dec5fec56acb5d', '0.8 cm', 0, '68a6b59b2ce04b648fe38b24daebcb8e'),
(1077, 'd8a9b75d10414aadbb157ecd20af8a87', '54 kg', 1, 'fbbb7f119a474f20b257976c2bfcc93a'),
(1078, '05d2ea60ca4b415883ae705d523f6bab', '540 kg', 0, 'fbbb7f119a474f20b257976c2bfcc93a'),
(1079, 'd415c1f56f2f4adc8cde38564f356f03', '5 400 kg', 0, 'fbbb7f119a474f20b257976c2bfcc93a'),
(1080, '70d473b67c0b4adb8e04833ad56083b2', '5.4 kg', 0, 'fbbb7f119a474f20b257976c2bfcc93a'),
(1081, 'f99df0c71958415aa2fe72d405576927', '11', 1, '79866fc6ca374c1b98cbf39c770e53fa'),
(1082, '94c6ba9c3eee4c999f519a647c4f37ed', '10 minutes 60 seconds', 0, '79866fc6ca374c1b98cbf39c770e53fa'),
(1083, '3a252f7059704db1bbaf2bfad82f54b2', '6.6 minutes', 0, '79866fc6ca374c1b98cbf39c770e53fa'),
(1084, '5aa9221df58e4c55ae1e58e380f84dd2', '66 minutes', 0, '79866fc6ca374c1b98cbf39c770e53fa'),
(1085, 'e537f9f73d494edc8841d5816c7411b0', '700 sh', 1, '4bd617934e374ce8bf4458299fb0c639'),
(1086, '6df05b3f53894a76842cc7b3ea868d63', '7 700 sh', 0, '4bd617934e374ce8bf4458299fb0c639'),
(1087, '4bd80175a4ee42589234a99b8a2b7c16', '500 sh', 0, '4bd617934e374ce8bf4458299fb0c639'),
(1088, '8552180c1a27457085ce4b948c630e40', '70 sh', 0, '4bd617934e374ce8bf4458299fb0c639'),
(1089, 'c5d06fd4216f4cfa90c64d8b532a930a', '400 sh loss', 1, '8ace7601bede4491b5f074b3b3240d44'),
(1090, 'cb65479b25ff453f9ca54ca3e454eeba', '400 ksh profit', 0, '8ace7601bede4491b5f074b3b3240d44'),
(1091, '23949322d35b4b96ae201cf4c68ab5a8', '3 650 profit', 0, '8ace7601bede4491b5f074b3b3240d44'),
(1092, '48fcf9d15c5c4f2db5e25fda1005bd21', '3 650 loss', 0, '8ace7601bede4491b5f074b3b3240d44'),
(1093, '86b42e8293c5466a934b04b271398494', '199 366', 1, '0b68d9fdab8f4b3581093168ed5383d3'),
(1094, '66c3758a18ed4bb4a4687304a3e8ec25', '128 100', 0, '0b68d9fdab8f4b3581093168ed5383d3'),
(1095, '0bcb05454d6f4babbe8fbc2c68efe6a3', '35 633', 0, '0b68d9fdab8f4b3581093168ed5383d3'),
(1096, 'c13999fc66b043a5a70a97b1444e6a35', 'None of the above', 0, '0b68d9fdab8f4b3581093168ed5383d3'),
(1097, 'cbe4d8eab97a4e6498c58af6ead62a57', '18n - 12', 1, '7337784229b647b987ab529327546eb4'),
(1098, '5dee55f33e454ae59217e43ae67847da', '6n', 0, '7337784229b647b987ab529327546eb4'),
(1099, '20893e9725ca4fbebbcd0a4d85a45181', '18n + 14', 0, '7337784229b647b987ab529327546eb4'),
(1100, '0d69f87c6aa84303966251079c505092', '6n - 12', 0, '7337784229b647b987ab529327546eb4'),
(1101, '545c0719a2c541c4af0cfe4cd6e7683b', '19p - 16x - 36', 1, 'de60cb7c1c614a10a889a283a534a8e5'),
(1102, '1451f59201e949658bf2595085a637e8', '19p + 16x - 36', 0, 'de60cb7c1c614a10a889a283a534a8e5'),
(1103, '21bcba24a7bd4df1991f379bbd37980e', '19p + 16x + 36', 0, 'de60cb7c1c614a10a889a283a534a8e5'),
(1104, '5d1a557506174b2d9b5b9b1d5bce8df5', 'Impossible', 0, 'de60cb7c1c614a10a889a283a534a8e5'),
(1105, 'c0c6955bc6fa40c19a2a1740a1e294c7', 'a = 9', 1, 'cc38deedf8634318a062cbde8da01d54'),
(1106, 'f3dfa0322cc44bc39f10d053cedbfac8', 'a = 3', 0, 'cc38deedf8634318a062cbde8da01d54'),
(1107, '3785086636e3488298233a32df3419fb', '4a = 12', 0, 'cc38deedf8634318a062cbde8da01d54'),
(1108, '56d6d155a7014637b896327798437cc0', '4a = 36', 0, 'cc38deedf8634318a062cbde8da01d54'),
(1109, '05853cee4a9c4e65b1188be317b7e03f', 'Plants that produce flowers, Maize', 1, '755cb7670d974b9b910e160f2c0c56bc'),
(1110, '53fe5e73a4d0463591dd0f3251e8118a', 'Plants that are flowers, Sunflower', 0, '755cb7670d974b9b910e160f2c0c56bc'),
(1111, 'dc190333e330496ba60119b072481f2d', 'Plants that do not produce flowers, Fern', 0, '755cb7670d974b9b910e160f2c0c56bc'),
(1112, '9d0b04fcbe2046faa8ec67874a118c52', 'Plants that do not reproduce, Algae', 0, '755cb7670d974b9b910e160f2c0c56bc'),
(1113, '109ecd32a2544de38d95ef7c15454c9c', 'They include algae and ferns', 1, 'e42e3def049e4121bdd5f062f07a3e9f'),
(1114, '3647ad384acd41d68247cafd4a33752d', 'They do not reproduce since they do not have flowers', 0, 'e42e3def049e4121bdd5f062f07a3e9f'),
(1115, 'eb37e2102c634b3cb86434619af61903', 'They lack flowers hence produce bad smells', 0, 'e42e3def049e4121bdd5f062f07a3e9f'),
(1116, '9d7f85f88c464bacb6be2cc9eff7d1ad', 'They include maize and mushrooms', 0, 'e42e3def049e4121bdd5f062f07a3e9f'),
(1117, '68404a044b884beabd421e7d34b95198', 'Maize, Lily', 1, '22ae3b1f6c3c457a9733c99f227e3ab4'),
(1118, 'd9b798dae1424c809543c6c603d810e9', 'Maize, Fern', 0, '22ae3b1f6c3c457a9733c99f227e3ab4'),
(1119, '01dad856ea614247be9c103676c537a8', 'Fern, Algae', 0, '22ae3b1f6c3c457a9733c99f227e3ab4'),
(1120, '13f05398ea994edeaaee47ebb281f23f', 'Beans, Mosses', 0, '22ae3b1f6c3c457a9733c99f227e3ab4'),
(1121, '88ffb0cc478744628617af90f0d24b89', 'Fern, Mosses, Algae', 1, '0c72df0f1be74b8d9cc7b6cb47a4bdf2'),
(1122, '680414a8039d4f4790ffe23f5a857ad1', 'Fern, Lily, Algae', 0, '0c72df0f1be74b8d9cc7b6cb47a4bdf2'),
(1123, 'ce0624d848ac4978bbdec131a63f8a15', 'Algae, Maize, Peas', 0, '0c72df0f1be74b8d9cc7b6cb47a4bdf2'),
(1124, '4218a5861a0540b6a179fc90e6f089f9', 'Peas, Beans, Lily', 0, '0c72df0f1be74b8d9cc7b6cb47a4bdf2'),
(1125, '3c28e79eab284aeb8d8aa5b0b5c79703', 'They are all functions of leaves', 1, 'f932b409d78c4aa6bf73f34c13eaa5c8'),
(1126, '62b85ba217b9449c97cb3b92bcc8af89', 'Produce food for the plant', 0, 'f932b409d78c4aa6bf73f34c13eaa5c8'),
(1127, '8cd476065bfe449b9bc0809a9f1f310b', 'Plants breathe through leaves', 0, 'f932b409d78c4aa6bf73f34c13eaa5c8'),
(1128, '7ed5f7e90fad427a8c7fb1f4f02556aa', 'They remove excess water from the plant', 0, 'f932b409d78c4aa6bf73f34c13eaa5c8'),
(1129, '105b50991ff6497bb3dbf3fffd466d1c', 'Trunk', 1, 'cf1230ebce2e428dbec7b722e7d28a16'),
(1130, '098ff8c956214a76823f4f4bda7b4fce', 'Body', 0, 'cf1230ebce2e428dbec7b722e7d28a16'),
(1131, 'b6b16d1cbed242ea9d87e292cba213cf', 'Log', 0, 'cf1230ebce2e428dbec7b722e7d28a16'),
(1132, 'a48bd92a137c439eae6f5a0470993c48', 'Back bone', 0, 'cf1230ebce2e428dbec7b722e7d28a16'),
(1133, '7696fdc360a74884a0edd63b4ebe359e', 'Support branches', 1, '13ab781fe4b34eadbbdfb7a14688802a'),
(1134, '3daf33f762eb410c90378db56db80c6b', 'Produce flowers', 0, '13ab781fe4b34eadbbdfb7a14688802a'),
(1135, '833552afb1344b69b40edcc84236a8a7', 'Absorb water', 0, '13ab781fe4b34eadbbdfb7a14688802a'),
(1136, 'cb5ed09ac852405690379a9568e49db4', 'None of he above', 0, '13ab781fe4b34eadbbdfb7a14688802a'),
(1137, 'f2be9314c07d44baba1113c526d9e3ad', 'They all smell nice', 1, '79e984b646ed4a32909a513ddbc3a505'),
(1138, '63e8f7be4e3f4109a3af00e88b9f6861', 'They have male and female parts', 0, '79e984b646ed4a32909a513ddbc3a505'),
(1139, '43d212232d174896908739aa1d476ff3', 'They produce nectar', 0, '79e984b646ed4a32909a513ddbc3a505'),
(1140, '9012d26d52b1445c838560a1b462a897', 'Some flowers have bright colors', 0, '79e984b646ed4a32909a513ddbc3a505'),
(1141, '36dcf1a2d846468a9109e6f0b183585a', 'Anther, Filament', 1, '0e418ee92fe54ccb814840d4361ae703'),
(1142, '2872085011714c3ca95405c5f2bcaaa7', 'Filament, Style', 0, '0e418ee92fe54ccb814840d4361ae703'),
(1143, '247bebf77e0048dd88594303effa5386', 'Stigma, Anther', 0, '0e418ee92fe54ccb814840d4361ae703'),
(1144, '22180ad9701b485ebf1d278be4de624c', 'Stigma, Style', 0, '0e418ee92fe54ccb814840d4361ae703'),
(1145, '36adbcb684a841389c641724cecd781f', 'Stigma, Style, Ovary', 1, '8cd062300f854e3fab7bd3eaf407e18b'),
(1146, '757718d9f873414083c61ca320dc3425', 'Stigma, Anther, Ovary', 0, '8cd062300f854e3fab7bd3eaf407e18b'),
(1147, '3d73168d9e304ac491b611d30bd85ed3', 'Ovary, Filament, Anther', 0, '8cd062300f854e3fab7bd3eaf407e18b'),
(1148, 'c61686560bc7432e9e5e67899e812cb6', 'Flowers do not have male and female parts', 0, '8cd062300f854e3fab7bd3eaf407e18b'),
(1149, 'e5dfcc84c801473e94bfed954022e1a4', 'They are all edible', 1, 'a2a579af045647088c33384a0d7cab7f'),
(1150, '0b07d88ef4e64e51aeef71f74b251647', 'They cover and protect seeds', 0, 'a2a579af045647088c33384a0d7cab7f'),
(1151, '14a023a642194f65b2ca14c8ede1ad84', 'Some are poisonous', 0, 'a2a579af045647088c33384a0d7cab7f'),
(1152, '0720f3b864494b50a148595b55bbdd82', 'Some are sweet while others bitter', 0, 'a2a579af045647088c33384a0d7cab7f'),
(1153, '08305de0105c4fefa5ac05210d32f598', 'Sodom apple, Datura', 1, 'c19627b9f3bf4b6f85a96bd787e31473'),
(1154, '05659ea494ad4b499886a3b1601bffe7', 'Mangoes, Apples', 0, 'c19627b9f3bf4b6f85a96bd787e31473'),
(1155, 'ed8f6443feb74d62a6de754e9c0c9042', 'Oranges, Grapes', 0, 'c19627b9f3bf4b6f85a96bd787e31473'),
(1156, '76e5ee676b83489b987b4f9802b7cfac', 'None of the above', 0, 'c19627b9f3bf4b6f85a96bd787e31473'),
(1157, 'c9334eedd03243759f302821fc6821a9', 'Produces pollen grains', 1, 'f09dbaf4c5ec4a448e0cd11c35e4bc10'),
(1158, '31be79980f44444d800022d1a45442eb', 'Holds filament in place', 0, 'f09dbaf4c5ec4a448e0cd11c35e4bc10'),
(1159, '08dfc7550737403497ff1a57267464bd', 'Produces ovules', 0, 'f09dbaf4c5ec4a448e0cd11c35e4bc10'),
(1160, '71873a3e2c274ead9c1a35dc976c0566', 'Captures pollen grain', 0, 'f09dbaf4c5ec4a448e0cd11c35e4bc10'),
(1161, 'cc3f729c0d8d46b69c110697408b94be', 'Holds the anther', 1, '0f9c50b6ed104c1187d370d63e580836'),
(1162, 'e7ada2a3a57e47eba93dc9eb29db5163', 'Produces pollen grain', 0, '0f9c50b6ed104c1187d370d63e580836'),
(1163, 'f25990d3c66f440bbdab652c2ed4f59e', 'Holds stigma in place', 0, '0f9c50b6ed104c1187d370d63e580836'),
(1164, '2bdb863de7bc40fbb3d04962cb1c3d6b', 'Produces ovules', 0, '0f9c50b6ed104c1187d370d63e580836'),
(1165, '645560bb465c45c996fde9c5d0c8852d', 'To capture pollen', 1, 'dcc84d9f9fe24f018f32779243a95310'),
(1166, 'a2b379672bf7486fb5ac97a5ec9445d8', 'To produce pollen grain', 0, 'dcc84d9f9fe24f018f32779243a95310'),
(1167, 'd79c6bb3c277481b91759cfef4f645cf', 'To hold the style in place', 0, 'dcc84d9f9fe24f018f32779243a95310'),
(1168, 'c00d752f8c6846e085af76b28338dd71', 'to produce ovules', 0, 'dcc84d9f9fe24f018f32779243a95310'),
(1169, 'b68cc777d63542ee895595c0f9225e08', 'To produce ovules', 1, '75450175bb4a42d0924a8b93902b8686'),
(1170, '43ceefd4f98145f297965d4c9f61f13d', 'To fertilise ovules', 0, '75450175bb4a42d0924a8b93902b8686'),
(1171, 'aafbda93488e482992d8d72f5582a0ba', 'To capture pollen', 0, '75450175bb4a42d0924a8b93902b8686'),
(1172, 'db6883689ea2483b8aaef80f0616235c', 'None of the above', 0, '75450175bb4a42d0924a8b93902b8686'),
(1173, '5fb7b780ec1a41b095d07a5781bbf4f7', 'Photosynthesis', 1, 'c8aeca0bd39346cd8daf41cf43c15685'),
(1174, '01220188b9c347b7bbbd0ced7fb30e58', 'Style', 0, 'c8aeca0bd39346cd8daf41cf43c15685'),
(1175, 'c20a072735254e99a3e2e53796db4800', 'Anther', 0, 'c8aeca0bd39346cd8daf41cf43c15685'),
(1176, '271a43ef45964716b3c230e79b284c5a', 'Petal', 0, 'c8aeca0bd39346cd8daf41cf43c15685'),
(1177, '64c9eb1cf7fa42719645197da0c26b78', 'They attract pollinators', 1, 'abe8028cd02c42d5a7b13eb9a9f74923'),
(1178, 'de8ee9197206486383193d8761fc3a4d', 'They produce pollen grain', 0, 'abe8028cd02c42d5a7b13eb9a9f74923'),
(1179, 'a1edb46b8b3545a6ae1e71d811473f54', 'They capture pollen grains', 0, 'abe8028cd02c42d5a7b13eb9a9f74923'),
(1180, '9f378e3885be481cacb1d10481e494d1', 'None of the above', 0, 'abe8028cd02c42d5a7b13eb9a9f74923'),
(1181, '8b4f2b68de0049c0841298250e46b39b', 'It is a root system made up of many branches of small roots', 1, '32281ff8bce9450fac82f87e7c551ece'),
(1182, 'af589d2572a94a74b1e70a9eddc13b99', 'It has one main root growing deep into the soil', 0, '32281ff8bce9450fac82f87e7c551ece'),
(1183, '819c46e35fb044978fd7bd4b67eaf7b2', 'An example of plants with fibrous root is beans', 0, '32281ff8bce9450fac82f87e7c551ece'),
(1184, 'b3dcdaf6a9c14997b7cc374128517afd', 'None of the above', 0, '32281ff8bce9450fac82f87e7c551ece'),
(1185, 'a07bd75dde2d4ea0bac67adc07b2796a', 'Beans, Ground nuts', 1, 'ee9d671b90894444a04b8fa9d0b51b29'),
(1186, '59c0dd84d00f44eb95311d898fcb2eea', 'Maize, Mango', 0, 'ee9d671b90894444a04b8fa9d0b51b29'),
(1187, '1d0cddf84bea417487f2db98b1e01311', 'Maize, Beans', 0, 'ee9d671b90894444a04b8fa9d0b51b29'),
(1188, '39f473b4744947e8a25fb1445cd46327', 'All of the above', 0, 'ee9d671b90894444a04b8fa9d0b51b29'),
(1189, '5dc5e005e52347d582a0832a135023a2', 'Spores', 1, 'fc7e2553bb39483bb9952da2dcfa32a6'),
(1190, '0480f50521df4f2a87b0f2bafc559c49', 'Fruits', 0, 'fc7e2553bb39483bb9952da2dcfa32a6'),
(1191, 'ce986db495bf4af5aaf606e428b6151b', 'Seeds', 0, 'fc7e2553bb39483bb9952da2dcfa32a6'),
(1192, 'bf2d2f272f8f47e7961a8b327d1cdd6c', 'Pollen grains', 0, 'fc7e2553bb39483bb9952da2dcfa32a6'),
(1193, 'd7460ec1afdd430e8dc0d82bfd9c5d15', 'The green coloring matter', 1, 'b701ee3b38ab4520af6a00d72939287e'),
(1194, '69aa9ba19dca40e68d8e761dd844827d', 'Male parts of a flower', 0, 'b701ee3b38ab4520af6a00d72939287e'),
(1195, '2fc6c0a2dd084fd99c0887fdc97a24a8', 'Female parts of a flower', 0, 'b701ee3b38ab4520af6a00d72939287e'),
(1196, 'a1af5f00ac8640ab83e0ca95130d2bb9', 'Pollen producing part of a flower ', 0, 'b701ee3b38ab4520af6a00d72939287e'),
(1197, 'c637042a58504fe6ada637c81b931ba1', 'They all contain backbones', 1, '66a4a2ae907940449cf9f943ecb22e88'),
(1198, 'c2320f39860d4791b754884ca1bcbdf7', 'Most have a backbone', 0, '66a4a2ae907940449cf9f943ecb22e88'),
(1199, 'ab80a3d156204e31afac0816d344b4ce', 'They are all warm blooded', 0, '66a4a2ae907940449cf9f943ecb22e88'),
(1200, 'b69d417a532d40c3b6e4e31c537eae1f', 'They all eat meat', 0, '66a4a2ae907940449cf9f943ecb22e88'),
(1201, 'ebcdd91f1ac442e39437d36a4ef886df', 'Fish, Reptiles', 1, 'd35c5b43dee842bf8a68706f9226b416'),
(1202, '8cba764777984fb38ab7e3c26d85d9d2', 'Reptiles, Arachnids', 0, 'd35c5b43dee842bf8a68706f9226b416'),
(1203, 'a42345d8d79544d7864c3c924c428459', 'Fish, Worms', 0, 'd35c5b43dee842bf8a68706f9226b416'),
(1204, '116dd715e6ed4ab897da6ede9e3a3ff7', 'Spiders, Tick', 0, 'd35c5b43dee842bf8a68706f9226b416'),
(1205, '0ba04e120200449e850c647261437e18', 'Dolphins', 1, '5858d67de26840658b1a4a688f7c79b1'),
(1206, 'fd2b0eecdc4e4d58bb9e9c8d1d2af359', 'Shark', 0, '5858d67de26840658b1a4a688f7c79b1'),
(1207, 'e9af2bcea74347b383993120db8d62fe', 'Gold fish', 0, '5858d67de26840658b1a4a688f7c79b1'),
(1208, 'c2f4b7aa27f84945a55b234992baf7ce', 'Herring', 0, '5858d67de26840658b1a4a688f7c79b1'),
(1209, '6d895c3a656d481e88dcd165e4e28b34', 'Whale, Tilapia', 1, 'c332250e6b744f1eb4ae81609c91a683'),
(1210, 'ddb50950ba0f41ccba7df013745b47c7', 'Dolphin, Frog', 0, 'c332250e6b744f1eb4ae81609c91a683'),
(1211, '39fa1dafc65b4d3c93f481af7e1e38e1', 'Human being, dolphin', 0, 'c332250e6b744f1eb4ae81609c91a683'),
(1212, 'a810580f5a434bef8ffbe2a6469fa196', 'Fish, Human being', 0, 'c332250e6b744f1eb4ae81609c91a683'),
(1213, '465fd95a36904a0da1467df2e0b6ed25', 'None of them can fly', 1, 'eca0491a77df40a18a4e0a79946ee76d'),
(1214, '148261e5ca2b4749a8e8a3496a9bd3b5', 'They are all warm blooded', 0, 'eca0491a77df40a18a4e0a79946ee76d'),
(1215, 'bc54d57e824a413789fe88a1322c3fbd', 'They breath through lungs', 0, 'eca0491a77df40a18a4e0a79946ee76d'),
(1216, '7a2c695cf7ae4453a5f6f092b2b214b7', 'Some of them live in water', 0, 'eca0491a77df40a18a4e0a79946ee76d'),
(1217, '0f159806495c4000af2e2277d55a4e51', 'They  all fly', 1, '3dad72b6543c4690a72bdb4302b61ade'),
(1218, '476f08a8454d416197a339cd4bd84b8a', 'They are warm blooded', 0, '3dad72b6543c4690a72bdb4302b61ade'),
(1219, 'acb5db42ab3046b39908f54136069c27', 'Some are cold blooded', 0, '3dad72b6543c4690a72bdb4302b61ade'),
(1220, '7d3df65c8e1f4c8188abf9dc5f8d1f7c', 'They have beaks', 0, '3dad72b6543c4690a72bdb4302b61ade'),
(1221, '9780a2584cf1488d8bc631d249252a47', 'Some are warm blloded', 1, '5e73774cffbf4b78a67a56aa8e001532'),
(1222, '67fca8f733294fa0b2e879967f5e8ff7', 'They are all cold blooded', 0, '5e73774cffbf4b78a67a56aa8e001532'),
(1223, '47156f6d3993475c97b1c44f682f03a4', 'They lay eggs', 0, '5e73774cffbf4b78a67a56aa8e001532'),
(1224, 'ab65181f7bce4efebe0538f97459f275', 'They breath through lungs skin and mouth', 0, '5e73774cffbf4b78a67a56aa8e001532'),
(1225, '8084d140f8bf451a83ffccc573f2ff1e', 'Frog', 1, '2c879405512e49cc847ac1d75fb72ccb'),
(1226, '00810ba2481c489b831dd33642f35485', 'Turtle', 0, '2c879405512e49cc847ac1d75fb72ccb'),
(1227, '63337c5954954ba29f204a802c4b61ef', 'Tortoise', 0, '2c879405512e49cc847ac1d75fb72ccb'),
(1228, '0526cb4300b74773af4550d4d91ed543', 'Alligator', 0, '2c879405512e49cc847ac1d75fb72ccb'),
(1229, 'e3f0ae790904439db4110f60614e782d', 'Newt', 1, '46389c3b80ab465eb27855073b37bce1'),
(1230, '281198cab2a143eebdb9a387fdb7adce', 'Locust', 0, '46389c3b80ab465eb27855073b37bce1'),
(1231, '1c11208c5d9a45489fdc2e146600a50b', 'Crabs', 0, '46389c3b80ab465eb27855073b37bce1'),
(1232, 'deb7980e52e84c7895be93c64a02ab27', 'Cray fish', 0, '46389c3b80ab465eb27855073b37bce1'),
(1233, '11741828cedd49b1828e769b7f1e4a87', 'They have six legs', 1, 'ddd9b30c728449d988c9e64a3fea6ec9'),
(1234, '49bb5958d5574e67bb2a806eb99ddd8b', 'They have 4 pairs of legs', 0, 'ddd9b30c728449d988c9e64a3fea6ec9'),
(1235, 'f67ef502220549d3b1e910303ac4d43e', 'Their bodies are divided into two parts', 0, 'ddd9b30c728449d988c9e64a3fea6ec9'),
(1236, '71aefba62fcf47e1b7ea72c21391fa08', 'They do not have wings', 0, 'ddd9b30c728449d988c9e64a3fea6ec9'),
(1237, 'be4b04abc669438cbbdcc25add6a587f', 'Mouth', 1, '780e587fdc6840e1ba60865d551d5531'),
(1238, '9f8b2ca8d063440b939699e2e65cb8ff', 'Bronchus', 0, '780e587fdc6840e1ba60865d551d5531'),
(1239, 'a1e27ecad670496b9dd7603ebb6e2684', 'Diaphragm', 0, '780e587fdc6840e1ba60865d551d5531'),
(1240, '7b7618cecce0412aa97297fda10c5ddc', 'Lung', 0, '780e587fdc6840e1ba60865d551d5531'),
(1241, '09a1c95df2fd416d937cc6bb108d7a02', 'Trachea', 1, '999f823f3f8040c4a6c3a52484201cde'),
(1242, '9e6e82427b92426d9b92ce6a69bc14d6', 'Bronchus', 0, '999f823f3f8040c4a6c3a52484201cde'),
(1243, 'e89b1381d6834ec6a9fde99b1c72fd9a', 'Mouth', 0, '999f823f3f8040c4a6c3a52484201cde'),
(1244, 'b043ac215cda4df39df3ff359fba0f0b', 'Nose', 0, '999f823f3f8040c4a6c3a52484201cde'),
(1245, 'cdefecb0243c4a7da29ef9975b09f710', 'To pass air to bronchus', 1, '45918614a52143fcb4bb991ce7c9c377'),
(1246, '08bb8adf2a324ed49070bd6a64286d40', 'Pass oxygen to the lungs', 0, '45918614a52143fcb4bb991ce7c9c377'),
(1247, 'a98a58d1c25d40d588054f3f5da02407', 'To pass carbon dioxide to the lungs', 0, '45918614a52143fcb4bb991ce7c9c377'),
(1248, '2c3409cfc15b40c4bceef3dabfe48cdf', 'Filters air coming from the lungs', 0, '45918614a52143fcb4bb991ce7c9c377'),
(1249, 'b3814d270a914e12a92dac3bdaccfdde', 'TO exchange oxygen and carbondioxide', 1, '1128b464e295438fb4adbbf6a1712c90'),
(1250, '21f156d7a7b34e2d99362275ad885fb9', 'To pass oxygen to the heart ', 0, '1128b464e295438fb4adbbf6a1712c90'),
(1251, '1218c0442de5439792dfc092aeb465cc', 'To pass carbon dioxide to the blood ', 0, '1128b464e295438fb4adbbf6a1712c90'),
(1252, '451666319f0f43e181d9ec15d6b5915d', 'To filter air to remove germs', 0, '1128b464e295438fb4adbbf6a1712c90'),
(1253, 'c81958292f85424388ba7346c911c8fb', 'It expands and contracts to increase and decrease volume of chest cavity', 1, '8487b759af534c6799e1722e30214df4'),
(1254, '4e4ef63a94214f1099b722dcd8b21492', 'To filter dust from air', 0, '8487b759af534c6799e1722e30214df4'),
(1255, '4cda09a691534b228159e933335ce5fb', 'To filter germs from air', 0, '8487b759af534c6799e1722e30214df4'),
(1256, '054ccba4f2db4fd7bc8a1d5b3dd2ecda', 'None of the above', 0, '8487b759af534c6799e1722e30214df4'),
(1257, '3c4eba3cd31648dfb01c929a53f762ad', 'To increase chest cavity', 1, 'c6d94b55c1e74bb589906cedbcfa952b'),
(1258, 'd37c97a7147a4a93971d2b7f537adace', 'To filter dust and germs from the air entering into the lungs', 0, 'c6d94b55c1e74bb589906cedbcfa952b'),
(1259, '3422e10661814efbab9bf657c6c0ca6d', 'To pass air into the lungs', 0, 'c6d94b55c1e74bb589906cedbcfa952b'),
(1260, 'c2d6fb7b31454c77bcfeecd40a29eef4', 'To receive air from trachea', 0, 'c6d94b55c1e74bb589906cedbcfa952b'),
(1261, '682ca458699741719f7df54e54a7d11d', 'mixtures that do not have uniform composition and properties throughout', 1, 'bc1ab7318e1848f5b8a0c97b7e87db54'),
(1262, 'aa07f8b2b1a0405ab8b8624c7dfb20da', 'Mixtures that uniform composition', 0, 'bc1ab7318e1848f5b8a0c97b7e87db54'),
(1263, 'a145c12d853b47eb8e315602d533c7db', 'Mixtures that fully mixes', 0, 'bc1ab7318e1848f5b8a0c97b7e87db54'),
(1264, '3c077ca967114bfd951ceadc1609a3e1', 'None of the above', 0, 'bc1ab7318e1848f5b8a0c97b7e87db54'),
(1265, '72eb3224f13c4e83b5328f7b6510a637', 'They form a uniform mixture', 1, 'e5fded685c4044a494254fdca4dc7183'),
(1266, '791d1008a6944594a32bd2198a98a87e', 'Elements that do not mix settle at the bottom of the solution.', 0, 'e5fded685c4044a494254fdca4dc7183'),
(1267, '9f8177577e414fed9c52ba02cb89e492', 'Elements that do not mix settle at the top of the solutuion.', 0, 'e5fded685c4044a494254fdca4dc7183'),
(1268, '5c5b7495b2e345ebae84a0b18c23ea26', 'None of the above', 0, 'e5fded685c4044a494254fdca4dc7183'),
(1269, '973839b80ae343cab1fb280adfb96b10', 'Distillation', 1, 'c9b86a49b99e4c5a997f0819338d0022'),
(1270, 'd2f85f3bbb8d457b9770f0490e48915e', 'Sieving', 0, 'c9b86a49b99e4c5a997f0819338d0022'),
(1271, '5baf3bfc173e42b0a8e436d37a30d521', 'Handpicking', 0, 'c9b86a49b99e4c5a997f0819338d0022'),
(1272, 'b27cbe0de1b2452a92ba7b6f9852bc04', 'Filtration', 0, 'c9b86a49b99e4c5a997f0819338d0022'),
(1273, '1f4d86f05ebc435d8c5c0215029f241e', 'Filtration, Handpicking', 1, '72795f163f1145fd8fc4b4d8a6164930'),
(1274, 'bfca6305bd2940509f001c2d1fb6a3c5', 'Distillation, Evaporation', 0, '72795f163f1145fd8fc4b4d8a6164930'),
(1275, '3c0c8c5d22c44df89b281dee9b879b4a', 'Filtration, Distillation', 0, '72795f163f1145fd8fc4b4d8a6164930'),
(1276, 'b1e5b38e216d44179806291644154864', 'Decanting, Evaporation', 0, '72795f163f1145fd8fc4b4d8a6164930'),
(1277, '9fd22d849cd14ddf9e2d3a7793f1a112', 'Separates chaff and grain', 1, '4e2c65b6164848b58a72171ddaea5063'),
(1278, '6d18868bdb544ff2ad7e36bbd8359961', 'Separates metalic and non-metallic mixtures', 0, '4e2c65b6164848b58a72171ddaea5063'),
(1279, '139a6049247a46a3b77f27266c645e54', 'Separates homogenous mixtures', 0, '4e2c65b6164848b58a72171ddaea5063'),
(1280, '3ce63dbaa91745d7b5c714e392eca9b5', 'None of the above', 0, '4e2c65b6164848b58a72171ddaea5063'),
(1281, '25f7ad1a68464a7cbb9e80644ff6b922', 'Adding of distruptive elemnts to our water sources', 1, '08e4c2e73a0e4a7891019a76e8dcb9da'),
(1282, '196dc1727af2489da551a77ae82e17d8', 'Bathing in rivers and lakes', 0, '08e4c2e73a0e4a7891019a76e8dcb9da'),
(1283, 'e276caf263934ffd857a90d0de490be1', 'All of the above', 0, '08e4c2e73a0e4a7891019a76e8dcb9da'),
(1284, '65ec9585c52c4639a547512d03c6e75f', 'Adding pollutants to our environment', 0, '08e4c2e73a0e4a7891019a76e8dcb9da'),
(1285, 'e62bc12c80a848c8998b5640c213b6b5', 'Adding chemicals for water treatment', 1, '7703d7f913564fdca869961d3d5959af'),
(1286, '9a76d9a8ef324b28a7f5a1d042c221ae', 'Washing our clothes in the river', 0, '7703d7f913564fdca869961d3d5959af'),
(1287, '44c59451aa0f418d80c491d08ad68029', 'Throwing dead fish in the lake', 0, '7703d7f913564fdca869961d3d5959af'),
(1288, 'c111e923f60344318ab802a4bb65bbdd', 'Pouring sewages to our water sources', 0, '7703d7f913564fdca869961d3d5959af'),
(1289, '725da36fd3784869b1ae538492125e56', 'Promotes afforestation', 1, 'd7bce54c0cd04d6c9cf9e0a9a732b517'),
(1290, '520af80325d44da1a33d4e0de96714a4', 'Kills living things in our water sources', 0, 'd7bce54c0cd04d6c9cf9e0a9a732b517'),
(1291, '0e3bf7122b1345e8bf5f126e558e8e80', 'Makes water unsafe for consumption', 0, 'd7bce54c0cd04d6c9cf9e0a9a732b517'),
(1292, '7dcc0a7d45024812b1c2a76bb82d964f', 'Causes water borne diseases', 0, 'd7bce54c0cd04d6c9cf9e0a9a732b517'),
(1293, '9b4f978c190d44198e83fae7b9c73e9b', 'Water treatment', 1, '9123effb96d444f6a6f4793781a1d20b'),
(1294, '02ba5e96f7fe4ea8bef41bb7c4286ecd', 'Arresting persons who pollute water', 0, '9123effb96d444f6a6f4793781a1d20b'),
(1295, 'd80608523be24527a6e97137407484e4', 'Proper disposal of sewages', 0, '9123effb96d444f6a6f4793781a1d20b'),
(1296, 'e439a376bf9c442d92f4efffbf47d5c3', 'All of the above', 0, '9123effb96d444f6a6f4793781a1d20b'),
(1297, '1012e43d08b547139b0675481e0625a6', 'Boiling, Solar treatment', 1, 'e88bde52d08e4f55856f91b30bbdc884'),
(1298, '4346d5a7ce364fa5b8863e3e3ffd04cd', 'Solar treatment, Magnetisation', 0, 'e88bde52d08e4f55856f91b30bbdc884'),
(1299, 'd81ca40fea72467aa85fb67905c5e6d9', 'Proper disposal of sewages, Boiling', 0, 'e88bde52d08e4f55856f91b30bbdc884'),
(1300, 'd973314297d2473d93bee7e3fcd2b8eb', 'Proper disposal of sewages, Winnowing', 0, 'e88bde52d08e4f55856f91b30bbdc884'),
(1301, 'c7db38642aa0434d81eeada256cc0f07', 'Cohesive force', 1, '9658f1714cf744d0a0e7dac5c7358db4'),
(1302, '40e7a1d193c646ceaf789081a5942dcd', 'Density', 0, '9658f1714cf744d0a0e7dac5c7358db4'),
(1303, '02488e4d701f49a8abbadbae70e92d94', 'Volume', 0, '9658f1714cf744d0a0e7dac5c7358db4'),
(1304, '130041f903264a9683471085730fc82b', 'Mass', 0, '9658f1714cf744d0a0e7dac5c7358db4'),
(1305, '1b9e769b0e014023bc9f127739c2d256', 'A hollow steel sphere less dense than water', 1, '517719cf777b47018fa67f33f3e37b40'),
(1306, '46179ef1c9f04b27afe04aa8e070d07e', 'A ship wreck', 0, '517719cf777b47018fa67f33f3e37b40'),
(1307, '50ebc6d6f96d49ac8777e39b6a7426ca', 'A rock', 0, '517719cf777b47018fa67f33f3e37b40'),
(1308, 'eb8a17629eeb4db5901e2a69ec1a6995', 'A spoon', 0, '517719cf777b47018fa67f33f3e37b40'),
(1309, '15cd02c80c934c68995990b888b85919', 'Used in making of boat anchors', 1, '28b3b3cb8f934420a0de4b95d96cbb30'),
(1310, '8e400bdaedc34add8e5ea9b5b4118afc', 'Used in making of boats', 0, '28b3b3cb8f934420a0de4b95d96cbb30'),
(1311, 'adf4258fef064eb5933833c80316f85e', 'Used in making of aeroplanes that can float on water', 0, '28b3b3cb8f934420a0de4b95d96cbb30'),
(1312, '9d9d48acf8164302b7bf224ea8b105c2', 'Used to make lifebuoy', 0, '28b3b3cb8f934420a0de4b95d96cbb30'),
(1313, '813efe74be3f44a6a6c2f9799ec79179', 'Makin of boat anchors', 1, 'b5b065fcc1324a47857de0ec5cb8e921'),
(1314, 'd06a02bb634d4cd8bf0ec35a19a0c402', 'Making of lifebuoy', 0, 'b5b065fcc1324a47857de0ec5cb8e921'),
(1315, '64c2d8f5718d404a938e1844c4646b06', 'Making of boats', 0, 'b5b065fcc1324a47857de0ec5cb8e921'),
(1316, '0ae73145ac1d49718e13d898e0648f8e', 'Making of life jackets', 0, 'b5b065fcc1324a47857de0ec5cb8e921'),
(1317, '8987495a68754bb6b92276c439cb66c7', 'Sound proof materials', 1, 'a3a7948cc0aa413884d87ec09902a29a'),
(1318, 'e9740495071941f3a00155a16b3730c9', 'Guns', 0, 'a3a7948cc0aa413884d87ec09902a29a'),
(1319, 'c173d1bd01a143bb915b47ce7f24838e', 'Bells', 0, 'a3a7948cc0aa413884d87ec09902a29a'),
(1320, '3e4807e6790048358ff5d6edd867602b', 'Mouth', 0, 'a3a7948cc0aa413884d87ec09902a29a'),
(1321, '9b63e7b93d4d4205a509ad6d606cb7cd', 'In all directions outward from its source', 1, '192f0e65d1ca4ddb8fdd42e3a87347ec'),
(1322, '7b281ebd34d747b6bbc3cf3111a1caa1', 'In a straight line', 0, '192f0e65d1ca4ddb8fdd42e3a87347ec'),
(1323, '5388b660bd394c1caae5b35d0fb1a3ee', 'In circular directions towards the soource', 0, '192f0e65d1ca4ddb8fdd42e3a87347ec'),
(1324, 'af19b43a53324769b3e19e92307f4a4a', 'None of the above', 0, '192f0e65d1ca4ddb8fdd42e3a87347ec'),
(1325, '9f6f439ce0c34a31a82b54263537030d', 'None of the above', 1, 'e4b5f73c9ddc460cb246f8188fee5e8f'),
(1326, '55f21742f8c04027aa2c36e23832eccb', 'It moves in all directions from the source', 0, 'e4b5f73c9ddc460cb246f8188fee5e8f'),
(1327, 'af72e3f7025641d5b04265080aca9b67', 'It moves by causing vibrations', 0, 'e4b5f73c9ddc460cb246f8188fee5e8f'),
(1328, 'd040a7e129d34302a8a3337bea25168a', 'It can be reflected', 0, 'e4b5f73c9ddc460cb246f8188fee5e8f'),
(1329, '06991cfd3ef14bbd9c107814cd4e08f7', 'Making of solar waves', 1, 'dffb0c776fae43f5b5b8ca27dd085c5a'),
(1330, '5e0e72e674bb4f2e9ba63112e2d7f6a3', 'Making bells', 0, 'dffb0c776fae43f5b5b8ca27dd085c5a'),
(1331, '05c7da475e944d49ab8f66a74c2d8e27', 'Making of horns for ships', 0, 'dffb0c776fae43f5b5b8ca27dd085c5a'),
(1332, '23affd3f6dee4b7fa20ac7b9a4ce3579', 'Making of sound proof material', 0, 'dffb0c776fae43f5b5b8ca27dd085c5a'),
(1333, '81bb96931be24aef8fcdb8b6219ad0d4', 'Sun bathing', 1, '25a89a2162c241deafa99ba8cecfb2dd'),
(1334, 'fed1f2daeb504a63b87f3123ea8e347c', 'Conduction', 0, '25a89a2162c241deafa99ba8cecfb2dd'),
(1335, '6c0ce415c3764cfa8ce22e4c44e91844', 'Convection', 0, '25a89a2162c241deafa99ba8cecfb2dd'),
(1336, '7f25c09226d54ec4ae01c4e3c391ca26', 'Radiation', 0, '25a89a2162c241deafa99ba8cecfb2dd'),
(1337, '442f9f45df234911ab5b1c01766fcfbb', 'Radiation', 1, '0e945d25067f4c24adcb3136f5d7264c'),
(1338, 'c179f8d316f440a1ba967ee58a00ff20', 'Convection', 0, '0e945d25067f4c24adcb3136f5d7264c'),
(1339, '63c5c4642aa942d6be1b9f81421633d7', 'Irradiation', 0, '0e945d25067f4c24adcb3136f5d7264c'),
(1340, 'a28f164a95584239bfce6c2ed22a4fc4', 'Advection', 0, '0e945d25067f4c24adcb3136f5d7264c'),
(1341, 'd2d30af5e62b4eda91e17f768b3ce350', 'The transfer of heat in fluids', 1, '7009229737e34d6e8ef306ac6d94bf85'),
(1342, '27caf6e63b8b45089e0e11f7d1f67d6c', 'The transfer of heat in liquids', 0, '7009229737e34d6e8ef306ac6d94bf85'),
(1343, 'd3c3bba743a1488aa91cf89e440d3605', 'Transfer of heat in solids', 0, '7009229737e34d6e8ef306ac6d94bf85'),
(1344, '6ac43e1ba6cb40dfa6769cde87b79939', 'Transfer of heat through space', 0, '7009229737e34d6e8ef306ac6d94bf85'),
(1345, 'b83e6326b9b344b689808f337439254b', 'Conduction', 1, 'a4a454319c114e1892db70dd128fbcc0'),
(1346, 'c7625b29f5474a0886ed5a3cf3e8a038', 'Convection', 0, 'a4a454319c114e1892db70dd128fbcc0'),
(1347, 'ab8060ebf4ac4808a08b9ae00983d2ec', 'Radiation', 0, 'a4a454319c114e1892db70dd128fbcc0'),
(1348, '64b0bb867f264c4795f4f5db238838f2', 'Advection', 0, 'a4a454319c114e1892db70dd128fbcc0'),
(1349, 'c1565c9f77ce4c018937db18d7a74e29', 'Materials that conduct heat effectively', 1, 'c2c2ca17a6d5480b81c773a27bbf2dd6'),
(1350, '8f7b9fc48b604756930100eb0501065d', 'Materials made of metal', 0, 'c2c2ca17a6d5480b81c773a27bbf2dd6'),
(1351, 'df71e3241ab94a86839d4e16531ec71a', 'Materials that preserve heat', 0, 'c2c2ca17a6d5480b81c773a27bbf2dd6'),
(1352, '7030ea067dad4905802c037c01884a2b', 'None of the above', 0, 'c2c2ca17a6d5480b81c773a27bbf2dd6'),
(1353, '75960e2d28e0444eb3417a1c18e0b01a', 'Steel spoon, Sufuria', 1, '58c858b0d5f742938d5dd2b027d91f6a'),
(1354, '296077ad5a6248de8ff3fba88857301a', 'Steel spoon, Wood', 0, '58c858b0d5f742938d5dd2b027d91f6a'),
(1355, 'c66afafa3b314b74b7ac49709ef169dc', 'Logs, Sufuria', 0, '58c858b0d5f742938d5dd2b027d91f6a'),
(1356, '7bc51a28280d43fbb6e959a9fc0b1d58', 'Iron box, Mittens', 0, '58c858b0d5f742938d5dd2b027d91f6a'),
(1357, '96379ec9f6b84884b58f9487a3270443', 'They are used while making mittens', 1, '2994eee0b78e49f8b53a857c9182332c'),
(1358, 'd7969ed548b14203b608f12680790230', 'They are used for making cooking pots', 0, '2994eee0b78e49f8b53a857c9182332c'),
(1359, 'f50ffdd685a94c68aa08bb5097cddb1b', 'They are used for making iron box', 0, '2994eee0b78e49f8b53a857c9182332c'),
(1360, 'b0e79c1368d1457dbf02c5cee38cb88e', 'They are used for making water heaters', 0, '2994eee0b78e49f8b53a857c9182332c'),
(1361, 'ed6f3ace8a274a7088d108f83e584f28', 'Toad stool, Mushrooms, Puff balls', 1, '5599cffa3eb14451ad1f6f508a6a5b77'),
(1362, '70ecba596f464b0b9e59e63e877e2212', 'Fern, Mushrooms, Moss', 0, '5599cffa3eb14451ad1f6f508a6a5b77'),
(1363, 'fb625418768d4e1a9ba0846666d68893', 'Moss, Puff balls, Mushrooms', 0, '5599cffa3eb14451ad1f6f508a6a5b77'),
(1364, '977b3f287af149d58dc5e254969fe251', 'Fern, Moss, Toad stool', 0, '5599cffa3eb14451ad1f6f508a6a5b77'),
(1365, 'b778e5537b5946c3a81112471341fbaa', 'Provide pollen for pollination', 1, 'a50e112d9bf745e499a918540da3a08f'),
(1366, '1d93fae8cfc945a8934ae20b32af47da', 'Used in making of medicines', 0, 'a50e112d9bf745e499a918540da3a08f'),
(1367, '10b257026fff447197d87f91ddd14019', 'Used for fermentation', 0, 'a50e112d9bf745e499a918540da3a08f'),
(1368, 'e93a4d78ba5d4784b3553920a397e2b4', 'A source of food', 0, 'a50e112d9bf745e499a918540da3a08f'),
(1369, '2b42acad3ab544a5b5ece704f9b24241', 'Animals that do not have a backbone', 1, 'b420ed463f7b4ba0a981edcc7588a9e4'),
(1370, '32cfd6cf48fe418c800f81f9e856ee8d', 'Animals that have a backbone', 0, 'b420ed463f7b4ba0a981edcc7588a9e4'),
(1371, '590e7cefc78540cca528166946e1e057', 'Animals that are cold blooded', 0, 'b420ed463f7b4ba0a981edcc7588a9e4'),
(1372, '2d59f348e53146a3af263f6e464dec56', 'Animals that are warm blooded', 0, 'b420ed463f7b4ba0a981edcc7588a9e4'),
(1373, '125f84c918f848c0b8b93327a52b3c54', 'Octopus, Start fish , Crabs', 1, 'f21f7dc6d9344e938e395422bcca6a9d'),
(1374, 'b3d7f646d8604e1d85687710979d2fef', 'Crabs, Spider, Newt', 0, 'f21f7dc6d9344e938e395422bcca6a9d'),
(1375, 'f14c024e233e4d41886f2756ae5e4e49', 'Newt, Worms, Insects', 0, 'f21f7dc6d9344e938e395422bcca6a9d'),
(1376, '73a196abeb2945ba8c4f0d17d703bef9', 'None of the above', 0, 'f21f7dc6d9344e938e395422bcca6a9d'),
(1377, '121e740833944e09ae1f65e1c8e4120e', 'They lack of a vertebra', 1, '0db877c3e6f74f13b2f81f9db5770de7'),
(1378, '6ca6ebdaca69445695c3eaf717b9e928', 'They have a vertebra', 0, '0db877c3e6f74f13b2f81f9db5770de7'),
(1379, '675f9ccca6b14181b544a2449297e1f4', 'They are all cold blooded', 0, '0db877c3e6f74f13b2f81f9db5770de7'),
(1380, 'b05429fe5a274060bce2de1f82d6c663', 'They are all warm blooded', 0, '0db877c3e6f74f13b2f81f9db5770de7'),
(1381, 'e15ad820ca794ead89b6f06d4f741fd9', 'They help to cure diseases', 1, '8f9e5d1826cd4967b3689f36ad98e014'),
(1382, '5ee3e36583ee4e859f1507af7e2010eb', 'They are a food source', 0, '8f9e5d1826cd4967b3689f36ad98e014'),
(1383, 'fd650fbbf18e4e5eac751ddb74a909da', 'They help in pollination', 0, '8f9e5d1826cd4967b3689f36ad98e014'),
(1384, 'c2d9ce962a5a4a7da25c0e9082e243f2', 'They help in soil aeration', 0, '8f9e5d1826cd4967b3689f36ad98e014'),
(1385, 'e762190956b74b2fa74f743b1bf425e3', 'Kidney', 1, '0a80e65e908a48bd99010f8d5eda3eba'),
(1386, 'fcf836ac07e849008d9def2a7e097993', 'Blood', 0, '0a80e65e908a48bd99010f8d5eda3eba'),
(1387, 'ba5b0cc57a1a413ba0d53fdcecbe3a07', 'Blood vessels', 0, '0a80e65e908a48bd99010f8d5eda3eba'),
(1388, '5dc9b108debc48bea91b465893e47605', 'Heart', 0, '0a80e65e908a48bd99010f8d5eda3eba'),
(1389, '314b83d3a6004167b78ae30e0b7d38c8', 'To pump blood into the atteries', 1, 'aabca3249d834bf69883e1fa67138613'),
(1390, '728867f773b144d7b15953eed0874e75', 'To mix blood and oxygen', 0, 'aabca3249d834bf69883e1fa67138613'),
(1391, '8a1aa3c5d6da456ab34bdf1ff72119df', 'To extract carbon dioxide from blood', 0, 'aabca3249d834bf69883e1fa67138613'),
(1392, '95cf5e22a8d4432e8968e6704f252194', 'To beat', 0, 'aabca3249d834bf69883e1fa67138613'),
(1393, '11fc54825f2847ea9be774373ea61640', 'To deliver oxygen to tissue', 1, '085a18cb3fd84132ae5c2f945202420e'),
(1394, '0f1910667d614e14a6c078d81b7d825b', 'To deliver carbon dioxide to body organs', 0, '085a18cb3fd84132ae5c2f945202420e'),
(1395, 'de05c2888fdf416a843d781abe7db19c', 'All of the above', 0, '085a18cb3fd84132ae5c2f945202420e'),
(1396, 'e14abac5631841f2936be50e44c11ef1', 'To keep the body warm', 0, '085a18cb3fd84132ae5c2f945202420e'),
(1397, '1337111d83234844a7730267d476f664', 'To transport and regulate blood flows', 1, '5c84167c0e274703b5c491c8fb218aa0'),
(1398, '50512f28971f4b00b5521157c134011e', 'To remove carbon dioxide from blood', 0, '5c84167c0e274703b5c491c8fb218aa0'),
(1399, 'd048689152a84504acb147f4f57d975a', 'To add oxygen to the blood', 0, '5c84167c0e274703b5c491c8fb218aa0'),
(1400, '395338916fc44133bb6c96ab033dcdcf', 'None of the above', 0, '5c84167c0e274703b5c491c8fb218aa0'),
(1401, '7a8a52318f1740a1aa68779de0b8e891', 'Oxygen is the highest composition of air', 1, '68fa3c5656864f6981f6f52cd6ac13cb'),
(1402, 'fa7c81b67fd745dbb6b36669c2d50daa', 'Air is a mixture of gases', 0, '68fa3c5656864f6981f6f52cd6ac13cb'),
(1403, 'f1bc3e90e75a4a8b8ca524ccec1d19f0', 'Air contains water vapour', 0, '68fa3c5656864f6981f6f52cd6ac13cb'),
(1404, '7ae29cc45ba041b2ba8fc15fa3253526', 'Nitrogen is the highest composition of air', 0, '68fa3c5656864f6981f6f52cd6ac13cb'),
(1405, '631c70f302cf4053a1259bae2d97282b', 'Carbon dioxide, Argon, Oxygen, Nitrogen', 1, 'b2fbe6f1ba294586a67e7d9f98ef9075'),
(1406, '34efffa669954edea9365eb59f770ae5', 'Nitrogen, Oxygen, Argon, Carbon dioxide', 0, 'b2fbe6f1ba294586a67e7d9f98ef9075'),
(1407, '66b98aa8ff8b4fb09b18768ba98e1eb9', 'Oxygen, Nitrogen, Carbon dioxide, Argon', 0, 'b2fbe6f1ba294586a67e7d9f98ef9075'),
(1408, '98439bc28d464c8a84477ff668d70443', 'Carbon dioxide, Argon, Nitrogen, Oxygen', 0, 'b2fbe6f1ba294586a67e7d9f98ef9075'),
(1409, 'ff8699f7b4ce4ae1bd8948cf581242e6', 'Used in making of fertilizer', 1, 'a83bdbd7f6cc4342a8ab74bd7610664f'),
(1410, 'c9c8e964ecf640fc8be0a4f32493c9c2', 'Useful to the body when breathing', 0, 'a83bdbd7f6cc4342a8ab74bd7610664f'),
(1411, '8858fddb9a624d449b2170f481a16d3c', 'Useful when putting out fire', 0, 'a83bdbd7f6cc4342a8ab74bd7610664f'),
(1412, 'fe26a2b596cb4bcab0e91284923fd017', 'None of the above', 0, 'a83bdbd7f6cc4342a8ab74bd7610664f'),
(1413, '3ba94ec867de48759237a8defcfbe02b', '726.112', 1, '32b31b7eaaa94be398d3e3b673edb2ce'),
(1414, 'a4194175ac104ef99ed0c296379b88ea', '725.1122', 0, '32b31b7eaaa94be398d3e3b673edb2ce'),
(1415, '82bc583380ba40d4a224d9b8b9ea5889', '725.112', 0, '32b31b7eaaa94be398d3e3b673edb2ce'),
(1416, '2687e57577d24429acaf0cd59156cd18', '727.112', 0, '32b31b7eaaa94be398d3e3b673edb2ce'),
(1417, '20f9d9a4e4624f89a146789d8bfa9735', '80', 1, 'b9eddbc451064c099c201e1a8f7efdc2'),
(1418, '241f852c85954f74ad1b181a0b8c4a3e', '90', 0, 'b9eddbc451064c099c201e1a8f7efdc2'),
(1419, 'fe0d92e28a6e4b3a94cb9ad17a981fb4', '530', 0, 'b9eddbc451064c099c201e1a8f7efdc2'),
(1420, '6fa9912ff2a44048b07f261b5ea19565', '53.0', 0, 'b9eddbc451064c099c201e1a8f7efdc2'),
(1421, '0216283715854830b0372233709b8852', '616', 1, '8bb162139d8f4c0683ebea28207644a3'),
(1422, '77f5a8cc1720456cb51c4f2bcbf4707d', '516', 0, '8bb162139d8f4c0683ebea28207644a3'),
(1423, '7a5ebe6252d24693a537ecde08815533', '716', 0, '8bb162139d8f4c0683ebea28207644a3'),
(1424, '1f889edd2ff54c95984938da19c02d2f', '81', 0, '8bb162139d8f4c0683ebea28207644a3'),
(1425, '81dbf6fda2724661ae36c2efd6644018', '4', 1, 'bc32d047ed654c7da05749422622db9f'),
(1426, '2b4f6802281446eea448a1322434d777', '6', 0, 'bc32d047ed654c7da05749422622db9f'),
(1427, '11e5cee374e84414b694a6ceffc6768f', '8', 0, 'bc32d047ed654c7da05749422622db9f'),
(1428, '92c282341cdf487eaf4b9fe5125ff00f', '3', 0, 'bc32d047ed654c7da05749422622db9f'),
(1429, '8532cb40664146a482c4ea9f4938ba51', 'Left auricle, Right auricle', 1, '691e382e04cd4feea3f3cfb2946c2b86'),
(1430, '8b2697e8b75d4eb698b684c06ab7f5fa', 'Left auricle, Right ventricle', 0, '691e382e04cd4feea3f3cfb2946c2b86'),
(1431, '2c3f7a2cee704c90b7d746b3e9c5a7b7', 'Right ventricle, Left Ventricle', 0, '691e382e04cd4feea3f3cfb2946c2b86'),
(1432, '57d54c9933024ae085eb3f4e8bad81b4', 'Right auricle, Aorta', 0, '691e382e04cd4feea3f3cfb2946c2b86'),
(1433, '10291d0f9f764833a089d5ea300ce4c1', 'Right Ventricle', 1, '554a3ddba6bf44f5b337f7dfd769804f'),
(1434, '694be452dfe84dce8d097475cdec2394', 'Left Ventricle', 0, '554a3ddba6bf44f5b337f7dfd769804f'),
(1435, '2529f863f1814f899044115a50909e31', 'Left Auricle', 0, '554a3ddba6bf44f5b337f7dfd769804f'),
(1436, '3a6507ec9cc94b4a83834d2bcf8561d7', 'Right Auricle', 0, '554a3ddba6bf44f5b337f7dfd769804f'),
(1437, '3996a680ab9c4fc2be3ab8ffd95756c3', 'To pump blood to all parts of the body', 1, '644f23dc39e34eb7b27233711a0258af'),
(1438, 'b9e1e22ced8c4114820a90669d60849a', 'To pumb blood to the lungs', 0, '644f23dc39e34eb7b27233711a0258af'),
(1439, '8ab184ce0d764a3397774479b82a6e73', 'To pump blood to the left auricle', 0, '644f23dc39e34eb7b27233711a0258af'),
(1440, 'b2c634f5d6eb4a57ba354bd24b1e3530', 'To pump blood to all body parts and the lungs', 0, '644f23dc39e34eb7b27233711a0258af'),
(1441, '963a1371eac44d81a575d19ce6109f88', 'Baby', 1, '46f12200132f43718a18b185c561fd4b'),
(1442, 'dae9d28f6a0b41328cfe1f2b61170133', 'Adult', 0, '46f12200132f43718a18b185c561fd4b'),
(1443, '3b4bf3f43130446e8815fa7ccf6107d4', 'They all beat at the same rate', 0, '46f12200132f43718a18b185c561fd4b'),
(1444, '5e9423e0be5d4c4d9a09fda4f9bca9f2', 'None of the above', 0, '46f12200132f43718a18b185c561fd4b'),
(1445, '29c071336f39480dbc7d7fd6b9e863b8', 'Right auricle, Venacava', 1, '6bde147aae6d45a1b8bfe03a947ef91e'),
(1446, '0ed73463733945d69cf5efb7ed5f1931', 'Left Auricle, Venacava', 0, '6bde147aae6d45a1b8bfe03a947ef91e'),
(1447, '9d0fa924685f4a1fa287c95ff1660882', 'Heart, Venacava', 0, '6bde147aae6d45a1b8bfe03a947ef91e'),
(1448, 'c0db7b5b2e7e4427ab5a8c0c1b837854', 'Right auricle, Pulmonary artery', 0, '6bde147aae6d45a1b8bfe03a947ef91e'),
(1449, '52454155b41140e8a58b3fd8bc8f5744', 'Left auricle via pulmonary vein', 1, 'b077459672454be2b02fea8d014f134d'),
(1450, 'aa3642de9e0a4d8b84053f5d0e7a417f', 'All parts of the body', 0, 'b077459672454be2b02fea8d014f134d'),
(1451, '60e1a6005f414378a30f627f16f2975e', 'Brain', 0, 'b077459672454be2b02fea8d014f134d'),
(1452, '066bbaf5738d473093a2b4e6128cfda5', 'Right auricle via pulmonary artery', 0, 'b077459672454be2b02fea8d014f134d'),
(1453, 'b9bae113d2064ee79b050b8186fb1467', 'Aorta', 1, '669bef6a32354ff4817b0dbbe8bfadab'),
(1454, '352864207f294c2f8246c747ffc853b5', 'Pulmonary vein', 0, '669bef6a32354ff4817b0dbbe8bfadab'),
(1455, 'be0022dbdef6418fb8fdcb764493f46e', 'Pulmonary artery', 0, '669bef6a32354ff4817b0dbbe8bfadab'),
(1456, '7919e0c9f11e4e0e9f9578de4be6f096', 'Venacava', 0, '669bef6a32354ff4817b0dbbe8bfadab'),
(1457, 'ff9a04819f844ace8f4d70569adf21f5', 'Capillaries', 1, '6fb35040969b4333a71606c6af651213'),
(1458, '88906eb7e5ed446d944d8b48d5b83df1', 'Arteries', 0, '6fb35040969b4333a71606c6af651213'),
(1459, '7e90611c0efa47c0a93ced8a2f170023', 'Veins', 0, '6fb35040969b4333a71606c6af651213'),
(1460, '418695bb91f848cbb0a39bb95aeddbf3', 'Platelets', 0, '6fb35040969b4333a71606c6af651213'),
(1461, 'ee44342814584d289e2aecbe5bf0b285', 'Transport of blood from organs to the heart', 1, 'd4e2414214964fd084a69067ee8da102'),
(1462, '5786dcc37b47429fb0b284d1fa1d0cb0', 'Transport of blood from organs to lungs', 0, 'd4e2414214964fd084a69067ee8da102'),
(1463, '892b46215b2a41bf952df926d3399fc0', 'Transport of blood from lungs to other body parts', 0, 'd4e2414214964fd084a69067ee8da102'),
(1464, '72bb4554622a4a9a927d7928ca5a7ffc', 'Transport of blood from  the heart to organs', 0, 'd4e2414214964fd084a69067ee8da102'),
(1465, '34ea7d01ab604a67a7af0e37e264a7f1', 'To transport blood from heart to other body parts', 1, '6f80c107d5684250bb74815dcdc2b733'),
(1466, 'e868ca3b1ab14168b1076bfe9869168e', 'To transport blood from organs to the heart', 0, '6f80c107d5684250bb74815dcdc2b733'),
(1467, '13d3d6ca57dd4593bc5343e14a2775ee', 'To transport blood from lungs to other body parts', 0, '6f80c107d5684250bb74815dcdc2b733'),
(1468, '0a5f2f88f4074cfaa88006603de500bc', 'To transport blood from the brain to the heart', 0, '6f80c107d5684250bb74815dcdc2b733'),
(1469, '6005f6ebe2344246b666cc17622046e0', 'Red blood plasma', 1, '85cc9a47f6264c05b92ed761df95e861'),
(1470, '00b55c4a1f93411eae15df919b1e0929', 'Plasma', 0, '85cc9a47f6264c05b92ed761df95e861'),
(1471, '6d89d0ca31c24f97b09f36a8c0b7f9ff', 'White blood cells', 0, '85cc9a47f6264c05b92ed761df95e861'),
(1472, '20c990024705428f8814898582f481b0', 'Platelets', 0, '85cc9a47f6264c05b92ed761df95e861'),
(1473, '0b4bfcfcd9614d56be5f3a680d837027', 'To transport oxygen to all body organs', 1, '2733882310bd433c8353e64f87091ce2'),
(1474, 'c0d48ebc891146829be89d9cd2d27f10', 'Transport of waste products from organs to the skin', 0, '2733882310bd433c8353e64f87091ce2'),
(1475, '4bbf216a098445c8b6aa234581f1bf95', 'Transport of white blood cells to injured parts', 0, '2733882310bd433c8353e64f87091ce2'),
(1476, 'ef3fa961f1c148dbbcd15ed3077f1bc8', 'To distribute heat throughout the body', 0, '2733882310bd433c8353e64f87091ce2'),
(1477, '46002f5c7e6a44a6b4c11b6f18380704', 'Red blood cells', 1, '5c092f3a3c954c5d808a2fe834fc1d48'),
(1478, 'de65334b19ae48d88bb69bec9e68af34', 'White blood cells', 0, '5c092f3a3c954c5d808a2fe834fc1d48'),
(1479, 'c839a1364297479093ab75c7a7ec6751', 'Blue blood cells', 0, '5c092f3a3c954c5d808a2fe834fc1d48'),
(1480, '032be3265a5747a98acb4e0755d73cbe', 'Plasma', 0, '5c092f3a3c954c5d808a2fe834fc1d48'),
(1481, 'b5466004f3554fe88d705abf6ee02d06', 'To fight and destroy disease causing organisms', 1, 'b969f12d41574a578d886ac0879936cd'),
(1482, '03e764c48844466e96870c6eb73ff9ac', 'To transport oxygen to other body parts', 0, 'b969f12d41574a578d886ac0879936cd'),
(1483, '2a8c44d52df742a4a60ee3ca0315273d', 'To cause blood clotting to stop bleeding', 0, 'b969f12d41574a578d886ac0879936cd'),
(1484, '7843332fe9214796bcc4cd93d23bc7f4', 'None of the above', 0, 'b969f12d41574a578d886ac0879936cd'),
(1485, 'f420378378864a6c9c2ddae428e03cf3', 'All of the above', 1, '9d2d536070344258a22cda80afbecac2'),
(1486, '34df55ff2ad647b8b441d4bfb7e2c160', 'It contains haemoglobin', 0, '9d2d536070344258a22cda80afbecac2'),
(1487, 'e6908ccad0bb4d7f814fa2cfa6079fa1', 'Haemoglobin combines with oxygen to transport the oxygen to body tissues', 0, '9d2d536070344258a22cda80afbecac2'),
(1488, '216c3c671dd746ae80f497db6a7f0768', 'Haemoglobin combines with carbon dioxide and transports it to the lungs', 0, '9d2d536070344258a22cda80afbecac2'),
(1489, 'b9544aecd90b4550bc23d9a5ac05c4e9', 'To cause blood clotting to prevent excessive blood loss', 1, '52224bf8d56f4efaa5b91a7ddf8096c4'),
(1490, '71ff7d8539f842688ec52f1aa55f4146', 'To fight diseases', 0, '52224bf8d56f4efaa5b91a7ddf8096c4'),
(1491, '3a864289fb8641a286f0a9ab89a5aece', 'To transport oxygen to other body parts', 0, '52224bf8d56f4efaa5b91a7ddf8096c4'),
(1492, '26733b2b24c0463996ea765e5e2380df', 'To transport carbon dioxide from body parts to the lungs', 0, '52224bf8d56f4efaa5b91a7ddf8096c4'),
(1493, '9b4127dc22c241688c7e063181e6275f', 'Icing', 1, 'cdcf93bdddba46489458b53fc84de544'),
(1494, 'fe3e63a3e4084e5b8c34882e242af3e5', 'Sublimation', 0, 'cdcf93bdddba46489458b53fc84de544'),
(1495, '68d75313ef774473b5725fc195ffcc43', 'Evaporation', 0, 'cdcf93bdddba46489458b53fc84de544'),
(1496, 'cf313a08597d4f039be651098a151205', 'Deposition', 0, 'cdcf93bdddba46489458b53fc84de544'),
(1497, '47266b10b3db45af895acb4d3615cbe3', 'Condensation', 1, '538dae8b99684f9f88b652ddbcd195eb'),
(1498, '6f8bd568cf6a46f0a9573d290c3976fc', 'Evaporation', 0, '538dae8b99684f9f88b652ddbcd195eb'),
(1499, 'a7b9145327cd4a8c911a3be3f01f9364', 'Sublimation', 0, '538dae8b99684f9f88b652ddbcd195eb'),
(1500, 'c697a179484c46d69dcb4b05a514bb1c', 'All of the above', 0, '538dae8b99684f9f88b652ddbcd195eb'),
(1501, 'e1e156d5c7c64c3d82f982cd34bc8da1', 'Change of state where a substance transitions directly from a solid to a gas ', 1, 'a0debe3d170d4e139cd96b489d012eb3'),
(1502, 'a818bd9f8098407e877eab244d8fdf4a', 'Change of state where a substance transitions directly from a gas  to solid', 0, 'a0debe3d170d4e139cd96b489d012eb3'),
(1503, 'c99358853e6341d287207744b4ab1971', 'Change of state where a substance transitions directly from a gas  to liquid', 0, 'a0debe3d170d4e139cd96b489d012eb3'),
(1504, '2e071027ce2c40e49f08259c96dfdbf2', 'Change of state where a substance transitions directly from a  solid to a liquid', 0, 'a0debe3d170d4e139cd96b489d012eb3'),
(1505, '8611b224b5b94ae68b039189119bdfa5', 'Sublimation', 1, '175ede72582a4438a85ba2d05769b20f'),
(1506, '18b890f951b449139ed74f9a4426e627', 'Deposition', 0, '175ede72582a4438a85ba2d05769b20f'),
(1507, 'd9c2db7302ab4b50bf30fb08b79363db', 'Freezing', 0, '175ede72582a4438a85ba2d05769b20f'),
(1508, '31363c7f9c96410c896c2bffec72263a', 'Condensation', 0, '175ede72582a4438a85ba2d05769b20f'),
(1509, '13d4e19e492743b0a51b3d758641faf1', 'Freezing', 1, 'acbfeba5cf574a1596d566c016d9b867'),
(1510, '62a9f4be7ae1468c8b442e1ee3fec1cc', 'Condensation', 0, 'acbfeba5cf574a1596d566c016d9b867'),
(1511, 'd3e5a143f810495e987552dbc4222bfd', 'Deposition', 0, 'acbfeba5cf574a1596d566c016d9b867'),
(1512, '1ca74a2e6b1c43198ff5bde96da6f2a6', 'Sublimation', 0, 'acbfeba5cf574a1596d566c016d9b867'),
(1513, 'be38001ee4c04ccd93c2ce8a81837240', 'Condensation', 1, '3f04c183921f4c709f48a68164a32532'),
(1514, '7b458612143b4f00b81fbecb69a6d063', 'Freezing', 0, '3f04c183921f4c709f48a68164a32532'),
(1515, '3e202af64b3e45faa3532df0d7b3259c', 'Sublimation', 0, '3f04c183921f4c709f48a68164a32532'),
(1516, 'a29fff6d2a9f488ab97ce632db9ef7b0', 'None of the above', 0, '3f04c183921f4c709f48a68164a32532'),
(1517, 'ee6c2677562947c59472cbdf4967a7c6', 'Used by firefighters to put out fires', 1, 'c77e01160cbf4a208bc17e1b043794ca'),
(1518, '98f4e604a27e47f29f53fdfe4b578af3', 'Used in the making of gas tanks for divers', 0, 'c77e01160cbf4a208bc17e1b043794ca'),
(1519, '44cccf42e97c4c53972db1d5a1f97fa7', 'Used in making of life support sytems in aeroplanes', 0, 'c77e01160cbf4a208bc17e1b043794ca'),
(1520, 'ba5e874caec042be9e4b74a187d2003d', 'Used in making of metal cutting furnace', 0, 'c77e01160cbf4a208bc17e1b043794ca'),
(1525, '440d70aaa27745b29a2c88c6c56a4bc8', 'Used in making of fluorescent bulbs', 1, '1ab0c85dd49e42098992a70aa13359f3');
INSERT INTO `exams_topicalquizanswers` (`id`, `uuid`, `choice`, `is_correct`, `quiz_id`) VALUES
(1526, 'b7829db05949423ebe55e478acb59e53', 'Used in making of fertilizers', 0, '1ab0c85dd49e42098992a70aa13359f3'),
(1527, 'f7dd7fbf6bf945b1a4116ad0a19c3fcf', 'Used in making of fire extinguishers', 0, '1ab0c85dd49e42098992a70aa13359f3'),
(1528, 'b73e3e277ac94541b67cf6427449bc52', 'All of the above', 0, '1ab0c85dd49e42098992a70aa13359f3'),
(1529, '874289c940434189bfc2073a2e6ce798', 'Causes death of fish in the seas', 1, '1d65bd4d6cf546f093582d55c334e018'),
(1530, '14cc9b5c050849e9b1133c264b1c2ef0', 'Cause acid rain', 0, '1d65bd4d6cf546f093582d55c334e018'),
(1531, '5989c5e1333844e8920374d2fde8520c', 'Causes respiratory diseases', 0, '1d65bd4d6cf546f093582d55c334e018'),
(1532, '722cf6f38ff04c25a3b63a80e8a10917', 'Reduces visibility', 0, '1d65bd4d6cf546f093582d55c334e018'),
(1533, '1d97fa60d0c84c7b8bc46844a264ad3d', 'Wearing of masks ', 1, 'bad77fcc122941bead9396e6249b4f01'),
(1534, '24b38ff0757e4909ba0cb54cc912af7f', 'Afforestation', 0, 'bad77fcc122941bead9396e6249b4f01'),
(1535, '5898a320af5642e2b8db501705576748', 'Taking a walk in short distances instead of driving', 0, 'bad77fcc122941bead9396e6249b4f01'),
(1536, '6be73f73fe9347fd838cd1c22d8bb6c7', 'Using of energy sparingly', 0, 'bad77fcc122941bead9396e6249b4f01'),
(1537, '2ae1344548924ced90a2191c4e7c96a0', 'None of the above', 1, 'c9ea6e321dc846049da4bda234b51f2a'),
(1538, '7185117cebbf4ad29d2298c67d117ee9', 'Opaque', 0, 'c9ea6e321dc846049da4bda234b51f2a'),
(1539, '6e7db5aebb764fe5bc10a47fa47075b4', 'Transluscent', 0, 'c9ea6e321dc846049da4bda234b51f2a'),
(1540, 'e3d74e8b4d334929a652796fb4a526af', 'Transparent', 0, 'c9ea6e321dc846049da4bda234b51f2a'),
(1541, 'e4130b06a7d9420ba81aa9505e28e82a', 'A material that allows some light to pass through', 1, 'd33f2880268c41db8caa6ba7377b5586'),
(1542, 'c91bee20b4714fe9b3c9555fc9ddabab', 'A material that allows all the light to pass through', 0, 'd33f2880268c41db8caa6ba7377b5586'),
(1543, '136a39f58be3425d8bea05becbb61c6f', 'A material that does not allow any light to pass through', 0, 'd33f2880268c41db8caa6ba7377b5586'),
(1544, '01ac3d920b91495c97d076366d04f9e0', 'A material that reflects light', 0, 'd33f2880268c41db8caa6ba7377b5586'),
(1545, 'e18692e3dbea4d9ba5a93f0b2e14426f', 'An astronomical event that occurs when the shadow of the Earth is cast on the moon', 1, 'c5885c85a76244199f9632afa391184d'),
(1546, 'b60050c946c44f518e11195cbf1ea4b5', 'An astronomical event that occurs when the shadow of the moon is cast on the Earth', 0, 'c5885c85a76244199f9632afa391184d'),
(1547, '39f86941ca784322ae975cf3ed3f9224', 'An astronomical event that occurs when the earth becomes dark', 0, 'c5885c85a76244199f9632afa391184d'),
(1548, '5847e12ed8d94ea193fa3ddd76c2c796', 'An astronomical event that occurs when the moon fully lights up', 0, 'c5885c85a76244199f9632afa391184d'),
(1549, '20fded6ff70f4a0d8a5c2ab201c6a29d', 'An  astronomical event that occurs when the Moon passes between the Earth and the Sun, blocking all or part of the Sun\'s light.', 1, '143eeefe5d7a404c933d18651cd484f3'),
(1550, '691be33f88904927984679c040c9fca2', ' astronomical event that occurs when the Earth passes between the moon and the Sun, blocking all or part of the Sun\'s light.', 0, '143eeefe5d7a404c933d18651cd484f3'),
(1551, '0af0951886bf49ac96d5955aa90c0f75', ' astronomical event that occurs when the Moon passes between the Earth and the Sun, blocking all of the Sun\'s light.', 0, '143eeefe5d7a404c933d18651cd484f3'),
(1552, '11581a8fd07c46d4b23610119cebaaf3', 'All of the above', 0, '143eeefe5d7a404c933d18651cd484f3'),
(1553, '0943ec3982d8460595e0b011920af825', 'Purple', 1, 'dd6b9bc5ec19406b84aefc4fb5ec30e2'),
(1554, '974e73a2f2b348bea397727ac237803e', 'Violet', 0, 'dd6b9bc5ec19406b84aefc4fb5ec30e2'),
(1555, '7b1bb1a4010d4f0dbf210198df2dcc3e', 'Red', 0, 'dd6b9bc5ec19406b84aefc4fb5ec30e2'),
(1556, '6947b54ea53f4319861afaf2eded97c1', 'Indigo', 0, 'dd6b9bc5ec19406b84aefc4fb5ec30e2'),
(1557, 'ae0c23a9f863423584e5a67608dc559a', 'The bouncing of light', 1, 'ea556ff0007a489ba5c8db15f52bdc62'),
(1558, '367f1b3d034e479d986f9eb9e59268dd', 'The bending of light', 0, 'ea556ff0007a489ba5c8db15f52bdc62'),
(1559, '6f86045569e3449695142c8c34d73988', 'The movement of light in a straight line', 0, 'ea556ff0007a489ba5c8db15f52bdc62'),
(1560, '6484505b9c29440683cbf0306821d679', 'None of the above', 0, 'ea556ff0007a489ba5c8db15f52bdc62'),
(1561, 'dafd6351996649f2a53fe56b7c79bc78', 'The bending of light', 1, '5ae1fcbb40aa44c18f688417fbc14199'),
(1562, '0950b8b091c447eaa31860a8ba22a127', 'The bouncing of light on surfaces', 0, '5ae1fcbb40aa44c18f688417fbc14199'),
(1563, 'bd511d6883314559a4ed455897d5c6d1', 'None of the above', 0, '5ae1fcbb40aa44c18f688417fbc14199'),
(1564, 'dea21062696e4b559259553d3c041264', 'All of the above', 0, '5ae1fcbb40aa44c18f688417fbc14199'),
(1565, '4e2aed113c4e4351b494991bac7968a0', 'Refraction', 1, '016981d9247444e28c812ccd30677200'),
(1566, '057a775b1f6b421c8589e8d6f977dc16', 'Reflection', 0, '016981d9247444e28c812ccd30677200'),
(1567, '92f969fafe5f4eba9c9c80b207f1c371', 'Shadowing', 0, '016981d9247444e28c812ccd30677200'),
(1568, 'cb6610fe73544e51a18c3aceb976fbcf', 'None of the above', 0, '016981d9247444e28c812ccd30677200'),
(1569, '3927ff23bba346308f0d7d697b29f8d1', 'Slope', 1, '088f135bfd9647ac8eaab8fbaee5c00e'),
(1570, 'cf10c6d17c3942118332767d37d2dcbe', 'Seesaw', 0, '088f135bfd9647ac8eaab8fbaee5c00e'),
(1571, 'd9e163ad11a349e78632df803c09862d', 'Wheelbarrow', 0, '088f135bfd9647ac8eaab8fbaee5c00e'),
(1572, '9e6f5e5086214328a3d4e4152a081ef9', 'Crowbar', 0, '088f135bfd9647ac8eaab8fbaee5c00e'),
(1573, 'ccc8f5e4f1924c1f97d9d2d97a8b4ff0', 'Gear', 1, '3d8eafeb480c4050b980c7772d0b9653'),
(1574, 'b74527b5c6e94dff9d01554946d7b491', 'Fulcrum', 0, '3d8eafeb480c4050b980c7772d0b9653'),
(1575, '88023f2737aa4f449e058afab5f80f90', 'Load', 0, '3d8eafeb480c4050b980c7772d0b9653'),
(1576, 'd75d78f1b3dc4511bd8788e0a2c896e4', 'Effort', 0, '3d8eafeb480c4050b980c7772d0b9653'),
(1577, 'b4dc7152aa264805803389e5d3014121', 'First class, Second class, Third class', 1, '6348a869fea9417498f537606284e0d1'),
(1578, '16e23bbdd0c34d5ea13a71f24b280be2', 'Simple levers, Gears, Slopes', 0, '6348a869fea9417498f537606284e0d1'),
(1579, '17b38d54bce047f0b82c8ab8131cc983', 'Slopes, Gears, Fulcrums', 0, '6348a869fea9417498f537606284e0d1'),
(1580, '72d83b81ecf44542899b151784a86092', 'Simple levers, Medium Levers, Complicated levers', 0, '6348a869fea9417498f537606284e0d1'),
(1581, 'a52cbab0f1494ee7ad4d0c0109934701', 'Reduces the effort needed', 1, 'b8eacada96cb4c05bacad20deee397bc'),
(1582, '7abb4f0214dc4bdcae3de69c3f9fa620', 'Reduces the weight of load', 0, 'b8eacada96cb4c05bacad20deee397bc'),
(1583, '7637c2a317034a4cb4f4c00710c1911c', 'Reduces friction', 0, 'b8eacada96cb4c05bacad20deee397bc'),
(1584, 'f6ceaf6fb4124aba917a98bb45acfa04', 'All of the above', 0, 'b8eacada96cb4c05bacad20deee397bc'),
(1585, '920b3dd4f04544e685479e0be0eb2c1d', 'Seesaw', 1, 'b5c2c593bb94465b90e81ea9a34419de'),
(1586, '58dac14a31e943d79bbfb30325dfaed3', 'Wedge', 0, 'b5c2c593bb94465b90e81ea9a34419de'),
(1587, '477123ef3cc642d4968acd233e836de7', 'Ladder', 0, 'b5c2c593bb94465b90e81ea9a34419de'),
(1588, '772a9654fe7e41508f591c044d7d095a', 'Roads winding up a hill', 0, 'b5c2c593bb94465b90e81ea9a34419de'),
(1589, '25e227c385be42bcaa626f8f006590c4', 'Ramp', 1, '82c4734eea7b4b1e89100dd7d1f281be'),
(1590, '4f45b02ebe1544d6be2aa4702bb12c61', 'Staircase', 0, '82c4734eea7b4b1e89100dd7d1f281be'),
(1591, '2c4641619a9e4df29be8d5d823d3c29c', 'Wheels', 0, '82c4734eea7b4b1e89100dd7d1f281be'),
(1592, '46cd44eb6be540ec992f885e78029843', 'Ladder', 0, '82c4734eea7b4b1e89100dd7d1f281be'),
(1593, 'eb789bbb47d342b3a529ff5d716bd818', 'None of the above', 1, 'ab226a8b6f394a12960c4a178eb833e2'),
(1594, '683576e3c1ba4540a78a4a9b8b94ee21', 'They increase distance required to reach the intended height', 0, 'ab226a8b6f394a12960c4a178eb833e2'),
(1595, '7124291f6a5e44908e5109e89d4f25a8', 'They reduce force required to achieve a task', 0, 'ab226a8b6f394a12960c4a178eb833e2'),
(1596, 'c095e55e02e84358a6a5f9b2b1e958be', 'Slopes are an inclined plane', 0, 'ab226a8b6f394a12960c4a178eb833e2');

-- --------------------------------------------------------

--
-- Table structure for table `exams_topicalquizes`
--

CREATE TABLE `exams_topicalquizes` (
  `id` char(32) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `quiz` longtext NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `subtopic_id` char(32) NOT NULL,
  `topic_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exams_topicalquizes`
--

INSERT INTO `exams_topicalquizes` (`id`, `file`, `quiz`, `subject_id`, `subtopic_id`, `topic_id`) VALUES
('00ea73b3472e4c28b26914b19b508a66', '', 'Round of 8 454 to the nearest hundreds.', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('016981d9247444e28c812ccd30677200', '', 'Which of the following light movement causes rainbow formation ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('01dfd877879444c481548df6452d5c95', '', 'Round of 6 997 to the nearest 10.', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('024863521d044198a5c26ecea7ba54b1', '', 'Round of 67 478 to the nearest thousands.', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('02b7ac47c567464d81244ff876146ae2', '', 'Work out 4m 36 cm ÷ 4.', 1, '7e82335799a14158a19e53ef835ae3a2', 'deea8f67f1fe4a3b88d22f92378804b8'),
('069472379bcb4e88a990132287037bde', '', 'Subtract 4 km 336 m from 8 km 106 m.', 2, '5619dcccad384f419efa3f4f5aec3554', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('078292ffc1344431a2a6cb8c52ffc14b', '', 'A cuboid tank is 3cm thick. The measurements of the cuboid has a length of 12 cm a width of 6 cm and a height of 6 cm. Calculate the volume of the cuboid.', 2, 'abd163cdcdfe4c06ab86e3aa36bd1120', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('07b20456082749f7ae717411087e6f52', '', 'Which of the following is the correct way to reduce air pollution in our environment ?', 4, 'e018fa86c90144c5b2b1ba8e8902cab2', '870d063230e54ab6bc6aaf166ca586b5'),
('07bf7129229342d08c701fc69056e7ed', '', 'Which of the following pair of objects sinks in water ?', 4, '440d08aeb1594ce780f82e895fb91391', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('081124b34c4248f991c24f113e745402', '', 'What is the place value of digit seven in 47 345 ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('085a18cb3fd84132ae5c2f945202420e', '', 'Which of the following is the correct function of blood in the circulatory system ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('087d6ce6562e40ebb8dca35f3a626553', '', 'A teacher had 42 sweets. He distributed the sweets among 11 students each receiving equal number of sweets. How many did each student get and how many was the teacher left with respectively ?', 1, '48a82f0c48ff4eb2b91d293858558644', 'b2a64da77fac499194c1d0bb4a416a34'),
('088f135bfd9647ac8eaab8fbaee5c00e', '', 'Which of the following is not an example of a lever ?', 6, 'bf4099a7123a4f448b9f971e8dcb5373', '5fce52cdc4744270b20972d3dc4fa0f1'),
('08e4c2e73a0e4a7891019a76e8dcb9da', '', 'What is the meaning of water pollution ?', 5, '6383a55dc9854486a0725d9bb4fb9ecd', '481defbe30ca4f1d9c3bc519ee6db70c'),
('093ec5f0b5cc4710a6c0147fb2e5e2c8', '', 'Which of the following contains odd numbers only ?\r\n36, 6 057, 710, 209', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('09a9b6ec849541319bd025374801312f', '', 'Complete the following pattern. 3, 9, 27,  ................ ?', 1, '95701a724ebf41b685f8fa1aa1c5ccbd', 'b2a64da77fac499194c1d0bb4a416a34'),
('0a0582091aa24528a84a3aec8f599ef7', '', 'Which of the following is not a part of the human digestive system ?', 4, '68cebfc7bb1b4512afaf5a7fd7e99c1d', '071b225f158b4a55a286539d3625be93'),
('0a80e65e908a48bd99010f8d5eda3eba', '', 'Which of the following is not a part of human circulatory system ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('0b68d9fdab8f4b3581093168ed5383d3', '', 'While trading online a trader realised a loss of ksh 35 633 after selling stock for ksh 163 733. What was the buying price of the stocks ?', 3, '7dfac60fffb44980b25c5ac1fe63f0cc', '059c4ba191e84558a48ae44acb8718d4'),
('0bc31e7162424c6bb31fa39a53842d7f', '', 'When handling plants in the field why are we advised to wear goggles ?', 4, 'c2a7860c8ff146dd940bf4ef8216a70f', '071b225f158b4a55a286539d3625be93'),
('0bff63aadc1a44f09e5a7b67bd513559', '', 'Find the area of a triangle with the measurements :height-36 cm width:8 cm', 3, '2b15214ec85e4e9287e51f578673e2d7', '059c4ba191e84558a48ae44acb8718d4'),
('0c72df0f1be74b8d9cc7b6cb47a4bdf2', '', 'Which of the following contains non-flowering plants only ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('0db877c3e6f74f13b2f81f9db5770de7', '', 'Which of the following is a characteristic of invertebrates.', 6, '316e18fe6d37444fb90f8ed46054aa89', '65433d5a2ff546e08ce9f432e4183a06'),
('0e418ee92fe54ccb814840d4361ae703', '', 'Which of the following are all male parts of a flower ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('0e42455ff2264b038419f2b1a3c342b4', '', 'Work out 7 380 ÷ 205.', 3, '9ab8bd138f6b4bc199f018565e2eae9a', '182efc31982d4c56b6a70ff43b34788a'),
('0e945d25067f4c24adcb3136f5d7264c', '', 'How does the heat from the sun reach us ?', 5, '628af366d92f4eadacda0db6b1d941c0', '787d880d5d4647f0a05d59303f870576'),
('0f97ae1ee4ab4905bbc0eae7729118b5', '', 'simplify 12x - 8x', 2, 'c5b5f471b6cc46a09da0db7f3e2c0295', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('0f9c50b6ed104c1187d370d63e580836', '', 'Which of the following best describes the work of filament in a flower ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('1128b464e295438fb4adbbf6a1712c90', '', 'Which of the following is a purpose of lungs ?', 5, 'a2bd35cbc4f54f73b29bf75db6cc2454', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('11820b7260c4407fa61401085331c89a', '', 'Work out 283.3749 + 788.9363 and round off the sum to 3 decimal places.', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('119f393bc8fc4540be145b2db3fa1732', '', 'What is the place value of five in 607.05 ?', 1, '805e316d0f6643b9a65c110511c1a8ab', 'b2a64da77fac499194c1d0bb4a416a34'),
('13ab781fe4b34eadbbdfb7a14688802a', '', 'Which of the following is a function of stems in plants ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('143eeefe5d7a404c933d18651cd484f3', '', 'Which of the following best describes a solar eclipse ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('151da5fee22247e4836cb1b9ee7cb922', '', 'A cube has a side measuring 12 cm. Find the volume of the cube.', 2, 'abd163cdcdfe4c06ab86e3aa36bd1120', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('15a26398b7fd49339afba8043556b62e', '', 'A teacher had 6 kg of sugar. He then packed them into half kilograms packets. How many packets were there ?', 1, 'c2412dff641348919c3d21c745f3debb', 'deea8f67f1fe4a3b88d22f92378804b8'),
('175ede72582a4438a85ba2d05769b20f', '', 'Which of the following is not a change of state when substances are cooled ?', 6, '53b9fc62af274e08a93a6d42675ca86a', '73bdba1305834e6aaee45bf39e4f4dbd'),
('1779d56524a24535bfdecca2b38ff637', '', 'What is the product between 12 and 10 ?', 1, '95701a724ebf41b685f8fa1aa1c5ccbd', 'b2a64da77fac499194c1d0bb4a416a34'),
('192f0e65d1ca4ddb8fdd42e3a87347ec', '', 'Which of the following best describes how ound moves ?', 5, 'd5e7172c9b3f4c28a35087690e423e64', '787d880d5d4647f0a05d59303f870576'),
('19628957bc5546be83e0e7b5170d89ef', '', 'During a birthday party 169 litres of juice was distributed among 13 boys. How many litres did each recive ?', 2, 'e0f60556e1e946f48f877692e7bb08e3', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('19a4ca73f92c450d99d9904ff3d87c76', '', 'The length of a footbal field measure 42 m and a width of 64 m. Find the area of the field.', 3, '2b15214ec85e4e9287e51f578673e2d7', '059c4ba191e84558a48ae44acb8718d4'),
('1a4f53a7316640fea92d84da11f84ff2', '', 'What digit is in the ten thousandths place value in the number 2 379.6458 ?', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('1ab0c85dd49e42098992a70aa13359f3', '', 'Which of the following is a use of argon gases ?', 6, '91d7938b6159462ab0d24df5172f4c69', '73bdba1305834e6aaee45bf39e4f4dbd'),
('1af9dadec92b409ea98f236154599c14', '', 'Convert 12 km 750 m to meters.', 2, '5619dcccad384f419efa3f4f5aec3554', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('1d5ec5456ab1431a9620daae5501ef00', '', 'Which of the following pairs is a unit measurement of mass ?', 2, '838d3d153eff44d1bbfc1a66ab113a2c', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('1d65bd4d6cf546f093582d55c334e018', '', 'Which of the following is not an effect of air pollution ?', 6, '91d7938b6159462ab0d24df5172f4c69', '73bdba1305834e6aaee45bf39e4f4dbd'),
('1dcfccba03244784a83b0b92e361ffd9', '', 'Solve for x in the equation 67x - 33x = 17', 2, 'c5b5f471b6cc46a09da0db7f3e2c0295', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('1dd1b0e4910643e4a052a5b7b400bd7e', '', 'A charity group had a debt of three hundred and twenty eight thousand five hundred and four shillings. They received eight hundred and eight thousand in contributions from well wishers. After clearing their debt how much money were they left with ?', 2, '4368e90cf2054a5fa775133531a7fc48', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('1e5b987848344faf804289cd1d520471', '', 'How many minutes are there in 3 hours 57 minutes ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('1f45262543f14871a9b8fc627f924b92', '', 'A student poured 3 packets of milk each containing 1/4 litres into a debe. How many litres does the student need to make the milk in the debe to be 3 and half litres ?', 1, '2ceb6de23db34727980321e12b09b531', 'deea8f67f1fe4a3b88d22f92378804b8'),
('208b3186bddc42ac80eefa67cc5a1483', '', 'Which of the following is the correct meaning of invertebrate ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('21f56fc4bd8241a18ee885f667fe132e', '', 'Work out 132 sh 60 ct by 17', 2, '932b0433136f403bbff727464323a532', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('222d1def85b24ff6b537b87cd9b7fd7a', '', 'Which of the following pairs is the correct measure of capacity?', 2, 'e0f60556e1e946f48f877692e7bb08e3', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('22ae3b1f6c3c457a9733c99f227e3ab4', '', 'Which of the following pairs contains flowering plants only ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('22c76b4b3aed46e8b969c3d37f4a898b', '', 'Which of the following below is a state of matter ?', 4, '3084527d7dce47b796358723d23baea1', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('23fc3fd62641425fbee1ae8db0556714', '', 'What is the meaning of an opaque object ?', 4, '513378363dfa445599c70db8106ac283', '80d0719f51804c33b3f12343482671fa'),
('25a89a2162c241deafa99ba8cecfb2dd', '', 'Which of the following is not a mode of heat transfer ?', 5, '628af366d92f4eadacda0db6b1d941c0', '787d880d5d4647f0a05d59303f870576'),
('26475a9fcd58472e85d833b3897dc978', '', 'Write 6/10 as decimals.', 1, '805e316d0f6643b9a65c110511c1a8ab', 'b2a64da77fac499194c1d0bb4a416a34'),
('2733882310bd433c8353e64f87091ce2', '', 'Which of the following is not a function of plasma ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('28b3b3cb8f934420a0de4b95d96cbb30', '', 'Which of the following is an application of sinkers ?', 5, 'c9f95b5e2ee945de94801340dd76d492', '787d880d5d4647f0a05d59303f870576'),
('2949177d863a490bbb94b47538817048', '', 'Convert 7 shillings to cents.', 1, 'db4f2f4ff4724a35b4ad708cb73b4b8f', 'deea8f67f1fe4a3b88d22f92378804b8'),
('298a980824cc4dee8271468f038f3e67', '', 'Which of the following is a good conductor of heat ?', 4, '29867d10f65a4ac4bb2d352633896b79', '80d0719f51804c33b3f12343482671fa'),
('2994eee0b78e49f8b53a857c9182332c', '', 'Which of the following is an application of poor conductors of heat ?', 5, '628af366d92f4eadacda0db6b1d941c0', '787d880d5d4647f0a05d59303f870576'),
('2a95c1cdff4b4ae6a3208b0d2cf2df60', '', 'Complete the pattern below.\r\n  247,  310, 373, ...............?', 1, 'cc35570a8c3c45b68c464800ce2aecf2', 'b2a64da77fac499194c1d0bb4a416a34'),
('2aa9f0c457134b6fad2cc761fe40757b', '', 'Convert 36 cm to millimetre.', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('2bb050dadae84953b3f093f01b19184b', '', 'Which of the pair of protective gears below are used when handling gases ?', 4, '3084527d7dce47b796358723d23baea1', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('2c879405512e49cc847ac1d75fb72ccb', '', 'Which of the folllowing is not an example of a reptile ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('2ca0d2dd52b74bce9e40d856670baa43', '', 'A race started at 11:49 am. The race lasted for 1036 seconds. At what time did the race end ?', 2, '73c128a230154d649a95c2f395a489bb', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('2d300d1904cf44bea4aceb1733a98360', '', 'How does light travel ?', 4, '513378363dfa445599c70db8106ac283', '80d0719f51804c33b3f12343482671fa'),
('2d693ff4f1d1487786f7197ab46bf9d8', '', 'A teacher had thre hundred five hundred and eighteen sweets. She later distributed them among 14 students. How many sweets did each student receive ?', 2, '7af9fbdfee3e463280e6d87bf3e7eb3b', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('2dffc82a38cf4a89879c98c62bbc0486', '', 'What is the meaning of an even number ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('2e6a890e2c8343e79a63a3d09ffdda04', '', 'Subtract 346 789 from 516 224.', 2, '4368e90cf2054a5fa775133531a7fc48', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('3016c264f4d84d53a35e2533b2004ce5', '', 'Complete the pattern below.  417 100, 446 672,  476 244 ................?', 2, 'a4026bd3d09044ada767c4698b6edb06', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('30b93ea91e3146bdbbdcc5395010f73c', '', 'What is the value of the number represented by the roman value VII.', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('31ba1a2cab414fa5adffbdf12c35c687', '', 'In a science lab there are four hundred and twenty four frogs. Each frog produces twenty six tadpoles in every 6 months. How many tadpoles will there be in 1 year ?', 3, '88dc82886e05430d9d9e8f336e459739', '182efc31982d4c56b6a70ff43b34788a'),
('32281ff8bce9450fac82f87e7c551ece', '', 'Which of the following is true about fibrous roots ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('32b31b7eaaa94be398d3e3b673edb2ce', '', 'Work out 637.363 + 88.749', 1, '805e316d0f6643b9a65c110511c1a8ab', 'b2a64da77fac499194c1d0bb4a416a34'),
('3386b4431c53418dbe7dd1ac98eff2c6', '', 'Find the circumference of a circle with a diameter of 21.', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('33957668a75f46b59458462ddcc59dea', '', 'A rectangular object measured 15 cm by 22 cm. What is the area of the object ?', 2, '40f37d4d1db54c0d80bbdfcbbe95309d', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('3406e79a65844fcea9c41eadfa8e6663', '', 'Convert the following fractions to percentages. 3/4 and 5/10.', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('345721e95ce448fdb1aaa9f9e9d4d3f4', '', 'What are reflex angles ?', 1, 'd8846feb519f4aebb4474ea8ca50d61a', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('34c6a17805a34102926d54fd5dc7f3bf', '', 'Convert 1679/10 000 to a decimal and round off to 3 decimal places.', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('34e456e84c544cf684b654d50d3a2669', '', 'What is the correct definition of the term force ?', 4, 'd147db3c91614f56a472cb8d73f5559d', '80d0719f51804c33b3f12343482671fa'),
('3653712b762a4aa487a68460cea7e557', '', 'What is the sum of 2 766 and 2 527 ?', 1, 'cc35570a8c3c45b68c464800ce2aecf2', 'b2a64da77fac499194c1d0bb4a416a34'),
('366f66b75f064b37b4077b96107b412a', '', 'The length of a water pipe in a fire station is  10 m 35 cm. What is the length of the pipe in centimeters ?', 1, '7e82335799a14158a19e53ef835ae3a2', 'deea8f67f1fe4a3b88d22f92378804b8'),
('368366c2155341eeada5799c4773deba', '', 'A car weighs 233 kg 400 g. During a race the car lost one of its four tyres. What is the mass of the car now if the total mass of all tyres all-together weigh 20 kg ?', 2, '838d3d153eff44d1bbfc1a66ab113a2c', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('36c8ed1a8dd84b909ad915826c61df76', '', 'Which of the following is the correct use of floaters ?', 4, '440d08aeb1594ce780f82e895fb91391', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('3713827d6b794881a31c0c593cf9eb24', '', 'The distance from otienos home to the market is 3km 622 m. What was the total distance travelled to and from if atieno travelled to and from the market for two trips ?', 2, '5619dcccad384f419efa3f4f5aec3554', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('37cb6337e2164278940eacaba661e48d', '', 'Complete the pattern below. 6, 30, 150 ......,  ....... ?', 3, '88dc82886e05430d9d9e8f336e459739', '182efc31982d4c56b6a70ff43b34788a'),
('37dc94bf57614fd593a10284dd27d641', '', 'A race started at 11:47 and ended at 12:36. How long did the racing event take place ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('3a27382f9c4940b588449e30fcbd2897', '', 'Round off 266 to the nearest 10.', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('3a52bc7ad0e342af9d59ee83ee694010', '', 'A sudent had one hundred and five shillings and twenty seven cents. She later bought a doll for twenty six shillings and fifty nine cents. How much many was she left with ?', 1, 'db4f2f4ff4724a35b4ad708cb73b4b8f', 'deea8f67f1fe4a3b88d22f92378804b8'),
('3a90baa35627433388ec9a9bfb6b9097', '', 'What is the sum of 238.443 and 12.999 ?', 2, '71ad059d99ef476a8ec249ca9161fb88', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('3adf418f999440048d36f2990161ea8b', '', 'Convert 0.064 to a proper fraction.', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('3b10a10c569c478ca6fbb9a6661080b1', '', 'Which of the following is not an air pollutant ?', 4, 'e018fa86c90144c5b2b1ba8e8902cab2', '870d063230e54ab6bc6aaf166ca586b5'),
('3c232aa573164a408611828e66f033d8', '', 'Subtract five hundred and nine from eight hundred and seven', 1, 'a888ee5f6df74c52a0d70b6bcb606bb0', 'b2a64da77fac499194c1d0bb4a416a34'),
('3cef548d8fbe4dad97e32685502bb65b', '', 'Which of the following objects will not sink in water ?', 4, '440d08aeb1594ce780f82e895fb91391', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('3d8eafeb480c4050b980c7772d0b9653', '', 'Which of the following is not part of a lever ?', 6, 'bf4099a7123a4f448b9f971e8dcb5373', '5fce52cdc4744270b20972d3dc4fa0f1'),
('3dad72b6543c4690a72bdb4302b61ade', '', 'Which of the following is false about birds ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('3f03654d0cfa4e9b895cb0f09cf9222e', '', 'During a class practical activity, a student measured the length of one side of a square surface and it measured 16 cm. Find the area of the surface.', 3, '2b15214ec85e4e9287e51f578673e2d7', '059c4ba191e84558a48ae44acb8718d4'),
('3f04c183921f4c709f48a68164a32532', '', 'Which process takes place when water vapour directly turns to liquid when it comes with a cold surface ?', 6, '53b9fc62af274e08a93a6d42675ca86a', '73bdba1305834e6aaee45bf39e4f4dbd'),
('3f6d18d432414b9b83dc5bdb895e5312', '', 'How many shillings are in 10 000 cents ?', 1, 'db4f2f4ff4724a35b4ad708cb73b4b8f', 'deea8f67f1fe4a3b88d22f92378804b8'),
('3fdc62cbde0e45bdb94722095c9d2b55', '', 'Work out 17/100 as decimal.', 1, '805e316d0f6643b9a65c110511c1a8ab', 'b2a64da77fac499194c1d0bb4a416a34'),
('4173738447534872968b5de85b4bf013', '', 'Work out √256 and √625 respectively ?', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('439d91f58e284a9ab2413e062664fa52', '', 'What is the value of the roman symbol  IX ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('4488a126eff843bd9c068096641c7d9c', '', 'Below is a list of examples on how we pollute our environment. Which correctly describes air pollution ?', 4, 'e018fa86c90144c5b2b1ba8e8902cab2', '870d063230e54ab6bc6aaf166ca586b5'),
('44c204a96514485f895de122a73a56d6', '', 'What does the term vertebrate mean ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('45918614a52143fcb4bb991ce7c9c377', '', 'Which of the following is a purpose of tranchea ?', 5, 'a2bd35cbc4f54f73b29bf75db6cc2454', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('46389c3b80ab465eb27855073b37bce1', '', 'Which of the following are not invertebrates ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('467ca0bb399a4e7e8bdb69954562188f', '', 'Write the following percentages as fractions in their simplest forms. 25% and 37%.', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('46975a7fb082430a91c4e5ae1399a32e', '', 'How many litres are there in 17 262 millilitres of water ?', 2, 'e0f60556e1e946f48f877692e7bb08e3', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('46f12200132f43718a18b185c561fd4b', '', 'Between an adult and a baby which hearts beats faster ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('47170450874f427da1a36c4e06123bd8', '', 'Which of the following is a form of water pollution', 4, '4b139d9ff4144c6a872ee65057c5fcbc', '870d063230e54ab6bc6aaf166ca586b5'),
('474650dc884d431cbb3225ebd18348fa', '', 'convert 218 minutes into hours ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('488f9e9463d74e64ba6d50a1034618d5', '', 'Which of the following best describes air pollution ?', 4, 'e018fa86c90144c5b2b1ba8e8902cab2', '870d063230e54ab6bc6aaf166ca586b5'),
('4bd617934e374ce8bf4458299fb0c639', '', 'A businessman bought a gas cylinder for three thousand five hundred. He later sold it fo four thousand two  hundred. How much profit did he make ?', 3, '7dfac60fffb44980b25c5ac1fe63f0cc', '059c4ba191e84558a48ae44acb8718d4'),
('4c2d1e6d07d54cb2af3fad1a29fe8d0e', '', 'The distance from the house to the shop is 2km 357 m. The distance from shop to the stadium in 7 km 709 m. What is the distance travelled by kamau from his home to the stadium via the shop ?', 2, '5619dcccad384f419efa3f4f5aec3554', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('4c92863673a940f3bf2fd8d5949b1f3d', '', 'Divide 56 by 6.', 1, '48a82f0c48ff4eb2b91d293858558644', 'b2a64da77fac499194c1d0bb4a416a34'),
('4e2c65b6164848b58a72171ddaea5063', '', 'Which of the following is true about winnowing ?', 5, '7071e61cada845d1848c5f5866cc61ec', '481defbe30ca4f1d9c3bc519ee6db70c'),
('4e357098bb9e4112921bfc6a0706e59d', '', 'Convert 1 000 000 cubic centimetre to cubic metre.', 3, '77544763fbb848e4b535dc2c40d826e7', '059c4ba191e84558a48ae44acb8718d4'),
('4e5361a539444bdfbb702b5d18ea408c', '', 'Convert quarter hours past midnight to 24 hrs system.', 3, 'a43c39977d044a1a92a2a6a8b11bd644', '059c4ba191e84558a48ae44acb8718d4'),
('4ef011d4580d4fb18432480018300853', '', 'Which of the following is false about plants ?', 4, 'c2a7860c8ff146dd940bf4ef8216a70f', '071b225f158b4a55a286539d3625be93'),
('4f48ed6576964f0595db33cb525a26cf', '', 'Which months have 31 days in the calendar ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('517719cf777b47018fa67f33f3e37b40', '', 'Which of the following objects will float on water ?', 5, 'c9f95b5e2ee945de94801340dd76d492', '787d880d5d4647f0a05d59303f870576'),
('52224bf8d56f4efaa5b91a7ddf8096c4', '', 'What is the sole purpose of platelets ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('5269b37638d1423aa0c64d10becb44e0', '', 'A field track was 3650 meters in length. Convert the size of the field in kilometers.', 2, '5619dcccad384f419efa3f4f5aec3554', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('531423fd6cc34d5ea84d8e62f3155c98', '', 'How many cents are in 1 shilling ?', 1, 'db4f2f4ff4724a35b4ad708cb73b4b8f', 'deea8f67f1fe4a3b88d22f92378804b8'),
('5342b95185ec4218a02a3b4630d635d8', '', 'How many a quarter kilograms are found in 4000 grams of sugar ?', 2, '838d3d153eff44d1bbfc1a66ab113a2c', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('538dae8b99684f9f88b652ddbcd195eb', '', 'Which of the following is not a change of state when objects are heated ?', 6, '53b9fc62af274e08a93a6d42675ca86a', '73bdba1305834e6aaee45bf39e4f4dbd'),
('554a3ddba6bf44f5b337f7dfd769804f', '', 'Which of the following pumps blood to the human lungs ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('5599cffa3eb14451ad1f6f508a6a5b77', '', 'Which of the following pairs contains only types of fungi ?', 6, 'e3e68fa2d99b4aff862fd94bf6f3dd39', '65433d5a2ff546e08ce9f432e4183a06'),
('560bb0a11aa743629884aea031125701', '', 'Which of the following is the correct formulae for finding the volume of cuboids ?', 2, 'abd163cdcdfe4c06ab86e3aa36bd1120', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('562eceb3ad1a4416923681a0ea8c4212', '', 'How many days are in the month of January ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('571b66ca48244b93b7e8fbfe9dba045f', '', 'When animals give life to young ones we say that they ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('5858d67de26840658b1a4a688f7c79b1', '', 'Which of the following are not examples of fish ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('58c858b0d5f742938d5dd2b027d91f6a', '', 'Which of the following contains only good conductors of heat ?', 5, '628af366d92f4eadacda0db6b1d941c0', '787d880d5d4647f0a05d59303f870576'),
('59119f894c4b45178af6ce0d1606c31b', '', 'Which of the following best describes characteristics of animals as living things ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('5973546bc4334ae8a5b347dacfd19527', '', 'Time during the night hours is measured in ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('5ae1fcbb40aa44c18f688417fbc14199', '', 'Explain the term refraction ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('5c092f3a3c954c5d808a2fe834fc1d48', '', 'Which of the following takes the highest percentage in the blood plasma ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('5c84167c0e274703b5c491c8fb218aa0', '', 'What is the importance of blood vessels ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('5d772de1b1d74daca61e3835ccae12e8', '', 'What is the purpose of the liver in human digestive system ?', 4, '68cebfc7bb1b4512afaf5a7fd7e99c1d', '071b225f158b4a55a286539d3625be93'),
('5e4cd1ba51634cca807c44883b43b694', '', 'What is the total value of the digit six in sixty seven thousand three hundred and fourty two ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('5e73774cffbf4b78a67a56aa8e001532', '', 'Which of the following is false about amphibians ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('5f14e2c389c44203b252bc92811df7c5', '', 'Students during a trip observed beautiful clouds that looked like feathers. Which clouds did the sudents likely see ?', 4, '0e05d89766034bd0a999959f925451de', '391c05683bdc4508abe79ff3c0babb94'),
('5fbe37ddf05e47dea877754e189edfd2', '', 'How many half litres are contained in a 5 litre debe ?', 1, '2ceb6de23db34727980321e12b09b531', 'deea8f67f1fe4a3b88d22f92378804b8'),
('60a1590834ee4841b6fec6ba384b43a5', '', 'Which choice contains animals classified as vertebrates ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('60d7d97791ef40fbafba174c32085863', '', 'Order the following numbers in ascending order ?\r\n    1. one thousand and eight ,\r\n    2. one thousand eight hundred ,\r\n    3. one thousand and eighty .\r\n', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('62fbd25232f04e7e8c24fabcaaa20c64', '', 'Complete the following pattern.  \r\n 292, 235, 178, ............ ?\r\n', 1, 'a888ee5f6df74c52a0d70b6bcb606bb0', 'b2a64da77fac499194c1d0bb4a416a34'),
('6348a869fea9417498f537606284e0d1', '', 'Which of the following contains correct classification of levers ?', 6, 'bf4099a7123a4f448b9f971e8dcb5373', '5fce52cdc4744270b20972d3dc4fa0f1'),
('637caacf57be4fc985082f8b2bfa2265', '', 'Which of the following is the least angle ?', 1, 'd8846feb519f4aebb4474ea8ca50d61a', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('642da40ee05b4515ae2f40fb09bf1692', '', 'Work out 12².', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('644f23dc39e34eb7b27233711a0258af', '', 'What is the purpose of the left ventricle in the human circulatory system ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('6493c957b09941f498442def6f3b071b', '', 'Convert 677 cents to shillings.', 1, 'db4f2f4ff4724a35b4ad708cb73b4b8f', 'deea8f67f1fe4a3b88d22f92378804b8'),
('65944ca657ce469aab984ece26a2b619', '', 'A cuboid has a volume of 864 cubic centimetres. The base area is 72 centimetres square. Find the height of the cuboid.', 3, '77544763fbb848e4b535dc2c40d826e7', '059c4ba191e84558a48ae44acb8718d4'),
('669bef6a32354ff4817b0dbbe8bfadab', '', 'Blood flows from the heart to all parts of the body via ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('66a4a2ae907940449cf9f943ecb22e88', '', 'Which of the following is true about vertebrates ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('68a6b59b2ce04b648fe38b24daebcb8e', '', 'A tank has a height of 20 cm a length of 12 cm and a base area of 120 centimetre square. Find the breadth of the tank.', 3, '77544763fbb848e4b535dc2c40d826e7', '059c4ba191e84558a48ae44acb8718d4'),
('68b63c28f77a4d7da710bc0335a9d653', '', '1 kilometer is equivalent to how many meters ?', 2, '5619dcccad384f419efa3f4f5aec3554', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('68fa3c5656864f6981f6f52cd6ac13cb', '', 'Which of the following is false about air ?', 6, '91d7938b6159462ab0d24df5172f4c69', '73bdba1305834e6aaee45bf39e4f4dbd'),
('691e382e04cd4feea3f3cfb2946c2b86', '', 'Name the 2 upper chambers of the human heart.', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('697575f9a2174ef091c6fc72916fe46a', '', 'Write the following numbers in words respectively.\r\n10 307 and 43 710', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('69d04d1c4eae422caca47a42ff50fe7c', '', 'Convert 13 shillings and 10 cents to cents.', 2, '932b0433136f403bbff727464323a532', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('6a591ef4c2854d3c8fedc9face95302f', '', 'How many 1/4 litres are contained in 1 1/2 litres ?', 1, '2ceb6de23db34727980321e12b09b531', 'deea8f67f1fe4a3b88d22f92378804b8'),
('6a9c340f3d674830909a2f2286aedc43', '', 'Which of the following months contain 30 days in the calendar ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('6bde147aae6d45a1b8bfe03a947ef91e', '', 'Blood from all parts of the body comes to the ________ chamber through the ___________ ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('6cb8c3104d394a5584c6a39b47e56948', '', 'Which of the following numbers are divisible by five ?\r\n3 005, 6 751, 2 010, 6 754', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('6eff4299369a4932ac95906cba951fd5', '', 'A school planned a trip that would last for  four weeks. How many days should students be prepared for?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('6f02ac3324d34590996f0dd898ab3527', '', 'The volume of a cube was found to be 169 cubic centimeters. Find the size of its sides.', 2, 'abd163cdcdfe4c06ab86e3aa36bd1120', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('6f80c107d5684250bb74815dcdc2b733', '', 'What is the work of arteries in the human circulatory system ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('6fb35040969b4333a71606c6af651213', '', 'Which of the following are the smallest blood vessels ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('6feea713e84945a0b77485d6479416e1', '', 'A farmer had 10kgs of feathers and 10kgs of fertilizer. Which one was heavier ?', 1, 'c2412dff641348919c3d21c745f3debb', 'deea8f67f1fe4a3b88d22f92378804b8'),
('7009229737e34d6e8ef306ac6d94bf85', '', 'What does the term convection mean ?', 5, '628af366d92f4eadacda0db6b1d941c0', '787d880d5d4647f0a05d59303f870576'),
('72795f163f1145fd8fc4b4d8a6164930', '', 'Which of the following pairs contains way of separating heterogenous mixtures ?', 5, '7071e61cada845d1848c5f5866cc61ec', '481defbe30ca4f1d9c3bc519ee6db70c'),
('72da7c47ae5c4df89da5e27a83945617', '', 'Which of the following is a poor conductor of heat ?', 4, '29867d10f65a4ac4bb2d352633896b79', '80d0719f51804c33b3f12343482671fa'),
('7337784229b647b987ab529327546eb4', '', 'Work out 3(6n - 4).', 3, '35cddc300c864b41a7de64094aa1e919', '182efc31982d4c56b6a70ff43b34788a'),
('73403ce5fdbb40efb88c7c20c3a0dded', '', 'Which of the following is not a solid ?', 4, '3084527d7dce47b796358723d23baea1', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('75450175bb4a42d0924a8b93902b8686', '', 'What is the purpose of the ovary ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('754bff2331fc41a797b8353ad37f092c', '', 'Round off 4 194 to the nearest 10.', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('755cb7670d974b9b910e160f2c0c56bc', '', 'Which of the following best describes flowering plants while giving the correct example ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('7646acc52a1e4007a132ef4a4ad75824', '', 'Which of the following is true about sound ?', 4, 'bbe912323079473bb7c1b533e8366051', '80d0719f51804c33b3f12343482671fa'),
('768e1342bad54d90a7001a3311f121e0', '', 'Which number is in the tenth place value in the number 134.09', 1, '805e316d0f6643b9a65c110511c1a8ab', 'b2a64da77fac499194c1d0bb4a416a34'),
('7703d7f913564fdca869961d3d5959af', '', 'Which of the following is not a way of polluting water ?', 5, '6383a55dc9854486a0725d9bb4fb9ecd', '481defbe30ca4f1d9c3bc519ee6db70c'),
('770798a97a3c4052b4f2702a7f3aa2ed', '', 'Round of 1 010 to the nearest tens ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('780e587fdc6840e1ba60865d551d5531', '', 'Which of the following is not a part of the breathing system ?', 5, 'a2bd35cbc4f54f73b29bf75db6cc2454', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('786a1c5cc3b6462e8e5d61a6e052d800', '', 'What is the mass of a chair in kilograms if it weighs 13 656 g ?', 2, '838d3d153eff44d1bbfc1a66ab113a2c', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('791cc430a8af4d41b20f86e3267a2f78', '', 'Complete the following pattern. 7, 21, 63 ........... ?', 2, '19070e4e65c6401b8a4d41111f626815', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('79866fc6ca374c1b98cbf39c770e53fa', '', 'Convert 660 seconds to minutes.', 3, 'a43c39977d044a1a92a2a6a8b11bd644', '059c4ba191e84558a48ae44acb8718d4'),
('79e984b646ed4a32909a513ddbc3a505', '', 'Which of the following is false about flowers ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('7ad8837394eb4fb2bf8bc5e3ab205d1f', '', 'Which of the following shapes has all sides equal ?', 1, '8b43888e14fa45408b5d77de51d10302', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('7c7ec322969d42bd83562df89c373f7d', '', 'A number is divisible by five if ?', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('7cb93156965348ea83ee006c454b4d6a', '', 'What is the place value of the digit 1 and 6 in 6 517 558 respectively ?', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('80958ab35c2e4e50882e96385edaccc8', '', 'What is the use of tongs while handling animals ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('809af93a20724e37b2aec6dae1f3aa48', '', 'Write seven hundred fifteen thousand one hundred one in figures ?', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('81b5afc7301048b595bdd87718926c43', '', 'A company had three hundred and ninety seven thousand  four hundred and ninety six packets of candy in their stores. They later produced five hundred and thirty six thousand nine hundred and ninety six more. How many packets does the company have in total ?', 2, 'a4026bd3d09044ada767c4698b6edb06', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('820d96ac346f4641ad794dc3e7612707', '', 'Define the term water pollution.', 4, '4b139d9ff4144c6a872ee65057c5fcbc', '870d063230e54ab6bc6aaf166ca586b5'),
('82c4734eea7b4b1e89100dd7d1f281be', '', 'While pushing a washing machine up to the fifth floor which of the following slopes is the best option ?', 6, '603aa4e0ec73436e99159ac1beecf6ea', '5fce52cdc4744270b20972d3dc4fa0f1'),
('8330b2648f514ebc8dc977023e38f91e', '', 'Convert 28 days to weeks.', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('83c2791b100a4350ab937ee1f0c7e12d', '', 'Which of the following contains even numbers only ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('8487b759af534c6799e1722e30214df4', '', 'What is the purpose of the diaphragm ?', 5, 'a2bd35cbc4f54f73b29bf75db6cc2454', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('84dbb9a84d7d4657aad03e8eacb4df12', '', 'Order the following angles from the smallest to the largest?', 1, 'd8846feb519f4aebb4474ea8ca50d61a', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('85502e2321c042f8bd78e03fd8cc0920', '', 'What is the total value of 7 in sixty seven million five hundred and thirteen thousand one hundred and nine ?', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('85810a6b060247cca390fce72f8e5a8f', '', 'In kamaus savings piggy bank there are 4 a thousand notes 6 500 sh notes 3 200 shilling notes 7 100 shilling notes and 9 50 shilling notes. How much money has kamau saved ?', 2, '932b0433136f403bbff727464323a532', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('85cc9a47f6264c05b92ed761df95e861', '', 'Which of the following is not a blood component ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('87da34be53f8416085d17bab89e7be3e', '', 'Write 567 789 in words.', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('87f095bdfe694724b64a57892d960ae6', '', 'Which of the following is false about force', 4, 'd147db3c91614f56a472cb8d73f5559d', '80d0719f51804c33b3f12343482671fa'),
('8812b50fd83b4bac8fa63e4b7f495c4a', '', 'After handling animals we are required to ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('8947722779ec4754a2264fc2a35f0b74', '', 'What is the place value of 0 in the number 232.5402 ?', 2, '71ad059d99ef476a8ec249ca9161fb88', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('8a41569231db4bfbb83a32c0a1b59e79', '', 'Simplify 12a + 6d - 6a -6d + d', 2, 'c5b5f471b6cc46a09da0db7f3e2c0295', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('8ace7601bede4491b5f074b3b3240d44', '', 'A parent bought four packets of milk for 350 sh each. She later sold all of them for 1000 ksh. How much profit/loss did she make ?', 3, '7dfac60fffb44980b25c5ac1fe63f0cc', '059c4ba191e84558a48ae44acb8718d4'),
('8bb162139d8f4c0683ebea28207644a3', '', 'A parent has seven children. He gave each child 88 shillings for good behavior. How much money was given out ?', 1, '95701a724ebf41b685f8fa1aa1c5ccbd', 'b2a64da77fac499194c1d0bb4a416a34'),
('8be4212e46384c7c9f635346b4d38e91', '', 'A teacher had 3 and a quarter kilograms of mandazis. He bought six and a half more from the school annex. How many kilograms of mandazis does the teacher have ?', 1, 'c2412dff641348919c3d21c745f3debb', 'deea8f67f1fe4a3b88d22f92378804b8'),
('8cc305c0038244418d3bb73ced14e7aa', '', 'What is the sum of 587 and 329?', 1, 'cc35570a8c3c45b68c464800ce2aecf2', 'b2a64da77fac499194c1d0bb4a416a34'),
('8cd062300f854e3fab7bd3eaf407e18b', '', 'Select the pairs that represent female parts of a flower.', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('8e50fc4d5da14a4385fcaa58d3da428f', '', 'Which of the following is not a property of a triangle ?', 1, '8b43888e14fa45408b5d77de51d10302', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('8e77e3b475ec4d2ca2bdca12d1c0fce1', '', 'How many days are in february in a non-leap year ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('8f9e5d1826cd4967b3689f36ad98e014', '', 'Which of the following is not a function of invertebrates ?', 6, '316e18fe6d37444fb90f8ed46054aa89', '65433d5a2ff546e08ce9f432e4183a06'),
('8faff50822134b69838209f09b820e26', '', 'Solve for x. x - 4 = 18', 2, 'c5b5f471b6cc46a09da0db7f3e2c0295', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('9123effb96d444f6a6f4793781a1d20b', '', 'Which of the following is not a way of preventing water pollution ?', 5, '6383a55dc9854486a0725d9bb4fb9ecd', '481defbe30ca4f1d9c3bc519ee6db70c'),
('919855e6a33e4ed18287ce434173649b', '', 'Which of the following numbers are divisible by 2 ?', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('91d6f0b0f4c54297b90da37fe1687d8b', '', 'A company had three thousand and three trees. They sold six hundred and seven trees to a farmer. How many trees was the company left with ?', 1, 'a888ee5f6df74c52a0d70b6bcb606bb0', 'b2a64da77fac499194c1d0bb4a416a34'),
('926e3ec885e3420eaece115fa94929fe', '', 'A teacher had seven hundred and ninety six pencils. He receive two thousand six hundred and ninety two more from the school administration. He then shared them equally among two hundred and eighteen students. How many pencils did each student get ?', 3, '9ab8bd138f6b4bc199f018565e2eae9a', '182efc31982d4c56b6a70ff43b34788a'),
('933716cd8fa44920811ff616ba68be37', '', 'In a school of three hundred and eight students books were donated where each student received 14 books each. How many books were delivered in total ?', 2, '19070e4e65c6401b8a4d41111f626815', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('9632c14549a04b6a89c71ed25c15dabb', '', 'Which of the following numbers are divisible by both 5 and 10 ?', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('9658f1714cf744d0a0e7dac5c7358db4', '', 'Which of the following is not a factor that affects floating and sinking ?', 5, 'c9f95b5e2ee945de94801340dd76d492', '787d880d5d4647f0a05d59303f870576'),
('966793791c78437495b87109c1d780fb', '', 'The circumference of a circle was found to be 44. Find the diameter of the circle.', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('98e24a665bf3455a9b267e41ecc64b11', '', 'In a village marriage celebrations lasts for 3 straight days. How many hours does the celebrations last ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('994258f0adb149fda94a3703ee852bd7', '', 'Calculate the total of 456 and 278.', 1, 'cc35570a8c3c45b68c464800ce2aecf2', 'b2a64da77fac499194c1d0bb4a416a34'),
('999f823f3f8040c4a6c3a52484201cde', '', 'Which part of breathing system is known as wind pipe ?', 5, 'a2bd35cbc4f54f73b29bf75db6cc2454', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('99d73d7b89d74ae18d7b848cce65aa00', '', 'A clock moves in what direction ?', 1, '7fcf2bef4c094335a39661082a46589d', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('9ab68f6eb4fa4f0fb5d5e6a227fba31d', '', 'During a field study a teacher asked students to wear protective garments to protect their hands and noses from certain plants. Which best describes the garments the students wore respectively ?', 4, 'c2a7860c8ff146dd940bf4ef8216a70f', '071b225f158b4a55a286539d3625be93'),
('9b0f474fc1904f86b1e72f9affce0834', '', 'Add.\r\n 4567\r\n+ 7890\r\n__________', 1, 'cc35570a8c3c45b68c464800ce2aecf2', 'b2a64da77fac499194c1d0bb4a416a34'),
('9bacbe07c976454aae7560ba58f7f847', '', 'How many days are there in 3 weeks ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('9c215a0901794c18a8bc98fc88fbe87c', '', 'Which of the following is not an example of air pollution ?', 4, 'e018fa86c90144c5b2b1ba8e8902cab2', '870d063230e54ab6bc6aaf166ca586b5'),
('9cff816c9ece4871849b01ebb0e8e874', '', 'Convert 12/25 to a decimal.', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('9d2d536070344258a22cda80afbecac2', '', 'Which of the following is true about red blood cells ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('9e3a2706772d4c38ae8012494f172029', '', 'what is the difference betwen the number 2 307 and 1 378', 1, 'a888ee5f6df74c52a0d70b6bcb606bb0', 'b2a64da77fac499194c1d0bb4a416a34'),
('a03c63855ea043d7983374ddf4c02130', '', 'A shopping cart weight 13 kg 567 g. A student added a number of shopping items weighing 16 kg 665 g into the cart. What is the total weight of the cart and shopping items ?', 2, '838d3d153eff44d1bbfc1a66ab113a2c', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('a0debe3d170d4e139cd96b489d012eb3', '', 'What is the meaning of the term sublimation ?', 6, '53b9fc62af274e08a93a6d42675ca86a', '73bdba1305834e6aaee45bf39e4f4dbd'),
('a1393dc954874bce8463b971625747c5', '', 'Convert 4 375 cm to metre.', 1, '7e82335799a14158a19e53ef835ae3a2', 'deea8f67f1fe4a3b88d22f92378804b8'),
('a1c336714cde432e988cd05c6490af2d', '', 'In a class of 50 each students contributed six sweets for a class party. How many sweets were contributed ?', 1, '95701a724ebf41b685f8fa1aa1c5ccbd', 'b2a64da77fac499194c1d0bb4a416a34'),
('a25025fb21c74b79b11aa52d562faa44', '', 'Add 34 m 13 cm to 73 m 89 cm', 1, '7e82335799a14158a19e53ef835ae3a2', 'deea8f67f1fe4a3b88d22f92378804b8'),
('a2a579af045647088c33384a0d7cab7f', '', 'Which of the following is false about fruits ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('a3a7948cc0aa413884d87ec09902a29a', '', 'Which of the following is not a source of sound ?', 5, 'd5e7172c9b3f4c28a35087690e423e64', '787d880d5d4647f0a05d59303f870576'),
('a40bdfaf34004fc984cebe267d6dfc78', '', 'Convert 36kilograms and 700 grams to tonnes.', 3, '45459b958d1d42f2b7436d087db87e41', '059c4ba191e84558a48ae44acb8718d4'),
('a4a454319c114e1892db70dd128fbcc0', '', 'What is the name that best describes transfer of heat in solids ?', 5, '628af366d92f4eadacda0db6b1d941c0', '787d880d5d4647f0a05d59303f870576'),
('a50e112d9bf745e499a918540da3a08f', '', 'Which of the following is not a crucial role of fungi in our ecosystem ?', 6, 'e3e68fa2d99b4aff862fd94bf6f3dd39', '65433d5a2ff546e08ce9f432e4183a06'),
('a59c528ca15f43a294fb9ed4d41add1e', '', 'Work out 3 438 × 13.', 3, '88dc82886e05430d9d9e8f336e459739', '182efc31982d4c56b6a70ff43b34788a'),
('a65360e2cf5d40539d1c09957efb2ee2', '', 'How many half kilograms are there in 1kg ?', 1, 'c2412dff641348919c3d21c745f3debb', 'deea8f67f1fe4a3b88d22f92378804b8'),
('a688674c5a8d463e8bd09b80160fa18b', '', 'Work out 15 kg 219 g ÷ 3.', 2, '838d3d153eff44d1bbfc1a66ab113a2c', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('a688e5484dc0417ba2f623469c8e58a4', '', 'Work out 76÷7.\r\n\r\n', 1, '48a82f0c48ff4eb2b91d293858558644', 'b2a64da77fac499194c1d0bb4a416a34'),
('a6f6210be3f541949e84b895e29abf38', '', 'A father had fourty two sweets. He later distributed the sweets among his seven children equally, how many sweets did each child get ?', 1, '48a82f0c48ff4eb2b91d293858558644', 'b2a64da77fac499194c1d0bb4a416a34'),
('a7b12fef2d8c4c5aafab0819fc572139', '', 'Whichof the following is true about force ?', 4, 'd147db3c91614f56a472cb8d73f5559d', '80d0719f51804c33b3f12343482671fa'),
('a83bdbd7f6cc4342a8ab74bd7610664f', '', 'Which of the following is a use of nitrogen ?', 6, '91d7938b6159462ab0d24df5172f4c69', '73bdba1305834e6aaee45bf39e4f4dbd'),
('a884e92341284db288ac927a7814b0b3', '', 'Which of the following is a unit for measuring length ?', 2, '5619dcccad384f419efa3f4f5aec3554', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('aabca3249d834bf69883e1fa67138613', '', 'What is the purpose of the heart ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('ab226a8b6f394a12960c4a178eb833e2', '', 'Which of the following is false about slopes ?', 6, '603aa4e0ec73436e99159ac1beecf6ea', '5fce52cdc4744270b20972d3dc4fa0f1'),
('ab3e806ce084470a8e7d70ade91fda40', '', 'Which activities take place during a sunny weather ?', 4, '0b7e3100bfc947b3a5ee75935fa93a88', '391c05683bdc4508abe79ff3c0babb94'),
('ab644f06314c43438043188ce17b2987', '', 'Which of the following is not a line of symmetry ?', 1, '8b43888e14fa45408b5d77de51d10302', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('abe8028cd02c42d5a7b13eb9a9f74923', '', 'Which of the following is true about petals in plants ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('acb2945be5fe40d78eeae16e2541b3d3', '', 'Which of the following is the correct representation of three hundred and sixteen thousand and sixteen in figures ?', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('acbfeba5cf574a1596d566c016d9b867', '', 'Which of the following process takes place when we put water in a freezer to form ice cubes ?', 6, '53b9fc62af274e08a93a6d42675ca86a', '73bdba1305834e6aaee45bf39e4f4dbd'),
('ad1c84dec6e44f28ab6284edccc3c0cc', '', 'Convert 30 m to centimeters.', 1, '7e82335799a14158a19e53ef835ae3a2', 'deea8f67f1fe4a3b88d22f92378804b8'),
('ad6e725d989a4d6d8bd038ef474e8035', '', 'Find the volumein cubic centimetre of a cube  tank that has a height of 100 cm.', 3, '77544763fbb848e4b535dc2c40d826e7', '059c4ba191e84558a48ae44acb8718d4'),
('ae37f6bd3d82457c9c9aed3b5d34eec2', '', 'Work out 3 h 54 m divided by 6.', 2, '73c128a230154d649a95c2f395a489bb', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('af6fba400cee4e0093d13568a7dcb4a4', '', 'Round of 82.56749 to the nearest three decimal places ?', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('afcb0e3698ea42b9877d01f4bb395fa6', '', 'A wedding ended at 4:32 pm. When did the wedding start if it lasted for a total of 6 h 56 m ?', 2, '73c128a230154d649a95c2f395a489bb', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('b077459672454be2b02fea8d014f134d', '', 'Oxygenated from the lungs goes to ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('b1aeb5a1d7ec4582aaaf00ae22748afc', '', 'Which of the following is not a protective clothing ?', 4, 'c2a7860c8ff146dd940bf4ef8216a70f', '071b225f158b4a55a286539d3625be93'),
('b285ab92f5f041cfaf478b2f1172c375', '', 'In a milk factory workers are given a quarter of a litre for their lunch break. If there are 28 workers in the company, how many millilitres of milk are consumed by the workers ?', 2, 'e0f60556e1e946f48f877692e7bb08e3', '94ceba6b9d2e4842bc651d8a10f0ba16');
INSERT INTO `exams_topicalquizes` (`id`, `file`, `quiz`, `subject_id`, `subtopic_id`, `topic_id`) VALUES
('b2fbe6f1ba294586a67e7d9f98ef9075', '', 'Which of the following shows the correct order in ascending order on the percentage composition of gases in the air ?', 6, '91d7938b6159462ab0d24df5172f4c69', '73bdba1305834e6aaee45bf39e4f4dbd'),
('b3c585af71d94dcebea3209a7514c0ab', '', '13 000\r\n-9 487\r\n_________ \r\n', 1, 'a888ee5f6df74c52a0d70b6bcb606bb0', 'b2a64da77fac499194c1d0bb4a416a34'),
('b420ed463f7b4ba0a981edcc7588a9e4', '', 'Which of the following best describes the meaning of the term invertebrate ?', 6, '316e18fe6d37444fb90f8ed46054aa89', '65433d5a2ff546e08ce9f432e4183a06'),
('b5b065fcc1324a47857de0ec5cb8e921', '', 'Which of the following is not an application of floating ?', 5, 'c9f95b5e2ee945de94801340dd76d492', '787d880d5d4647f0a05d59303f870576'),
('b5c2c593bb94465b90e81ea9a34419de', '', 'Which of the following is not an example of  ?', 6, '603aa4e0ec73436e99159ac1beecf6ea', '5fce52cdc4744270b20972d3dc4fa0f1'),
('b5ecadd5d83b44a284abb34107eba355', '', 'Which of the following is not a charasteristics of animals.', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('b5f310dfb3ce4e6495787ad1470f968b', '', 'A student had 2kgs of bread. She later received 5 more kg from the school backery. What is the total mass of the bread the student has if she earlier ate 3 kgs ?', 1, 'c2412dff641348919c3d21c745f3debb', 'deea8f67f1fe4a3b88d22f92378804b8'),
('b6955ff81cf541ca8bb7898be3c0beaf', '', 'Work out 12 m 55 cm 7 mm + 36 m 95 cm 9 mm', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('b6ae7c4f060b4626b082e831071c18de', '', 'Convert 78054 ml to litres.', 3, '77544763fbb848e4b535dc2c40d826e7', '059c4ba191e84558a48ae44acb8718d4'),
('b701ee3b38ab4520af6a00d72939287e', '', 'Which of the following best describes chlorophyll ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('b72e64949672452797593ff86d526e67', '', 'What is the total value of six in six hundred and six thousand three hundred and five ?', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('b8eacada96cb4c05bacad20deee397bc', '', 'How do levers make work easier ?', 6, 'bf4099a7123a4f448b9f971e8dcb5373', '5fce52cdc4744270b20972d3dc4fa0f1'),
('b8f54098ec6b4a988f489f367bbd4fe5', '', 'A hole measures 2.4 m by 1.2 m by 2 m. Find the volume of the hole in cubic centimetres.', 3, '77544763fbb848e4b535dc2c40d826e7', '059c4ba191e84558a48ae44acb8718d4'),
('b969f12d41574a578d886ac0879936cd', '', 'What is the purpose of the white blood cells ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('b9eddbc451064c099c201e1a8f7efdc2', '', 'What is the value of x in x = 16 × 5 ?', 1, '95701a724ebf41b685f8fa1aa1c5ccbd', 'b2a64da77fac499194c1d0bb4a416a34'),
('bad77fcc122941bead9396e6249b4f01', '', 'Which of the following is not a way of reducing air pollution ?', 6, '91d7938b6159462ab0d24df5172f4c69', '73bdba1305834e6aaee45bf39e4f4dbd'),
('bb35b2133042451f9c2e240af9828a4f', '', 'Which of the following is not a weather condition ?', 4, '0b7e3100bfc947b3a5ee75935fa93a88', '391c05683bdc4508abe79ff3c0babb94'),
('bb6ac8c0265846419b8e73d224d7a8d8', '', 'What is the meaning of pollution ?', 4, 'e018fa86c90144c5b2b1ba8e8902cab2', '870d063230e54ab6bc6aaf166ca586b5'),
('bc1ab7318e1848f5b8a0c97b7e87db54', '', 'Which of the following best describes heterogenous mixtures ?', 5, '7071e61cada845d1848c5f5866cc61ec', '481defbe30ca4f1d9c3bc519ee6db70c'),
('bc32d047ed654c7da05749422622db9f', '', 'How many chambers does the human heart have ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('bcb8c8523fb841c0adb2e29caf3ba3b8', '', 'Round of 456.4579007 to three decimal places ?', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('bd93ba2fb6674b468517f24c8b93e28e', '', 'Animals can be grouped into two. Which of the choices below is correct ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('bde5f8a9c05448eb8293b62059211655', '', 'Which of the following clouds shows that there will be heavy rainfalls ?', 4, '0e05d89766034bd0a999959f925451de', '391c05683bdc4508abe79ff3c0babb94'),
('be2fb7f698d4467fad9624c49cb632b7', '', 'Calculate the area of a square whose side measures 12 cm.', 2, '40f37d4d1db54c0d80bbdfcbbe95309d', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('bf36149cc4234205906a286776f6a0b7', '', 'Convert 22 months to years and months.', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('bfa8ed3d55ee4fe3be38380060fb8fae', '', 'Convert 996 seconds into minutes and seconds.\r\n\r\n', 2, '73c128a230154d649a95c2f395a489bb', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('bffff8c69b264434a7589c82c8df0686', '', 'Find the square of 16.', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('c0177e292a31464cae33197eea39c410', '', 'Which of the following is the correct use of poor conductors of heat ?', 4, '29867d10f65a4ac4bb2d352633896b79', '80d0719f51804c33b3f12343482671fa'),
('c02ea1bedfc04309ba34eb8f0b45872d', '', 'Work out. 4 500 sh 79 ct + 6 500  sh 1 ct 345 sh 27 ct', 2, '932b0433136f403bbff727464323a532', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('c19627b9f3bf4b6f85a96bd787e31473', '', 'Which of the following pairs are not edible fruits ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('c220a35ca0a34fc295af096e0ae5e247', '', 'How many millilitres are there in four and a quarter litres ?', 2, 'e0f60556e1e946f48f877692e7bb08e3', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('c2c2ca17a6d5480b81c773a27bbf2dd6', '', 'What is the correct meaning of good conductors of heat ?', 5, '628af366d92f4eadacda0db6b1d941c0', '787d880d5d4647f0a05d59303f870576'),
('c332250e6b744f1eb4ae81609c91a683', '', 'Which of the following contains a mammal and a fish respectively ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('c400b758ab5d49498ae7b93ec16c43dc', '', 'Convert 96 hrs to days.', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('c5885c85a76244199f9632afa391184d', '', 'Which of the following best describes lunar eclipse ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('c639ac0e12c64a71bc5e1bfffa35deb0', '', 'How many days are in february in a leap year ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('c6d94b55c1e74bb589906cedbcfa952b', '', 'which of the following is not a  purpose of the bronchus ?', 5, 'a2bd35cbc4f54f73b29bf75db6cc2454', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('c77e01160cbf4a208bc17e1b043794ca', '', 'Which of the following is not an apllicable use of oxygen ?', 6, '91d7938b6159462ab0d24df5172f4c69', '73bdba1305834e6aaee45bf39e4f4dbd'),
('c79c3b7fc31e4f0da3a85b799840d551', '', 'How many 1/4 kgs are there in 2 kilograms ?', 1, 'c2412dff641348919c3d21c745f3debb', 'deea8f67f1fe4a3b88d22f92378804b8'),
('c87ba4b7ae83487096013a2aa0d2f8ed', '', 'What is the square of 13 ?', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('c8aeca0bd39346cd8daf41cf43c15685', '', 'Which of the following is not a part of a flower ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('c9b86a49b99e4c5a997f0819338d0022', '', 'Which of the following is a method of separating homogenous mixtures ?', 5, '7071e61cada845d1848c5f5866cc61ec', '481defbe30ca4f1d9c3bc519ee6db70c'),
('c9ea6e321dc846049da4bda234b51f2a', '', 'Which of the following is not one way how light moves through materials ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('cae318703dba40d2af826672b8366b80', '', 'Write three hundred three thousand and three in figures.', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('cb1ac97db2104d05b88b404b3349883a', '', 'Work out 647.8203 - 598.9948. Round the results to two decimal places.', 3, '92df037abf084b8e99f6802d9bc19ca7', '182efc31982d4c56b6a70ff43b34788a'),
('cc38deedf8634318a062cbde8da01d54', '', 'Solve for a in 36a - 12  = 32a + 24', 3, '35cddc300c864b41a7de64094aa1e919', '182efc31982d4c56b6a70ff43b34788a'),
('ccacf7047be546a6b09ba5384a6967e0', '', 'Convert three and a half kilograms to grams ?', 2, '838d3d153eff44d1bbfc1a66ab113a2c', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('cd1d54879294492fb072509e642bcf6d', '', 'What is the purpose of the mouth in human digestive system ?', 4, '68cebfc7bb1b4512afaf5a7fd7e99c1d', '071b225f158b4a55a286539d3625be93'),
('cdcf93bdddba46489458b53fc84de544', '', 'Which of the following is not a change of state ?', 6, '53b9fc62af274e08a93a6d42675ca86a', '73bdba1305834e6aaee45bf39e4f4dbd'),
('ce2f100c5adf4113a1819bba406ab998', '', 'Add 3 3/4 litres to 5 1/2 litres.', 1, '2ceb6de23db34727980321e12b09b531', 'deea8f67f1fe4a3b88d22f92378804b8'),
('ce39060b925f49a39446805b572f2f00', '', 'Which of the following correctly shows characteristics of plants as living things ?', 4, 'c2a7860c8ff146dd940bf4ef8216a70f', '071b225f158b4a55a286539d3625be93'),
('cf1230ebce2e428dbec7b722e7d28a16', '', 'What is the other name for a stem in trees ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('cfbeed45abb549a0b9805df8dac14974', '', 'A car was found to weigh 2 tonnes and seven hundred and ninety grams. Convert its mass to kilograms.', 3, '45459b958d1d42f2b7436d087db87e41', '059c4ba191e84558a48ae44acb8718d4'),
('d33f2880268c41db8caa6ba7377b5586', '', 'Which of the following best describes the term transluscent ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('d35c5b43dee842bf8a68706f9226b416', '', 'Which of the following pairs contains only vertebrates ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('d385540b2f8f44ef80ccaf2d6cc0509a', '', 'Complete the pattern below\r\n  13,   17,    21,    ............?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('d49d6b91dccf4ca7ac359023c8df16ef', '', 'Solve t - 6 = 3/8', 2, 'c5b5f471b6cc46a09da0db7f3e2c0295', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('d4e2414214964fd084a69067ee8da102', '', 'Which of the following best describes the role of veins in the human circulatory system ?', 6, 'a014d2abedae4b87a8c1c6dffe4bea1a', '65433d5a2ff546e08ce9f432e4183a06'),
('d50f4c8a044b4025bead701230f5b9d1', '', 'work out the following. 11 h 24 m 45 sec × 8', 2, '73c128a230154d649a95c2f395a489bb', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('d54341c94e014140b52503dad80eaa2a', '', 'Work out 400 m 56 cm 8 mm divided by 8.', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('d586e5dc29ea4947bb0405b0dad814f5', '', 'Convert 9.7 l to millilitres.', 3, '77544763fbb848e4b535dc2c40d826e7', '059c4ba191e84558a48ae44acb8718d4'),
('d75c27413db642aca3d1d507493a5f0a', '', 'Which of the following best describes effects of water pollution ?', 4, '4b139d9ff4144c6a872ee65057c5fcbc', '870d063230e54ab6bc6aaf166ca586b5'),
('d7bbaff6988c4c19aff6ceffeb41ab7c', '', 'Multiply 45 m 50 cm 5 mm by 5.', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('d7bce54c0cd04d6c9cf9e0a9a732b517', '', 'Which of the following is not an effect of water pollution ?', 5, '6383a55dc9854486a0725d9bb4fb9ecd', '481defbe30ca4f1d9c3bc519ee6db70c'),
('d7be68b36b824dfda359b8a530f08b64', '', 'What are the factors of the number 56 ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('d81c525d95364c13abe5c20bd9406877', '', 'Convert 3 years 5 months to months.', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('d9e61d950a6941d3b62abfbdc9a31411', '', 'The volume of a cuboid was found to be 420 cubic centimeters. The height and width of the cuboid was 12 and 5 respectively. Find the length of the cuboid.', 2, 'abd163cdcdfe4c06ab86e3aa36bd1120', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('d9fd4e7f42044339b3987453c9fe487f', '', 'What is the value of :\r\n5m 33 cm × 4 = ?', 1, '7e82335799a14158a19e53ef835ae3a2', 'deea8f67f1fe4a3b88d22f92378804b8'),
('db4f14314f8c4a22b9b473593d83240e', '', 'A student looked at his digital watch during their evening games activitities and it read 3:26. Was the time a.m or p.m ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('db719b73283c431cb9f1ed4aa7596b19', '', 'Which of the following is not considered as living things ?', 4, 'c2a7860c8ff146dd940bf4ef8216a70f', '071b225f158b4a55a286539d3625be93'),
('db866d88699f4731a132fcc335a22748', '', 'What is the square root of 121?', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('dbc4bea5778240b58b1b027ff10e1376', '', 'Which of the following is not part of the human digestive system ?', 4, '69cb10820a2c4568bd0e989ad295d3fa', '071b225f158b4a55a286539d3625be93'),
('dcc84d9f9fe24f018f32779243a95310', '', 'What is the purpose of the stigma in a flower ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('dcfc4add8a2543889287dff5f7a9afff', '', 'Work out 7 litres 232 ml × 8.', 2, 'e0f60556e1e946f48f877692e7bb08e3', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('dd6b9bc5ec19406b84aefc4fb5ec30e2', '', 'Which of the following is not a color of the rainbow ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('ddd9b30c728449d988c9e64a3fea6ec9', '', 'Which of the following is false about arachnids ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('de2a762672db43ae8c9e6f12ffe44399', '', 'Which of the following is false about sound ?', 4, 'bbe912323079473bb7c1b533e8366051', '80d0719f51804c33b3f12343482671fa'),
('de60cb7c1c614a10a889a283a534a8e5', '', 'Work out: 14p + 16x - 17p - 32x + 22p - 36', 3, '35cddc300c864b41a7de64094aa1e919', '182efc31982d4c56b6a70ff43b34788a'),
('dffb0c776fae43f5b5b8ca27dd085c5a', '', 'Which of the following is not an application of sound ?', 5, 'd5e7172c9b3f4c28a35087690e423e64', '787d880d5d4647f0a05d59303f870576'),
('e04a598350a84254870f56f8eb3c0114', '', 'A banker had 667.002 shillings in her account. She later purchased a glass of juice for 12.118. How much was she left with ?', 2, '71ad059d99ef476a8ec249ca9161fb88', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('e05cb6714b9d4578b8d3546d7d2d72b7', '', 'Which of the selections below best describes effects of air pollution on living things ?', 4, 'e018fa86c90144c5b2b1ba8e8902cab2', '870d063230e54ab6bc6aaf166ca586b5'),
('e0838c38f0c248728d378427a9f5f43e', '', 'Which of the following best describes activities undertaken during raining seasons ?', 4, '0b7e3100bfc947b3a5ee75935fa93a88', '391c05683bdc4508abe79ff3c0babb94'),
('e21b521e94da4ea5adfbfe32825e5fea', '', 'Select the numbers which are both divisible by 2 and 10.\r\n3 010,  412,   650, 1 002', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('e28135f8b5c54355a6cac8f39fdbd1bb', '', 'A student had 5 sh and 10 cents. He later received 60 shillings and 97 cents from his sister. How much money does the student have ?', 1, 'db4f2f4ff4724a35b4ad708cb73b4b8f', 'deea8f67f1fe4a3b88d22f92378804b8'),
('e39e614da75a4736af0e4ccedb922956', '', 'Which of the following is not a way of preventing water pollution?', 4, '4b139d9ff4144c6a872ee65057c5fcbc', '870d063230e54ab6bc6aaf166ca586b5'),
('e42e3def049e4121bdd5f062f07a3e9f', '', 'Which of the following best describes non-flowering plants ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('e434557584eb4f16a446bc9d785cff9a', '', 'Which of the following affects floating and sinking of objects in water ?', 4, '440d08aeb1594ce780f82e895fb91391', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('e444ce0be4d6430e8724efd89bc78777', '', 'Which of the following angles is the biggest ?', 1, 'd8846feb519f4aebb4474ea8ca50d61a', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('e4b5f73c9ddc460cb246f8188fee5e8f', '', 'Which of the following is false about sound ?', 5, 'd5e7172c9b3f4c28a35087690e423e64', '787d880d5d4647f0a05d59303f870576'),
('e5fded685c4044a494254fdca4dc7183', '', 'Which of the following is true about homogeneous mixtures ?', 5, '7071e61cada845d1848c5f5866cc61ec', '481defbe30ca4f1d9c3bc519ee6db70c'),
('e666cb5875b14025a17b151af5526ffa', '', 'Which of the following lines run from the top to the bottom of a shape ?', 1, '8b43888e14fa45408b5d77de51d10302', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('e88bde52d08e4f55856f91b30bbdc884', '', 'Which of the following pairs illustrate method of water treatment ?', 5, '6383a55dc9854486a0725d9bb4fb9ecd', '481defbe30ca4f1d9c3bc519ee6db70c'),
('ea556ff0007a489ba5c8db15f52bdc62', '', 'Which of the following best describes the term reflection ?', 6, 'b8a23acb37ba4ec9a89ff30d7f5a1b51', '5fce52cdc4744270b20972d3dc4fa0f1'),
('ea5a7302adba4abe871e81d792a2d138', '', 'A right angles has the value of ?', 1, 'd8846feb519f4aebb4474ea8ca50d61a', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('eb3896ca3d9547f58febd2e4a2ee95e6', '', 'Round off 1 566 099 to the nearest 100 000.', 3, '7ad5247dc0e84bdd8aa715853ff0811f', '182efc31982d4c56b6a70ff43b34788a'),
('eca0491a77df40a18a4e0a79946ee76d', '', 'Which of the following is false about mammals ?', 5, '060999ad814c4d3fa35c8c41b9257b79', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('ed9a7930040d4066a61ab401dd6622df', '', 'Which of the following is not a state of matter ?', 4, '3084527d7dce47b796358723d23baea1', '6f83f223938c4f5d8c3ffc48d51f0da9'),
('ee9d671b90894444a04b8fa9d0b51b29', '', 'Which of the folowing contains plants with tap roots ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('ef0ae91db36145ebbd7777416063d562', '', 'In which weather condition is winnowing done ?', 4, '0b7e3100bfc947b3a5ee75935fa93a88', '391c05683bdc4508abe79ff3c0babb94'),
('f05314291b91449cbe1a1d5daefc6600', '', 'What is the place value of the digit 7 and 5 respectively in the number 725 467 ?', 2, '730ba2cddd2946e88cc246d8c64a9e32', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('f09dbaf4c5ec4a448e0cd11c35e4bc10', '', 'What is the function of the anther in a flower ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('f21f7dc6d9344e938e395422bcca6a9d', '', 'Which of the following pairs contains only invertebrates ?', 6, '316e18fe6d37444fb90f8ed46054aa89', '65433d5a2ff546e08ce9f432e4183a06'),
('f31321329c6d4cd3bc5fb675434a71d4', '', 'In which of the following will the light of a lamp not pass through ?', 4, '513378363dfa445599c70db8106ac283', '80d0719f51804c33b3f12343482671fa'),
('f36a955ffc3a40ca832819a11d3b3d0d', '', 'Which of the following is true about a translucent object ?', 4, '513378363dfa445599c70db8106ac283', '80d0719f51804c33b3f12343482671fa'),
('f3a8280f48dc460298f09f16faf03b4f', '', 'Subtract 48 m 56 cm 9 mm from 78 m 24 cm 1 mm.', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('f6925e7b51764d3291e5ad1e33ac592e', '', 'Which of the following is not a property of a rectangle ?', 1, '8b43888e14fa45408b5d77de51d10302', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('f720c4dc640f45f38e87efa7df8bf2c6', '', 'A school had three thousand three hundred and seventy seven books in its liblary. The school received five thousand four hundred and sixty seven more. How many books in total does the school have now ?', 1, 'cc35570a8c3c45b68c464800ce2aecf2', 'b2a64da77fac499194c1d0bb4a416a34'),
('f80be5a61123499fa21b5eb691dd0ef8', '', 'How many 200 shilings notes are in ksh 4400 ?', 2, '932b0433136f403bbff727464323a532', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('f8a7e8f39be34aa1947d9a2cc1f41545', '', 'What is the capacity in litres of a fluid measured to be 13 750 millilitres ?', 2, 'e0f60556e1e946f48f877692e7bb08e3', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('f90452cfe6c7418f8935acd9655f4b2a', '', 'Convert 15m  26 seconds to seconds.', 2, '73c128a230154d649a95c2f395a489bb', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('f932b409d78c4aa6bf73f34c13eaa5c8', '', 'Which of the following is not a fuction of leaves in a plant ?', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('f9cccaf95eec409da5d467e64a3dc16f', '', 'A company had thre hundred thousand four hundred and four milk packets. They produced one hundred thousand two hundred and nine more. They then sold two hundred and eight thousand packets. How many packets was the company left with ?', 2, '4368e90cf2054a5fa775133531a7fc48', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('faacbdba2ba341e69ea9fe0f98550313', '', 'Convert 75 mm to centimetres.', 3, '9c6f9cfea482448f975eb4b86ef1d7d6', '059c4ba191e84558a48ae44acb8718d4'),
('fb182ae69e8549658ee6d2429e9a69e2', '', 'Which of the following numbers are a multiple of 10 ?\r\n30009. 40015, 30010, 4020', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('fb97a08e39c043c9a56f678f48ae7d54', '', 'A student looked at a military watch during their trip and it read 17:56. Convert to 12 hrs system.', 3, 'a43c39977d044a1a92a2a6a8b11bd644', '059c4ba191e84558a48ae44acb8718d4'),
('fbbb7f119a474f20b257976c2bfcc93a', '', 'Convert 0.054 t to kilograms.', 3, '45459b958d1d42f2b7436d087db87e41', '059c4ba191e84558a48ae44acb8718d4'),
('fc7e2553bb39483bb9952da2dcfa32a6', '', 'Most non-flowering plants by means of', 5, '66d3fb4fc7344396b845c280765ceb08', '201bd90ff3ce4f3490ac84b1b85e76f5'),
('fcc1d122d0bf493eaa1e992fa13d4b44', '', 'If a driver makes two round trips between Nairobi and Eldoret, and each one-way trip takes 4 hours and 33 minutes, what is the total travel time?', 2, '73c128a230154d649a95c2f395a489bb', '94ceba6b9d2e4842bc651d8a10f0ba16'),
('fd617d4892c8460cbc2d3f186c47e9fa', '', 'Convert 8:36 pm to 24 hrs system.', 3, 'a43c39977d044a1a92a2a6a8b11bd644', '059c4ba191e84558a48ae44acb8718d4'),
('fdbfaf4d1c464839b272379745c19668', '', 'Solve the following equation. x + 21 = 33', 2, 'c5b5f471b6cc46a09da0db7f3e2c0295', 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('fde2905c9d804f3a928f011f80d2c7ac', '', 'If the year 2008 was aleap year. Which years would also be leap years ?', 1, 'd1be9bd4b8914834abbaca1d69e07a75', 'deea8f67f1fe4a3b88d22f92378804b8'),
('fe155121d1224686b0357d4c786c56b4', '', 'Which of the following best describes odd numbers ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('fe53534dc9b249f4b0933896f445ffe1', '', 'Which of the following is not an angle ?', 1, 'd8846feb519f4aebb4474ea8ca50d61a', 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('fe814c43e68946f1ac588f4998ce461c', '', 'Which of the following shows the correct value of thirty eight thousand three hundred and three ?', 1, 'ee79b27e4cb94dd998dba70bcb58d126', 'b2a64da77fac499194c1d0bb4a416a34'),
('feb6c5e214fc48abb2bf78622e9a9cd8', '', 'Which of the following is not a unit measurement for mass ?', 3, '45459b958d1d42f2b7436d087db87e41', '059c4ba191e84558a48ae44acb8718d4');

-- --------------------------------------------------------

--
-- Table structure for table `guardian_mykids`
--

CREATE TABLE `guardian_mykids` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guardian_mykids_kids`
--

CREATE TABLE `guardian_mykids_kids` (
  `id` bigint(20) NOT NULL,
  `mykids_id` bigint(20) NOT NULL,
  `myuser_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logs_logentry`
--

CREATE TABLE `logs_logentry` (
  `id` bigint(20) NOT NULL,
  `app_name` varchar(100) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `school` char(32) NOT NULL,
  `level` varchar(10) NOT NULL,
  `error_type` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `object_id` varchar(100) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs_logentry`
--

INSERT INTO `logs_logentry` (`id`, `app_name`, `url`, `school`, `level`, `error_type`, `message`, `model`, `timestamp`, `object_id`, `user_id`) VALUES
(1, 'Teacher.views', '/Teacher/Dashboard/', '3d627dc5da9f45829a9c31ce81448784', 'CRITICAL', 'NameError', 'name \'SchoolClass\' is not defined', 'TeacherProfile', '2024-07-23 00:16:24.638016', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_accountinquiries`
--

CREATE TABLE `subjectlist_accountinquiries` (
  `id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `uuid` char(32) NOT NULL,
  `message` longtext NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_completion`
--

CREATE TABLE `subjectlist_completion` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `response` longtext NOT NULL,
  `prompt_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_course`
--

CREATE TABLE `subjectlist_course` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `discipline` varchar(20) NOT NULL,
  `abbreviation` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjectlist_course`
--

INSERT INTO `subjectlist_course` (`id`, `name`, `discipline`, `abbreviation`) VALUES
(1, 'Mathematics', 'Mathematics', 'Math'),
(2, 'Science and Technology', 'Science', 'Math'),
(3, 'Social Studies', 'Humanities', 'Math'),
(4, 'Computer Studies', 'IT', 'Math'),
(5, 'English', 'Literature', 'Math'),
(6, 'Agriculture', 'Humanities', 'Math');

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_mysubjects`
--

CREATE TABLE `subjectlist_mysubjects` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_mysubjects_name`
--

CREATE TABLE `subjectlist_mysubjects_name` (
  `id` bigint(20) NOT NULL,
  `mysubjects_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_paymentnotifications`
--

CREATE TABLE `subjectlist_paymentnotifications` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `notification_type` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `about` varchar(100) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `date` datetime(6) NOT NULL,
  `amount` int(10) UNSIGNED NOT NULL CHECK (`amount` >= 0),
  `subscription_type` varchar(10) NOT NULL,
  `beneficiaries` varchar(1000) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_progress`
--

CREATE TABLE `subjectlist_progress` (
  `id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_progress_subtopic`
--

CREATE TABLE `subjectlist_progress_subtopic` (
  `id` bigint(20) NOT NULL,
  `progress_id` bigint(20) NOT NULL,
  `subtopic_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_progress_topic`
--

CREATE TABLE `subjectlist_progress_topic` (
  `id` bigint(20) NOT NULL,
  `progress_id` bigint(20) NOT NULL,
  `topic_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_prompt`
--

CREATE TABLE `subjectlist_prompt` (
  `id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `uuid` char(32) NOT NULL,
  `quiz` longtext NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_ratelimiter`
--

CREATE TABLE `subjectlist_ratelimiter` (
  `id` bigint(20) NOT NULL,
  `tokens` int(10) UNSIGNED NOT NULL CHECK (`tokens` >= 0),
  `image` int(10) UNSIGNED NOT NULL CHECK (`image` >= 0),
  `speech` int(10) UNSIGNED NOT NULL CHECK (`speech` >= 0),
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_subject`
--

CREATE TABLE `subjectlist_subject` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `order` int(11) NOT NULL,
  `grade` varchar(2) NOT NULL,
  `topics` int(10) UNSIGNED NOT NULL CHECK (`topics` >= 0),
  `abbreviation` varchar(10) NOT NULL,
  `course_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjectlist_subject`
--

INSERT INTO `subjectlist_subject` (`id`, `name`, `order`, `grade`, `topics`, `abbreviation`, `course_id`) VALUES
(1, 'Mathematics', 1, '4', 5, 'DEF', 1),
(2, 'Mathematics', 1, '5', 4, 'DEF', 1),
(3, 'Mathematics', 1, '6', 4, 'DEF', 1),
(4, 'Science and Technology', 1, '4', 4, 'DEF', 2),
(5, 'Science and Technology', 1, '5', 4, 'DEF', 2),
(6, 'Science and Technology', 1, '6', 4, 'DEF', 2),
(7, 'Social Studies', 1, '4', 4, 'DEF', 3),
(8, 'Social Studies', 1, '5', 4, 'DEF', 3),
(9, 'Social Studies', 1, '6', 4, 'DEF', 3),
(10, 'Computer Studies', 1, '4', 4, 'DEF', 4),
(11, 'Computer Studies', 1, '5', 4, 'DEF', 4),
(12, 'Computer Studies', 1, '6', 4, 'DEF', 4),
(13, 'English', 1, '4', 4, 'DEF', 5),
(14, 'English', 1, '5', 4, 'DEF', 5),
(15, 'English', 1, '6', 4, 'DEF', 5),
(16, 'Agriculture', 1, '4', 4, 'DEF', 6),
(17, 'Agriculture', 1, '5', 4, 'DEF', 6),
(18, 'Agriculture', 1, '6', 4, 'DEF', 6);

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_subtopic`
--

CREATE TABLE `subjectlist_subtopic` (
  `id` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `file1` varchar(100) NOT NULL,
  `file2` varchar(100) NOT NULL,
  `order` varchar(5) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `topic_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjectlist_subtopic`
--

INSERT INTO `subjectlist_subtopic` (`id`, `name`, `file1`, `file2`, `order`, `subject_id`, `topic_id`) VALUES
('060999ad814c4d3fa35c8c41b9257b79', 'Animals', 'file.pdf', 'start.mp4', '2', 5, '201bd90ff3ce4f3490ac84b1b85e76f5'),
('08c70acbb1434cb8acd898b6827e306d', 'Area', 'file.pdf', 'start.mp4', '2', 1, 'deea8f67f1fe4a3b88d22f92378804b8'),
('0b7e3100bfc947b3a5ee75935fa93a88', 'Weather ', 'file.pdf', 'start.mp4', '1', 4, '391c05683bdc4508abe79ff3c0babb94'),
('0e05d89766034bd0a999959f925451de', 'Clouds', 'file.pdf', 'start.mp4', '2', 4, '391c05683bdc4508abe79ff3c0babb94'),
('19070e4e65c6401b8a4d41111f626815', 'Multiplication', 'file.pdf', 'start.mp4', '4', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('2831f60454d646258c16775c0260ed99', 'Teeth', 'file.pdf', 'start.mp4', '4', 4, '071b225f158b4a55a286539d3625be93'),
('29867d10f65a4ac4bb2d352633896b79', 'Heat Energy', 'file.pdf', 'start.mp4', '4', 4, '80d0719f51804c33b3f12343482671fa'),
('2b15214ec85e4e9287e51f578673e2d7', 'Area', 'file.pdf', 'start.mp4', '2', 3, '059c4ba191e84558a48ae44acb8718d4'),
('2ceb6de23db34727980321e12b09b531', 'Capacity', 'file.pdf', 'start.mp4', '5', 1, 'deea8f67f1fe4a3b88d22f92378804b8'),
('3084527d7dce47b796358723d23baea1', 'States of Matter', 'file.pdf', 'start.mp4', '1', 4, '6f83f223938c4f5d8c3ffc48d51f0da9'),
('316e18fe6d37444fb90f8ed46054aa89', 'Invertebrates', 'file.pdf', 'start.mp4', '2', 6, '65433d5a2ff546e08ce9f432e4183a06'),
('35cddc300c864b41a7de64094aa1e919', 'Inequalities', 'file.pdf', 'start.mp4', '6', 3, '182efc31982d4c56b6a70ff43b34788a'),
('37896cd8a0404d86ad48d03d30e0a835', 'Machines and Levers', 'file.pdf', 'start.mp4', '5', 4, '80d0719f51804c33b3f12343482671fa'),
('400dd23348ef4d8d8ccfdd4afaa85c76', 'Fractions', 'file.pdf', 'start.mp4', '4', 3, '182efc31982d4c56b6a70ff43b34788a'),
('40f37d4d1db54c0d80bbdfcbbe95309d', 'Area', 'file.pdf', 'start.mp4', '2', 2, '94ceba6b9d2e4842bc651d8a10f0ba16'),
('4368e90cf2054a5fa775133531a7fc48', 'Subtraction', 'file.pdf', 'start.mp4', '3', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('440d08aeb1594ce780f82e895fb91391', 'Floating And Sinking', 'file.pdf', 'start.mp4', '3', 4, '6f83f223938c4f5d8c3ffc48d51f0da9'),
('45459b958d1d42f2b7436d087db87e41', 'Mass', 'file.pdf', 'start.mp4', '4', 3, '059c4ba191e84558a48ae44acb8718d4'),
('48a82f0c48ff4eb2b91d293858558644', 'Division', 'file.pdf', 'start.mp4', '5', 1, 'b2a64da77fac499194c1d0bb4a416a34'),
('4b139d9ff4144c6a872ee65057c5fcbc', 'Water Pollution', 'file.pdf', 'start.mp4', '2', 4, '870d063230e54ab6bc6aaf166ca586b5'),
('513378363dfa445599c70db8106ac283', 'Light Energy', 'file.pdf', 'start.mp4', '3', 4, '80d0719f51804c33b3f12343482671fa'),
('53b9fc62af274e08a93a6d42675ca86a', 'Change of State', 'file.pdf', 'start.mp4', '1', 6, '73bdba1305834e6aaee45bf39e4f4dbd'),
('5619dcccad384f419efa3f4f5aec3554', 'Length', 'file.pdf', 'start.mp4', '1', 2, '94ceba6b9d2e4842bc651d8a10f0ba16'),
('5b5981af49c74cee9817644cf198eb84', 'Fractions', 'file.pdf', 'start.mp4', '6', 1, 'b2a64da77fac499194c1d0bb4a416a34'),
('5ded735696024f01b01d0e721518cbdc', 'Volume', 'file.pdf', 'start.mp4', '4', 1, 'deea8f67f1fe4a3b88d22f92378804b8'),
('603aa4e0ec73436e99159ac1beecf6ea', 'Slopes', 'file.pdf', 'start.mp4', '3', 6, '5fce52cdc4744270b20972d3dc4fa0f1'),
('628af366d92f4eadacda0db6b1d941c0', 'Heat Transfer', 'file.pdf', 'start.mp4', '3', 5, '787d880d5d4647f0a05d59303f870576'),
('6383a55dc9854486a0725d9bb4fb9ecd', 'Water', 'file.pdf', 'start.mp4', '2', 5, '481defbe30ca4f1d9c3bc519ee6db70c'),
('66d3fb4fc7344396b845c280765ceb08', 'Plants', 'file.pdf', 'start.mp4', '1', 5, '201bd90ff3ce4f3490ac84b1b85e76f5'),
('68cebfc7bb1b4512afaf5a7fd7e99c1d', 'Human Digestive System', 'file.pdf', 'start.mp4', '3', 4, '071b225f158b4a55a286539d3625be93'),
('69cb10820a2c4568bd0e989ad295d3fa', 'Animals', 'file.pdf', 'start.mp4', '2', 4, '071b225f158b4a55a286539d3625be93'),
('7071e61cada845d1848c5f5866cc61ec', 'Mixtures', 'file.pdf', 'start.mp4', '1', 5, '481defbe30ca4f1d9c3bc519ee6db70c'),
('71ad059d99ef476a8ec249ca9161fb88', 'Decimals', 'file.pdf', 'start.mp4', '7', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('730ba2cddd2946e88cc246d8c64a9e32', 'Whole Numbers', 'file.pdf', 'start.mp4', '1', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('73c128a230154d649a95c2f395a489bb', 'Time', 'file.pdf', 'start.mp4', '6', 2, '94ceba6b9d2e4842bc651d8a10f0ba16'),
('77544763fbb848e4b535dc2c40d826e7', 'Capacity', 'file.pdf', 'start.mp4', '3', 3, '059c4ba191e84558a48ae44acb8718d4'),
('7ad5247dc0e84bdd8aa715853ff0811f', 'Whole Numbers', 'file.pdf', 'start.mp4', '1', 3, '182efc31982d4c56b6a70ff43b34788a'),
('7af9fbdfee3e463280e6d87bf3e7eb3b', 'Division', 'file.pdf', 'start.mp4', '5', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('7dfac60fffb44980b25c5ac1fe63f0cc', 'Money', 'file.pdf', 'start.mp4', '6', 3, '059c4ba191e84558a48ae44acb8718d4'),
('7e82335799a14158a19e53ef835ae3a2', 'Length', 'file.pdf', 'start.mp4', '1', 1, 'deea8f67f1fe4a3b88d22f92378804b8'),
('7fcf2bef4c094335a39661082a46589d', 'Position and Direction', 'file.pdf', 'start.mp4', '1', 1, 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('80131f0a6c5a428ba0111424dfd370ba', 'Coding', 'file.pdf', 'start.mp4', '2', 4, '29acb78ccb6b45ceb73e675967bff3d7'),
('805e316d0f6643b9a65c110511c1a8ab', 'Decimals', 'file.pdf', 'start.mp4', '7', 1, 'b2a64da77fac499194c1d0bb4a416a34'),
('8346f249ab0a45739ce6f729c3bdfa8e', 'Use of Letters', 'file.pdf', 'start.mp4', '1', 1, '8a266bf22d494d3db0bf97cef5e74b7d'),
('838d3d153eff44d1bbfc1a66ab113a2c', 'Mass', 'file.pdf', 'start.mp4', '5', 2, '94ceba6b9d2e4842bc651d8a10f0ba16'),
('88dc82886e05430d9d9e8f336e459739', 'Multiplication', 'file.pdf', 'start.mp4', '2', 3, '182efc31982d4c56b6a70ff43b34788a'),
('8b43888e14fa45408b5d77de51d10302', '2-Dimensional Shapes', 'file.pdf', 'start.mp4', '3', 1, 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('91d7938b6159462ab0d24df5172f4c69', 'Composition of Air', 'file.pdf', 'start.mp4', '2', 6, '73bdba1305834e6aaee45bf39e4f4dbd'),
('92df037abf084b8e99f6802d9bc19ca7', 'Decimals', 'file.pdf', 'start.mp4', '5', 3, '182efc31982d4c56b6a70ff43b34788a'),
('932b0433136f403bbff727464323a532', 'Money', 'file.pdf', 'start.mp4', '7', 2, '94ceba6b9d2e4842bc651d8a10f0ba16'),
('95701a724ebf41b685f8fa1aa1c5ccbd', 'Multiplication', 'file.pdf', 'start.mp4', '4', 1, 'b2a64da77fac499194c1d0bb4a416a34'),
('95f57e5cb8a74bbab5a37d7d33ca7ec0', 'Fractions', 'file.pdf', 'start.mp4', '6', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('9ab8bd138f6b4bc199f018565e2eae9a', 'Division', 'file.pdf', 'start.mp4', '3', 3, '182efc31982d4c56b6a70ff43b34788a'),
('9c6f9cfea482448f975eb4b86ef1d7d6', 'Length', 'file.pdf', 'start.mp4', '1', 3, '059c4ba191e84558a48ae44acb8718d4'),
('a014d2abedae4b87a8c1c6dffe4bea1a', 'Human Circulatory System', 'file.pdf', 'start.mp4', '3', 6, '65433d5a2ff546e08ce9f432e4183a06'),
('a2bd35cbc4f54f73b29bf75db6cc2454', 'Human Breathing System', 'file.pdf', 'start.mp4', '3', 5, '201bd90ff3ce4f3490ac84b1b85e76f5'),
('a4026bd3d09044ada767c4698b6edb06', 'Addition', 'file.pdf', 'start.mp4', '2', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('a43c39977d044a1a92a2a6a8b11bd644', 'Time', 'file.pdf', 'start.mp4', '5', 3, '059c4ba191e84558a48ae44acb8718d4'),
('a8634a57433c4a738dc4a3a7b647350b', 'Data', 'file.pdf', 'start.mp4', '1', 1, '1775a1cbaa054ee9b43b7c3516be0149'),
('a888ee5f6df74c52a0d70b6bcb606bb0', 'Subtraction', 'file.pdf', 'start.mp4', '3', 1, 'b2a64da77fac499194c1d0bb4a416a34'),
('abd163cdcdfe4c06ab86e3aa36bd1120', 'Volume', 'file.pdf', 'start.mp4', '3', 2, '94ceba6b9d2e4842bc651d8a10f0ba16'),
('b846bbb4ca2a42639b667e6e5cdd94f0', 'Digital Devices', 'file.pdf', 'start.mp4', '1', 4, '29acb78ccb6b45ceb73e675967bff3d7'),
('b8a23acb37ba4ec9a89ff30d7f5a1b51', 'Light Energy', 'file.pdf', 'start.mp4', '1', 6, '5fce52cdc4744270b20972d3dc4fa0f1'),
('bbe912323079473bb7c1b533e8366051', 'Sound Energy', 'file.pdf', 'start.mp4', '2', 4, '80d0719f51804c33b3f12343482671fa'),
('bf4099a7123a4f448b9f971e8dcb5373', 'Levers and Simple Machines', 'file.pdf', 'start.mp4', '2', 6, '5fce52cdc4744270b20972d3dc4fa0f1'),
('c2412dff641348919c3d21c745f3debb', 'Mass', 'file.pdf', 'start.mp4', '3', 1, 'deea8f67f1fe4a3b88d22f92378804b8'),
('c2a7860c8ff146dd940bf4ef8216a70f', 'Plants', 'file.pdf', 'start.mp4', '1', 4, '071b225f158b4a55a286539d3625be93'),
('c5b5f471b6cc46a09da0db7f3e2c0295', 'Simple Equations', 'file.pdf', 'start.mp4', '8', 2, 'f7b39f0cdf7a4d6baa45ac2ac6d4c0ad'),
('c9f95b5e2ee945de94801340dd76d492', 'Floating And Sinking', 'file.pdf', 'start.mp4', '1', 5, '787d880d5d4647f0a05d59303f870576'),
('cc35570a8c3c45b68c464800ce2aecf2', 'Addition', 'file.pdf', 'start.mp4', '2', 1, 'b2a64da77fac499194c1d0bb4a416a34'),
('d147db3c91614f56a472cb8d73f5559d', 'Force', 'file.pdf', 'start.mp4', '1', 4, '80d0719f51804c33b3f12343482671fa'),
('d1be9bd4b8914834abbaca1d69e07a75', 'Time', 'file.pdf', 'start.mp4', '6', 1, 'deea8f67f1fe4a3b88d22f92378804b8'),
('d5e7172c9b3f4c28a35087690e423e64', 'Sound Energy', 'file.pdf', 'start.mp4', '2', 5, '787d880d5d4647f0a05d59303f870576'),
('d8846feb519f4aebb4474ea8ca50d61a', 'Angles', 'file.pdf', 'start.mp4', '2', 1, 'c59e50898eeb4c3eac4c3346a4c9eedf'),
('db4f2f4ff4724a35b4ad708cb73b4b8f', 'Money', 'file.pdf', 'start.mp4', '7', 1, 'deea8f67f1fe4a3b88d22f92378804b8'),
('e018fa86c90144c5b2b1ba8e8902cab2', 'Air Pollution', 'file.pdf', 'start.mp4', '1', 4, '870d063230e54ab6bc6aaf166ca586b5'),
('e0f60556e1e946f48f877692e7bb08e3', 'Capacity', 'file.pdf', 'start.mp4', '4', 2, '94ceba6b9d2e4842bc651d8a10f0ba16'),
('e3e68fa2d99b4aff862fd94bf6f3dd39', 'Fungi', 'file.pdf', 'start.mp4', '1', 6, '65433d5a2ff546e08ce9f432e4183a06'),
('ec45d61f1eae4babb7160382a0d1454c', 'Properties of Matter', 'file.pdf', 'start.mp4', '2', 4, '6f83f223938c4f5d8c3ffc48d51f0da9'),
('ee79b27e4cb94dd998dba70bcb58d126', 'Whole Numbers', 'file.pdf', 'start.mp4', '1', 1, 'b2a64da77fac499194c1d0bb4a416a34');

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_topic`
--

CREATE TABLE `subjectlist_topic` (
  `id` char(32) NOT NULL,
  `order` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `topics_count` varchar(5) NOT NULL,
  `test_size` int(10) UNSIGNED NOT NULL CHECK (`test_size` >= 0),
  `time` int(10) UNSIGNED NOT NULL CHECK (`time` >= 0),
  `subject_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjectlist_topic`
--

INSERT INTO `subjectlist_topic` (`id`, `order`, `name`, `topics_count`, `test_size`, `time`, `subject_id`) VALUES
('059c4ba191e84558a48ae44acb8718d4', 2, 'Measurement', '6', 10, 30, 3),
('071b225f158b4a55a286539d3625be93', 1, 'Living Things', '4', 10, 30, 4),
('1775a1cbaa054ee9b43b7c3516be0149', 4, 'Data Handling', '1', 5, 15, 1),
('182efc31982d4c56b6a70ff43b34788a', 1, 'Numbers', '6', 10, 30, 3),
('201bd90ff3ce4f3490ac84b1b85e76f5', 1, 'Living Things', '3', 10, 25, 5),
('29acb78ccb6b45ceb73e675967bff3d7', 3, 'Digital Technology', '2', 10, 30, 4),
('391c05683bdc4508abe79ff3c0babb94', 6, 'Earth and Space', '2', 10, 25, 4),
('3c356e8a89fe4dbb9c2fbcc1edd9f24c', 3, 'Geometry', '3', 10, 30, 2),
('481defbe30ca4f1d9c3bc519ee6db70c', 2, 'Matter', '2', 10, 25, 5),
('5fce52cdc4744270b20972d3dc4fa0f1', 3, 'Force and Energy', '3', 10, 30, 6),
('65433d5a2ff546e08ce9f432e4183a06', 1, 'Living Things', '3', 10, 25, 6),
('67d32444c9f648588192abef268ba649', 4, 'Data Handling', '1', 7, 20, 3),
('6f83f223938c4f5d8c3ffc48d51f0da9', 4, 'Matter', '2', 10, 30, 4),
('73bdba1305834e6aaee45bf39e4f4dbd', 2, 'Matter', '2', 10, 25, 6),
('787d880d5d4647f0a05d59303f870576', 3, 'Force and Energy', '3', 10, 25, 5),
('80d0719f51804c33b3f12343482671fa', 5, 'Force and Energy', '5', 10, 30, 4),
('870d063230e54ab6bc6aaf166ca586b5', 2, 'Environment', '2', 10, 30, 4),
('8a266bf22d494d3db0bf97cef5e74b7d', 5, 'Algebra', '1', 10, 30, 1),
('94ceba6b9d2e4842bc651d8a10f0ba16', 2, 'Measurement', '7', 10, 35, 2),
('b2a64da77fac499194c1d0bb4a416a34', 1, 'Numbers', '7', 10, 30, 1),
('c59e50898eeb4c3eac4c3346a4c9eedf', 3, 'Geometry', '3', 10, 30, 1),
('c7cbcdedff2843ec8cda5b0fa63ff507', 4, 'Data Handling', '1', 10, 30, 2),
('d4f4efa0ef6c40f881d898a873d620df', 3, 'Geometry', '3', 10, 30, 3),
('deea8f67f1fe4a3b88d22f92378804b8', 2, 'Measurement', '7', 10, 30, 1),
('f7b39f0cdf7a4d6baa45ac2ac6d4c0ad', 1, 'Numbers', '8', 10, 35, 2);

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_topicalexamresults`
--

CREATE TABLE `subjectlist_topicalexamresults` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `notification_type` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `about` varchar(100) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `date` datetime(6) NOT NULL,
  `test` char(32) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `topic_id` char(32) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjectlist_topicexamnotifications`
--

CREATE TABLE `subjectlist_topicexamnotifications` (
  `id` bigint(20) NOT NULL,
  `uuid` char(32) NOT NULL,
  `notification_type` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `about` varchar(100) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `date` datetime(6) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `topic_id` char(32) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_mpesapayments`
--

CREATE TABLE `subscription_mpesapayments` (
  `id` bigint(20) NOT NULL,
  `amount` int(11) NOT NULL,
  `student_list` varchar(100) NOT NULL,
  `date` datetime(6) NOT NULL,
  `checkout_id` varchar(100) NOT NULL,
  `receipt` varchar(15) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `transaction_date` varchar(100) NOT NULL,
  `sub_type_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_mysubscription`
--

CREATE TABLE `subscription_mysubscription` (
  `expiry` date NOT NULL,
  `id` bigint(20) NOT NULL,
  `account` varchar(10) DEFAULT NULL,
  `date` date NOT NULL,
  `status` tinyint(1) NOT NULL,
  `type_id` varchar(30) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_pendingpayment`
--

CREATE TABLE `subscription_pendingpayment` (
  `id` bigint(20) NOT NULL,
  `checkout_id` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `subscriptions_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_pendingpayment_beneficiaries`
--

CREATE TABLE `subscription_pendingpayment_beneficiaries` (
  `id` bigint(20) NOT NULL,
  `pendingpayment_id` bigint(20) NOT NULL,
  `myuser_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_stripecardpayments`
--

CREATE TABLE `subscription_stripecardpayments` (
  `id` bigint(20) NOT NULL,
  `transact_id` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `brand` varchar(30) NOT NULL,
  `date` datetime(6) NOT NULL,
  `created` varchar(15) NOT NULL,
  `type` varchar(100) NOT NULL,
  `student_list` varchar(100) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_subscriptions`
--

CREATE TABLE `subscription_subscriptions` (
  `id` bigint(20) NOT NULL,
  `type` varchar(30) NOT NULL,
  `amount` int(10) UNSIGNED NOT NULL CHECK (`amount` >= 0),
  `validity` varchar(10) NOT NULL,
  `duration` int(10) UNSIGNED NOT NULL CHECK (`duration` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_filemodel`
--

CREATE TABLE `supervisor_filemodel` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_inquire`
--

CREATE TABLE `supervisor_inquire` (
  `id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `message` longtext NOT NULL,
  `contact` varchar(100) NOT NULL,
  `names` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_questioncount`
--

CREATE TABLE `supervisor_questioncount` (
  `id` bigint(20) NOT NULL,
  `count` int(10) UNSIGNED NOT NULL CHECK (`count` >= 0),
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervisor_questioncount`
--

INSERT INTO `supervisor_questioncount` (`id`, `count`, `user_id`) VALUES
(1, 394, 3);

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_questioncount_quiz`
--

CREATE TABLE `supervisor_questioncount_quiz` (
  `id` bigint(20) NOT NULL,
  `questioncount_id` bigint(20) NOT NULL,
  `topicalquizes_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervisor_questioncount_quiz`
--

INSERT INTO `supervisor_questioncount_quiz` (`id`, `questioncount_id`, `topicalquizes_id`) VALUES
(158, 1, '00ea73b3472e4c28b26914b19b508a66'),
(392, 1, '016981d9247444e28c812ccd30677200'),
(157, 1, '01dfd877879444c481548df6452d5c95'),
(159, 1, '024863521d044198a5c26ecea7ba54b1'),
(105, 1, '02b7ac47c567464d81244ff876146ae2'),
(181, 1, '069472379bcb4e88a990132287037bde'),
(185, 1, '078292ffc1344431a2a6cb8c52ffc14b'),
(32, 1, '07b20456082749f7ae717411087e6f52'),
(42, 1, '07bf7129229342d08c701fc69056e7ed'),
(1, 1, '081124b34c4248f991c24f113e745402'),
(349, 1, '085a18cb3fd84132ae5c2f945202420e'),
(67, 1, '087d6ce6562e40ebb8dca35f3a626553'),
(393, 1, '088f135bfd9647ac8eaab8fbaee5c00e'),
(321, 1, '08e4c2e73a0e4a7891019a76e8dcb9da'),
(82, 1, '093ec5f0b5cc4710a6c0147fb2e5e2c8'),
(77, 1, '09a9b6ec849541319bd025374801312f'),
(21, 1, '0a0582091aa24528a84a3aec8f599ef7'),
(347, 1, '0a80e65e908a48bd99010f8d5eda3eba'),
(274, 1, '0b68d9fdab8f4b3581093168ed5383d3'),
(10, 1, '0bc31e7162424c6bb31fa39a53842d7f'),
(262, 1, '0bff63aadc1a44f09e5a7b67bd513559'),
(281, 1, '0c72df0f1be74b8d9cc7b6cb47a4bdf2'),
(345, 1, '0db877c3e6f74f13b2f81f9db5770de7'),
(286, 1, '0e418ee92fe54ccb814840d4361ae703'),
(234, 1, '0e42455ff2264b038419f2b1a3c342b4'),
(335, 1, '0e945d25067f4c24adcb3136f5d7264c'),
(216, 1, '0f97ae1ee4ab4905bbc0eae7729118b5'),
(291, 1, '0f9c50b6ed104c1187d370d63e580836'),
(313, 1, '1128b464e295438fb4adbbf6a1712c90'),
(239, 1, '11820b7260c4407fa61401085331c89a'),
(98, 1, '119f393bc8fc4540be145b2db3fa1732'),
(284, 1, '13ab781fe4b34eadbbdfb7a14688802a'),
(388, 1, '143eeefe5d7a404c933d18651cd484f3'),
(186, 1, '151da5fee22247e4836cb1b9ee7cb922'),
(107, 1, '15a26398b7fd49339afba8043556b62e'),
(377, 1, '175ede72582a4438a85ba2d05769b20f'),
(75, 1, '1779d56524a24535bfdecca2b38ff637'),
(331, 1, '192f0e65d1ca4ddb8fdd42e3a87347ec'),
(194, 1, '19628957bc5546be83e0e7b5170d89ef'),
(261, 1, '19a4ca73f92c450d99d9904ff3d87c76'),
(236, 1, '1a4f53a7316640fea92d84da11f84ff2'),
(382, 1, '1ab0c85dd49e42098992a70aa13359f3'),
(178, 1, '1af9dadec92b409ea98f236154599c14'),
(197, 1, '1d5ec5456ab1431a9620daae5501ef00'),
(383, 1, '1d65bd4d6cf546f093582d55c334e018'),
(221, 1, '1dcfccba03244784a83b0b92e361ffd9'),
(168, 1, '1dd1b0e4910643e4a052a5b7b400bd7e'),
(121, 1, '1e5b987848344faf804289cd1d520471'),
(113, 1, '1f45262543f14871a9b8fc627f924b92'),
(23, 1, '208b3186bddc42ac80eefa67cc5a1483'),
(215, 1, '21f56fc4bd8241a18ee885f667fe132e'),
(190, 1, '222d1def85b24ff6b537b87cd9b7fd7a'),
(280, 1, '22ae3b1f6c3c457a9733c99f227e3ab4'),
(38, 1, '22c76b4b3aed46e8b969c3d37f4a898b'),
(52, 1, '23fc3fd62641425fbee1ae8db0556714'),
(334, 1, '25a89a2162c241deafa99ba8cecfb2dd'),
(96, 1, '26475a9fcd58472e85d833b3897dc978'),
(369, 1, '2733882310bd433c8353e64f87091ce2'),
(328, 1, '28b3b3cb8f934420a0de4b95d96cbb30'),
(134, 1, '2949177d863a490bbb94b47538817048'),
(55, 1, '298a980824cc4dee8271468f038f3e67'),
(340, 1, '2994eee0b78e49f8b53a857c9182332c'),
(70, 1, '2a95c1cdff4b4ae6a3208b0d2cf2df60'),
(252, 1, '2aa9f0c457134b6fad2cc761fe40757b'),
(39, 1, '2bb050dadae84953b3f093f01b19184b'),
(307, 1, '2c879405512e49cc847ac1d75fb72ccb'),
(206, 1, '2ca0d2dd52b74bce9e40d856670baa43'),
(50, 1, '2d300d1904cf44bea4aceb1733a98360'),
(172, 1, '2d693ff4f1d1487786f7197ab46bf9d8'),
(63, 1, '2dffc82a38cf4a89879c98c62bbc0486'),
(167, 1, '2e6a890e2c8343e79a63a3d09ffdda04'),
(166, 1, '3016c264f4d84d53a35e2533b2004ce5'),
(93, 1, '30b93ea91e3146bdbbdcc5395010f73c'),
(231, 1, '31ba1a2cab414fa5adffbdf12c35c687'),
(296, 1, '32281ff8bce9450fac82f87e7c551ece'),
(354, 1, '32b31b7eaaa94be398d3e3b673edb2ce'),
(258, 1, '3386b4431c53418dbe7dd1ac98eff2c6'),
(184, 1, '33957668a75f46b59458462ddcc59dea'),
(251, 1, '3406e79a65844fcea9c41eadfa8e6663'),
(145, 1, '345721e95ce448fdb1aaa9f9e9d4d3f4'),
(247, 1, '34c6a17805a34102926d54fd5dc7f3bf'),
(45, 1, '34e456e84c544cf684b654d50d3a2669'),
(69, 1, '3653712b762a4aa487a68460cea7e557'),
(101, 1, '366f66b75f064b37b4077b96107b412a'),
(202, 1, '368366c2155341eeada5799c4773deba'),
(43, 1, '36c8ed1a8dd84b909ad915826c61df76'),
(182, 1, '3713827d6b794881a31c0c593cf9eb24'),
(232, 1, '37cb6337e2164278940eacaba661e48d'),
(120, 1, '37dc94bf57614fd593a10284dd27d641'),
(155, 1, '3a27382f9c4940b588449e30fcbd2897'),
(139, 1, '3a52bc7ad0e342af9d59ee83ee694010'),
(174, 1, '3a90baa35627433388ec9a9bfb6b9097'),
(249, 1, '3adf418f999440048d36f2990161ea8b'),
(30, 1, '3b10a10c569c478ca6fbb9a6661080b1'),
(73, 1, '3c232aa573164a408611828e66f033d8'),
(41, 1, '3cef548d8fbe4dad97e32685502bb65b'),
(394, 1, '3d8eafeb480c4050b980c7772d0b9653'),
(305, 1, '3dad72b6543c4690a72bdb4302b61ade'),
(260, 1, '3f03654d0cfa4e9b895cb0f09cf9222e'),
(379, 1, '3f04c183921f4c709f48a68164a32532'),
(137, 1, '3f6d18d432414b9b83dc5bdb895e5312'),
(97, 1, '3fdc62cbde0e45bdb94722095c9d2b55'),
(229, 1, '4173738447534872968b5de85b4bf013'),
(94, 1, '439d91f58e284a9ab2413e062664fa52'),
(28, 1, '4488a126eff843bd9c068096641c7d9c'),
(22, 1, '44c204a96514485f895de122a73a56d6'),
(312, 1, '45918614a52143fcb4bb991ce7c9c377'),
(308, 1, '46389c3b80ab465eb27855073b37bce1'),
(250, 1, '467ca0bb399a4e7e8bdb69954562188f'),
(195, 1, '46975a7fb082430a91c4e5ae1399a32e'),
(361, 1, '46f12200132f43718a18b185c561fd4b'),
(34, 1, '47170450874f427da1a36c4e06123bd8'),
(122, 1, '474650dc884d431cbb3225ebd18348fa'),
(27, 1, '488f9e9463d74e64ba6d50a1034618d5'),
(272, 1, '4bd617934e374ce8bf4458299fb0c639'),
(180, 1, '4c2d1e6d07d54cb2af3fad1a29fe8d0e'),
(80, 1, '4c92863673a940f3bf2fd8d5949b1f3d'),
(320, 1, '4e2c65b6164848b58a72171ddaea5063'),
(266, 1, '4e357098bb9e4112921bfc6a0706e59d'),
(246, 1, '4e5361a539444bdfbb702b5d18ea408c'),
(9, 1, '4ef011d4580d4fb18432480018300853'),
(129, 1, '4f48ed6576964f0595db33cb525a26cf'),
(327, 1, '517719cf777b47018fa67f33f3e37b40'),
(373, 1, '52224bf8d56f4efaa5b91a7ddf8096c4'),
(179, 1, '5269b37638d1423aa0c64d10becb44e0'),
(136, 1, '531423fd6cc34d5ea84d8e62f3155c98'),
(200, 1, '5342b95185ec4218a02a3b4630d635d8'),
(375, 1, '538dae8b99684f9f88b652ddbcd195eb'),
(359, 1, '554a3ddba6bf44f5b337f7dfd769804f'),
(341, 1, '5599cffa3eb14451ad1f6f508a6a5b77'),
(187, 1, '560bb0a11aa743629884aea031125701'),
(126, 1, '562eceb3ad1a4416923681a0ea8c4212'),
(18, 1, '571b66ca48244b93b7e8fbfe9dba045f'),
(302, 1, '5858d67de26840658b1a4a688f7c79b1'),
(339, 1, '58c858b0d5f742938d5dd2b027d91f6a'),
(13, 1, '59119f894c4b45178af6ce0d1606c31b'),
(118, 1, '5973546bc4334ae8a5b347dacfd19527'),
(391, 1, '5ae1fcbb40aa44c18f688417fbc14199'),
(370, 1, '5c092f3a3c954c5d808a2fe834fc1d48'),
(350, 1, '5c84167c0e274703b5c491c8fb218aa0'),
(25, 1, '5d772de1b1d74daca61e3835ccae12e8'),
(2, 1, '5e4cd1ba51634cca807c44883b43b694'),
(306, 1, '5e73774cffbf4b78a67a56aa8e001532'),
(62, 1, '5f14e2c389c44203b252bc92811df7c5'),
(112, 1, '5fbe37ddf05e47dea877754e189edfd2'),
(16, 1, '60a1590834ee4841b6fec6ba384b43a5'),
(4, 1, '60d7d97791ef40fbafba174c32085863'),
(74, 1, '62fbd25232f04e7e8c24fabcaaa20c64'),
(395, 1, '6348a869fea9417498f537606284e0d1'),
(146, 1, '637caacf57be4fc985082f8b2bfa2265'),
(230, 1, '642da40ee05b4515ae2f40fb09bf1692'),
(360, 1, '644f23dc39e34eb7b27233711a0258af'),
(135, 1, '6493c957b09941f498442def6f3b071b'),
(268, 1, '65944ca657ce469aab984ece26a2b619'),
(364, 1, '669bef6a32354ff4817b0dbbe8bfadab'),
(300, 1, '66a4a2ae907940449cf9f943ecb22e88'),
(269, 1, '68a6b59b2ce04b648fe38b24daebcb8e'),
(177, 1, '68b63c28f77a4d7da710bc0335a9d653'),
(351, 1, '68fa3c5656864f6981f6f52cd6ac13cb'),
(358, 1, '691e382e04cd4feea3f3cfb2946c2b86'),
(81, 1, '697575f9a2174ef091c6fc72916fe46a'),
(211, 1, '69d04d1c4eae422caca47a42ff50fe7c'),
(115, 1, '6a591ef4c2854d3c8fedc9face95302f'),
(130, 1, '6a9c340f3d674830909a2f2286aedc43'),
(362, 1, '6bde147aae6d45a1b8bfe03a947ef91e'),
(90, 1, '6cb8c3104d394a5584c6a39b47e56948'),
(117, 1, '6eff4299369a4932ac95906cba951fd5'),
(189, 1, '6f02ac3324d34590996f0dd898ab3527'),
(367, 1, '6f80c107d5684250bb74815dcdc2b733'),
(365, 1, '6fb35040969b4333a71606c6af651213'),
(108, 1, '6feea713e84945a0b77485d6479416e1'),
(336, 1, '7009229737e34d6e8ef306ac6d94bf85'),
(319, 1, '72795f163f1145fd8fc4b4d8a6164930'),
(54, 1, '72da7c47ae5c4df89da5e27a83945617'),
(275, 1, '7337784229b647b987ab529327546eb4'),
(40, 1, '73403ce5fdbb40efb88c7c20c3a0dded'),
(293, 1, '75450175bb4a42d0924a8b93902b8686'),
(156, 1, '754bff2331fc41a797b8353ad37f092c'),
(278, 1, '755cb7670d974b9b910e160f2c0c56bc'),
(48, 1, '7646acc52a1e4007a132ef4a4ad75824'),
(99, 1, '768e1342bad54d90a7001a3311f121e0'),
(322, 1, '7703d7f913564fdca869961d3d5959af'),
(5, 1, '770798a97a3c4052b4f2702a7f3aa2ed'),
(310, 1, '780e587fdc6840e1ba60865d551d5531'),
(199, 1, '786a1c5cc3b6462e8e5d61a6e052d800'),
(171, 1, '791cc430a8af4d41b20f86e3267a2f78'),
(271, 1, '79866fc6ca374c1b98cbf39c770e53fa'),
(285, 1, '79e984b646ed4a32909a513ddbc3a505'),
(147, 1, '7ad8837394eb4fb2bf8bc5e3ab205d1f'),
(164, 1, '7c7ec322969d42bd83562df89c373f7d'),
(222, 1, '7cb93156965348ea83ee006c454b4d6a'),
(24, 1, '80958ab35c2e4e50882e96385edaccc8'),
(154, 1, '809af93a20724e37b2aec6dae1f3aa48'),
(165, 1, '81b5afc7301048b595bdd87718926c43'),
(33, 1, '820d96ac346f4641ad794dc3e7612707'),
(398, 1, '82c4734eea7b4b1e89100dd7d1f281be'),
(123, 1, '8330b2648f514ebc8dc977023e38f91e'),
(64, 1, '83c2791b100a4350ab937ee1f0c7e12d'),
(314, 1, '8487b759af534c6799e1722e30214df4'),
(144, 1, '84dbb9a84d7d4657aad03e8eacb4df12'),
(223, 1, '85502e2321c042f8bd78e03fd8cc0920'),
(213, 1, '85810a6b060247cca390fce72f8e5a8f'),
(368, 1, '85cc9a47f6264c05b92ed761df95e861'),
(161, 1, '87da34be53f8416085d17bab89e7be3e'),
(46, 1, '87f095bdfe694724b64a57892d960ae6'),
(17, 1, '8812b50fd83b4bac8fa63e4b7f495c4a'),
(173, 1, '8947722779ec4754a2264fc2a35f0b74'),
(217, 1, '8a41569231db4bfbb83a32c0a1b59e79'),
(273, 1, '8ace7601bede4491b5f074b3b3240d44'),
(356, 1, '8bb162139d8f4c0683ebea28207644a3'),
(111, 1, '8be4212e46384c7c9f635346b4d38e91'),
(86, 1, '8cc305c0038244418d3bb73ced14e7aa'),
(287, 1, '8cd062300f854e3fab7bd3eaf407e18b'),
(151, 1, '8e50fc4d5da14a4385fcaa58d3da428f'),
(128, 1, '8e77e3b475ec4d2ca2bdca12d1c0fce1'),
(346, 1, '8f9e5d1826cd4967b3689f36ad98e014'),
(218, 1, '8faff50822134b69838209f09b820e26'),
(324, 1, '9123effb96d444f6a6f4793781a1d20b'),
(162, 1, '919855e6a33e4ed18287ce434173649b'),
(71, 1, '91d6f0b0f4c54297b90da37fe1687d8b'),
(235, 1, '926e3ec885e3420eaece115fa94929fe'),
(170, 1, '933716cd8fa44920811ff616ba68be37'),
(163, 1, '9632c14549a04b6a89c71ed25c15dabb'),
(326, 1, '9658f1714cf744d0a0e7dac5c7358db4'),
(259, 1, '966793791c78437495b87109c1d780fb'),
(124, 1, '98e24a665bf3455a9b267e41ecc64b11'),
(87, 1, '994258f0adb149fda94a3703ee852bd7'),
(311, 1, '999f823f3f8040c4a6c3a52484201cde'),
(140, 1, '99d73d7b89d74ae18d7b848cce65aa00'),
(11, 1, '9ab68f6eb4fa4f0fb5d5e6a227fba31d'),
(83, 1, '9b0f474fc1904f86b1e72f9affce0834'),
(116, 1, '9bacbe07c976454aae7560ba58f7f847'),
(29, 1, '9c215a0901794c18a8bc98fc88fbe87c'),
(248, 1, '9cff816c9ece4871849b01ebb0e8e874'),
(372, 1, '9d2d536070344258a22cda80afbecac2'),
(72, 1, '9e3a2706772d4c38ae8012494f172029'),
(201, 1, 'a03c63855ea043d7983374ddf4c02130'),
(376, 1, 'a0debe3d170d4e139cd96b489d012eb3'),
(102, 1, 'a1393dc954874bce8463b971625747c5'),
(76, 1, 'a1c336714cde432e988cd05c6490af2d'),
(103, 1, 'a25025fb21c74b79b11aa52d562faa44'),
(288, 1, 'a2a579af045647088c33384a0d7cab7f'),
(330, 1, 'a3a7948cc0aa413884d87ec09902a29a'),
(242, 1, 'a40bdfaf34004fc984cebe267d6dfc78'),
(337, 1, 'a4a454319c114e1892db70dd128fbcc0'),
(342, 1, 'a50e112d9bf745e499a918540da3a08f'),
(233, 1, 'a59c528ca15f43a294fb9ed4d41add1e'),
(106, 1, 'a65360e2cf5d40539d1c09957efb2ee2'),
(203, 1, 'a688674c5a8d463e8bd09b80160fa18b'),
(95, 1, 'a688e5484dc0417ba2f623469c8e58a4'),
(79, 1, 'a6f6210be3f541949e84b895e29abf38'),
(47, 1, 'a7b12fef2d8c4c5aafab0819fc572139'),
(353, 1, 'a83bdbd7f6cc4342a8ab74bd7610664f'),
(176, 1, 'a884e92341284db288ac927a7814b0b3'),
(348, 1, 'aabca3249d834bf69883e1fa67138613'),
(399, 1, 'ab226a8b6f394a12960c4a178eb833e2'),
(60, 1, 'ab3e806ce084470a8e7d70ade91fda40'),
(148, 1, 'ab644f06314c43438043188ce17b2987'),
(295, 1, 'abe8028cd02c42d5a7b13eb9a9f74923'),
(224, 1, 'acb2945be5fe40d78eeae16e2541b3d3'),
(378, 1, 'acbfeba5cf574a1596d566c016d9b867'),
(100, 1, 'ad1c84dec6e44f28ab6284edccc3c0cc'),
(265, 1, 'ad6e725d989a4d6d8bd038ef474e8035'),
(210, 1, 'ae37f6bd3d82457c9c9aed3b5d34eec2'),
(238, 1, 'af6fba400cee4e0093d13568a7dcb4a4'),
(207, 1, 'afcb0e3698ea42b9877d01f4bb395fa6'),
(363, 1, 'b077459672454be2b02fea8d014f134d'),
(12, 1, 'b1aeb5a1d7ec4582aaaf00ae22748afc'),
(193, 1, 'b285ab92f5f041cfaf478b2f1172c375'),
(352, 1, 'b2fbe6f1ba294586a67e7d9f98ef9075'),
(84, 1, 'b3c585af71d94dcebea3209a7514c0ab'),
(343, 1, 'b420ed463f7b4ba0a981edcc7588a9e4'),
(329, 1, 'b5b065fcc1324a47857de0ec5cb8e921'),
(397, 1, 'b5c2c593bb94465b90e81ea9a34419de'),
(14, 1, 'b5ecadd5d83b44a284abb34107eba355'),
(110, 1, 'b5f310dfb3ce4e6495787ad1470f968b'),
(254, 1, 'b6955ff81cf541ca8bb7898be3c0beaf'),
(264, 1, 'b6ae7c4f060b4626b082e831071c18de'),
(299, 1, 'b701ee3b38ab4520af6a00d72939287e'),
(160, 1, 'b72e64949672452797593ff86d526e67'),
(396, 1, 'b8eacada96cb4c05bacad20deee397bc'),
(267, 1, 'b8f54098ec6b4a988f489f367bbd4fe5'),
(371, 1, 'b969f12d41574a578d886ac0879936cd'),
(355, 1, 'b9eddbc451064c099c201e1a8f7efdc2'),
(384, 1, 'bad77fcc122941bead9396e6249b4f01'),
(57, 1, 'bb35b2133042451f9c2e240af9828a4f'),
(26, 1, 'bb6ac8c0265846419b8e73d224d7a8d8'),
(316, 1, 'bc1ab7318e1848f5b8a0c97b7e87db54'),
(357, 1, 'bc32d047ed654c7da05749422622db9f'),
(237, 1, 'bcb8c8523fb841c0adb2e29caf3ba3b8'),
(15, 1, 'bd93ba2fb6674b468517f24c8b93e28e'),
(61, 1, 'bde5f8a9c05448eb8293b62059211655'),
(183, 1, 'be2fb7f698d4467fad9624c49cb632b7'),
(132, 1, 'bf36149cc4234205906a286776f6a0b7'),
(205, 1, 'bfa8ed3d55ee4fe3be38380060fb8fae'),
(227, 1, 'bffff8c69b264434a7589c82c8df0686'),
(56, 1, 'c0177e292a31464cae33197eea39c410'),
(214, 1, 'c02ea1bedfc04309ba34eb8f0b45872d'),
(289, 1, 'c19627b9f3bf4b6f85a96bd787e31473'),
(192, 1, 'c220a35ca0a34fc295af096e0ae5e247'),
(338, 1, 'c2c2ca17a6d5480b81c773a27bbf2dd6'),
(303, 1, 'c332250e6b744f1eb4ae81609c91a683'),
(125, 1, 'c400b758ab5d49498ae7b93ec16c43dc'),
(387, 1, 'c5885c85a76244199f9632afa391184d'),
(127, 1, 'c639ac0e12c64a71bc5e1bfffa35deb0'),
(315, 1, 'c6d94b55c1e74bb589906cedbcfa952b'),
(380, 1, 'c77e01160cbf4a208bc17e1b043794ca'),
(109, 1, 'c79c3b7fc31e4f0da3a85b799840d551'),
(226, 1, 'c87ba4b7ae83487096013a2aa0d2f8ed'),
(294, 1, 'c8aeca0bd39346cd8daf41cf43c15685'),
(318, 1, 'c9b86a49b99e4c5a997f0819338d0022'),
(385, 1, 'c9ea6e321dc846049da4bda234b51f2a'),
(153, 1, 'cae318703dba40d2af826672b8366b80'),
(240, 1, 'cb1ac97db2104d05b88b404b3349883a'),
(277, 1, 'cc38deedf8634318a062cbde8da01d54'),
(198, 1, 'ccacf7047be546a6b09ba5384a6967e0'),
(20, 1, 'cd1d54879294492fb072509e642bcf6d'),
(374, 1, 'cdcf93bdddba46489458b53fc84de544'),
(114, 1, 'ce2f100c5adf4113a1819bba406ab998'),
(6, 1, 'ce39060b925f49a39446805b572f2f00'),
(283, 1, 'cf1230ebce2e428dbec7b722e7d28a16'),
(243, 1, 'cfbeed45abb549a0b9805df8dac14974'),
(386, 1, 'd33f2880268c41db8caa6ba7377b5586'),
(301, 1, 'd35c5b43dee842bf8a68706f9226b416'),
(66, 1, 'd385540b2f8f44ef80ccaf2d6cc0509a'),
(220, 1, 'd49d6b91dccf4ca7ac359023c8df16ef'),
(366, 1, 'd4e2414214964fd084a69067ee8da102'),
(209, 1, 'd50f4c8a044b4025bead701230f5b9d1'),
(257, 1, 'd54341c94e014140b52503dad80eaa2a'),
(263, 1, 'd586e5dc29ea4947bb0405b0dad814f5'),
(35, 1, 'd75c27413db642aca3d1d507493a5f0a'),
(256, 1, 'd7bbaff6988c4c19aff6ceffeb41ab7c'),
(323, 1, 'd7bce54c0cd04d6c9cf9e0a9a732b517'),
(92, 1, 'd7be68b36b824dfda359b8a530f08b64'),
(133, 1, 'd81c525d95364c13abe5c20bd9406877'),
(188, 1, 'd9e61d950a6941d3b62abfbdc9a31411'),
(104, 1, 'd9fd4e7f42044339b3987453c9fe487f'),
(119, 1, 'db4f14314f8c4a22b9b473593d83240e'),
(7, 1, 'db719b73283c431cb9f1ed4aa7596b19'),
(228, 1, 'db866d88699f4731a132fcc335a22748'),
(19, 1, 'dbc4bea5778240b58b1b027ff10e1376'),
(292, 1, 'dcc84d9f9fe24f018f32779243a95310'),
(196, 1, 'dcfc4add8a2543889287dff5f7a9afff'),
(389, 1, 'dd6b9bc5ec19406b84aefc4fb5ec30e2'),
(309, 1, 'ddd9b30c728449d988c9e64a3fea6ec9'),
(49, 1, 'de2a762672db43ae8c9e6f12ffe44399'),
(276, 1, 'de60cb7c1c614a10a889a283a534a8e5'),
(333, 1, 'dffb0c776fae43f5b5b8ca27dd085c5a'),
(175, 1, 'e04a598350a84254870f56f8eb3c0114'),
(31, 1, 'e05cb6714b9d4578b8d3546d7d2d72b7'),
(58, 1, 'e0838c38f0c248728d378427a9f5f43e'),
(91, 1, 'e21b521e94da4ea5adfbfe32825e5fea'),
(138, 1, 'e28135f8b5c54355a6cac8f39fdbd1bb'),
(36, 1, 'e39e614da75a4736af0e4ccedb922956'),
(279, 1, 'e42e3def049e4121bdd5f062f07a3e9f'),
(44, 1, 'e434557584eb4f16a446bc9d785cff9a'),
(142, 1, 'e444ce0be4d6430e8724efd89bc78777'),
(332, 1, 'e4b5f73c9ddc460cb246f8188fee5e8f'),
(317, 1, 'e5fded685c4044a494254fdca4dc7183'),
(149, 1, 'e666cb5875b14025a17b151af5526ffa'),
(325, 1, 'e88bde52d08e4f55856f91b30bbdc884'),
(390, 1, 'ea556ff0007a489ba5c8db15f52bdc62'),
(143, 1, 'ea5a7302adba4abe871e81d792a2d138'),
(225, 1, 'eb3896ca3d9547f58febd2e4a2ee95e6'),
(304, 1, 'eca0491a77df40a18a4e0a79946ee76d'),
(37, 1, 'ed9a7930040d4066a61ab401dd6622df'),
(297, 1, 'ee9d671b90894444a04b8fa9d0b51b29'),
(59, 1, 'ef0ae91db36145ebbd7777416063d562'),
(152, 1, 'f05314291b91449cbe1a1d5daefc6600'),
(290, 1, 'f09dbaf4c5ec4a448e0cd11c35e4bc10'),
(344, 1, 'f21f7dc6d9344e938e395422bcca6a9d'),
(51, 1, 'f31321329c6d4cd3bc5fb675434a71d4'),
(53, 1, 'f36a955ffc3a40ca832819a11d3b3d0d'),
(255, 1, 'f3a8280f48dc460298f09f16faf03b4f'),
(150, 1, 'f6925e7b51764d3291e5ad1e33ac592e'),
(68, 1, 'f720c4dc640f45f38e87efa7df8bf2c6'),
(212, 1, 'f80be5a61123499fa21b5eb691dd0ef8'),
(191, 1, 'f8a7e8f39be34aa1947d9a2cc1f41545'),
(204, 1, 'f90452cfe6c7418f8935acd9655f4b2a'),
(282, 1, 'f932b409d78c4aa6bf73f34c13eaa5c8'),
(169, 1, 'f9cccaf95eec409da5d467e64a3dc16f'),
(253, 1, 'faacbdba2ba341e69ea9fe0f98550313'),
(89, 1, 'fb182ae69e8549658ee6d2429e9a69e2'),
(245, 1, 'fb97a08e39c043c9a56f678f48ae7d54'),
(270, 1, 'fbbb7f119a474f20b257976c2bfcc93a'),
(298, 1, 'fc7e2553bb39483bb9952da2dcfa32a6'),
(208, 1, 'fcc1d122d0bf493eaa1e992fa13d4b44'),
(244, 1, 'fd617d4892c8460cbc2d3f186c47e9fa'),
(219, 1, 'fdbfaf4d1c464839b272379745c19668'),
(131, 1, 'fde2905c9d804f3a928f011f80d2c7ac'),
(65, 1, 'fe155121d1224686b0357d4c786c56b4'),
(141, 1, 'fe53534dc9b249f4b0933896f445ffe1'),
(3, 1, 'fe814c43e68946f1ac588f4998ce461c'),
(241, 1, 'feb6c5e214fc48abb2bf78622e9a9cd8');

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_quizassignment`
--

CREATE TABLE `supervisor_quizassignment` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervisor_quizassignment`
--

INSERT INTO `supervisor_quizassignment` (`id`, `user_id`) VALUES
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_quizassignment_topic`
--

CREATE TABLE `supervisor_quizassignment_topic` (
  `id` bigint(20) NOT NULL,
  `quizassignment_id` bigint(20) NOT NULL,
  `topic_id` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervisor_quizassignment_topic`
--

INSERT INTO `supervisor_quizassignment_topic` (`id`, `quizassignment_id`, `topic_id`) VALUES
(27, 1, '5fce52cdc4744270b20972d3dc4fa0f1');

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_updates`
--

CREATE TABLE `supervisor_updates` (
  `id` bigint(20) NOT NULL,
  `title` varchar(300) NOT NULL,
  `description` longtext NOT NULL,
  `date` date NOT NULL,
  `file` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_sessionbooking`
--

CREATE TABLE `teacher_sessionbooking` (
  `id` bigint(20) NOT NULL,
  `link` varchar(500) DEFAULT NULL,
  `mode` varchar(100) NOT NULL,
  `created` date NOT NULL,
  `date` datetime(6) NOT NULL,
  `about` longtext NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_sessionbooking_students`
--

CREATE TABLE `teacher_sessionbooking_students` (
  `id` bigint(20) NOT NULL,
  `sessionbooking_id` bigint(20) NOT NULL,
  `myuser_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_studentlist`
--

CREATE TABLE `teacher_studentlist` (
  `id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_studentlist_students`
--

CREATE TABLE `teacher_studentlist_students` (
  `id` bigint(20) NOT NULL,
  `studentlist_id` bigint(20) NOT NULL,
  `myuser_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_teacherprofile`
--

CREATE TABLE `teacher_teacherprofile` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_teacherprofile`
--

INSERT INTO `teacher_teacherprofile` (`id`, `user_id`) VALUES
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_teacherprofile_subject`
--

CREATE TABLE `teacher_teacherprofile_subject` (
  `id` bigint(20) NOT NULL,
  `teacherprofile_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_teacherprofile_subject`
--

INSERT INTO `teacher_teacherprofile_subject` (`id`, `teacherprofile_id`, `subject_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_teacherranking`
--

CREATE TABLE `teacher_teacherranking` (
  `id` bigint(20) NOT NULL,
  `rank` int(10) UNSIGNED NOT NULL CHECK (`rank` >= 0),
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_teacherranking`
--

INSERT INTO `teacher_teacherranking` (`id`, `rank`, `user_id`) VALUES
(2, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users_academicprofile`
--

CREATE TABLE `users_academicprofile` (
  `id` bigint(20) NOT NULL,
  `current_class_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_grade`
--

CREATE TABLE `users_grade` (
  `id` bigint(20) NOT NULL,
  `grade` int(10) UNSIGNED NOT NULL CHECK (`grade` >= 0),
  `level` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_myuser`
--

CREATE TABLE `users_myuser` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `uuid` varchar(100) NOT NULL,
  `role` varchar(15) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_myuser`
--

INSERT INTO `users_myuser` (`id`, `password`, `last_login`, `email`, `uuid`, `role`, `is_active`, `is_admin`) VALUES
(2, 'pbkdf2_sha256$600000$TiQHHrIR01vzAlPJeSDwyJ$Ph/tBif7cn7FChmfUMJmYe57/QAiW31V/YqtEKIcBlQ=', '2024-07-23 21:49:07.367935', 'njokevin9@gmail.com', '7644306a-ad9f-448f-bd6e-72ab6442024e', 'Admin', 1, 1),
(3, 'pbkdf2_sha256$600000$NZSseDqIjjKVdXvNddkErm$FrfIaW5YnL3gYGrnxSB47f2dhNpiEry1eumGfvg24u8=', '2024-07-29 09:43:09.036874', 'teacher1@gmail.com', 'eb716a21-7689-4811-94a3-2a50cef70d22', 'Teacher', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users_personalprofile`
--

CREATE TABLE `users_personalprofile` (
  `id` bigint(20) NOT NULL,
  `f_name` varchar(30) NOT NULL,
  `location` varchar(100) NOT NULL,
  `l_name` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_personalprofile`
--

INSERT INTO `users_personalprofile` (`id`, `f_name`, `location`, `l_name`, `surname`, `gender`, `phone`, `user_id`) VALUES
(2, '', '', '', '', '', NULL, 2),
(3, 'kevin', '', 'njoroge', 'gitundu', 'Male', '0742134431', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `exams_classtest`
--
ALTER TABLE `exams_classtest`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `Exams_classtest_subject_id_dceb909e_fk_SubjectList_subject_id` (`subject_id`),
  ADD KEY `Exams_classtest_teacher_id_71727c35_fk_Users_myuser_id` (`teacher_id`),
  ADD KEY `Exams_classtest_class_id_id_5dff4e1c` (`class_id_id`);

--
-- Indexes for table `exams_classteststudenttest`
--
ALTER TABLE `exams_classteststudenttest`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Exams_classteststudenttest_user_id_uuid_1d70e420_uniq` (`user_id`,`uuid`),
  ADD KEY `Exams_classteststude_test_id_40848729_fk_Exams_cla` (`test_id`);

--
-- Indexes for table `exams_classtest_quiz`
--
ALTER TABLE `exams_classtest_quiz`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Exams_classtest_quiz_classtest_id_topicalquizes_id_9106a21d_uniq` (`classtest_id`,`topicalquizes_id`),
  ADD KEY `Exams_classtest_quiz_topicalquizes_id_3e9c5d39_fk_Exams_top` (`topicalquizes_id`);

--
-- Indexes for table `exams_generaltest`
--
ALTER TABLE `exams_generaltest`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `Exams_generaltest_subject_id_d32150eb_fk_SubjectList_subject_id` (`subject_id`),
  ADD KEY `Exams_generaltest_user_id_c254cc21_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `exams_generaltest_quiz`
--
ALTER TABLE `exams_generaltest_quiz`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Exams_generaltest_quiz_generaltest_id_topicalqu_d2345403_uniq` (`generaltest_id`,`topicalquizes_id`),
  ADD KEY `Exams_generaltest_qu_topicalquizes_id_6c36babb_fk_Exams_top` (`topicalquizes_id`);

--
-- Indexes for table `exams_studentsanswers`
--
ALTER TABLE `exams_studentsanswers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Exams_studentsanswers_user_id_uuid_10180606_uniq` (`user_id`,`uuid`),
  ADD KEY `Exams_studentsanswers_quiz_id_22d6f356_fk_Exams_topicalquizes_id` (`quiz_id`),
  ADD KEY `Exams_studentsanswer_selection_id_08039437_fk_Exams_top` (`selection_id`),
  ADD KEY `Exams_studentsanswer_test_content_type_id_8ef1f088_fk_django_co` (`test_content_type_id`);

--
-- Indexes for table `exams_studenttest`
--
ALTER TABLE `exams_studenttest`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `Exams_studenttest_subject_id_693ad2c5_fk_SubjectList_subject_id` (`subject_id`),
  ADD KEY `Exams_studenttest_topic_id_920f9a0d_fk_SubjectList_topic_id` (`topic_id`),
  ADD KEY `Exams_studenttest_user_id_f13e532b_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `exams_studenttest_quiz`
--
ALTER TABLE `exams_studenttest_quiz`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Exams_studenttest_quiz_studenttest_id_topicalqu_1abd905d_uniq` (`studenttest_id`,`topicalquizes_id`),
  ADD KEY `Exams_studenttest_qu_topicalquizes_id_e411cc79_fk_Exams_top` (`topicalquizes_id`);

--
-- Indexes for table `exams_topicalquizanswers`
--
ALTER TABLE `exams_topicalquizanswers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `Exams_topicalquizans_quiz_id_e63f6f38_fk_Exams_top` (`quiz_id`);

--
-- Indexes for table `exams_topicalquizes`
--
ALTER TABLE `exams_topicalquizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Exams_topicalquizes_subject_id_501483e2_fk_SubjectLi` (`subject_id`),
  ADD KEY `Exams_topicalquizes_subtopic_id_32657004_fk_SubjectLi` (`subtopic_id`),
  ADD KEY `Exams_topicalquizes_topic_id_8b289a6d_fk_SubjectList_topic_id` (`topic_id`);

--
-- Indexes for table `guardian_mykids`
--
ALTER TABLE `guardian_mykids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `guardian_mykids_kids`
--
ALTER TABLE `guardian_mykids_kids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Guardian_mykids_kids_mykids_id_myuser_id_4fb01b2e_uniq` (`mykids_id`,`myuser_id`),
  ADD KEY `Guardian_mykids_kids_myuser_id_25a29a40_fk_Users_myuser_id` (`myuser_id`);

--
-- Indexes for table `logs_logentry`
--
ALTER TABLE `logs_logentry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Logs_logentry_user_id_d42ba64a_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `subjectlist_accountinquiries`
--
ALTER TABLE `subjectlist_accountinquiries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `SubjectList_accountinquiries_user_id_0469c233_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `subjectlist_completion`
--
ALTER TABLE `subjectlist_completion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `SubjectList_completi_prompt_id_b07f4f6c_fk_SubjectLi` (`prompt_id`);

--
-- Indexes for table `subjectlist_course`
--
ALTER TABLE `subjectlist_course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjectlist_mysubjects`
--
ALTER TABLE `subjectlist_mysubjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `subjectlist_mysubjects_name`
--
ALTER TABLE `subjectlist_mysubjects_name`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `SubjectList_mysubjects_n_mysubjects_id_course_id_443a4192_uniq` (`mysubjects_id`,`course_id`),
  ADD KEY `SubjectList_mysubjec_course_id_b4be0e5a_fk_SubjectLi` (`course_id`);

--
-- Indexes for table `subjectlist_paymentnotifications`
--
ALTER TABLE `subjectlist_paymentnotifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `SubjectList_paymentn_user_id_462212ae_fk_Users_myu` (`user_id`);

--
-- Indexes for table `subjectlist_progress`
--
ALTER TABLE `subjectlist_progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SubjectList_progress_subject_id_f0fadb80_fk_SubjectLi` (`subject_id`),
  ADD KEY `SubjectList_progress_user_id_ef093ed0_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `subjectlist_progress_subtopic`
--
ALTER TABLE `subjectlist_progress_subtopic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `SubjectList_progress_sub_progress_id_subtopic_id_cac94a23_uniq` (`progress_id`,`subtopic_id`),
  ADD KEY `SubjectList_progress_subtopic_id_b69a9544_fk_SubjectLi` (`subtopic_id`);

--
-- Indexes for table `subjectlist_progress_topic`
--
ALTER TABLE `subjectlist_progress_topic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `SubjectList_progress_topic_progress_id_topic_id_c1999f8c_uniq` (`progress_id`,`topic_id`),
  ADD KEY `SubjectList_progress_topic_id_39e0f3b2_fk_SubjectLi` (`topic_id`);

--
-- Indexes for table `subjectlist_prompt`
--
ALTER TABLE `subjectlist_prompt`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `SubjectList_prompt_user_id_d22c1b3a_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `subjectlist_ratelimiter`
--
ALTER TABLE `subjectlist_ratelimiter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `subjectlist_subject`
--
ALTER TABLE `subjectlist_subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SubjectList_subject_course_id_18ddbe01_fk_SubjectList_course_id` (`course_id`);

--
-- Indexes for table `subjectlist_subtopic`
--
ALTER TABLE `subjectlist_subtopic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SubjectList_subtopic_subject_id_1eee1b10_fk_SubjectLi` (`subject_id`),
  ADD KEY `SubjectList_subtopic_topic_id_c007b43e_fk_SubjectList_topic_id` (`topic_id`);

--
-- Indexes for table `subjectlist_topic`
--
ALTER TABLE `subjectlist_topic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SubjectList_topic_subject_id_3c9122ea_fk_SubjectList_subject_id` (`subject_id`);

--
-- Indexes for table `subjectlist_topicalexamresults`
--
ALTER TABLE `subjectlist_topicalexamresults`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `SubjectList_topicale_subject_id_44d4d5d7_fk_SubjectLi` (`subject_id`),
  ADD KEY `SubjectList_topicale_topic_id_e729201e_fk_SubjectLi` (`topic_id`),
  ADD KEY `SubjectList_topicale_user_id_276b95da_fk_Users_myu` (`user_id`);

--
-- Indexes for table `subjectlist_topicexamnotifications`
--
ALTER TABLE `subjectlist_topicexamnotifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `SubjectList_topicexa_subject_id_439fcbd6_fk_SubjectLi` (`subject_id`),
  ADD KEY `SubjectList_topicexa_topic_id_e7f337f9_fk_SubjectLi` (`topic_id`),
  ADD KEY `SubjectList_topicexa_user_id_5194b43e_fk_Users_myu` (`user_id`);

--
-- Indexes for table `subscription_mpesapayments`
--
ALTER TABLE `subscription_mpesapayments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Subscription_mpesapa_sub_type_id_8f80d1c7_fk_Subscript` (`sub_type_id`),
  ADD KEY `Subscription_mpesapayments_user_id_c0509776_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `subscription_mysubscription`
--
ALTER TABLE `subscription_mysubscription`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `Subscription_mysubsc_type_id_9fc7e0c6_fk_Subscript` (`type_id`);

--
-- Indexes for table `subscription_pendingpayment`
--
ALTER TABLE `subscription_pendingpayment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Subscription_pending_subscriptions_id_eeb45c7c_fk_Subscript` (`subscriptions_id`),
  ADD KEY `Subscription_pendingpayment_user_id_d08c4237_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `subscription_pendingpayment_beneficiaries`
--
ALTER TABLE `subscription_pendingpayment_beneficiaries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Subscription_pendingpaym_pendingpayment_id_myuser_21a86e96_uniq` (`pendingpayment_id`,`myuser_id`),
  ADD KEY `Subscription_pending_myuser_id_d4b737f2_fk_Users_myu` (`myuser_id`);

--
-- Indexes for table `subscription_stripecardpayments`
--
ALTER TABLE `subscription_stripecardpayments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Subscription_stripec_user_id_747a5633_fk_Users_myu` (`user_id`);

--
-- Indexes for table `subscription_subscriptions`
--
ALTER TABLE `subscription_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`type`);

--
-- Indexes for table `supervisor_filemodel`
--
ALTER TABLE `supervisor_filemodel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supervisor_inquire`
--
ALTER TABLE `supervisor_inquire`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supervisor_questioncount`
--
ALTER TABLE `supervisor_questioncount`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `supervisor_questioncount_quiz`
--
ALTER TABLE `supervisor_questioncount_quiz`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Supervisor_questioncount_questioncount_id_topical_aa373eb3_uniq` (`questioncount_id`,`topicalquizes_id`),
  ADD KEY `Supervisor_questionc_topicalquizes_id_8d2c16ad_fk_Exams_top` (`topicalquizes_id`);

--
-- Indexes for table `supervisor_quizassignment`
--
ALTER TABLE `supervisor_quizassignment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `supervisor_quizassignment_topic`
--
ALTER TABLE `supervisor_quizassignment_topic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Supervisor_quizassignmen_quizassignment_id_topic__49c30020_uniq` (`quizassignment_id`,`topic_id`),
  ADD KEY `Supervisor_quizassig_topic_id_c03ae33e_fk_SubjectLi` (`topic_id`);

--
-- Indexes for table `supervisor_updates`
--
ALTER TABLE `supervisor_updates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teacher_sessionbooking`
--
ALTER TABLE `teacher_sessionbooking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Teacher_sessionbooki_subject_id_443e5558_fk_SubjectLi` (`subject_id`),
  ADD KEY `Teacher_sessionbooking_teacher_id_e8ffb108_fk_Users_myuser_id` (`teacher_id`);

--
-- Indexes for table `teacher_sessionbooking_students`
--
ALTER TABLE `teacher_sessionbooking_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Teacher_sessionbooking_s_sessionbooking_id_myuser_070731c1_uniq` (`sessionbooking_id`,`myuser_id`),
  ADD KEY `Teacher_sessionbooki_myuser_id_ac35d0f4_fk_Users_myu` (`myuser_id`);

--
-- Indexes for table `teacher_studentlist`
--
ALTER TABLE `teacher_studentlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Teacher_studentlist_subject_id_346e35c5_fk_SubjectLi` (`subject_id`),
  ADD KEY `Teacher_studentlist_user_id_1c3d912a_fk_Users_myuser_id` (`user_id`);

--
-- Indexes for table `teacher_studentlist_students`
--
ALTER TABLE `teacher_studentlist_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Teacher_studentlist_stud_studentlist_id_myuser_id_79490a3f_uniq` (`studentlist_id`,`myuser_id`),
  ADD KEY `Teacher_studentlist__myuser_id_171508bb_fk_Users_myu` (`myuser_id`);

--
-- Indexes for table `teacher_teacherprofile`
--
ALTER TABLE `teacher_teacherprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `teacher_teacherprofile_subject`
--
ALTER TABLE `teacher_teacherprofile_subject`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Teacher_teacherprofile_s_teacherprofile_id_subjec_43d0c658_uniq` (`teacherprofile_id`,`subject_id`),
  ADD KEY `Teacher_teacherprofi_subject_id_7f57c70d_fk_SubjectLi` (`subject_id`);

--
-- Indexes for table `teacher_teacherranking`
--
ALTER TABLE `teacher_teacherranking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `users_academicprofile`
--
ALTER TABLE `users_academicprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `Users_academicprofil_current_class_id_9a11ec64_fk_Users_gra` (`current_class_id`);

--
-- Indexes for table `users_grade`
--
ALTER TABLE `users_grade`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `grade` (`grade`);

--
-- Indexes for table `users_myuser`
--
ALTER TABLE `users_myuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uuid` (`uuid`);

--
-- Indexes for table `users_personalprofile`
--
ALTER TABLE `users_personalprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `exams_classteststudenttest`
--
ALTER TABLE `exams_classteststudenttest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams_classtest_quiz`
--
ALTER TABLE `exams_classtest_quiz`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams_generaltest`
--
ALTER TABLE `exams_generaltest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams_generaltest_quiz`
--
ALTER TABLE `exams_generaltest_quiz`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams_studentsanswers`
--
ALTER TABLE `exams_studentsanswers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams_studenttest`
--
ALTER TABLE `exams_studenttest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams_studenttest_quiz`
--
ALTER TABLE `exams_studenttest_quiz`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams_topicalquizanswers`
--
ALTER TABLE `exams_topicalquizanswers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1597;

--
-- AUTO_INCREMENT for table `guardian_mykids`
--
ALTER TABLE `guardian_mykids`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guardian_mykids_kids`
--
ALTER TABLE `guardian_mykids_kids`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_logentry`
--
ALTER TABLE `logs_logentry`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subjectlist_accountinquiries`
--
ALTER TABLE `subjectlist_accountinquiries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_completion`
--
ALTER TABLE `subjectlist_completion`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_course`
--
ALTER TABLE `subjectlist_course`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `subjectlist_mysubjects`
--
ALTER TABLE `subjectlist_mysubjects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_mysubjects_name`
--
ALTER TABLE `subjectlist_mysubjects_name`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_paymentnotifications`
--
ALTER TABLE `subjectlist_paymentnotifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_progress`
--
ALTER TABLE `subjectlist_progress`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_progress_subtopic`
--
ALTER TABLE `subjectlist_progress_subtopic`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_progress_topic`
--
ALTER TABLE `subjectlist_progress_topic`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_prompt`
--
ALTER TABLE `subjectlist_prompt`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_ratelimiter`
--
ALTER TABLE `subjectlist_ratelimiter`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_subject`
--
ALTER TABLE `subjectlist_subject`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `subjectlist_topicalexamresults`
--
ALTER TABLE `subjectlist_topicalexamresults`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjectlist_topicexamnotifications`
--
ALTER TABLE `subjectlist_topicexamnotifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_mpesapayments`
--
ALTER TABLE `subscription_mpesapayments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_mysubscription`
--
ALTER TABLE `subscription_mysubscription`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_pendingpayment`
--
ALTER TABLE `subscription_pendingpayment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_pendingpayment_beneficiaries`
--
ALTER TABLE `subscription_pendingpayment_beneficiaries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_stripecardpayments`
--
ALTER TABLE `subscription_stripecardpayments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_subscriptions`
--
ALTER TABLE `subscription_subscriptions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supervisor_filemodel`
--
ALTER TABLE `supervisor_filemodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supervisor_inquire`
--
ALTER TABLE `supervisor_inquire`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supervisor_questioncount`
--
ALTER TABLE `supervisor_questioncount`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `supervisor_questioncount_quiz`
--
ALTER TABLE `supervisor_questioncount_quiz`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=400;

--
-- AUTO_INCREMENT for table `supervisor_quizassignment`
--
ALTER TABLE `supervisor_quizassignment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `supervisor_quizassignment_topic`
--
ALTER TABLE `supervisor_quizassignment_topic`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `supervisor_updates`
--
ALTER TABLE `supervisor_updates`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_sessionbooking`
--
ALTER TABLE `teacher_sessionbooking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_sessionbooking_students`
--
ALTER TABLE `teacher_sessionbooking_students`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_studentlist`
--
ALTER TABLE `teacher_studentlist`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_studentlist_students`
--
ALTER TABLE `teacher_studentlist_students`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_teacherprofile`
--
ALTER TABLE `teacher_teacherprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_teacherprofile_subject`
--
ALTER TABLE `teacher_teacherprofile_subject`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_teacherranking`
--
ALTER TABLE `teacher_teacherranking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users_academicprofile`
--
ALTER TABLE `users_academicprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_grade`
--
ALTER TABLE `users_grade`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_myuser`
--
ALTER TABLE `users_myuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users_personalprofile`
--
ALTER TABLE `users_personalprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `exams_classtest`
--
ALTER TABLE `exams_classtest`
  ADD CONSTRAINT `Exams_classtest_class_id_id_5dff4e1c_fk_Teacher_studentlist_id` FOREIGN KEY (`class_id_id`) REFERENCES `teacher_studentlist` (`id`),
  ADD CONSTRAINT `Exams_classtest_subject_id_dceb909e_fk_SubjectList_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `Exams_classtest_teacher_id_71727c35_fk_Users_myuser_id` FOREIGN KEY (`teacher_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `exams_classteststudenttest`
--
ALTER TABLE `exams_classteststudenttest`
  ADD CONSTRAINT `Exams_classteststude_test_id_40848729_fk_Exams_cla` FOREIGN KEY (`test_id`) REFERENCES `exams_classtest` (`uuid`),
  ADD CONSTRAINT `Exams_classteststudenttest_user_id_62dc06c9_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `exams_classtest_quiz`
--
ALTER TABLE `exams_classtest_quiz`
  ADD CONSTRAINT `Exams_classtest_quiz_classtest_id_aeb9aece_fk_Exams_cla` FOREIGN KEY (`classtest_id`) REFERENCES `exams_classtest` (`uuid`),
  ADD CONSTRAINT `Exams_classtest_quiz_topicalquizes_id_3e9c5d39_fk_Exams_top` FOREIGN KEY (`topicalquizes_id`) REFERENCES `exams_topicalquizes` (`id`);

--
-- Constraints for table `exams_generaltest`
--
ALTER TABLE `exams_generaltest`
  ADD CONSTRAINT `Exams_generaltest_subject_id_d32150eb_fk_SubjectList_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `Exams_generaltest_user_id_c254cc21_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `exams_generaltest_quiz`
--
ALTER TABLE `exams_generaltest_quiz`
  ADD CONSTRAINT `Exams_generaltest_qu_generaltest_id_c519fdd0_fk_Exams_gen` FOREIGN KEY (`generaltest_id`) REFERENCES `exams_generaltest` (`id`),
  ADD CONSTRAINT `Exams_generaltest_qu_topicalquizes_id_6c36babb_fk_Exams_top` FOREIGN KEY (`topicalquizes_id`) REFERENCES `exams_topicalquizes` (`id`);

--
-- Constraints for table `exams_studentsanswers`
--
ALTER TABLE `exams_studentsanswers`
  ADD CONSTRAINT `Exams_studentsanswer_selection_id_08039437_fk_Exams_top` FOREIGN KEY (`selection_id`) REFERENCES `exams_topicalquizanswers` (`id`),
  ADD CONSTRAINT `Exams_studentsanswer_test_content_type_id_8ef1f088_fk_django_co` FOREIGN KEY (`test_content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `Exams_studentsanswers_quiz_id_22d6f356_fk_Exams_topicalquizes_id` FOREIGN KEY (`quiz_id`) REFERENCES `exams_topicalquizes` (`id`),
  ADD CONSTRAINT `Exams_studentsanswers_user_id_fdf0c627_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `exams_studenttest`
--
ALTER TABLE `exams_studenttest`
  ADD CONSTRAINT `Exams_studenttest_subject_id_693ad2c5_fk_SubjectList_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `Exams_studenttest_topic_id_920f9a0d_fk_SubjectList_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `subjectlist_topic` (`id`),
  ADD CONSTRAINT `Exams_studenttest_user_id_f13e532b_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `exams_studenttest_quiz`
--
ALTER TABLE `exams_studenttest_quiz`
  ADD CONSTRAINT `Exams_studenttest_qu_studenttest_id_f2e73577_fk_Exams_stu` FOREIGN KEY (`studenttest_id`) REFERENCES `exams_studenttest` (`id`),
  ADD CONSTRAINT `Exams_studenttest_qu_topicalquizes_id_e411cc79_fk_Exams_top` FOREIGN KEY (`topicalquizes_id`) REFERENCES `exams_topicalquizes` (`id`);

--
-- Constraints for table `exams_topicalquizanswers`
--
ALTER TABLE `exams_topicalquizanswers`
  ADD CONSTRAINT `Exams_topicalquizans_quiz_id_e63f6f38_fk_Exams_top` FOREIGN KEY (`quiz_id`) REFERENCES `exams_topicalquizes` (`id`);

--
-- Constraints for table `exams_topicalquizes`
--
ALTER TABLE `exams_topicalquizes`
  ADD CONSTRAINT `Exams_topicalquizes_subject_id_501483e2_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `Exams_topicalquizes_subtopic_id_32657004_fk_SubjectLi` FOREIGN KEY (`subtopic_id`) REFERENCES `subjectlist_subtopic` (`id`),
  ADD CONSTRAINT `Exams_topicalquizes_topic_id_8b289a6d_fk_SubjectList_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `subjectlist_topic` (`id`);

--
-- Constraints for table `guardian_mykids`
--
ALTER TABLE `guardian_mykids`
  ADD CONSTRAINT `Guardian_mykids_user_id_0162427c_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `guardian_mykids_kids`
--
ALTER TABLE `guardian_mykids_kids`
  ADD CONSTRAINT `Guardian_mykids_kids_mykids_id_e116cf7a_fk_Guardian_mykids_id` FOREIGN KEY (`mykids_id`) REFERENCES `guardian_mykids` (`id`),
  ADD CONSTRAINT `Guardian_mykids_kids_myuser_id_25a29a40_fk_Users_myuser_id` FOREIGN KEY (`myuser_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `logs_logentry`
--
ALTER TABLE `logs_logentry`
  ADD CONSTRAINT `Logs_logentry_user_id_d42ba64a_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_accountinquiries`
--
ALTER TABLE `subjectlist_accountinquiries`
  ADD CONSTRAINT `SubjectList_accountinquiries_user_id_0469c233_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_completion`
--
ALTER TABLE `subjectlist_completion`
  ADD CONSTRAINT `SubjectList_completi_prompt_id_b07f4f6c_fk_SubjectLi` FOREIGN KEY (`prompt_id`) REFERENCES `subjectlist_prompt` (`id`);

--
-- Constraints for table `subjectlist_mysubjects`
--
ALTER TABLE `subjectlist_mysubjects`
  ADD CONSTRAINT `SubjectList_mysubjects_user_id_12ccf2e4_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_mysubjects_name`
--
ALTER TABLE `subjectlist_mysubjects_name`
  ADD CONSTRAINT `SubjectList_mysubjec_course_id_b4be0e5a_fk_SubjectLi` FOREIGN KEY (`course_id`) REFERENCES `subjectlist_course` (`id`),
  ADD CONSTRAINT `SubjectList_mysubjec_mysubjects_id_821f42e8_fk_SubjectLi` FOREIGN KEY (`mysubjects_id`) REFERENCES `subjectlist_mysubjects` (`id`);

--
-- Constraints for table `subjectlist_paymentnotifications`
--
ALTER TABLE `subjectlist_paymentnotifications`
  ADD CONSTRAINT `SubjectList_paymentn_user_id_462212ae_fk_Users_myu` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_progress`
--
ALTER TABLE `subjectlist_progress`
  ADD CONSTRAINT `SubjectList_progress_subject_id_f0fadb80_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `SubjectList_progress_user_id_ef093ed0_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_progress_subtopic`
--
ALTER TABLE `subjectlist_progress_subtopic`
  ADD CONSTRAINT `SubjectList_progress_progress_id_18a2c072_fk_SubjectLi` FOREIGN KEY (`progress_id`) REFERENCES `subjectlist_progress` (`id`),
  ADD CONSTRAINT `SubjectList_progress_subtopic_id_b69a9544_fk_SubjectLi` FOREIGN KEY (`subtopic_id`) REFERENCES `subjectlist_subtopic` (`id`);

--
-- Constraints for table `subjectlist_progress_topic`
--
ALTER TABLE `subjectlist_progress_topic`
  ADD CONSTRAINT `SubjectList_progress_progress_id_3fc11831_fk_SubjectLi` FOREIGN KEY (`progress_id`) REFERENCES `subjectlist_progress` (`id`),
  ADD CONSTRAINT `SubjectList_progress_topic_id_39e0f3b2_fk_SubjectLi` FOREIGN KEY (`topic_id`) REFERENCES `subjectlist_topic` (`id`);

--
-- Constraints for table `subjectlist_prompt`
--
ALTER TABLE `subjectlist_prompt`
  ADD CONSTRAINT `SubjectList_prompt_user_id_d22c1b3a_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_ratelimiter`
--
ALTER TABLE `subjectlist_ratelimiter`
  ADD CONSTRAINT `SubjectList_ratelimiter_user_id_89237658_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_subject`
--
ALTER TABLE `subjectlist_subject`
  ADD CONSTRAINT `SubjectList_subject_course_id_18ddbe01_fk_SubjectList_course_id` FOREIGN KEY (`course_id`) REFERENCES `subjectlist_course` (`id`);

--
-- Constraints for table `subjectlist_subtopic`
--
ALTER TABLE `subjectlist_subtopic`
  ADD CONSTRAINT `SubjectList_subtopic_subject_id_1eee1b10_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `SubjectList_subtopic_topic_id_c007b43e_fk_SubjectList_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `subjectlist_topic` (`id`);

--
-- Constraints for table `subjectlist_topic`
--
ALTER TABLE `subjectlist_topic`
  ADD CONSTRAINT `SubjectList_topic_subject_id_3c9122ea_fk_SubjectList_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`);

--
-- Constraints for table `subjectlist_topicalexamresults`
--
ALTER TABLE `subjectlist_topicalexamresults`
  ADD CONSTRAINT `SubjectList_topicale_subject_id_44d4d5d7_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `SubjectList_topicale_topic_id_e729201e_fk_SubjectLi` FOREIGN KEY (`topic_id`) REFERENCES `subjectlist_topic` (`id`),
  ADD CONSTRAINT `SubjectList_topicale_user_id_276b95da_fk_Users_myu` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subjectlist_topicexamnotifications`
--
ALTER TABLE `subjectlist_topicexamnotifications`
  ADD CONSTRAINT `SubjectList_topicexa_subject_id_439fcbd6_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `SubjectList_topicexa_topic_id_e7f337f9_fk_SubjectLi` FOREIGN KEY (`topic_id`) REFERENCES `subjectlist_topic` (`id`),
  ADD CONSTRAINT `SubjectList_topicexa_user_id_5194b43e_fk_Users_myu` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subscription_mpesapayments`
--
ALTER TABLE `subscription_mpesapayments`
  ADD CONSTRAINT `Subscription_mpesapa_sub_type_id_8f80d1c7_fk_Subscript` FOREIGN KEY (`sub_type_id`) REFERENCES `subscription_subscriptions` (`id`),
  ADD CONSTRAINT `Subscription_mpesapayments_user_id_c0509776_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subscription_mysubscription`
--
ALTER TABLE `subscription_mysubscription`
  ADD CONSTRAINT `Subscription_mysubsc_type_id_9fc7e0c6_fk_Subscript` FOREIGN KEY (`type_id`) REFERENCES `subscription_subscriptions` (`type`),
  ADD CONSTRAINT `Subscription_mysubscription_user_id_c331a558_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subscription_pendingpayment`
--
ALTER TABLE `subscription_pendingpayment`
  ADD CONSTRAINT `Subscription_pending_subscriptions_id_eeb45c7c_fk_Subscript` FOREIGN KEY (`subscriptions_id`) REFERENCES `subscription_subscriptions` (`id`),
  ADD CONSTRAINT `Subscription_pendingpayment_user_id_d08c4237_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `subscription_pendingpayment_beneficiaries`
--
ALTER TABLE `subscription_pendingpayment_beneficiaries`
  ADD CONSTRAINT `Subscription_pending_myuser_id_d4b737f2_fk_Users_myu` FOREIGN KEY (`myuser_id`) REFERENCES `users_myuser` (`id`),
  ADD CONSTRAINT `Subscription_pending_pendingpayment_id_4b9f0026_fk_Subscript` FOREIGN KEY (`pendingpayment_id`) REFERENCES `subscription_pendingpayment` (`id`);

--
-- Constraints for table `subscription_stripecardpayments`
--
ALTER TABLE `subscription_stripecardpayments`
  ADD CONSTRAINT `Subscription_stripec_user_id_747a5633_fk_Users_myu` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `supervisor_questioncount`
--
ALTER TABLE `supervisor_questioncount`
  ADD CONSTRAINT `Supervisor_questioncount_user_id_b70eab3f_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `supervisor_questioncount_quiz`
--
ALTER TABLE `supervisor_questioncount_quiz`
  ADD CONSTRAINT `Supervisor_questionc_questioncount_id_82975e93_fk_Superviso` FOREIGN KEY (`questioncount_id`) REFERENCES `supervisor_questioncount` (`id`),
  ADD CONSTRAINT `Supervisor_questionc_topicalquizes_id_8d2c16ad_fk_Exams_top` FOREIGN KEY (`topicalquizes_id`) REFERENCES `exams_topicalquizes` (`id`);

--
-- Constraints for table `supervisor_quizassignment`
--
ALTER TABLE `supervisor_quizassignment`
  ADD CONSTRAINT `Supervisor_quizassignment_user_id_70ae5e2d_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `supervisor_quizassignment_topic`
--
ALTER TABLE `supervisor_quizassignment_topic`
  ADD CONSTRAINT `Supervisor_quizassig_quizassignment_id_ea1103ed_fk_Superviso` FOREIGN KEY (`quizassignment_id`) REFERENCES `supervisor_quizassignment` (`id`),
  ADD CONSTRAINT `Supervisor_quizassig_topic_id_c03ae33e_fk_SubjectLi` FOREIGN KEY (`topic_id`) REFERENCES `subjectlist_topic` (`id`);

--
-- Constraints for table `teacher_sessionbooking`
--
ALTER TABLE `teacher_sessionbooking`
  ADD CONSTRAINT `Teacher_sessionbooki_subject_id_443e5558_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `Teacher_sessionbooking_teacher_id_e8ffb108_fk_Users_myuser_id` FOREIGN KEY (`teacher_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `teacher_sessionbooking_students`
--
ALTER TABLE `teacher_sessionbooking_students`
  ADD CONSTRAINT `Teacher_sessionbooki_myuser_id_ac35d0f4_fk_Users_myu` FOREIGN KEY (`myuser_id`) REFERENCES `users_myuser` (`id`),
  ADD CONSTRAINT `Teacher_sessionbooki_sessionbooking_id_2e02ead6_fk_Teacher_s` FOREIGN KEY (`sessionbooking_id`) REFERENCES `teacher_sessionbooking` (`id`);

--
-- Constraints for table `teacher_studentlist`
--
ALTER TABLE `teacher_studentlist`
  ADD CONSTRAINT `Teacher_studentlist_subject_id_346e35c5_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `Teacher_studentlist_user_id_1c3d912a_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `teacher_studentlist_students`
--
ALTER TABLE `teacher_studentlist_students`
  ADD CONSTRAINT `Teacher_studentlist__myuser_id_171508bb_fk_Users_myu` FOREIGN KEY (`myuser_id`) REFERENCES `users_myuser` (`id`),
  ADD CONSTRAINT `Teacher_studentlist__studentlist_id_c5eb9188_fk_Teacher_s` FOREIGN KEY (`studentlist_id`) REFERENCES `teacher_studentlist` (`id`);

--
-- Constraints for table `teacher_teacherprofile`
--
ALTER TABLE `teacher_teacherprofile`
  ADD CONSTRAINT `Teacher_teacherprofile_user_id_8d07ccac_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `teacher_teacherprofile_subject`
--
ALTER TABLE `teacher_teacherprofile_subject`
  ADD CONSTRAINT `Teacher_teacherprofi_subject_id_7f57c70d_fk_SubjectLi` FOREIGN KEY (`subject_id`) REFERENCES `subjectlist_subject` (`id`),
  ADD CONSTRAINT `Teacher_teacherprofi_teacherprofile_id_5f5e6b18_fk_Teacher_t` FOREIGN KEY (`teacherprofile_id`) REFERENCES `teacher_teacherprofile` (`id`);

--
-- Constraints for table `teacher_teacherranking`
--
ALTER TABLE `teacher_teacherranking`
  ADD CONSTRAINT `Teacher_teacherranking_user_id_7503c776_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `users_academicprofile`
--
ALTER TABLE `users_academicprofile`
  ADD CONSTRAINT `Users_academicprofil_current_class_id_9a11ec64_fk_Users_gra` FOREIGN KEY (`current_class_id`) REFERENCES `users_grade` (`id`),
  ADD CONSTRAINT `Users_academicprofile_user_id_b2ff6092_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);

--
-- Constraints for table `users_personalprofile`
--
ALTER TABLE `users_personalprofile`
  ADD CONSTRAINT `Users_personalprofile_user_id_7fedef99_fk_Users_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_myuser` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
