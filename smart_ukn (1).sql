-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1:3307
-- 產生時間： 2026-10-22 05:00:03
-- 伺服器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `smart_ukn`
--

-- --------------------------------------------------------

--
-- 資料表結構 `academic_calendar`
--

CREATE TABLE `academic_calendar` (
  `id` int(11) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `category` varchar(50) NOT NULL DEFAULT '教務',
  `related_checklist_id` int(11) DEFAULT NULL,
  `owner_key` varchar(50) DEFAULT NULL,
  `note` varchar(300) DEFAULT NULL,
  `source` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `academic_calendar`
--

INSERT INTO `academic_calendar` (`id`, `event_name`, `start_date`, `end_date`, `category`, `related_checklist_id`, `owner_key`, `note`, `source`) VALUES
(1, '網路加退選及重補修', '2026-09-14', '2026-09-20', '教務', NULL, NULL, NULL, NULL),
(2, '就學貸款申請、學雜費減免收件', '2026-09-14', '2026-09-15', '繳費', NULL, NULL, NULL, NULL),
(3, '弱勢助學金、學產基金申請', '2026-09-16', '2026-10-01', '獎助', NULL, NULL, NULL, NULL),
(4, '受理棄選（停修）', '2026-11-16', '2026-12-04', '教務', 1, NULL, NULL, NULL),
(5, '網路教學評量填寫', '2026-12-14', '2026-12-20', '教務', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `anniversary_events`
--

CREATE TABLE `anniversary_events` (
  `id` int(11) NOT NULL,
  `name_zh` varchar(100) NOT NULL,
  `name_en` varchar(150) DEFAULT NULL,
  `name_ja` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL COMMENT '校慶當天 (多天活動為第一天)',
  `end_date` date NOT NULL COMMENT '最後一天，隔天起不再顯示',
  `announce_days` int(11) NOT NULL DEFAULT 30 COMMENT '提前幾天開始顯示',
  `require_approval` tinyint(1) NOT NULL DEFAULT 1 COMMENT '匿名祝福是否需審核後才顯示',
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `anniversary_events`
--

INSERT INTO `anniversary_events` (`id`, `name_zh`, `name_en`, `name_ja`, `start_date`, `end_date`, `announce_days`, `require_approval`, `is_enabled`) VALUES
(1, '康寧大學校慶', 'UKN Anniversary Celebration', '康寧大学 創立記念祭', '2026-11-01', '2026-11-01', 30, 1, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `anniversary_wishes`
--

CREATE TABLE `anniversary_wishes` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `message` varchar(100) NOT NULL,
  `lang` varchar(5) NOT NULL DEFAULT 'zh',
  `status` enum('待審核','顯示中','已隱藏') NOT NULL DEFAULT '待審核',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text DEFAULT NULL,
  `office` varchar(50) NOT NULL,
  `publish_date` date NOT NULL,
  `target_class` varchar(50) DEFAULT NULL COMMENT 'NULL = 全校公告',
  `url` varchar(500) NOT NULL DEFAULT '#'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `content`, `office`, `publish_date`, `target_class`, `url`) VALUES
(1, '本學期加退選將於 9/25 (五) 17:00 截止', '請同學於截止前至學生教務系統確認選課結果，逾期不再受理加退選。', '註冊組', '2026-09-22', NULL, '#'),
(2, '獎助學金申請開始受理（至 10/16）', '校內外獎助學金即日起開放線上申請，請備妥清寒證明或成績單等相關文件。', '生輔組', '2026-09-21', NULL, '#'),
(3, '9/25 班會地點改至 A402', '因 A301 投影設備維修，本週五班會改於 A402 舉行，請準時出席。', '資管科辦', '2026-09-23', '資管五忠', '#'),
(4, '圖書館利用講習開放報名', '介紹電子資料庫查詢與館際合作服務，參加可認證學習時數 2 小時。', '圖書館', '2026-09-15', NULL, '#'),
(5, '台北校區 A 棟電梯 9/24 停機保養', '9/24 (四) 08:00-12:00 A 棟電梯停機保養，行動不便同學請洽總務處協助。', '總務處', '2026-09-23', NULL, '#'),
(6, '宿舍晚歸登記改為線上辦理', '即日起晚歸、外宿請於學生專區「宿舍晚歸／外宿請假」線上登記，不再受理紙本。', '學務處', '2026-09-10', NULL, '#'),
(7, '實習前健康檢查 10/2 截止繳交', '請於 10/2 前將健康檢查報告繳交至科辦，未繳交者不得參加下學期臨床實習。', '護理科辦', '2026-09-20', '護理四忠', '#');

-- --------------------------------------------------------

--
-- 資料表結構 `announcement_reads`
--

CREATE TABLE `announcement_reads` (
  `student_id` varchar(20) NOT NULL,
  `announcement_id` int(11) NOT NULL,
  `read_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `announcement_reads`
--

INSERT INTO `announcement_reads` (`student_id`, `announcement_id`, `read_at`) VALUES
('111534117', 6, '2026-10-08 04:17:18'),
('S112001', 4, '2026-09-24 04:10:29'),
('S112001', 6, '2026-09-24 04:10:29'),
('S112002', 1, '2026-09-24 04:10:29'),
('S112002', 2, '2026-09-24 04:10:29'),
('S112002', 4, '2026-09-24 04:10:29');

-- --------------------------------------------------------

--
-- 資料表結構 `assignments`
--

CREATE TABLE `assignments` (
  `id` int(11) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `student_id` varchar(20) DEFAULT NULL,
  `course_name` varchar(100) NOT NULL,
  `title` varchar(200) NOT NULL,
  `due_at` datetime NOT NULL,
  `url` varchar(500) NOT NULL DEFAULT '#'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `assignments`
--

INSERT INTO `assignments` (`id`, `class_name`, `student_id`, `course_name`, `title`, `due_at`, `url`) VALUES
(1, '資管五忠', NULL, '資料結構', '作業一：鏈結串列實作', '2026-09-25 23:59:00', '#'),
(2, '資管五忠', NULL, '資料庫系統概論', 'ER 圖設計報告', '2026-09-30 23:59:00', '#'),
(3, '資管五忠', NULL, '物件導向程式設計', 'Lab 2：類別與封裝', '2026-09-24 12:00:00', '#'),
(4, '資管五忠', NULL, '基礎英文(二)', 'Reading Journal Week 3', '2026-09-22 23:59:00', '#'),
(5, NULL, 'S112001', '程式設計(一)', '重修班：迴圈練習題', '2026-09-28 23:59:00', '#'),
(6, '資管五孝', NULL, '資料結構', '作業一：鏈結串列實作', '2026-09-26 23:59:00', '#'),
(7, '護理四忠', NULL, '藥理學', '常用藥物分類表', '2026-09-29 23:59:00', '#');

-- --------------------------------------------------------

--
-- 資料表結構 `assignment_submissions`
--

CREATE TABLE `assignment_submissions` (
  `student_id` varchar(20) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `assignment_submissions`
--

INSERT INTO `assignment_submissions` (`student_id`, `assignment_id`, `submitted_at`) VALUES
('S112001', 3, '2026-09-24 04:10:29'),
('S112002', 1, '2026-09-24 04:10:29'),
('S112002', 3, '2026-09-24 04:10:29'),
('S112002', 4, '2026-09-24 04:10:29'),
('S112005', 4, '2026-09-24 04:10:29');

-- --------------------------------------------------------

--
-- 資料表結構 `attendance_records`
--

CREATE TABLE `attendance_records` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `type` enum('曠課','遲到','病假','事假','公假','重大傷病假','產假') NOT NULL,
  `notified` tinyint(1) NOT NULL DEFAULT 0,
  `hours` decimal(7,2) DEFAULT NULL,
  `exam_policy` varchar(20) NOT NULL DEFAULT 'ordinary'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `attendance_records`
--

INSERT INTO `attendance_records` (`id`, `student_id`, `date`, `course_name`, `type`, `notified`, `hours`, `exam_policy`) VALUES
(1, 'S112001', '2026-09-14', '程式設計(一)', '曠課', 1, NULL, 'ordinary'),
(2, 'S112001', '2026-09-15', '基礎英文(二)', '遲到', 1, NULL, 'ordinary'),
(3, 'S112001', '2026-09-16', '程式設計(一)', '曠課', 1, NULL, 'ordinary'),
(4, 'S112001', '2026-09-18', '跨領域思維與創新科技', '病假', 1, NULL, 'ordinary'),
(5, 'S112001', '2026-09-21', '程式設計(一)', '曠課', 0, NULL, 'ordinary'),
(6, 'S112001', '2026-09-23', '程式設計(一)', '曠課', 0, NULL, 'ordinary'),
(7, 'S112002', '2026-09-16', '資料庫系統概論', '病假', 1, NULL, 'ordinary'),
(8, 'S112005', '2026-09-15', '資料結構', '曠課', 0, NULL, 'ordinary'),
(9, 'S112005', '2026-09-17', '物件導向程式設計', '遲到', 0, NULL, 'ordinary'),
(157, '115534101', '2026-09-30', '基礎英文(一)', '遲到', 1, NULL, 'ordinary'),
(158, '115534101', '2026-10-05', '基礎英文(一)', '遲到', 1, NULL, 'ordinary'),
(159, '115534102', '2026-09-22', '計算機概論', '曠課', 1, NULL, 'ordinary'),
(160, '115534102', '2026-09-23', '計算機概論', '曠課', 1, NULL, 'ordinary'),
(161, '115534102', '2026-10-01', '計算機概論', '曠課', 1, NULL, 'ordinary'),
(162, '115534102', '2026-10-02', '計算機概論', '曠課', 1, NULL, 'ordinary'),
(163, '115534102', '2026-09-24', '大學之道與校園倫理', '遲到', 1, NULL, 'ordinary'),
(164, '115534102', '2026-10-09', '大學之道與校園倫理', '遲到', 1, NULL, 'ordinary'),
(165, '115534107', '2026-09-17', '計算機概論', '遲到', 1, NULL, 'ordinary'),
(166, '115534107', '2026-09-21', '大學之道與校園倫理', '遲到', 1, NULL, 'ordinary'),
(167, '115534107', '2026-10-08', '大學之道與校園倫理', '遲到', 1, NULL, 'ordinary'),
(168, '115534108', '2026-09-23', '基礎英文(一)', '曠課', 1, NULL, 'ordinary'),
(169, '115534108', '2026-10-06', '基礎英文(一)', '遲到', 1, NULL, 'ordinary'),
(170, '114534101', '2026-09-17', '資料結構', '遲到', 1, NULL, 'ordinary'),
(171, '114534101', '2026-09-21', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(172, '114534101', '2026-09-25', '跨領域思維與創新科技', '病假', 1, NULL, 'ordinary'),
(173, '114534102', '2026-09-15', '資料結構', '曠課', 1, NULL, 'ordinary'),
(174, '114534102', '2026-09-24', '資料結構', '曠課', 1, NULL, 'ordinary'),
(175, '114534102', '2026-09-28', '資料結構', '曠課', 1, NULL, 'ordinary'),
(176, '114534102', '2026-09-30', '資料結構', '曠課', 1, NULL, 'ordinary'),
(177, '114534102', '2026-10-02', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(178, '114534102', '2026-10-09', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(179, '114534105', '2026-09-22', '資料結構', '遲到', 1, NULL, 'ordinary'),
(180, '114534105', '2026-09-23', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(181, '114534105', '2026-09-30', '跨領域思維與創新科技', '病假', 1, NULL, 'ordinary'),
(182, '114534106', '2026-09-15', '資料結構', '曠課', 1, NULL, 'ordinary'),
(183, '114534106', '2026-09-29', '資料結構', '曠課', 1, NULL, 'ordinary'),
(184, '114534106', '2026-10-07', '資料結構', '病假', 1, NULL, 'ordinary'),
(185, '114534107', '2026-09-15', '跨領域思維與創新科技', '病假', 1, NULL, 'ordinary'),
(186, '114534107', '2026-09-28', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(187, '114534108', '2026-09-30', '資料結構', '曠課', 1, NULL, 'ordinary'),
(188, '114534109', '2026-09-23', '資料結構', '病假', 1, NULL, 'ordinary'),
(189, '114534109', '2026-09-25', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(190, '114534109', '2026-09-29', '資料結構', '病假', 1, NULL, 'ordinary'),
(191, '113534101', '2026-09-30', '演算法分析', '遲到', 1, NULL, 'ordinary'),
(192, '113534101', '2026-10-05', '網頁前後端開發實務', '病假', 1, NULL, 'ordinary'),
(193, '113534101', '2026-10-06', '網頁前後端開發實務', '病假', 1, NULL, 'ordinary'),
(194, '113534102', '2026-09-16', '演算法分析', '曠課', 1, NULL, 'ordinary'),
(195, '113534102', '2026-10-02', '演算法分析', '曠課', 1, NULL, 'ordinary'),
(196, '113534102', '2026-10-08', '演算法分析', '曠課', 1, NULL, 'ordinary'),
(197, '113534102', '2026-10-09', '演算法分析', '曠課', 1, NULL, 'ordinary'),
(198, '113534102', '2026-10-05', '網頁前後端開發實務', '遲到', 1, NULL, 'ordinary'),
(199, '113534102', '2026-10-09', '網頁前後端開發實務', '遲到', 1, NULL, 'ordinary'),
(200, '113534105', '2026-10-06', '網頁前後端開發實務', '曠課', 1, NULL, 'ordinary'),
(201, '113534106', '2026-09-14', '網頁前後端開發實務', '曠課', 1, NULL, 'ordinary'),
(202, '113534106', '2026-10-06', '演算法分析', '遲到', 1, NULL, 'ordinary'),
(203, '113534107', '2026-10-02', '演算法分析', '病假', 1, NULL, 'ordinary'),
(204, '113534109', '2026-09-25', '網頁前後端開發實務', '曠課', 1, NULL, 'ordinary'),
(205, '113534109', '2026-10-09', '網頁前後端開發實務', '病假', 1, NULL, 'ordinary'),
(206, '112534101', '2026-10-01', '資料庫系統概論', '病假', 1, NULL, 'ordinary'),
(207, '112534102', '2026-09-17', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(208, '112534102', '2026-09-23', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(209, '112534102', '2026-10-01', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(210, '112534102', '2026-10-09', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(211, '112534102', '2026-09-23', '雲端運算與虛擬化', '遲到', 1, NULL, 'ordinary'),
(212, '112534102', '2026-10-02', '雲端運算與虛擬化', '遲到', 1, NULL, 'ordinary'),
(213, '112534105', '2026-09-22', '雲端運算與虛擬化', '曠課', 1, NULL, 'ordinary'),
(214, '112534108', '2026-09-17', '雲端運算與虛擬化', '病假', 1, NULL, 'ordinary'),
(215, '112534108', '2026-09-18', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(216, '112534108', '2026-09-28', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(217, '112534109', '2026-09-15', '資料庫系統概論', '病假', 1, NULL, 'ordinary'),
(218, '112534109', '2026-09-22', '資料庫系統概論', '病假', 1, NULL, 'ordinary'),
(219, '112534109', '2026-09-30', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(220, '111534101', '2026-09-29', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(221, '111534101', '2026-10-01', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(222, '111534101', '2026-10-09', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(223, '111534102', '2026-10-05', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(224, '111534102', '2026-10-06', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(225, '111534107', '2026-09-16', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(226, '111534107', '2026-10-05', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(227, '111534107', '2026-10-06', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(228, '111534107', '2026-10-07', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(229, '111534107', '2026-09-17', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(230, '111534107', '2026-09-28', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(231, '111534108', '2026-09-29', '物件導向程式設計', '遲到', 1, NULL, 'ordinary'),
(232, '111534108', '2026-10-06', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(233, '111534110', '2026-09-16', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(234, '111534110', '2026-09-21', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(235, '111534110', '2026-10-02', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(236, '111534110', '2026-10-05', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(237, '111534110', '2026-10-07', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(238, '111534110', '2026-10-09', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(239, '111534110', '2026-09-18', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(240, '111534110', '2026-10-07', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(241, '111534111', '2026-09-14', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(242, '111534111', '2026-09-17', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(243, '111534111', '2026-09-22', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(244, '111534111', '2026-09-23', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(245, '111534111', '2026-09-17', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(246, '111534111', '2026-09-18', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(247, '111534112', '2026-09-15', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(248, '111534112', '2026-09-24', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(249, '111534112', '2026-09-25', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(250, '111534112', '2026-09-29', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(251, '111534112', '2026-10-01', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(252, '111534112', '2026-10-06', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(253, '111534112', '2026-10-09', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(254, '111534112', '2026-09-14', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(255, '111534112', '2026-09-15', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(256, '111534112', '2026-09-22', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(257, '111534112', '2026-09-23', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(258, '111534112', '2026-09-25', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(259, '111534112', '2026-10-06', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(260, '111534112', '2026-10-07', '物件導向程式設計', '曠課', 1, NULL, 'ordinary'),
(261, '111534112', '2026-09-14', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(262, '111534112', '2026-09-16', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(263, '111534112', '2026-09-22', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(264, '111534112', '2026-09-24', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(265, '111534112', '2026-10-05', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(266, '111534112', '2026-10-06', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(267, '111534112', '2026-10-08', '基礎英文(二)', '曠課', 1, NULL, 'ordinary'),
(268, '111534112', '2026-09-21', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(269, '111534112', '2026-09-28', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(270, '111534112', '2026-09-29', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(271, '111534112', '2026-10-05', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(272, '111534112', '2026-10-06', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(273, '111534112', '2026-10-08', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(274, '111534112', '2026-10-09', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(275, '111534119', '2026-09-18', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(276, '111534119', '2026-09-21', '物件導向程式設計', '病假', 1, NULL, 'ordinary'),
(277, '111534119', '2026-10-02', '物件導向程式設計', '遲到', 1, NULL, 'ordinary'),
(278, '111534122', '2026-09-17', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(279, '111534122', '2026-09-29', '跨領域思維與創新科技', '病假', 1, NULL, 'ordinary'),
(280, '111534122', '2026-10-07', '基礎英文(二)', '病假', 1, NULL, 'ordinary'),
(281, '111534123', '2026-09-21', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(282, '111534123', '2026-10-01', '資料庫系統概論', '病假', 1, NULL, 'ordinary'),
(283, '111534124', '2026-09-16', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(284, '111534124', '2026-10-08', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(285, '111534125', '2026-09-14', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(286, '111534125', '2026-09-17', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(287, '111534125', '2026-10-06', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(288, '111534201', '2026-09-15', '基礎英文(二)', '病假', 1, NULL, 'ordinary'),
(289, '111534202', '2026-09-17', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(290, '111534202', '2026-09-23', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(291, '111534202', '2026-10-01', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(292, '111534202', '2026-10-09', '資料庫系統概論', '曠課', 1, NULL, 'ordinary'),
(293, '111534202', '2026-09-22', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(294, '111534202', '2026-10-08', '跨領域思維與創新科技', '遲到', 1, NULL, 'ordinary'),
(295, '111534205', '2026-09-17', '基礎英文(二)', '病假', 1, NULL, 'ordinary'),
(296, '111534205', '2026-09-21', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(297, '111534205', '2026-09-25', '物件導向程式設計', '病假', 1, NULL, 'ordinary'),
(298, '111534206', '2026-09-17', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(299, '111534206', '2026-09-28', '跨領域思維與創新科技', '曠課', 1, NULL, 'ordinary'),
(300, '111534207', '2026-09-17', '基礎英文(二)', '遲到', 1, NULL, 'ordinary'),
(301, '111534207', '2026-09-18', '物件導向程式設計', '病假', 1, NULL, 'ordinary'),
(302, '111534208', '2026-09-30', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(303, '111534209', '2026-10-07', '資料庫系統概論', '遲到', 1, NULL, 'ordinary'),
(304, 'S112001', '2026-10-20', '【示範】門檻前17小時', '曠課', 0, 17.00, 'ordinary'),
(305, 'S112001', '2026-10-20', '【示範】達門檻18小時', '曠課', 0, 18.00, 'ordinary'),
(306, 'S112001', '2026-10-20', '【示範】門檻後19小時', '曠課', 0, 19.00, 'ordinary'),
(307, 'S112001', '2026-10-20', '【示範】普通病假18小時', '病假', 0, 18.00, 'ordinary');

-- --------------------------------------------------------

--
-- 資料表結構 `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `record_id` varchar(50) NOT NULL,
  `action` varchar(20) NOT NULL,
  `changed_by` varchar(50) NOT NULL,
  `changed_by_role` varchar(20) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `before_json` longtext DEFAULT NULL,
  `after_json` longtext DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `audit_logs`
--

INSERT INTO `audit_logs` (`log_id`, `table_name`, `record_id`, `action`, `changed_by`, `changed_by_role`, `ip_address`, `before_json`, `after_json`, `changed_at`) VALUES
(1, 'notices', '1', '新增', '彭賓鈺 老師', '老師', NULL, NULL, '{\"class_name\": \"資管五忠\", \"title\": \"10/11 開班會\", \"priority\": \"緊急\", \"whole_class\": true, \"recipients\": [\"111534117\"], \"due_date\": \"2026-10-11\", \"content\": \"請帶筆記本 跟筆\"}', '2026-10-09 17:04:08'),
(2, 'counseling_records', '1', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"student_id\": \"S112001\", \"talk_date\": \"2026-10-20\", \"method\": \"面談\", \"topic\": \"學業\", \"follow_up\": true, \"follow_up_done\": false}', '2026-10-20 01:46:16'),
(3, 'counseling_records', '2', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"student_id\": \"S112002\", \"talk_date\": \"2026-10-20\", \"method\": \"面談\", \"topic\": \"學業\", \"follow_up\": true, \"follow_up_done\": false}', '2026-10-20 01:46:16'),
(4, 'counseling_records', '3', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"student_id\": \"S112001\", \"talk_date\": \"2026-10-20\", \"method\": \"面談\", \"topic\": \"學業\", \"follow_up\": true, \"follow_up_done\": false}', '2026-10-20 01:46:16'),
(5, 'counseling_records', '4', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"student_id\": \"S112002\", \"talk_date\": \"2026-10-20\", \"method\": \"面談\", \"topic\": \"生涯\", \"follow_up\": true, \"follow_up_done\": true}', '2026-10-20 01:46:16'),
(6, 'notices', '3', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"class_name\": \"資管五忠\", \"title\": \"【示範流程】專題討論時間確認（待回覆）\", \"priority\": \"一般\", \"whole_class\": false, \"recipients\": [\"S112001\", \"S112002\"], \"due_date\": \"2026-10-27\", \"content\": \"僅供老師與學生操作展示，並非正式活動或行政通知。請展開本通知，選擇回條後送出；期限前可更新回覆。\"}', '2026-10-20 01:46:16'),
(7, 'notices', '4', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"class_name\": \"資管五忠\", \"title\": \"【示範流程】校園活動參加意願（部分回覆）\", \"priority\": \"一般\", \"whole_class\": false, \"recipients\": [\"S112001\", \"S112002\"], \"due_date\": \"2026-10-27\", \"content\": \"僅供老師與學生操作展示，並非正式活動或行政通知。請展開本通知，選擇回條後送出；期限前可更新回覆。\"}', '2026-10-20 01:46:16'),
(8, 'notices', '5', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"class_name\": \"資管五忠\", \"title\": \"【示範流程】學習資源收件確認（已收齊）\", \"priority\": \"一般\", \"whole_class\": false, \"recipients\": [\"S112001\", \"S112002\"], \"due_date\": \"2026-10-27\", \"content\": \"僅供老師與學生操作展示，並非正式活動或行政通知。請展開本通知，選擇回條後送出；期限前可更新回覆。\"}', '2026-10-20 01:46:16'),
(9, 'counseling_records', '2', '修改', '彭賓鈺 老師', '老師', '127.0.0.1', '{\"student_id\": \"S112002\", \"talk_date\": \"2026-10-20\", \"method\": \"面談\", \"topic\": \"學業\", \"follow_up\": true, \"follow_up_done\": false}', '{\"student_id\": \"S112002\", \"talk_date\": \"2026-10-20\", \"method\": \"面談\", \"topic\": \"學業\", \"follow_up\": true, \"follow_up_done\": true}', '2026-10-20 01:47:48'),
(10, 'notices', '6', '提醒', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"original_notice_id\": 4, \"count\": 1}', '2026-10-20 01:48:12'),
(11, 'attendance_records', '304', '新增', '系統超級管理員', '管理員', '127.0.0.1', NULL, '{\"id\": 304, \"student_id\": \"S112001\", \"date\": \"2026-10-20\", \"course_name\": \"【示範】門檻前17小時\", \"type\": \"曠課\", \"notified\": false, \"hours\": 17.0, \"exam_policy\": \"ordinary\"}', '2026-10-20 02:08:56'),
(12, 'attendance_records', '305', '新增', '系統超級管理員', '管理員', '127.0.0.1', NULL, '{\"id\": 305, \"student_id\": \"S112001\", \"date\": \"2026-10-20\", \"course_name\": \"【示範】達門檻18小時\", \"type\": \"曠課\", \"notified\": false, \"hours\": 18.0, \"exam_policy\": \"ordinary\"}', '2026-10-20 02:08:56'),
(13, 'attendance_records', '306', '新增', '系統超級管理員', '管理員', '127.0.0.1', NULL, '{\"id\": 306, \"student_id\": \"S112001\", \"date\": \"2026-10-20\", \"course_name\": \"【示範】門檻後19小時\", \"type\": \"曠課\", \"notified\": false, \"hours\": 19.0, \"exam_policy\": \"ordinary\"}', '2026-10-20 02:08:56'),
(14, 'attendance_records', '307', '新增', '系統超級管理員', '管理員', '127.0.0.1', NULL, '{\"id\": 307, \"student_id\": \"S112001\", \"date\": \"2026-10-20\", \"course_name\": \"【示範】普通病假18小時\", \"type\": \"病假\", \"notified\": false, \"hours\": 18.0, \"exam_policy\": \"ordinary\"}', '2026-10-20 02:08:56'),
(15, 'leave_requests', '6', '修改', '彭賓鈺 老師', '老師', '127.0.0.1', '{\"status\": \"待審核\"}', '{\"status\": \"已核准\", \"review_note\": \"【示範】假單資料讀取驗證\"}', '2026-10-20 02:08:56'),
(16, 'dorm_applications', '1', '新增', '王小明', '學生', '127.0.0.1', NULL, '{\"student_id\": \"S112001\", \"semester\": \"示範115-1\", \"stage\": 0}', '2026-10-20 02:08:56'),
(17, 'dorm_applications', '1', '修改', '宿舍管理示範員', '教職員', '127.0.0.1', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"已送件\", \"bed\": \"\"}', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"資格審查\", \"bed\": \"DEMO-S305-2\", \"note\": \"【示範】審核與床位分配\"}', '2026-10-20 02:08:57'),
(18, 'dorm_applications', '1', '修改', '宿舍管理示範員', '教職員', '127.0.0.1', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"資格審查\", \"bed\": \"DEMO-S305-2\"}', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"床位排序\", \"bed\": \"DEMO-S305-2\", \"note\": \"【示範】審核與床位分配\"}', '2026-10-20 02:08:57'),
(19, 'dorm_applications', '1', '修改', '宿舍管理示範員', '教職員', '127.0.0.1', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"床位排序\", \"bed\": \"DEMO-S305-2\"}', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"床位分配\", \"bed\": \"DEMO-S305-2\", \"note\": \"【示範】審核與床位分配\"}', '2026-10-20 02:08:57'),
(20, 'dorm_applications', '2', '新增', '李美華', '學生', '127.0.0.1', NULL, '{\"student_id\": \"S112002\", \"semester\": \"示範115-1\", \"stage\": 0}', '2026-10-20 02:08:57'),
(21, 'dorm_applications', '2', '修改', '宿舍管理示範員', '教職員', '127.0.0.1', '{\"name\": \"李美華\", \"student_id\": \"S112002\", \"status\": \"進行中\", \"stage\": \"已送件\", \"bed\": \"\"}', '{\"name\": \"李美華\", \"student_id\": \"S112002\", \"status\": \"未通過\", \"stage\": \"已送件\", \"bed\": \"\", \"note\": \"【示範】文件未齊，展示不通過結果\"}', '2026-10-20 02:08:58'),
(22, 'notices', '7', '新增', '彭賓鈺 老師', '老師', '127.0.0.1', NULL, '{\"class_name\": \"資管五忠\", \"title\": \"出缺勤提醒\", \"priority\": \"緊急\", \"whole_class\": false, \"recipients\": [\"S112001\"], \"due_date\": \"\", \"content\": \"王小明 同學您好：\\n「【示範】門檻後19小時」缺曠課 19 小時，達到扣考門檻，須由任課教師確認；\\n「【示範】普通病假18小時」缺曠課 18 小時，達到扣考門檻，須由任課教師確認；\\n「【示範】達門檻18小時」缺曠課 18 小時，達到扣考門檻，須由任課教師確認；\\n「【示範】門檻前17小時」缺曠課 17 小時，距門檻 1 小時，請核對；\\n「程式設計(一)」缺曠課 12 小時，距門檻 6 小時，請核對。\\n此為缺曠課預警；未提供實際時數的紀錄屬估算，特殊假別及正式扣考須另行確認。\\n請注意出席；如果是請假，記得盡快補辦假單。有困難可以來找導師談。\"}', '2026-10-21 01:29:25'),
(23, 'dorm_applications', '1', '修改', '宿舍管理示範員', '教職員', '127.0.0.1', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"床位分配\", \"bed\": \"DEMO-S305-2\"}', '{\"name\": \"王小明\", \"student_id\": \"S112001\", \"status\": \"進行中\", \"stage\": \"繳交住宿費\", \"bed\": \"DEMO-S305-2\", \"note\": \"【操作示範】確認床位，請依通知辦理繳費。\"}', '2026-10-21 01:30:43'),
(24, 'admin_offices', 'configuration', '修改', '系統超級管理員', '管理員', '127.0.0.1', '{\"members\": {}, \"offices\": [\"教務處\", \"學生事務處\", \"總務處\", \"研究發展處\", \"秘書室\", \"資訊暨圖書中心\", \"會計室\", \"人事室\", \"教學發展暨資源中心\", \"招生中心\", \"體育室\", \"校務研究辦公室\", \"國際暨兩岸事務處\", \"高教深耕辦公室\", \"推廣教育中心\"]}', '{\"members\": {\"demo_office_academic\": \"教務處\", \"demo_office_accounting\": \"會計室\", \"demo_office_admissions\": \"招生中心\", \"demo_office_extension\": \"推廣教育中心\", \"demo_office_general\": \"總務處\", \"demo_office_highered\": \"高教深耕辦公室\", \"demo_office_institutional\": \"校務研究辦公室\", \"demo_office_international\": \"國際暨兩岸事務處\", \"demo_office_library\": \"資訊暨圖書中心\", \"demo_office_personnel\": \"人事室\", \"demo_office_research\": \"研究發展處\", \"demo_office_secretary\": \"秘書室\", \"demo_office_sports\": \"體育室\", \"demo_office_student\": \"學生事務處\", \"demo_office_teaching\": \"教學發展暨資源中心\", \"dorm_demo\": \"學生事務處\", \"staff1\": \"教務處\"}}', '2026-10-21 01:36:14'),
(25, 'admin_cases', '2', '受理案件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 2, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:14\", \"updated_at\": \"2026-10-21 09:36:14\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:14\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 2, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:14\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:14\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:15'),
(26, 'admin_cases', '3', '受理案件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 3, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 3, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:15'),
(27, 'admin_cases', '3', '要求補件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 3, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '{\"id\": 3, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 3, \"requirements\": [\"請補充證明用途\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充證明用途、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:15'),
(28, 'admin_cases', '5', '受理案件', '學生事務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 5, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】學生事務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"獎助資料審查\", \"office\": \"學生事務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"申請項目\": \"【示範】申請項目：操作練習用\", \"資格說明\": \"【示範】資格說明：操作練習用\"}, \"workflow\": [{\"name\": \"資格初審\", \"office\": \"學生事務處\", \"checks\": [\"核對申請資格\", \"核對佐證資料\"]}, {\"name\": \"審查結果確認\", \"office\": \"學生事務處\", \"checks\": [\"確認審查意見\", \"登錄辦理結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"申請表\", \"資格佐證\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"學生事務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 5, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】學生事務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"獎助資料審查\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"申請項目\": \"【示範】申請項目：操作練習用\", \"資格說明\": \"【示範】資格說明：操作練習用\"}, \"workflow\": [{\"name\": \"資格初審\", \"office\": \"學生事務處\", \"checks\": [\"核對申請資格\", \"核對佐證資料\"]}, {\"name\": \"審查結果確認\", \"office\": \"學生事務處\", \"checks\": [\"確認審查意見\", \"登錄辦理結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"申請表\", \"資格佐證\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"學生事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"學生事務處示範承辦人\", \"username\": \"demo_office_student\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\"}], \"files\": []}', '2026-10-21 01:36:15'),
(29, 'admin_cases', '6', '受理案件', '學生事務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 6, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】學生事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"獎助資料審查\", \"office\": \"學生事務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"申請項目\": \"【示範】申請項目：操作練習用\", \"資格說明\": \"【示範】資格說明：操作練習用\"}, \"workflow\": [{\"name\": \"資格初審\", \"office\": \"學生事務處\", \"checks\": [\"核對申請資格\", \"核對佐證資料\"]}, {\"name\": \"審查結果確認\", \"office\": \"學生事務處\", \"checks\": [\"確認審查意見\", \"登錄辦理結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"申請表\", \"資格佐證\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"學生事務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 6, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】學生事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"獎助資料審查\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"申請項目\": \"【示範】申請項目：操作練習用\", \"資格說明\": \"【示範】資格說明：操作練習用\"}, \"workflow\": [{\"name\": \"資格初審\", \"office\": \"學生事務處\", \"checks\": [\"核對申請資格\", \"核對佐證資料\"]}, {\"name\": \"審查結果確認\", \"office\": \"學生事務處\", \"checks\": [\"確認審查意見\", \"登錄辦理結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"申請表\", \"資格佐證\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"學生事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"學生事務處示範承辦人\", \"username\": \"demo_office_student\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\"}], \"files\": []}', '2026-10-21 01:36:15'),
(30, 'admin_cases', '6', '要求補件', '學生事務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 6, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】學生事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"獎助資料審查\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"申請項目\": \"【示範】申請項目：操作練習用\", \"資格說明\": \"【示範】資格說明：操作練習用\"}, \"workflow\": [{\"name\": \"資格初審\", \"office\": \"學生事務處\", \"checks\": [\"核對申請資格\", \"核對佐證資料\"]}, {\"name\": \"審查結果確認\", \"office\": \"學生事務處\", \"checks\": [\"確認審查意見\", \"登錄辦理結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"申請表\", \"資格佐證\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"學生事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"學生事務處示範承辦人\", \"username\": \"demo_office_student\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\"}], \"files\": []}', '{\"id\": 6, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】學生事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"獎助資料審查\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"申請項目\": \"【示範】申請項目：操作練習用\", \"資格說明\": \"【示範】資格說明：操作練習用\"}, \"workflow\": [{\"name\": \"資格初審\", \"office\": \"學生事務處\", \"checks\": [\"核對申請資格\", \"核對佐證資料\"]}, {\"name\": \"審查結果確認\", \"office\": \"學生事務處\", \"checks\": [\"確認審查意見\", \"登錄辦理結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"申請表\", \"資格佐證\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 3, \"requirements\": [\"請補充申請項目\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"學生事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"學生事務處示範承辦人\", \"username\": \"demo_office_student\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\"}, {\"at\": \"2026-10-21 09:36:15\", \"actor\": \"學生事務處示範承辦人\", \"username\": \"demo_office_student\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充申請項目、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"學生事務處\", \"assignee\": \"demo_office_student\"}], \"files\": []}', '2026-10-21 01:36:15'),
(31, 'admin_cases', '8', '受理案件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 8, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】總務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"【示範】設備位置：操作練習用\", \"故障情形\": \"【示範】故障情形：操作練習用\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:15\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 8, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】總務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"【示範】設備位置：操作練習用\", \"故障情形\": \"【示範】故障情形：操作練習用\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:15\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:15\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:36:16'),
(32, 'admin_cases', '9', '受理案件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 9, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】總務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"【示範】設備位置：操作練習用\", \"故障情形\": \"【示範】故障情形：操作練習用\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 9, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】總務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"【示範】設備位置：操作練習用\", \"故障情形\": \"【示範】故障情形：操作練習用\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:36:16'),
(33, 'admin_cases', '9', '要求補件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 9, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】總務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"【示範】設備位置：操作練習用\", \"故障情形\": \"【示範】故障情形：操作練習用\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '{\"id\": 9, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】總務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"【示範】設備位置：操作練習用\", \"故障情形\": \"【示範】故障情形：操作練習用\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 3, \"requirements\": [\"請補充設備位置\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充設備位置、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:36:16'),
(34, 'admin_cases', '11', '受理案件', '研究發展處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 11, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】研究發展處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"實習文件審查\", \"office\": \"研究發展處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"實習單位\": \"【示範】實習單位：操作練習用\", \"預計實習期間\": \"【示範】預計實習期間：操作練習用\"}, \"workflow\": [{\"name\": \"實習資料檢核\", \"office\": \"研究發展處\", \"checks\": [\"確認實習資料\", \"確認聯繫窗口\"]}, {\"name\": \"實習安排確認\", \"office\": \"研究發展處\", \"checks\": [\"確認安排與申請一致\", \"記錄後續聯繫事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"實習計畫\", \"單位聯繫資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"研究發展處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 11, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】研究發展處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"實習文件審查\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"實習單位\": \"【示範】實習單位：操作練習用\", \"預計實習期間\": \"【示範】預計實習期間：操作練習用\"}, \"workflow\": [{\"name\": \"實習資料檢核\", \"office\": \"研究發展處\", \"checks\": [\"確認實習資料\", \"確認聯繫窗口\"]}, {\"name\": \"實習安排確認\", \"office\": \"研究發展處\", \"checks\": [\"確認安排與申請一致\", \"記錄後續聯繫事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"實習計畫\", \"單位聯繫資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"研究發展處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"研究發展處示範承辦人\", \"username\": \"demo_office_research\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\"}], \"files\": []}', '2026-10-21 01:36:16'),
(35, 'admin_cases', '12', '受理案件', '研究發展處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 12, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】研究發展處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"實習文件審查\", \"office\": \"研究發展處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"實習單位\": \"【示範】實習單位：操作練習用\", \"預計實習期間\": \"【示範】預計實習期間：操作練習用\"}, \"workflow\": [{\"name\": \"實習資料檢核\", \"office\": \"研究發展處\", \"checks\": [\"確認實習資料\", \"確認聯繫窗口\"]}, {\"name\": \"實習安排確認\", \"office\": \"研究發展處\", \"checks\": [\"確認安排與申請一致\", \"記錄後續聯繫事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"實習計畫\", \"單位聯繫資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"研究發展處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 12, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】研究發展處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"實習文件審查\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"實習單位\": \"【示範】實習單位：操作練習用\", \"預計實習期間\": \"【示範】預計實習期間：操作練習用\"}, \"workflow\": [{\"name\": \"實習資料檢核\", \"office\": \"研究發展處\", \"checks\": [\"確認實習資料\", \"確認聯繫窗口\"]}, {\"name\": \"實習安排確認\", \"office\": \"研究發展處\", \"checks\": [\"確認安排與申請一致\", \"記錄後續聯繫事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"實習計畫\", \"單位聯繫資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"研究發展處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"研究發展處示範承辦人\", \"username\": \"demo_office_research\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\"}], \"files\": []}', '2026-10-21 01:36:16'),
(36, 'admin_cases', '12', '要求補件', '研究發展處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 12, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】研究發展處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"實習文件審查\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"實習單位\": \"【示範】實習單位：操作練習用\", \"預計實習期間\": \"【示範】預計實習期間：操作練習用\"}, \"workflow\": [{\"name\": \"實習資料檢核\", \"office\": \"研究發展處\", \"checks\": [\"確認實習資料\", \"確認聯繫窗口\"]}, {\"name\": \"實習安排確認\", \"office\": \"研究發展處\", \"checks\": [\"確認安排與申請一致\", \"記錄後續聯繫事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"實習計畫\", \"單位聯繫資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"研究發展處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"研究發展處示範承辦人\", \"username\": \"demo_office_research\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\"}], \"files\": []}', '{\"id\": 12, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】研究發展處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"實習文件審查\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"實習單位\": \"【示範】實習單位：操作練習用\", \"預計實習期間\": \"【示範】預計實習期間：操作練習用\"}, \"workflow\": [{\"name\": \"實習資料檢核\", \"office\": \"研究發展處\", \"checks\": [\"確認實習資料\", \"確認聯繫窗口\"]}, {\"name\": \"實習安排確認\", \"office\": \"研究發展處\", \"checks\": [\"確認安排與申請一致\", \"記錄後續聯繫事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"實習計畫\", \"單位聯繫資料\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 3, \"requirements\": [\"請補充實習單位\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"研究發展處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"研究發展處示範承辦人\", \"username\": \"demo_office_research\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\"}, {\"at\": \"2026-10-21 09:36:16\", \"actor\": \"研究發展處示範承辦人\", \"username\": \"demo_office_research\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充實習單位、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"研究發展處\", \"assignee\": \"demo_office_research\"}], \"files\": []}', '2026-10-21 01:36:16'),
(37, 'admin_cases', '14', '受理案件', '秘書室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 14, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】秘書室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務公文諮詢\", \"office\": \"秘書室\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"來文主旨\": \"【示範】來文主旨：操作練習用\", \"洽詢事項\": \"【示範】洽詢事項：操作練習用\"}, \"workflow\": [{\"name\": \"收件與業務判別\", \"office\": \"秘書室\", \"checks\": [\"確認洽詢內容\", \"確認承辦窗口\"]}, {\"name\": \"回覆與歸檔\", \"office\": \"秘書室\", \"checks\": [\"確認回覆內容\", \"保留辦理紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"相關來文或說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:16\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"秘書室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 14, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】秘書室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務公文諮詢\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"來文主旨\": \"【示範】來文主旨：操作練習用\", \"洽詢事項\": \"【示範】洽詢事項：操作練習用\"}, \"workflow\": [{\"name\": \"收件與業務判別\", \"office\": \"秘書室\", \"checks\": [\"確認洽詢內容\", \"確認承辦窗口\"]}, {\"name\": \"回覆與歸檔\", \"office\": \"秘書室\", \"checks\": [\"確認回覆內容\", \"保留辦理紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"相關來文或說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:16\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:16\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"秘書室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"秘書室示範承辦人\", \"username\": \"demo_office_secretary\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\"}], \"files\": []}', '2026-10-21 01:36:17'),
(38, 'admin_cases', '15', '受理案件', '秘書室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 15, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】秘書室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務公文諮詢\", \"office\": \"秘書室\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"來文主旨\": \"【示範】來文主旨：操作練習用\", \"洽詢事項\": \"【示範】洽詢事項：操作練習用\"}, \"workflow\": [{\"name\": \"收件與業務判別\", \"office\": \"秘書室\", \"checks\": [\"確認洽詢內容\", \"確認承辦窗口\"]}, {\"name\": \"回覆與歸檔\", \"office\": \"秘書室\", \"checks\": [\"確認回覆內容\", \"保留辦理紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"相關來文或說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"秘書室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 15, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】秘書室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務公文諮詢\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"來文主旨\": \"【示範】來文主旨：操作練習用\", \"洽詢事項\": \"【示範】洽詢事項：操作練習用\"}, \"workflow\": [{\"name\": \"收件與業務判別\", \"office\": \"秘書室\", \"checks\": [\"確認洽詢內容\", \"確認承辦窗口\"]}, {\"name\": \"回覆與歸檔\", \"office\": \"秘書室\", \"checks\": [\"確認回覆內容\", \"保留辦理紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"相關來文或說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"秘書室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"秘書室示範承辦人\", \"username\": \"demo_office_secretary\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\"}], \"files\": []}', '2026-10-21 01:36:17'),
(39, 'admin_cases', '15', '要求補件', '秘書室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 15, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】秘書室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務公文諮詢\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"來文主旨\": \"【示範】來文主旨：操作練習用\", \"洽詢事項\": \"【示範】洽詢事項：操作練習用\"}, \"workflow\": [{\"name\": \"收件與業務判別\", \"office\": \"秘書室\", \"checks\": [\"確認洽詢內容\", \"確認承辦窗口\"]}, {\"name\": \"回覆與歸檔\", \"office\": \"秘書室\", \"checks\": [\"確認回覆內容\", \"保留辦理紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"相關來文或說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"秘書室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"秘書室示範承辦人\", \"username\": \"demo_office_secretary\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\"}], \"files\": []}', '{\"id\": 15, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】秘書室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務公文諮詢\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"來文主旨\": \"【示範】來文主旨：操作練習用\", \"洽詢事項\": \"【示範】洽詢事項：操作練習用\"}, \"workflow\": [{\"name\": \"收件與業務判別\", \"office\": \"秘書室\", \"checks\": [\"確認洽詢內容\", \"確認承辦窗口\"]}, {\"name\": \"回覆與歸檔\", \"office\": \"秘書室\", \"checks\": [\"確認回覆內容\", \"保留辦理紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"相關來文或說明\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 3, \"requirements\": [\"請補充來文主旨\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"秘書室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"秘書室示範承辦人\", \"username\": \"demo_office_secretary\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"秘書室示範承辦人\", \"username\": \"demo_office_secretary\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充來文主旨、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"秘書室\", \"assignee\": \"demo_office_secretary\"}], \"files\": []}', '2026-10-21 01:36:17');
INSERT INTO `audit_logs` (`log_id`, `table_name`, `record_id`, `action`, `changed_by`, `changed_by_role`, `ip_address`, `before_json`, `after_json`, `changed_at`) VALUES
(40, 'admin_cases', '17', '受理案件', '資訊暨圖書中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 17, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】資訊暨圖書中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校園帳號與資源服務\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"服務項目\": \"【示範】服務項目：操作練習用\", \"使用情境\": \"【示範】使用情境：操作練習用\"}, \"workflow\": [{\"name\": \"問題分類與身分確認\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"核對申請人身分\", \"確認服務項目\"]}, {\"name\": \"服務處理\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"記錄處理步驟\", \"確認服務可使用\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"回覆使用方式\", \"記錄確認結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"問題畫面或說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 17, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】資訊暨圖書中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校園帳號與資源服務\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"服務項目\": \"【示範】服務項目：操作練習用\", \"使用情境\": \"【示範】使用情境：操作練習用\"}, \"workflow\": [{\"name\": \"問題分類與身分確認\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"核對申請人身分\", \"確認服務項目\"]}, {\"name\": \"服務處理\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"記錄處理步驟\", \"確認服務可使用\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"回覆使用方式\", \"記錄確認結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"問題畫面或說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"資訊暨圖書中心示範承辦人\", \"username\": \"demo_office_library\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\"}], \"files\": []}', '2026-10-21 01:36:17'),
(41, 'admin_cases', '18', '受理案件', '資訊暨圖書中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 18, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】資訊暨圖書中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校園帳號與資源服務\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"服務項目\": \"【示範】服務項目：操作練習用\", \"使用情境\": \"【示範】使用情境：操作練習用\"}, \"workflow\": [{\"name\": \"問題分類與身分確認\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"核對申請人身分\", \"確認服務項目\"]}, {\"name\": \"服務處理\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"記錄處理步驟\", \"確認服務可使用\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"回覆使用方式\", \"記錄確認結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"問題畫面或說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 18, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】資訊暨圖書中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校園帳號與資源服務\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"服務項目\": \"【示範】服務項目：操作練習用\", \"使用情境\": \"【示範】使用情境：操作練習用\"}, \"workflow\": [{\"name\": \"問題分類與身分確認\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"核對申請人身分\", \"確認服務項目\"]}, {\"name\": \"服務處理\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"記錄處理步驟\", \"確認服務可使用\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"回覆使用方式\", \"記錄確認結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"問題畫面或說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"資訊暨圖書中心示範承辦人\", \"username\": \"demo_office_library\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\"}], \"files\": []}', '2026-10-21 01:36:17'),
(42, 'admin_cases', '18', '要求補件', '資訊暨圖書中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 18, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】資訊暨圖書中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校園帳號與資源服務\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"服務項目\": \"【示範】服務項目：操作練習用\", \"使用情境\": \"【示範】使用情境：操作練習用\"}, \"workflow\": [{\"name\": \"問題分類與身分確認\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"核對申請人身分\", \"確認服務項目\"]}, {\"name\": \"服務處理\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"記錄處理步驟\", \"確認服務可使用\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"回覆使用方式\", \"記錄確認結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"問題畫面或說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"資訊暨圖書中心示範承辦人\", \"username\": \"demo_office_library\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\"}], \"files\": []}', '{\"id\": 18, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】資訊暨圖書中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校園帳號與資源服務\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"服務項目\": \"【示範】服務項目：操作練習用\", \"使用情境\": \"【示範】使用情境：操作練習用\"}, \"workflow\": [{\"name\": \"問題分類與身分確認\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"核對申請人身分\", \"確認服務項目\"]}, {\"name\": \"服務處理\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"記錄處理步驟\", \"確認服務可使用\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"資訊暨圖書中心\", \"checks\": [\"回覆使用方式\", \"記錄確認結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"問題畫面或說明\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:17\", \"updated_at\": \"2026-10-21 09:36:17\", \"revision\": 3, \"requirements\": [\"請補充服務項目\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:17\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"資訊暨圖書中心示範承辦人\", \"username\": \"demo_office_library\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\"}, {\"at\": \"2026-10-21 09:36:17\", \"actor\": \"資訊暨圖書中心示範承辦人\", \"username\": \"demo_office_library\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充服務項目、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"資訊暨圖書中心\", \"assignee\": \"demo_office_library\"}], \"files\": []}', '2026-10-21 01:36:17'),
(43, 'admin_cases', '20', '受理案件', '會計室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 20, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】會計室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"經費核銷資料檢核\", \"office\": \"會計室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"經費來源\": \"【示範】經費來源：操作練習用\", \"金額與用途\": \"【示範】金額與用途：操作練習用\"}, \"workflow\": [{\"name\": \"憑證初核\", \"office\": \"會計室\", \"checks\": [\"確認支出用途\", \"確認憑證完整\"]}, {\"name\": \"預算與科目核對\", \"office\": \"會計室\", \"checks\": [\"核對經費來源\", \"確認會計科目\"]}, {\"name\": \"核對結果登錄\", \"office\": \"會計室\", \"checks\": [\"登錄檢核結果\", \"交付後續辦理事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"支出說明\", \"收據或發票影本\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:18\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"會計室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 20, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】會計室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"經費核銷資料檢核\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"經費來源\": \"【示範】經費來源：操作練習用\", \"金額與用途\": \"【示範】金額與用途：操作練習用\"}, \"workflow\": [{\"name\": \"憑證初核\", \"office\": \"會計室\", \"checks\": [\"確認支出用途\", \"確認憑證完整\"]}, {\"name\": \"預算與科目核對\", \"office\": \"會計室\", \"checks\": [\"核對經費來源\", \"確認會計科目\"]}, {\"name\": \"核對結果登錄\", \"office\": \"會計室\", \"checks\": [\"登錄檢核結果\", \"交付後續辦理事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"支出說明\", \"收據或發票影本\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:18\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"會計室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:18\", \"actor\": \"會計室示範承辦人\", \"username\": \"demo_office_accounting\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\"}], \"files\": []}', '2026-10-21 01:36:18'),
(44, 'admin_cases', '21', '受理案件', '會計室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 21, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】會計室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"經費核銷資料檢核\", \"office\": \"會計室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"經費來源\": \"【示範】經費來源：操作練習用\", \"金額與用途\": \"【示範】金額與用途：操作練習用\"}, \"workflow\": [{\"name\": \"憑證初核\", \"office\": \"會計室\", \"checks\": [\"確認支出用途\", \"確認憑證完整\"]}, {\"name\": \"預算與科目核對\", \"office\": \"會計室\", \"checks\": [\"核對經費來源\", \"確認會計科目\"]}, {\"name\": \"核對結果登錄\", \"office\": \"會計室\", \"checks\": [\"登錄檢核結果\", \"交付後續辦理事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"支出說明\", \"收據或發票影本\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:18\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"會計室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 21, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】會計室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"經費核銷資料檢核\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"經費來源\": \"【示範】經費來源：操作練習用\", \"金額與用途\": \"【示範】金額與用途：操作練習用\"}, \"workflow\": [{\"name\": \"憑證初核\", \"office\": \"會計室\", \"checks\": [\"確認支出用途\", \"確認憑證完整\"]}, {\"name\": \"預算與科目核對\", \"office\": \"會計室\", \"checks\": [\"核對經費來源\", \"確認會計科目\"]}, {\"name\": \"核對結果登錄\", \"office\": \"會計室\", \"checks\": [\"登錄檢核結果\", \"交付後續辦理事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"支出說明\", \"收據或發票影本\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:18\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"會計室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:18\", \"actor\": \"會計室示範承辦人\", \"username\": \"demo_office_accounting\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\"}], \"files\": []}', '2026-10-21 01:36:18'),
(45, 'admin_cases', '21', '要求補件', '會計室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 21, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】會計室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"經費核銷資料檢核\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"經費來源\": \"【示範】經費來源：操作練習用\", \"金額與用途\": \"【示範】金額與用途：操作練習用\"}, \"workflow\": [{\"name\": \"憑證初核\", \"office\": \"會計室\", \"checks\": [\"確認支出用途\", \"確認憑證完整\"]}, {\"name\": \"預算與科目核對\", \"office\": \"會計室\", \"checks\": [\"核對經費來源\", \"確認會計科目\"]}, {\"name\": \"核對結果登錄\", \"office\": \"會計室\", \"checks\": [\"登錄檢核結果\", \"交付後續辦理事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"支出說明\", \"收據或發票影本\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:18\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"會計室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:18\", \"actor\": \"會計室示範承辦人\", \"username\": \"demo_office_accounting\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\"}], \"files\": []}', '{\"id\": 21, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】會計室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"經費核銷資料檢核\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"經費來源\": \"【示範】經費來源：操作練習用\", \"金額與用途\": \"【示範】金額與用途：操作練習用\"}, \"workflow\": [{\"name\": \"憑證初核\", \"office\": \"會計室\", \"checks\": [\"確認支出用途\", \"確認憑證完整\"]}, {\"name\": \"預算與科目核對\", \"office\": \"會計室\", \"checks\": [\"核對經費來源\", \"確認會計科目\"]}, {\"name\": \"核對結果登錄\", \"office\": \"會計室\", \"checks\": [\"登錄檢核結果\", \"交付後續辦理事項\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"支出說明\", \"收據或發票影本\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:18\", \"revision\": 3, \"requirements\": [\"請補充經費來源\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"會計室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:18\", \"actor\": \"會計室示範承辦人\", \"username\": \"demo_office_accounting\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\"}, {\"at\": \"2026-10-21 09:36:18\", \"actor\": \"會計室示範承辦人\", \"username\": \"demo_office_accounting\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充經費來源、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"會計室\", \"assignee\": \"demo_office_accounting\"}], \"files\": []}', '2026-10-21 01:36:18'),
(46, 'admin_cases', '23', '受理案件', '人事室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 23, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】人事室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"教職員在職證明申請\", \"office\": \"人事室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"申請用途\": \"【示範】申請用途：操作練習用\", \"領取方式\": \"【示範】領取方式：操作練習用\"}, \"workflow\": [{\"name\": \"人員資料確認\", \"office\": \"人事室\", \"checks\": [\"核對教職員身分\", \"確認用途\"]}, {\"name\": \"證明製發與交付\", \"office\": \"人事室\", \"checks\": [\"核對證明內容\", \"登錄交付結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分確認資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:18\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"人事室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 23, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】人事室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"教職員在職證明申請\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"申請用途\": \"【示範】申請用途：操作練習用\", \"領取方式\": \"【示範】領取方式：操作練習用\"}, \"workflow\": [{\"name\": \"人員資料確認\", \"office\": \"人事室\", \"checks\": [\"核對教職員身分\", \"確認用途\"]}, {\"name\": \"證明製發與交付\", \"office\": \"人事室\", \"checks\": [\"核對證明內容\", \"登錄交付結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分確認資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:18\", \"updated_at\": \"2026-10-21 09:36:19\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:18\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"人事室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:19\", \"actor\": \"人事室示範承辦人\", \"username\": \"demo_office_personnel\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\"}], \"files\": []}', '2026-10-21 01:36:19'),
(47, 'admin_cases', '24', '受理案件', '人事室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 24, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】人事室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"教職員在職證明申請\", \"office\": \"人事室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"申請用途\": \"【示範】申請用途：操作練習用\", \"領取方式\": \"【示範】領取方式：操作練習用\"}, \"workflow\": [{\"name\": \"人員資料確認\", \"office\": \"人事室\", \"checks\": [\"核對教職員身分\", \"確認用途\"]}, {\"name\": \"證明製發與交付\", \"office\": \"人事室\", \"checks\": [\"核對證明內容\", \"登錄交付結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分確認資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:19\", \"updated_at\": \"2026-10-21 09:36:19\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:19\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"人事室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 24, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】人事室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"教職員在職證明申請\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"申請用途\": \"【示範】申請用途：操作練習用\", \"領取方式\": \"【示範】領取方式：操作練習用\"}, \"workflow\": [{\"name\": \"人員資料確認\", \"office\": \"人事室\", \"checks\": [\"核對教職員身分\", \"確認用途\"]}, {\"name\": \"證明製發與交付\", \"office\": \"人事室\", \"checks\": [\"核對證明內容\", \"登錄交付結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分確認資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:19\", \"updated_at\": \"2026-10-21 09:36:19\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:19\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"人事室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:19\", \"actor\": \"人事室示範承辦人\", \"username\": \"demo_office_personnel\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\"}], \"files\": []}', '2026-10-21 01:36:19'),
(48, 'admin_cases', '24', '要求補件', '人事室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 24, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】人事室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"教職員在職證明申請\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"申請用途\": \"【示範】申請用途：操作練習用\", \"領取方式\": \"【示範】領取方式：操作練習用\"}, \"workflow\": [{\"name\": \"人員資料確認\", \"office\": \"人事室\", \"checks\": [\"核對教職員身分\", \"確認用途\"]}, {\"name\": \"證明製發與交付\", \"office\": \"人事室\", \"checks\": [\"核對證明內容\", \"登錄交付結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分確認資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:19\", \"updated_at\": \"2026-10-21 09:36:19\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:19\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"人事室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:19\", \"actor\": \"人事室示範承辦人\", \"username\": \"demo_office_personnel\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\"}], \"files\": []}', '{\"id\": 24, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】人事室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"教職員在職證明申請\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"申請用途\": \"【示範】申請用途：操作練習用\", \"領取方式\": \"【示範】領取方式：操作練習用\"}, \"workflow\": [{\"name\": \"人員資料確認\", \"office\": \"人事室\", \"checks\": [\"核對教職員身分\", \"確認用途\"]}, {\"name\": \"證明製發與交付\", \"office\": \"人事室\", \"checks\": [\"核對證明內容\", \"登錄交付結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分確認資料\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:19\", \"updated_at\": \"2026-10-21 09:36:19\", \"revision\": 3, \"requirements\": [\"請補充申請用途\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:19\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"人事室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:19\", \"actor\": \"人事室示範承辦人\", \"username\": \"demo_office_personnel\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\"}, {\"at\": \"2026-10-21 09:36:19\", \"actor\": \"人事室示範承辦人\", \"username\": \"demo_office_personnel\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充申請用途、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"人事室\", \"assignee\": \"demo_office_personnel\"}], \"files\": []}', '2026-10-21 01:36:19'),
(49, 'admin_cases', '26', '受理案件', '教學發展暨資源中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 26, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教學發展暨資源中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學習資源支援申請\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"資源需求\": \"【示範】資源需求：操作練習用\", \"使用期間\": \"【示範】使用期間：操作練習用\"}, \"workflow\": [{\"name\": \"需求確認\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認需求與使用對象\", \"確認使用期間\"]}, {\"name\": \"資源安排\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認可提供資源\", \"記錄安排內容\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:19\", \"updated_at\": \"2026-10-21 09:36:19\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:19\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 26, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教學發展暨資源中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學習資源支援申請\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"資源需求\": \"【示範】資源需求：操作練習用\", \"使用期間\": \"【示範】使用期間：操作練習用\"}, \"workflow\": [{\"name\": \"需求確認\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認需求與使用對象\", \"確認使用期間\"]}, {\"name\": \"資源安排\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認可提供資源\", \"記錄安排內容\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:19\", \"updated_at\": \"2026-10-21 09:36:20\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:19\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:20\", \"actor\": \"教學發展暨資源中心示範承辦人\", \"username\": \"demo_office_teaching\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\"}], \"files\": []}', '2026-10-21 01:36:20'),
(50, 'admin_cases', '27', '受理案件', '教學發展暨資源中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 27, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教學發展暨資源中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學習資源支援申請\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"資源需求\": \"【示範】資源需求：操作練習用\", \"使用期間\": \"【示範】使用期間：操作練習用\"}, \"workflow\": [{\"name\": \"需求確認\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認需求與使用對象\", \"確認使用期間\"]}, {\"name\": \"資源安排\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認可提供資源\", \"記錄安排內容\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:20\", \"updated_at\": \"2026-10-21 09:36:20\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:20\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 27, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教學發展暨資源中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學習資源支援申請\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"資源需求\": \"【示範】資源需求：操作練習用\", \"使用期間\": \"【示範】使用期間：操作練習用\"}, \"workflow\": [{\"name\": \"需求確認\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認需求與使用對象\", \"確認使用期間\"]}, {\"name\": \"資源安排\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認可提供資源\", \"記錄安排內容\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:20\", \"updated_at\": \"2026-10-21 09:36:20\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:20\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:20\", \"actor\": \"教學發展暨資源中心示範承辦人\", \"username\": \"demo_office_teaching\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\"}], \"files\": []}', '2026-10-21 01:36:20'),
(51, 'admin_cases', '27', '要求補件', '教學發展暨資源中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 27, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教學發展暨資源中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學習資源支援申請\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"資源需求\": \"【示範】資源需求：操作練習用\", \"使用期間\": \"【示範】使用期間：操作練習用\"}, \"workflow\": [{\"name\": \"需求確認\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認需求與使用對象\", \"確認使用期間\"]}, {\"name\": \"資源安排\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認可提供資源\", \"記錄安排內容\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:20\", \"updated_at\": \"2026-10-21 09:36:20\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:20\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:20\", \"actor\": \"教學發展暨資源中心示範承辦人\", \"username\": \"demo_office_teaching\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\"}], \"files\": []}', '{\"id\": 27, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教學發展暨資源中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學習資源支援申請\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"資源需求\": \"【示範】資源需求：操作練習用\", \"使用期間\": \"【示範】使用期間：操作練習用\"}, \"workflow\": [{\"name\": \"需求確認\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認需求與使用對象\", \"確認使用期間\"]}, {\"name\": \"資源安排\", \"office\": \"教學發展暨資源中心\", \"checks\": [\"確認可提供資源\", \"記錄安排內容\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求說明\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:20\", \"updated_at\": \"2026-10-21 09:36:20\", \"revision\": 3, \"requirements\": [\"請補充資源需求\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:20\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:20\", \"actor\": \"教學發展暨資源中心示範承辦人\", \"username\": \"demo_office_teaching\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\"}, {\"at\": \"2026-10-21 09:36:20\", \"actor\": \"教學發展暨資源中心示範承辦人\", \"username\": \"demo_office_teaching\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充資源需求、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"教學發展暨資源中心\", \"assignee\": \"demo_office_teaching\"}], \"files\": []}', '2026-10-21 01:36:20'),
(52, 'admin_cases', '29', '受理案件', '招生中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 29, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】招生中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"招生諮詢轉介\", \"office\": \"招生中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"諮詢管道\": \"【示範】諮詢管道：操作練習用\", \"想了解的入學項目\": \"【示範】想了解的入學項目：操作練習用\"}, \"workflow\": [{\"name\": \"諮詢分類\", \"office\": \"招生中心\", \"checks\": [\"確認諮詢項目\", \"確認回覆窗口\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"招生中心\", \"checks\": [\"提供資訊來源\", \"記錄後續追蹤\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"諮詢內容摘要\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:20\", \"updated_at\": \"2026-10-21 09:36:20\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:20\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"招生中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 29, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】招生中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"招生諮詢轉介\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"諮詢管道\": \"【示範】諮詢管道：操作練習用\", \"想了解的入學項目\": \"【示範】想了解的入學項目：操作練習用\"}, \"workflow\": [{\"name\": \"諮詢分類\", \"office\": \"招生中心\", \"checks\": [\"確認諮詢項目\", \"確認回覆窗口\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"招生中心\", \"checks\": [\"提供資訊來源\", \"記錄後續追蹤\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"諮詢內容摘要\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:20\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:20\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"招生中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"招生中心示範承辦人\", \"username\": \"demo_office_admissions\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\"}], \"files\": []}', '2026-10-21 01:36:21'),
(53, 'admin_cases', '30', '受理案件', '招生中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 30, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】招生中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"招生諮詢轉介\", \"office\": \"招生中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"諮詢管道\": \"【示範】諮詢管道：操作練習用\", \"想了解的入學項目\": \"【示範】想了解的入學項目：操作練習用\"}, \"workflow\": [{\"name\": \"諮詢分類\", \"office\": \"招生中心\", \"checks\": [\"確認諮詢項目\", \"確認回覆窗口\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"招生中心\", \"checks\": [\"提供資訊來源\", \"記錄後續追蹤\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"諮詢內容摘要\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"招生中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 30, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】招生中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"招生諮詢轉介\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"諮詢管道\": \"【示範】諮詢管道：操作練習用\", \"想了解的入學項目\": \"【示範】想了解的入學項目：操作練習用\"}, \"workflow\": [{\"name\": \"諮詢分類\", \"office\": \"招生中心\", \"checks\": [\"確認諮詢項目\", \"確認回覆窗口\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"招生中心\", \"checks\": [\"提供資訊來源\", \"記錄後續追蹤\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"諮詢內容摘要\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"招生中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"招生中心示範承辦人\", \"username\": \"demo_office_admissions\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\"}], \"files\": []}', '2026-10-21 01:36:21'),
(54, 'admin_cases', '30', '要求補件', '招生中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 30, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】招生中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"招生諮詢轉介\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"諮詢管道\": \"【示範】諮詢管道：操作練習用\", \"想了解的入學項目\": \"【示範】想了解的入學項目：操作練習用\"}, \"workflow\": [{\"name\": \"諮詢分類\", \"office\": \"招生中心\", \"checks\": [\"確認諮詢項目\", \"確認回覆窗口\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"招生中心\", \"checks\": [\"提供資訊來源\", \"記錄後續追蹤\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"諮詢內容摘要\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"招生中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"招生中心示範承辦人\", \"username\": \"demo_office_admissions\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\"}], \"files\": []}', '{\"id\": 30, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】招生中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"招生諮詢轉介\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"諮詢管道\": \"【示範】諮詢管道：操作練習用\", \"想了解的入學項目\": \"【示範】想了解的入學項目：操作練習用\"}, \"workflow\": [{\"name\": \"諮詢分類\", \"office\": \"招生中心\", \"checks\": [\"確認諮詢項目\", \"確認回覆窗口\"]}, {\"name\": \"回覆與追蹤\", \"office\": \"招生中心\", \"checks\": [\"提供資訊來源\", \"記錄後續追蹤\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"諮詢內容摘要\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 3, \"requirements\": [\"請補充諮詢管道\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"招生中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"招生中心示範承辦人\", \"username\": \"demo_office_admissions\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"招生中心示範承辦人\", \"username\": \"demo_office_admissions\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充諮詢管道、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"招生中心\", \"assignee\": \"demo_office_admissions\"}], \"files\": []}', '2026-10-21 01:36:21'),
(55, 'admin_cases', '32', '受理案件', '體育室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 32, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】體育室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"運動場地使用申請\", \"office\": \"體育室\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"使用場地\": \"【示範】使用場地：操作練習用\", \"日期與時段\": \"【示範】日期與時段：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"場地與時段確認\", \"office\": \"體育室\", \"checks\": [\"確認場地時段\", \"確認使用內容\"]}, {\"name\": \"使用安排確認\", \"office\": \"體育室\", \"checks\": [\"告知使用須知\", \"登錄使用安排\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"體育室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 32, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】體育室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"運動場地使用申請\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"使用場地\": \"【示範】使用場地：操作練習用\", \"日期與時段\": \"【示範】日期與時段：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"場地與時段確認\", \"office\": \"體育室\", \"checks\": [\"確認場地時段\", \"確認使用內容\"]}, {\"name\": \"使用安排確認\", \"office\": \"體育室\", \"checks\": [\"告知使用須知\", \"登錄使用安排\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"體育室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"體育室示範承辦人\", \"username\": \"demo_office_sports\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\"}], \"files\": []}', '2026-10-21 01:36:21'),
(56, 'admin_cases', '33', '受理案件', '體育室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 33, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】體育室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"運動場地使用申請\", \"office\": \"體育室\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"使用場地\": \"【示範】使用場地：操作練習用\", \"日期與時段\": \"【示範】日期與時段：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"場地與時段確認\", \"office\": \"體育室\", \"checks\": [\"確認場地時段\", \"確認使用內容\"]}, {\"name\": \"使用安排確認\", \"office\": \"體育室\", \"checks\": [\"告知使用須知\", \"登錄使用安排\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"體育室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 33, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】體育室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"運動場地使用申請\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"使用場地\": \"【示範】使用場地：操作練習用\", \"日期與時段\": \"【示範】日期與時段：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"場地與時段確認\", \"office\": \"體育室\", \"checks\": [\"確認場地時段\", \"確認使用內容\"]}, {\"name\": \"使用安排確認\", \"office\": \"體育室\", \"checks\": [\"告知使用須知\", \"登錄使用安排\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"體育室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"體育室示範承辦人\", \"username\": \"demo_office_sports\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\"}], \"files\": []}', '2026-10-21 01:36:21'),
(57, 'admin_cases', '33', '要求補件', '體育室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 33, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】體育室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"運動場地使用申請\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"使用場地\": \"【示範】使用場地：操作練習用\", \"日期與時段\": \"【示範】日期與時段：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"場地與時段確認\", \"office\": \"體育室\", \"checks\": [\"確認場地時段\", \"確認使用內容\"]}, {\"name\": \"使用安排確認\", \"office\": \"體育室\", \"checks\": [\"告知使用須知\", \"登錄使用安排\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"體育室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"體育室示範承辦人\", \"username\": \"demo_office_sports\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\"}], \"files\": []}', '{\"id\": 33, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】體育室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"運動場地使用申請\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"使用場地\": \"【示範】使用場地：操作練習用\", \"日期與時段\": \"【示範】日期與時段：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"場地與時段確認\", \"office\": \"體育室\", \"checks\": [\"確認場地時段\", \"確認使用內容\"]}, {\"name\": \"使用安排確認\", \"office\": \"體育室\", \"checks\": [\"告知使用須知\", \"登錄使用安排\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動說明\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 3, \"requirements\": [\"請補充使用場地\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"體育室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"體育室示範承辦人\", \"username\": \"demo_office_sports\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\"}, {\"at\": \"2026-10-21 09:36:21\", \"actor\": \"體育室示範承辦人\", \"username\": \"demo_office_sports\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充使用場地、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"體育室\", \"assignee\": \"demo_office_sports\"}], \"files\": []}', '2026-10-21 01:36:21');
INSERT INTO `audit_logs` (`log_id`, `table_name`, `record_id`, `action`, `changed_by`, `changed_by_role`, `ip_address`, `before_json`, `after_json`, `changed_at`) VALUES
(58, 'admin_cases', '35', '受理案件', '校務研究辦公室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 35, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】校務研究辦公室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務統計資料需求\", \"office\": \"校務研究辦公室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"資料用途\": \"【示範】資料用途：操作練習用\", \"統計範圍\": \"【示範】統計範圍：操作練習用\"}, \"workflow\": [{\"name\": \"需求與範圍確認\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認資料用途\", \"確認可提供範圍\"]}, {\"name\": \"資料彙整\", \"office\": \"校務研究辦公室\", \"checks\": [\"檢查統計口徑\", \"移除可識別資料\"]}, {\"name\": \"結果交付\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認提供內容\", \"登錄交付紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求與使用範圍說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:21\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"校務研究辦公室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 35, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】校務研究辦公室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務統計資料需求\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"資料用途\": \"【示範】資料用途：操作練習用\", \"統計範圍\": \"【示範】統計範圍：操作練習用\"}, \"workflow\": [{\"name\": \"需求與範圍確認\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認資料用途\", \"確認可提供範圍\"]}, {\"name\": \"資料彙整\", \"office\": \"校務研究辦公室\", \"checks\": [\"檢查統計口徑\", \"移除可識別資料\"]}, {\"name\": \"結果交付\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認提供內容\", \"登錄交付紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求與使用範圍說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:21\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:21\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"校務研究辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"校務研究辦公室示範承辦人\", \"username\": \"demo_office_institutional\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\"}], \"files\": []}', '2026-10-21 01:36:22'),
(59, 'admin_cases', '36', '受理案件', '校務研究辦公室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 36, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】校務研究辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務統計資料需求\", \"office\": \"校務研究辦公室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"資料用途\": \"【示範】資料用途：操作練習用\", \"統計範圍\": \"【示範】統計範圍：操作練習用\"}, \"workflow\": [{\"name\": \"需求與範圍確認\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認資料用途\", \"確認可提供範圍\"]}, {\"name\": \"資料彙整\", \"office\": \"校務研究辦公室\", \"checks\": [\"檢查統計口徑\", \"移除可識別資料\"]}, {\"name\": \"結果交付\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認提供內容\", \"登錄交付紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求與使用範圍說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"校務研究辦公室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 36, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】校務研究辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務統計資料需求\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"資料用途\": \"【示範】資料用途：操作練習用\", \"統計範圍\": \"【示範】統計範圍：操作練習用\"}, \"workflow\": [{\"name\": \"需求與範圍確認\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認資料用途\", \"確認可提供範圍\"]}, {\"name\": \"資料彙整\", \"office\": \"校務研究辦公室\", \"checks\": [\"檢查統計口徑\", \"移除可識別資料\"]}, {\"name\": \"結果交付\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認提供內容\", \"登錄交付紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求與使用範圍說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"校務研究辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"校務研究辦公室示範承辦人\", \"username\": \"demo_office_institutional\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\"}], \"files\": []}', '2026-10-21 01:36:22'),
(60, 'admin_cases', '36', '要求補件', '校務研究辦公室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 36, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】校務研究辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務統計資料需求\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"資料用途\": \"【示範】資料用途：操作練習用\", \"統計範圍\": \"【示範】統計範圍：操作練習用\"}, \"workflow\": [{\"name\": \"需求與範圍確認\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認資料用途\", \"確認可提供範圍\"]}, {\"name\": \"資料彙整\", \"office\": \"校務研究辦公室\", \"checks\": [\"檢查統計口徑\", \"移除可識別資料\"]}, {\"name\": \"結果交付\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認提供內容\", \"登錄交付紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求與使用範圍說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"校務研究辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"校務研究辦公室示範承辦人\", \"username\": \"demo_office_institutional\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\"}], \"files\": []}', '{\"id\": 36, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】校務研究辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"校務統計資料需求\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"資料用途\": \"【示範】資料用途：操作練習用\", \"統計範圍\": \"【示範】統計範圍：操作練習用\"}, \"workflow\": [{\"name\": \"需求與範圍確認\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認資料用途\", \"確認可提供範圍\"]}, {\"name\": \"資料彙整\", \"office\": \"校務研究辦公室\", \"checks\": [\"檢查統計口徑\", \"移除可識別資料\"]}, {\"name\": \"結果交付\", \"office\": \"校務研究辦公室\", \"checks\": [\"確認提供內容\", \"登錄交付紀錄\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"需求與使用範圍說明\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 3, \"requirements\": [\"請補充資料用途\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"校務研究辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"校務研究辦公室示範承辦人\", \"username\": \"demo_office_institutional\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"校務研究辦公室示範承辦人\", \"username\": \"demo_office_institutional\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充資料用途、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"校務研究辦公室\", \"assignee\": \"demo_office_institutional\"}], \"files\": []}', '2026-10-21 01:36:22'),
(61, 'admin_cases', '38', '受理案件', '國際暨兩岸事務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 38, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】國際暨兩岸事務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"交流活動諮詢申請\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"交流項目\": \"【示範】交流項目：操作練習用\", \"預計參與期間\": \"【示範】預計參與期間：操作練習用\"}, \"workflow\": [{\"name\": \"交流需求確認\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認交流項目\", \"確認參與條件\"]}, {\"name\": \"文件檢核\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認所需資料\", \"整理補充事項\"]}, {\"name\": \"回覆與安排\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"提供安排說明\", \"記錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"參與規劃\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 38, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】國際暨兩岸事務處｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"交流活動諮詢申請\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"交流項目\": \"【示範】交流項目：操作練習用\", \"預計參與期間\": \"【示範】預計參與期間：操作練習用\"}, \"workflow\": [{\"name\": \"交流需求確認\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認交流項目\", \"確認參與條件\"]}, {\"name\": \"文件檢核\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認所需資料\", \"整理補充事項\"]}, {\"name\": \"回覆與安排\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"提供安排說明\", \"記錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"參與規劃\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"國際暨兩岸事務處示範承辦人\", \"username\": \"demo_office_international\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\"}], \"files\": []}', '2026-10-21 01:36:22'),
(62, 'admin_cases', '39', '受理案件', '國際暨兩岸事務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 39, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】國際暨兩岸事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"交流活動諮詢申請\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"交流項目\": \"【示範】交流項目：操作練習用\", \"預計參與期間\": \"【示範】預計參與期間：操作練習用\"}, \"workflow\": [{\"name\": \"交流需求確認\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認交流項目\", \"確認參與條件\"]}, {\"name\": \"文件檢核\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認所需資料\", \"整理補充事項\"]}, {\"name\": \"回覆與安排\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"提供安排說明\", \"記錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"參與規劃\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 39, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】國際暨兩岸事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"交流活動諮詢申請\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"交流項目\": \"【示範】交流項目：操作練習用\", \"預計參與期間\": \"【示範】預計參與期間：操作練習用\"}, \"workflow\": [{\"name\": \"交流需求確認\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認交流項目\", \"確認參與條件\"]}, {\"name\": \"文件檢核\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認所需資料\", \"整理補充事項\"]}, {\"name\": \"回覆與安排\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"提供安排說明\", \"記錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"參與規劃\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"國際暨兩岸事務處示範承辦人\", \"username\": \"demo_office_international\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\"}], \"files\": []}', '2026-10-21 01:36:22'),
(63, 'admin_cases', '39', '要求補件', '國際暨兩岸事務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 39, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】國際暨兩岸事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"交流活動諮詢申請\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"交流項目\": \"【示範】交流項目：操作練習用\", \"預計參與期間\": \"【示範】預計參與期間：操作練習用\"}, \"workflow\": [{\"name\": \"交流需求確認\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認交流項目\", \"確認參與條件\"]}, {\"name\": \"文件檢核\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認所需資料\", \"整理補充事項\"]}, {\"name\": \"回覆與安排\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"提供安排說明\", \"記錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"參與規劃\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"國際暨兩岸事務處示範承辦人\", \"username\": \"demo_office_international\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\"}], \"files\": []}', '{\"id\": 39, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】國際暨兩岸事務處｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"交流活動諮詢申請\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"交流項目\": \"【示範】交流項目：操作練習用\", \"預計參與期間\": \"【示範】預計參與期間：操作練習用\"}, \"workflow\": [{\"name\": \"交流需求確認\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認交流項目\", \"確認參與條件\"]}, {\"name\": \"文件檢核\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"確認所需資料\", \"整理補充事項\"]}, {\"name\": \"回覆與安排\", \"office\": \"國際暨兩岸事務處\", \"checks\": [\"提供安排說明\", \"記錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"參與規劃\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 3, \"requirements\": [\"請補充交流項目\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"國際暨兩岸事務處示範承辦人\", \"username\": \"demo_office_international\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\"}, {\"at\": \"2026-10-21 09:36:22\", \"actor\": \"國際暨兩岸事務處示範承辦人\", \"username\": \"demo_office_international\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充交流項目、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"國際暨兩岸事務處\", \"assignee\": \"demo_office_international\"}], \"files\": []}', '2026-10-21 01:36:22'),
(64, 'admin_cases', '41', '受理案件', '高教深耕辦公室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 41, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】高教深耕辦公室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"計畫活動資料檢核\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"計畫名稱\": \"【示範】計畫名稱：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"計畫對應確認\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認計畫項目\", \"確認活動目標\"]}, {\"name\": \"成果資料檢核\", \"office\": \"高教深耕辦公室\", \"checks\": [\"核對成果資料\", \"記錄待補事項\"]}, {\"name\": \"結果彙整\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認資料完整\", \"登錄彙整結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動計畫\", \"預期成果說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:22\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 41, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】高教深耕辦公室｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"計畫活動資料檢核\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"計畫名稱\": \"【示範】計畫名稱：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"計畫對應確認\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認計畫項目\", \"確認活動目標\"]}, {\"name\": \"成果資料檢核\", \"office\": \"高教深耕辦公室\", \"checks\": [\"核對成果資料\", \"記錄待補事項\"]}, {\"name\": \"結果彙整\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認資料完整\", \"登錄彙整結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動計畫\", \"預期成果說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:22\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:22\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"高教深耕辦公室示範承辦人\", \"username\": \"demo_office_highered\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\"}], \"files\": []}', '2026-10-21 01:36:23'),
(65, 'admin_cases', '42', '受理案件', '高教深耕辦公室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 42, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】高教深耕辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"計畫活動資料檢核\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"計畫名稱\": \"【示範】計畫名稱：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"計畫對應確認\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認計畫項目\", \"確認活動目標\"]}, {\"name\": \"成果資料檢核\", \"office\": \"高教深耕辦公室\", \"checks\": [\"核對成果資料\", \"記錄待補事項\"]}, {\"name\": \"結果彙整\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認資料完整\", \"登錄彙整結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動計畫\", \"預期成果說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 42, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】高教深耕辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"計畫活動資料檢核\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"計畫名稱\": \"【示範】計畫名稱：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"計畫對應確認\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認計畫項目\", \"確認活動目標\"]}, {\"name\": \"成果資料檢核\", \"office\": \"高教深耕辦公室\", \"checks\": [\"核對成果資料\", \"記錄待補事項\"]}, {\"name\": \"結果彙整\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認資料完整\", \"登錄彙整結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動計畫\", \"預期成果說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"高教深耕辦公室示範承辦人\", \"username\": \"demo_office_highered\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\"}], \"files\": []}', '2026-10-21 01:36:23'),
(66, 'admin_cases', '42', '要求補件', '高教深耕辦公室示範承辦人', '教職員', '127.0.0.1', '{\"id\": 42, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】高教深耕辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"計畫活動資料檢核\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"計畫名稱\": \"【示範】計畫名稱：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"計畫對應確認\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認計畫項目\", \"確認活動目標\"]}, {\"name\": \"成果資料檢核\", \"office\": \"高教深耕辦公室\", \"checks\": [\"核對成果資料\", \"記錄待補事項\"]}, {\"name\": \"結果彙整\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認資料完整\", \"登錄彙整結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動計畫\", \"預期成果說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"高教深耕辦公室示範承辦人\", \"username\": \"demo_office_highered\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\"}], \"files\": []}', '{\"id\": 42, \"student_id\": null, \"student_name\": \"周立威 (教務處職員)\", \"title\": \"【處室示範】高教深耕辦公室｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"計畫活動資料檢核\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\", \"applicant_username\": \"staff1\", \"applicant_role\": \"教職員\", \"answers\": {\"計畫名稱\": \"【示範】計畫名稱：操作練習用\", \"活動內容\": \"【示範】活動內容：操作練習用\"}, \"workflow\": [{\"name\": \"計畫對應確認\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認計畫項目\", \"確認活動目標\"]}, {\"name\": \"成果資料檢核\", \"office\": \"高教深耕辦公室\", \"checks\": [\"核對成果資料\", \"記錄待補事項\"]}, {\"name\": \"結果彙整\", \"office\": \"高教深耕辦公室\", \"checks\": [\"確認資料完整\", \"登錄彙整結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"活動計畫\", \"預期成果說明\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 3, \"requirements\": [\"請補充計畫名稱\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"周立威 (教務處職員)\", \"username\": \"staff1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"高教深耕辦公室\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"高教深耕辦公室示範承辦人\", \"username\": \"demo_office_highered\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"高教深耕辦公室示範承辦人\", \"username\": \"demo_office_highered\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充計畫名稱、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"高教深耕辦公室\", \"assignee\": \"demo_office_highered\"}], \"files\": []}', '2026-10-21 01:36:23'),
(67, 'admin_cases', '44', '受理案件', '推廣教育中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 44, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】推廣教育中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"推廣課程諮詢\", \"office\": \"推廣教育中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"課程主題\": \"【示範】課程主題：操作練習用\", \"預計參加時段\": \"【示範】預計參加時段：操作練習用\"}, \"workflow\": [{\"name\": \"課程需求確認\", \"office\": \"推廣教育中心\", \"checks\": [\"確認課程主題\", \"確認參與時段\"]}, {\"name\": \"開課資訊回覆\", \"office\": \"推廣教育中心\", \"checks\": [\"確認可提供資訊\", \"登錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"課程需求說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"推廣教育中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 44, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】推廣教育中心｜處理中：可逐關檢核\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"推廣課程諮詢\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"課程主題\": \"【示範】課程主題：操作練習用\", \"預計參加時段\": \"【示範】預計參加時段：操作練習用\"}, \"workflow\": [{\"name\": \"課程需求確認\", \"office\": \"推廣教育中心\", \"checks\": [\"確認課程主題\", \"確認參與時段\"]}, {\"name\": \"開課資訊回覆\", \"office\": \"推廣教育中心\", \"checks\": [\"確認可提供資訊\", \"登錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"課程需求說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"推廣教育中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"推廣教育中心示範承辦人\", \"username\": \"demo_office_extension\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\"}], \"files\": []}', '2026-10-21 01:36:23'),
(68, 'admin_cases', '45', '受理案件', '推廣教育中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 45, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】推廣教育中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"推廣課程諮詢\", \"office\": \"推廣教育中心\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"課程主題\": \"【示範】課程主題：操作練習用\", \"預計參加時段\": \"【示範】預計參加時段：操作練習用\"}, \"workflow\": [{\"name\": \"課程需求確認\", \"office\": \"推廣教育中心\", \"checks\": [\"確認課程主題\", \"確認參與時段\"]}, {\"name\": \"開課資訊回覆\", \"office\": \"推廣教育中心\", \"checks\": [\"確認可提供資訊\", \"登錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"課程需求說明\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"推廣教育中心\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 45, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】推廣教育中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"推廣課程諮詢\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"課程主題\": \"【示範】課程主題：操作練習用\", \"預計參加時段\": \"【示範】預計參加時段：操作練習用\"}, \"workflow\": [{\"name\": \"課程需求確認\", \"office\": \"推廣教育中心\", \"checks\": [\"確認課程主題\", \"確認參與時段\"]}, {\"name\": \"開課資訊回覆\", \"office\": \"推廣教育中心\", \"checks\": [\"確認可提供資訊\", \"登錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"課程需求說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"推廣教育中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"推廣教育中心示範承辦人\", \"username\": \"demo_office_extension\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\"}], \"files\": []}', '2026-10-21 01:36:23'),
(69, 'admin_cases', '45', '要求補件', '推廣教育中心示範承辦人', '教職員', '127.0.0.1', '{\"id\": 45, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】推廣教育中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"推廣課程諮詢\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"課程主題\": \"【示範】課程主題：操作練習用\", \"預計參加時段\": \"【示範】預計參加時段：操作練習用\"}, \"workflow\": [{\"name\": \"課程需求確認\", \"office\": \"推廣教育中心\", \"checks\": [\"確認課程主題\", \"確認參與時段\"]}, {\"name\": \"開課資訊回覆\", \"office\": \"推廣教育中心\", \"checks\": [\"確認可提供資訊\", \"登錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"課程需求說明\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"推廣教育中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"推廣教育中心示範承辦人\", \"username\": \"demo_office_extension\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\"}], \"files\": []}', '{\"id\": 45, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】推廣教育中心｜待補件：可用申請帳號補交\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"推廣課程諮詢\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"課程主題\": \"【示範】課程主題：操作練習用\", \"預計參加時段\": \"【示範】預計參加時段：操作練習用\"}, \"workflow\": [{\"name\": \"課程需求確認\", \"office\": \"推廣教育中心\", \"checks\": [\"確認課程主題\", \"確認參與時段\"]}, {\"name\": \"開課資訊回覆\", \"office\": \"推廣教育中心\", \"checks\": [\"確認可提供資訊\", \"登錄回覆結果\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"課程需求說明\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 3, \"requirements\": [\"請補充課程主題\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"推廣教育中心\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"推廣教育中心示範承辦人\", \"username\": \"demo_office_extension\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"推廣教育中心示範承辦人\", \"username\": \"demo_office_extension\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充課程主題、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"推廣教育中心\", \"assignee\": \"demo_office_extension\"}], \"files\": []}', '2026-10-21 01:36:23'),
(70, 'admin_cases', '46', '受理案件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 46, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜重新送審：可再次受理\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 46, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜重新送審：可再次受理\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:23'),
(71, 'admin_cases', '46', '要求補件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 46, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜重新送審：可再次受理\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '{\"id\": 46, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜重新送審：可再次受理\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 3, \"requirements\": [\"請補充證明用途\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充證明用途、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:23'),
(72, 'admin_cases', '46', '補件重新送審', '王小明', '學生', '127.0.0.1', '{\"id\": 46, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜重新送審：可再次受理\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待補件\", \"due_date\": \"2026-10-26\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 3, \"requirements\": [\"請補充證明用途\", \"請確認聯絡與交付方式\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充證明用途、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '{\"id\": 46, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜重新送審：可再次受理\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"重新送審\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 4, \"requirements\": [\"請補充證明用途\", \"請確認聯絡與交付方式\"], \"supplements\": [{\"at\": \"2026-10-21 09:36:23\", \"note\": \"【示範】已補充申請用途與聯絡方式，請重新審查。\", \"checked\": [\"請補充證明用途\", \"請確認聯絡與交付方式\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"要求補件\", \"note\": \"【示範】資料尚待補充，可用申請帳號練習補件。\\n應補資料：請補充證明用途、請確認聯絡與交付方式\\n期限：2026-10-26\", \"status\": \"待補件\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【示範】已補充申請用途與聯絡方式，請重新審查。\", \"status\": \"重新送審\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:23'),
(73, 'admin_cases', '47', '受理案件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:24'),
(74, 'admin_cases', '47', '完成步驟：學籍資料核對', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:23\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 3, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"完成步驟：學籍資料核對\", \"note\": \"【示範】本步驟檢核完成。\\n下一步：證明製發（教務處）\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}], \"files\": []}', '2026-10-21 01:36:24');
INSERT INTO `audit_logs` (`log_id`, `table_name`, `record_id`, `action`, `changed_by`, `changed_by_role`, `ip_address`, `before_json`, `after_json`, `changed_at`) VALUES
(75, 'admin_cases', '47', '受理案件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 3, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"完成步驟：學籍資料核對\", \"note\": \"【示範】本步驟檢核完成。\\n下一步：證明製發（教務處）\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 4, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"完成步驟：學籍資料核對\", \"note\": \"【示範】本步驟檢核完成。\\n下一步：證明製發（教務處）\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:24'),
(76, 'admin_cases', '47', '完成案件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 4, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"完成步驟：學籍資料核對\", \"note\": \"【示範】本步驟檢核完成。\\n下一步：證明製發（教務處）\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '{\"id\": 47, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已完成：可查看全程紀錄\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"已完成\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:23\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 5, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:23\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:23\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"完成步驟：學籍資料核對\", \"note\": \"【示範】本步驟檢核完成。\\n下一步：證明製發（教務處）\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"完成案件\", \"note\": \"【示範】全部步驟已完成，展示結案與完整紀錄。\", \"status\": \"已完成\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:24'),
(77, 'admin_cases', '48', '受理案件', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 48, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已退件：可查看原因\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:24\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:24\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 48, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已退件：可查看原因\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:24\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:24\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:24'),
(78, 'admin_cases', '48', '退件結案', '教務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 48, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已退件：可查看原因\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:24\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:24\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '{\"id\": 48, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【處室示範】教務處｜已退件：可查看原因\", \"detail\": \"虛構示範資料，僅供切換處室、分派、逐關檢核與補件操作，不代表正式申請。\", \"kind\": \"學籍證明申請\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"證明用途\": \"【示範】證明用途：操作練習用\", \"申請份數\": \"【示範】申請份數：操作練習用\"}, \"workflow\": [{\"name\": \"學籍資料核對\", \"office\": \"教務處\", \"checks\": [\"核對在學身分\", \"確認申請用途\"]}, {\"name\": \"證明製發\", \"office\": \"教務處\", \"checks\": [\"確認證明內容\", \"記錄交付方式\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"身分驗證資料\"], \"status\": \"已退件\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:36:24\", \"updated_at\": \"2026-10-21 09:36:24\", \"revision\": 3, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:36:24\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"教務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}, {\"at\": \"2026-10-21 09:36:24\", \"actor\": \"教務處示範承辦人\", \"username\": \"demo_office_academic\", \"action\": \"退件結案\", \"note\": \"【示範】展示資料不適用時的退件結案，不代表真實資格判斷。\", \"status\": \"已退件\", \"office\": \"教務處\", \"assignee\": \"demo_office_academic\"}], \"files\": []}', '2026-10-21 01:36:24'),
(79, 'admin_cases', '50', '受理案件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:37:29\", \"revision\": 1, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:37:45\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:37:45'),
(80, 'admin_cases', '50', '要求補件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:37:45\", \"revision\": 2, \"requirements\": [], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待補件\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:37:46\", \"revision\": 3, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:37:46'),
(81, 'admin_cases', '50', '補件重新送審', '王小明', '學生', '127.0.0.1', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待補件\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:37:46\", \"revision\": 3, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"重新送審\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:37:59\", \"revision\": 4, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:37:59'),
(82, 'admin_cases', '50', '受理案件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"重新送審\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:37:59\", \"revision\": 4, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:38:01\", \"revision\": 5, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:01\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:38:01'),
(83, 'admin_cases', '50', '完成步驟：報修受理與派工', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 0, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:38:01\", \"revision\": 5, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:01\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:38:09\", \"revision\": 6, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:01\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:09\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"完成步驟：報修受理與派工\", \"note\": \"【瀏覽器驗收】第一階段派工資料確認。\\n下一步：修繕與驗收（總務處）\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}], \"files\": []}', '2026-10-21 01:38:09'),
(84, 'admin_cases', '50', '受理案件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"待受理\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:38:09\", \"revision\": 6, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:01\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:09\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"完成步驟：報修受理與派工\", \"note\": \"【瀏覽器驗收】第一階段派工資料確認。\\n下一步：修繕與驗收（總務處）\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}], \"files\": []}', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:38:10\", \"revision\": 7, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:01\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:09\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"完成步驟：報修受理與派工\", \"note\": \"【瀏覽器驗收】第一階段派工資料確認。\\n下一步：修繕與驗收（總務處）\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:38:10\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:38:10'),
(85, 'admin_cases', '50', '完成案件', '總務處示範承辦人', '教職員', '127.0.0.1', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"處理中\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:38:10\", \"revision\": 7, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:01\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:09\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"完成步驟：報修受理與派工\", \"note\": \"【瀏覽器驗收】第一階段派工資料確認。\\n下一步：修繕與驗收（總務處）\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:38:10\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '{\"id\": 50, \"student_id\": \"S112001\", \"student_name\": \"王小明\", \"title\": \"【瀏覽器驗收】總務處逐關辦理與補件\", \"detail\": \"虛構測試，驗證總務處獨立流程與學生補件。\", \"kind\": \"設備報修申請\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\", \"applicant_username\": \"student1\", \"applicant_role\": \"學生\", \"answers\": {\"設備位置\": \"示範教室 A301\", \"故障情形\": \"虛構投影設備問題，供操作驗收\"}, \"workflow\": [{\"name\": \"報修受理與派工\", \"office\": \"總務處\", \"checks\": [\"確認故障位置\", \"安排處理人員\"]}, {\"name\": \"修繕與驗收\", \"office\": \"總務處\", \"checks\": [\"記錄處理情形\", \"確認設備恢復狀態\"]}], \"workflow_index\": 1, \"workflow_days\": 7, \"is_demo_workflow\": true, \"documents\": [\"故障照片（可於補件時補交）\"], \"status\": \"已完成\", \"due_date\": \"2026-10-28\", \"created_at\": \"2026-10-21 09:37:29\", \"updated_at\": \"2026-10-21 09:38:11\", \"revision\": 8, \"requirements\": [\"請補充故障發生時間\"], \"supplements\": [{\"at\": \"2026-10-21 09:37:59\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"checked\": [\"請補充故障發生時間\"], \"files\": []}], \"history\": [{\"at\": \"2026-10-21 09:37:29\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"送出申請\", \"note\": \"\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:37:45\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:46\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"要求補件\", \"note\": \"【瀏覽器驗收】請補充問題發生時間，便於派工。\\n應補資料：請補充故障發生時間\\n期限：2026-10-28\", \"status\": \"待補件\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:37:59\", \"actor\": \"王小明\", \"username\": \"student1\", \"action\": \"補件重新送審\", \"note\": \"【瀏覽器驗收】故障發生於示範日期上午，已補充。\", \"status\": \"重新送審\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:01\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:09\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"完成步驟：報修受理與派工\", \"note\": \"【瀏覽器驗收】第一階段派工資料確認。\\n下一步：修繕與驗收（總務處）\", \"status\": \"待受理\", \"office\": \"總務處\", \"assignee\": \"\"}, {\"at\": \"2026-10-21 09:38:10\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"受理案件\", \"note\": \"\", \"status\": \"處理中\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}, {\"at\": \"2026-10-21 09:38:11\", \"actor\": \"總務處示範承辦人\", \"username\": \"demo_office_general\", \"action\": \"完成案件\", \"note\": \"【瀏覽器驗收】修繕與驗收檢核完成，示範全流程結案。\", \"status\": \"已完成\", \"office\": \"總務處\", \"assignee\": \"demo_office_general\"}], \"files\": []}', '2026-10-21 01:38:11'),
(86, 'admin_offices', 'configuration', '修改', '系統超級管理員', '管理員', '127.0.0.1', '{\"members\": {\"demo_office_academic\": \"教務處\", \"demo_office_accounting\": \"會計室\", \"demo_office_admissions\": \"招生中心\", \"demo_office_extension\": \"推廣教育中心\", \"demo_office_general\": \"總務處\", \"demo_office_highered\": \"高教深耕辦公室\", \"demo_office_institutional\": \"校務研究辦公室\", \"demo_office_international\": \"國際暨兩岸事務處\", \"demo_office_library\": \"資訊暨圖書中心\", \"demo_office_personnel\": \"人事室\", \"demo_office_research\": \"研究發展處\", \"demo_office_secretary\": \"秘書室\", \"demo_office_sports\": \"體育室\", \"demo_office_student\": \"學生事務處\", \"demo_office_teaching\": \"教學發展暨資源中心\", \"dorm_demo\": \"學生事務處\", \"staff1\": \"教務處\"}, \"offices\": [\"教務處\", \"學生事務處\", \"總務處\", \"研究發展處\", \"秘書室\", \"資訊暨圖書中心\", \"會計室\", \"人事室\", \"教學發展暨資源中心\", \"招生中心\", \"體育室\", \"校務研究辦公室\", \"國際暨兩岸事務處\", \"高教深耕辦公室\", \"推廣教育中心\"]}', '{\"workflow_name\": \"經費核銷資料檢核\", \"workflow\": {\"office\": \"會計室\", \"fields\": [\"經費來源\", \"金額與用途\"], \"documents\": [\"支出說明\", \"收據或發票影本\"], \"days\": 7, \"steps\": [{\"name\": \"憑證初核\", \"office\": \"會計室\", \"checks\": [\"確認支出用途\", \"確認憑證完整\"]}, {\"name\": \"預算與科目核對\", \"office\": \"會計室\", \"checks\": [\"核對經費來源\", \"確認會計科目\"]}, {\"name\": \"核對結果登錄\", \"office\": \"會計室\", \"checks\": [\"登錄檢核結果\", \"交付後續辦理事項\"]}], \"roles\": [\"教職員\", \"管理員\"]}}', '2026-10-21 01:39:37');

-- --------------------------------------------------------

--
-- 資料表結構 `certificates`
--

CREATE TABLE `certificates` (
  `cert_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `cert_name` varchar(100) NOT NULL,
  `issuing_org` varchar(100) NOT NULL DEFAULT '勞動部勞動力發展署技能檢定中心',
  `cert_number` varchar(50) DEFAULT NULL,
  `theory_score` decimal(5,2) DEFAULT NULL,
  `practical_score` decimal(5,2) DEFAULT NULL,
  `cert_status` varchar(50) DEFAULT '及格發證',
  `verify_url` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(20) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `kind` enum('證照','競賽','作品') NOT NULL DEFAULT '證照',
  `review_status` enum('待審核','已通過','已退回') NOT NULL DEFAULT '已通過',
  `reviewer` varchar(50) DEFAULT NULL,
  `review_note` varchar(200) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `award` varchar(60) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `certificates`
--

INSERT INTO `certificates` (`cert_id`, `student_id`, `cert_name`, `issuing_org`, `cert_number`, `theory_score`, `practical_score`, `cert_status`, `verify_url`, `file_path`, `file_name`, `file_type`, `issue_date`, `kind`, `review_status`, `reviewer`, `review_note`, `reviewed_at`, `award`, `description`, `attachments`, `created_at`) VALUES
(1, 'S112001', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署', '113-CS-004521', 82.00, 88.00, '及格發證', NULL, NULL, NULL, NULL, '2026-06-20', '證照', '已通過', NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-24 04:10:29'),
(2, 'S112001', '乙級電腦軟體應用技術士', '勞動部勞動力發展署', '114-CS-008912', 86.50, 92.00, '及格發證', NULL, NULL, NULL, NULL, '2026-08-15', '證照', '已通過', NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-24 04:10:29'),
(3, 'S112002', 'TQC+ 網頁設計工程師', '財團法人中華民國電腦技能基金會', 'TQC-WD-22310', 78.00, 85.00, '及格發證', NULL, NULL, NULL, NULL, '2026-07-05', '證照', '已通過', NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-24 04:10:29'),
(4, 'S112004', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署', '113-CS-004588', 90.00, 86.00, '及格發證', NULL, NULL, NULL, NULL, '2026-06-20', '證照', '已通過', NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-24 04:10:29'),
(5, 'S112004', '乙級電腦軟體應用技術士', '勞動部勞動力發展署', '114-CS-009010', 88.00, 90.00, '及格發證', NULL, NULL, NULL, NULL, '2026-08-15', '證照', '已通過', NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-24 04:10:29'),
(6, '115534102', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '115-343530', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-15', '證照', '已通過', '示範資料', NULL, '2026-09-14 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(7, '115534102', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-15', '競賽', '已通過', '示範資料', NULL, '2026-09-14 16:00:00', '入圍決賽', NULL, '[]', '2026-10-14 06:27:40'),
(8, '115534103', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '115-621826', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-17', '證照', '已通過', '示範資料', NULL, '2026-09-16 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(9, '115534103', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-19', '競賽', '已通過', '示範資料', NULL, '2026-09-18 16:00:00', '第三名', NULL, '[]', '2026-10-14 06:27:40'),
(10, '115534104', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '115-751184', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-17', '證照', '已通過', '示範資料', NULL, '2026-09-16 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(11, '115534104', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-24', '競賽', '已通過', '示範資料', NULL, '2026-09-23 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(12, '115534104', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-05', '競賽', '已通過', '示範資料', NULL, '2026-10-04 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(13, '115534106', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '115-205721', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-28', '證照', '已通過', '示範資料', NULL, '2026-09-27 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(14, '115534107', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '115-173870', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-19', '證照', '已通過', '示範資料', NULL, '2026-09-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(15, '115534107', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-26', '競賽', '已通過', '示範資料', NULL, '2026-09-25 16:00:00', '第三名', NULL, '[]', '2026-10-14 06:27:40'),
(16, '115534109', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '115-688834', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-09-25', '證照', '已通過', '示範資料', NULL, '2026-09-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(17, '115534109', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-04', '競賽', '已通過', '示範資料', NULL, '2026-10-03 16:00:00', '第三名', NULL, '[]', '2026-10-14 06:27:40'),
(18, '114534101', '全民英檢初級', '財團法人語言訓練測驗中心', '114-833453', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-19', '證照', '已通過', '示範資料', NULL, '2025-10-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(19, '114534101', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-12', '競賽', '已通過', '示範資料', NULL, '2026-04-11 16:00:00', '第三名', NULL, '[]', '2026-10-14 06:27:40'),
(20, '114534102', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '114-738847', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-06', '證照', '已通過', '示範資料', NULL, '2026-04-05 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(21, '114534103', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '114-994088', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-23', '證照', '已通過', '示範資料', NULL, '2026-03-22 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(22, '114534103', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '114-786198', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-11', '證照', '已通過', '示範資料', NULL, '2026-04-10 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(23, '114534103', '全民英檢初級', '財團法人語言訓練測驗中心', '114-144311', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-28', '證照', '已通過', '示範資料', NULL, '2025-10-27 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(24, '114534104', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '114-192438', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-18', '證照', '已通過', '示範資料', NULL, '2025-10-17 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(25, '114534104', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '114-707230', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-12-12', '證照', '已通過', '示範資料', NULL, '2025-12-11 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(26, '114534104', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-12-08', '競賽', '已通過', '示範資料', NULL, '2025-12-07 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(27, '114534105', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-04', '競賽', '已通過', '示範資料', NULL, '2026-04-03 16:00:00', '第一名', NULL, '[]', '2026-10-14 06:27:40'),
(28, '114534105', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-04', '競賽', '已通過', '示範資料', NULL, '2026-04-03 16:00:00', '參賽', NULL, '[]', '2026-10-14 06:27:40'),
(29, '114534106', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '114-588835', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-11-07', '證照', '已通過', '示範資料', NULL, '2025-11-06 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(30, '114534106', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-30', '競賽', '已通過', '示範資料', NULL, '2025-10-29 16:00:00', '參賽', NULL, '[]', '2026-10-14 06:27:40'),
(31, '114534107', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '114-636004', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-03', '證照', '已通過', '示範資料', NULL, '2026-05-02 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(32, '114534107', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-06-09', '競賽', '已通過', '示範資料', NULL, '2026-06-08 16:00:00', '參賽', NULL, '[]', '2026-10-14 06:27:40'),
(33, '114534107', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-10', '競賽', '已通過', '示範資料', NULL, '2025-10-09 16:00:00', '參賽', NULL, '[]', '2026-10-14 06:27:40'),
(34, '114534107', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '115-859849', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(35, '114534108', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '114-384940', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-11-18', '證照', '已通過', '示範資料', NULL, '2025-11-17 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(36, '114534109', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '114-599166', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-13', '證照', '已通過', '示範資料', NULL, '2026-04-12 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(37, '114534109', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '115-775984', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(38, '113534101', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '113-553475', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-22', '證照', '已通過', '示範資料', NULL, '2024-11-21 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(39, '113534101', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '115-531583', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(40, '113534102', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '113-289442', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-27', '證照', '已通過', '示範資料', NULL, '2025-04-26 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(41, '113534102', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '114-216483', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-02-28', '證照', '已通過', '示範資料', NULL, '2026-02-27 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(42, '113534102', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-11', '競賽', '已通過', '示範資料', NULL, '2026-04-10 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(43, '113534102', '校內簡報競賽', '康寧大學學務處', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-10-08', '競賽', '已通過', '示範資料', NULL, '2024-10-07 16:00:00', '參賽', NULL, '[]', '2026-10-14 06:27:40'),
(44, '113534102', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-16', '作品', '已通過', '示範資料', NULL, '2026-04-15 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(45, '113534103', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '114-618490', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-09-15', '證照', '已通過', '示範資料', NULL, '2025-09-14 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(46, '113534103', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '113-968530', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-02-24', '證照', '已通過', '示範資料', NULL, '2025-02-23 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(47, '113534103', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '113-309792', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-14', '證照', '已通過', '示範資料', NULL, '2025-04-13 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(48, '113534103', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-09-22', '競賽', '已通過', '示範資料', NULL, '2024-09-21 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(49, '113534103', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '115-824193', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(50, '113534104', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '114-925960', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-02-20', '證照', '已通過', '示範資料', NULL, '2026-02-19 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(51, '113534104', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '114-598539', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-11-02', '證照', '已通過', '示範資料', NULL, '2025-11-01 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(52, '113534104', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '114-190700', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-30', '證照', '已通過', '示範資料', NULL, '2026-05-29 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(53, '113534104', '校園失物招領 App', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-12-19', '作品', '已通過', '示範資料', NULL, '2024-12-18 16:00:00', NULL, '課堂期末專案，可以拍照登記失物', '[]', '2026-10-14 06:27:40'),
(54, '113534105', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '113-631180', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-10-02', '證照', '已通過', '示範資料', NULL, '2024-10-01 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(55, '113534106', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-837591', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-03-06', '證照', '已通過', '示範資料', NULL, '2025-03-05 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(56, '113534106', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-05-13', '競賽', '已通過', '示範資料', NULL, '2025-05-12 16:00:00', '第一名', NULL, '[]', '2026-10-14 06:27:40'),
(57, '113534106', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-17', '競賽', '已通過', '示範資料', NULL, '2025-04-16 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(58, '113534107', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '113-261854', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-23', '證照', '已通過', '示範資料', NULL, '2024-11-22 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(59, '113534107', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '114-819516', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-29', '證照', '已通過', '示範資料', NULL, '2026-05-28 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(60, '113534108', '全民英檢初級', '財團法人語言訓練測驗中心', '114-763638', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-12-18', '證照', '已通過', '示範資料', NULL, '2025-12-17 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(61, '113534108', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '113-511795', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-11', '證照', '已通過', '示範資料', NULL, '2024-11-10 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(62, '113534109', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '113-356961', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-28', '證照', '已通過', '示範資料', NULL, '2024-11-27 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(63, '113534109', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '113-678314', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-05-20', '證照', '已通過', '示範資料', NULL, '2025-05-19 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(64, '112534101', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '114-761012', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-27', '證照', '已通過', '示範資料', NULL, '2025-10-26 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(65, '112534101', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-674781', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-05-03', '證照', '已通過', '示範資料', NULL, '2024-05-02 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(66, '112534102', '全民英檢初級', '財團法人語言訓練測驗中心', '113-449778', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-25', '證照', '已通過', '示範資料', NULL, '2025-04-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(67, '112534102', '多益測驗 600 分', '忠欣股份有限公司', '114-802877', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-06-02', '證照', '已通過', '示範資料', NULL, '2026-06-01 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(68, '112534102', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '114-704380', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-11-18', '證照', '已通過', '示範資料', NULL, '2025-11-17 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(69, '112534103', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '113-527379', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-09-17', '證照', '已通過', '示範資料', NULL, '2024-09-16 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(70, '112534103', '全民英檢初級', '財團法人語言訓練測驗中心', '112-744866', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-06-04', '證照', '已通過', '示範資料', NULL, '2024-06-03 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(71, '112534103', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '112-385365', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-05-19', '證照', '已通過', '示範資料', NULL, '2024-05-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(72, '112534103', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '112-179948', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-12-20', '證照', '已通過', '示範資料', NULL, '2023-12-19 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(73, '112534103', '全民英檢初級', '財團法人語言訓練測驗中心', '115-678564', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(74, '112534104', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-818873', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-07', '證照', '已通過', '示範資料', NULL, '2026-05-06 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(75, '112534104', '多益測驗 600 分', '忠欣股份有限公司', '112-584956', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-09-27', '證照', '已通過', '示範資料', NULL, '2023-09-26 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(76, '112534104', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-565945', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-02', '證照', '已通過', '示範資料', NULL, '2026-05-01 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(77, '112534104', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '112-546277', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-12-19', '證照', '已通過', '示範資料', NULL, '2023-12-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(78, '112534104', '校內簡報競賽', '康寧大學學務處', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-05-24', '競賽', '已通過', '示範資料', NULL, '2024-05-23 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(79, '112534104', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-10-07', '作品', '已通過', '示範資料', NULL, '2023-10-06 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(80, '112534105', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '114-356062', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-09', '證照', '已通過', '示範資料', NULL, '2026-04-08 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(81, '112534105', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '115-226249', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(82, '112534106', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '114-374836', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-18', '證照', '已通過', '示範資料', NULL, '2026-03-17 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(83, '112534106', '多益測驗 600 分', '忠欣股份有限公司', '114-140399', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-24', '證照', '已通過', '示範資料', NULL, '2026-03-23 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(84, '112534106', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '114-408574', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-23', '證照', '已通過', '示範資料', NULL, '2026-05-22 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(85, '112534106', '全國大專校院資訊應用服務創新競賽', '教育部', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-31', '競賽', '已通過', '示範資料', NULL, '2026-03-30 16:00:00', '第三名', NULL, '[]', '2026-10-14 06:27:40'),
(86, '112534106', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-11-22', '作品', '已通過', '示範資料', NULL, '2023-11-21 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(87, '112534107', '全民英檢初級', '財團法人語言訓練測驗中心', '113-145011', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-05', '證照', '已通過', '示範資料', NULL, '2025-04-04 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(88, '112534107', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-465900', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-10-09', '證照', '已通過', '示範資料', NULL, '2024-10-08 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(89, '112534108', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-375388', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-26', '證照', '已通過', '示範資料', NULL, '2025-04-25 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(90, '112534108', '多益測驗 600 分', '忠欣股份有限公司', '112-132435', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-05-10', '證照', '已通過', '示範資料', NULL, '2024-05-09 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(91, '112534108', '全民英檢初級', '財團法人語言訓練測驗中心', '113-596096', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-19', '證照', '已通過', '示範資料', NULL, '2025-04-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(92, '112534108', '全國大專校院資訊應用服務創新競賽', '教育部', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-03-12', '競賽', '已通過', '示範資料', NULL, '2025-03-11 16:00:00', '入圍決賽', NULL, '[]', '2026-10-14 06:27:40'),
(93, '112534109', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '112-458269', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-04-13', '證照', '已通過', '示範資料', NULL, '2024-04-12 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(94, '112534109', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-342082', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-12-25', '證照', '已通過', '示範資料', NULL, '2023-12-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(95, '111534101', '多益測驗 600 分', '忠欣股份有限公司', '114-759556', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-11-23', '證照', '已通過', '示範資料', NULL, '2025-11-22 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(96, '111534101', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '111-661384', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-05', '證照', '已通過', '示範資料', NULL, '2023-03-04 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(97, '111534101', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-09-24', '作品', '已通過', '示範資料', NULL, '2024-09-23 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(98, '111534102', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '111-141371', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-04-14', '證照', '已通過', '示範資料', NULL, '2023-04-13 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(99, '111534102', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '111-404188', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-12', '證照', '已通過', '示範資料', NULL, '2023-03-11 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(100, '111534102', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-343799', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-10-29', '證照', '已通過', '示範資料', NULL, '2023-10-28 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(101, '111534103', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '111-997065', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-12-08', '證照', '已通過', '示範資料', NULL, '2022-12-07 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(102, '111534103', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-971982', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-10-01', '證照', '已通過', '示範資料', NULL, '2023-09-30 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(103, '111534103', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '111-166517', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-10-30', '證照', '已通過', '示範資料', NULL, '2022-10-29 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(104, '111534103', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '111-768791', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-04-27', '證照', '已通過', '示範資料', NULL, '2023-04-26 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(105, '111534103', '全國大專校院資訊應用服務創新競賽', '教育部', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-12-31', '競賽', '已通過', '示範資料', NULL, '2023-12-30 16:00:00', '第一名', NULL, '[]', '2026-10-14 06:27:40'),
(106, '111534103', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-26', '競賽', '已通過', '示範資料', NULL, '2024-11-25 16:00:00', '第三名', NULL, '[]', '2026-10-14 06:27:40'),
(107, '111534103', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-02-26', '作品', '已通過', '示範資料', NULL, '2024-02-25 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(108, '111534104', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '112-876535', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-22', '證照', '已通過', '示範資料', NULL, '2024-03-21 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(109, '111534104', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-535432', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-18', '證照', '已通過', '示範資料', NULL, '2026-03-17 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(110, '111534104', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '111-953098', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-19', '證照', '已通過', '示範資料', NULL, '2023-03-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(111, '111534104', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-09-30', '競賽', '已通過', '示範資料', NULL, '2022-09-29 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(112, '111534104', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '115-731180', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(113, '111534105', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '112-697673', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-07', '證照', '已通過', '示範資料', NULL, '2024-03-06 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(114, '111534105', '多益測驗 600 分', '忠欣股份有限公司', '111-877438', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-04-20', '證照', '已通過', '示範資料', NULL, '2023-04-19 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(115, '111534105', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '114-784059', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-12-04', '證照', '已通過', '示範資料', NULL, '2025-12-03 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(116, '111534105', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-591621', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-15', '證照', '已通過', '示範資料', NULL, '2025-04-14 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(117, '111534105', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-22', '競賽', '已通過', '示範資料', NULL, '2023-03-21 16:00:00', '第一名', NULL, '[]', '2026-10-14 06:27:40'),
(118, '111534105', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-25', '競賽', '已通過', '示範資料', NULL, '2025-10-24 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(119, '111534106', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '111-824161', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-11-05', '證照', '已通過', '示範資料', NULL, '2022-11-04 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(120, '111534106', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '113-930790', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-02-25', '證照', '已通過', '示範資料', NULL, '2025-02-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(121, '111534106', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '114-970298', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-15', '證照', '已通過', '示範資料', NULL, '2026-05-14 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(122, '111534106', '全國大專校院資訊應用服務創新競賽', '教育部', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-11-04', '競賽', '已通過', '示範資料', NULL, '2022-11-03 16:00:00', '第一名', NULL, '[]', '2026-10-14 06:27:40'),
(123, '111534107', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-822935', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-02-27', '證照', '已通過', '示範資料', NULL, '2024-02-26 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(124, '111534107', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '114-439387', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-27', '證照', '已通過', '示範資料', NULL, '2026-04-26 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(125, '111534107', '全國大專校院資訊應用服務創新競賽', '教育部', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-19', '競賽', '已通過', '示範資料', NULL, '2026-04-18 16:00:00', '入圍決賽', NULL, '[]', '2026-10-14 06:27:40'),
(126, '111534107', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-13', '競賽', '已通過', '示範資料', NULL, '2026-05-12 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(127, '111534108', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-404196', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-05-22', '證照', '已通過', '示範資料', NULL, '2025-05-21 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(128, '111534108', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '113-809305', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-02', '證照', '已通過', '示範資料', NULL, '2025-04-01 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(129, '111534108', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '112-392119', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-06-03', '證照', '已通過', '示範資料', NULL, '2024-06-02 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(130, '111534109', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '112-498879', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-25', '證照', '已通過', '示範資料', NULL, '2024-03-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(131, '111534109', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-756818', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-31', '證照', '已通過', '示範資料', NULL, '2024-03-30 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(132, '111534109', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '111-604909', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-11-21', '證照', '已通過', '示範資料', NULL, '2022-11-20 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(133, '111534109', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-11-10', '競賽', '已通過', '示範資料', NULL, '2025-11-09 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(134, '111534110', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-973573', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-05-10', '證照', '已通過', '示範資料', NULL, '2024-05-09 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(135, '111534110', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '112-281614', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-10-02', '證照', '已通過', '示範資料', NULL, '2023-10-01 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(136, '111534111', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-955311', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-09-30', '證照', '已通過', '示範資料', NULL, '2025-09-29 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(137, '111534111', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-911982', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-05-25', '證照', '已通過', '示範資料', NULL, '2025-05-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(138, '111534112', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-878309', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-02-28', '證照', '已通過', '示範資料', NULL, '2024-02-27 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(139, '111534112', '多益測驗 600 分', '忠欣股份有限公司', '111-412003', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-11-30', '證照', '已通過', '示範資料', NULL, '2022-11-29 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(140, '111534113', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '112-300458', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-11-06', '證照', '已通過', '示範資料', NULL, '2023-11-05 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(141, '111534113', '多益測驗 600 分', '忠欣股份有限公司', '111-436587', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-25', '證照', '已通過', '示範資料', NULL, '2023-03-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(142, '111534113', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '111-270711', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-12-06', '證照', '已通過', '示範資料', NULL, '2022-12-05 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(143, '111534113', '校內簡報競賽', '康寧大學學務處', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-11', '競賽', '已通過', '示範資料', NULL, '2024-03-10 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(144, '111534113', '校園失物招領 App', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-06-08', '作品', '已通過', '示範資料', NULL, '2024-06-07 16:00:00', NULL, '課堂期末專案，可以拍照登記失物', '[]', '2026-10-14 06:27:40'),
(145, '111534114', '全民英檢初級', '財團法人語言訓練測驗中心', '111-405283', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-30', '證照', '已通過', '示範資料', NULL, '2023-03-29 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(146, '111534114', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '112-986199', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-04-29', '證照', '已通過', '示範資料', NULL, '2024-04-28 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(147, '111534114', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-407577', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-10-05', '證照', '已通過', '示範資料', NULL, '2023-10-04 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(148, '111534114', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-658804', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-20', '證照', '已通過', '示範資料', NULL, '2026-03-19 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(149, '111534114', '校內簡報競賽', '康寧大學學務處', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-09-18', '競賽', '已通過', '示範資料', NULL, '2022-09-17 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(150, '111534114', '畢業專題：校園選課小幫手', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-05-04', '作品', '已通過', '示範資料', NULL, '2023-05-03 16:00:00', NULL, '畢業專題，幫同學檢查衝堂與擋修', '[]', '2026-10-14 06:27:40'),
(151, '111534115', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '113-548797', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-05-12', '證照', '已通過', '示範資料', NULL, '2025-05-11 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(152, '111534115', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '114-101751', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-14', '證照', '已通過', '示範資料', NULL, '2026-05-13 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(153, '111534115', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '113-634759', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-03-19', '證照', '已通過', '示範資料', NULL, '2025-03-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(154, '111534115', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '112-191032', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-10-26', '證照', '已通過', '示範資料', NULL, '2023-10-25 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(155, '111534115', '校內簡報競賽', '康寧大學學務處', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-12-03', '競賽', '已通過', '示範資料', NULL, '2025-12-02 16:00:00', '第三名', NULL, '[]', '2026-10-14 06:27:40'),
(156, '111534115', '全國大專校院資訊應用服務創新競賽', '教育部', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-17', '競賽', '已通過', '示範資料', NULL, '2024-11-16 16:00:00', '第一名', NULL, '[]', '2026-10-14 06:27:40'),
(157, '111534116', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-887809', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-06-10', '證照', '已通過', '示範資料', NULL, '2025-06-09 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(158, '111534116', '全民英檢初級', '財團法人語言訓練測驗中心', '114-217962', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-14', '證照', '已通過', '示範資料', NULL, '2026-03-13 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(159, '111534116', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '113-856278', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-03-26', '證照', '已通過', '示範資料', NULL, '2025-03-25 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(160, '111534116', '校內英文單字比賽', '康寧大學語言中心', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-10-24', '競賽', '已通過', '示範資料', NULL, '2024-10-23 16:00:00', '佳作', NULL, '[]', '2026-10-14 06:27:40'),
(161, '111534116', '全國大專校院資訊應用服務創新競賽', '教育部', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-14', '競賽', '已通過', '示範資料', NULL, '2026-03-13 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(162, '111534118', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '112-700600', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-01-03', '證照', '已通過', '示範資料', NULL, '2024-01-02 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(163, '111534118', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '114-687585', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-12-09', '證照', '已通過', '示範資料', NULL, '2025-12-08 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(164, '111534119', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '111-321814', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-10-23', '證照', '已通過', '示範資料', NULL, '2022-10-22 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(165, '111534119', '多益測驗 600 分', '忠欣股份有限公司', '113-820648', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-09-30', '證照', '已通過', '示範資料', NULL, '2024-09-29 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(166, '111534119', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '112-633898', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-12-20', '證照', '已通過', '示範資料', NULL, '2023-12-19 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(167, '111534119', '校內簡報競賽', '康寧大學學務處', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-15', '競賽', '已通過', '示範資料', NULL, '2024-03-14 16:00:00', '參賽', NULL, '[]', '2026-10-14 06:27:40'),
(168, '111534120', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '112-785235', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-11-22', '證照', '已通過', '示範資料', NULL, '2023-11-21 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(169, '111534120', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '111-202918', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-10-26', '證照', '已通過', '示範資料', NULL, '2022-10-25 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(170, '111534120', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-01-01', '作品', '已通過', '示範資料', NULL, '2025-12-31 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(171, '111534121', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-138558', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-06-06', '證照', '已通過', '示範資料', NULL, '2024-06-05 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(172, '111534121', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '112-783102', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-09-19', '證照', '已通過', '示範資料', NULL, '2023-09-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(173, '111534121', '校內簡報競賽', '康寧大學學務處', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-25', '競賽', '已通過', '示範資料', NULL, '2023-03-24 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(174, '111534121', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-02-20', '作品', '已通過', '示範資料', NULL, '2024-02-19 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(175, '111534122', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-333675', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-10-09', '證照', '已通過', '示範資料', NULL, '2023-10-08 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(176, '111534122', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-296845', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-09-17', '證照', '已通過', '示範資料', NULL, '2025-09-16 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(177, '111534122', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '113-424813', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-09-25', '證照', '已通過', '示範資料', NULL, '2024-09-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(178, '111534123', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '113-150375', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-05-13', '證照', '已通過', '示範資料', NULL, '2025-05-12 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(179, '111534123', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-517888', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-23', '證照', '已通過', '示範資料', NULL, '2024-03-22 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(180, '111534123', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-278896', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-09-21', '證照', '已通過', '示範資料', NULL, '2023-09-20 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(181, '111534123', '畢業專題：校園選課小幫手', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-04', '作品', '已通過', '示範資料', NULL, '2026-04-03 16:00:00', NULL, '畢業專題，幫同學檢查衝堂與擋修', '[]', '2026-10-14 06:27:40'),
(182, '111534124', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '112-930685', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-02-29', '證照', '已通過', '示範資料', NULL, '2024-02-28 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(183, '111534124', '全民英檢初級', '財團法人語言訓練測驗中心', '113-262811', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-10-24', '證照', '已通過', '示範資料', NULL, '2024-10-23 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(184, '111534124', '班級網站製作', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-03-05', '作品', '已通過', '示範資料', NULL, '2025-03-04 16:00:00', NULL, '用 HTML、CSS 做的班級介紹網站', '[]', '2026-10-14 06:27:40'),
(185, '111534125', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-663775', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-21', '證照', '已通過', '示範資料', NULL, '2024-03-20 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(186, '111534125', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '114-255952', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-17', '證照', '已通過', '示範資料', NULL, '2026-03-16 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(187, '111534201', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '112-768588', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-03-24', '證照', '已通過', '示範資料', NULL, '2024-03-23 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(188, '111534201', '多益測驗 600 分', '忠欣股份有限公司', '111-344346', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-04-19', '證照', '已通過', '示範資料', NULL, '2023-04-18 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(189, '111534201', '全國專科學校專題實作競賽', '教育部技術及職業教育司', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-03-09', '競賽', '已通過', '示範資料', NULL, '2026-03-08 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(190, '111534202', '全民英檢初級', '財團法人語言訓練測驗中心', '114-681231', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-11', '證照', '已通過', '示範資料', NULL, '2026-05-10 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(191, '111534202', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '114-844175', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-21', '證照', '已通過', '示範資料', NULL, '2026-05-20 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(192, '111534202', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-02-23', '競賽', '已通過', '示範資料', NULL, '2023-02-22 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(193, '111534203', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-255834', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-03-30', '證照', '已通過', '示範資料', NULL, '2025-03-29 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(194, '111534203', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '113-777307', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-12-04', '證照', '已通過', '示範資料', NULL, '2024-12-03 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(195, '111534203', '多益測驗 600 分', '忠欣股份有限公司', '112-915139', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-12-07', '證照', '已通過', '示範資料', NULL, '2023-12-06 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(196, '111534203', '全民英檢初級', '財團法人語言訓練測驗中心', '113-390130', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-04-10', '證照', '已通過', '示範資料', NULL, '2025-04-09 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(197, '111534203', '全國專科學校專題實作競賽', '教育部技術及職業教育司', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-03-03', '競賽', '已通過', '示範資料', NULL, '2023-03-02 16:00:00', '第二名', NULL, '[]', '2026-10-14 06:27:40'),
(198, '111534203', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '115-635160', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(199, '111534204', 'TQC 程式語言（Python）', '財團法人中華民國電腦技能基金會', '114-675188', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-06-10', '證照', '已通過', '示範資料', NULL, '2026-06-09 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(200, '111534204', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-425536', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-10-15', '證照', '已通過', '示範資料', NULL, '2025-10-14 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(201, '111534204', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '112-698322', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-04-10', '證照', '已通過', '示範資料', NULL, '2024-04-09 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(202, '111534204', '校內程式設計競賽', '康寧大學資訊管理科', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-10-15', '競賽', '已通過', '示範資料', NULL, '2024-10-14 16:00:00', '第一名', NULL, '[]', '2026-10-14 06:27:40'),
(203, '111534205', 'TQC 文書處理（Word）', '財團法人中華民國電腦技能基金會', '112-128170', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-05-26', '證照', '已通過', '示範資料', NULL, '2024-05-25 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(204, '111534206', '全民英檢初級', '財團法人語言訓練測驗中心', '111-840481', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2022-11-25', '證照', '已通過', '示範資料', NULL, '2022-11-24 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(205, '111534206', '丙級電腦硬體裝修技術士', '勞動部勞動力發展署技能檢定中心', '112-534484', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-05-28', '證照', '已通過', '示範資料', NULL, '2024-05-27 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(206, '111534206', '多益測驗 600 分', '忠欣股份有限公司', '114-176320', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-09-18', '證照', '已通過', '示範資料', NULL, '2025-09-17 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(207, '111534206', '全國技藝競賽 資訊技術類', '教育部國民及學前教育署', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-04-09', '競賽', '已通過', '示範資料', NULL, '2026-04-08 16:00:00', '入圍決賽', NULL, '[]', '2026-10-14 06:27:40'),
(208, '111534206', '全民英檢初級', '財團法人語言訓練測驗中心', '115-697057', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-10-03', '證照', '待審核', NULL, NULL, NULL, NULL, NULL, '[]', '2026-10-14 06:27:40'),
(209, '111534207', '多益測驗 600 分', '忠欣股份有限公司', '112-511934', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-11-01', '證照', '已通過', '示範資料', NULL, '2023-10-31 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(210, '111534207', '丙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '114-768795', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2026-05-14', '證照', '已通過', '示範資料', NULL, '2026-05-13 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(211, '111534207', '全民英檢初級', '財團法人語言訓練測驗中心', '113-889910', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-06', '證照', '已通過', '示範資料', NULL, '2024-11-05 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(212, '111534208', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '113-623779', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-06-01', '證照', '已通過', '示範資料', NULL, '2025-05-31 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(213, '111534208', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '112-399827', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2023-11-20', '證照', '已通過', '示範資料', NULL, '2023-11-19 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(214, '111534208', '丙級網頁設計技術士', '勞動部勞動力發展署技能檢定中心', '113-605262', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2024-11-07', '證照', '已通過', '示範資料', NULL, '2024-11-06 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(215, '111534209', '乙級電腦軟體應用技術士', '勞動部勞動力發展署技能檢定中心', '113-338892', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-06-06', '證照', '已通過', '示範資料', NULL, '2025-06-05 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(216, '111534209', 'TQC 電子試算表（Excel）', '財團法人中華民國電腦技能基金會', '113-141310', NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-01-01', '證照', '已通過', '示範資料', NULL, '2024-12-31 16:00:00', NULL, NULL, '[]', '2026-10-14 06:27:40'),
(217, '111534209', '畢業專題：校園選課小幫手', '', NULL, NULL, NULL, '及格發證', NULL, NULL, 'seed_classes.py', NULL, '2025-05-19', '作品', '已通過', '示範資料', NULL, '2025-05-18 16:00:00', NULL, '畢業專題，幫同學檢查衝堂與擋修', '[]', '2026-10-14 06:27:40');

-- --------------------------------------------------------

--
-- 資料表結構 `checklist_items`
--

CREATE TABLE `checklist_items` (
  `item_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `category_name` varchar(50) NOT NULL DEFAULT '課務組',
  `business_name` varchar(100) NOT NULL,
  `steps_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `required_docs` text DEFAULT NULL,
  `office_hours` varchar(100) DEFAULT '週一至週五 08:30 - 17:00',
  `office_location` varchar(100) DEFAULT '康寧樓 2 樓 A201 (教務處)',
  `contact_phone` varchar(50) DEFAULT '02-2632-1181 分機 310',
  `form_download_url` varchar(300) DEFAULT NULL,
  `system_url` varchar(300) DEFAULT NULL,
  `deadline_week_info` varchar(100) DEFAULT NULL,
  `related_kb_id` int(11) DEFAULT NULL,
  `audience` varchar(20) NOT NULL DEFAULT '學生'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `checklist_items`
--

INSERT INTO `checklist_items` (`item_id`, `category_id`, `category_name`, `business_name`, `steps_json`, `required_docs`, `office_hours`, `office_location`, `contact_phone`, `form_download_url`, `system_url`, `deadline_week_info`, `related_kb_id`, `audience`) VALUES
(1, 1, '課務組', '課程停修申請', '[\"至校務資訊系統登入『停修申請表』\", \"列印紙本停修申請單\", \"親自送請任課教師簽章同意\", \"送請班級導師及科主任簽章\", \"於第12週五前送交教務處課務組核備\"]', '停修申請單紙本、歷年成績單正本', '週一至週五 08:30 - 17:00', '康寧樓 2 樓 A201 (課務組)', '02-2632-1181 分機 310, 312', '/forms/course_withdraw_form.pdf', 'http://talk.ukn.edu.tw/class_redi/class.php', '第 10-12 週 (本週受理中)', 1, '學生'),
(2, 2, '生輔組', '學生請假申請 (病假/事假)', '[\"登入學生資訊系統填寫請假單\", \"上傳就醫證明或相關佐證文件圖檔\", \"送出後通知導師進行線上簽核\", \"請假超過3日由生輔組組長複核\", \"系統顯示審核通過即完成登錄\"]', '健保特約就醫證明、就診收據影本', '週一至週五 08:00 - 17:30', '行政大樓 1 樓 學務處生輔組', '02-2632-1181 分機 211', '/forms/leave_application_form.pdf', 'https://ec.ukn.edu.tw/AskLeave/login.aspx', '請假日當日起 3 日內', 2, '學生'),
(3, 3, '通識中心', '外語證照免修與學分抵免', '[\"填寫通識外語抵免申請表\", \"備妥多益/英檢/雅思成績單正本及影本各一份\", \"送交通識教育中心辦公室查驗正本\", \"教務處課務組複審學分折抵\", \"次學期初於歷年成績單確認抵免註記\"]', '外語檢定成績單正本、影本、抵免申請書', '週一至週五 09:00 - 16:30', '卓越樓 3 樓 C305 (通識教育中心)', '02-2632-1181 分機 520, 521', '/forms/english_waiver_form.pdf', 'http://203.71.63.13/academic/', '開學前至加退選截止 (已截止)', 3, '學生'),
(4, 1, '註冊組', '學士班畢業學分資格預審', '[\"登入畢業審查系統列印學分檢核表\", \"核對科專業必修、選修與通識學分缺口\", \"確認英文畢業門檻與專題通過證明\", \"至科辦公室請科主任初審簽章\", \"送交教務處註冊組進行畢業資格決審\"]', '歷年成績單正本、畢業學分預審表、外語通過證明', '週一至週五 08:30 - 17:00', '康寧樓 2 樓 A202 (註冊組)', '02-2632-1181 分機 321, 322', '/forms/graduation_audit_form.pdf', 'http://203.71.63.13/academic/', '大四第 8-16 週 (進行中)', 4, '學生'),
(5, 3, '研發處', '專業證照與競賽獲獎獎勵金申請', '[\"登入研發處證照獎勵申請平台\", \"填寫證照/競賽名稱、證書字號與發證單位\", \"上傳證書正反面與郵局存摺封面圖檔\", \"列印紙本印領清冊並親筆簽名\", \"送交研發處實習就業組審核並撥款\"]', '證照證書影本、郵局存摺封面影本、印領清冊', '週一至週五 09:00 - 17:00', '圖資大樓 2 樓 研發處實習就業組', '02-2632-1181 分機 612', '/forms/certificate_reward_form.pdf', 'https://oes3.ukn.edu.tw/~license/', '每學期第 1-5 週', 5, '學生');

-- --------------------------------------------------------

--
-- 資料表結構 `checklist_progress`
--

CREATE TABLE `checklist_progress` (
  `student_id` varchar(20) NOT NULL,
  `item_id` int(11) NOT NULL,
  `step_index` int(11) NOT NULL,
  `done` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `checklist_progress`
--

INSERT INTO `checklist_progress` (`student_id`, `item_id`, `step_index`, `done`) VALUES
('S112001', 1, 0, 1),
('S112001', 1, 1, 1),
('S112001', 3, 0, 1),
('S112005', 1, 0, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `class_groups`
--

CREATE TABLE `class_groups` (
  `class_name` varchar(50) NOT NULL COMMENT '班級 / 群組名稱 (PK)',
  `password_hash` varchar(255) NOT NULL COMMENT '加入密碼雜湊',
  `created_by` varchar(50) NOT NULL COMMENT '建立者姓名',
  `created_by_username` varchar(50) DEFAULT NULL COMMENT '建立者帳號 (系統自動建立時為 NULL)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='科上通知：班級 / 群組';

--
-- 傾印資料表的資料 `class_groups`
--

INSERT INTO `class_groups` (`class_name`, `password_hash`, `created_by`, `created_by_username`, `created_at`) VALUES
('護理四忠', 'scrypt:32768:8:1$0GYx6TVcfAQVxJOx$4d1a22eadaf089d86ead428a0928ff303048ef7fd87891f997f58510110ee82954339c19e0501f79ed6cb29c4c497b7b9cc048ffba5afb1edabf5fa64642fa89', '系統', NULL, '2026-10-12 01:56:18'),
('資管一忠', 'scrypt:32768:8:1$NCD1Q8HGtazaZmwL$1e41cbf3426caadd084cff99ce0087339fe9da45c0cabc6a939cd775e640f0a29423af6146bb7df9a2815fef63590df0a43ac59fc200d1ef6b844afbb61fcfee', '系統', NULL, '2026-10-12 02:23:50'),
('資管三忠', 'scrypt:32768:8:1$NCD1Q8HGtazaZmwL$1e41cbf3426caadd084cff99ce0087339fe9da45c0cabc6a939cd775e640f0a29423af6146bb7df9a2815fef63590df0a43ac59fc200d1ef6b844afbb61fcfee', '系統', NULL, '2026-10-12 02:23:50'),
('資管二忠', 'scrypt:32768:8:1$NCD1Q8HGtazaZmwL$1e41cbf3426caadd084cff99ce0087339fe9da45c0cabc6a939cd775e640f0a29423af6146bb7df9a2815fef63590df0a43ac59fc200d1ef6b844afbb61fcfee', '系統', NULL, '2026-10-12 02:23:50'),
('資管五孝', 'scrypt:32768:8:1$0fg2NWOkB4Hw8Nu4$20780a4e4e2ef19530ef15e330ce6a7f486d3272347f076eaa32659dde254196af6aaaf3888df774b353e79f648eeaedbc3c1eb1fc29c647cec05b213669bddb', '系統', NULL, '2026-10-12 01:56:18'),
('資管五忠', 'scrypt:32768:8:1$WrYVpe2a4Givba0l$d16b67e21b119bf8fc21d5180e53e268aa67bd3e9d45f1f498de0bbe1c5f1c7382daccec588b473eca4210353bd3efa2f7f901c99f58af58de11a850cc31a22b', '系統', NULL, '2026-10-12 01:56:18'),
('資管四忠', 'scrypt:32768:8:1$lvb145Qsu7IsNY7w$96a95585dada8cf22f5e4d331c6f16545d2f057bfaddaf570cd75de3173c384d5d75af3c7d5c7988471b15d0bfc448932aa0de7ba19b3c0fc8119672c5801a03', '系統', NULL, '2026-10-12 01:56:18');

-- --------------------------------------------------------

--
-- 資料表結構 `class_group_members`
--

CREATE TABLE `class_group_members` (
  `class_name` varchar(50) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='科上通知：班級成員';

--
-- 傾印資料表的資料 `class_group_members`
--

INSERT INTO `class_group_members` (`class_name`, `student_id`, `joined_at`) VALUES
('護理四忠', 'S112003', '2026-10-12 01:56:18'),
('資管五孝', 'S112004', '2026-10-12 01:56:18'),
('資管五忠', '111534117', '2026-10-12 01:56:18'),
('資管四忠', 'S112001', '2026-10-12 01:56:18'),
('資管四忠', 'S112002', '2026-10-12 01:56:18'),
('資管四忠', 'S112005', '2026-10-12 01:56:18');

-- --------------------------------------------------------

--
-- 資料表結構 `class_notices`
--

CREATE TABLE `class_notices` (
  `id` int(11) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL COMMENT '班級通知的班級；課程 / 科系 / 年級 / 全校廣播為 NULL',
  `target_type` enum('班級','課程','科系','年級','全校') NOT NULL DEFAULT '班級' COMMENT '通知對象類型',
  `target_label` varchar(100) DEFAULT NULL COMMENT '對象說明，例：資料庫系統概論（資管五忠）、資訊管理科（五專）、全校',
  `whole_class` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = 整班；0 = 只發給個別學生',
  `title` varchar(80) NOT NULL,
  `content` text NOT NULL,
  `priority` enum('一般','重要','緊急') NOT NULL DEFAULT '一般',
  `sender` varchar(50) NOT NULL COMMENT '發送者姓名',
  `sender_username` varchar(50) DEFAULT NULL COMMENT '發送者帳號',
  `due_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reply_required` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='科上通知：通知內容';

--
-- 傾印資料表的資料 `class_notices`
--

INSERT INTO `class_notices` (`id`, `class_name`, `target_type`, `target_label`, `whole_class`, `title`, `content`, `priority`, `sender`, `sender_username`, `due_date`, `created_at`, `reply_required`) VALUES
(1, '資管五忠', '班級', '資管五忠', 1, '10/11 開班會', '請帶筆記本 跟筆', '緊急', '彭賓鈺 老師', 'teacher1', '2026-10-11', '2026-10-09 17:04:08', 0),
(2, '資管五忠', '班級', '資管五忠', 1, '10/11 開班會', '請帶筆記本 跟筆', '緊急', '彭賓鈺 老師', 'teacher1', '2026-10-11', '2026-10-09 17:04:08', 0),
(3, '資管五忠', '班級', '資管五忠', 0, '【示範流程】專題討論時間確認（待回覆）', '僅供老師與學生操作展示，並非正式活動或行政通知。請展開本通知，選擇回條後送出；期限前可更新回覆。', '一般', '彭賓鈺 老師', 'teacher1', '2026-10-27', '2026-10-20 01:46:16', 1),
(4, '資管五忠', '班級', '資管五忠', 0, '【示範流程】校園活動參加意願（部分回覆）', '僅供老師與學生操作展示，並非正式活動或行政通知。請展開本通知，選擇回條後送出；期限前可更新回覆。', '一般', '彭賓鈺 老師', 'teacher1', '2026-10-27', '2026-10-20 01:46:16', 1),
(5, '資管五忠', '班級', '資管五忠', 0, '【示範流程】學習資源收件確認（已收齊）', '僅供老師與學生操作展示，並非正式活動或行政通知。請展開本通知，選擇回條後送出；期限前可更新回覆。', '一般', '彭賓鈺 老師', 'teacher1', '2026-10-27', '2026-10-20 01:46:16', 1),
(6, '資管五忠', '班級', '資管五忠', 0, '回條提醒：【示範流程】校園活動參加意願（部分回覆）', '請至班級通知回覆原通知「【示範流程】校園活動參加意願（部分回覆）」的回條。', '重要', '彭賓鈺 老師', 'teacher1', '2026-10-27', '2026-10-20 01:48:12', 0),
(7, '資管五忠', '班級', '資管五忠', 0, '出缺勤提醒', '王小明 同學您好：\n「【示範】門檻後19小時」缺曠課 19 小時，達到扣考門檻，須由任課教師確認；\n「【示範】普通病假18小時」缺曠課 18 小時，達到扣考門檻，須由任課教師確認；\n「【示範】達門檻18小時」缺曠課 18 小時，達到扣考門檻，須由任課教師確認；\n「【示範】門檻前17小時」缺曠課 17 小時，距門檻 1 小時，請核對；\n「程式設計(一)」缺曠課 12 小時，距門檻 6 小時，請核對。\n此為缺曠課預警；未提供實際時數的紀錄屬估算，特殊假別及正式扣考須另行確認。\n請注意出席；如果是請假，記得盡快補辦假單。有困難可以來找導師談。', '緊急', '彭賓鈺 老師', 'teacher1', NULL, '2026-10-21 01:29:25', 0);

-- --------------------------------------------------------

--
-- 資料表結構 `class_notice_recipients`
--

CREATE TABLE `class_notice_recipients` (
  `notice_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL COMMENT 'NULL = 尚未讀',
  `reply` varchar(20) DEFAULT NULL,
  `reply_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='科上通知：收件人與已讀時間';

--
-- 傾印資料表的資料 `class_notice_recipients`
--

INSERT INTO `class_notice_recipients` (`notice_id`, `student_id`, `read_at`, `reply`, `reply_at`) VALUES
(1, '111534117', NULL, NULL, NULL),
(2, '111534117', NULL, NULL, NULL),
(3, 'S112001', NULL, NULL, NULL),
(3, 'S112002', '2026-10-20 01:47:05', '需要協助', '2026-10-20 09:47:11'),
(4, 'S112001', '2026-10-20 01:46:16', '會參加', '2026-10-20 09:46:16'),
(4, 'S112002', '2026-10-20 01:46:16', NULL, NULL),
(5, 'S112001', '2026-10-20 01:46:16', '收到', '2026-10-20 09:46:16'),
(5, 'S112002', '2026-10-20 01:46:16', '收到', '2026-10-20 09:46:16'),
(6, 'S112002', '2026-10-20 01:48:59', NULL, NULL),
(7, 'S112001', '2026-10-21 01:31:40', NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `class_schedule`
--

CREATE TABLE `class_schedule` (
  `id` int(11) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `student_id` varchar(20) DEFAULT NULL,
  `weekday` tinyint(4) NOT NULL COMMENT '1=週一 … 7=週日',
  `period_start` tinyint(4) NOT NULL,
  `period_end` tinyint(4) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `classroom` varchar(50) DEFAULT NULL,
  `teacher` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `class_schedule`
--

INSERT INTO `class_schedule` (`id`, `class_name`, `student_id`, `weekday`, `period_start`, `period_end`, `course_name`, `classroom`, `teacher`) VALUES
(1, '資管五忠', NULL, 1, 3, 4, '環境永續與社會責任', 'G203', '黃淑芬'),
(2, '資管五忠', NULL, 2, 1, 2, '基礎英文(二)', 'L201', 'Amy Chen'),
(3, '資管五忠', NULL, 2, 3, 5, '資料結構', 'A301', '林志明'),
(4, '資管五忠', NULL, 3, 3, 5, '資料庫系統概論', 'A402', '彭賓鈺'),
(5, '資管五忠', NULL, 4, 2, 4, '物件導向程式設計', 'A305 電腦教室', '吳建宏'),
(6, '資管五忠', NULL, 5, 3, 4, '跨領域思維與創新科技', 'G101', '李佩珊'),
(7, '資管五忠', NULL, 5, 6, 7, '班會 / 導師時間', 'A301', '彭賓鈺'),
(8, NULL, 'S112001', 1, 6, 7, '程式設計(一)', 'A303', '張文華'),
(9, NULL, 'S112001', 3, 6, 6, '程式設計(一)', 'A303', '張文華'),
(10, '資管五孝', NULL, 1, 1, 3, '資料結構', 'A301', '林志明'),
(11, '資管五孝', NULL, 2, 3, 4, '基礎英文(二)', 'L203', 'Amy Chen'),
(12, '資管五孝', NULL, 3, 2, 4, '物件導向程式設計', 'A305 電腦教室', '吳建宏'),
(13, '資管五孝', NULL, 4, 3, 5, '資料庫系統概論', 'A402', '彭賓鈺'),
(14, '資管五孝', NULL, 5, 6, 7, '班會 / 導師時間', 'A302', '林志明'),
(15, '護理四忠', NULL, 1, 1, 3, '內外科護理學', 'N201', '許美玲'),
(16, '護理四忠', NULL, 2, 1, 2, '藥理學', 'N203', '蔡宗翰'),
(17, '護理四忠', NULL, 3, 3, 4, '基礎英文(二)', 'L202', 'Amy Chen'),
(18, '護理四忠', NULL, 4, 1, 4, '基本護理學實驗', 'N105 技術教室', '許美玲'),
(19, '護理四忠', NULL, 5, 3, 4, '護理倫理', 'N201', '鄭如君'),
(80, '資管五忠', NULL, 1, 1, 2, '自習/班週會', 'C4060', '彭賓鈺'),
(81, '資管五忠', NULL, 1, 3, 8, '自習/班週會', 'C4110', '彭賓鈺'),
(82, '資管五忠', NULL, 2, 3, 4, '統計學', 'C4070', '彭賓鈺'),
(83, '資管五忠', NULL, 2, 6, 8, 'AI應用精準管理', 'C3060', '謝樹明'),
(84, '資管五忠', NULL, 3, 1, 2, '進階分類通識外語類(英文)', 'A201', '蔡維岳'),
(85, '資管五忠', NULL, 3, 5, 6, '校部週會', 'C4110', '彭賓鈺'),
(86, '資管五忠', NULL, 3, 7, 8, '社團活動', 'C4110', '彭賓鈺'),
(87, '資管五忠', NULL, 4, 5, 6, '資訊安全與智慧財產保護', 'C4110', '張丕白'),
(88, '資管五忠', NULL, 4, 8, 8, '統計學', 'C4070', '彭賓鈺'),
(89, '資管五忠', NULL, 5, 2, 4, '投資管理', 'C4110', '益西曲珍'),
(90, '資管五忠', NULL, 5, 5, 7, '商務智慧數據分析', 'C3050', '彭賓鈺'),
(91, '資管五忠', NULL, 6, 1, 1, '實務專題', 'C2060', '周建羽');

-- --------------------------------------------------------

--
-- 資料表結構 `counseling_records`
--

CREATE TABLE `counseling_records` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL COMMENT '記錄當時學生的班級',
  `talk_date` date NOT NULL COMMENT '晤談日期',
  `method` enum('面談','電話','線上','家長聯繫') NOT NULL DEFAULT '面談',
  `topic` enum('學業','出缺勤','生活','生涯','家庭','身心','其他') NOT NULL DEFAULT '其他',
  `content` text NOT NULL COMMENT '晤談內容 (個人隱私，學生與家長看不到)',
  `follow_up` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = 需要追蹤',
  `follow_up_note` varchar(200) DEFAULT NULL COMMENT '要追蹤什麼',
  `follow_up_done` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = 已追蹤完成',
  `counselor_username` varchar(50) NOT NULL COMMENT '記錄人帳號',
  `counselor_name` varchar(50) NOT NULL COMMENT '記錄人姓名',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `follow_up_date` date DEFAULT NULL,
  `tracking_status` varchar(20) NOT NULL DEFAULT '待聯繫',
  `tracking_result` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='導生關懷紀錄 (T14)';

--
-- 傾印資料表的資料 `counseling_records`
--

INSERT INTO `counseling_records` (`id`, `student_id`, `class_name`, `talk_date`, `method`, `topic`, `content`, `follow_up`, `follow_up_note`, `follow_up_done`, `counselor_username`, `counselor_name`, `created_at`, `updated_at`, `follow_up_date`, `tracking_status`, `tracking_result`) VALUES
(1, 'S112001', '資管五忠', '2026-10-20', '面談', '學業', '【示範流程】待聯繫：學習計畫確認。此為虛構操作情境，不代表學生真實狀況。', 1, '確認學生是否需要課程學習資源。', 0, 'teacher1', '彭賓鈺 老師', '2026-10-20 01:46:16', '2026-10-20 01:46:16', '2026-10-19', '待聯繫', ''),
(2, 'S112002', '資管五忠', '2026-10-20', '面談', '學業', '【示範流程】今日到期：專題進度確認。此為虛構操作情境，不代表學生真實狀況。', 1, '確認專題進度與下一次討論時間。', 1, 'teacher1', '彭賓鈺 老師', '2026-10-20 01:46:16', '2026-10-20 01:47:48', '2026-10-20', '已結案', '【示範操作】已確認專題討論時間並完成資源說明，本次追蹤結案。'),
(3, 'S112001', '資管五忠', '2026-10-20', '面談', '學業', '【示範流程】追蹤中：課程資源使用。此為虛構操作情境，不代表學生真實狀況。', 1, '下次確認課程資源是否合用。', 0, 'teacher1', '彭賓鈺 老師', '2026-10-20 01:46:16', '2026-10-20 01:46:16', '2026-10-23', '追蹤中', '已提供教材連結，預定再次確認。'),
(4, 'S112002', '資管五忠', '2026-10-20', '面談', '生涯', '【示範流程】已結案：生涯活動諮詢。此為虛構操作情境，不代表學生真實狀況。', 1, '確認活動資訊已收到。', 1, 'teacher1', '彭賓鈺 老師', '2026-10-20 01:46:16', '2026-10-20 01:46:16', '2026-10-18', '已結案', '已確認資訊收到，本筆展示結案。');

-- --------------------------------------------------------

--
-- 資料表結構 `course_map`
--

CREATE TABLE `course_map` (
  `course_id` varchar(20) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `credits` int(11) NOT NULL,
  `prerequisite_id` varchar(20) DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 1,
  `course_type` enum('專業必修','專業選修','通識教育','共同必修') NOT NULL DEFAULT '專業必修',
  `dept_id` varchar(20) NOT NULL DEFAULT 'CS',
  `semester_suggest` varchar(20) DEFAULT '大一上',
  `description` text DEFAULT NULL,
  `semester_hours` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `course_map`
--

INSERT INTO `course_map` (`course_id`, `course_name`, `credits`, `prerequisite_id`, `is_required`, `course_type`, `dept_id`, `semester_suggest`, `description`, `semester_hours`) VALUES
('5110311', '進階分類通識數學類', 2, NULL, 1, '通識教育', 'CS', NULL, NULL, NULL),
('5121124', '化學', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5125974', '臨床檢查報告判讀與應用', 2, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5340249', '中英文輸入', 1, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5340249B', '中英文輸入', 1, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5340310', '進階分類通識課程-國文藝術類(文學與人生)', 2, NULL, 1, '通識教育', 'CS', NULL, NULL, NULL),
('5340311', '進階分類通識數學類', 2, NULL, 1, '通識教育', 'CS', NULL, NULL, NULL),
('5340312', '進階分類通識課程-自然健康類(創意與創造)', 2, NULL, 1, '通識教育', 'CS', NULL, NULL, NULL),
('5341000', '服務學習與實踐', 0, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341000B', '服務學習與實踐', 0, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341030', '生涯規劃', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341045', '辦公室自動化', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341045B', '辦公室自動化', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341046', '資訊科技進階', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341093', '管理學', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341093B', '管理學', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341117', '會計學', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341117B', '會計學', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341259', '物理', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341320', '電腦繪圖與動畫', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341322', '商品攝影與後製', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341332', 'JAVA程式語言', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341332B', 'JAVA程式語言', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341393', '藝術生活', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341501', '康寧全人教育', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341506', '公民與社會', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341510', '音樂', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341514', '一年全民國防教育', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341514B', '一年全民國防教育', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341515', '一年體育', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341515B', '一年體育', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341518', '一年國文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341518B', '一年國文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341519', '一年英文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341519B', '一年英文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341521', '資訊科技', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341524', '一年數學', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341524B', '一年數學', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341602', '會計概論', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341602B', '會計概論', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341605', '數位化資料處理', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341605B', '數位化資料處理', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5341901', '一年康寧勞作教育', 0, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5341901B', '一年康寧勞作教育', 0, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342090', '經濟學', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342090B', '經濟學', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342110', '微積分', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342508', '化學', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342515', '二年體育', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342515B', '二年體育', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342520', '健康與護理', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342528', '二年國文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342528B', '二年國文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342807', '商業套裝軟體', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342807B', '商業套裝軟體', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342808', '行動網頁程式開發', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342808B', '行動網頁程式開發', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342809', '微電影製作', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342829', '程式設計', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342829B', '程式設計', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342831', '作業系統', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342833', '網頁設計', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342833B', '網頁設計', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5342901', '二年康寧勞作教育', 0, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5342901B', '二年康寧勞作教育', 0, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5343093', '統計學', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343096', '行銷管理', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343096B', '行銷管理', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343097H', '財務管理', 3, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5343113', '資料結構', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343117', '系統分析與設計', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343211H', '創意發明實務', 3, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5343346', '硬體裝修', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343346B', '硬體裝修', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343607', '行動應用服務開發', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343829', '計算機網路', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5343901', '三年康寧勞作教育', 0, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5344100', '溝通與簡報實務', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5344103H', '顧客關係管理', 3, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5344108', 'PYTHON程式語言', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5344109', '資料庫管理實務(SQL)', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5344110', '資料庫伺服器管理與實作', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5344123', '商務網站經營', 3, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5344219', '行銷企劃書撰寫', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5344220H', '多媒體設計', 3, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5344353H', 'Windows伺服器管理', 3, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5344356H', '響應式網頁設計', 3, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5344487H', '資訊管理企業實習', 9, NULL, 0, '專業選修', 'CS', NULL, NULL, NULL),
('5345617', '創意機器人', 2, NULL, 1, '專業必修', 'CS', NULL, NULL, NULL),
('5912222', '二年英文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5912222B', '二年英文', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5915191', '歷史', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5915424', '台灣手語', 2, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5920088', '體育─健康體適能', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('5920088B', '體育─健康體適能', 1, NULL, 1, '共同必修', 'CS', NULL, NULL, NULL),
('CS101', '計算機概論', 3, NULL, 1, '專業必修', 'CS', '大一上', '計算機科學基礎、電腦架構、二進位運算、作業系統與網路概論。', NULL),
('CS102', '程式設計(一)', 3, 'CS101', 1, '專業必修', 'CS', '大一下', 'Python 與 C 語言基礎邏輯、變數、迴圈、陣列與函式設計。', NULL),
('CS201', '資料結構', 3, 'CS102', 1, '專業必修', 'CS', '大二上', '陣列、鏈結串列、堆疊、佇列、二元樹、圖形演算法與搜尋排序。', NULL),
('CS202', '物件導向程式設計', 3, 'CS102', 1, '專業必修', 'CS', '大二下', '類別、封裝、繼承、多型、Java/C++ 實作與 GUI 設計。', NULL),
('CS301', '演算法分析', 3, 'CS201', 1, '專業必修', 'CS', '大三上', '時間複雜度、分治演算法、貪婪演算法、動態規劃與 NP 問題。', NULL),
('CS302', '資料庫系統概論', 3, 'CS201', 1, '專業必修', 'CS', '大三上', '關聯式資料庫、SQL 查詢最佳化、3NF 正規化與 MySQL/PostgreSQL 實務。', NULL),
('CS303', '網頁前後端開發實務', 3, 'CS102', 0, '專業選修', 'CS', '大三上', 'HTML5/Tailwind/FastAPI/Flask 全端系統整合與 REST API。', NULL),
('CS304', '雲端運算與虛擬化', 3, 'CS101', 0, '專業選修', 'CS', '大三下', 'Docker 容器化、Kubernetes、AWS 與微服務架構實戰。', NULL),
('CS305', '系統分析與設計', 3, 'CS201', 0, '專業選修', 'CS', '大四上', '需求訪談、UML、系統規格書撰寫。', NULL),
('CS306', '行動應用程式開發', 3, 'CS102', 0, '專業選修', 'CS', '大四下', 'Android / Flutter 行動 App 開發與上架。', NULL),
('CS401', '畢業專題研討(一)', 3, 'CS302', 1, '專業必修', 'CS', '大四上', '綜合資訊系統開發、專題實作、系統架構設計與成果展覽。', NULL),
('CS402', '畢業專題研討(二)', 3, 'CS401', 1, '專業必修', 'CS', '大四下', '畢業專題成果報告撰寫、系統部署與校外競賽發表。', NULL),
('DEMO_RISK_AFTER', '【示範】門檻後19小時', 3, NULL, 0, '專業必修', 'CS', '示範', '【示範】假設全學期54小時，僅供扣考門檻展示。', 54.00),
('DEMO_RISK_AT', '【示範】達門檻18小時', 3, NULL, 0, '專業必修', 'CS', '示範', '【示範】假設全學期54小時，僅供扣考門檻展示。', 54.00),
('DEMO_RISK_BEFORE', '【示範】門檻前17小時', 3, NULL, 0, '專業必修', 'CS', '示範', '【示範】假設全學期54小時，僅供扣考門檻展示。', 54.00),
('DEMO_RISK_SICK', '【示範】普通病假18小時', 3, NULL, 0, '專業必修', 'CS', '示範', '【示範】假設全學期54小時，僅供扣考門檻展示。', 54.00),
('EN101', '基礎英文(一)', 2, NULL, 1, '共同必修', 'CS', '大一上', '大一基礎外語聽說讀寫與實用生活英語。', NULL),
('EN102', '基礎英文(二)', 2, 'EN101', 1, '共同必修', 'CS', '大一下', '進階商用英文與學術閱讀報告寫作。', NULL),
('GE101', '大學之道與校園倫理', 2, NULL, 0, '通識教育', 'CS', '大一上', '校園生活適應、生命教育、學術誠信與職場倫理。', NULL),
('GE102', '跨領域思維與創新科技', 2, NULL, 0, '通識教育', 'CS', '大二上', '人工智慧生活應用、設計思考與數位轉型思維。', NULL),
('GE103', '環境永續與社會責任', 2, NULL, 0, '通識教育', 'CS', '大二下', 'ESG 永續發展目標、生態保育與社會公益實踐。', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `deadlines`
--

CREATE TABLE `deadlines` (
  `deadline_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `semester_week` int(11) DEFAULT 11,
  `start_date` date DEFAULT NULL,
  `end_date` date NOT NULL,
  `applies_to_role` varchar(20) NOT NULL DEFAULT 'all',
  `applies_to_dept` varchar(20) DEFAULT NULL,
  `related_system_url` varchar(300) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status_badge` varchar(50) DEFAULT '進行中'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `deadlines`
--

INSERT INTO `deadlines` (`deadline_id`, `title`, `category`, `semester_week`, `start_date`, `end_date`, `applies_to_role`, `applies_to_dept`, `related_system_url`, `description`, `status_badge`) VALUES
(1, '115-1 學期課程停修申請', '教務處課務組', 11, '2026-10-01', '2026-10-18', '學生', 'CS', 'http://talk.ukn.edu.tw/class_redi/class.php', '學期第 10-12 週開放停修申請，每人以 2 科為限，須完成導師與主任簽章。', '進行中 (剩 3 天)'),
(2, '期中預警評量與導師學習輔導訪談', '學務處/教務處', 11, '2026-10-05', '2026-10-20', '學生,老師,家長', 'CS', 'http://203.71.63.13/academic/', '期中成績不及格達 1/2 者列入預警，導師將安排個別學習輔導與座談。', '進行中 (剩 5 天)'),
(3, '大四應屆畢業生學分資格預審', '教務處註冊組', 11, '2026-09-15', '2026-11-30', '學生', 'CS', 'http://203.71.63.13/academic/', '大四學生請至註冊組核對必選修、通識與外語門檻缺口。', '進行中 (剩 35 天)'),
(4, '共同外語與證照學分抵免申請', '通識教育中心', 3, '2026-09-01', '2026-09-15', '學生', NULL, 'http://203.71.63.13/academic/', '大一共同外語抵免申請已截止，逾期者請於下學期初辦理。', '已截止'),
(5, '暑期重補修意願登記與開班調查', '教務處課務組', 14, '2026-11-01', '2026-11-20', '學生', 'CS', 'http://talk.ukn.edu.tw/class_redi/class.php', '先修科目不及格需重修者，可預先登記暑期課程開班意願。', '尚未開放');

-- --------------------------------------------------------

--
-- 資料表結構 `departments`
--

CREATE TABLE `departments` (
  `dept_id` varchar(20) NOT NULL,
  `dept_name` varchar(100) NOT NULL,
  `college_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `departments`
--

INSERT INTO `departments` (`dept_id`, `dept_name`, `college_name`) VALUES
('ANI', '數位影視動畫科（五專）', '商業資訊學院'),
('BA', '企業管理學系（科）', '商業資訊學院'),
('CS', '資訊管理科（五專）', '商業資訊學院'),
('ECE', '嬰幼兒保育學系', '護理健康學院'),
('ENG', '應用外語科（五專）', '商業資訊學院'),
('LTC', '長期照護學系', '護理健康學院'),
('NUR', '護理科（五專）', '護理健康學院'),
('OPT', '視光科（五專）', '護理健康學院');

-- --------------------------------------------------------

--
-- 資料表結構 `dorm_applications`
--

CREATE TABLE `dorm_applications` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `student_name` varchar(50) NOT NULL,
  `semester` varchar(20) NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `commute_minutes` int(11) NOT NULL,
  `special_needs` varchar(200) NOT NULL DEFAULT '',
  `emergency_phone` varchar(20) NOT NULL,
  `stage` int(11) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT '進行中',
  `bed` varchar(20) NOT NULL DEFAULT '',
  `note` varchar(200) NOT NULL DEFAULT '',
  `history_json` longtext NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `dorm_applications`
--

INSERT INTO `dorm_applications` (`id`, `student_id`, `student_name`, `semester`, `room_type`, `commute_minutes`, `special_needs`, `emergency_phone`, `stage`, `status`, `bed`, `note`, `history_json`, `created_at`) VALUES
(1, 'S112001', '王小明', '示範115-1', '四人房', 60, '【示範】虛構申請，供學生與家長同步展示', '0000000000', 4, '進行中', 'DEMO-S305-2', '', '[{\"stage\": 0, \"at\": \"2026-10-20 10:08:56\", \"note\": \"線上送件\"}, {\"stage\": 1, \"at\": \"2026-10-20 10:08:57\", \"note\": \"【示範】審核與床位分配\", \"status\": \"進行中\", \"reviewed_by\": \"dorm_demo\"}, {\"stage\": 2, \"at\": \"2026-10-20 10:08:57\", \"note\": \"【示範】審核與床位分配\", \"status\": \"進行中\", \"reviewed_by\": \"dorm_demo\"}, {\"stage\": 3, \"at\": \"2026-10-20 10:08:57\", \"note\": \"【示範】審核與床位分配\", \"status\": \"進行中\", \"reviewed_by\": \"dorm_demo\"}, {\"stage\": 4, \"at\": \"2026-10-21 09:30:43\", \"note\": \"【操作示範】確認床位，請依通知辦理繳費。\", \"status\": \"進行中\", \"reviewed_by\": \"dorm_demo\"}]', '2026-10-20 10:08:56'),
(2, 'S112002', '李美華', '示範115-1', '四人房', 60, '【示範】虛構申請，供學生與家長同步展示', '0000000000', 0, '未通過', '', '【示範】文件未齊，展示不通過結果', '[{\"stage\": 0, \"at\": \"2026-10-20 10:08:57\", \"note\": \"線上送件\"}, {\"stage\": 0, \"at\": \"2026-10-20 10:08:58\", \"note\": \"【示範】文件未齊，展示不通過結果\", \"status\": \"未通過\", \"reviewed_by\": \"dorm_demo\"}]', '2026-10-20 10:08:57');

-- --------------------------------------------------------

--
-- 資料表結構 `faculty_profiles`
--

CREATE TABLE `faculty_profiles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `dept_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fields` varchar(200) NOT NULL DEFAULT '' COMMENT '領域分類，逗號分隔',
  `expertise` varchar(400) NOT NULL COMMENT '專長關鍵字，逗號分隔',
  `research_summary` text DEFAULT NULL,
  `accepts_projects` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可指導專題',
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `faculty_profiles`
--

INSERT INTO `faculty_profiles` (`id`, `name`, `title`, `dept_name`, `email`, `fields`, `expertise`, `research_summary`, `accepts_projects`, `is_public`, `updated_at`) VALUES
(1, '彭賓鈺', '副教授', '資訊管理科', '', '資訊科技,人工智慧與資料分析', '機器學習,資料探勘,Python,學習分析', '運用機器學習分析學生學習歷程，預測學習落後並提供早期輔導建議。', 1, 1, '2026-10-08 06:56:44'),
(2, '林志明', '助理教授', '資訊管理科', '', '資訊安全與網路', '資訊安全,網路安全,滲透測試,雲端運算,Linux', '校園網路安全檢測與雲端服務架構，帶領學生參加資安競賽。', 1, 1, '2026-10-08 04:15:50'),
(3, '吳建宏', '講師', '資訊管理科', '', '資訊科技,數位媒體與動畫', '網頁開發,前端,行動應用,UI/UX', '響應式網站與行動應用程式設計，重視使用者體驗與無障礙設計。', 1, 1, '2026-10-08 04:15:50'),
(4, '張文華', '講師', '資訊管理科', '', '資訊科技,企業管理與行銷', '資料庫設計,SQL,ERP,電子商務', '企業資源規劃系統導入與電子商務平台資料庫設計。', 0, 1, '2026-10-08 04:15:50'),
(5, '黃淑芬', '副教授', '通識教育中心', '', '通識與人文社會', '生命教育,倫理學,服務學習', '生命教育與醫護倫理課程設計，推動社區服務學習。', 1, 1, '2026-10-08 04:15:50'),
(6, '李佩珊', '助理教授', '通識教育中心', '', '通識與人文社會,人工智慧與資料分析', '統計學,研究方法,問卷設計,資料分析', '健康行為調查的問卷設計與統計分析，可協助專題的研究方法與數據處理。', 1, 1, '2026-10-08 04:15:50'),
(7, 'Amy Chen', '講師', '應用外語科', '', '語言與外語教學', '英語會話,多益,商務英文', '多益與商務英語教學，指導英語簡報與口說競賽。', 1, 1, '2026-10-08 04:15:50'),
(8, '許美玲', '副教授', '護理科', '', '護理與健康照護,長期照護', '長期照護,老人護理,社區衛生', '社區長者健康促進與長照服務品質，與在地長照據點合作實習。', 1, 1, '2026-10-08 04:15:50'),
(9, '蔡宗翰', '助理教授', '護理科', '', '護理與健康照護,資訊科技', '重症護理,護理資訊,模擬教學', '以情境模擬與數位工具輔助護理技術教學。', 1, 1, '2026-10-08 04:15:50'),
(10, '鄭如君', '講師', '護理科', '', '護理與健康照護,幼兒教育與保育', '婦兒護理,母嬰照護,衛教設計', '母嬰照護衛教教材設計與親職教育。', 0, 1, '2026-10-08 04:15:50');

-- --------------------------------------------------------

--
-- 資料表結構 `graduation_requirements`
--

CREATE TABLE `graduation_requirements` (
  `req_id` int(11) NOT NULL,
  `dept_id` varchar(20) NOT NULL,
  `total_credits_req` int(11) NOT NULL DEFAULT 128,
  `major_required_req` int(11) NOT NULL DEFAULT 60,
  `major_elective_req` int(11) NOT NULL DEFAULT 30,
  `general_req` int(11) NOT NULL DEFAULT 28,
  `english_threshold_name` varchar(100) NOT NULL DEFAULT '多益 550 分或通過進階英文檢定',
  `ethics_req` int(11) NOT NULL DEFAULT 2,
  `project_req` int(11) NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `graduation_requirements`
--

INSERT INTO `graduation_requirements` (`req_id`, `dept_id`, `total_credits_req`, `major_required_req`, `major_elective_req`, `general_req`, `english_threshold_name`, `ethics_req`, `project_req`) VALUES
(1, 'CS', 220, 60, 30, 28, '多益測驗 550 分以上 或 通過進階實用英語檢定', 2, 6),
(2, 'NUR', 220, 75, 25, 28, '通過護理師國家考試門檻檢定', 2, 4),
(3, 'ENG', 220, 55, 35, 28, '多益測驗 750 分以上 或 雅思 6.0 以上', 2, 6);

-- --------------------------------------------------------

--
-- 資料表結構 `knowledge_base`
--

CREATE TABLE `knowledge_base` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory` varchar(50) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `official_term` varchar(255) DEFAULT '',
  `content` text NOT NULL,
  `doc_name` varchar(255) NOT NULL,
  `page` int(11) DEFAULT 1,
  `url` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `knowledge_base`
--

INSERT INTO `knowledge_base` (`id`, `category_id`, `subcategory`, `keyword`, `official_term`, `content`, `doc_name`, `page`, `url`) VALUES
(1, 1, '選課與停修', '棄修', '停修', '學生於加退選截止後，因特殊原因無法繼續修習某門課程，得於學期第 10-12 週申請停修（每學期以 2 科為限）。停修課程仍須登記於歷年成績單，但成績欄註記「停修」，不計入該學期學分數計算，且停修後學分數不得低於該學期最低應修學分。', '康寧大學學生學則.pdf', 12, 'https://www.ukn.edu.tw/p/412-1000-381.php?Lang=zh-tw'),
(2, 2, '出缺勤請假', '病假', '學生請假規定', '學生因病無法到校上課，應於請假日當日起 3 日內（含例假日）登入校務系統提出線上請假申請，並檢附健保特約醫療院所開立之就醫證明或診斷書，經導師核准後始完成請假手續。', '康寧大學學生請假規則.pdf', 5, 'https://www.ukn.edu.tw/p/412-1000-382.php?Lang=zh-tw'),
(3, 3, '語言證照抵免', '英文抵免', '語言證照抵免', '學生取得多益測驗 (TOEIC) 550 分以上、全民英檢 (GEPT) 中級複試通過或同等級國際外語證照者，得於每學期開學後至加退選截止前，檢附成績單正本與影本至通識教育中心申請抵免大一共同外語「基礎英文(一)」及「基礎英文(二)」共 4 學分。', '康寧大學共同外語學分抵免辦法.pdf', 3, 'https://www.ukn.edu.tw/p/412-1000-383.php?Lang=zh-tw'),
(4, 1, '擋修與先修', '擋修', '先修科目未通過', '本校各科系必修課程若訂有先修科目限制（例如：程式設計(一) 為 資料結構 之先修科目），學生該先修科目未達及格標準（60 分）者，電腦選課系統將自動擋修，不得修習後續先修關聯課程，需待先修科目重修及格後始得修習。', '康寧大學課程選修要點.pdf', 8, 'https://www.ukn.edu.tw/p/412-1000-384.php?Lang=zh-tw'),
(5, 3, '專業證照獎勵', '證照補助', '學生取得專業證照獎勵辦法', '學生在學期間取得教育部認可之乙級以上技術士證照或國際專業原廠認證，每張最高可申請新台幣 3,000 至 10,000 元獎勵金。申請期間為每學期第 1 至 5 週，請至研發處實習就業組辦理。', '康寧大學學生專業證照獎勵要點.pdf', 2, 'https://www.ukn.edu.tw/p/412-1000-385.php?Lang=zh-tw');

-- --------------------------------------------------------

--
-- 資料表結構 `knowledge_categories`
--

CREATE TABLE `knowledge_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `icon` varchar(20) DEFAULT '?',
  `sort_order` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `knowledge_categories`
--

INSERT INTO `knowledge_categories` (`category_id`, `category_name`, `icon`, `sort_order`) VALUES
(1, '教務學則與選課', '📖', 1),
(2, '學務生輔與請假', '📝', 2),
(3, '證照抵免與獎助', '🏆', 3),
(4, '總務校園與設施', '🏢', 4);

-- --------------------------------------------------------

--
-- 資料表結構 `leave_requests`
--

CREATE TABLE `leave_requests` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `leave_type` enum('病假','事假','公假','喪假','生理假') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `periods` varchar(50) DEFAULT NULL COMMENT '節次，例如 3-4',
  `reason` varchar(255) DEFAULT NULL,
  `status` enum('待審核','已核准','已退回') NOT NULL DEFAULT '待審核',
  `review_note` varchar(255) NOT NULL DEFAULT '',
  `submitted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `leave_requests`
--

INSERT INTO `leave_requests` (`id`, `student_id`, `leave_type`, `start_date`, `end_date`, `periods`, `reason`, `status`, `review_note`, `submitted_at`) VALUES
(1, 'S112001', '病假', '2026-09-18', '2026-09-18', '3-4', '發燒就醫', '已核准', '', '2026-09-18 08:30:00'),
(2, 'S112001', '事假', '2026-09-30', '2026-09-30', '3-5', '家中有事需返鄉', '待審核', '', '2026-09-22 21:10:00'),
(3, 'S112002', '病假', '2026-09-16', '2026-09-16', '3-5', '腸胃炎', '已核准', '', '2026-09-16 07:45:00'),
(4, 'S112005', '事假', '2026-09-22', '2026-09-22', '1-2', '機車故障', '已退回', '請補附相關證明後重新申請', '2026-09-22 09:20:00'),
(5, 'S112001', '事假', '2026-10-20', '2026-10-20', '3-4', '【模擬串接】待審事假展示', '待審核', '', '2026-10-20 10:08:56'),
(6, 'S112002', '事假', '2026-10-20', '2026-10-20', '3-4', '【模擬串接】已核准事假展示', '已核准', '【示範】假單資料讀取驗證', '2026-10-20 10:08:56');

-- --------------------------------------------------------

--
-- 資料表結構 `moodle_links`
--

CREATE TABLE `moodle_links` (
  `student_id` varchar(20) NOT NULL,
  `moodle_username` varchar(100) NOT NULL,
  `moodle_fullname` varchar(100) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `linked_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `moodle_links`
--

INSERT INTO `moodle_links` (`student_id`, `moodle_username`, `moodle_fullname`, `token`, `linked_at`) VALUES
('111534117', '111534117', '111534117 張晴茹', '72d61efdbb246f0d7cb7245c7d7bae9e', '2026-09-24 13:03:00');

-- --------------------------------------------------------

--
-- 資料表結構 `scholarships`
--

CREATE TABLE `scholarships` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `provider` enum('校內','校外') NOT NULL DEFAULT '校內',
  `amount` int(11) DEFAULT NULL,
  `deadline` date NOT NULL,
  `apply_url` varchar(300) DEFAULT NULL,
  `announcement_url` varchar(300) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `min_grade` tinyint(4) DEFAULT NULL,
  `max_grade` tinyint(4) DEFAULT NULL,
  `departments` varchar(200) DEFAULT NULL COMMENT '適用科系代碼，逗號分隔；NULL 代表全校',
  `min_gpa` decimal(3,2) DEFAULT NULL,
  `min_conduct` decimal(5,2) DEFAULT NULL,
  `identity_required` varchar(100) DEFAULT NULL COMMENT '符合任一身分即可，逗號分隔；NULL 代表不限',
  `no_fail_required` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否要求前學期無不及格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `scholarships`
--

INSERT INTO `scholarships` (`id`, `name`, `provider`, `amount`, `deadline`, `apply_url`, `announcement_url`, `description`, `min_grade`, `max_grade`, `departments`, `min_gpa`, `min_conduct`, `identity_required`, `no_fail_required`) VALUES
(1, '書卷獎（學業優異獎學金）', '校內', 5000, '2026-10-15', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '各班前學期學業成績優異者，依排名核發。', 2, 5, NULL, 3.50, 80.00, NULL, 1),
(2, '清寒助學金', '校內', 10000, '2026-09-28', 'https://ec2.ukn.edu.tw/WebRemit/login.aspx', 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '協助家境清寒學生安心就學，需檢附低收入戶或中低收入戶證明。', NULL, NULL, NULL, NULL, 70.00, '低收入戶,中低收入戶', 0),
(3, '原住民族學生獎助學金', '校外', 15000, '2026-10-31', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '原住民族委員會補助原住民族學生就學。', NULL, NULL, NULL, 2.50, NULL, '原住民', 0),
(4, '身心障礙學生獎助學金', '校外', 12000, '2026-11-15', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '教育部補助持有身心障礙證明之學生。', NULL, NULL, NULL, NULL, NULL, '身心障礙', 0),
(5, '資訊管理科專題研究獎學金', '校內', 8000, '2026-10-05', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '鼓勵高年級學生投入專題研究，需檢附專題計畫書。', 3, 5, 'CS', 3.00, NULL, NULL, 0),
(6, '產學合作企業獎學金', '校外', 20000, '2026-09-30', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '產學合作企業提供資訊管理科學生申請，錄取者可優先參加企業實習。', 1, 5, 'CS', 3.30, 85.00, NULL, 1),
(7, '弱勢學生助學金', '校外', 8000, '2026-10-20', 'https://ec2.ukn.edu.tw/WebRemit/login.aspx', 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '教育部大專校院弱勢學生助學計畫，符合任一身分即可申請。', NULL, NULL, NULL, NULL, NULL, '低收入戶,中低收入戶,原住民,身心障礙', 0),
(8, '護理科實習獎學金', '校內', 5000, '2026-10-10', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '補助護理科學生臨床實習期間交通與生活支出。', 2, 5, 'NUR', NULL, 80.00, NULL, 0),
(9, '學海飛颺（出國研修）', '校外', 50000, '2026-09-15', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '教育部補助學生赴國外研修一學期。', 2, 5, NULL, 3.00, NULL, NULL, 0),
(10, '品德楷模獎學金', '校內', 3000, '2026-11-30', NULL, 'https://sa.ukn.edu.tw/p/412-1003-4377.php?Lang=zh-tw', '表揚操行表現優良、熱心服務的學生。', NULL, NULL, NULL, 3.00, 88.00, NULL, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `search_feedback`
--

CREATE TABLE `search_feedback` (
  `feedback_id` int(11) NOT NULL,
  `kb_id` int(11) DEFAULT NULL,
  `query_text` varchar(255) NOT NULL,
  `is_helpful` tinyint(1) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `search_feedback`
--

INSERT INTO `search_feedback` (`feedback_id`, `kb_id`, `query_text`, `is_helpful`, `comment`, `created_at`) VALUES
(1, 1, '棄修', 1, '流程很清楚，知道要去課務組了！', '2026-09-24 04:10:29'),
(2, 4, '擋修', 1, '終於知道為什麼不能選資料結構了', '2026-09-24 04:10:29'),
(3, 3, '英文抵免', 1, '感謝提供多益 550 分門檻資訊', '2026-09-24 04:10:29'),
(4, 2, '病假', 0, '希望能直接線上送假單，不想跑流程', '2026-09-24 04:10:29');

-- --------------------------------------------------------

--
-- 資料表結構 `search_logs`
--

CREATE TABLE `search_logs` (
  `id` int(11) NOT NULL,
  `query` varchar(255) NOT NULL,
  `matched` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `search_logs`
--

INSERT INTO `search_logs` (`id`, `query`, `matched`, `created_at`) VALUES
(1, '棄修', 1, '2026-10-15 01:22:15'),
(2, '請假', 1, '2026-10-21 14:51:58');

-- --------------------------------------------------------

--
-- 資料表結構 `self_reviews`
--

CREATE TABLE `self_reviews` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `semester` varchar(10) NOT NULL COMMENT '學年-學期，例如 115-1',
  `ratings_json` text NOT NULL COMMENT '各項 1-5 分',
  `reflections_json` text NOT NULL COMMENT '文字反思',
  `status` enum('草稿','已完成') NOT NULL DEFAULT '草稿',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `students`
--

CREATE TABLE `students` (
  `student_id` varchar(20) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `dept_id` varchar(20) NOT NULL,
  `admission_year` int(11) NOT NULL,
  `class_name` varchar(50) NOT NULL,
  `parent_phone` varchar(30) DEFAULT NULL,
  `grade_level` tinyint(4) DEFAULT NULL,
  `gpa` decimal(3,2) DEFAULT NULL,
  `conduct_score` decimal(5,2) DEFAULT NULL,
  `identity_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `students`
--

INSERT INTO `students` (`student_id`, `full_name`, `dept_id`, `admission_year`, `class_name`, `parent_phone`, `grade_level`, `gpa`, `conduct_score`, `identity_type`) VALUES
('111534101', '許浩宥', 'CS', 111, '資管五忠', '0968-429-350', 5, 2.14, 91.00, '低收入戶'),
('111534102', '羅宥萱', 'CS', 111, '資管五忠', '0995-670-649', 5, 1.40, 92.00, '中低收入戶'),
('111534103', '楊欣傑', 'CS', 111, '資管五忠', '0928-468-574', 5, 3.30, 83.00, '中低收入戶'),
('111534104', '陳豪思', 'CS', 111, '資管五忠', '0944-296-455', 5, 2.03, 86.00, '身心障礙'),
('111534105', '朱芷冠', 'CS', 111, '資管五忠', '0979-712-969', 5, 3.12, 91.00, '原住民'),
('111534106', '蕭亭均', 'CS', 111, '資管五忠', '0992-785-573', 5, 2.03, 91.00, '新住民子女'),
('111534107', '梁涵妍', 'CS', 111, '資管五忠', '0999-275-477', 5, 1.37, 91.00, NULL),
('111534108', '廖郁建', 'CS', 111, '資管五忠', '0953-599-606', 5, 1.44, 91.00, NULL),
('111534109', '陳瑄穎', 'CS', 111, '資管五忠', '0960-529-876', 5, 1.12, 86.00, NULL),
('111534110', '曾睿浩', 'CS', 111, '資管五忠', '0912-695-384', 5, 0.95, 78.00, NULL),
('111534111', '翁雅豪', 'CS', 111, '資管五忠', '0956-210-533', 5, 1.04, 86.00, NULL),
('111534112', '游宏翰', 'CS', 111, '資管五忠', '0935-659-653', 5, 0.95, 72.00, NULL),
('111534113', '吳詠翰', 'CS', 111, '資管五忠', '0943-627-791', 5, 3.31, 83.00, NULL),
('111534114', '彭建妍', 'CS', 111, '資管五忠', '0932-541-230', 5, 3.47, 85.00, NULL),
('111534115', '魏宇君', 'CS', 111, '資管五忠', '0920-245-899', 5, 3.38, 86.00, NULL),
('111534116', '盧彥穎', 'CS', 111, '資管五忠', '0951-699-364', 5, 3.05, 89.00, NULL),
('111534117', '張晴茹', 'CS', 111, '資管五忠', NULL, 5, 3.50, 85.00, NULL),
('111534118', '吳詠浩', 'CS', 111, '資管五忠', '0955-810-371', 5, 2.01, 92.00, NULL),
('111534119', '邱彤子', 'CS', 111, '資管五忠', '0952-849-663', 5, 1.88, 88.00, NULL),
('111534120', '何品嘉', 'CS', 111, '資管五忠', '0950-594-972', 5, 2.32, 83.00, NULL),
('111534121', '高涵晴', 'CS', 111, '資管五忠', '0981-967-268', 5, 2.21, 90.00, NULL),
('111534122', '徐翔婷', 'CS', 111, '資管五忠', '0987-327-800', 5, 2.20, 84.00, NULL),
('111534123', '魏欣思', 'CS', 111, '資管五忠', '0937-994-430', 5, 2.00, 92.00, NULL),
('111534124', '何涵傑', 'CS', 111, '資管五忠', '0940-855-633', 5, 2.11, 89.00, NULL),
('111534125', '周承妍', 'CS', 111, '資管五忠', '0968-289-957', 5, 2.07, 91.00, NULL),
('111534201', '鄭柏瑄', 'CS', 111, '資管五孝', '0934-374-432', 5, 2.39, 91.00, '中低收入戶'),
('111534202', '羅欣育', 'CS', 111, '資管五孝', '0926-333-876', 5, 1.27, 84.00, NULL),
('111534203', '游瑄語', 'CS', 111, '資管五孝', '0910-929-375', 5, 3.32, 82.00, NULL),
('111534204', '詹翰婷', 'CS', 111, '資管五孝', '0975-877-833', 5, 3.31, 90.00, NULL),
('111534205', '游明宏', 'CS', 111, '資管五孝', '0995-789-214', 5, 1.30, 85.00, NULL),
('111534206', '盧家秉', 'CS', 111, '資管五孝', '0988-772-518', 5, 2.07, 86.00, NULL),
('111534207', '游筱宇', 'CS', 111, '資管五孝', '0969-927-851', 5, 2.01, 89.00, NULL),
('111534208', '魏妤明', 'CS', 111, '資管五孝', '0930-347-849', 5, 2.13, 86.00, NULL),
('111534209', '高詠恩', 'CS', 111, '資管五孝', '0997-801-554', 5, 2.20, 82.00, NULL),
('112534101', '施晴欣', 'CS', 112, '資管四忠', '0971-562-808', 4, 2.14, 85.00, '中低收入戶'),
('112534102', '葉彤婷', 'CS', 112, '資管四忠', '0956-703-842', 4, 1.18, 91.00, NULL),
('112534103', '彭子浩', 'CS', 112, '資管四忠', '0911-789-475', 4, 3.52, 87.00, NULL),
('112534104', '盧誠涵', 'CS', 112, '資管四忠', '0947-533-195', 4, 3.24, 85.00, NULL),
('112534105', '陳建翰', 'CS', 112, '資管四忠', '0968-594-616', 4, 1.12, 87.00, NULL),
('112534106', '簡家傑', 'CS', 112, '資管四忠', '0952-924-290', 4, 1.90, 84.00, NULL),
('112534107', '謝誠晴', 'CS', 112, '資管四忠', '0919-179-691', 4, 1.98, 88.00, NULL),
('112534108', '洪家誠', 'CS', 112, '資管四忠', '0995-399-584', 4, 1.89, 85.00, NULL),
('112534109', '孫嘉傑', 'CS', 112, '資管四忠', '0989-554-151', 4, 2.18, 86.00, NULL),
('113534101', '吳廷萱', 'CS', 113, '資管三忠', '0976-408-626', 3, 2.53, 87.00, '中低收入戶'),
('113534102', '邱均宗', 'CS', 113, '資管三忠', '0923-724-347', 3, 1.01, 91.00, NULL),
('113534103', '吳萱瑄', 'CS', 113, '資管三忠', '0975-943-657', 3, 3.28, 89.00, NULL),
('113534104', '施婷彤', 'CS', 113, '資管三忠', '0934-644-490', 3, 3.62, 86.00, NULL),
('113534105', '葉涵廷', 'CS', 113, '資管三忠', '0948-916-427', 3, 1.13, 84.00, NULL),
('113534106', '王志君', 'CS', 113, '資管三忠', '0911-429-576', 3, 2.10, 84.00, NULL),
('113534107', '孫芷宇', 'CS', 113, '資管三忠', '0987-815-756', 3, 2.24, 90.00, NULL),
('113534108', '盧晴欣', 'CS', 113, '資管三忠', '0983-404-677', 3, 1.79, 91.00, NULL),
('113534109', '顏彥雅', 'CS', 113, '資管三忠', '0915-824-100', 3, 2.35, 82.00, NULL),
('114534101', '戴佳郁', 'CS', 114, '資管二忠', '0956-540-694', 2, 2.57, 92.00, '中低收入戶'),
('114534102', '許語育', 'CS', 114, '資管二忠', '0995-256-544', 2, 0.95, 82.00, NULL),
('114534103', '魏詠涵', 'CS', 114, '資管二忠', '0921-817-118', 2, 3.32, 90.00, NULL),
('114534104', '高涵佳', 'CS', 114, '資管二忠', '0919-823-979', 2, 3.47, 86.00, NULL),
('114534105', '趙誠建', 'CS', 114, '資管二忠', '0972-353-305', 2, 1.08, 88.00, NULL),
('114534106', '周均庭', 'CS', 114, '資管二忠', '0944-331-309', 2, 1.85, 83.00, NULL),
('114534107', '葉宏芷', 'CS', 114, '資管二忠', '0961-977-141', 2, 2.04, 91.00, NULL),
('114534108', '趙承涵', 'CS', 114, '資管二忠', '0930-319-905', 2, 2.14, 89.00, NULL),
('114534109', '蕭品建', 'CS', 114, '資管二忠', '0916-269-484', 2, 2.07, 92.00, NULL),
('115534101', '何宇秉', 'CS', 115, '資管一忠', '0986-956-822', 1, NULL, 84.00, '中低收入戶'),
('115534102', '張宇庭', 'CS', 115, '資管一忠', '0969-801-224', 1, NULL, 92.00, NULL),
('115534103', '游郁浩', 'CS', 115, '資管一忠', '0999-285-842', 1, NULL, 92.00, NULL),
('115534104', '鍾志嘉', 'CS', 115, '資管一忠', '0966-944-710', 1, NULL, 87.00, NULL),
('115534105', '郭均瑄', 'CS', 115, '資管一忠', '0927-887-397', 1, NULL, 86.00, NULL),
('115534106', '許俊豪', 'CS', 115, '資管一忠', '0999-916-348', 1, NULL, 82.00, NULL),
('115534107', '游俊嘉', 'CS', 115, '資管一忠', '0971-872-104', 1, NULL, 87.00, NULL),
('115534108', '施家涵', 'CS', 115, '資管一忠', '0971-715-127', 1, NULL, 87.00, NULL),
('115534109', '盧語晨', 'CS', 115, '資管一忠', '0976-744-832', 1, NULL, 83.00, NULL),
('S112001', '王小明', 'CS', 112, '資管五忠', '0912-345-678', 4, 3.35, 86.00, '中低收入戶'),
('S112002', '李美華', 'CS', 112, '資管五忠', '0922-333-444', 4, 3.62, 88.00, NULL),
('S112003', '張建華', 'NUR', 112, '護理四忠', '0933-555-666', 4, 3.10, 85.00, '原住民'),
('S112004', '陳冠宇', 'CS', 112, '資管五孝', '0955-222-111', 4, 3.85, 90.00, NULL),
('S112005', '林雨潔', 'CS', 112, '資管五忠', '0966-777-888', 4, 3.20, 86.00, '低收入戶');

-- --------------------------------------------------------

--
-- 資料表結構 `student_credits`
--

CREATE TABLE `student_credits` (
  `credit_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `course_id` varchar(20) NOT NULL,
  `semester` varchar(20) NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `is_passed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `student_credits`
--

INSERT INTO `student_credits` (`credit_id`, `student_id`, `course_id`, `semester`, `score`, `is_passed`) VALUES
(1, 'S112001', 'CS101', '112-1', 85.00, 1),
(2, 'S112001', 'CS102', '112-2', 55.00, 0),
(3, 'S112001', 'EN101', '112-1', 78.00, 1),
(4, 'S112001', 'GE101', '112-1', 82.00, 1),
(5, 'S112002', 'CS101', '112-1', 92.50, 1),
(6, 'S112002', 'CS102', '112-2', 88.00, 1),
(7, 'S112002', 'CS201', '113-1', 85.00, 1),
(8, 'S112002', 'EN101', '112-1', 80.00, 1),
(9, 'S112002', 'GE101', '112-1', 90.00, 1),
(10, 'S112004', 'CS101', '112-1', 88.00, 1),
(11, 'S112004', 'CS102', '112-2', 91.00, 1),
(12, 'S112004', 'CS201', '113-1', 84.00, 1),
(13, 'S112004', 'EN101', '112-1', 80.00, 1),
(14, 'S112004', 'CS202', '113-2', 79.00, 1),
(15, 'S112004', 'GE101', '112-1', 86.00, 1),
(16, 'S112005', 'CS101', '112-1', 76.00, 1),
(17, 'S112005', 'CS102', '112-2', 68.00, 1),
(18, 'S112005', 'CS201', '113-1', 48.00, 0),
(19, 'S112005', 'EN101', '112-1', 81.00, 1),
(20, 'S112005', 'GE101', '112-1', 88.00, 1),
(411, '111534117', '5341501', '111-1', 80.00, 1),
(412, '111534117', '5341514', '111-1', 77.00, 1),
(413, '111534117', '5341901', '111-1', 91.00, 1),
(414, '111534117', '5341510', '111-1', 80.00, 1),
(415, '111534117', '5341515', '111-1', 82.00, 1),
(416, '111534117', '5341518', '111-1', 87.00, 1),
(417, '111534117', '5341519', '111-1', 66.00, 1),
(418, '111534117', '5341521', '111-1', 85.00, 1),
(419, '111534117', '5341524', '111-1', 92.00, 1),
(420, '111534117', '5340249', '111-1', 70.00, 1),
(421, '111534117', '5341093', '111-1', 81.00, 1),
(422, '111534117', '5341602', '111-1', 70.00, 1),
(423, '111534117', '5341605', '111-1', 74.00, 1),
(424, '111534117', '5342829', '111-1', 60.00, 1),
(425, '111534117', '5343346', '111-1', 64.00, 1),
(426, '111534117', '5345617', '111-1', 95.00, 1),
(427, '111534117', '5341514B', '111-2', 71.00, 1),
(428, '111534117', '5341901B', '111-2', 76.00, 1),
(429, '111534117', '5341515B', '111-2', 88.00, 1),
(430, '111534117', '5341518B', '111-2', 76.00, 1),
(431, '111534117', '5341519B', '111-2', 60.00, 1),
(432, '111534117', '5341524B', '111-2', 70.00, 1),
(433, '111534117', '5340249B', '111-2', 68.00, 1),
(434, '111534117', '5341046', '111-2', 68.00, 1),
(435, '111534117', '5341093B', '111-2', 61.00, 1),
(436, '111534117', '5341320', '111-2', 60.00, 1),
(437, '111534117', '5341322', '111-2', 81.00, 1),
(438, '111534117', '5341602B', '111-2', 71.00, 1),
(439, '111534117', '5341605B', '111-2', 87.00, 1),
(440, '111534117', '5342829B', '111-2', 60.00, 1),
(441, '111534117', '5343346B', '111-2', 63.00, 1),
(442, '111534117', '5341000', '112-1', 80.00, 1),
(443, '111534117', '5342901', '112-1', 65.00, 1),
(444, '111534117', '5341259', '112-1', 68.00, 1),
(445, '111534117', '5342515', '112-1', 60.00, 1),
(446, '111534117', '5342520', '112-1', 68.00, 1),
(447, '111534117', '5342528', '112-1', 60.00, 1),
(448, '111534117', '5912222', '112-1', 60.00, 1),
(449, '111534117', '5341117', '112-1', 60.00, 1),
(450, '111534117', '5342807', '112-1', 23.00, 0),
(451, '111534117', '5342808', '112-1', 60.00, 1),
(452, '111534117', '5342809', '112-1', 70.00, 1),
(453, '111534117', '5342833', '112-1', 68.00, 1),
(454, '111534117', '5343093', '112-1', 30.00, 0),
(455, '111534117', '5343096', '112-1', 55.00, 0),
(456, '111534117', '5341000B', '112-2', 85.00, 1),
(457, '111534117', '5342901B', '112-2', 82.00, 1),
(458, '111534117', '5342508', '112-2', 55.00, 0),
(459, '111534117', '5342515B', '112-2', 61.00, 1),
(460, '111534117', '5342528B', '112-2', 60.00, 1),
(461, '111534117', '5912222B', '112-2', 60.00, 1),
(462, '111534117', '5915191', '112-2', 65.00, 1),
(463, '111534117', '5341117B', '112-2', 60.00, 1),
(464, '111534117', '5342110', '112-2', 48.00, 0),
(465, '111534117', '5342807B', '112-2', 60.00, 1),
(466, '111534117', '5342808B', '112-2', 50.00, 0),
(467, '111534117', '5342833B', '112-2', 60.00, 1),
(468, '111534117', '5343096B', '112-2', 65.00, 1),
(469, '111534117', '5343901', '113-1', 85.00, 1),
(470, '111534117', '5341393', '113-1', 83.00, 1),
(471, '111534117', '5341506', '113-1', 83.00, 1),
(472, '111534117', '5920088', '113-1', 76.00, 1),
(473, '111534117', '5341045', '113-1', 82.00, 1),
(474, '111534117', '5341332', '113-1', 73.00, 1),
(475, '111534117', '5342090', '113-1', 71.00, 1),
(476, '111534117', '5342831', '113-1', 69.00, 1),
(477, '111534117', '5343113', '113-1', 71.00, 1),
(478, '111534117', '5344110', '113-1', 66.00, 1),
(479, '111534117', '5344219', '113-1', 89.00, 1),
(480, '111534117', '5341030', '113-2', 70.00, 1),
(481, '111534117', '5915424', '113-2', 65.00, 1),
(482, '111534117', '5920088B', '113-2', 80.00, 1),
(483, '111534117', '5341045B', '113-2', 75.00, 1),
(484, '111534117', '5341332B', '113-2', 63.00, 1),
(485, '111534117', '5342090B', '113-2', 87.00, 1),
(486, '111534117', '5343117', '113-2', 80.00, 1),
(487, '111534117', '5343829', '113-2', 86.00, 1),
(488, '111534117', '5344109', '113-2', 83.00, 1),
(489, '111534117', '5344123', '113-2', 75.00, 1),
(490, '111534117', '5343607', '114-1', 77.00, 1),
(491, '111534117', '5344100', '114-1', 86.00, 1),
(492, '111534117', '5344108', '114-1', 72.00, 1),
(493, '111534117', '5125974', '112-2', 81.00, 1),
(494, '111534117', '5344220H', '112-2', 67.00, 1),
(495, '111534117', '5344103H', '113-1', 62.00, 1),
(496, '111534117', '5343211H', '113-2', 92.00, 1),
(497, '111534117', '5343097H', '114-1', 89.00, 1),
(498, '111534117', '5344353H', '114-1', 84.00, 1),
(499, '111534117', '5344356H', '114-1', 84.00, 1),
(500, '111534117', '5344487H', '114-2', 82.00, 1),
(501, '111534117', '5340311', '112-1', 45.00, 0),
(502, '111534117', '5110311', '113-1', 79.00, 1),
(503, '111534117', '5343096', '113-1', 62.00, 1),
(504, '111534117', '5121124', '113-2', 60.00, 1),
(505, '111534117', '5342808B', '113-2', 63.00, 1),
(506, '111534117', '5340310', '114-1', 73.00, 1),
(507, '111534117', '5340312', '114-1', 93.00, 1),
(508, '111534117', '5342807', '114-1', 60.00, 1),
(1313, '114534101', 'CS101', '114-1', 74.80, 1),
(1314, '114534101', 'EN101', '114-1', 85.80, 1),
(1315, '114534101', 'GE101', '114-1', 80.60, 1),
(1316, '114534101', 'CS102', '114-2', 89.50, 1),
(1317, '114534101', 'EN102', '114-2', 72.90, 1),
(1318, '114534102', 'CS101', '114-1', 47.20, 0),
(1319, '114534102', 'EN101', '114-1', 69.70, 1),
(1320, '114534102', 'GE101', '114-1', 64.20, 1),
(1321, '114534102', 'CS102', '114-2', 75.00, 1),
(1322, '114534102', 'EN102', '114-2', 66.60, 1),
(1323, '114534103', 'CS101', '114-1', 95.50, 1),
(1324, '114534103', 'EN101', '114-1', 80.20, 1),
(1325, '114534103', 'GE101', '114-1', 89.20, 1),
(1326, '114534103', 'CS102', '114-2', 85.50, 1),
(1327, '114534103', 'EN102', '114-2', 90.60, 1),
(1328, '114534104', 'CS101', '114-1', 97.20, 1),
(1329, '114534104', 'EN101', '114-1', 87.10, 1),
(1330, '114534104', 'GE101', '114-1', 80.40, 1),
(1331, '114534104', 'CS102', '114-2', 93.20, 1),
(1332, '114534104', 'EN102', '114-2', 90.40, 1),
(1333, '114534105', 'CS101', '114-1', 76.60, 1),
(1334, '114534105', 'EN101', '114-1', 64.10, 1),
(1335, '114534105', 'GE101', '114-1', 71.10, 1),
(1336, '114534105', 'CS102', '114-2', 50.10, 0),
(1337, '114534105', 'EN102', '114-2', 67.10, 1),
(1338, '114534106', 'CS101', '114-1', 81.00, 1),
(1339, '114534106', 'EN101', '114-1', 73.80, 1),
(1340, '114534106', 'GE101', '114-1', 77.70, 1),
(1341, '114534106', 'CS102', '114-2', 63.90, 1),
(1342, '114534106', 'EN102', '114-2', 71.00, 1),
(1343, '114534107', 'CS101', '114-1', 73.10, 1),
(1344, '114534107', 'EN101', '114-1', 73.20, 1),
(1345, '114534107', 'GE101', '114-1', 81.30, 1),
(1346, '114534107', 'CS102', '114-2', 77.90, 1),
(1347, '114534107', 'EN102', '114-2', 71.40, 1),
(1348, '114534108', 'CS101', '114-1', 76.40, 1),
(1349, '114534108', 'EN101', '114-1', 69.50, 1),
(1350, '114534108', 'GE101', '114-1', 82.70, 1),
(1351, '114534108', 'CS102', '114-2', 76.40, 1),
(1352, '114534108', 'EN102', '114-2', 76.80, 1),
(1353, '114534109', 'CS101', '114-1', 74.90, 1),
(1354, '114534109', 'EN101', '114-1', 70.50, 1),
(1355, '114534109', 'GE101', '114-1', 86.10, 1),
(1356, '114534109', 'CS102', '114-2', 77.20, 1),
(1357, '114534109', 'EN102', '114-2', 69.60, 1),
(1358, '113534101', 'CS101', '113-1', 77.40, 1),
(1359, '113534101', 'EN101', '113-1', 84.50, 1),
(1360, '113534101', 'GE101', '113-1', 79.70, 1),
(1361, '113534101', 'CS102', '113-2', 76.70, 1),
(1362, '113534101', 'EN102', '113-2', 74.60, 1),
(1363, '113534101', 'CS201', '114-1', 79.50, 1),
(1364, '113534101', 'GE102', '114-1', 80.50, 1),
(1365, '113534101', 'CS202', '114-2', 81.10, 1),
(1366, '113534101', 'GE103', '114-2', 88.30, 1),
(1367, '113534102', 'CS101', '113-1', 60.30, 1),
(1368, '113534102', 'EN101', '113-1', 73.60, 1),
(1369, '113534102', 'GE101', '113-1', 74.60, 1),
(1370, '113534102', 'CS102', '113-2', 62.30, 1),
(1371, '113534102', 'EN102', '113-2', 63.40, 1),
(1372, '113534102', 'CS201', '114-1', 49.60, 0),
(1373, '113534102', 'GE102', '114-1', 66.20, 1),
(1374, '113534102', 'CS202', '114-2', 70.00, 1),
(1375, '113534102', 'GE103', '114-2', 65.80, 1),
(1376, '113534103', 'CS101', '113-1', 85.40, 1),
(1377, '113534103', 'EN101', '113-1', 88.00, 1),
(1378, '113534103', 'GE101', '113-1', 91.90, 1),
(1379, '113534103', 'CS102', '113-2', 90.40, 1),
(1380, '113534103', 'EN102', '113-2', 90.30, 1),
(1381, '113534103', 'CS201', '114-1', 74.60, 1),
(1382, '113534103', 'GE102', '114-1', 92.40, 1),
(1383, '113534103', 'CS202', '114-2', 86.70, 1),
(1384, '113534103', 'GE103', '114-2', 90.50, 1),
(1385, '113534104', 'CS101', '113-1', 95.40, 1),
(1386, '113534104', 'EN101', '113-1', 91.40, 1),
(1387, '113534104', 'GE101', '113-1', 89.50, 1),
(1388, '113534104', 'CS102', '113-2', 84.30, 1),
(1389, '113534104', 'EN102', '113-2', 86.10, 1),
(1390, '113534104', 'CS201', '114-1', 86.50, 1),
(1391, '113534104', 'GE102', '114-1', 98.10, 1),
(1392, '113534104', 'CS202', '114-2', 99.00, 1),
(1393, '113534104', 'GE103', '114-2', 90.30, 1),
(1394, '113534105', 'CS101', '113-1', 66.00, 1),
(1395, '113534105', 'EN101', '113-1', 63.90, 1),
(1396, '113534105', 'GE101', '113-1', 64.50, 1),
(1397, '113534105', 'CS102', '113-2', 73.80, 1),
(1398, '113534105', 'EN102', '113-2', 74.30, 1),
(1399, '113534105', 'CS201', '114-1', 68.80, 1),
(1400, '113534105', 'GE102', '114-1', 74.30, 1),
(1401, '113534105', 'CS202', '114-2', 38.50, 0),
(1402, '113534105', 'GE103', '114-2', 73.00, 1),
(1403, '113534106', 'CS101', '113-1', 71.20, 1),
(1404, '113534106', 'EN101', '113-1', 79.00, 1),
(1405, '113534106', 'GE101', '113-1', 75.10, 1),
(1406, '113534106', 'CS102', '113-2', 75.60, 1),
(1407, '113534106', 'EN102', '113-2', 82.10, 1),
(1408, '113534106', 'CS201', '114-1', 70.10, 1),
(1409, '113534106', 'GE102', '114-1', 82.80, 1),
(1410, '113534106', 'CS202', '114-2', 76.70, 1),
(1411, '113534106', 'GE103', '114-2', 71.00, 1),
(1412, '113534107', 'CS101', '113-1', 88.10, 1),
(1413, '113534107', 'EN101', '113-1', 80.50, 1),
(1414, '113534107', 'GE101', '113-1', 81.80, 1),
(1415, '113534107', 'CS102', '113-2', 78.90, 1),
(1416, '113534107', 'EN102', '113-2', 78.00, 1),
(1417, '113534107', 'CS201', '114-1', 70.20, 1),
(1418, '113534107', 'GE102', '114-1', 64.50, 1),
(1419, '113534107', 'CS202', '114-2', 74.80, 1),
(1420, '113534107', 'GE103', '114-2', 80.00, 1),
(1421, '113534108', 'CS101', '113-1', 62.20, 1),
(1422, '113534108', 'EN101', '113-1', 75.20, 1),
(1423, '113534108', 'GE101', '113-1', 70.10, 1),
(1424, '113534108', 'CS102', '113-2', 75.30, 1),
(1425, '113534108', 'EN102', '113-2', 71.70, 1),
(1426, '113534108', 'CS201', '114-1', 77.00, 1),
(1427, '113534108', 'GE102', '114-1', 71.00, 1),
(1428, '113534108', 'CS202', '114-2', 77.50, 1),
(1429, '113534108', 'GE103', '114-2', 76.10, 1),
(1430, '113534109', 'CS101', '113-1', 67.00, 1),
(1431, '113534109', 'EN101', '113-1', 88.10, 1),
(1432, '113534109', 'GE101', '113-1', 74.70, 1),
(1433, '113534109', 'CS102', '113-2', 77.30, 1),
(1434, '113534109', 'EN102', '113-2', 71.90, 1),
(1435, '113534109', 'CS201', '114-1', 85.70, 1),
(1436, '113534109', 'GE102', '114-1', 79.40, 1),
(1437, '113534109', 'CS202', '114-2', 83.80, 1),
(1438, '113534109', 'GE103', '114-2', 79.00, 1),
(1439, '112534101', 'CS101', '112-1', 70.30, 1),
(1440, '112534101', 'EN101', '112-1', 65.60, 1),
(1441, '112534101', 'GE101', '112-1', 77.10, 1),
(1442, '112534101', 'CS102', '112-2', 79.90, 1),
(1443, '112534101', 'EN102', '112-2', 77.60, 1),
(1444, '112534101', 'CS201', '113-1', 77.40, 1),
(1445, '112534101', 'GE102', '113-1', 67.30, 1),
(1446, '112534101', 'CS202', '113-2', 75.90, 1),
(1447, '112534101', 'GE103', '113-2', 88.40, 1),
(1448, '112534101', 'CS301', '114-1', 84.40, 1),
(1449, '112534101', 'CS303', '114-1', 81.00, 1),
(1450, '112534101', 'CS302', '114-2', 80.60, 1),
(1451, '112534101', 'CS304', '114-2', 68.10, 1),
(1452, '112534102', 'CS101', '112-1', 63.60, 1),
(1453, '112534102', 'EN101', '112-1', 67.00, 1),
(1454, '112534102', 'GE101', '112-1', 67.10, 1),
(1455, '112534102', 'CS102', '112-2', 75.80, 1),
(1456, '112534102', 'EN102', '112-2', 65.00, 1),
(1457, '112534102', 'CS201', '113-1', 38.80, 0),
(1458, '112534102', 'GE102', '113-1', 66.90, 1),
(1459, '112534102', 'CS202', '113-2', 68.10, 1),
(1460, '112534102', 'GE103', '113-2', 64.00, 1),
(1461, '112534102', 'CS301', '114-1', 74.00, 1),
(1462, '112534102', 'CS303', '114-1', 65.00, 1),
(1463, '112534102', 'CS302', '114-2', 81.40, 1),
(1464, '112534102', 'CS304', '114-2', 71.10, 1),
(1465, '112534103', 'CS101', '112-1', 93.30, 1),
(1466, '112534103', 'EN101', '112-1', 98.00, 1),
(1467, '112534103', 'GE101', '112-1', 99.00, 1),
(1468, '112534103', 'CS102', '112-2', 90.50, 1),
(1469, '112534103', 'EN102', '112-2', 77.70, 1),
(1470, '112534103', 'CS201', '113-1', 81.40, 1),
(1471, '112534103', 'GE102', '113-1', 88.30, 1),
(1472, '112534103', 'CS202', '113-2', 89.10, 1),
(1473, '112534103', 'GE103', '113-2', 94.30, 1),
(1474, '112534103', 'CS301', '114-1', 89.60, 1),
(1475, '112534103', 'CS303', '114-1', 99.00, 1),
(1476, '112534103', 'CS302', '114-2', 91.60, 1),
(1477, '112534103', 'CS304', '114-2', 80.50, 1),
(1478, '112534104', 'CS101', '112-1', 88.50, 1),
(1479, '112534104', 'EN101', '112-1', 83.60, 1),
(1480, '112534104', 'GE101', '112-1', 91.20, 1),
(1481, '112534104', 'CS102', '112-2', 88.00, 1),
(1482, '112534104', 'EN102', '112-2', 81.50, 1),
(1483, '112534104', 'CS201', '113-1', 79.90, 1),
(1484, '112534104', 'GE102', '113-1', 95.00, 1),
(1485, '112534104', 'CS202', '113-2', 85.30, 1),
(1486, '112534104', 'GE103', '113-2', 90.10, 1),
(1487, '112534104', 'CS301', '114-1', 93.80, 1),
(1488, '112534104', 'CS303', '114-1', 81.70, 1),
(1489, '112534104', 'CS302', '114-2', 84.40, 1),
(1490, '112534104', 'CS304', '114-2', 92.90, 1),
(1491, '112534105', 'CS101', '112-1', 67.90, 1),
(1492, '112534105', 'EN101', '112-1', 67.00, 1),
(1493, '112534105', 'GE101', '112-1', 61.80, 1),
(1494, '112534105', 'CS102', '112-2', 64.00, 1),
(1495, '112534105', 'EN102', '112-2', 67.40, 1),
(1496, '112534105', 'CS201', '113-1', 60.00, 1),
(1497, '112534105', 'GE102', '113-1', 76.60, 1),
(1498, '112534105', 'CS202', '113-2', 65.90, 1),
(1499, '112534105', 'GE103', '113-2', 72.10, 1),
(1500, '112534105', 'CS301', '114-1', 66.40, 1),
(1501, '112534105', 'CS303', '114-1', 74.90, 1),
(1502, '112534105', 'CS302', '114-2', 41.20, 0),
(1503, '112534105', 'CS304', '114-2', 75.70, 1),
(1504, '112534106', 'CS101', '112-1', 73.10, 1),
(1505, '112534106', 'EN101', '112-1', 76.80, 1),
(1506, '112534106', 'GE101', '112-1', 67.40, 1),
(1507, '112534106', 'CS102', '112-2', 80.00, 1),
(1508, '112534106', 'EN102', '112-2', 69.90, 1),
(1509, '112534106', 'CS201', '113-1', 80.60, 1),
(1510, '112534106', 'GE102', '113-1', 74.10, 1),
(1511, '112534106', 'CS202', '113-2', 70.50, 1),
(1512, '112534106', 'GE103', '113-2', 77.00, 1),
(1513, '112534106', 'CS301', '114-1', 79.30, 1),
(1514, '112534106', 'CS303', '114-1', 70.90, 1),
(1515, '112534106', 'CS302', '114-2', 61.10, 1),
(1516, '112534106', 'CS304', '114-2', 81.10, 1),
(1517, '112534107', 'CS101', '112-1', 68.50, 1),
(1518, '112534107', 'EN101', '112-1', 79.50, 1),
(1519, '112534107', 'GE101', '112-1', 72.00, 1),
(1520, '112534107', 'CS102', '112-2', 69.80, 1),
(1521, '112534107', 'EN102', '112-2', 74.00, 1),
(1522, '112534107', 'CS201', '113-1', 77.80, 1),
(1523, '112534107', 'GE102', '113-1', 74.90, 1),
(1524, '112534107', 'CS202', '113-2', 66.80, 1),
(1525, '112534107', 'GE103', '113-2', 68.60, 1),
(1526, '112534107', 'CS301', '114-1', 78.30, 1),
(1527, '112534107', 'CS303', '114-1', 75.20, 1),
(1528, '112534107', 'CS302', '114-2', 85.90, 1),
(1529, '112534107', 'CS304', '114-2', 81.20, 1),
(1530, '112534108', 'CS101', '112-1', 73.50, 1),
(1531, '112534108', 'EN101', '112-1', 69.20, 1),
(1532, '112534108', 'GE101', '112-1', 79.80, 1),
(1533, '112534108', 'CS102', '112-2', 77.10, 1),
(1534, '112534108', 'EN102', '112-2', 71.40, 1),
(1535, '112534108', 'CS201', '113-1', 61.00, 1),
(1536, '112534108', 'GE102', '113-1', 71.00, 1),
(1537, '112534108', 'CS202', '113-2', 67.40, 1),
(1538, '112534108', 'GE103', '113-2', 80.40, 1),
(1539, '112534108', 'CS301', '114-1', 76.90, 1),
(1540, '112534108', 'CS303', '114-1', 70.40, 1),
(1541, '112534108', 'CS302', '114-2', 87.00, 1),
(1542, '112534108', 'CS304', '114-2', 75.60, 1),
(1543, '112534109', 'CS101', '112-1', 80.50, 1),
(1544, '112534109', 'EN101', '112-1', 77.70, 1),
(1545, '112534109', 'GE101', '112-1', 78.30, 1),
(1546, '112534109', 'CS102', '112-2', 77.20, 1),
(1547, '112534109', 'EN102', '112-2', 86.00, 1),
(1548, '112534109', 'CS201', '113-1', 85.30, 1),
(1549, '112534109', 'GE102', '113-1', 64.00, 1),
(1550, '112534109', 'CS202', '113-2', 64.80, 1),
(1551, '112534109', 'GE103', '113-2', 72.30, 1),
(1552, '112534109', 'CS301', '114-1', 75.20, 1),
(1553, '112534109', 'CS303', '114-1', 82.80, 1),
(1554, '112534109', 'CS302', '114-2', 77.60, 1),
(1555, '112534109', 'CS304', '114-2', 77.00, 1),
(1556, '111534101', 'CS101', '111-1', 80.00, 1),
(1557, '111534101', 'EN101', '111-1', 71.50, 1),
(1558, '111534101', 'GE101', '111-1', 80.20, 1),
(1559, '111534101', 'CS102', '111-2', 76.20, 1),
(1560, '111534101', 'EN102', '111-2', 75.10, 1),
(1561, '111534101', 'CS201', '112-1', 77.90, 1),
(1562, '111534101', 'GE102', '112-1', 77.60, 1),
(1563, '111534101', 'CS202', '112-2', 73.90, 1),
(1564, '111534101', 'GE103', '112-2', 72.90, 1),
(1565, '111534101', 'CS301', '113-1', 85.10, 1),
(1566, '111534101', 'CS303', '113-1', 66.40, 1),
(1567, '111534101', 'CS302', '113-2', 80.40, 1),
(1568, '111534101', 'CS304', '113-2', 75.80, 1),
(1569, '111534101', 'CS401', '114-1', 76.90, 1),
(1570, '111534101', 'CS305', '114-1', 75.60, 1),
(1571, '111534101', 'CS402', '114-2', 73.40, 1),
(1572, '111534101', 'CS306', '114-2', 80.40, 1),
(1573, '111534102', 'CS101', '111-1', 73.60, 1),
(1574, '111534102', 'EN101', '111-1', 63.10, 1),
(1575, '111534102', 'GE101', '111-1', 70.30, 1),
(1576, '111534102', 'CS102', '111-2', 73.90, 1),
(1577, '111534102', 'EN102', '111-2', 73.80, 1),
(1578, '111534102', 'CS201', '112-1', 67.90, 1),
(1579, '111534102', 'GE102', '112-1', 62.20, 1),
(1580, '111534102', 'CS202', '112-2', 76.80, 1),
(1581, '111534102', 'GE103', '112-2', 63.30, 1),
(1582, '111534102', 'CS301', '113-1', 73.30, 1),
(1583, '111534102', 'CS303', '113-1', 86.50, 1),
(1584, '111534102', 'CS302', '113-2', 64.80, 1),
(1585, '111534102', 'CS304', '113-2', 73.60, 1),
(1586, '111534102', 'CS401', '114-1', 52.30, 0),
(1587, '111534102', 'CS305', '114-1', 65.00, 1),
(1588, '111534102', 'CS402', '114-2', 61.10, 1),
(1589, '111534102', 'CS306', '114-2', 72.10, 1),
(1590, '111534103', 'CS101', '111-1', 95.70, 1),
(1591, '111534103', 'EN101', '111-1', 79.50, 1),
(1592, '111534103', 'GE101', '111-1', 82.70, 1),
(1593, '111534103', 'CS102', '111-2', 86.70, 1),
(1594, '111534103', 'EN102', '111-2', 83.10, 1),
(1595, '111534103', 'CS201', '112-1', 85.70, 1),
(1596, '111534103', 'GE102', '112-1', 86.40, 1),
(1597, '111534103', 'CS202', '112-2', 90.10, 1),
(1598, '111534103', 'GE103', '112-2', 86.90, 1),
(1599, '111534103', 'CS301', '113-1', 87.20, 1),
(1600, '111534103', 'CS303', '113-1', 93.80, 1),
(1601, '111534103', 'CS302', '113-2', 98.70, 1),
(1602, '111534103', 'CS304', '113-2', 82.80, 1),
(1603, '111534103', 'CS401', '114-1', 86.30, 1),
(1604, '111534103', 'CS305', '114-1', 89.30, 1),
(1605, '111534103', 'CS402', '114-2', 86.80, 1),
(1606, '111534103', 'CS306', '114-2', 95.00, 1),
(1607, '111534104', 'CS101', '111-1', 68.90, 1),
(1608, '111534104', 'EN101', '111-1', 77.30, 1),
(1609, '111534104', 'GE101', '111-1', 69.80, 1),
(1610, '111534104', 'CS102', '111-2', 80.40, 1),
(1611, '111534104', 'EN102', '111-2', 72.80, 1),
(1612, '111534104', 'CS201', '112-1', 66.00, 1),
(1613, '111534104', 'GE102', '112-1', 70.90, 1),
(1614, '111534104', 'CS202', '112-2', 65.30, 1),
(1615, '111534104', 'GE103', '112-2', 80.00, 1),
(1616, '111534104', 'CS301', '113-1', 73.80, 1),
(1617, '111534104', 'CS303', '113-1', 72.80, 1),
(1618, '111534104', 'CS302', '113-2', 77.90, 1),
(1619, '111534104', 'CS304', '113-2', 79.80, 1),
(1620, '111534104', 'CS401', '114-1', 83.50, 1),
(1621, '111534104', 'CS305', '114-1', 88.20, 1),
(1622, '111534104', 'CS402', '114-2', 82.90, 1),
(1623, '111534104', 'CS306', '114-2', 70.20, 1),
(1624, '111534105', 'CS101', '111-1', 80.20, 1),
(1625, '111534105', 'EN101', '111-1', 80.20, 1),
(1626, '111534105', 'GE101', '111-1', 84.00, 1),
(1627, '111534105', 'CS102', '111-2', 82.20, 1),
(1628, '111534105', 'EN102', '111-2', 86.20, 1),
(1629, '111534105', 'CS201', '112-1', 89.60, 1),
(1630, '111534105', 'GE102', '112-1', 81.70, 1),
(1631, '111534105', 'CS202', '112-2', 90.60, 1),
(1632, '111534105', 'GE103', '112-2', 84.60, 1),
(1633, '111534105', 'CS301', '113-1', 91.20, 1),
(1634, '111534105', 'CS303', '113-1', 86.20, 1),
(1635, '111534105', 'CS302', '113-2', 79.90, 1),
(1636, '111534105', 'CS304', '113-2', 82.80, 1),
(1637, '111534105', 'CS401', '114-1', 86.80, 1),
(1638, '111534105', 'CS305', '114-1', 91.70, 1),
(1639, '111534105', 'CS402', '114-2', 88.80, 1),
(1640, '111534105', 'CS306', '114-2', 99.00, 1),
(1641, '111534106', 'CS101', '111-1', 65.30, 1),
(1642, '111534106', 'EN101', '111-1', 85.50, 1),
(1643, '111534106', 'GE101', '111-1', 71.50, 1),
(1644, '111534106', 'CS102', '111-2', 82.10, 1),
(1645, '111534106', 'EN102', '111-2', 65.40, 1),
(1646, '111534106', 'CS201', '112-1', 81.10, 1),
(1647, '111534106', 'GE102', '112-1', 70.60, 1),
(1648, '111534106', 'CS202', '112-2', 86.60, 1),
(1649, '111534106', 'GE103', '112-2', 71.00, 1),
(1650, '111534106', 'CS301', '113-1', 80.70, 1),
(1651, '111534106', 'CS303', '113-1', 78.60, 1),
(1652, '111534106', 'CS302', '113-2', 69.40, 1),
(1653, '111534106', 'CS304', '113-2', 66.40, 1),
(1654, '111534106', 'CS401', '114-1', 88.30, 1),
(1655, '111534106', 'CS305', '114-1', 75.40, 1),
(1656, '111534106', 'CS402', '114-2', 74.50, 1),
(1657, '111534106', 'CS306', '114-2', 67.20, 1),
(1658, '111534107', 'CS101', '111-1', 38.70, 0),
(1659, '111534107', 'EN101', '111-1', 71.40, 1),
(1660, '111534107', 'GE101', '111-1', 73.60, 1),
(1661, '111534107', 'CS102', '111-2', 69.10, 1),
(1662, '111534107', 'EN102', '111-2', 68.80, 1),
(1663, '111534107', 'CS201', '112-1', 77.30, 1),
(1664, '111534107', 'GE102', '112-1', 72.80, 1),
(1665, '111534107', 'CS202', '112-2', 66.10, 1),
(1666, '111534107', 'GE103', '112-2', 81.30, 1),
(1667, '111534107', 'CS301', '113-1', 66.20, 1),
(1668, '111534107', 'CS303', '113-1', 76.30, 1),
(1669, '111534107', 'CS302', '113-2', 75.40, 1),
(1670, '111534107', 'CS304', '113-2', 74.70, 1),
(1671, '111534107', 'CS401', '114-1', 61.30, 1),
(1672, '111534107', 'CS305', '114-1', 64.90, 1),
(1673, '111534107', 'CS402', '114-2', 61.00, 1),
(1674, '111534107', 'CS306', '114-2', 68.80, 1),
(1675, '111534108', 'CS101', '111-1', 63.00, 1),
(1676, '111534108', 'EN101', '111-1', 60.30, 1),
(1677, '111534108', 'GE101', '111-1', 65.40, 1),
(1678, '111534108', 'CS102', '111-2', 79.90, 1),
(1679, '111534108', 'EN102', '111-2', 75.10, 1),
(1680, '111534108', 'CS201', '112-1', 69.30, 1),
(1681, '111534108', 'GE102', '112-1', 78.50, 1),
(1682, '111534108', 'CS202', '112-2', 64.10, 1),
(1683, '111534108', 'GE103', '112-2', 68.50, 1),
(1684, '111534108', 'CS301', '113-1', 42.20, 0),
(1685, '111534108', 'CS303', '113-1', 76.60, 1),
(1686, '111534108', 'CS302', '113-2', 74.30, 1),
(1687, '111534108', 'CS304', '113-2', 77.00, 1),
(1688, '111534108', 'CS401', '114-1', 80.70, 1),
(1689, '111534108', 'CS305', '114-1', 68.80, 1),
(1690, '111534108', 'CS402', '114-2', 73.70, 1),
(1691, '111534108', 'CS306', '114-2', 62.10, 1),
(1692, '111534109', 'CS101', '111-1', 67.10, 1),
(1693, '111534109', 'EN101', '111-1', 67.00, 1),
(1694, '111534109', 'GE101', '111-1', 68.70, 1),
(1695, '111534109', 'CS102', '111-2', 36.10, 0),
(1696, '111534109', 'EN102', '111-2', 73.60, 1),
(1697, '111534109', 'CS201', '112-1', 69.90, 1),
(1698, '111534109', 'GE102', '112-1', 66.20, 1),
(1699, '111534109', 'CS202', '112-2', 76.90, 1),
(1700, '111534109', 'GE103', '112-2', 61.30, 1),
(1701, '111534109', 'CS301', '113-1', 61.90, 1),
(1702, '111534109', 'CS303', '113-1', 72.60, 1),
(1703, '111534109', 'CS302', '113-2', 60.30, 1),
(1704, '111534109', 'CS304', '113-2', 68.60, 1),
(1705, '111534109', 'CS401', '114-1', 69.00, 1),
(1706, '111534109', 'CS305', '114-1', 65.70, 1),
(1707, '111534109', 'CS402', '114-2', 67.80, 1),
(1708, '111534109', 'CS306', '114-2', 73.00, 1),
(1709, '111534110', 'CS101', '111-1', 67.20, 1),
(1710, '111534110', 'EN101', '111-1', 72.00, 1),
(1711, '111534110', 'GE101', '111-1', 65.70, 1),
(1712, '111534110', 'CS102', '111-2', 75.20, 1),
(1713, '111534110', 'EN102', '111-2', 73.40, 1),
(1714, '111534110', 'CS201', '112-1', 66.10, 1),
(1715, '111534110', 'GE102', '112-1', 66.80, 1),
(1716, '111534110', 'CS202', '112-2', 63.00, 1),
(1717, '111534110', 'GE103', '112-2', 65.00, 1),
(1718, '111534110', 'CS301', '113-1', 61.10, 1),
(1719, '111534110', 'CS303', '113-1', 60.00, 1),
(1720, '111534110', 'CS302', '113-2', 63.00, 1),
(1721, '111534110', 'CS304', '113-2', 62.00, 1),
(1722, '111534110', 'CS401', '114-1', 64.40, 1),
(1723, '111534110', 'CS305', '114-1', 62.20, 1),
(1724, '111534110', 'CS402', '114-2', 37.00, 0),
(1725, '111534110', 'CS306', '114-2', 72.10, 1),
(1726, '111534111', 'CS101', '111-1', 67.80, 1),
(1727, '111534111', 'EN101', '111-1', 68.70, 1),
(1728, '111534111', 'GE101', '111-1', 66.60, 1),
(1729, '111534111', 'CS102', '111-2', 70.50, 1),
(1730, '111534111', 'EN102', '111-2', 68.80, 1),
(1731, '111534111', 'CS201', '112-1', 62.00, 1),
(1732, '111534111', 'GE102', '112-1', 62.20, 1),
(1733, '111534111', 'CS202', '112-2', 60.00, 1),
(1734, '111534111', 'GE103', '112-2', 71.40, 1),
(1735, '111534111', 'CS301', '113-1', 61.00, 1),
(1736, '111534111', 'CS303', '113-1', 64.50, 1),
(1737, '111534111', 'CS302', '113-2', 77.60, 1),
(1738, '111534111', 'CS304', '113-2', 61.00, 1),
(1739, '111534111', 'CS401', '114-1', 72.30, 1),
(1740, '111534111', 'CS305', '114-1', 68.00, 1),
(1741, '111534111', 'CS402', '114-2', 42.90, 0),
(1742, '111534111', 'CS306', '114-2', 67.10, 1),
(1743, '111534112', 'CS101', '111-1', 65.00, 1),
(1744, '111534112', 'EN101', '111-1', 64.70, 1),
(1745, '111534112', 'GE101', '111-1', 62.00, 1),
(1746, '111534112', 'CS102', '111-2', 70.40, 1),
(1747, '111534112', 'EN102', '111-2', 67.30, 1),
(1748, '111534112', 'CS201', '112-1', 64.70, 1),
(1749, '111534112', 'GE102', '112-1', 69.30, 1),
(1750, '111534112', 'CS202', '112-2', 65.60, 1),
(1751, '111534112', 'GE103', '112-2', 65.80, 1),
(1752, '111534112', 'CS301', '113-1', 74.60, 1),
(1753, '111534112', 'CS303', '113-1', 69.80, 1),
(1754, '111534112', 'CS302', '113-2', 62.00, 1),
(1755, '111534112', 'CS304', '113-2', 62.00, 1),
(1756, '111534112', 'CS401', '114-1', 62.30, 1),
(1757, '111534112', 'CS305', '114-1', 63.00, 1),
(1758, '111534112', 'CS402', '114-2', 45.10, 0),
(1759, '111534112', 'CS306', '114-2', 63.00, 1),
(1760, '111534113', 'CS101', '111-1', 96.70, 1),
(1761, '111534113', 'EN101', '111-1', 91.50, 1),
(1762, '111534113', 'GE101', '111-1', 86.40, 1),
(1763, '111534113', 'CS102', '111-2', 82.20, 1),
(1764, '111534113', 'EN102', '111-2', 93.60, 1),
(1765, '111534113', 'CS201', '112-1', 85.70, 1),
(1766, '111534113', 'GE102', '112-1', 82.30, 1),
(1767, '111534113', 'CS202', '112-2', 88.10, 1),
(1768, '111534113', 'GE103', '112-2', 90.40, 1),
(1769, '111534113', 'CS301', '113-1', 89.90, 1),
(1770, '111534113', 'CS303', '113-1', 90.60, 1),
(1771, '111534113', 'CS302', '113-2', 86.10, 1),
(1772, '111534113', 'CS304', '113-2', 86.20, 1),
(1773, '111534113', 'CS401', '114-1', 89.70, 1),
(1774, '111534113', 'CS305', '114-1', 81.20, 1),
(1775, '111534113', 'CS402', '114-2', 95.90, 1),
(1776, '111534113', 'CS306', '114-2', 82.00, 1),
(1777, '111534114', 'CS101', '111-1', 90.30, 1),
(1778, '111534114', 'EN101', '111-1', 93.40, 1),
(1779, '111534114', 'GE101', '111-1', 96.20, 1),
(1780, '111534114', 'CS102', '111-2', 95.50, 1),
(1781, '111534114', 'EN102', '111-2', 81.00, 1),
(1782, '111534114', 'CS201', '112-1', 93.90, 1),
(1783, '111534114', 'GE102', '112-1', 91.90, 1),
(1784, '111534114', 'CS202', '112-2', 91.10, 1),
(1785, '111534114', 'GE103', '112-2', 85.20, 1),
(1786, '111534114', 'CS301', '113-1', 89.30, 1),
(1787, '111534114', 'CS303', '113-1', 75.50, 1),
(1788, '111534114', 'CS302', '113-2', 90.70, 1),
(1789, '111534114', 'CS304', '113-2', 90.30, 1),
(1790, '111534114', 'CS401', '114-1', 99.00, 1),
(1791, '111534114', 'CS305', '114-1', 87.70, 1),
(1792, '111534114', 'CS402', '114-2', 84.10, 1),
(1793, '111534114', 'CS306', '114-2', 89.10, 1),
(1794, '111534115', 'CS101', '111-1', 94.60, 1),
(1795, '111534115', 'EN101', '111-1', 95.30, 1),
(1796, '111534115', 'GE101', '111-1', 94.90, 1),
(1797, '111534115', 'CS102', '111-2', 88.90, 1),
(1798, '111534115', 'EN102', '111-2', 83.10, 1),
(1799, '111534115', 'CS201', '112-1', 84.80, 1),
(1800, '111534115', 'GE102', '112-1', 88.60, 1),
(1801, '111534115', 'CS202', '112-2', 78.80, 1),
(1802, '111534115', 'GE103', '112-2', 87.40, 1),
(1803, '111534115', 'CS301', '113-1', 90.70, 1),
(1804, '111534115', 'CS303', '113-1', 86.00, 1),
(1805, '111534115', 'CS302', '113-2', 99.00, 1),
(1806, '111534115', 'CS304', '113-2', 86.90, 1),
(1807, '111534115', 'CS401', '114-1', 85.50, 1),
(1808, '111534115', 'CS305', '114-1', 84.70, 1),
(1809, '111534115', 'CS402', '114-2', 83.40, 1),
(1810, '111534115', 'CS306', '114-2', 97.10, 1),
(1811, '111534116', 'CS101', '111-1', 86.20, 1),
(1812, '111534116', 'EN101', '111-1', 87.50, 1),
(1813, '111534116', 'GE101', '111-1', 75.30, 1),
(1814, '111534116', 'CS102', '111-2', 83.50, 1),
(1815, '111534116', 'EN102', '111-2', 84.50, 1),
(1816, '111534116', 'CS201', '112-1', 89.60, 1),
(1817, '111534116', 'GE102', '112-1', 78.80, 1),
(1818, '111534116', 'CS202', '112-2', 85.40, 1),
(1819, '111534116', 'GE103', '112-2', 97.80, 1),
(1820, '111534116', 'CS301', '113-1', 91.60, 1),
(1821, '111534116', 'CS303', '113-1', 81.00, 1),
(1822, '111534116', 'CS302', '113-2', 86.90, 1),
(1823, '111534116', 'CS304', '113-2', 76.70, 1),
(1824, '111534116', 'CS401', '114-1', 89.20, 1),
(1825, '111534116', 'CS305', '114-1', 87.40, 1),
(1826, '111534116', 'CS402', '114-2', 89.90, 1),
(1827, '111534116', 'CS306', '114-2', 81.90, 1),
(1828, '111534118', 'CS101', '111-1', 76.20, 1),
(1829, '111534118', 'EN101', '111-1', 75.60, 1),
(1830, '111534118', 'GE101', '111-1', 78.10, 1),
(1831, '111534118', 'CS102', '111-2', 71.30, 1),
(1832, '111534118', 'EN102', '111-2', 83.20, 1),
(1833, '111534118', 'CS201', '112-1', 78.90, 1),
(1834, '111534118', 'GE102', '112-1', 76.00, 1),
(1835, '111534118', 'CS202', '112-2', 74.70, 1),
(1836, '111534118', 'GE103', '112-2', 71.20, 1),
(1837, '111534118', 'CS301', '113-1', 70.70, 1),
(1838, '111534118', 'CS303', '113-1', 67.20, 1),
(1839, '111534118', 'CS302', '113-2', 84.50, 1),
(1840, '111534118', 'CS304', '113-2', 74.70, 1),
(1841, '111534118', 'CS401', '114-1', 69.20, 1),
(1842, '111534118', 'CS305', '114-1', 65.80, 1),
(1843, '111534118', 'CS402', '114-2', 76.80, 1),
(1844, '111534118', 'CS306', '114-2', 82.40, 1),
(1845, '111534119', 'CS101', '111-1', 77.40, 1),
(1846, '111534119', 'EN101', '111-1', 75.50, 1),
(1847, '111534119', 'GE101', '111-1', 82.70, 1),
(1848, '111534119', 'CS102', '111-2', 67.40, 1),
(1849, '111534119', 'EN102', '111-2', 72.90, 1),
(1850, '111534119', 'CS201', '112-1', 62.70, 1),
(1851, '111534119', 'GE102', '112-1', 72.70, 1),
(1852, '111534119', 'CS202', '112-2', 72.80, 1),
(1853, '111534119', 'GE103', '112-2', 82.20, 1),
(1854, '111534119', 'CS301', '113-1', 77.60, 1),
(1855, '111534119', 'CS303', '113-1', 71.70, 1),
(1856, '111534119', 'CS302', '113-2', 77.60, 1),
(1857, '111534119', 'CS304', '113-2', 75.80, 1),
(1858, '111534119', 'CS401', '114-1', 79.30, 1),
(1859, '111534119', 'CS305', '114-1', 65.70, 1),
(1860, '111534119', 'CS402', '114-2', 69.40, 1),
(1861, '111534119', 'CS306', '114-2', 71.10, 1),
(1862, '111534120', 'CS101', '111-1', 86.30, 1),
(1863, '111534120', 'EN101', '111-1', 83.50, 1),
(1864, '111534120', 'GE101', '111-1', 79.60, 1),
(1865, '111534120', 'CS102', '111-2', 76.10, 1),
(1866, '111534120', 'EN102', '111-2', 79.50, 1),
(1867, '111534120', 'CS201', '112-1', 77.50, 1),
(1868, '111534120', 'GE102', '112-1', 74.60, 1),
(1869, '111534120', 'CS202', '112-2', 83.30, 1),
(1870, '111534120', 'GE103', '112-2', 81.60, 1),
(1871, '111534120', 'CS301', '113-1', 81.50, 1),
(1872, '111534120', 'CS303', '113-1', 70.00, 1),
(1873, '111534120', 'CS302', '113-2', 82.00, 1),
(1874, '111534120', 'CS304', '113-2', 63.70, 1),
(1875, '111534120', 'CS401', '114-1', 77.50, 1),
(1876, '111534120', 'CS305', '114-1', 76.70, 1),
(1877, '111534120', 'CS402', '114-2', 75.90, 1),
(1878, '111534120', 'CS306', '114-2', 79.50, 1),
(1879, '111534121', 'CS101', '111-1', 76.10, 1),
(1880, '111534121', 'EN101', '111-1', 73.30, 1),
(1881, '111534121', 'GE101', '111-1', 86.50, 1),
(1882, '111534121', 'CS102', '111-2', 76.60, 1),
(1883, '111534121', 'EN102', '111-2', 68.60, 1),
(1884, '111534121', 'CS201', '112-1', 83.20, 1),
(1885, '111534121', 'GE102', '112-1', 79.10, 1),
(1886, '111534121', 'CS202', '112-2', 73.00, 1),
(1887, '111534121', 'GE103', '112-2', 71.60, 1),
(1888, '111534121', 'CS301', '113-1', 67.20, 1),
(1889, '111534121', 'CS303', '113-1', 87.40, 1),
(1890, '111534121', 'CS302', '113-2', 69.40, 1),
(1891, '111534121', 'CS304', '113-2', 88.00, 1),
(1892, '111534121', 'CS401', '114-1', 79.30, 1),
(1893, '111534121', 'CS305', '114-1', 76.80, 1),
(1894, '111534121', 'CS402', '114-2', 77.20, 1),
(1895, '111534121', 'CS306', '114-2', 76.70, 1),
(1896, '111534122', 'CS101', '111-1', 80.70, 1),
(1897, '111534122', 'EN101', '111-1', 78.30, 1),
(1898, '111534122', 'GE101', '111-1', 74.70, 1),
(1899, '111534122', 'CS102', '111-2', 75.70, 1),
(1900, '111534122', 'EN102', '111-2', 80.30, 1),
(1901, '111534122', 'CS201', '112-1', 74.60, 1),
(1902, '111534122', 'GE102', '112-1', 71.80, 1),
(1903, '111534122', 'CS202', '112-2', 75.40, 1),
(1904, '111534122', 'GE103', '112-2', 74.90, 1),
(1905, '111534122', 'CS301', '113-1', 82.00, 1),
(1906, '111534122', 'CS303', '113-1', 89.60, 1),
(1907, '111534122', 'CS302', '113-2', 83.60, 1),
(1908, '111534122', 'CS304', '113-2', 81.40, 1),
(1909, '111534122', 'CS401', '114-1', 63.80, 1),
(1910, '111534122', 'CS305', '114-1', 75.70, 1),
(1911, '111534122', 'CS402', '114-2', 63.60, 1),
(1912, '111534122', 'CS306', '114-2', 83.10, 1),
(1913, '111534123', 'CS101', '111-1', 72.70, 1),
(1914, '111534123', 'EN101', '111-1', 80.10, 1),
(1915, '111534123', 'GE101', '111-1', 76.10, 1),
(1916, '111534123', 'CS102', '111-2', 78.90, 1),
(1917, '111534123', 'EN102', '111-2', 70.90, 1),
(1918, '111534123', 'CS201', '112-1', 61.60, 1),
(1919, '111534123', 'GE102', '112-1', 83.30, 1),
(1920, '111534123', 'CS202', '112-2', 81.20, 1),
(1921, '111534123', 'GE103', '112-2', 78.40, 1),
(1922, '111534123', 'CS301', '113-1', 81.30, 1),
(1923, '111534123', 'CS303', '113-1', 74.70, 1),
(1924, '111534123', 'CS302', '113-2', 65.70, 1),
(1925, '111534123', 'CS304', '113-2', 72.80, 1),
(1926, '111534123', 'CS401', '114-1', 76.90, 1),
(1927, '111534123', 'CS305', '114-1', 78.60, 1),
(1928, '111534123', 'CS402', '114-2', 70.30, 1),
(1929, '111534123', 'CS306', '114-2', 71.50, 1),
(1930, '111534124', 'CS101', '111-1', 79.50, 1),
(1931, '111534124', 'EN101', '111-1', 76.90, 1),
(1932, '111534124', 'GE101', '111-1', 83.80, 1),
(1933, '111534124', 'CS102', '111-2', 88.50, 1),
(1934, '111534124', 'EN102', '111-2', 67.50, 1),
(1935, '111534124', 'CS201', '112-1', 78.30, 1),
(1936, '111534124', 'GE102', '112-1', 70.90, 1),
(1937, '111534124', 'CS202', '112-2', 78.50, 1),
(1938, '111534124', 'GE103', '112-2', 75.20, 1),
(1939, '111534124', 'CS301', '113-1', 78.80, 1),
(1940, '111534124', 'CS303', '113-1', 74.80, 1),
(1941, '111534124', 'CS302', '113-2', 76.50, 1),
(1942, '111534124', 'CS304', '113-2', 72.20, 1),
(1943, '111534124', 'CS401', '114-1', 76.70, 1),
(1944, '111534124', 'CS305', '114-1', 74.90, 1),
(1945, '111534124', 'CS402', '114-2', 70.50, 1),
(1946, '111534124', 'CS306', '114-2', 70.70, 1),
(1947, '111534125', 'CS101', '111-1', 86.70, 1),
(1948, '111534125', 'EN101', '111-1', 77.60, 1),
(1949, '111534125', 'GE101', '111-1', 78.90, 1),
(1950, '111534125', 'CS102', '111-2', 73.40, 1),
(1951, '111534125', 'EN102', '111-2', 81.70, 1),
(1952, '111534125', 'CS201', '112-1', 69.80, 1),
(1953, '111534125', 'GE102', '112-1', 80.50, 1),
(1954, '111534125', 'CS202', '112-2', 74.90, 1),
(1955, '111534125', 'GE103', '112-2', 74.10, 1),
(1956, '111534125', 'CS301', '113-1', 83.10, 1),
(1957, '111534125', 'CS303', '113-1', 79.40, 1),
(1958, '111534125', 'CS302', '113-2', 81.70, 1),
(1959, '111534125', 'CS304', '113-2', 71.30, 1),
(1960, '111534125', 'CS401', '114-1', 68.30, 1),
(1961, '111534125', 'CS305', '114-1', 62.00, 1),
(1962, '111534125', 'CS402', '114-2', 70.80, 1),
(1963, '111534125', 'CS306', '114-2', 73.50, 1),
(1964, '111534201', 'CS101', '111-1', 71.30, 1),
(1965, '111534201', 'EN101', '111-1', 81.80, 1),
(1966, '111534201', 'GE101', '111-1', 81.60, 1),
(1967, '111534201', 'CS102', '111-2', 80.40, 1),
(1968, '111534201', 'EN102', '111-2', 81.20, 1),
(1969, '111534201', 'CS201', '112-1', 85.60, 1),
(1970, '111534201', 'GE102', '112-1', 74.20, 1),
(1971, '111534201', 'CS202', '112-2', 78.90, 1),
(1972, '111534201', 'GE103', '112-2', 76.20, 1),
(1973, '111534201', 'CS301', '113-1', 82.30, 1),
(1974, '111534201', 'CS303', '113-1', 82.90, 1),
(1975, '111534201', 'CS302', '113-2', 74.10, 1),
(1976, '111534201', 'CS304', '113-2', 79.10, 1),
(1977, '111534201', 'CS401', '114-1', 74.60, 1),
(1978, '111534201', 'CS305', '114-1', 73.00, 1),
(1979, '111534201', 'CS402', '114-2', 80.40, 1),
(1980, '111534201', 'CS306', '114-2', 83.50, 1),
(1981, '111534202', 'CS101', '111-1', 61.00, 1),
(1982, '111534202', 'EN101', '111-1', 74.20, 1),
(1983, '111534202', 'GE101', '111-1', 61.50, 1),
(1984, '111534202', 'CS102', '111-2', 69.00, 1),
(1985, '111534202', 'EN102', '111-2', 67.60, 1),
(1986, '111534202', 'CS201', '112-1', 76.00, 1),
(1987, '111534202', 'GE102', '112-1', 72.50, 1),
(1988, '111534202', 'CS202', '112-2', 71.40, 1),
(1989, '111534202', 'GE103', '112-2', 63.30, 1),
(1990, '111534202', 'CS301', '113-1', 62.00, 1),
(1991, '111534202', 'CS303', '113-1', 73.90, 1),
(1992, '111534202', 'CS302', '113-2', 73.10, 1),
(1993, '111534202', 'CS304', '113-2', 71.00, 1),
(1994, '111534202', 'CS401', '114-1', 55.30, 0),
(1995, '111534202', 'CS305', '114-1', 65.40, 1),
(1996, '111534202', 'CS402', '114-2', 66.10, 1),
(1997, '111534202', 'CS306', '114-2', 67.90, 1),
(1998, '111534203', 'CS101', '111-1', 90.70, 1),
(1999, '111534203', 'EN101', '111-1', 79.60, 1),
(2000, '111534203', 'GE101', '111-1', 92.60, 1),
(2001, '111534203', 'CS102', '111-2', 84.80, 1),
(2002, '111534203', 'EN102', '111-2', 83.90, 1),
(2003, '111534203', 'CS201', '112-1', 88.00, 1),
(2004, '111534203', 'GE102', '112-1', 86.20, 1),
(2005, '111534203', 'CS202', '112-2', 86.90, 1),
(2006, '111534203', 'GE103', '112-2', 80.40, 1),
(2007, '111534203', 'CS301', '113-1', 86.90, 1),
(2008, '111534203', 'CS303', '113-1', 84.30, 1),
(2009, '111534203', 'CS302', '113-2', 89.80, 1),
(2010, '111534203', 'CS304', '113-2', 84.30, 1),
(2011, '111534203', 'CS401', '114-1', 97.30, 1),
(2012, '111534203', 'CS305', '114-1', 92.90, 1),
(2013, '111534203', 'CS402', '114-2', 99.00, 1),
(2014, '111534203', 'CS306', '114-2', 91.50, 1),
(2015, '111534204', 'CS101', '111-1', 94.90, 1),
(2016, '111534204', 'EN101', '111-1', 92.30, 1),
(2017, '111534204', 'GE101', '111-1', 90.10, 1),
(2018, '111534204', 'CS102', '111-2', 84.60, 1),
(2019, '111534204', 'EN102', '111-2', 90.60, 1),
(2020, '111534204', 'CS201', '112-1', 93.10, 1),
(2021, '111534204', 'GE102', '112-1', 99.00, 1),
(2022, '111534204', 'CS202', '112-2', 84.80, 1),
(2023, '111534204', 'GE103', '112-2', 89.90, 1),
(2024, '111534204', 'CS301', '113-1', 87.10, 1),
(2025, '111534204', 'CS303', '113-1', 79.90, 1),
(2026, '111534204', 'CS302', '113-2', 83.20, 1),
(2027, '111534204', 'CS304', '113-2', 79.60, 1),
(2028, '111534204', 'CS401', '114-1', 92.30, 1),
(2029, '111534204', 'CS305', '114-1', 90.40, 1),
(2030, '111534204', 'CS402', '114-2', 88.40, 1),
(2031, '111534204', 'CS306', '114-2', 77.30, 1),
(2032, '111534205', 'CS101', '111-1', 78.90, 1),
(2033, '111534205', 'EN101', '111-1', 60.50, 1),
(2034, '111534205', 'GE101', '111-1', 73.20, 1),
(2035, '111534205', 'CS102', '111-2', 66.10, 1),
(2036, '111534205', 'EN102', '111-2', 74.30, 1),
(2037, '111534205', 'CS201', '112-1', 72.40, 1),
(2038, '111534205', 'GE102', '112-1', 65.00, 1),
(2039, '111534205', 'CS202', '112-2', 64.00, 1),
(2040, '111534205', 'GE103', '112-2', 72.70, 1),
(2041, '111534205', 'CS301', '113-1', 64.60, 1),
(2042, '111534205', 'CS303', '113-1', 68.20, 1),
(2043, '111534205', 'CS302', '113-2', 67.60, 1),
(2044, '111534205', 'CS304', '113-2', 79.20, 1),
(2045, '111534205', 'CS401', '114-1', 70.00, 1),
(2046, '111534205', 'CS305', '114-1', 67.70, 1),
(2047, '111534205', 'CS402', '114-2', 42.10, 0),
(2048, '111534205', 'CS306', '114-2', 69.30, 1),
(2049, '111534206', 'CS101', '111-1', 81.10, 1),
(2050, '111534206', 'EN101', '111-1', 81.90, 1),
(2051, '111534206', 'GE101', '111-1', 73.70, 1),
(2052, '111534206', 'CS102', '111-2', 69.80, 1),
(2053, '111534206', 'EN102', '111-2', 76.10, 1),
(2054, '111534206', 'CS201', '112-1', 74.20, 1),
(2055, '111534206', 'GE102', '112-1', 74.10, 1),
(2056, '111534206', 'CS202', '112-2', 71.90, 1),
(2057, '111534206', 'GE103', '112-2', 80.30, 1),
(2058, '111534206', 'CS301', '113-1', 72.20, 1),
(2059, '111534206', 'CS303', '113-1', 78.50, 1),
(2060, '111534206', 'CS302', '113-2', 78.60, 1),
(2061, '111534206', 'CS304', '113-2', 71.30, 1),
(2062, '111534206', 'CS401', '114-1', 80.50, 1),
(2063, '111534206', 'CS305', '114-1', 77.90, 1),
(2064, '111534206', 'CS402', '114-2', 76.00, 1),
(2065, '111534206', 'CS306', '114-2', 68.70, 1),
(2066, '111534207', 'CS101', '111-1', 62.80, 1),
(2067, '111534207', 'EN101', '111-1', 73.20, 1),
(2068, '111534207', 'GE101', '111-1', 77.70, 1),
(2069, '111534207', 'CS102', '111-2', 70.20, 1),
(2070, '111534207', 'EN102', '111-2', 85.10, 1),
(2071, '111534207', 'CS201', '112-1', 74.80, 1),
(2072, '111534207', 'GE102', '112-1', 81.30, 1),
(2073, '111534207', 'CS202', '112-2', 76.10, 1),
(2074, '111534207', 'GE103', '112-2', 87.80, 1),
(2075, '111534207', 'CS301', '113-1', 73.70, 1),
(2076, '111534207', 'CS303', '113-1', 73.30, 1),
(2077, '111534207', 'CS302', '113-2', 82.70, 1),
(2078, '111534207', 'CS304', '113-2', 74.80, 1),
(2079, '111534207', 'CS401', '114-1', 73.00, 1),
(2080, '111534207', 'CS305', '114-1', 67.30, 1),
(2081, '111534207', 'CS402', '114-2', 78.70, 1),
(2082, '111534207', 'CS306', '114-2', 63.70, 1),
(2083, '111534208', 'CS101', '111-1', 81.90, 1),
(2084, '111534208', 'EN101', '111-1', 79.70, 1),
(2085, '111534208', 'GE101', '111-1', 86.10, 1),
(2086, '111534208', 'CS102', '111-2', 75.20, 1),
(2087, '111534208', 'EN102', '111-2', 81.80, 1),
(2088, '111534208', 'CS201', '112-1', 67.20, 1),
(2089, '111534208', 'GE102', '112-1', 70.10, 1),
(2090, '111534208', 'CS202', '112-2', 72.30, 1),
(2091, '111534208', 'GE103', '112-2', 68.10, 1),
(2092, '111534208', 'CS301', '113-1', 74.20, 1),
(2093, '111534208', 'CS303', '113-1', 84.80, 1),
(2094, '111534208', 'CS302', '113-2', 80.60, 1),
(2095, '111534208', 'CS304', '113-2', 77.70, 1),
(2096, '111534208', 'CS401', '114-1', 79.30, 1),
(2097, '111534208', 'CS305', '114-1', 71.20, 1),
(2098, '111534208', 'CS402', '114-2', 71.70, 1),
(2099, '111534208', 'CS306', '114-2', 74.50, 1),
(2100, '111534209', 'CS101', '111-1', 69.40, 1),
(2101, '111534209', 'EN101', '111-1', 78.20, 1),
(2102, '111534209', 'GE101', '111-1', 83.20, 1),
(2103, '111534209', 'CS102', '111-2', 82.10, 1),
(2104, '111534209', 'EN102', '111-2', 86.40, 1),
(2105, '111534209', 'CS201', '112-1', 81.10, 1),
(2106, '111534209', 'GE102', '112-1', 77.70, 1),
(2107, '111534209', 'CS202', '112-2', 66.00, 1),
(2108, '111534209', 'GE103', '112-2', 77.00, 1),
(2109, '111534209', 'CS301', '113-1', 74.10, 1),
(2110, '111534209', 'CS303', '113-1', 71.90, 1),
(2111, '111534209', 'CS302', '113-2', 86.70, 1),
(2112, '111534209', 'CS304', '113-2', 73.50, 1),
(2113, '111534209', 'CS401', '114-1', 78.40, 1),
(2114, '111534209', 'CS305', '114-1', 73.00, 1),
(2115, '111534209', 'CS402', '114-2', 66.80, 1),
(2116, '111534209', 'CS306', '114-2', 83.70, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `student_privacy_settings`
--

CREATE TABLE `student_privacy_settings` (
  `setting_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `parent_alert_consent` tinyint(1) NOT NULL DEFAULT 1,
  `advisor_alert_consent` tinyint(1) NOT NULL DEFAULT 1,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `student_privacy_settings`
--

INSERT INTO `student_privacy_settings` (`setting_id`, `student_id`, `parent_alert_consent`, `advisor_alert_consent`, `updated_at`) VALUES
(1, 'S112001', 1, 1, '2026-09-24 04:10:29'),
(2, 'S112002', 0, 1, '2026-09-24 04:10:29'),
(3, 'S112004', 1, 1, '2026-09-24 04:10:29');

-- --------------------------------------------------------

--
-- 資料表結構 `student_records`
--

CREATE TABLE `student_records` (
  `record_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `kind` enum('獎懲','幹部') NOT NULL COMMENT '獎懲 或 幹部',
  `item` varchar(20) NOT NULL COMMENT '獎懲：嘉獎、小功、大功、申誡、小過、大過；幹部：班長、課程小老師…',
  `count` tinyint(4) NOT NULL DEFAULT 1 COMMENT '獎懲次數，例如嘉獎 2 次；幹部固定 1',
  `reason` varchar(200) DEFAULT NULL COMMENT '獎懲事由；小老師填負責的科目',
  `semester` varchar(10) NOT NULL COMMENT '學期，例如 115-1',
  `record_date` date DEFAULT NULL COMMENT '核定或擔任日期',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='學生表現紀錄：獎懲與幹部 (T18)';

--
-- 傾印資料表的資料 `student_records`
--

INSERT INTO `student_records` (`record_id`, `student_id`, `kind`, `item`, `count`, `reason`, `semester`, `record_date`, `created_at`) VALUES
(1, '115534103', '獎懲', '嘉獎', 1, '參加校內程式設計競賽獲得第三名，為校爭光', '115-1', '2026-09-19', '2026-10-14 06:27:40'),
(2, '115534104', '獎懲', '嘉獎', 1, '協助校慶活動', '115-1', '2026-10-05', '2026-10-14 06:27:40'),
(3, '115534107', '獎懲', '嘉獎', 1, '參加校內程式設計競賽獲得第三名，為校爭光', '115-1', '2026-09-26', '2026-10-14 06:27:40'),
(4, '115534109', '獎懲', '嘉獎', 1, '參加校內程式設計競賽獲得第三名，為校爭光', '115-1', '2026-10-04', '2026-10-14 06:27:40'),
(5, '115534104', '幹部', '班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(6, '115534103', '幹部', '副班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(7, '115534107', '幹部', '學藝股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(8, '115534108', '幹部', '總務股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(9, '115534101', '幹部', '風紀股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(10, '115534106', '幹部', '衛生股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(11, '115534105', '幹部', '康樂股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(12, '115534109', '幹部', '資訊股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(13, '115534104', '幹部', '課程小老師', 1, '計算機概論', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(14, '115534101', '幹部', '課程小老師', 1, '基礎英文(一)', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(15, '115534107', '幹部', '課程小老師', 1, '大學之道與校園倫理', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(16, '114534101', '獎懲', '嘉獎', 1, '參加校內程式設計競賽獲得第三名，為校爭光', '114-2', '2026-04-12', '2026-10-14 06:27:40'),
(17, '114534103', '獎懲', '嘉獎', 1, '熱心公務', '114-2', '2026-06-03', '2026-10-14 06:27:40'),
(18, '114534104', '獎懲', '嘉獎', 1, '熱心公務', '114-2', '2026-03-01', '2026-10-14 06:27:40'),
(19, '114534105', '獎懲', '小功', 1, '參加全國技藝競賽 資訊技術類獲得第一名，為校爭光', '114-2', '2026-04-04', '2026-10-14 06:27:40'),
(20, '114534106', '獎懲', '嘉獎', 1, '拾金不昧', '114-2', '2026-03-23', '2026-10-14 06:27:40'),
(21, '114534101', '幹部', '班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(22, '114534105', '幹部', '副班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(23, '114534107', '幹部', '學藝股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(24, '114534109', '幹部', '總務股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(25, '114534106', '幹部', '風紀股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(26, '114534103', '幹部', '衛生股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(27, '114534104', '幹部', '康樂股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(28, '114534108', '幹部', '資訊股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(29, '114534103', '幹部', '課程小老師', 1, '資料結構', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(30, '114534101', '幹部', '課程小老師', 1, '跨領域思維與創新科技', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(31, '114534103', '幹部', '班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(32, '114534103', '獎懲', '嘉獎', 1, '擔任班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(33, '114534105', '幹部', '副班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(34, '114534105', '獎懲', '嘉獎', 2, '擔任副班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(35, '114534107', '幹部', '學藝股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(36, '114534107', '獎懲', '嘉獎', 2, '擔任學藝股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(37, '114534106', '幹部', '總務股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(38, '114534106', '獎懲', '嘉獎', 1, '擔任總務股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(39, '113534102', '獎懲', '嘉獎', 1, '參加校內英文單字比賽獲得第二名，為校爭光', '114-2', '2026-04-11', '2026-10-14 06:27:40'),
(40, '113534103', '獎懲', '嘉獎', 1, '參加校內程式設計競賽獲得第二名，為校爭光', '113-1', '2024-09-22', '2026-10-14 06:27:40'),
(41, '113534103', '獎懲', '嘉獎', 1, '擔任志工服務認真', '113-1', '2024-10-16', '2026-10-14 06:27:40'),
(42, '113534106', '獎懲', '小功', 1, '參加全國技藝競賽 資訊技術類獲得第一名，為校爭光', '113-2', '2025-05-13', '2026-10-14 06:27:40'),
(43, '113534106', '獎懲', '嘉獎', 1, '參加校內英文單字比賽獲得第二名，為校爭光', '113-2', '2025-04-17', '2026-10-14 06:27:40'),
(44, '113534107', '獎懲', '嘉獎', 1, '拾金不昧', '114-2', '2026-04-12', '2026-10-14 06:27:40'),
(45, '113534107', '獎懲', '申誡', 1, '未依規定時間繳交班級資料', '113-2', '2025-06-04', '2026-10-14 06:27:40'),
(46, '113534108', '獎懲', '嘉獎', 1, '拾金不昧', '113-1', '2024-10-10', '2026-10-14 06:27:40'),
(47, '113534109', '獎懲', '嘉獎', 1, '拾金不昧', '113-2', '2025-05-05', '2026-10-14 06:27:40'),
(48, '113534107', '幹部', '班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(49, '113534106', '幹部', '副班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(50, '113534101', '幹部', '學藝股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(51, '113534105', '幹部', '總務股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(52, '113534108', '幹部', '風紀股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(53, '113534104', '幹部', '衛生股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(54, '113534109', '幹部', '康樂股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(55, '113534103', '幹部', '資訊股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(56, '113534103', '幹部', '課程小老師', 1, '演算法分析', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(57, '113534109', '幹部', '課程小老師', 1, '網頁前後端開發實務', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(58, '113534105', '幹部', '班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(59, '113534105', '獎懲', '嘉獎', 2, '擔任班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(60, '113534103', '幹部', '副班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(61, '113534103', '獎懲', '嘉獎', 1, '擔任副班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(62, '113534107', '幹部', '學藝股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(63, '113534107', '獎懲', '嘉獎', 1, '擔任學藝股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(64, '113534109', '幹部', '總務股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(65, '113534109', '獎懲', '嘉獎', 1, '擔任總務股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(66, '112534102', '獎懲', '嘉獎', 1, '擔任志工服務認真', '113-2', '2025-05-26', '2026-10-14 06:27:40'),
(67, '112534103', '獎懲', '嘉獎', 1, '拾金不昧', '113-2', '2025-06-02', '2026-10-14 06:27:40'),
(68, '112534104', '獎懲', '申誡', 1, '服儀不整經勸導未改善', '114-1', '2025-12-28', '2026-10-14 06:27:40'),
(69, '112534105', '獎懲', '申誡', 1, '未依規定時間繳交班級資料', '114-1', '2025-11-01', '2026-10-14 06:27:40'),
(70, '112534106', '獎懲', '小功', 1, '參加全國大專校院資訊應用服務創新競賽獲得第三名，為校爭光', '114-2', '2026-03-31', '2026-10-14 06:27:40'),
(71, '112534106', '獎懲', '嘉獎', 1, '拾金不昧', '112-2', '2024-05-12', '2026-10-14 06:27:40'),
(72, '112534104', '幹部', '班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(73, '112534108', '幹部', '副班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(74, '112534106', '幹部', '學藝股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(75, '112534109', '幹部', '總務股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(76, '112534103', '幹部', '風紀股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(77, '112534101', '幹部', '衛生股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(78, '112534107', '幹部', '康樂股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(79, '112534105', '幹部', '資訊股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(80, '112534101', '幹部', '課程小老師', 1, '資料庫系統概論', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(81, '112534103', '幹部', '課程小老師', 1, '雲端運算與虛擬化', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(82, '112534103', '幹部', '班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(83, '112534103', '獎懲', '嘉獎', 1, '擔任班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(84, '112534101', '幹部', '副班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(85, '112534101', '獎懲', '嘉獎', 1, '擔任副班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(86, '112534106', '幹部', '學藝股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(87, '112534106', '獎懲', '嘉獎', 2, '擔任學藝股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(88, '112534107', '幹部', '總務股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(89, '112534107', '獎懲', '嘉獎', 1, '擔任總務股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(90, '111534101', '獎懲', '嘉獎', 1, '熱心公務', '114-1', '2025-10-27', '2026-10-14 06:27:40'),
(91, '111534103', '獎懲', '小功', 1, '參加全國大專校院資訊應用服務創新競賽獲得第一名，為校爭光', '112-1', '2023-12-31', '2026-10-14 06:27:40'),
(92, '111534103', '獎懲', '嘉獎', 1, '參加校內英文單字比賽獲得第三名，為校爭光', '113-1', '2024-11-26', '2026-10-14 06:27:40'),
(93, '111534105', '獎懲', '嘉獎', 2, '參加校內英文單字比賽獲得第一名，為校爭光', '111-2', '2023-03-22', '2026-10-14 06:27:40'),
(94, '111534106', '獎懲', '小功', 1, '參加全國大專校院資訊應用服務創新競賽獲得第一名，為校爭光', '111-1', '2022-11-04', '2026-10-14 06:27:40'),
(95, '111534107', '獎懲', '嘉獎', 1, '參加校內英文單字比賽獲得第二名，為校爭光', '114-2', '2026-05-13', '2026-10-14 06:27:40'),
(96, '111534110', '獎懲', '申誡', 1, '無故曠課累計達規定節數', '115-1', '2026-10-08', '2026-10-14 06:27:40'),
(97, '111534112', '獎懲', '小過', 2, '無故曠課累計達規定節數', '115-1', '2026-10-08', '2026-10-14 06:27:40'),
(98, '111534113', '獎懲', '嘉獎', 1, '參加校內簡報競賽獲得第二名，為校爭光', '112-2', '2024-03-11', '2026-10-14 06:27:40'),
(99, '111534114', '獎懲', '嘉獎', 1, '參加校內簡報競賽獲得第二名，為校爭光', '111-1', '2022-09-18', '2026-10-14 06:27:40'),
(100, '111534114', '獎懲', '嘉獎', 1, '協助新生訓練', '111-2', '2023-03-27', '2026-10-14 06:27:40'),
(101, '111534115', '獎懲', '嘉獎', 1, '參加校內簡報競賽獲得第三名，為校爭光', '114-1', '2025-12-03', '2026-10-14 06:27:40'),
(102, '111534115', '獎懲', '小功', 1, '參加全國大專校院資訊應用服務創新競賽獲得第一名，為校爭光', '113-1', '2024-11-17', '2026-10-14 06:27:40'),
(103, '111534115', '獎懲', '申誡', 1, '服儀不整經勸導未改善', '112-2', '2024-03-15', '2026-10-14 06:27:40'),
(104, '111534116', '獎懲', '小功', 1, '參加全國大專校院資訊應用服務創新競賽獲得第二名，為校爭光', '114-2', '2026-03-14', '2026-10-14 06:27:40'),
(105, '111534120', '獎懲', '嘉獎', 1, '擔任志工服務認真', '114-1', '2025-11-17', '2026-10-14 06:27:40'),
(106, '111534121', '獎懲', '嘉獎', 1, '參加校內簡報競賽獲得第二名，為校爭光', '111-2', '2023-03-25', '2026-10-14 06:27:40'),
(107, '111534121', '獎懲', '嘉獎', 1, '熱心公務', '114-2', '2026-04-25', '2026-10-14 06:27:40'),
(108, '111534122', '獎懲', '嘉獎', 1, '熱心公務', '112-2', '2024-04-03', '2026-10-14 06:27:40'),
(109, '111534109', '幹部', '班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(110, '111534124', '幹部', '副班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(111, '111534122', '幹部', '學藝股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(112, '111534118', '幹部', '總務股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(113, '111534116', '幹部', '風紀股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(114, '111534121', '幹部', '衛生股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(115, '111534106', '幹部', '康樂股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(116, '111534123', '幹部', '資訊股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(117, '111534122', '幹部', '課程小老師', 1, '資料庫系統概論', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(118, '111534106', '幹部', '課程小老師', 1, '物件導向程式設計', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(119, '111534123', '幹部', '課程小老師', 1, '基礎英文(二)', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(120, '111534119', '幹部', '課程小老師', 1, '跨領域思維與創新科技', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(121, '111534106', '幹部', '班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(122, '111534106', '獎懲', '嘉獎', 1, '擔任班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(123, '111534124', '幹部', '副班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(124, '111534124', '獎懲', '嘉獎', 1, '擔任副班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(125, '111534115', '幹部', '學藝股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(126, '111534115', '獎懲', '嘉獎', 1, '擔任學藝股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(127, '111534116', '幹部', '總務股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(128, '111534116', '獎懲', '嘉獎', 1, '擔任總務股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(129, '111534201', '獎懲', '小功', 1, '參加全國專科學校專題實作競賽獲得第二名，為校爭光', '114-2', '2026-03-09', '2026-10-14 06:27:40'),
(130, '111534201', '獎懲', '嘉獎', 1, '擔任志工服務認真', '111-2', '2023-05-11', '2026-10-14 06:27:40'),
(131, '111534202', '獎懲', '小功', 1, '參加全國技藝競賽 資訊技術類獲得第二名，為校爭光', '111-2', '2023-02-23', '2026-10-14 06:27:40'),
(132, '111534202', '獎懲', '嘉獎', 1, '協助校慶活動', '113-2', '2025-02-24', '2026-10-14 06:27:40'),
(133, '111534203', '獎懲', '小功', 1, '參加全國專科學校專題實作競賽獲得第二名，為校爭光', '111-2', '2023-03-03', '2026-10-14 06:27:40'),
(134, '111534203', '獎懲', '嘉獎', 1, '拾金不昧', '111-1', '2022-10-23', '2026-10-14 06:27:40'),
(135, '111534204', '獎懲', '嘉獎', 2, '參加校內程式設計競賽獲得第一名，為校爭光', '113-1', '2024-10-15', '2026-10-14 06:27:40'),
(136, '111534204', '獎懲', '申誡', 1, '上課使用手機經勸導未改善', '112-1', '2023-09-28', '2026-10-14 06:27:40'),
(137, '111534205', '獎懲', '嘉獎', 1, '熱心公務', '112-1', '2023-12-25', '2026-10-14 06:27:40'),
(138, '111534205', '獎懲', '申誡', 1, '服儀不整經勸導未改善', '113-1', '2024-11-24', '2026-10-14 06:27:40'),
(139, '111534206', '獎懲', '嘉獎', 1, '擔任志工服務認真', '111-1', '2022-11-27', '2026-10-14 06:27:40'),
(140, '111534209', '獎懲', '嘉獎', 1, '拾金不昧', '111-1', '2022-10-28', '2026-10-14 06:27:40'),
(141, '111534209', '獎懲', '申誡', 1, '未依規定時間繳交班級資料', '111-1', '2022-12-12', '2026-10-14 06:27:40'),
(142, '111534209', '幹部', '班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(143, '111534208', '幹部', '副班長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(144, '111534204', '幹部', '學藝股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(145, '111534205', '幹部', '總務股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(146, '111534206', '幹部', '風紀股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(147, '111534203', '幹部', '衛生股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(148, '111534201', '幹部', '康樂股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(149, '111534207', '幹部', '資訊股長', 1, NULL, '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(150, '111534204', '幹部', '課程小老師', 1, '資料庫系統概論', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(151, '111534208', '幹部', '課程小老師', 1, '物件導向程式設計', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(152, '111534201', '幹部', '課程小老師', 1, '基礎英文(二)', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(153, '111534207', '幹部', '課程小老師', 1, '跨領域思維與創新科技', '115-1', '2026-09-14', '2026-10-14 06:27:40'),
(154, '111534207', '幹部', '班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(155, '111534207', '獎懲', '嘉獎', 2, '擔任班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(156, '111534204', '幹部', '副班長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(157, '111534204', '獎懲', '嘉獎', 2, '擔任副班長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(158, '111534205', '幹部', '學藝股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(159, '111534205', '獎懲', '嘉獎', 1, '擔任學藝股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40'),
(160, '111534208', '幹部', '總務股長', 1, NULL, '114-2', '2026-02-23', '2026-10-14 06:27:40'),
(161, '111534208', '獎懲', '嘉獎', 2, '擔任總務股長認真負責', '114-2', '2026-06-19', '2026-10-14 06:27:40');

-- --------------------------------------------------------

--
-- 資料表結構 `synonym_dictionary`
--

CREATE TABLE `synonym_dictionary` (
  `synonym_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `user_keyword` varchar(50) NOT NULL,
  `official_term` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `synonym_dictionary`
--

INSERT INTO `synonym_dictionary` (`synonym_id`, `category_id`, `user_keyword`, `official_term`) VALUES
(1, 1, '棄修', '停修'),
(2, 1, '退選', '停修'),
(3, 1, '不要修了', '停修'),
(4, 1, '擋修', '先修科目未通過'),
(5, 1, '先修沒過', '先修科目未通過'),
(6, 3, '英文抵免', '語言證照抵免'),
(7, 3, '英檢抵免', '語言證照抵免'),
(8, 3, '多益抵免', '語言證照抵免'),
(9, 2, '事假', '學生請假規定'),
(10, 2, '公假', '學生請假規定'),
(11, 2, '喪假', '學生請假規定'),
(12, 3, '證照錢', '學生取得專業證照獎勵辦法'),
(13, 1, '二一', '學業成績退學規定'),
(14, 1, '暑修', '暑期開班授課規定');

-- --------------------------------------------------------

--
-- 資料表結構 `unmatched_queries`
--

CREATE TABLE `unmatched_queries` (
  `query_id` int(11) NOT NULL,
  `query_text` varchar(255) NOT NULL,
  `search_count` int(11) NOT NULL DEFAULT 1,
  `status` enum('待處理','已轉同義詞','已建條文','已忽略') NOT NULL DEFAULT '待處理',
  `resolved_term` varchar(100) DEFAULT NULL,
  `first_searched_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_searched_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `unmatched_queries`
--

INSERT INTO `unmatched_queries` (`query_id`, `query_text`, `search_count`, `status`, `resolved_term`, `first_searched_at`, `last_searched_at`) VALUES
(1, '退費手續', 14, '待處理', NULL, '2026-09-24 04:10:29', '2026-09-24 04:10:29'),
(2, '兵役緩徵', 9, '待處理', NULL, '2026-09-24 04:10:29', '2026-09-24 04:10:29'),
(3, '宿舍門禁時間', 18, '待處理', NULL, '2026-09-24 04:10:29', '2026-09-24 04:10:29'),
(4, '機車通行證申請', 22, '待處理', NULL, '2026-09-24 04:10:29', '2026-09-24 04:10:29'),
(5, '轉系規定', 7, '待處理', NULL, '2026-09-24 04:10:29', '2026-09-24 04:10:29');

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('學生','家長','教職員','老師','管理員','訪客') NOT NULL,
  `student_id` varchar(20) DEFAULT NULL,
  `full_name` varchar(50) NOT NULL,
  `advised_class` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `can_manage_dorm` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`user_id`, `username`, `password_hash`, `role`, `student_id`, `full_name`, `advised_class`, `created_at`, `can_manage_dorm`) VALUES
(1, 'student1', 'scrypt:32768:8:1$BUihyUarM9iQQCWd$d4abf05cc1533276a6c504eafce1a93fba579769ffebdfd70d188f6582ed43c2de57b035a1c726f9005d525f784ac361ef384520d8b862d8e61674e63e55bcbf', '學生', 'S112001', '王小明', NULL, '2026-09-24 04:10:29', 0),
(2, 'student2', 'scrypt:32768:8:1$BUihyUarM9iQQCWd$d4abf05cc1533276a6c504eafce1a93fba579769ffebdfd70d188f6582ed43c2de57b035a1c726f9005d525f784ac361ef384520d8b862d8e61674e63e55bcbf', '學生', 'S112002', '李美華', NULL, '2026-09-24 04:10:29', 0),
(3, 'parent1', 'scrypt:32768:8:1$BUihyUarM9iQQCWd$d4abf05cc1533276a6c504eafce1a93fba579769ffebdfd70d188f6582ed43c2de57b035a1c726f9005d525f784ac361ef384520d8b862d8e61674e63e55bcbf', '家長', 'S112001', '王大明 (小明家長)', NULL, '2026-09-24 04:10:29', 0),
(4, 'staff1', 'scrypt:32768:8:1$BUihyUarM9iQQCWd$d4abf05cc1533276a6c504eafce1a93fba579769ffebdfd70d188f6582ed43c2de57b035a1c726f9005d525f784ac361ef384520d8b862d8e61674e63e55bcbf', '教職員', NULL, '周立威 (教務處職員)', NULL, '2026-09-24 04:10:29', 0),
(5, 'admin', 'scrypt:32768:8:1$IXJt7DeyelfShW9P$e6e23bccae4ab84bccd5823b3fc4a415c8b72fcd728324567980ca65b9df8e16ebca81646df22f8ffe31e23a6a1c4d89b1aeec093e3a0d1d17d719f1c3eb209c', '管理員', NULL, '系統超級管理員', NULL, '2026-09-24 04:10:29', 0),
(6, 'teacher1', 'scrypt:32768:8:1$BUihyUarM9iQQCWd$d4abf05cc1533276a6c504eafce1a93fba579769ffebdfd70d188f6582ed43c2de57b035a1c726f9005d525f784ac361ef384520d8b862d8e61674e63e55bcbf', '老師', NULL, '彭賓鈺 老師', '資管五忠', '2026-09-24 04:10:29', 0),
(7, 'S112004', 'scrypt:32768:8:1$BUihyUarM9iQQCWd$d4abf05cc1533276a6c504eafce1a93fba579769ffebdfd70d188f6582ed43c2de57b035a1c726f9005d525f784ac361ef384520d8b862d8e61674e63e55bcbf', '學生', 'S112004', '陳冠宇', NULL, '2026-09-24 04:10:29', 0),
(8, 'S112005', 'scrypt:32768:8:1$BUihyUarM9iQQCWd$d4abf05cc1533276a6c504eafce1a93fba579769ffebdfd70d188f6582ed43c2de57b035a1c726f9005d525f784ac361ef384520d8b862d8e61674e63e55bcbf', '學生', 'S112005', '林雨潔', NULL, '2026-09-24 04:10:29', 0),
(9, '111534117', 'scrypt:32768:8:1$s3u8tsRg9K4A6QAt$a9ef8f10d54c0d1dbef8166b84e7e3110f427762a6ed5180f58428b1342959a5090a596b745a357a563f86366a154b2a92c77705cf7c70a675f34a790c1a62fa', '學生', '111534117', '張晴茹', NULL, '2026-09-24 04:39:04', 0),
(10, '115534101', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534101', '何宇秉', NULL, '2026-10-12 02:23:50', 0),
(11, '115534102', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534102', '張宇庭', NULL, '2026-10-12 02:23:50', 0),
(12, '115534103', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534103', '游郁浩', NULL, '2026-10-12 02:23:50', 0),
(13, '115534104', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534104', '鍾志嘉', NULL, '2026-10-12 02:23:50', 0),
(14, '115534105', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534105', '郭均瑄', NULL, '2026-10-12 02:23:50', 0),
(15, '115534106', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534106', '許俊豪', NULL, '2026-10-12 02:23:50', 0),
(16, '115534107', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534107', '游俊嘉', NULL, '2026-10-12 02:23:50', 0),
(17, '115534108', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534108', '施家涵', NULL, '2026-10-12 02:23:50', 0),
(18, '115534109', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '115534109', '盧語晨', NULL, '2026-10-12 02:23:50', 0),
(19, '114534101', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534101', '戴佳郁', NULL, '2026-10-12 02:23:50', 0),
(20, '114534102', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534102', '許語育', NULL, '2026-10-12 02:23:50', 0),
(21, '114534103', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534103', '魏詠涵', NULL, '2026-10-12 02:23:50', 0),
(22, '114534104', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534104', '高涵佳', NULL, '2026-10-12 02:23:50', 0),
(23, '114534105', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534105', '趙誠建', NULL, '2026-10-12 02:23:50', 0),
(24, '114534106', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534106', '周均庭', NULL, '2026-10-12 02:23:50', 0),
(25, '114534107', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534107', '葉宏芷', NULL, '2026-10-12 02:23:50', 0),
(26, '114534108', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534108', '趙承涵', NULL, '2026-10-12 02:23:50', 0),
(27, '114534109', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '114534109', '蕭品建', NULL, '2026-10-12 02:23:50', 0),
(28, '113534101', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534101', '吳廷萱', NULL, '2026-10-12 02:23:50', 0),
(29, '113534102', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534102', '邱均宗', NULL, '2026-10-12 02:23:50', 0),
(30, '113534103', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534103', '吳萱瑄', NULL, '2026-10-12 02:23:50', 0),
(31, '113534104', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534104', '施婷彤', NULL, '2026-10-12 02:23:50', 0),
(32, '113534105', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534105', '葉涵廷', NULL, '2026-10-12 02:23:50', 0),
(33, '113534106', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534106', '王志君', NULL, '2026-10-12 02:23:50', 0),
(34, '113534107', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534107', '孫芷宇', NULL, '2026-10-12 02:23:50', 0),
(35, '113534108', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534108', '盧晴欣', NULL, '2026-10-12 02:23:50', 0),
(36, '113534109', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '113534109', '顏彥雅', NULL, '2026-10-12 02:23:50', 0),
(37, '112534101', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534101', '施晴欣', NULL, '2026-10-12 02:23:50', 0),
(38, '112534102', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534102', '葉彤婷', NULL, '2026-10-12 02:23:50', 0),
(39, '112534103', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534103', '彭子浩', NULL, '2026-10-12 02:23:50', 0),
(40, '112534104', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534104', '盧誠涵', NULL, '2026-10-12 02:23:50', 0),
(41, '112534105', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534105', '陳建翰', NULL, '2026-10-12 02:23:50', 0),
(42, '112534106', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534106', '簡家傑', NULL, '2026-10-12 02:23:50', 0),
(43, '112534107', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534107', '謝誠晴', NULL, '2026-10-12 02:23:50', 0),
(44, '112534108', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534108', '洪家誠', NULL, '2026-10-12 02:23:50', 0),
(45, '112534109', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '112534109', '孫嘉傑', NULL, '2026-10-12 02:23:50', 0),
(46, '111534101', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534101', '許浩宥', NULL, '2026-10-12 02:23:50', 0),
(47, '111534102', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534102', '羅宥萱', NULL, '2026-10-12 02:23:50', 0),
(48, '111534103', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534103', '楊欣傑', NULL, '2026-10-12 02:23:50', 0),
(49, '111534104', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534104', '陳豪思', NULL, '2026-10-12 02:23:50', 0),
(50, '111534105', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534105', '朱芷冠', NULL, '2026-10-12 02:23:50', 0),
(51, '111534106', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534106', '蕭亭均', NULL, '2026-10-12 02:23:50', 0),
(52, '111534107', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534107', '梁涵妍', NULL, '2026-10-12 02:23:50', 0),
(53, '111534108', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534108', '廖郁建', NULL, '2026-10-12 02:23:50', 0),
(54, '111534109', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534109', '陳瑄穎', NULL, '2026-10-12 02:23:50', 0),
(55, '111534110', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534110', '曾睿浩', NULL, '2026-10-12 02:23:50', 0),
(56, '111534111', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534111', '翁雅豪', NULL, '2026-10-12 02:23:50', 0),
(57, '111534112', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534112', '游宏翰', NULL, '2026-10-12 02:23:50', 0),
(58, '111534113', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534113', '吳詠翰', NULL, '2026-10-12 02:23:50', 0),
(59, '111534114', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534114', '彭建妍', NULL, '2026-10-12 02:23:50', 0),
(60, '111534115', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534115', '魏宇君', NULL, '2026-10-12 02:23:50', 0),
(61, '111534116', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534116', '盧彥穎', NULL, '2026-10-12 02:23:50', 0),
(62, '111534118', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534118', '吳詠浩', NULL, '2026-10-12 02:23:50', 0),
(63, '111534119', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534119', '邱彤子', NULL, '2026-10-12 02:23:50', 0),
(64, '111534120', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534120', '何品嘉', NULL, '2026-10-12 02:23:50', 0),
(65, '111534121', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534121', '高涵晴', NULL, '2026-10-12 02:23:50', 0),
(66, '111534122', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534122', '徐翔婷', NULL, '2026-10-12 02:23:50', 0),
(67, '111534123', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534123', '魏欣思', NULL, '2026-10-12 02:23:50', 0),
(68, '111534124', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534124', '何涵傑', NULL, '2026-10-12 02:23:50', 0),
(69, '111534125', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534125', '周承妍', NULL, '2026-10-12 02:23:50', 0),
(70, '111534201', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534201', '鄭柏瑄', NULL, '2026-10-12 02:23:50', 0),
(71, '111534202', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534202', '羅欣育', NULL, '2026-10-12 02:23:50', 0),
(72, '111534203', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534203', '游瑄語', NULL, '2026-10-12 02:23:50', 0),
(73, '111534204', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534204', '詹翰婷', NULL, '2026-10-12 02:23:50', 0),
(74, '111534205', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534205', '游明宏', NULL, '2026-10-12 02:23:50', 0),
(75, '111534206', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534206', '盧家秉', NULL, '2026-10-12 02:23:50', 0),
(76, '111534207', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534207', '游筱宇', NULL, '2026-10-12 02:23:50', 0),
(77, '111534208', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534208', '魏妤明', NULL, '2026-10-12 02:23:50', 0),
(78, '111534209', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '學生', '111534209', '高詠恩', NULL, '2026-10-12 02:23:50', 0),
(79, 'teacher2', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '老師', NULL, '林志明 老師', '資管五孝', '2026-10-12 02:23:50', 0),
(150, 'dorm_demo', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '宿舍管理示範員', NULL, '2026-10-20 02:04:33', 1),
(151, 'demo_office_academic', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '教務處示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(152, 'demo_office_student', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '學生事務處示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(153, 'demo_office_general', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '總務處示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(154, 'demo_office_research', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '研究發展處示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(155, 'demo_office_secretary', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '秘書室示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(156, 'demo_office_library', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '資訊暨圖書中心示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(157, 'demo_office_accounting', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '會計室示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(158, 'demo_office_personnel', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '人事室示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(159, 'demo_office_teaching', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '教學發展暨資源中心示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(160, 'demo_office_admissions', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '招生中心示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(161, 'demo_office_sports', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '體育室示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(162, 'demo_office_institutional', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '校務研究辦公室示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(163, 'demo_office_international', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '國際暨兩岸事務處示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(164, 'demo_office_highered', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '高教深耕辦公室示範承辦人', NULL, '2026-10-21 01:36:14', 0),
(165, 'demo_office_extension', 'pbkdf2:sha256:1000000$1pZH4zsCrzpTUDpY$56c22c83158361bc754b4c140e89c0812713d8c5b1277ffd02fe410f12c6149c', '教職員', NULL, '推廣教育中心示範承辦人', NULL, '2026-10-21 01:36:14', 0);

-- --------------------------------------------------------

--
-- 資料表結構 `user_preferences`
--

CREATE TABLE `user_preferences` (
  `username` varchar(50) NOT NULL,
  `dept_id` varchar(20) DEFAULT NULL,
  `content_scope` enum('all','mine') NOT NULL DEFAULT 'all' COMMENT 'mine = 只看全校公開與本科資訊',
  `pinned_features` varchar(500) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `user_preferences`
--

INSERT INTO `user_preferences` (`username`, `dept_id`, `content_scope`, `pinned_features`, `updated_at`) VALUES
('111534117', 'CS', 'all', 'calendar,course-plan,rules,notices', '2026-10-12 03:18:57'),
('admin', NULL, 'all', '', '2026-10-15 01:30:21'),
('dorm_demo', NULL, 'all', '', '2026-10-21 01:27:19'),
('parent1', NULL, 'all', '', '2026-10-15 01:28:49'),
('student1', 'CS', 'all', '', '2026-10-14 16:28:40'),
('student2', NULL, 'all', '', '2026-10-20 01:47:05'),
('teacher1', 'CS', 'all', '', '2026-10-14 16:28:21');

-- --------------------------------------------------------

--
-- 資料表結構 `visitor_logs`
--

CREATE TABLE `visitor_logs` (
  `log_id` int(11) NOT NULL,
  `visitor_name` varchar(50) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `school_from` varchar(100) NOT NULL,
  `purpose` varchar(100) NOT NULL,
  `target_dept` varchar(100) DEFAULT '資訊管理科（五專）',
  `visited_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) DEFAULT '127.0.0.1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `academic_calendar`
--
ALTER TABLE `academic_calendar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cal_dates` (`start_date`,`end_date`),
  ADD KEY `fk_cal_checklist` (`related_checklist_id`);

--
-- 資料表索引 `anniversary_events`
--
ALTER TABLE `anniversary_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_anniv_dates` (`start_date`,`end_date`);

--
-- 資料表索引 `anniversary_wishes`
--
ALTER TABLE `anniversary_wishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_wish_event_status` (`event_id`,`status`,`created_at`);

--
-- 資料表索引 `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ann_date` (`publish_date`);

--
-- 資料表索引 `announcement_reads`
--
ALTER TABLE `announcement_reads`
  ADD PRIMARY KEY (`student_id`,`announcement_id`),
  ADD KEY `fk_ar_ann` (`announcement_id`);

--
-- 資料表索引 `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_asg_class` (`class_name`),
  ADD KEY `idx_asg_student` (`student_id`);

--
-- 資料表索引 `assignment_submissions`
--
ALTER TABLE `assignment_submissions`
  ADD PRIMARY KEY (`student_id`,`assignment_id`),
  ADD KEY `fk_sub_asg` (`assignment_id`);

--
-- 資料表索引 `attendance_records`
--
ALTER TABLE `attendance_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_att_student_date` (`student_id`,`date`),
  ADD KEY `idx_att_notified` (`notified`);

--
-- 資料表索引 `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_audit_table_record` (`table_name`,`record_id`);

--
-- 資料表索引 `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`cert_id`),
  ADD KEY `fk_cert_student` (`student_id`);

--
-- 資料表索引 `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `fk_chk_cat` (`category_id`);

--
-- 資料表索引 `checklist_progress`
--
ALTER TABLE `checklist_progress`
  ADD PRIMARY KEY (`student_id`,`item_id`,`step_index`),
  ADD KEY `fk_cp_item` (`item_id`);

--
-- 資料表索引 `class_groups`
--
ALTER TABLE `class_groups`
  ADD PRIMARY KEY (`class_name`);

--
-- 資料表索引 `class_group_members`
--
ALTER TABLE `class_group_members`
  ADD PRIMARY KEY (`class_name`,`student_id`),
  ADD KEY `fk_cgm_student` (`student_id`);

--
-- 資料表索引 `class_notices`
--
ALTER TABLE `class_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cn_class` (`class_name`),
  ADD KEY `idx_cn_sender` (`sender_username`);

--
-- 資料表索引 `class_notice_recipients`
--
ALTER TABLE `class_notice_recipients`
  ADD PRIMARY KEY (`notice_id`,`student_id`),
  ADD KEY `fk_cnr_student` (`student_id`);

--
-- 資料表索引 `class_schedule`
--
ALTER TABLE `class_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sched_class` (`class_name`,`weekday`),
  ADD KEY `idx_sched_student` (`student_id`,`weekday`);

--
-- 資料表索引 `counseling_records`
--
ALTER TABLE `counseling_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_counsel_student` (`student_id`,`talk_date`),
  ADD KEY `idx_counsel_class` (`class_name`);

--
-- 資料表索引 `course_map`
--
ALTER TABLE `course_map`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `fk_course_prereq` (`prerequisite_id`),
  ADD KEY `fk_course_dept` (`dept_id`);

--
-- 資料表索引 `deadlines`
--
ALTER TABLE `deadlines`
  ADD PRIMARY KEY (`deadline_id`),
  ADD KEY `fk_deadline_dept` (`applies_to_dept`);

--
-- 資料表索引 `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_id`);

--
-- 資料表索引 `dorm_applications`
--
ALTER TABLE `dorm_applications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_dorm_student_semester` (`student_id`,`semester`);

--
-- 資料表索引 `faculty_profiles`
--
ALTER TABLE `faculty_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_faculty_name` (`name`);

--
-- 資料表索引 `graduation_requirements`
--
ALTER TABLE `graduation_requirements`
  ADD PRIMARY KEY (`req_id`),
  ADD UNIQUE KEY `uk_grad_dept` (`dept_id`);

--
-- 資料表索引 `knowledge_base`
--
ALTER TABLE `knowledge_base`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_kb_category` (`category_id`);

--
-- 資料表索引 `knowledge_categories`
--
ALTER TABLE `knowledge_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- 資料表索引 `leave_requests`
--
ALTER TABLE `leave_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_leave_student` (`student_id`,`submitted_at`);

--
-- 資料表索引 `moodle_links`
--
ALTER TABLE `moodle_links`
  ADD PRIMARY KEY (`student_id`);

--
-- 資料表索引 `scholarships`
--
ALTER TABLE `scholarships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_scholarship_deadline` (`deadline`);

--
-- 資料表索引 `search_feedback`
--
ALTER TABLE `search_feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `fk_fb_kb` (`kb_id`);

--
-- 資料表索引 `search_logs`
--
ALTER TABLE `search_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_search_created` (`created_at`),
  ADD KEY `idx_search_matched_query` (`matched`,`query`);

--
-- 資料表索引 `self_reviews`
--
ALTER TABLE `self_reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_review_student_semester` (`student_id`,`semester`);

--
-- 資料表索引 `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `fk_students_dept` (`dept_id`);

--
-- 資料表索引 `student_credits`
--
ALTER TABLE `student_credits`
  ADD PRIMARY KEY (`credit_id`),
  ADD KEY `fk_credits_student` (`student_id`),
  ADD KEY `fk_credits_course` (`course_id`);

--
-- 資料表索引 `student_privacy_settings`
--
ALTER TABLE `student_privacy_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `uk_privacy_student` (`student_id`);

--
-- 資料表索引 `student_records`
--
ALTER TABLE `student_records`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `idx_records_student` (`student_id`,`record_date`);

--
-- 資料表索引 `synonym_dictionary`
--
ALTER TABLE `synonym_dictionary`
  ADD PRIMARY KEY (`synonym_id`),
  ADD KEY `fk_synonym_cat` (`category_id`);

--
-- 資料表索引 `unmatched_queries`
--
ALTER TABLE `unmatched_queries`
  ADD PRIMARY KEY (`query_id`),
  ADD UNIQUE KEY `uk_query_text` (`query_text`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uk_username` (`username`),
  ADD KEY `fk_users_student` (`student_id`);

--
-- 資料表索引 `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`username`),
  ADD KEY `fk_pref_dept` (`dept_id`);

--
-- 資料表索引 `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `academic_calendar`
--
ALTER TABLE `academic_calendar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `anniversary_events`
--
ALTER TABLE `anniversary_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `anniversary_wishes`
--
ALTER TABLE `anniversary_wishes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `attendance_records`
--
ALTER TABLE `attendance_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=308;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `certificates`
--
ALTER TABLE `certificates`
  MODIFY `cert_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=218;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `checklist_items`
--
ALTER TABLE `checklist_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `class_notices`
--
ALTER TABLE `class_notices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `class_schedule`
--
ALTER TABLE `class_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `counseling_records`
--
ALTER TABLE `counseling_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `deadlines`
--
ALTER TABLE `deadlines`
  MODIFY `deadline_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `dorm_applications`
--
ALTER TABLE `dorm_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `faculty_profiles`
--
ALTER TABLE `faculty_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `graduation_requirements`
--
ALTER TABLE `graduation_requirements`
  MODIFY `req_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `knowledge_base`
--
ALTER TABLE `knowledge_base`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `knowledge_categories`
--
ALTER TABLE `knowledge_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `leave_requests`
--
ALTER TABLE `leave_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `scholarships`
--
ALTER TABLE `scholarships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `search_feedback`
--
ALTER TABLE `search_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `search_logs`
--
ALTER TABLE `search_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `self_reviews`
--
ALTER TABLE `self_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `student_credits`
--
ALTER TABLE `student_credits`
  MODIFY `credit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2117;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `student_privacy_settings`
--
ALTER TABLE `student_privacy_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `student_records`
--
ALTER TABLE `student_records`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `synonym_dictionary`
--
ALTER TABLE `synonym_dictionary`
  MODIFY `synonym_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `unmatched_queries`
--
ALTER TABLE `unmatched_queries`
  MODIFY `query_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `academic_calendar`
--
ALTER TABLE `academic_calendar`
  ADD CONSTRAINT `fk_cal_checklist` FOREIGN KEY (`related_checklist_id`) REFERENCES `checklist_items` (`item_id`) ON DELETE SET NULL;

--
-- 資料表的限制式 `anniversary_wishes`
--
ALTER TABLE `anniversary_wishes`
  ADD CONSTRAINT `fk_wish_event` FOREIGN KEY (`event_id`) REFERENCES `anniversary_events` (`id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `announcement_reads`
--
ALTER TABLE `announcement_reads`
  ADD CONSTRAINT `fk_ar_ann` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ar_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `fk_asg_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `assignment_submissions`
--
ALTER TABLE `assignment_submissions`
  ADD CONSTRAINT `fk_sub_asg` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sub_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `attendance_records`
--
ALTER TABLE `attendance_records`
  ADD CONSTRAINT `fk_att_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `fk_cert_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD CONSTRAINT `fk_chk_cat` FOREIGN KEY (`category_id`) REFERENCES `knowledge_categories` (`category_id`) ON DELETE SET NULL;

--
-- 資料表的限制式 `checklist_progress`
--
ALTER TABLE `checklist_progress`
  ADD CONSTRAINT `fk_cp_item` FOREIGN KEY (`item_id`) REFERENCES `checklist_items` (`item_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `class_group_members`
--
ALTER TABLE `class_group_members`
  ADD CONSTRAINT `fk_cgm_class` FOREIGN KEY (`class_name`) REFERENCES `class_groups` (`class_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cgm_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的限制式 `class_notices`
--
ALTER TABLE `class_notices`
  ADD CONSTRAINT `fk_cn_class` FOREIGN KEY (`class_name`) REFERENCES `class_groups` (`class_name`) ON UPDATE CASCADE;

--
-- 資料表的限制式 `class_notice_recipients`
--
ALTER TABLE `class_notice_recipients`
  ADD CONSTRAINT `fk_cnr_notice` FOREIGN KEY (`notice_id`) REFERENCES `class_notices` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cnr_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的限制式 `class_schedule`
--
ALTER TABLE `class_schedule`
  ADD CONSTRAINT `fk_sched_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `counseling_records`
--
ALTER TABLE `counseling_records`
  ADD CONSTRAINT `fk_counsel_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的限制式 `course_map`
--
ALTER TABLE `course_map`
  ADD CONSTRAINT `fk_course_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_course_prereq` FOREIGN KEY (`prerequisite_id`) REFERENCES `course_map` (`course_id`) ON DELETE SET NULL;

--
-- 資料表的限制式 `deadlines`
--
ALTER TABLE `deadlines`
  ADD CONSTRAINT `fk_deadline_dept` FOREIGN KEY (`applies_to_dept`) REFERENCES `departments` (`dept_id`) ON DELETE SET NULL;

--
-- 資料表的限制式 `dorm_applications`
--
ALTER TABLE `dorm_applications`
  ADD CONSTRAINT `fk_dorm_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON UPDATE CASCADE;

--
-- 資料表的限制式 `graduation_requirements`
--
ALTER TABLE `graduation_requirements`
  ADD CONSTRAINT `fk_grad_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`) ON UPDATE CASCADE;

--
-- 資料表的限制式 `knowledge_base`
--
ALTER TABLE `knowledge_base`
  ADD CONSTRAINT `fk_kb_category` FOREIGN KEY (`category_id`) REFERENCES `knowledge_categories` (`category_id`) ON UPDATE CASCADE;

--
-- 資料表的限制式 `leave_requests`
--
ALTER TABLE `leave_requests`
  ADD CONSTRAINT `fk_leave_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `moodle_links`
--
ALTER TABLE `moodle_links`
  ADD CONSTRAINT `fk_moodle_links_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `search_feedback`
--
ALTER TABLE `search_feedback`
  ADD CONSTRAINT `fk_fb_kb` FOREIGN KEY (`kb_id`) REFERENCES `knowledge_base` (`id`) ON DELETE SET NULL;

--
-- 資料表的限制式 `self_reviews`
--
ALTER TABLE `self_reviews`
  ADD CONSTRAINT `fk_review_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`) ON UPDATE CASCADE;

--
-- 資料表的限制式 `student_credits`
--
ALTER TABLE `student_credits`
  ADD CONSTRAINT `fk_credits_course` FOREIGN KEY (`course_id`) REFERENCES `course_map` (`course_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_credits_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `student_privacy_settings`
--
ALTER TABLE `student_privacy_settings`
  ADD CONSTRAINT `fk_privacy_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- 資料表的限制式 `student_records`
--
ALTER TABLE `student_records`
  ADD CONSTRAINT `fk_records_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的限制式 `synonym_dictionary`
--
ALTER TABLE `synonym_dictionary`
  ADD CONSTRAINT `fk_synonym_cat` FOREIGN KEY (`category_id`) REFERENCES `knowledge_categories` (`category_id`) ON DELETE SET NULL;

--
-- 資料表的限制式 `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- 資料表的限制式 `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD CONSTRAINT `fk_pref_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
