/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 8.0.33 : Database - audioshield
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`audioshield` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `audioshield`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add login_table',7,'add_login_table'),
(26,'Can change login_table',7,'change_login_table'),
(27,'Can delete login_table',7,'delete_login_table'),
(28,'Can view login_table',7,'view_login_table'),
(29,'Can add user_table',8,'add_user_table'),
(30,'Can change user_table',8,'change_user_table'),
(31,'Can delete user_table',8,'delete_user_table'),
(32,'Can view user_table',8,'view_user_table'),
(33,'Can add feedback_table',9,'add_feedback_table'),
(34,'Can change feedback_table',9,'change_feedback_table'),
(35,'Can delete feedback_table',9,'delete_feedback_table'),
(36,'Can view feedback_table',9,'view_feedback_table'),
(37,'Can add complaint_table',10,'add_complaint_table'),
(38,'Can change complaint_table',10,'change_complaint_table'),
(39,'Can delete complaint_table',10,'delete_complaint_table'),
(40,'Can view complaint_table',10,'view_complaint_table'),
(41,'Can add otp',11,'add_otp'),
(42,'Can change otp',11,'change_otp'),
(43,'Can delete otp',11,'delete_otp'),
(44,'Can view otp',11,'view_otp'),
(45,'Can add audio_table',12,'add_audio_table'),
(46,'Can change audio_table',12,'change_audio_table'),
(47,'Can delete audio_table',12,'delete_audio_table'),
(48,'Can view audio_table',12,'view_audio_table');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$600000$cVVeNSIPk46lz4Vh9TmTCq$4wVs6cG29YtUHPqs26JKM1UTyQOdCaHd0aZ9R5uRCPc=','2024-03-30 03:39:01.202281',1,'admin','','','admin@gmail.com',1,1,'2024-03-15 08:53:09.740296');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(12,'fakeaudio','audio_table'),
(10,'fakeaudio','complaint_table'),
(9,'fakeaudio','feedback_table'),
(7,'fakeaudio','login_table'),
(11,'fakeaudio','otp'),
(8,'fakeaudio','user_table'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2024-02-04 06:12:41.736873'),
(2,'auth','0001_initial','2024-02-04 06:12:42.584305'),
(3,'admin','0001_initial','2024-02-04 06:12:42.841178'),
(4,'admin','0002_logentry_remove_auto_add','2024-02-04 06:12:42.856692'),
(5,'admin','0003_logentry_add_action_flag_choices','2024-02-04 06:12:42.872325'),
(6,'contenttypes','0002_remove_content_type_name','2024-02-04 06:12:43.014749'),
(7,'auth','0002_alter_permission_name_max_length','2024-02-04 06:12:43.140408'),
(8,'auth','0003_alter_user_email_max_length','2024-02-04 06:12:43.187879'),
(9,'auth','0004_alter_user_username_opts','2024-02-04 06:12:43.203606'),
(10,'auth','0005_alter_user_last_login_null','2024-02-04 06:12:43.298329'),
(11,'auth','0006_require_contenttypes_0002','2024-02-04 06:12:43.313991'),
(12,'auth','0007_alter_validators_add_error_messages','2024-02-04 06:12:43.329704'),
(13,'auth','0008_alter_user_username_max_length','2024-02-04 06:12:43.440715'),
(14,'auth','0009_alter_user_last_name_max_length','2024-02-04 06:12:43.535886'),
(15,'auth','0010_alter_group_name_max_length','2024-02-04 06:12:43.567094'),
(16,'auth','0011_update_proxy_permissions','2024-02-04 06:12:43.582764'),
(17,'auth','0012_alter_user_first_name_max_length','2024-02-04 06:12:43.645857'),
(18,'fakeaudio','0001_initial','2024-02-04 06:12:43.963789'),
(19,'sessions','0001_initial','2024-02-04 06:12:44.025695'),
(20,'fakeaudio','0002_otp','2024-03-10 05:38:15.241359'),
(21,'fakeaudio','0003_audio_table','2024-03-28 05:11:15.267295');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('05qmcbji24l623qhx1zsyiomeh5nci9d','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rlLmy:JLG6i7_lp9RKac32SDoFyqonfz-KWedxWH1Qu_9ZLQI','2024-03-30 04:36:56.013728'),
('3xsny5rh3gziesx997mdv9g74ctszwsp','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnE7I:dH43gImT-9pCxumwA2CjByxczsrJaDJR1Q9TQkMzw2s','2024-04-04 08:49:40.298446'),
('5os6ecayw3tlo0hedoym3cturc5qz9h6','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnsyf:B-YWfu6EPQFxn-y36DMVptPb79gcg5KosMix342P0Uk','2024-04-06 04:27:29.910011'),
('aghsgh77ngniyh3zmn2r2p3a0i4uxx5c','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnsiv:FQBwCo6wRNHBmCRvbuHsPPLpg15-sDIeOMuNpfcIoC0','2024-04-06 04:11:13.887462'),
('azutz2mgoju5bja6j479019w66vic2hf','eyJjaWQiOjZ9:1reSVG:AR-dCnMKbyGPwpQFPd4Jh1-aGqOZ3K8AZCLUYGJJxTY','2024-03-11 04:22:10.805337'),
('ea3afsw9oni4z95f6b5i15b01t4eq7lf','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnt0W:nHIqeGhod1a5wkRHpPtTDtV8DXIov0BfkvzfTh0z1Qs','2024-04-06 04:29:24.368139'),
('iheo6z6thlecorh1s6nu6m19ukve3rtt','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnt7P:gGmmJYW4sEnj73oYwMHJMz9zav8ylV47Z7vHS7qfeQg','2024-04-06 04:36:31.137792'),
('mpx4zglmmdowlkkwhr4pken94o68gjha','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rlLqs:SDUfq76RKV5cwySpqTBPDzc-8vtVrxDbn9VXeVKZeXM','2024-03-30 04:40:58.686744'),
('pkf88v07zhl9puhmtrqujlinesvca2m5','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnsv0:kyNcEVB_y3z_CXJ49ZXA79Hap1HYASYvl8ECQID7i9c','2024-04-06 04:23:42.471918'),
('sn3wgz508qibcr67ybl7sgzzg5ngybsr','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnt6C:aneYR0e_Uk9v6LyQyR2FbazEU1qrCS9Anq8ufTHqAPc','2024-04-06 04:35:16.136846'),
('tz5p3zlo0dk8nnm7tjy965ldhd0ei7zy','eyJjaWQiOjF9:1rYK6p:cEvlhUrxHlB2CO_ZeFmwVBtMPeBIQbU_5Lss1pMjkMc','2024-02-23 06:11:35.863081'),
('yo3m9nfhd0p5xhs9y3bsbr4pt0crpm20','.eJxVjMEOwiAQRP-FsyHAQqAevfsNBNhdqRqalPZk_Hcl6UGPM-_NvERM-1bj3mmNM4qz0OL02-VUHtQGwHtqt0WWpW3rnOVQ5EG7vC5Iz8vh_h3U1OtYk80GCFgrnrIzHpiMZ2ZbQnIFnMGAECZUllSBFBhC_iavjEbOQbw__Dw4aA:1rnstZ:pl67AGLR3g_0oXAqE8qvusAvri5_z1jVXV2YAR6bXM8','2024-04-06 04:22:13.913006');

/*Table structure for table `fakeaudio_audio_table` */

DROP TABLE IF EXISTS `fakeaudio_audio_table`;

CREATE TABLE `fakeaudio_audio_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `result` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `confidence_level` double NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fakeaudio_audio_tabl_LOGIN_id_199f1370_fk_fakeaudio` (`LOGIN_id`),
  CONSTRAINT `fakeaudio_audio_tabl_LOGIN_id_199f1370_fk_fakeaudio` FOREIGN KEY (`LOGIN_id`) REFERENCES `fakeaudio_login_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fakeaudio_audio_table` */

insert  into `fakeaudio_audio_table`(`id`,`file`,`result`,`date`,`confidence_level`,`LOGIN_id`) values 
(1,'20240328-111906.mp3','valid','2024-03-28',83,17),
(2,'20240328-112155.mp3','valid','2024-03-28',83,17),
(6,'20240330-100429.mp3','valid','2024-03-30',83,17),
(7,'20240330-102204.mp3','valid','2024-03-30',83,17),
(8,'20240330-102219.opus','valid','2024-03-30',83,17),
(9,'20240330-103002.opus','Real','2024-03-30',99.64,17),
(10,'20240330-103246.opus','Real','2024-03-30',99.64,17),
(11,'20240330-103331.opus','Real','2024-03-30',99.64,17),
(12,'20240330-103344.opus','Real','2024-03-30',99.64,17),
(13,'20240330-103402.opus','Real','2024-03-30',99.64,17),
(14,'20240330-103404.opus','Real','2024-03-30',99.64,17),
(15,'20240330-103444.opus','Real','2024-03-30',99.64,17),
(16,'20240330-103828.wav','Fake','2024-03-30',0.84,17),
(17,'20240330-103845.wav','Fake','2024-03-30',0.84,17),
(18,'20240330-104128.wav','Fake','2024-03-30',0.84,17),
(19,'20240330-104137.wav','Fake','2024-03-30',0.84,17),
(20,'20240330-104141.wav','Fake','2024-03-30',1.27,17),
(21,'20240330-104143.wav','Fake','2024-03-30',1.27,17),
(22,'20240330-104148.wav','Fake','2024-03-30',1.79,17),
(23,'20240330-104158.wav','Fake','2024-03-30',1.27,17),
(24,'20240330-104242.wav','Fake','2024-03-30',0.84,17),
(25,'20240330-104314.opus','Real','2024-03-30',99.64,17),
(26,'20240330-104323.opus','Real','2024-03-30',99.94,17),
(27,'20240330-104609.wav','Fake','2024-03-30',99.23,17),
(28,'20240330-104619.wav','Fake','2024-03-30',98.73,17),
(29,'20240330-104702.wav','Fake','2024-03-30',98.21,17),
(30,'20240330-104710.wav','Fake','2024-03-30',98.73,17),
(31,'20240330-104714.wav','Fake','2024-03-30',99.16,17),
(32,'20240330-104727.opus','Real','2024-03-30',98.38,17),
(33,'20240330-104800.mp3','Fake','2024-03-30',88.46000000000001,17),
(34,'20240330-105018.mp3','Fake','2024-03-30',88.46000000000001,17),
(35,'20240330-105022.mp3','Fake','2024-03-30',88.46000000000001,17),
(36,'20240330-105036.mp3','Fake','2024-03-30',88.46000000000001,17),
(37,'20240330-105052.opus','Real','2024-03-30',98.38,17);

/*Table structure for table `fakeaudio_complaint_table` */

DROP TABLE IF EXISTS `fakeaudio_complaint_table`;

CREATE TABLE `fakeaudio_complaint_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `complaint` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `reply` varchar(120) NOT NULL,
  `userid_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fakeaudio_complaint__userid_id_2457a916_fk_fakeaudio` (`userid_id`),
  CONSTRAINT `fakeaudio_complaint__userid_id_2457a916_fk_fakeaudio` FOREIGN KEY (`userid_id`) REFERENCES `fakeaudio_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fakeaudio_complaint_table` */

insert  into `fakeaudio_complaint_table`(`id`,`complaint`,`date`,`reply`,`userid_id`) values 
(1,'error','2024-02-09','juygttt',1),
(3,'error','2024-02-12','done',1),
(4,'error','2024-02-12','',1),
(5,'error','2024-02-25','ok done',13),
(6,'error','2024-02-26','rswdfsdfs',7),
(31,'problem with ui','2024-03-18','I will fix it',16),
(32,'glitch in the app','2024-03-18','ok bro',16),
(33,'problem ','2024-03-18','pending',16),
(34,'ok','2024-03-18','pending',16),
(35,'problem ','2024-03-18','pending',16),
(36,'issue','2024-03-18','pending',16),
(37,'issue ','2024-03-18','pending',16),
(38,'poor design','2024-03-20','I will fix it.',16);

/*Table structure for table `fakeaudio_feedback_table` */

DROP TABLE IF EXISTS `fakeaudio_feedback_table`;

CREATE TABLE `fakeaudio_feedback_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `feedback` varchar(120) NOT NULL,
  `date` date NOT NULL,
  `userid_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fakeaudio_feedback_t_userid_id_5fe6ff67_fk_fakeaudio` (`userid_id`),
  CONSTRAINT `fakeaudio_feedback_t_userid_id_5fe6ff67_fk_fakeaudio` FOREIGN KEY (`userid_id`) REFERENCES `fakeaudio_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fakeaudio_feedback_table` */

insert  into `fakeaudio_feedback_table`(`id`,`feedback`,`date`,`userid_id`) values 
(1,'ok nice','2024-02-09',1),
(2,'ok','2024-02-12',1),
(4,'hi','2024-03-17',16),
(5,'nice app','2024-03-17',16),
(6,'nice ui','2024-03-17',16),
(11,'ok nice','2024-03-17',16),
(12,'nice ok','2024-03-17',16),
(13,'ok','2024-03-17',16),
(14,'ok','2024-03-17',16),
(15,'ok','2024-03-18',16),
(16,'It\'s nice','2024-03-20',16);

/*Table structure for table `fakeaudio_login_table` */

DROP TABLE IF EXISTS `fakeaudio_login_table`;

CREATE TABLE `fakeaudio_login_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(30) NOT NULL,
  `type` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fakeaudio_login_table` */

insert  into `fakeaudio_login_table`(`id`,`username`,`password`,`type`) values 
(1,'admin','admin','admin'),
(2,'user','Stm1234@','user'),
(8,'123','123','user'),
(9,'kiran@gmail.com','kiran@123','user'),
(12,'youarecute571@gmail.com','You@1234','user'),
(13,'nanma@gmail.com','Nanma@123','user'),
(14,'gokul@gmail.com','Gokul@123','user'),
(15,'ajal@gmail.com','Ajal@123','user'),
(16,'ahs@123.as','Jithin123','user'),
(17,'gokul@123gmail.com','Gokul123@','user');

/*Table structure for table `fakeaudio_otp` */

DROP TABLE IF EXISTS `fakeaudio_otp`;

CREATE TABLE `fakeaudio_otp` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `otp` varchar(10) NOT NULL,
  `userid_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fakeaudio_otp_userid_id_f91ea110_fk_fakeaudio_user_table_id` (`userid_id`),
  CONSTRAINT `fakeaudio_otp_userid_id_f91ea110_fk_fakeaudio_user_table_id` FOREIGN KEY (`userid_id`) REFERENCES `fakeaudio_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fakeaudio_otp` */

insert  into `fakeaudio_otp`(`id`,`otp`,`userid_id`) values 
(1,'31240',1),
(2,'62786',1),
(3,'50484',1),
(4,'52657',1),
(5,'40065',1),
(6,'51787',1),
(7,'71363',1),
(8,'36503',1),
(9,'19908',1),
(10,'70119',1),
(11,'75897',1),
(12,'37309',1);

/*Table structure for table `fakeaudio_user_table` */

DROP TABLE IF EXISTS `fakeaudio_user_table`;

CREATE TABLE `fakeaudio_user_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstname` varchar(60) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `place` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` bigint NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fakeaudio_user_table_LOGIN_id_e0a81f7a_fk_fakeaudio` (`LOGIN_id`),
  CONSTRAINT `fakeaudio_user_table_LOGIN_id_e0a81f7a_fk_fakeaudio` FOREIGN KEY (`LOGIN_id`) REFERENCES `fakeaudio_login_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `fakeaudio_user_table` */

insert  into `fakeaudio_user_table`(`id`,`firstname`,`lastname`,`photo`,`place`,`email`,`phone`,`LOGIN_id`) values 
(1,'Shonin','K.T','20240222-120331.jpg','thalassery','youarecute571@gmail.com',8543679467,12),
(7,'Parrot ','G','20240222-120331.jpg','Cage','parrot@gmail.com',123456789,8),
(8,'kiran','kumar','20240222-121946.jpg','kollam','kiran@gmail.com',8978787656,9),
(11,'Shonin','T K','20240223-085920.jpg','Mattanur','shonintk@gmail.com',123456789,12),
(12,'nanma','n','20240223-200420.jpg','nanma','nanma@gmail.com',526626211,13),
(13,'gokul','Tk','20240225-105203.jpg','kannur','gokul@gmail.com',9752135794,14),
(14,'Ajal',' Master','20240226-091852.jpg','kannur','ajal@gmail.com',9876543212,15),
(15,'asd','gg','20240226-095707.jpg','asd','ahs@123.as',8123456780,16),
(16,'Gokul','KP','20240323-093009.jpg','Kannur','gokul@123gmail.com',9282625212,17);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
