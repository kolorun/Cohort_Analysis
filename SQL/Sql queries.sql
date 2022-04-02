-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 30, 2022 at 10:38 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wolt-exercise`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `cohort_dfn_by_month_first_purchase_Restaurant`
-- (See below for the actual view)
--
CREATE TABLE `cohort_dfn_by_month_first_purchase_Restaurant` (
`user_id` varchar(7)
,`cohort` int(2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `cohort_dfn_by_month_first_purchase_retail`
-- (See below for the actual view)
--
CREATE TABLE `cohort_dfn_by_month_first_purchase_retail` (
`user_id` varchar(7)
,`cohort` int(2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `cohort_retention_by_month_first_purchase`
-- (See below for the actual view)
--
CREATE TABLE `cohort_retention_by_month_first_purchase` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `cohort_retention_by_month_first_purchase_restaurant`
-- (See below for the actual view)
--
CREATE TABLE `cohort_retention_by_month_first_purchase_restaurant` (
`cohort` int(2)
,`month_actual` int(2)
,`revenue` bigint(21)
,`month_rank` bigint(22)
,`month_rank_trend` bigint(22)
,`subscribers` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `cohort_retention_by_month_first_purchase_retail`
-- (See below for the actual view)
--
CREATE TABLE `cohort_retention_by_month_first_purchase_retail` (
`cohort` int(2)
,`month_actual` int(2)
,`revenue` bigint(21)
,`month_rank` bigint(22)
,`month_rank_trend` bigint(22)
,`subscribers` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `retention_by_user_by_month`
-- (See below for the actual view)
--
CREATE TABLE `retention_by_user_by_month` (
`user_id` varchar(7)
,`months_active` int(2)
,`revenue` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `retention_by_user_by_month_restaurant`
-- (See below for the actual view)
--
CREATE TABLE `retention_by_user_by_month_restaurant` (
`user_id` varchar(7)
,`months_active` int(2)
,`revenue` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `retention_by_user_by_month_retail`
-- (See below for the actual view)
--
CREATE TABLE `retention_by_user_by_month_retail` (
`user_id` varchar(7)
,`months_active` int(2)
,`revenue` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `cohort_dfn_by_month_first_purchase_Restaurant`
--
DROP TABLE IF EXISTS `cohort_dfn_by_month_first_purchase_Restaurant`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cohort_dfn_by_month_first_purchase_restaurant`  AS SELECT `first_purchases`.`user_id` AS `user_id`, month(`first_purchases`.`first_purchase_date`) AS `cohort` FROM `first_purchases` WHERE `first_purchases`.`product_line` = 'Restaurant' GROUP BY 1 ;

-- --------------------------------------------------------

--
-- Structure for view `cohort_dfn_by_month_first_purchase_retail`
--
DROP TABLE IF EXISTS `cohort_dfn_by_month_first_purchase_retail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cohort_dfn_by_month_first_purchase_retail`  AS SELECT `first_purchases`.`user_id` AS `user_id`, month(`first_purchases`.`first_purchase_date`) AS `cohort` FROM `first_purchases` WHERE `first_purchases`.`product_line` = 'Retail store' GROUP BY 1 ;

-- --------------------------------------------------------

--
-- Structure for view `cohort_retention_by_month_first_purchase`
--
DROP TABLE IF EXISTS `cohort_retention_by_month_first_purchase`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cohort_retention_by_month_first_purchase`  AS SELECT `c`.`cohort` AS `cohort`, `m`.`months_active` AS `month_actual`, count(`m`.`revenue`) AS `revenue`, rank()  ( partition by `c`.`cohort` order by `m`.`months_active`) - 1 AS `over` FROM (`cohort_dfn_by_month_first_purchase` `c` join `retention_by_user_by_month` `m` on(`c`.`user_id` = `m`.`user_id`)) GROUP BY '', '' ORDER BY `m`.`months_active` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `cohort_retention_by_month_first_purchase_restaurant`
--
DROP TABLE IF EXISTS `cohort_retention_by_month_first_purchase_restaurant`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cohort_retention_by_month_first_purchase_restaurant`  AS SELECT `c`.`cohort` AS `cohort`, `m`.`months_active` AS `month_actual`, count(`m`.`revenue`) AS `revenue`, rank()  ( partition by `c`.`cohort` order by `m`.`months_active`) - 1 AS `over` FROM (`cohort_dfn_by_month_first_purchase_restaurant` `c` join `retention_by_user_by_month_restaurant` `m` on(`c`.`user_id` = `m`.`user_id`)) GROUP BY 1, 2 ORDER BY `m`.`months_active` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `cohort_retention_by_month_first_purchase_retail`
--
DROP TABLE IF EXISTS `cohort_retention_by_month_first_purchase_retail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cohort_retention_by_month_first_purchase_retail`  AS SELECT `c`.`cohort` AS `cohort`, `m`.`months_active` AS `month_actual`, count(`m`.`revenue`) AS `revenue`, rank()  ( partition by `c`.`cohort` order by `m`.`months_active`) - 1 AS `over` FROM (`cohort_dfn_by_month_first_purchase_retail` `c` join `retention_by_user_by_month_retail` `m` on(`c`.`user_id` = `m`.`user_id`)) GROUP BY 1, 2 ORDER BY `m`.`months_active` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `retention_by_user_by_month`
--
DROP TABLE IF EXISTS `retention_by_user_by_month`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `retention_by_user_by_month`  AS SELECT `purchases`.`user_id` AS `user_id`, month(`purchases`.`purchase_date`) AS `months_active`, count(`purchases`.`id`) AS `revenue` FROM `purchases` GROUP BY 1, 2 ;

-- --------------------------------------------------------

--
-- Structure for view `retention_by_user_by_month_restaurant`
--
DROP TABLE IF EXISTS `retention_by_user_by_month_restaurant`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `retention_by_user_by_month_restaurant`  AS SELECT `purchases`.`user_id` AS `user_id`, month(`purchases`.`purchase_date`) AS `months_active`, count(`purchases`.`purchase_id`) AS `revenue` FROM `purchases` WHERE `purchases`.`product_line` = 'Restaurant' GROUP BY 1, 2 ;

-- --------------------------------------------------------

--
-- Structure for view `retention_by_user_by_month_retail`
--
DROP TABLE IF EXISTS `retention_by_user_by_month_retail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `retention_by_user_by_month_retail`  AS SELECT `purchases`.`user_id` AS `user_id`, month(`purchases`.`purchase_date`) AS `months_active`, count(`purchases`.`purchase_id`) AS `revenue` FROM `purchases` WHERE `purchases`.`product_line` = 'Retail store' GROUP BY 1, 2 ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
