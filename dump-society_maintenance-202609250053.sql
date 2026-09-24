/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acl_user_action_rlt`
--

DROP TABLE IF EXISTS `acl_user_action_rlt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acl_user_action_rlt` (
  `rlt_pk` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `action_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activate_flag` int DEFAULT '1',
  `created_date` datetime NOT NULL,
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`rlt_pk`),
  KEY `idx_user_action` (`user_id`,`activate_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_user_role_rlt`
--

DROP TABLE IF EXISTS `acl_user_role_rlt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acl_user_role_rlt` (
  `rlt_pk` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`rlt_pk`),
  KEY `acl_user_role_rlt_user_id_IDX` (`user_id`,`role_id`,`activate_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config_maintenence`
--

DROP TABLE IF EXISTS `config_maintenence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_maintenence` (
  `config_id` bigint NOT NULL AUTO_INCREMENT,
  `property_type` varchar(100) DEFAULT NULL,
  `owner_type` varchar(100) DEFAULT NULL,
  `sub_type` varchar(100) DEFAULT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `effective_from_date` date DEFAULT NULL,
  `effective_to_date` date DEFAULT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flat_exception_master`
--

DROP TABLE IF EXISTS `flat_exception_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flat_exception_master` (
  `exception_id` bigint NOT NULL AUTO_INCREMENT,
  `flat_id` bigint DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`exception_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flat_owner_mapping`
--

DROP TABLE IF EXISTS `flat_owner_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flat_owner_mapping` (
  `flat_owner_id` bigint NOT NULL AUTO_INCREMENT,
  `flat_id` bigint DEFAULT NULL,
  `person_id` bigint DEFAULT NULL,
  `purchase_date` datetime DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`flat_owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flat_tenant_mapping`
--

DROP TABLE IF EXISTS `flat_tenant_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flat_tenant_mapping` (
  `flat_tenant_id` bigint NOT NULL AUTO_INCREMENT,
  `flat_id` bigint DEFAULT NULL,
  `person_id` bigint DEFAULT NULL,
  `rented_date` datetime DEFAULT NULL,
  `vacated_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`flat_tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frm_audit_trail`
--

DROP TABLE IF EXISTS `frm_audit_trail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frm_audit_trail` (
  `audit_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) DEFAULT NULL,
  `url` varchar(5000) DEFAULT NULL,
  `parameters` longtext,
  `accessed_time` datetime DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `browser_name` varchar(300) DEFAULT NULL,
  `responded_time` datetime DEFAULT NULL,
  `response_string` longtext,
  PRIMARY KEY (`audit_id`),
  KEY `frm_audit_trail_user_name_IDX` (`user_name`) USING BTREE,
  KEY `frm_audit_trail_accessed_time_IDX` (`accessed_time`) USING BTREE,
  KEY `frm_audit_trail_user_name_accessed_time_IDX` (`user_name`,`accessed_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52309 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frm_error_log`
--

DROP TABLE IF EXISTS `frm_error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frm_error_log` (
  `error_id` int NOT NULL AUTO_INCREMENT,
  `error_message` mediumtext,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`error_id`)
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frm_query_log`
--

DROP TABLE IF EXISTS `frm_query_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frm_query_log` (
  `query_id` bigint NOT NULL AUTO_INCREMENT,
  `query_string` mediumtext NOT NULL,
  `time_taken` decimal(10,0) NOT NULL,
  `accessed_time` datetime DEFAULT NULL,
  PRIMARY KEY (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guest_vehicle_entry`
--

DROP TABLE IF EXISTS `guest_vehicle_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guest_vehicle_entry` (
  `guest_vehicle_id` bigint NOT NULL AUTO_INCREMENT,
  `flat_id` bigint DEFAULT NULL,
  `guest_name` varchar(100) DEFAULT NULL,
  `guest_mobile_no` bigint DEFAULT NULL,
  `guest_vehicle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `guest_vehicle_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `in_time` datetime DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`guest_vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hist_tbl_task_manager`
--

DROP TABLE IF EXISTS `hist_tbl_task_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_tbl_task_manager` (
  `task_id` int NOT NULL,
  `task_date` datetime DEFAULT NULL,
  `target_date` datetime DEFAULT NULL,
  `task_name` varchar(100) DEFAULT NULL,
  `task_type` varchar(50) DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `assigned_by` int DEFAULT NULL,
  `curr_status` varchar(50) DEFAULT NULL,
  `task_completed_date` datetime DEFAULT NULL,
  `activate_flag` tinyint(1) DEFAULT NULL,
  `priority` varchar(50) DEFAULT NULL,
  `remarks` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `action_type` enum('CREATE','UPDATE','DELETE') DEFAULT NULL,
  `action_msg` varchar(50) DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `action_by` varchar(50) DEFAULT NULL,
  `app_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `holiday_master`
--

DROP TABLE IF EXISTS `holiday_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holiday_master` (
  `holiday_id` bigint NOT NULL AUTO_INCREMENT,
  `holiday_name` varchar(100) DEFAULT NULL,
  `holiday_date` date DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  PRIMARY KEY (`holiday_id`),
  KEY `holiday_master_holiday_date_IDX` (`holiday_date`,`activate_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mom_agenda_mst`
--

DROP TABLE IF EXISTS `mom_agenda_mst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mom_agenda_mst` (
  `mom_agenda_id` int NOT NULL AUTO_INCREMENT,
  `mom_agenda_name` varchar(200) NOT NULL,
  `mom_category_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_dt` datetime DEFAULT NULL,
  `activate_flag` int DEFAULT '1',
  PRIMARY KEY (`mom_agenda_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mom_category_mst`
--

DROP TABLE IF EXISTS `mom_category_mst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mom_category_mst` (
  `mom_category_id` int NOT NULL AUTO_INCREMENT,
  `mom_category_name` varchar(200) NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_dt` datetime DEFAULT NULL,
  `activate_flag` int DEFAULT '1',
  PRIMARY KEY (`mom_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_account`
--

DROP TABLE IF EXISTS `mst_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_account` (
  `account_id` bigint NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `account_no` varchar(100) DEFAULT NULL,
  `ifsc_code` varchar(100) DEFAULT NULL,
  `qr_code` varchar(100) DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_app`
--

DROP TABLE IF EXISTS `mst_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_app` (
  `app_id` bigint NOT NULL DEFAULT '0',
  `app_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `about_us_content` mediumtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `contact_1` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `contact_2` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `map_cordinates` mediumtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `address` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `valid_till` date DEFAULT NULL,
  `app_type` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `threads_overlap` int DEFAULT NULL,
  `app_short_code` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_block`
--

DROP TABLE IF EXISTS `mst_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_block` (
  `block_id` bigint NOT NULL AUTO_INCREMENT,
  `block_name` varchar(100) DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_client`
--

DROP TABLE IF EXISTS `mst_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_client` (
  `client_id` bigint NOT NULL AUTO_INCREMENT,
  `client_name` varchar(100) DEFAULT NULL,
  `address_of_the_establishment` varchar(100) DEFAULT NULL,
  `date_of_setup` date DEFAULT NULL,
  `company_pan` varchar(10) NOT NULL,
  `ownership_details` varchar(10) DEFAULT NULL,
  `gst_no` varchar(100) DEFAULT NULL,
  `contact_person_name` varchar(200) DEFAULT NULL,
  `contact_person_email_id` varchar(50) DEFAULT NULL,
  `contact_person_mobile_no` bigint DEFAULT NULL,
  `director_name` varchar(100) DEFAULT NULL,
  `director_pan_card` varchar(10) DEFAULT NULL,
  `activate_flag` tinyint NOT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_Date` datetime DEFAULT NULL,
  `director_dob` date DEFAULT NULL,
  `director_email_id` varchar(100) DEFAULT NULL,
  `director_mobile_no` bigint DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_dept`
--

DROP TABLE IF EXISTS `mst_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_dept` (
  `department_id` bigint NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dept_short_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_designation`
--

DROP TABLE IF EXISTS `mst_designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_designation` (
  `designation_id` int NOT NULL AUTO_INCREMENT,
  `designation_name` varchar(100) DEFAULT NULL,
  `designation_short_code` varchar(100) DEFAULT NULL,
  `no_of_positions` int DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  PRIMARY KEY (`designation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_flat`
--

DROP TABLE IF EXISTS `mst_flat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_flat` (
  `flat_id` bigint NOT NULL AUTO_INCREMENT,
  `block_id` bigint DEFAULT NULL,
  `flat_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`flat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_person`
--

DROP TABLE IF EXISTS `mst_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_person` (
  `person_id` bigint NOT NULL AUTO_INCREMENT,
  `person_name` varchar(100) DEFAULT NULL,
  `person_mobile_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_shop`
--

DROP TABLE IF EXISTS `mst_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_shop` (
  `shop_id` bigint NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(100) DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_vehicle`
--

DROP TABLE IF EXISTS `mst_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mst_vehicle` (
  `vehicle_id` bigint NOT NULL AUTO_INCREMENT,
  `flat_id` bigint DEFAULT NULL,
  `vehicle_name` varchar(100) DEFAULT NULL,
  `vehicle_number` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=429 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `report_id` bigint NOT NULL,
  `report_name` varchar(100) DEFAULT NULL,
  `class_name` varchar(100) DEFAULT NULL,
  `method_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_columns`
--

DROP TABLE IF EXISTS `report_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_columns` (
  `column_id` bigint NOT NULL AUTO_INCREMENT,
  `report_id` bigint DEFAULT NULL,
  `column_name` varchar(100) DEFAULT NULL,
  `column_value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_parameters`
--

DROP TABLE IF EXISTS `report_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_parameters` (
  `parameter_id` bigint NOT NULL AUTO_INCREMENT,
  `report_id` bigint DEFAULT NULL,
  `parameter_label` varchar(100) DEFAULT NULL,
  `parameter_form_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `parameter_type` varchar(100) DEFAULT NULL,
  `default_value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`parameter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rlt_agenda_task`
--

DROP TABLE IF EXISTS `rlt_agenda_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rlt_agenda_task` (
  `agenda_task_id` int NOT NULL AUTO_INCREMENT,
  `agenda_id` int NOT NULL,
  `task_id` int NOT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `activate_flag` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`agenda_task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rlt_mom_agenda`
--

DROP TABLE IF EXISTS `rlt_mom_agenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rlt_mom_agenda` (
  `agenda_id` int NOT NULL AUTO_INCREMENT,
  `mom_id` int DEFAULT NULL,
  `agenda_point` text,
  `is_discussed` tinyint(1) DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_ts` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_ts` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`agenda_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seq_master`
--

DROP TABLE IF EXISTS `seq_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seq_master` (
  `sequence_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence_name` varchar(100) NOT NULL,
  `current_seq_no` bigint NOT NULL,
  PRIMARY KEY (`sequence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_attachment_mst`
--

DROP TABLE IF EXISTS `tbl_attachment_mst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_attachment_mst` (
  `attachment_id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(200) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `file_id` int DEFAULT NULL,
  `type` varchar(300) DEFAULT NULL,
  `attachment_asblob` longblob,
  PRIMARY KEY (`attachment_id`),
  KEY `tbl_attachment_mst_file_id_IDX` (`file_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_task_manager`
--

DROP TABLE IF EXISTS `tbl_task_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_task_manager` (
  `task_id` int NOT NULL AUTO_INCREMENT,
  `task_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `target_date` datetime DEFAULT NULL,
  `task_name` varchar(100) NOT NULL,
  `task_type` enum('Daily','Weekly','Monthly','Quarterly','Yearly','OneTime') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `assigned_to` int NOT NULL,
  `assigned_by` int NOT NULL,
  `curr_status` enum('Pending','In Progress','Done','Canceled','Verified') DEFAULT 'Pending',
  `task_completed_date` datetime DEFAULT NULL,
  `activate_flag` tinyint(1) DEFAULT '1',
  `priority` enum('Low','Medium','High','Urgent') DEFAULT 'Medium',
  `remarks` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `assigned_to` (`assigned_to`),
  KEY `assigned_by` (`assigned_by`)
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_user_mst`
--

DROP TABLE IF EXISTS `tbl_user_mst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user_mst` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `app_id` bigint DEFAULT NULL,
  `aadhar_card_no` varchar(20) DEFAULT NULL,
  `parent_user_id` bigint DEFAULT NULL,
  `qr_code` int DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `designation_id` bigint DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `tbl_user_mst_username_IDX` (`username`,`password`,`activate_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_agenda_announcements`
--

DROP TABLE IF EXISTS `trn_agenda_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_agenda_announcements` (
  `announcement_id` int NOT NULL AUTO_INCREMENT,
  `agenda_id` int DEFAULT NULL,
  `announcement` text,
  `created_by` int DEFAULT NULL,
  `created_ts` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_ts` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_agenda_register`
--

DROP TABLE IF EXISTS `trn_agenda_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_agenda_register` (
  `agenda_id` int NOT NULL AUTO_INCREMENT,
  `agenda_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mom_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_dt` datetime DEFAULT NULL,
  `activate_flag` int DEFAULT '1',
  PRIMARY KEY (`agenda_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_checkin_register`
--

DROP TABLE IF EXISTS `trn_checkin_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_checkin_register` (
  `check_in_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `check_in_type` char(1) NOT NULL,
  `checked_time` datetime NOT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`check_in_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1392 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_collect_transfer_fees`
--

DROP TABLE IF EXISTS `trn_collect_transfer_fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_collect_transfer_fees` (
  `transfer_id` bigint NOT NULL AUTO_INCREMENT,
  `unique_id` bigint DEFAULT NULL,
  `receipt_no` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `from_owner` bigint DEFAULT NULL,
  `to_owner` bigint DEFAULT NULL,
  `transfer_date` datetime DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `amount` bigint DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `reference_no` varchar(200) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`transfer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_distribution_register`
--

DROP TABLE IF EXISTS `trn_distribution_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_distribution_register` (
  `distribution_id` bigint NOT NULL AUTO_INCREMENT,
  `vehicle_id` bigint DEFAULT NULL,
  `collected_by` varchar(100) DEFAULT NULL,
  `collection_date` datetime DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_expense_register`
--

DROP TABLE IF EXISTS `trn_expense_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_expense_register` (
  `expense_id` bigint NOT NULL AUTO_INCREMENT,
  `expense_name` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `expense_date` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `qty` decimal(10,0) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_income_register`
--

DROP TABLE IF EXISTS `trn_income_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_income_register` (
  `income_id` bigint NOT NULL AUTO_INCREMENT,
  `income_name` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `income_date` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`income_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_maintenence_collection`
--

DROP TABLE IF EXISTS `trn_maintenence_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_maintenence_collection` (
  `collection_id` bigint NOT NULL AUTO_INCREMENT,
  `receipt_no` varchar(100) DEFAULT NULL,
  `unique_id` bigint DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `collection_date` datetime DEFAULT NULL,
  `maintenence_from_date` datetime DEFAULT NULL,
  `maintenence_to_date` datetime DEFAULT NULL,
  `amount` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `updated_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `owner_flag` varchar(100) DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  PRIMARY KEY (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3242 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_mom_attendees`
--

DROP TABLE IF EXISTS `trn_mom_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_mom_attendees` (
  `attendee_id` int NOT NULL AUTO_INCREMENT,
  `mom_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_ts` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_ts` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`attendee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_mom_discussions`
--

DROP TABLE IF EXISTS `trn_mom_discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_mom_discussions` (
  `discussion_id` int NOT NULL AUTO_INCREMENT,
  `agenda_id` int NOT NULL,
  `discussion_text` text NOT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `activate_flag` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`discussion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trn_mom_register`
--

DROP TABLE IF EXISTS `trn_mom_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trn_mom_register` (
  `mom_id` int NOT NULL AUTO_INCREMENT,
  `mom_no` varchar(50) NOT NULL,
  `mom_date` date NOT NULL,
  `mom_conclusion` text,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `activate_flag` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`mom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visitor_entry`
--

DROP TABLE IF EXISTS `visitor_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor_entry` (
  `visitor_id` int NOT NULL AUTO_INCREMENT,
  `visitor_name` varchar(45) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `purpose_of_visit` varchar(100) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  `mobile_no` varchar(100) DEFAULT NULL,
  `email_id` varchar(45) DEFAULT NULL,
  `checkin_time` datetime DEFAULT NULL,
  `app_id` bigint NOT NULL,
  `in_time` datetime DEFAULT NULL,
  `activate_flag` tinyint DEFAULT NULL,
  `contact_to_employee` bigint DEFAULT NULL,
  `checkout_time` datetime DEFAULT NULL,
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'society_maintenance'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-25  0:53:58
