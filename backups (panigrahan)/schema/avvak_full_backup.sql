-- MySQL dump 10.13  Distrib 8.4.9, for Linux (x86_64)
--
-- Host: localhost    Database: avvak
-- ------------------------------------------------------
-- Server version	8.4.9

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
-- Current Database: `avvak`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `avvak` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `avvak`;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `relationid` int unsigned DEFAULT NULL,
  `relationtype` varchar(30) DEFAULT NULL,
  `addone` varchar(100) DEFAULT NULL,
  `addtwo` varchar(100) DEFAULT NULL,
  `addthree` varchar(100) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `district` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_addpartyp` (`relationtype`),
  KEY `idx_addparid` (`relationid`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (5,2,'profile','ags layout','shivaganga sathyarama',NULL,'bangalore','bangalore','karnataka','indiua','560061'),(6,6,'profile','kamakshipalya','123',NULL,'bangalore','bangalore urban','karnataka','india','560070'),(8,5,'profile','NR Coloney','bus stop',NULL,'bangalore','bangalore','karnataka','india','560061'),(10,3,'profile','ags layout','shivaganga sathyarama',NULL,'hindupur','bangalore','karnataka','india','560045'),(11,4,'profile','ags layout','shivaganga sathyarama',NULL,'bangalore','bangalore urban','karnataka','India','560061'),(13,1,'family','ags layout','shivaganga sathyarama',NULL,'hindupur','bangalore urban','karnataka','India','560070'),(14,13,'family','NR Coloney','shivaganga sathyarama',NULL,'hindupur','hindupur','Andra Praadesh','India','560075'),(16,4,'family','hindupur ','#92 201 5th cross',NULL,'hindupur','vijaywada','karnataka','india','1234567'),(17,15,'family','dollars coloney','bus stop',NULL,'madanapalli','kadapa','Andra Praadesh','india','702256'),(18,7,'profile','NR Coloney','bus stop',NULL,'vijaywada','kadapa','karnataka','India','560070'),(19,1,'profile','NR Coloney','bus stop',NULL,'bangalore','bangalore','karnataka','India','560070'),(20,8,'profile','kamakshipalya','bus stop',NULL,'vijaywada','vijaywada','Andra Praadesh','India','123456'),(21,17,'family','test street','',NULL,'test city','bangalore','ka','in','560001'),(22,8,'profile','ags layout','bus stop',NULL,'bangalore','bangalore urban','karnataka','India','560061'),(23,9,'profile','ags layout','bus stop',NULL,'bangalore','bangalore','karnataka','India','560061'),(24,11,'family','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(25,11,'family','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(26,23,'family','nariman point','',NULL,'mumbai','mumbai','maharasthra','India','263215'),(27,12,'profile','nariman point','',NULL,'mumbai','mumbai','maharasthra','India','263215'),(28,12,'profile','','',NULL,'','','','',''),(29,12,'profile','nariman point','',NULL,'mumbai','mumbai','maharasthra','India','263215'),(30,12,'profile','nariman point','',NULL,'Mumbai','mumbai','Maharasthra','India','263215'),(31,11,'profile','nariman point','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','mumbai','maharasthra','India','263215'),(32,11,'profile','','',NULL,'','','','',''),(33,11,'profile','nariman point','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','mumbai','maharasthra','India','263215'),(34,3,'profile','Shivaganga Sathyarama ','AGS Layout',NULL,'Hydhrabad','hydhrabad','telangana','India','263215'),(35,3,'profile','JP Nagar','Jeevan Ananda',NULL,'bangalore','bangalore','karnataka','india','560082'),(36,13,'profile','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(37,13,'profile','JP Nagar','',NULL,'bangalore','bangalore','karnataka','india','560082'),(38,12,'profile','','',NULL,'','','','',''),(39,23,'family','','',NULL,'','','','',''),(40,24,'family','','',NULL,'','','','',''),(41,5,'profile','','',NULL,'','','','',''),(42,20,'family','','',NULL,'','','','',''),(43,21,'family','','',NULL,'','','','',''),(44,5,'profile','NR Coloney','',NULL,'bangalore','bangalore','karnataka','India','560061'),(45,20,'family','NR Coloney','',NULL,'bangalore','bangalore','karnataka','India','560061'),(46,21,'family','NR Coloney','',NULL,'bangalore','bangalore','karnataka','India','560061'),(47,1,'profile','#123 Parvathi nilayam','Nayandhalli, 5th main road',NULL,'bangalore','bangalore','karnataka','India','560070'),(48,1,'profile','JP Nagar','oracle',NULL,'bangalore','bangalore','karnataka','india','560082'),(49,16,'family','#123 Parvathi nilayam','Nayandhalli, 5th main road',NULL,'bangalore','bangalore','karnataka','India','560070'),(50,14,'profile','Shivaganga Sathyarama ','AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(51,14,'profile','Shivaganga Sathyarama ','AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(52,25,'family','Shivaganga Sathyarama ','AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(53,26,'family','#93 201 5th main','',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(54,15,'profile','','',NULL,'','','','',''),(55,26,'family','','',NULL,'','','','',''),(56,15,'profile','','',NULL,'','','','',''),(57,26,'family','','',NULL,'','','','',''),(58,15,'profile','','',NULL,'','','','',''),(59,26,'family','','',NULL,'','','','',''),(60,15,'profile','NR Coloney','',NULL,'bangalore','bangalore','karnataka','india','560045'),(61,26,'family','NR Coloney','',NULL,'bangalore','bangalore','karnataka','india','560045'),(62,15,'profile','NR Coloney','',NULL,'Nellore','bangalore','karnataka','india','560045'),(63,26,'family','NR Coloney','',NULL,'Nellore','bangalore','karnataka','india','560045'),(64,2,'profile','gandhi bazar ','',NULL,'chennai','chennai','tamilnadu','India','570034'),(65,6,'family','gandhi bazar ','',NULL,'chennai','chennai','tamilnadu','India','570034'),(66,15,'profile','ags layout','shivaganga sathyarama',NULL,'bangalore','bangalore','karnataka','India','560070'),(67,15,'profile','','',NULL,'','','','',''),(68,10,'profile','nariman point','Nayandhalli, 5th main road',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(69,14,'profile','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(70,25,'family','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(71,12,'profile','1200','Mc Kay Dr',NULL,'San Jose','','Ca','Usa','95131'),(72,19,'profile','#472','2nd cross,14th main, near asha bakery,srinivasnagar',NULL,'Bangalore','Bangaloresouth','Karnataka','India','560050'),(73,19,'profile','arya vysya kanya varanenneveshana kendra','@2/2, near vasavi convenentioncentre,opp bank of baroda, basavagudi,',NULL,'Bangalore','Bangalore South','Karnataka','India','560004'),(74,32,'family','','',NULL,'','','','',''),(75,32,'family','avkvk','#2/2, opp bank of barod, basavgudi',NULL,'Bangalore','Bangaloresouth','Karntaka','India','560004'),(76,19,'profile','#472','2nd cross,14th main, near asha bakery,srinivasnagar',NULL,'Bangalore','Bangaloresouth','Karnataka','India','560050'),(77,32,'family','#472','2nd cross,14th main, near asha bakery,srinivasnagar',NULL,'Bangalore','Bangaloresouth','Karnataka','India','560050'),(78,33,'family','#472','2nd cross,14th main, near asha bakery,srinivasnagar',NULL,'Bangalore','Bangaloresouth','Karnataka','India','560050'),(79,20,'profile','HSR Layout','1st Street 5th main ',NULL,'Bangalore','Bangalore','Karnataka','India','560080'),(80,18,'profile','#93 201 5th main ','Kengeri near Adithi public school',NULL,'Bangalore','Bangalore','Karnataka','India','560087'),(81,18,'profile','#93 201 5th main ','Kengeri near Adithi public school',NULL,'Bangalore','Bangalore','Karnataka','India','560087'),(82,18,'profile','#93 201 5th main ','Kengeri near Adithi public school',NULL,'Bangalore','Bangalore','Karnataka','India','560087'),(83,18,'profile','#93 201 5th main ','Kengeri near Adithi public school',NULL,'Bangalore','Bangalore','Karnataka','India','560087'),(84,18,'profile','#93 201 5th main ','Kengeri near Adithi public school',NULL,'Bangalore','Bangalore','Karnataka','India','560087'),(85,20,'profile','HSR Layout','1st Street 5th main ',NULL,'Bangalore','Bangalore','Karnataka','India','560080'),(86,20,'profile','HSR Layout','1st Street 5th main ',NULL,'Bangalore','Bangalore','Karnataka','India','560080'),(87,17,'profile','#93 201 5th main Shivaganga Sathyarama','AGS LAYOUT Arehalli near sarvagna circle',NULL,'Bangalore','Bnagalore','Karnataka','India','560061'),(88,17,'profile','93, SHIVAGANGA SATHYARAMA, AGS','LAYOUT SARVAGNA CIRCLE AREHALLI, SUBRAMANYAPURA,',NULL,'BANGALORE URBAN','Bangalore','Karnataka','India','560061'),(89,13,'profile','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(90,27,'family','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(91,40,'family','#93 201 5th main','Shivaganga Sathyrama AGS Layout',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(92,10,'profile','nariman point','Nayandhalli, 5th main road',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(93,41,'family','nariman point','Nayandhalli, 5th main road',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(94,28,'family','nariman point','Nayandhalli, 5th main road',NULL,'Bangalore','Bangalore','Karnataka','India','560061'),(95,42,'family','Sai Lakshmi,2nd Cross','Thyagraja Colony',NULL,'Mulbagal','Kolar','Karnataka','India','563131'),(96,42,'family','Sundeep Jewellers,Bazar Street','',NULL,'Mulbagal','Kolar','Karnataka','India','563131'),(97,23,'profile','','',NULL,'','','','',''),(98,23,'profile','AIRTEL','GURGEON NEW DELHI',NULL,'Gurgeion','Delhi','Harayana','India','610005'),(99,49,'family','#491,20 th cross.13th Main Road','BSK 2ND Stage,Near Post Office',NULL,'Bengaluru','','Karnataka','India','560050'),(100,25,'profile','Ireland','',NULL,'','','','',''),(101,25,'profile','','',NULL,'','','','',''),(102,51,'family','','',NULL,'','','','',''),(103,51,'family','Vinayak Bazar,Near Sri Siddivinayaka Temple','',NULL,'Hospete','Hospete','Karnataka','India','583201'),(104,57,'family','','',NULL,'','','','',''),(105,57,'family','Aisri Feeds','Nethaji Road',NULL,'Channarayapatna','Hassan','Karnataka','India',''),(106,59,'family','No 44,Patel Layout','3rd Main,Begur Main Road,Begur',NULL,'Bengaluru','Bangalore','Karnataka','India','560068');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attachable_type` varchar(50) NOT NULL,
  `attachable_id` bigint NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `file_url` text NOT NULL,
  `file_size` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_attachable` (`attachable_type`,`attachable_id`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` VALUES (175,'profile',3,NULL,'m12.jpg','image','/uploads/1779873075613-850822016.jpg',17785,'2026-05-27 09:11:15','2026-05-27 09:11:15'),(179,'profile',2,NULL,'m6.jpg','image','/uploads/1779873231152-392511712.jpg',261577,'2026-05-27 09:13:52','2026-05-27 09:13:52'),(181,'profile',1,NULL,'m7.jpg','image','/uploads/1779873262909-960348610.jpg',39433,'2026-05-27 09:14:23','2026-05-27 09:14:23'),(226,'profile',19,NULL,'m6.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781525714011-1cae8f86-m6.jpg',261577,'2026-06-15 12:15:14','2026-06-15 12:15:14'),(227,'profile',20,NULL,'m11.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781525767957-e63b9432-m11.jpg',73387,'2026-06-15 12:16:08','2026-06-15 12:16:08'),(228,'profile',18,NULL,'fm11.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781525799344-70f55d87-fm11.jpg',631875,'2026-06-15 12:16:39','2026-06-15 12:16:39'),(229,'profile',17,NULL,'m9.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781684611398-0bd77693-m9.jpg',85468,'2026-06-17 08:23:31','2026-06-17 08:23:31'),(230,'profile',16,NULL,'m8.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781684639726-9300ed24-m8.jpg',23568,'2026-06-17 08:23:59','2026-06-17 08:23:59'),(231,'profile',15,NULL,'fm3.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781684665704-94b75d20-fm3.jpg',60129,'2026-06-17 08:24:25','2026-06-17 08:24:25'),(232,'profile',14,NULL,'fm2.webp','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781684685310-e1026b9e-fm2.webp',62192,'2026-06-17 08:24:45','2026-06-17 08:24:45'),(235,'profile',13,NULL,'m17.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685088792-f17d6fb5-m17.jpg',83054,'2026-06-17 08:31:28','2026-06-17 08:31:28'),(236,'profile',12,NULL,'m16.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685338355-61f829d8-m16.jpg',103761,'2026-06-17 08:35:38','2026-06-17 08:35:38'),(237,'profile',11,NULL,'m5.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685386601-69413cf3-m5.jpg',93204,'2026-06-17 08:36:26','2026-06-17 08:36:26'),(238,'profile',10,NULL,'m2.webp','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685417908-fa5f935e-m2.webp',122568,'2026-06-17 08:36:58','2026-06-17 08:36:58'),(239,'profile',9,NULL,'fm4.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685713004-fe6fbef3-fm4.jpg',106922,'2026-06-17 08:41:53','2026-06-17 08:41:53'),(240,'profile',6,NULL,'fm9.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685759679-b1f2c14e-fm9.jpg',1291753,'2026-06-17 08:42:39','2026-06-17 08:42:39'),(241,'profile',4,NULL,'fm10.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685791300-3066b9df-fm10.jpg',2239137,'2026-06-17 08:43:11','2026-06-17 08:43:11'),(242,'profile',8,NULL,'m1.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685839140-07f6e60c-m1.jpg',66223,'2026-06-17 08:43:59','2026-06-17 08:43:59'),(243,'profile',7,NULL,'m12.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1781685878057-d6e600a5-m12.jpg',17785,'2026-06-17 08:44:38','2026-06-17 08:44:38'),(245,'profile',21,NULL,'19721.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783343040799-9bd27034-19721.jpg',187279,'2026-07-06 13:04:01','2026-07-06 13:04:01'),(246,'profile',21,'horoscope','19721_Sanjitha_Mulabagal.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783343063273-fe4a8e1f-19721_Sanjitha_Mulabagal.jpg',667023,'2026-07-06 13:04:23','2026-07-06 13:04:23'),(247,'profile',21,'traditional_wear','19721d.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783343097221-7f3a62b9-19721d.jpg',581911,'2026-07-06 13:04:57','2026-07-06 13:04:57'),(248,'profile',21,'casual_wear','19721b.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783343109918-deac8e8f-19721b.jpg',347344,'2026-07-06 13:05:10','2026-07-06 13:05:10'),(249,'profile',22,'horoscope','21243_Pratham-Santhosh_Bang.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783602209642-2686e865-21243_Pratham-Santhosh_Bang.jpg',264662,'2026-07-09 13:03:29','2026-07-09 13:03:29'),(250,'profile',22,'traditional_wear','21243a.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783602229757-15897d01-21243a.jpg',97811,'2026-07-09 13:03:49','2026-07-09 13:03:49'),(251,'profile',22,NULL,'21243.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783602235511-ec2425c7-21243.jpg',288894,'2026-07-09 13:03:55','2026-07-09 13:03:55'),(252,'profile',22,NULL,'21243b.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783602255159-2503ee1e-21243b.jpg',107270,'2026-07-09 13:04:15','2026-07-09 13:04:15'),(253,'profile',22,NULL,'21243c.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783602269047-6ccd8af9-21243c.jpg',109062,'2026-07-09 13:04:29','2026-07-09 13:04:29'),(255,'profile',23,NULL,'21313a.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783669482561-c0ec0cd0-21313a.jpg',1362300,'2026-07-10 07:44:42','2026-07-10 07:44:42'),(256,'profile',23,NULL,'21313.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783669482562-ced9cea1-21313.jpg',1536047,'2026-07-10 07:44:42','2026-07-10 07:44:42'),(257,'profile',23,'horoscope','21313_Niranjan_Bangalore.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1783669510405-08b9d34f-21313_Niranjan_Bangalore.jpg',695064,'2026-07-10 07:45:10','2026-07-10 07:45:10'),(258,'profile',5,NULL,'m17.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784283013048-9f219407-m17.jpg',83054,'2026-07-17 10:10:13','2026-07-17 10:10:13'),(260,'profile',24,NULL,'21008.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784627967443-1b38612b-21008.jpg',334532,'2026-07-21 09:59:27','2026-07-21 09:59:27'),(261,'profile',24,'horoscope','21008_Shreyas_Bangalore.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784627982279-66f5107d-21008_Shreyas_Bangalore.jpg',185808,'2026-07-21 09:59:42','2026-07-21 09:59:42'),(262,'profile',24,NULL,'21008c.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784628007493-6e5d59f1-21008c.jpg',259084,'2026-07-21 10:00:07','2026-07-21 10:00:07'),(263,'profile',24,NULL,'21008d.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784628020332-32085bc3-21008d.jpg',388112,'2026-07-21 10:00:20','2026-07-21 10:00:20'),(264,'profile',25,NULL,'21090.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784630729788-c4268901-21090.jpg',203779,'2026-07-21 10:45:30','2026-07-21 10:45:30'),(265,'profile',25,NULL,'21090a.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784630741487-739238db-21090a.jpg',285582,'2026-07-21 10:45:41','2026-07-21 10:45:41'),(266,'profile',25,NULL,'21090c.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784630766149-f38f5b7b-21090c.jpg',244644,'2026-07-21 10:46:06','2026-07-21 10:46:06'),(267,'profile',25,'horoscope','21090_SathvikBhupal_Hospete.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784630781612-d61592ab-21090_SathvikBhupal_Hospete.jpg',255016,'2026-07-21 10:46:21','2026-07-21 10:46:21'),(268,'profile',26,NULL,'21007.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784632306714-78248824-21007.jpg',263164,'2026-07-21 11:11:46','2026-07-21 11:11:46'),(269,'profile',26,NULL,'21007a.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784632313403-3d50d251-21007a.jpg',174634,'2026-07-21 11:11:53','2026-07-21 11:11:53'),(270,'profile',26,'family','21007b.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784632320835-575e9191-21007b.jpg',425125,'2026-07-21 11:12:00','2026-07-21 11:12:00'),(271,'profile',26,NULL,'21007d.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784632333066-15583dec-21007d.jpg',133267,'2026-07-21 11:12:13','2026-07-21 11:12:13'),(272,'profile',26,'horoscope','21007_Shilpa_Bangalore.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784632359861-5219ba9b-21007_Shilpa_Bangalore.jpg',335725,'2026-07-21 11:12:40','2026-07-21 11:12:40'),(273,'profile',27,NULL,'20358e.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784730052132-033b28e3-20358e.jpg',188876,'2026-07-22 14:20:52','2026-07-22 14:20:52'),(274,'profile',27,NULL,'20358.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784730064966-ee5f3570-20358.jpg',107052,'2026-07-22 14:21:05','2026-07-22 14:21:05'),(275,'profile',27,'traditional_wear','20358aa.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784730075103-92466746-20358aa.jpg',238605,'2026-07-22 14:21:15','2026-07-22 14:21:15'),(276,'profile',27,'traditional_wear','20358c.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784730085787-19506d33-20358c.jpg',267911,'2026-07-22 14:21:25','2026-07-22 14:21:25'),(277,'profile',27,NULL,'20358f.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784730100627-96132ab5-20358f.jpg',131122,'2026-07-22 14:21:40','2026-07-22 14:21:40'),(278,'profile',27,'horoscope','20358-Dr.Prathiksha_Davangere.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1784730127770-eb6f7414-20358-Dr.Prathiksha_Davangere.jpg',182814,'2026-07-22 14:22:07','2026-07-22 14:22:07'),(279,'profile',28,NULL,'21019.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785762570252-0019cc70-21019.jpg',276499,'2026-08-03 13:09:30','2026-08-03 13:09:30'),(280,'profile',28,NULL,'21019a.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785762582760-5a53953d-21019a.jpg',268483,'2026-08-03 13:09:42','2026-08-03 13:09:42'),(281,'profile',28,'traditional_wear','21019b.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785762598102-169065ef-21019b.jpg',205620,'2026-08-03 13:09:58','2026-08-03 13:09:58'),(282,'profile',28,'horoscope','21019_Aisiri_Channarayapatna.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785762627656-a01347f4-21019_Aisiri_Channarayapatna.jpg',276756,'2026-08-03 13:10:27','2026-08-03 13:10:27'),(283,'profile',29,'horoscope','21020_Shivani_Blore.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785764943219-b0bb7531-21020_Shivani_Blore.jpg',198148,'2026-08-03 13:49:03','2026-08-03 13:49:03'),(284,'profile',29,NULL,'21020.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785764960575-c52b0631-21020.jpg',260557,'2026-08-03 13:49:20','2026-08-03 13:49:20'),(285,'profile',29,'traditional_wear','21020a.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785764968207-6ff36a56-21020a.jpg',184390,'2026-08-03 13:49:28','2026-08-03 13:49:28'),(286,'profile',29,'family','21020c.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785764981627-47cd1fe4-21020c.jpg',153737,'2026-08-03 13:49:41','2026-08-03 13:49:41'),(287,'profile',29,NULL,'21020b.jpg','image','https://panigrahan-tf-and-logs-backup.s3.amazonaws.com/uploads/1785764993945-0db0f275-21020b.jpg',431076,'2026-08-03 13:49:54','2026-08-03 13:49:54');
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_definitions`
--

DROP TABLE IF EXISTS `attribute_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_definitions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `data_type` enum('string','number','boolean','date') NOT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `is_filterable` tinyint(1) DEFAULT '0',
  `is_required` tinyint(1) DEFAULT '0',
  `applicable_to` enum('product','customer','both') NOT NULL,
  `validation_rules` json DEFAULT NULL,
  `ui_metadata` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_definitions`
--

LOCK TABLES `attribute_definitions` WRITE;
/*!40000 ALTER TABLE `attribute_definitions` DISABLE KEYS */;
INSERT INTO `attribute_definitions` VALUES (1,'color','Color','string',NULL,1,0,'both',NULL,'{\"control\": \"dropdown\"}','2026-01-06 09:40:22'),(2,'weight','Weight','number','kg',1,0,'product','{\"min\": 0}','{\"control\": \"number\"}','2026-01-06 09:40:22'),(3,'voltage','Voltage','number','V',1,0,'product','{\"max\": 240, \"min\": 110}','{\"control\": \"number\"}','2026-01-06 09:40:22'),(4,'warranty_years','Warranty (Years)','number','years',0,0,'product','{\"min\": 0}','{\"control\": \"number\"}','2026-01-06 09:40:22'),(5,'preferred_brand','Preferred Brand','string',NULL,0,0,'customer',NULL,'{\"control\": \"text\"}','2026-01-06 09:40:22');
/*!40000 ALTER TABLE `attribute_definitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Machinery'),(2,'Electrical Equipment');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_attribute_definitions`
--

DROP TABLE IF EXISTS `category_attribute_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_attribute_definitions` (
  `category_id` bigint NOT NULL,
  `attribute_definition_id` bigint NOT NULL,
  PRIMARY KEY (`category_id`,`attribute_definition_id`),
  KEY `attribute_definition_id` (`attribute_definition_id`),
  CONSTRAINT `category_attribute_definitions_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `category_attribute_definitions_ibfk_2` FOREIGN KEY (`attribute_definition_id`) REFERENCES `attribute_definitions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_attribute_definitions`
--

LOCK TABLES `category_attribute_definitions` WRITE;
/*!40000 ALTER TABLE `category_attribute_definitions` DISABLE KEYS */;
INSERT INTO `category_attribute_definitions` VALUES (1,1),(2,1),(1,2),(2,3),(1,4),(2,4);
/*!40000 ALTER TABLE `category_attribute_definitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_preferences`
--

DROP TABLE IF EXISTS `customer_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_preferences` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `attribute_definition_id` bigint NOT NULL,
  `preferred_value_string` varchar(255) DEFAULT NULL,
  `preferred_min_number` decimal(14,4) DEFAULT NULL,
  `preferred_max_number` decimal(14,4) DEFAULT NULL,
  `preferred_value_boolean` tinyint(1) DEFAULT NULL,
  `preferred_date_from` date DEFAULT NULL,
  `preferred_date_to` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `idx_pref_string` (`attribute_definition_id`,`preferred_value_string`),
  KEY `idx_pref_number` (`attribute_definition_id`,`preferred_min_number`,`preferred_max_number`),
  CONSTRAINT `customer_preferences_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `customer_preferences_ibfk_2` FOREIGN KEY (`attribute_definition_id`) REFERENCES `attribute_definitions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_preferences`
--

LOCK TABLES `customer_preferences` WRITE;
/*!40000 ALTER TABLE `customer_preferences` DISABLE KEYS */;
INSERT INTO `customer_preferences` VALUES (1,1,1,'Red',NULL,NULL,NULL,NULL,NULL,'2026-01-06 09:40:31'),(2,1,3,NULL,200.0000,240.0000,NULL,NULL,NULL,'2026-01-06 09:40:31'),(3,2,2,NULL,0.0000,100.0000,NULL,NULL,NULL,'2026-01-06 09:40:31');
/*!40000 ALTER TABLE `customer_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Acme Corporation','contact@acme.com','+1-555-1111','2026-01-06 09:40:01','2026-01-06 09:40:01'),(2,'Globex Pvt Ltd','info@globex.com','+91-9876543210','2026-01-06 09:40:01','2026-01-06 09:40:01');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `education`
--

DROP TABLE IF EXISTS `education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `education` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` int unsigned NOT NULL,
  `degree` varchar(100) DEFAULT NULL,
  `college` varchar(100) DEFAULT NULL,
  `fieldstudy` varchar(100) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `sort_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_edu_profile` (`profile_id`),
  KEY `idx_edu_degree` (`degree`),
  KEY `idx_edu_college` (`college`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education`
--

LOCK TABLES `education` WRITE;
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` VALUES (3,16,'B.com','Jain','Commerce',2023,0,'2026-05-06 10:00:17'),(5,15,'BBA','PES','Commerce',2023,0,'2026-05-06 13:06:41'),(7,15,'MBA','BMS','Commerce',2023,0,'2026-05-06 13:58:37'),(9,10,'MBBS','BMC','Medical',2020,0,'2026-05-07 06:36:26'),(10,10,'MD (orthopedic Surgeon)','BMC','medical',2022,0,'2026-05-07 06:37:41'),(11,16,'M. Com','Jain VV Puram','Commerce',2022,0,'2026-05-07 08:51:39'),(12,14,'BBA','Jain','Commerce',2022,0,'2026-05-08 07:01:52'),(13,12,'2nd PUC','lakshmi bai PU college','Science',2020,0,'2026-05-09 14:43:07'),(14,17,'BCA','AMC College','Computer Science',2023,0,'2026-05-27 18:49:25'),(15,18,'BA LLB LLM','M S RAMAIAH COLLEGE','LAW',2026,0,'2026-05-28 06:29:17'),(16,17,'mca','rv','computer science',2025,0,'2026-05-28 10:50:54'),(17,19,'b.com','jain college','commerce',2018,0,'2026-05-28 12:02:05'),(18,19,'mba','jain college','generl management',2023,0,'2026-05-28 12:02:42'),(19,19,'digital marketing','digital360','marketing',2019,0,'2026-05-28 12:03:21'),(20,20,'PUC','Geethanjali Olympiad','PCMB',2020,0,'2026-06-13 10:37:30'),(21,20,'MBBS','Bangalore Medical College','Medicine',2025,0,'2026-06-13 10:38:15'),(22,21,'Bcom','Pes','',NULL,0,'2026-07-06 13:05:48'),(23,21,'MBA','BMS','Marketing & Finance',NULL,0,'2026-07-06 13:06:41'),(24,22,'BArch','Bgs School of Architecture','',NULL,0,'2026-07-09 13:05:36'),(25,23,'BTECH','BMS COLLEGE','E&C',2018,0,'2026-07-10 07:29:52'),(26,24,'Be','BMS','',NULL,0,'2026-07-21 10:00:41'),(27,24,'MS','Northern University, Usa','',NULL,0,'2026-07-21 10:01:23'),(28,25,'BBA','Hospete','',NULL,0,'2026-07-21 10:46:42'),(29,25,'Msc','LETTER KENNY INSTITUTE OF TECHNOLOGY, IRELAND','',NULL,0,'2026-07-21 10:47:04'),(30,26,'Be','SJBIT','EEE',NULL,0,'2026-07-21 11:13:07'),(31,27,'MBBS','','',NULL,0,'2026-07-22 14:20:32'),(32,28,'B.A.S.L.P','','Speach And Hearing',NULL,0,'2026-08-03 13:11:04'),(33,29,'Mcom','Mount Carmel College,Bangalore','',NULL,0,'2026-08-03 13:50:37');
/*!40000 ALTER TABLE `education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enumtypes`
--

DROP TABLE IF EXISTS `enumtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enumtypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `enumtype` varchar(30) NOT NULL,
  `enumvalue` tinyint NOT NULL,
  `strvalue` varchar(30) NOT NULL,
  `defaultselect` tinyint(1) NOT NULL DEFAULT '0',
  `systemtype` tinyint(1) NOT NULL DEFAULT '1',
  `typeorder` tinyint DEFAULT NULL,
  `orgid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_enm_orgid` (`orgid`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enumtypes`
--

LOCK TABLES `enumtypes` WRITE;
/*!40000 ALTER TABLE `enumtypes` DISABLE KEYS */;
INSERT INTO `enumtypes` VALUES (1,'birthstar',1,'Ashwini',0,1,1,1),(2,'birthstar',2,'Bharani',0,1,2,1),(3,'birthstar',3,'Krittika',0,1,3,1),(4,'birthpada',1,'1st Pada',0,1,1,1),(5,'birthpada',2,'2nd Pada',0,1,2,1),(6,'birthpada',3,'3rd Pada',0,1,3,1),(7,'birthrasi',1,'Mesha (Aries)',0,1,1,1),(8,'birthrasi',2,'Vrishabha (Taurus)',0,1,2,1),(9,'birthstar',4,'Rohini',0,1,4,1),(10,'birthrasi',3,'Mithuna (Gemini)',0,1,3,1),(11,'birthpada',4,'4th Pada',0,1,4,1),(12,'gender',1,'Male',0,1,1,1),(13,'gender',2,'Female',0,1,2,1),(14,'maritalsts',1,'married',0,1,1,1),(15,'maritalsts',2,'unmarried',0,1,2,1),(16,'maritalsts',3,'divorced',0,1,3,1),(17,'maritalsts',4,'widow',0,1,4,1),(31,'relationtype',1,'Father',0,1,1,1),(32,'relationtype',2,'Mother',0,1,2,1),(33,'relationtype',3,'Brother',0,1,3,1),(34,'relationtype',4,'Sister',0,1,4,1),(35,'relationtype',5,'Paternal Grand Father',0,1,5,1),(36,'relationtype',6,'Paternal Grand Mother',0,1,6,1),(37,'relationtype',7,'Maternal Grand Father',0,1,7,1),(38,'relationtype',8,'Maternal Grand Mother',0,1,7,1),(39,'relationtype',9,'Paternal Uncle',0,1,9,1),(40,'relationtype',10,'Maternal Uncle',0,1,10,1),(41,'livingstatus',1,'Alive',0,1,1,1),(42,'livingstatus',2,'Deceased',0,1,2,1),(43,'occupationtype',1,'Working',0,1,1,1),(44,'occupationtype',2,'Business',0,1,2,1),(45,'occupationtype',3,'Professional',0,1,3,1),(47,'color',1,'white',0,1,1,1),(48,'color',2,'Darker Complexion',0,1,2,1),(49,'color',3,'fair',0,1,3,1),(50,'color',4,'medium complexion',0,1,4,1),(70,'hastwin',1,'yes',0,1,1,1),(71,'hastwin',2,'no',0,1,2,1),(72,'matchstatus',1,'suggested',0,1,1,1),(73,'rejectionreason',2,'suggested',0,1,2,1),(74,'interactiontype',1,'Phone',0,1,1,1),(75,'interactiontype',2,'Follow-up',0,1,2,1),(76,'interactiontype',3,'Shared profile',0,1,3,1),(77,'answertype',1,'Text',0,1,1,1),(78,'answertype',2,'Single Select',0,1,2,1),(79,'answertype',3,'Multi Select',0,1,3,1),(80,'answertype',4,'radio',0,1,4,1),(81,'interactiontype',4,'office visit',0,1,4,1),(82,'rejectionreason',3,' Non-matching horoscopes',0,1,3,1),(83,'forgender',1,'male',0,1,1,1),(84,'forgender',2,'female',0,1,2,1),(85,'forgender',3,'both',0,1,3,1),(86,'occtype',1,'Business',0,1,1,1),(87,'occtype',2,'Professional',0,1,2,1),(88,'occtype',3,'Salaried',0,1,3,1),(89,'profilests',1,'active',0,1,1,1),(90,'profilests',2,'inactive',0,1,2,1),(91,'occtype',4,'Student',0,1,4,1),(92,'occtype',5,'Homemaker',0,1,5,1),(93,'occtype',6,'Freelancer / Consultant',0,1,6,1),(94,'occtype',7,'Artist / Creative',0,1,7,1),(95,'occtype',8,'Entrepreneur / Startup',0,1,8,1),(96,'occtype',9,'Government Employee',0,1,9,1),(97,'occtype',10,'Retired',0,1,10,1),(98,'occtype',11,'Not Working Currently',0,1,11,1),(99,'occtype',12,'Family Business',0,1,12,1),(100,'birthstar',5,'Mrigashira',0,1,5,1),(101,'birthstar',6,'Ardra',0,1,6,1),(102,'birthstar',7,'Punarvasu',0,1,7,1),(103,'birthstar',8,'Pushya',0,1,8,1),(104,'birthstar',9,'Ashlesha',0,1,9,1),(105,'birthstar',10,'Magha',0,1,10,1),(106,'birthstar',11,'Purva Phalguni',0,1,11,1),(107,'birthstar',12,'Uttara Phalguni',0,1,12,1),(108,'birthstar',13,'Hasta',0,1,13,1),(109,'birthstar',14,'Chitra',0,1,14,1),(110,'birthstar',15,'Swati',0,1,15,1),(111,'birthstar',16,'Vishakha',0,1,16,1),(112,'birthstar',17,'Anuradha',0,1,17,1),(113,'birthstar',18,'Jyeshtha',0,1,18,1),(114,'birthstar',19,'Mula',0,1,19,1),(115,'birthstar',20,'Purva Ashadha',0,1,20,1),(116,'birthstar',21,'Uttara Ashadha',0,1,21,1),(117,'birthstar',22,'Shravana',0,1,22,1),(118,'birthstar',23,'Dhanishta',0,1,23,1),(119,'birthstar',24,'Shatabhisha',0,1,24,1),(120,'birthstar',25,'Purva Bhadrapada',0,1,25,1),(121,'birthstar',26,'Uttara Bhadrapada',0,1,26,1),(122,'birthstar',27,'Revati',0,1,27,1),(123,'birthrasi',4,'Karka (Cancer)',0,1,4,1),(124,'birthrasi',5,'Simha (Leo)',0,1,5,1),(125,'birthrasi',6,'Kanya (Virgo)',0,1,6,1),(126,'birthrasi',7,'Tula (Libra)',0,1,7,1),(127,'birthrasi',8,'Vrischika (Scorpio)',0,1,8,1),(128,'birthrasi',9,'Dhanus (Sagittarius)',0,1,9,1),(129,'birthrasi',10,'Makara (Capricorn)',0,1,10,1),(130,'birthrasi',11,'Kumbha (Aquarius)',0,1,11,1),(131,'birthrasi',12,'Meena (Pisces)',0,1,12,1),(148,'rejectionreason',4,'Not Matching Fin Expect',0,1,4,1),(149,'rejectionreason',5,'Frequently transferable job',0,1,5,1),(150,'rejectionreason',6,'Low gunas (below 18/36)',0,1,6,1),(151,'rejectionreason',7,'Doshas - Kuja, Kala-Sarpa etc',0,1,7,1),(152,'rejectionreason',8,'Height - Tall',0,1,8,1),(153,'rejectionreason',9,'Height - Short',0,1,9,1),(154,'rejectionreason',10,'Settled Abroad',0,1,10,1),(155,'rejectionreason',11,'Unwilling to move Abroad',0,1,11,1);
/*!40000 ALTER TABLE `enumtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familydetails`
--

DROP TABLE IF EXISTS `familydetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `familydetails` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `familyname` varchar(30) DEFAULT NULL,
  `surname` varchar(30) DEFAULT NULL,
  `relationtype` tinyint unsigned DEFAULT NULL,
  `addressid` int unsigned DEFAULT NULL,
  `occtype` tinyint unsigned DEFAULT NULL,
  `occname` varchar(100) DEFAULT NULL,
  `maritalsts` tinyint unsigned DEFAULT NULL,
  `livingstatus` tinyint unsigned DEFAULT NULL,
  `gender` tinyint unsigned DEFAULT NULL,
  `profileid` int DEFAULT NULL,
  `cellphone` varchar(15) DEFAULT NULL,
  `homephone` varchar(15) DEFAULT NULL,
  `otherphone` varchar(15) DEFAULT NULL,
  `emailaddress` varchar(100) DEFAULT NULL,
  `placeoforigin` varchar(50) DEFAULT NULL,
  `current_address_id` int DEFAULT NULL,
  `permanent_address_id` int DEFAULT NULL,
  `work_address_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fp_profileid` (`profileid`),
  KEY `idx_fp_reltype` (`relationtype`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familydetails`
--

LOCK TABLES `familydetails` WRITE;
/*!40000 ALTER TABLE `familydetails` DISABLE KEYS */;
INSERT INTO `familydetails` VALUES (1,'makam','ramakrishna',NULL,'subramanyam',1,NULL,NULL,NULL,1,1,NULL,4,'9448134526','7412589630','2587413690','parvathi@gmail.com','hospete',NULL,NULL,NULL),(4,'parvathi','parameshwara',NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Ramakrishna','Makam',NULL,'subramanyam',1,NULL,NULL,NULL,2,1,1,2,'9448134526','1234567890','1234567890','parvathi@gmail.com','davangere',65,65,NULL),(9,'Ramakrishna','nayak',NULL,'',8,NULL,NULL,NULL,4,1,2,4,'9448134526','1234567890','1234567890','parvathi@gmail.com','hospete',NULL,NULL,NULL),(10,'lalitha','D',NULL,'somi',4,NULL,NULL,NULL,2,1,2,4,'9448134526','1234567890','1234567890','lalithad@gmail.com','rajasthan',NULL,NULL,NULL),(11,'bindhu','kumar',NULL,'gowda',4,NULL,NULL,NULL,2,1,2,6,'9448134526','7412589630','1234567890','pavithra@gmail.com','davangere',NULL,NULL,NULL),(13,'geetha','kumar',NULL,'subramanyam',2,NULL,2,NULL,1,1,2,7,'9448134526','1234567890','1234567890','lalithad@gmail.com','hospete',NULL,NULL,NULL),(14,'venkatesh','M',NULL,'S',3,NULL,NULL,NULL,1,1,1,5,'7894561230','7412589630','1234567890','venkatesh@gmail.com','Andhra Pradesh',NULL,NULL,NULL),(15,'Ramaiyah','prasad',NULL,'Shetty',1,NULL,NULL,NULL,1,1,1,3,'6360025298','1122334455','9633699630','ram@gmail.com','peelaer',NULL,NULL,NULL),(16,'parvathamma','jonnagadla',NULL,'somi',2,NULL,NULL,NULL,1,1,2,1,'6360025298','1234567890','9633699630','pavithra@gmail.com','peelaer',49,49,NULL),(17,'Pullaiyah','M S',NULL,'Guptha',1,NULL,NULL,NULL,1,1,1,8,'9448134526','1234567890','1234567890','pulaiyah@guptha.com','peelaer',NULL,NULL,NULL),(18,'ramalinga ','reddy',NULL,'reddy',1,NULL,NULL,NULL,1,1,1,8,'9448134526','1234567890','1234567890','lingaiyah123@gmail.com','rajasthan',NULL,NULL,NULL),(19,'Suresh','Some last name',NULL,'',1,NULL,2,NULL,1,1,1,9,'1234567890','','','karthik@rameshj.com','hospete',NULL,NULL,NULL),(20,'Karthik','Makam',NULL,'Guptha',1,NULL,1,NULL,1,1,1,5,'9448134526','1234567890','1234567890','karthik@rameshj.com','bangalore',45,45,NULL),(21,'Lakshmi','Makam',NULL,'',2,NULL,1,NULL,1,1,2,5,'7894561230','1234567890','1234567890','karthik@rameshj.com','bangalore',46,46,NULL),(23,'rakesh','sharma',NULL,'',1,NULL,1,NULL,1,1,1,12,'','','','','kolar',39,39,NULL),(24,'radha','lakshmi',NULL,'',2,NULL,1,NULL,1,1,2,12,'','','','','',40,40,NULL),(25,'parthasarathi','chandhra',NULL,'guptha',1,NULL,1,NULL,1,1,1,14,'7894561230','7412589630','2587413690','parthasarathi2026@gmail.com','madanapalli',70,70,NULL),(26,'Karthik','Makam',NULL,'Makam',1,NULL,1,NULL,1,1,1,15,'1234567890','7412589630','9633699630','karthik@rameshj.com.test','hospete',63,63,NULL),(27,'damodar','naroji',NULL,'singh',1,NULL,3,'Marketing Manager',1,1,1,13,'9448134526','7412589630','1234567890','damodarsingh29@gmail.com','Hydrabad',90,90,NULL),(28,'Nagamani','',NULL,'',2,NULL,5,NULL,1,1,2,10,'855633210','','','','Ananthapur',94,94,NULL),(30,'MAHESH','B K',NULL,'KOTA',1,NULL,2,NULL,1,1,1,18,'9972309784','','','','BANGALORE',NULL,NULL,NULL),(32,'venkatesh','babu',NULL,'chennur',1,NULL,1,NULL,1,1,1,19,'9844085118','9844085118','','','bangalore',77,77,75),(33,'vani','venkatesh',NULL,'',2,NULL,NULL,NULL,1,1,2,19,'9844645118','','','','mysore',78,78,NULL),(34,'Rajesh','M',NULL,'Muntimadugu',1,NULL,3,'Senior Software Engineer',1,1,1,20,'4578693210','','','rajesh21@gmail.com','Anantapram',NULL,NULL,NULL),(35,'Sowjanya','K',NULL,'Kayasri',2,NULL,3,'Senior Regional Manger',1,1,2,20,'457812036','','','sowjanyakayasri23@gmail.com','Vizag',NULL,NULL,NULL),(36,'suresh','kumar',NULL,'Guptha',1,NULL,1,'Komali Textiles',1,1,1,11,'4556898712','','','suresh123@gmail.com','Gouribidanur',NULL,NULL,NULL),(37,'Komali','Prasad',NULL,'Guptha',2,NULL,5,'',1,1,2,11,'2587410369','','','komali9119@gmail.com','Hydrabad',NULL,NULL,NULL),(38,'Girish','Kumar',NULL,'Guptha',1,NULL,2,'Police',1,1,1,17,'56987412330','','','girish1998@gmail.com','Hindupur',NULL,NULL,NULL),(39,'Geetha','Kumari',NULL,'Poghat',2,NULL,5,'',1,1,2,17,'7898456510','','','geetha2000@gmail.coim','Hindupur',NULL,NULL,NULL),(40,'shantha','',NULL,'',2,NULL,5,'',1,1,2,13,'9987452101','','','','Chitthoor',91,91,NULL),(41,'Nagabushan','Guptha',NULL,'Muntimadugu',1,NULL,2,'CRPF',1,2,1,10,'9945878560','','','','Channampalli',93,93,NULL),(42,'Sundeep','K N',NULL,'Krishnagiri',1,NULL,12,'Sundeep Jewellers',1,1,1,21,'126536753','','','','Mulbagal',95,95,96),(43,'Lakshmi','',NULL,'',2,NULL,5,'',1,1,2,21,'','','','','Bangalore',NULL,NULL,NULL),(44,'Santosh ','Chitlur',NULL,'Chitlur',1,NULL,1,'Kuber Entreprises',1,1,1,22,'','','','','Bangalore',NULL,NULL,NULL),(45,'Anushree','',NULL,'',2,NULL,5,'',NULL,1,2,22,'','','','','',NULL,NULL,NULL),(46,'K ','VASUDEVA',NULL,'GUPTA',1,NULL,2,'RETD OFFICE FROM PRIVATE SECTOR',1,1,1,23,'9844425919','','','','BANGALORE',NULL,NULL,NULL),(47,'SUMAVASU','',NULL,'',2,NULL,2,'ACCOUNTS EXECUTIVE A1 Steel bangalore',1,1,2,23,'9741128919','','','','BANGALORE',NULL,NULL,NULL),(48,'','',NULL,'',NULL,NULL,NULL,'',NULL,NULL,NULL,23,'','','','','',NULL,NULL,NULL),(49,'Ramesh','',NULL,'Chittlur',1,NULL,NULL,'',1,1,1,24,'','','','','',99,99,NULL),(50,'Asharani','',NULL,'',2,NULL,6,'Jewelry Design & selling',1,1,2,24,'','','','','',NULL,NULL,NULL),(51,'BHUPAL SATHISH','',NULL,'BHUPAl',1,NULL,1,'VINAYAKA BAZAAR, KIRANA STORES',1,1,NULL,25,'','','','','',102,102,103),(52,' SUMA','B S',NULL,'',2,NULL,NULL,'',NULL,2,2,25,'','','','','',NULL,NULL,NULL),(53,'Nagendra Kumar','D N',NULL,'Doolipet',1,NULL,10,'OFFICER, CANARA BANK',1,1,NULL,26,'','','','','Bangalore',NULL,NULL,NULL),(54,'Sarvani','',NULL,'',2,NULL,10,'Sbi',1,1,2,26,'','','','','Bangalore',NULL,NULL,NULL),(55,'MANJUNATH','B N',NULL,'',1,NULL,1,'ESHA COMMERCIALS',1,1,1,27,'','','','','DAVANAGERE',NULL,NULL,NULL),(56,'mamtha','b m',NULL,'',2,NULL,NULL,'',2,1,2,27,'','','','','',NULL,NULL,NULL),(57,'HarishBabu','C G',NULL,'Rokkam',1,NULL,1,'Aisiri Feeds',1,1,1,28,'9060196060','','','','Channarayapatna',104,104,105),(58,'Malini','',NULL,'',2,NULL,5,'',1,1,2,28,'','','','','Davangere',NULL,NULL,NULL),(59,'Radhakrishna','V A',NULL,'Vankadari',1,NULL,1,'Gems Stone',1,1,1,29,'9916743336','','','','Bangalore',106,106,NULL),(60,'Jyothi','',NULL,'',2,NULL,5,'',1,1,2,29,'','','','','Tiptur',NULL,NULL,NULL);
/*!40000 ALTER TABLE `familydetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formenumap`
--

DROP TABLE IF EXISTS `formenumap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formenumap` (
  `id` int NOT NULL AUTO_INCREMENT,
  `formname` varchar(30) NOT NULL,
  `enumtype` varchar(30) NOT NULL,
  `fieldname` varchar(30) NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `disporder` tinyint DEFAULT NULL,
  `orgid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_formap_orgid` (`orgid`),
  KEY `idx_formap_formnm` (`formname`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formenumap`
--

LOCK TABLES `formenumap` WRITE;
/*!40000 ALTER TABLE `formenumap` DISABLE KEYS */;
INSERT INTO `formenumap` VALUES (1,'profile','birthstar','birthstar',1,1,1),(2,'profile','birthpada','birthpada',0,2,1),(3,'profile','birthrasi','birthrasi',1,3,1),(4,'profile','gender','gender',1,4,1),(5,'profile','maritalsts','maritalsts',1,5,1),(8,'profile','relationtype','relationtype',0,6,1),(9,'profile','color','color',1,7,1),(11,'profile','hastwin','hastwin',1,9,1),(12,'profile','livingstatus','livingstatus',1,10,1),(13,'profile','matchstatus','matchstatus',0,50,1),(14,'profile','rejectionreason','rejectionreason',0,50,1),(15,'interaction','interactiontype','interactiontype',0,1,1),(16,'profile','occtype','occtype',0,1,1),(17,'occupation','occtype','occtype',0,1,1);
/*!40000 ALTER TABLE `formenumap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gothra`
--

DROP TABLE IF EXISTS `gothra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gothra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gothraname` varchar(50) DEFAULT NULL,
  `gothrarushi` varchar(50) DEFAULT NULL,
  `gothranum` tinyint unsigned DEFAULT NULL,
  `aliases` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gothra`
--

LOCK TABLES `gothra` WRITE;
/*!40000 ALTER TABLE `gothra` DISABLE KEYS */;
INSERT INTO `gothra` VALUES (1,'Arishistakula','Aathreya',1,NULL),(2,'Arana','Aathreya',1,NULL),(3,'Arisetla','Aathreya',1,NULL),(4,'Elishista','Aathreya',1,NULL),(5,'yerashista','Aathreya',1,NULL),(6,'Harishista','Aathreya',1,NULL),(7,'Agramoola','Aswalayana',2,NULL),(8,'Agyamoola','Aswalayana',2,NULL),(9,'Argyamoola','Aswalayana',2,NULL),(10,'Amala','Aswalayana',2,NULL),(11,'Anapakula','Agasthya',3,NULL),(12,'Anupala','Agasthya',3,NULL),(13,'Pherushishta','Bruhadashwah',4,NULL),(14,'Pherishista','Bruhadashwah',4,NULL),(15,'Phirushita','Bruhadashwah',4,NULL),(16,'Buddakula','Bodayanah',5,NULL),(17,'Buddikula','Bodayanah',5,NULL),(18,'Budanakula','Bodayanah',5,NULL),(19,'Balashresta','Baradwaja',6,NULL),(20,'Balishista','Baradwaja',6,NULL),(21,'Balisetla','Baradwaja',6,NULL),(22,'Prudhivisista','Bargava',7,NULL),(23,'Prudhivisresti','Bargava',7,NULL),(24,'Chakramoola','Chakrapani',8,NULL),(25,'Chakramoolasa','Chakrapani',8,NULL),(26,'Palakakula','Daalbyah',10,NULL),(27,'Palakula','Daalbyah',10,NULL),(28,'Patinakula','Daalbyah',10,NULL),(29,'Patinashista','Daalbyah',10,NULL),(30,'Didisa','Durvasah',11,NULL),(31,'Didina','Durvasah',11,NULL),(32,'Dedana','Durvasah',11,NULL),(33,'Denthushula','Durvasah',11,NULL),(34,'Denthanula','Durvasah',11,NULL),(35,'Hiraraasi','Devarathah',12,NULL),(36,'Vusirikula','Devavalkyah (harivraktha)',13,NULL),(37,'Vusiri','Devavalkyah (harivraktha)',13,NULL),(38,'Desishata','Devavalkyah (harivraktha)',13,NULL),(39,'Prahini','Gargyah (Angeerasa)',14,NULL),(40,'Praheenu','Gargyah (Angeerasa)',14,NULL),(41,'Paidi','Gargyah (Angeerasa)',14,NULL),(42,'Inapakula','Gruthsna Madah',15,NULL),(43,'Inupa','Gruthsna Madah',15,NULL),(44,'Ishupa','Gruthsna Madah',15,NULL),(45,'Channa','Gruthsna Madah',15,NULL),(46,'Jana','Gruthsna Madah',15,NULL),(47,'Jaanu','Gruthsna Madah',15,NULL),(48,'Inguva','Gopakah',16,NULL),(49,'Gota','Gopakah',16,NULL),(50,'Montaka','Gopakah',16,NULL),(51,'Inchupahvaya','Gopakah',16,NULL),(52,'gopakula','Gopakah',16,NULL),(53,'Gandhasheela','Gowthama',17,NULL),(54,'Gandhaseela','Gowthama',17,NULL),(55,'Grandhisheela','Gowthama',17,NULL),(56,'Grandishila','Gowthama',17,NULL),(57,'Goranta','Harivalkya',18,NULL),(58,'Korata','Harivalkya',18,NULL),(59,'Kurata','Harivalkya',18,NULL),(60,'Kavata','Harivalkya',18,NULL),(61,'Gundakula','JadaBharatha',19,NULL),(62,'Doorashista','JadaBharatha',19,NULL),(63,'Chandra kula','Jatukarnah',20,NULL),(64,'Chandra Shista','Jatukarnah',20,NULL),(65,'Chandra Mashista','Jatukarnah',20,NULL),(66,'Chandramoola','Jatukarnah',20,NULL),(67,'Thirmoola','Jambasudhana',21,NULL),(68,'Channa','Jarathaarkha',22,NULL),(69,'Jana','Jarathaarkha',22,NULL),(70,'Jyanu','Jarathaarkha',22,NULL),(71,'Surishista','Jaabilih',23,NULL),(72,'Soorashista','Jaabilih',23,NULL),(73,'Karnah','Kanvah',26,NULL),(74,'Karnata','Kanvah',26,NULL),(75,'Kata','Kanvah',26,NULL),(76,'Katu','Kanvah',26,NULL),(77,'Kota','Kanvah',26,NULL),(78,'Koutu','Kanvah',26,NULL),(79,'Charakula','Kandarpa',27,NULL),(80,'Manukula','Kandarpa',27,NULL),(81,'Chegodda','Kandarpa',27,NULL),(82,'Samanakula','Kandarpa',27,NULL),(83,'ChegollashrestaKundala','Kandarpa',27,NULL),(84,'','Kandarpa',27,NULL),(85,'Mandu','Kapila',28,NULL),(86,'Mandha','Kapila',28,NULL),(87,'Hastha','Kapila',28,NULL),(88,'Venkala','Kapeetha',29,NULL),(89,'Venkola','Kapeetha',29,NULL),(90,'Ganamukha','Kasyapa',30,NULL),(91,'Ganamu','Kasyapa',30,NULL),(92,'Ikshwaku','Kuthsah',31,NULL),(93,'Ganalola','Koundinya',32,NULL),(94,'Ganasreela','Koundinya',32,NULL),(95,'Ganaseela','Koundinya',32,NULL),(96,'Karakapaala','Koushika',33,NULL),(97,'Dhanakula','Krishna ( Karshanah)',34,NULL),(98,'Dhandakula','Krishna ( Karshanah)',34,NULL),(99,'Daenakula','Krishna ( Karshanah)',34,NULL),(100,'Vinnakula','Mandapala',35,NULL),(101,'Veenakula','Mandapala',35,NULL),(102,'Vennakula','Mandapala',35,NULL),(103,'Modukula','Markandeya',38,NULL),(104,'Morkala','Markandeya',38,NULL),(105,'Moruka','Markandeya',38,NULL),(106,'Morusa','Markandeya',38,NULL),(107,'Padmashista','Muniraja',39,NULL),(108,'Padmashresta','Muniraja',39,NULL),(109,'Maddikula','Mythreyah',40,NULL),(110,'Madanakula','Mythreyah',40,NULL),(111,'Madhyakula','Mythreyah',40,NULL),(112,'Midunakula','Mythreyah',40,'[\"Mithunakula\", \"Mythreyesa\"]'),(113,'Chanda','Mounala',41,NULL),(114,'Chandaka','Mounala',41,NULL),(115,'Changa','Mounala',41,NULL),(116,'Changala','Mounala',41,NULL),(117,'Mounji','Mounjayanah',42,NULL),(118,'Mounjana','Mounjayanah',42,NULL),(119,'Manjukula','Mounjayanah',42,NULL),(120,'Naabilla','Moudgalya',43,NULL),(121,'Naabeela','Moudgalya',43,NULL),(122,'Munikula','Moudgalya',43,NULL),(123,'Moolakula','Moudgalya',43,NULL),(124,'Naabeelana','Moudgalya',43,NULL),(125,'Sanakula','Nanaka',44,NULL),(126,'Saanakula','Nanaka',44,NULL),(127,'Palakula','Naradah',45,NULL),(128,'Palaka','Naradah',45,NULL),(129,'Chandogu','Netrapadah(Athrith)',46,NULL),(130,'Chhandogu','Netrapadah(Athrith)',46,NULL),(131,'Yanana','Ouchithya (Pishabarba)',47,NULL),(132,'Yanasaksha','Ouchithya (Pishabarba)',47,NULL),(133,'Yanasaha','Ouchithya (Pishabarba)',47,NULL),(134,'Ganapa','Pallavah',49,NULL),(135,'Gantasu','Pallavah',49,NULL),(136,'Ganta','Pallavah',49,NULL),(137,'Gantashula','Pallavah',49,NULL),(138,'Gantashoola','Pallavah',49,NULL),(139,'Dayashista','PavithraPranih',50,NULL),(140,'Dahishista','PavithraPranih',50,NULL),(141,'Daishetla','PavithraPranih',50,NULL),(142,'Daishista','PavithraPranih',50,NULL),(143,'Daeshista','PavithraPranih',50,NULL),(144,'Kamadhenu','Parasharya',51,NULL),(145,'Madagasila','Parasharya',51,NULL),(146,'Prananula','Parasharya',51,NULL),(147,'Panchala','Parasharya',51,NULL),(148,'Pranasheela','Parasharya',51,NULL),(149,'Pragbala','Parasharya',51,NULL),(150,'Proudasheela','Parasharya',51,NULL),(151,'Paapala','Parasharya',51,NULL),(152,'Paambaala','Parasharya',51,NULL),(153,'Paanchala','Parasharya',51,NULL),(154,'Ayana','Pingala',52,NULL),(155,'Anushita','Pundareeka',53,NULL),(156,'Kranu','Pundareeka',53,NULL),(157,'Thonti','Pundareeka',53,NULL),(158,'Thuryata','Poothimava',54,NULL),(159,'Thulashista','Poothimava',54,NULL),(160,'Thulasi','Poothimava',54,NULL),(161,'Thotakula','Poothimava',54,NULL),(162,'Punsimansu','Poundraka',55,NULL),(163,'Proli','Poundraka',55,NULL),(164,'Polekha','Poundraka',55,NULL),(165,'Punisimana','Poundraka',55,NULL),(166,'Prolishista','Poundraka',55,NULL),(167,'Gosheela','Poulasthya',56,NULL),(168,'Uthmagosheela','Poulasthya',56,NULL),(169,'Pallavagosheela','Poulasthya',56,NULL),(170,'Suryakula','Poulasthya',56,NULL),(171,'Patutagosheela','Poulasthya',56,NULL),(172,'Srigosheela','Poulasthya',56,NULL),(173,'Bhimagosheela','Poulasthya',56,NULL),(174,'Punagasila','Poulasthya',56,NULL),(175,'Sathyagosheela','Poulasthya',56,NULL),(176,'Nandigosheels','Poulasthya',56,NULL),(177,'Punargosheelta','Poulasthya',56,NULL),(178,'Sreepunsakula','Poulasthya',56,NULL),(179,'Vanishista','Pracheena',57,NULL),(180,'Venashista','Pracheena',57,NULL),(181,'Velishista','Pracheena',57,NULL),(182,'Pendikula','Prabhatha',58,NULL),(183,'Ravishista','Prabhatha',58,NULL),(184,'Ananthakula','RushyaSrunga',59,NULL),(185,'Kramashista','Sharabangah',60,NULL),(186,'Kramashesta','Sharabangah',60,NULL),(187,'Gundaka','Sharjgaravah',61,NULL),(188,'Ghondaka','Sharjgaravah',61,NULL),(189,'Tuppakula','Sandilya',62,NULL),(190,'Chilakula','Sreevathsah',63,NULL),(191,'Sreelakula','Sreevathsah',63,NULL),(192,'Sreerangakula','Sreevathsah',63,NULL),(193,'Sirishista','Sreedharah',64,NULL),(194,'Sreeshista','Sreedharah',64,NULL),(195,'Sirishesta','Sreedharah',64,NULL),(196,'Sreesaallah','Suklarushi',65,NULL),(197,'Sreeshala','Suklarushi',65,NULL),(198,'Sreesoallah','Suklarushi',65,NULL),(199,'Elamanchi','Sowcheyah',66,NULL),(200,'Yalamanchi','Sowcheyah',66,NULL),(201,'Helamanchi','Sowcheyah',66,NULL),(202,'Kamalakula','Sownaka',67,NULL),(203,'Thirushista','Sownaka',67,NULL),(204,'Dhanadha','Sownaka',67,NULL),(205,'Shankala','Sownaka',67,NULL),(206,'Chintana','Sathyah',68,NULL),(207,'Chintya','Sathyah',68,NULL),(208,'Chintala','Sathyah',68,NULL),(209,'Andarikula','Sathyah',68,NULL),(210,'Chintakula','Sathyah',68,NULL),(211,'Muddu','Sanathkumara',69,NULL),(212,'Tankara','Sanathkumara',69,NULL),(213,'Samahista','Sanadanath',70,NULL),(214,'Rentakula','Samvarthaka',71,NULL),(215,'Rentana','Samvarthaka',71,NULL),(216,'Puchchakula','Sukanchana',72,NULL),(217,'Puneetha','Sukanchana',72,NULL),(218,'Puchchaka','Sukanchana',72,NULL),(219,'Dhentha','Sutheekshah',73,NULL),(220,'Dyantha','Sutheekshah',73,NULL),(221,'Dontha','Sutheekshah',73,NULL),(222,'Danthakula','Sutheekshah',73,NULL),(223,'Devishetla','Sutheekshah',73,NULL),(224,'Inakula','Sundarah',74,NULL),(225,'Inakola','Sundarah',74,NULL),(226,'Vinukula','Sundarah',74,NULL),(227,'Proudayaaja','Suvarna',75,NULL),(228,'Prodayaja','Suvarna',75,NULL),(229,'Prodyaacha','Suvarna',75,NULL),(230,'Chandana','Subramanyah',76,NULL),(231,'Snigdha','Subramanyah',76,NULL),(232,'Budhurukula','Sowbarna',78,NULL),(233,'Budhuruksa','Sowbarna',78,NULL),(234,'Hastikula','Sowmyah',79,NULL),(235,'Sukaalla','Sowvarna',80,NULL),(236,'Sushaala','Sowvarna',80,NULL),(237,'Susolla','Sowvarna',80,NULL),(238,'Susaala','Sowvarna',80,NULL),(239,'Thrivikramashista','Tharanih',81,NULL),(240,'Bamada','Thittirih',82,NULL),(241,'Bramada','Thittirih',82,NULL),(242,'Bramara','Thittirih',82,NULL),(243,'Bravada','Thittirih',82,NULL),(244,'Uparakula','Thrijatah',83,NULL),(245,'Usirikula','Thrijatah',83,NULL),(246,'Chidroopa','Thaithrevah',84,NULL),(247,'Chidrukula','Thaithrevah',84,NULL),(248,'Chidurupella','Thaithrevah',84,NULL),(249,'kanyakula','Uthkrushta',85,NULL),(250,'Kanukula','Uthkrushta',85,NULL),(251,'Kranukula','Uthkrushta',85,NULL),(252,'Uthakala','Uttamouja',86,NULL),(253,'Uthakula','Uttamouja',86,NULL),(254,'Uthashisti','Uttamouja',86,NULL),(255,'Uttama','Uttamouja',86,NULL),(256,'Kumarashista','Ugrasena',87,NULL),(257,'Kanukula','Ugrasena',87,NULL),(258,'Kranukula','Ugrasena',87,NULL),(259,'Anumarshana','Vatuka',88,NULL),(260,'Maanantha','Vaarathanthu',89,NULL),(261,'Maashastakula','Vaarathanthu',89,NULL),(262,'Aelashista','Varuna',90,NULL),(263,'Velashista','Varuna',90,NULL),(264,'Sirishesta','Varuna',90,NULL),(265,'Vasti','Vasista',91,NULL),(266,'Vastina','Vasista',91,NULL),(267,'Vastrakula','Vasista',91,NULL),(268,'Upama','Vamadeva',92,NULL),(269,'Upalaala','Vamadeva',92,NULL),(270,'Upana','Vamadeva',92,NULL),(271,'Upamanyu','Vamadeva',92,NULL),(272,'Beemashila','Vasudeva',93,NULL),(273,'Beemashista','Vasudeva',93,NULL),(274,'Beemashresta','Vasudeva',93,NULL),(275,'Vrangama','Vaayuvya',94,NULL),(276,'Vrakashista','Vaayuvya',94,NULL),(277,'Vrakalamrangama','Vaayuvya',94,NULL),(278,'Vrangamoola','Vaayuvya',94,NULL),(279,'Vrakal','Vaayuvya',94,NULL),(280,'Saanthala','Valmika',95,NULL),(281,'Uparishista','Vishwaksenah',96,NULL),(282,'Vivarishista','Vishwaksenah',96,NULL),(283,'Viparishetla','Vishwaksenah',96,NULL),(284,'Vikramashista','Viswamithra',97,NULL),(285,'Pippala','Vishnuvrudha',98,NULL),(286,'Puppala','Vishnuvrudha',98,NULL),(287,'Pushpala','Vishnuvrudha',98,NULL),(288,'Vasanthakula','Virohithyah',99,NULL),(289,'Dhanagu','Vyana',100,NULL),(290,'Dhanadha','Vyana',100,NULL),(291,'Dhanagunda','Vyana',100,NULL),(292,'Veligella','Yaskah (Jaimini)',101,NULL),(293,'Veligolla','Yaskah (Jaimini)',101,NULL),(294,'Vyalakulasa','Yaskah (Jaimini)',101,NULL),(295,'mandakula','yagnavalkya',102,'[]'),(296,'srilakula','srilakula',NULL,NULL),(297,'yellasetla','yellasetla',NULL,NULL),(298,'Parasarasa','Parasarasa',NULL,NULL),(299,'Bharadwaja','Bharadwaja',NULL,NULL),(300,'Devashatla','Devashatla',NULL,NULL),(301,'MITHUNAKULA','MYTHREYASA',NULL,'[\"MIDUNAKULA\"]'),(302,'mourukula','mourukula',NULL,NULL),(303,'Padagashila','Padagashila',NULL,NULL),(304,'Poutsakula','Poutsakula',NULL,NULL);
/*!40000 ALTER TABLE `gothra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hinduyears`
--

DROP TABLE IF EXISTS `hinduyears`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hinduyears` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sanskritname` varchar(20) NOT NULL,
  `alternatename` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hinduyears`
--

LOCK TABLES `hinduyears` WRITE;
/*!40000 ALTER TABLE `hinduyears` DISABLE KEYS */;
INSERT INTO `hinduyears` VALUES (1,'Prabhava','Prabhava'),(2,'Vibhava','Vibhava'),(3,'Śukla','Śukla'),(4,'Pramodadūta','Pramoda'),(5,'Prajāpati','Prajotpatti'),(6,'Āṅgirasa','Angira'),(7,'Śrīmukha','Shrimukha'),(8,'Bhāva','Bhava'),(9,'Yuva','Yuvan'),(10,'Dhātṛ','Dhata/Dhatu'),(11,'Īśvara','Ishwar'),(12,'Bahudhānya','Bahudhana'),(13,'Pramāthi','Pramathin'),(14,'Vikrama','Vikrama'),(15,'Vṛṣaprajā','Vrisha/Vrusha'),(16,'Citrabhānu','Citrabhānu'),(17,'Svabhānu','Subhanu'),(18,'Tāraṇa','Taran'),(19,'Pārthiva','Parthiva'),(20,'Vyaya','Avyaya'),(21,'Sarvajit','Sarvajit'),(22,'Sarvadhārī','Sarvadhari'),(23,'Virodhī','Virodhi'),(24,'Vikṛti','Vikriti'),(25,'Khara','Khara'),(26,'Nandana','Nandana'),(27,'Vijaya','Vijaya'),(28,'Jaya','Jaya'),(29,'Manmatha','Marmath'),(30,'Durmukha','Durmukhi'),(31,'Hevilambi','Hemalambin'),(32,'Vilambi','Vilambin'),(33,'Vikāri','Vikari'),(34,'Śārvarī','Sharvari/Sharvar'),(35,'Plava','Plava'),(36,'Śubhakṛt','Shubakrit'),(37,'Śobhakṛt','Shobhana'),(38,'Krodhī','Krodhi'),(39,'Viśvāvasu','Vishvavasu'),(40,'Parābhava','Parabhava'),(41,'Plavaṅga','Plavanga'),(42,'Kīlaka','Kilaka'),(43,'Saumya','Saumya'),(44,'Sādhāraṇa','Sadharana'),(45,'Virodhikṛt','Virodhikruthi'),(46,'Paridhāvi','Paridhavi/Paridhvin'),(47,'Pramādī','Pramadi'),(48,'Ānanda','Ananda'),(49,'Rākṣasa','Rakshasa'),(50,'Nala/Anala','Nala/Anala'),(51,'Piṅgala','Pingala'),(52,'Kālayukta','Kalayukti'),(53,'Siddhārthi','Siddhartha/Siddharti'),(54,'Raudra','Raudri'),(55,'Durmati','Durmati'),(56,'Dundubhi','Dundubhi'),(57,'Rudhirodgārī','Rudhirodgari'),(58,'Raktākṣī','Raktakshi/Raktaksa'),(59,'Krodhana','Krodhana/Manyu'),(60,'Kṣaya','Akshaya');
/*!40000 ALTER TABLE `hinduyears` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occupation`
--

DROP TABLE IF EXISTS `occupation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `occupation` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `occname` varchar(100) DEFAULT NULL,
  `occrole` varchar(100) DEFAULT NULL,
  `addressid` int unsigned DEFAULT NULL,
  `parentid` int unsigned DEFAULT NULL,
  `parenttype` varchar(30) DEFAULT NULL,
  `income` smallint unsigned DEFAULT NULL,
  `compname` varchar(50) DEFAULT NULL,
  `occtype` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_occparid` (`parentid`),
  KEY `idx_occpartype` (`parenttype`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupation`
--

LOCK TABLES `occupation` WRITE;
/*!40000 ALTER TABLE `occupation` DISABLE KEYS */;
INSERT INTO `occupation` VALUES (1,'Softwre Engineer','Project Manager',NULL,4,'profile',0,'Goldman Sachs',3),(2,'softwre','team lead',NULL,6,'profile',10,'Goldman Sachs',NULL),(4,'Software Engineer','team lead',NULL,7,'profile',0,'DENTAPRISE SOFTWARE SYSTEMS',2),(7,'Software Engineer','Senior Cloud Engineer',NULL,3,'profile',0,'Amazon',NULL),(8,'business','rice traders',NULL,2,'profile',10,'bhagyalakshmi',2),(9,'Software Engineer','Senior Software Engineer',NULL,1,'profile',20,'Dentaprise Software Systems Pvt Ltd',NULL),(10,'Wholesale Provisional Store','business',NULL,8,'profile',10,'Sri Sai stores',NULL),(11,'Wholesale Provisional Store','project head',NULL,4,'profile',0,'LIC',1),(12,'Software Engineer','Project Manager',NULL,9,'profile',12,'Goldman Sachs',2),(13,'Softwre Engineer','team lead',NULL,5,'profile',20,'LIC',3),(14,'cricketer','captain',NULL,12,'profile',6,'BCCI',2),(15,'CA','Lead',NULL,11,'profile',25,'IBM',3),(16,'Cricketer','Team Captain',NULL,13,'profile',100,'BCCI',2),(17,'Media Personality','Actor',NULL,13,'profile',100,'Dhoni Media',2),(19,'Doctor','Surggeon',NULL,15,'profile',12,'Appolo Hospitals',2),(20,'Doctor','Surgeon',NULL,10,'profile',20,'Appolo Hospitals',2),(21,'softwre','team lead',NULL,14,'profile',10,'Goldman Sachs',3),(22,'Software Engineer','Devops Engineer',NULL,17,'profile',10,'IBM',3),(23,'matrimony office','properitor',NULL,19,'profile',30,'avkvk',1),(24,'Doctor','Anesthecia Specialist',NULL,20,'profile',8,'Appollo Hospitals',2),(25,'Propreiter','',NULL,22,'profile',NULL,'Wright Brick',1),(26,'employee','SEINOR MANAGER',NULL,23,'profile',12,'AIRTEL',3),(28,'Senior Associate','',NULL,24,'profile',200,'New York Life Insurance , New york',NULL),(29,'CLOUD DEVELOPMENT ENGINEER','',NULL,25,'profile',65,' CAMERAMATICS, DUBLIN, IRELAND',3),(30,'Software Engineer','',NULL,26,'profile',5,'RGBSI (P) LTD, BANGALORE',3),(31,'','',NULL,29,'profile',10,'Target Corporation',3),(32,'Audioligist','',NULL,28,'profile',NULL,'Victoria Hospital',2);
/*!40000 ALTER TABLE `occupation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attributes`
--

DROP TABLE IF EXISTS `product_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_attributes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `attribute_definition_id` bigint NOT NULL,
  `value_string` varchar(255) DEFAULT NULL,
  `value_number` decimal(14,4) DEFAULT NULL,
  `value_boolean` tinyint(1) DEFAULT NULL,
  `value_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_attr_string` (`attribute_definition_id`,`value_string`),
  KEY `idx_attr_number` (`attribute_definition_id`,`value_number`),
  KEY `idx_product` (`product_id`),
  CONSTRAINT `product_attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_attributes_ibfk_2` FOREIGN KEY (`attribute_definition_id`) REFERENCES `attribute_definitions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attributes`
--

LOCK TABLES `product_attributes` WRITE;
/*!40000 ALTER TABLE `product_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `extra_attributes` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (4,'Keyboard',NULL,NULL,'ACTIVE',NULL,'2026-01-07 09:01:46','2026-01-07 09:01:46'),(5,'Mouse',NULL,NULL,'ACTIVE',NULL,'2026-01-07 09:01:50','2026-01-07 09:01:50');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profileanswers`
--

DROP TABLE IF EXISTS `profileanswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profileanswers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profileid` int NOT NULL,
  `questionid` int NOT NULL,
  `answer` varchar(200) DEFAULT NULL,
  `createdby` int DEFAULT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ans_profid` (`profileid`),
  KEY `idx_ans_quesid` (`questionid`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profileanswers`
--

LOCK TABLES `profileanswers` WRITE;
/*!40000 ALTER TABLE `profileanswers` DISABLE KEYS */;
INSERT INTO `profileanswers` VALUES (143,5,1,'Yes',1,'2026-02-20 07:07:57'),(144,5,2,' No',1,'2026-02-20 07:07:57'),(145,5,3,'Yes',1,'2026-02-20 07:07:57'),(146,5,4,' Professional, Salaried',1,'2026-02-20 07:07:57'),(147,5,5,'BLR',1,'2026-02-20 07:07:57'),(148,5,6,' short-tempered',1,'2026-02-20 07:07:57'),(149,5,7,' No',1,'2026-02-20 07:07:57'),(150,6,1,' No',1,'2026-02-20 07:17:00'),(151,6,2,' No',1,'2026-02-20 07:17:00'),(152,6,3,' No Preference',1,'2026-02-20 07:17:00'),(153,6,4,' Professional, Salaried',1,'2026-02-20 07:17:00'),(154,6,5,'HYD',1,'2026-02-20 07:17:00'),(155,6,6,' short-tempered',1,'2026-02-20 07:17:00'),(156,6,7,' No',1,'2026-02-20 07:17:00'),(199,8,1,'Yes',1,'2026-03-02 11:57:08'),(200,8,2,' No',1,'2026-03-02 11:57:08'),(201,8,3,'Yes',1,'2026-03-02 11:57:08'),(202,8,4,' Professional',1,'2026-03-02 11:57:08'),(203,8,5,'hhh',1,'2026-03-02 11:57:08'),(204,8,6,' short-tempered',1,'2026-03-02 11:57:08'),(205,8,7,'Yes',1,'2026-03-02 11:57:08'),(206,7,1,'Yes',1,'2026-03-03 11:49:44'),(207,7,2,' No',1,'2026-03-03 11:49:44'),(208,7,3,'Yes',1,'2026-03-03 11:49:44'),(209,7,4,'Business, Professional, Salaried',1,'2026-03-03 11:49:44'),(210,7,5,'HYD',1,'2026-03-03 11:49:44'),(211,7,6,'calm',1,'2026-03-03 11:49:44'),(212,7,7,' No',1,'2026-03-03 11:49:44'),(255,4,1,'Yes',1,'2026-03-06 13:06:02'),(256,4,2,' No',1,'2026-03-06 13:06:02'),(257,4,3,'Yes',1,'2026-03-06 13:06:02'),(258,4,4,' Professional, Salaried',1,'2026-03-06 13:06:02'),(259,4,5,'BLR',1,'2026-03-06 13:06:02'),(260,4,6,' short-tempered',1,'2026-03-06 13:06:02'),(261,4,7,' No',1,'2026-03-06 13:06:02'),(274,2,2,'Yes',1,'2026-03-10 08:54:50'),(275,2,3,'Yes',1,'2026-03-10 08:54:50'),(276,2,4,' Professional, Salaried,Business',1,'2026-03-10 08:54:50'),(277,2,5,'bangalore',1,'2026-03-10 08:54:50'),(278,2,6,' short-tempered',1,'2026-03-10 08:54:50'),(279,2,7,'Yes',1,'2026-03-10 08:54:50'),(280,10,2,'Yes',1,'2026-03-10 09:19:21'),(281,10,3,'Yes',1,'2026-03-10 09:19:21'),(282,10,4,' Professional, Salaried',1,'2026-03-10 09:19:21'),(283,10,5,'bangalore',1,'2026-03-10 09:19:21'),(284,10,6,'calm',1,'2026-03-10 09:19:21'),(285,10,7,' No',1,'2026-03-10 09:19:21'),(298,13,2,'Yes',2,'2026-03-24 17:30:41'),(299,13,4,'Business',2,'2026-03-24 17:30:41'),(300,13,3,'No Preference',2,'2026-03-24 17:30:41'),(301,13,7,'No',2,'2026-03-24 17:30:41'),(302,13,6,'calm',2,'2026-03-24 17:30:41'),(321,11,4,'Salaried',2,'2026-03-25 12:06:49'),(327,14,1,'Yes',1,'2026-04-01 07:47:53'),(328,14,2,'Yes',1,'2026-04-01 07:47:53'),(329,14,4,'Professional',1,'2026-04-01 07:47:53'),(330,14,5,'bangalore',1,'2026-04-01 07:47:53'),(331,9,1,'Yes',2,'2026-04-11 05:35:15'),(332,9,2,'No',2,'2026-04-11 05:35:15'),(333,9,4,'Professional, Salaried,Professional',2,'2026-04-11 05:35:15'),(334,9,5,'bangalore',2,'2026-04-11 05:35:15'),(335,9,6,'short-tempered',2,'2026-04-11 05:35:15'),(336,9,7,'No',2,'2026-04-11 05:35:15'),(337,15,1,'Yes',1,'2026-04-13 07:10:31'),(338,15,2,'No',1,'2026-04-13 07:10:31'),(339,15,7,'No',1,'2026-04-13 07:10:31'),(340,21,2,'No',1,'2026-07-10 08:05:16'),(341,21,5,'KARNATAKA',1,'2026-07-10 08:05:16'),(342,21,7,'No',1,'2026-07-10 08:05:16'),(343,21,1,'No',1,'2026-07-10 08:05:16'),(344,21,4,'Business,Professional,Salaried',1,'2026-07-10 08:05:16');
/*!40000 ALTER TABLE `profileanswers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profileinteraction`
--

DROP TABLE IF EXISTS `profileinteraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profileinteraction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profileid` int NOT NULL,
  `interactiontype` tinyint NOT NULL,
  `notes` text,
  `createdat` datetime DEFAULT CURRENT_TIMESTAMP,
  `userid` int NOT NULL,
  `udcreateddt` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_profile` (`profileid`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profileinteraction`
--

LOCK TABLES `profileinteraction` WRITE;
/*!40000 ALTER TABLE `profileinteraction` DISABLE KEYS */;
INSERT INTO `profileinteraction` VALUES (1,7,1,'want to hold the matches upto next 2 months','2026-02-10 09:34:17',0,'2026-02-20 15:17:06',NULL),(2,7,2,'2nd user','2026-02-10 10:30:25',0,'2026-02-20 15:17:06',NULL),(3,7,1,'we liked profile number 4','2026-02-12 09:18:18',0,'2026-02-20 15:17:06',NULL),(4,7,1,'stop the matches for next 3 months','2026-02-12 10:00:37',0,'2026-02-20 15:17:06',NULL),(5,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:12',1,'2026-02-22 14:37:12',NULL),(6,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:14',1,'2026-02-22 14:37:14',NULL),(7,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:15',1,'2026-02-22 14:37:15',NULL),(8,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:15',1,'2026-02-22 14:37:15',NULL),(9,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:15',1,'2026-02-22 14:37:15',NULL),(10,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:15',1,'2026-02-22 14:37:15',NULL),(11,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:15',1,'2026-02-22 14:37:15',NULL),(12,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:16',1,'2026-02-22 14:37:16',NULL),(13,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:16',1,'2026-02-22 14:37:16',NULL),(14,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:16',1,'2026-02-22 14:37:16',NULL),(15,8,4,'asked for some more profiles to send through watsapp','2026-02-22 14:37:26',1,'2026-02-22 14:37:26',NULL),(16,56,1,'follow up with profile 32','2026-02-25 09:03:51',1,'2026-02-25 09:03:51',NULL),(17,2,1,'follow up with profile 32','2026-02-25 09:04:30',1,'2026-02-25 09:04:30',NULL),(18,2,1,'follow up with profile 32','2026-02-25 09:04:31',1,'2026-02-25 09:04:31',NULL),(19,2,1,'follow up with profile 32','2026-02-25 09:04:37',1,'2026-02-25 09:04:37',NULL),(20,8,1,'asked for some more profiles to be sent','2026-03-03 08:09:42',1,'2026-03-03 08:09:42',NULL),(21,8,1,'asked for some more profiles to be sent','2026-03-03 08:09:45',1,'2026-03-03 08:09:45',NULL),(22,8,1,'asked for some more profiles to be sent','2026-03-03 08:09:53',1,'2026-03-03 08:09:53',NULL),(23,8,1,'asked for  some more profiles','2026-03-03 08:10:54',1,'2026-03-03 08:10:54',NULL),(24,8,1,'asked for  some more profiles','2026-03-03 08:10:57',1,'2026-03-03 08:10:57',NULL),(25,9,1,'liked the profile number 6','2026-03-12 08:32:51',1,'2026-03-12 08:32:51',0),(26,9,2,'liked profilenumber 6 ','2026-03-13 07:31:37',1,'2026-03-13 07:31:37',0),(27,11,4,'profile match.','2026-03-16 00:00:00',1,'2026-03-14 08:11:47',1),(28,11,1,'wanted more profiles','2026-03-17 00:00:00',1,'2026-03-14 08:20:42',0),(29,10,2,'liked the profile number 22 ','2026-03-16 06:49:25',1,'2026-03-16 06:49:25',0),(30,10,2,'update2','2026-03-16 06:55:23',1,'2026-03-16 06:55:23',0),(31,11,3,'test inter','2026-03-16 09:11:16',1,'2026-03-16 09:11:16',0),(32,12,1,'wanted profiles','2026-04-01 07:44:32',1,'2026-04-01 07:44:32',0),(33,14,1,'update my salary','2026-04-01 08:06:06',2,'2026-04-01 08:06:06',0),(34,8,1,'call profile 10202','2026-04-01 08:11:50',2,'2026-04-01 08:11:50',0),(35,8,1,'call profile 10202','2026-04-01 08:12:05',2,'2026-04-01 08:12:05',0),(36,8,1,'call profile 10202','2026-04-01 08:12:13',2,'2026-04-01 08:12:13',0),(37,9,4,'asked for more profiles and liked profile number 9 and 10','2026-04-01 14:44:10',2,'2026-04-01 14:44:10',0),(38,8,3,'test notes','2026-04-09 13:47:34',1,'2026-04-09 13:47:34',1),(39,4,1,'discussed about the previously shared profiles and interested to proceed further with profile number 12','2026-04-11 08:57:45',3,'2026-04-11 08:57:45',0),(40,15,1,'Send more profiles','2026-04-13 07:12:20',1,'2026-04-13 07:12:20',0),(41,15,4,'interested in some profiles','2026-04-13 07:21:11',1,'2026-04-13 07:21:11',0),(42,15,4,'interested in some profiles','2026-04-13 07:21:43',1,'2026-04-13 07:21:43',0),(43,15,1,'test','2026-04-29 09:58:00',1,'2026-04-29 09:58:00',1),(44,15,1,'test','2026-04-29 10:01:32',1,'2026-04-29 10:01:32',1),(45,16,1,'test','2026-04-29 10:03:59',1,'2026-04-29 10:03:59',0),(46,15,2,'test follow-up','2026-04-29 10:04:22',1,'2026-04-29 10:04:22',1),(47,15,3,'test','2026-04-29 10:32:15',1,'2026-04-29 10:32:15',1),(48,15,2,'test interaction','2026-04-29 10:35:55',1,'2026-04-29 10:35:55',1),(49,15,3,'asdfasf','2026-04-29 10:36:30',1,'2026-04-29 10:36:30',1),(50,15,3,'test','2026-04-29 10:37:30',1,'2026-04-29 10:37:30',1),(51,15,3,'test','2026-04-29 10:38:34',1,'2026-04-29 10:38:34',1),(52,15,4,'testtt','2026-04-29 10:38:46',1,'2026-04-29 10:38:46',1),(53,15,3,'testttt','2026-04-29 10:39:24',1,'2026-04-29 10:39:24',0),(54,16,4,'share profiles','2026-05-03 13:46:25',1,'2026-05-03 13:46:25',0),(55,16,2,'test interactions','2026-05-06 09:31:25',2,'2026-05-06 09:31:25',0),(56,9,1,'liked the profile number 19012','2026-05-07 08:24:16',2,'2026-05-07 08:24:16',0),(57,14,2,'liked profile number 19008','2026-05-07 08:35:31',2,'2026-05-07 08:35:31',0),(58,16,1,'test 112','2026-05-07 08:52:53',1,'2026-05-07 08:52:53',0),(59,10,2,'19016 is not interested.','2026-05-07 09:10:49',1,'2026-05-07 09:10:49',0),(60,14,2,'check with this client about profiles sent.','2026-05-11 10:57:06',1,'2026-05-11 10:57:06',0),(61,13,3,'share profiles ','2026-05-11 11:17:47',1,'2026-05-11 11:17:47',0),(62,10,4,'just a casual visit','2026-05-11 11:36:36',1,'2026-05-11 11:36:36',0),(63,16,3,'shared with 19014','2026-05-11 11:39:30',1,'2026-05-11 11:39:30',0),(64,14,4,'this should get added to 19014 and not 19016','2026-05-11 11:44:53',1,'2026-05-11 11:44:53',0),(65,10,4,'test search','2026-05-11 11:45:27',1,'2026-05-11 11:45:27',0),(66,17,2,'WHAT HAPPENED WITH 20101?','2026-05-28 06:54:23',1,'2026-05-28 06:54:23',0),(67,19,2,'ask about 20645','2026-05-29 12:53:32',5,'2026-05-29 12:53:32',0),(68,19,4,'they took 3 profiles','2026-05-29 12:54:25',5,'2026-05-29 12:54:25',0),(69,20,2,'asking for more profiles with Occupation as Software Engineer','2026-06-16 17:49:21',1,'2026-06-16 17:49:21',0);
/*!40000 ALTER TABLE `profileinteraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profilematch`
--

DROP TABLE IF EXISTS `profilematch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profilematch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profileid` int NOT NULL,
  `matchprofileid` int NOT NULL,
  `status` tinyint NOT NULL,
  `reasoncode` tinyint DEFAULT NULL,
  `notes` text,
  `createdat` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedat` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_pair` (`profileid`,`matchprofileid`),
  KEY `idx_pm_profileid` (`profileid`),
  KEY `idx_pm_matchprofileid` (`matchprofileid`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profilematch`
--

LOCK TABLES `profilematch` WRITE;
/*!40000 ALTER TABLE `profilematch` DISABLE KEYS */;
INSERT INTO `profilematch` VALUES (6,7,4,1,NULL,NULL,'2026-02-04 11:32:28','2026-02-04 11:32:28'),(7,7,6,9,3,NULL,'2026-02-04 11:40:05','2026-03-04 17:55:18'),(8,8,7,9,3,NULL,'2026-02-23 11:31:55','2026-03-04 18:10:33'),(9,8,3,9,3,NULL,'2026-02-23 11:32:12','2026-03-06 03:13:18'),(10,6,5,1,NULL,NULL,'2026-02-23 11:32:51','2026-02-23 11:32:51'),(11,6,2,1,NULL,NULL,'2026-02-23 11:32:53','2026-02-23 11:32:53'),(12,5,6,1,NULL,NULL,'2026-02-23 11:34:18','2026-02-23 11:34:18'),(13,5,4,1,NULL,NULL,'2026-02-23 11:34:20','2026-02-23 11:34:20'),(14,4,1,9,3,NULL,'2026-02-23 11:34:29','2026-03-06 13:06:27'),(15,4,2,9,3,NULL,'2026-02-23 11:34:29','2026-03-06 12:55:54'),(16,9,7,9,3,NULL,'2026-03-03 11:29:57','2026-03-04 18:15:20'),(17,9,3,9,3,NULL,'2026-03-03 11:30:52','2026-03-04 07:43:20'),(18,9,1,9,3,NULL,'2026-03-03 11:31:13','2026-03-04 07:42:25'),(19,9,2,9,3,NULL,'2026-03-03 11:32:10','2026-03-04 07:40:29'),(26,9,5,9,3,NULL,'2026-03-06 05:07:25','2026-03-06 08:09:40'),(27,8,5,1,NULL,NULL,'2026-03-06 05:14:36','2026-03-06 05:14:36'),(28,8,2,1,NULL,NULL,'2026-03-06 08:04:51','2026-03-06 08:04:51'),(30,9,10,9,3,NULL,'2026-03-06 09:07:45','2026-03-11 16:18:09'),(33,1,9,1,NULL,NULL,'2026-03-06 12:13:51','2026-03-06 12:13:51'),(35,10,4,9,3,NULL,'2026-03-06 13:27:33','2026-03-10 07:55:40'),(36,10,8,1,NULL,NULL,'2026-03-06 13:34:13','2026-03-06 13:34:13'),(39,10,9,9,3,NULL,'2026-03-10 08:30:14','2026-03-10 08:36:02'),(40,10,6,1,NULL,NULL,'2026-03-10 08:33:03','2026-03-10 08:33:03'),(41,3,9,9,3,NULL,'2026-03-10 09:02:15','2026-03-10 09:02:36'),(42,2,8,1,NULL,NULL,'2026-03-10 09:32:04','2026-03-10 09:32:04'),(44,11,9,9,3,NULL,'2026-03-11 16:37:36','2026-03-11 16:37:47'),(45,9,11,1,NULL,NULL,'2026-03-13 09:41:24','2026-03-13 09:41:24'),(46,11,4,9,3,NULL,'2026-03-14 08:10:21','2026-03-14 08:10:48'),(48,14,13,1,NULL,NULL,'2026-04-01 07:54:32','2026-04-01 07:54:32'),(51,15,3,1,3,NULL,'2026-04-13 07:11:12','2026-07-30 11:36:02'),(52,15,8,1,NULL,NULL,'2026-04-13 07:11:43','2026-04-13 07:11:43'),(55,17,15,9,11,NULL,'2026-05-27 19:02:28','2026-07-03 22:29:16'),(58,18,13,9,3,NULL,'2026-05-28 06:52:00','2026-05-28 06:52:35'),(59,19,15,1,NULL,NULL,'2026-05-28 12:32:06','2026-05-28 12:32:06'),(64,19,14,9,3,NULL,'2026-05-28 12:37:38','2026-07-10 08:20:50'),(65,1,14,1,NULL,NULL,'2026-06-09 17:51:32','2026-06-09 17:51:32'),(66,1,15,1,NULL,NULL,'2026-06-09 17:51:35','2026-06-09 17:51:35'),(67,17,6,1,NULL,NULL,'2026-07-03 22:29:00','2026-07-03 22:29:00'),(68,19,21,1,NULL,NULL,'2026-07-10 08:17:27','2026-07-10 08:17:27');
/*!40000 ALTER TABLE `profilematch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profileplans`
--

DROP TABLE IF EXISTS `profileplans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profileplans` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `profileid` int NOT NULL,
  `plan_start` date NOT NULL,
  `plan_expiry` date NOT NULL,
  `duration_days` int unsigned DEFAULT NULL,
  `subscription_name` enum('bronze','silver','gold','diamond') NOT NULL,
  `payment_status` enum('unpaid','paid','expiring','expired') NOT NULL DEFAULT 'unpaid',
  `created_by` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `payment_confirmed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_profileid` (`profileid`),
  KEY `idx_payment_status` (`payment_status`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profileplans`
--

LOCK TABLES `profileplans` WRITE;
/*!40000 ALTER TABLE `profileplans` DISABLE KEYS */;
INSERT INTO `profileplans` VALUES (1,12,'2026-03-17','2028-03-17',NULL,'gold','paid',1,'2026-03-17 11:18:18','2026-03-17 11:18:39',NULL),(2,11,'2026-03-23','2026-09-23',NULL,'bronze','paid',1,'2026-03-23 08:56:24','2026-03-23 08:56:35','2026-03-23 08:56:35'),(3,14,'2026-04-01','2027-04-01',NULL,'silver','paid',1,'2026-04-01 07:45:59','2026-04-01 07:46:04','2026-04-01 07:46:04'),(4,15,'2026-04-13','2028-04-13',NULL,'gold','paid',1,'2026-04-13 07:14:21','2026-04-13 07:14:24','2026-04-13 07:14:24'),(5,15,'2026-04-28','2026-10-28',NULL,'bronze','paid',1,'2026-04-28 11:20:48','2026-04-29 13:47:55','2026-04-29 13:47:55'),(6,17,'2026-05-27','2026-11-27',NULL,'bronze','paid',1,'2026-05-27 18:51:47','2026-05-27 18:52:13','2026-05-27 18:52:13'),(7,18,'2026-05-28','2027-05-28',NULL,'silver','paid',1,'2026-05-28 06:37:53','2026-05-28 07:01:52','2026-05-28 07:01:52'),(8,18,'2026-05-28','2028-05-28',NULL,'gold','paid',1,'2026-05-28 07:02:24','2026-05-28 11:22:11','2026-05-28 11:22:11'),(9,13,'2026-05-28','2027-05-28',NULL,'silver','paid',1,'2026-05-28 07:03:53','2026-06-25 19:34:51','2026-06-25 19:34:51'),(10,19,'2026-05-28','2027-05-28',NULL,'silver','paid',1,'2026-05-28 12:27:12','2026-06-02 09:23:19','2026-06-02 09:23:19'),(11,20,'2000-12-12','2001-12-12',NULL,'silver','expired',1,'2026-06-15 15:25:46','2026-06-15 15:25:52','2026-06-15 15:25:52'),(12,20,'2000-12-12','2001-12-12',NULL,'silver','expired',1,'2026-06-15 15:26:18','2026-06-15 15:26:23','2026-06-15 15:26:23'),(13,10,'2026-06-17','2027-06-17',NULL,'silver','paid',1,'2026-06-17 08:39:58','2026-06-17 08:40:05','2026-06-17 08:40:05'),(14,23,'2026-07-10','2027-07-10',NULL,'silver','unpaid',1,'2026-07-10 07:33:50','2026-07-10 07:33:50',NULL),(15,23,'2026-07-10','2027-07-10',NULL,'silver','unpaid',1,'2026-07-10 07:33:58','2026-07-10 07:33:58',NULL);
/*!40000 ALTER TABLE `profileplans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profilepreference`
--

DROP TABLE IF EXISTS `profilepreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profilepreference` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profileid` int NOT NULL,
  `minincome` decimal(10,2) DEFAULT NULL,
  `minnetworth` decimal(10,2) DEFAULT NULL,
  `agegap` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profileid` (`profileid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profilepreference`
--

LOCK TABLES `profilepreference` WRITE;
/*!40000 ALTER TABLE `profilepreference` DISABLE KEYS */;
INSERT INTO `profilepreference` VALUES (1,4,6.00,25.00,NULL),(2,2,10.00,20.00,NULL),(3,6,6.00,20.00,NULL),(4,7,7.00,25.00,NULL),(5,5,10.00,10.00,NULL),(6,8,45.00,45.00,NULL),(7,9,15.00,10.00,3),(8,10,10.00,20.00,NULL),(9,11,20.00,20.00,3),(10,13,10.00,20.00,NULL),(11,14,10.00,7.00,3),(12,12,NULL,NULL,4),(13,15,20.00,10.00,4),(14,18,10.00,5.00,5),(15,19,0.00,0.00,0),(16,21,NULL,NULL,5),(17,26,NULL,NULL,NULL);
/*!40000 ALTER TABLE `profilepreference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profilequestions`
--

DROP TABLE IF EXISTS `profilequestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profilequestions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `questiontxt` varchar(200) NOT NULL,
  `answertype` tinyint NOT NULL DEFAULT '1',
  `ansopts` varchar(200) DEFAULT NULL,
  `createdby` int DEFAULT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `orgid` int DEFAULT NULL,
  `forgender` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ques_orgid` (`orgid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profilequestions`
--

LOCK TABLES `profilequestions` WRITE;
/*!40000 ALTER TABLE `profilequestions` DISABLE KEYS */;
INSERT INTO `profilequestions` VALUES (1,'Willing to work after marriage?',4,'Yes, No',NULL,'2026-02-10 16:43:21',1,2),(2,'Do you prefer abroad profiles?',4,'Yes, No',NULL,'2026-02-10 16:43:54',1,3),(3,'Do you prefer working spouse?',4,'Yes, No, No Preference',NULL,'2026-02-10 16:48:30',1,1),(4,'What profession do you prefer?',3,'Business, Professional, Salaried',NULL,'2026-02-10 16:50:46',1,3),(5,'Which City do you prefer?',1,NULL,NULL,'2026-02-18 14:00:03',1,3),(6,'how would you describe your nature',2,'calm, short-tempered, adjustable',NULL,'2026-02-20 00:37:40',1,3),(7,'Do you have any health issues we should know?',4,'Yes, No',NULL,'2026-02-20 01:03:55',1,3);
/*!40000 ALTER TABLE `profilequestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profilerejection`
--

DROP TABLE IF EXISTS `profilerejection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profilerejection` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profileid` int NOT NULL,
  `rejectedprofileid` int NOT NULL,
  `reasoncode` tinyint unsigned NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profileid` (`profileid`,`rejectedprofileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profilerejection`
--

LOCK TABLES `profilerejection` WRITE;
/*!40000 ALTER TABLE `profilerejection` DISABLE KEYS */;
/*!40000 ALTER TABLE `profilerejection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` varchar(50) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `middlei` varchar(50) DEFAULT NULL,
  `familyname` varchar(100) DEFAULT NULL,
  `nameaddlinfo` varchar(255) DEFAULT NULL,
  `gender` tinyint unsigned DEFAULT '1',
  `birthdate` date DEFAULT NULL,
  `birthtime` time DEFAULT NULL,
  `birthstar` tinyint unsigned DEFAULT NULL,
  `starpada` tinyint unsigned DEFAULT '1',
  `birthrasi` varchar(50) DEFAULT NULL,
  `birthplace` varchar(100) DEFAULT NULL,
  `birthdist` varchar(100) DEFAULT NULL,
  `birthstate` varchar(100) DEFAULT NULL,
  `birthcountry` varchar(100) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `color` tinyint unsigned DEFAULT NULL,
  `broe` tinyint unsigned DEFAULT NULL,
  `broem` tinyint unsigned DEFAULT NULL,
  `broy` tinyint unsigned DEFAULT NULL,
  `borym` tinyint unsigned DEFAULT NULL,
  `sise` tinyint unsigned DEFAULT NULL,
  `sisem` tinyint unsigned DEFAULT NULL,
  `sisy` tinyint unsigned DEFAULT NULL,
  `sisym` tinyint unsigned DEFAULT NULL,
  `hastwin` tinyint(1) DEFAULT NULL,
  `workid` int DEFAULT NULL,
  `profilests` tinyint unsigned DEFAULT '1',
  `billingsts` tinyint unsigned DEFAULT NULL,
  `maritalsts` tinyint unsigned DEFAULT NULL,
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedon` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdby` int DEFAULT NULL,
  `updatedby` int DEFAULT NULL,
  `phonenumber` varchar(15) DEFAULT NULL,
  `profilePictureId` int unsigned DEFAULT NULL,
  `education1` varchar(30) DEFAULT NULL,
  `almamater` varchar(100) DEFAULT NULL,
  `udeducation` varchar(30) DEFAULT NULL,
  `swagothra` smallint DEFAULT NULL,
  `mamagothra` smallint DEFAULT NULL,
  `familygod` varchar(30) DEFAULT NULL,
  `education2` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `horoscopepictureId` int unsigned DEFAULT NULL,
  `familyphotoId` int unsigned DEFAULT NULL,
  `current_address_id` int unsigned DEFAULT NULL,
  `permanent_address_id` int unsigned DEFAULT NULL,
  `work_address_id` int unsigned DEFAULT NULL,
  `income` decimal(10,2) DEFAULT NULL,
  `networth` decimal(10,2) DEFAULT NULL,
  `traditional_picture_id` int unsigned DEFAULT NULL,
  `contemporary_picture_id` int unsigned DEFAULT NULL,
  `last_interaction` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `secret_notes` json DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `assetdets` text,
  `additional_details` text,
  `almamater2` varchar(100) DEFAULT NULL,
  `childrencount` tinyint unsigned DEFAULT NULL,
  `orgid` int DEFAULT NULL,
  `inacreason` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_org_client` (`orgid`,`client_id`),
  KEY `idx_birthdate` (`birthdate`),
  KEY `idx_prof_gender` (`gender`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'19001','Ramesh','Jonnagadla','P','Jonnagadla',NULL,1,'1970-12-12','04:46:00',3,3,'2','madanapalli','kadapa','andrapradesh',NULL,78.00,3,2,11,1,0,1,1,0,0,2,NULL,1,NULL,2,'2026-01-16 11:51:37','2026-06-09 17:51:35',1,1,'9945877803',181,'B.tech','PES University','Civil Engineering',55,20,'Subramanyeshwara Swamy','M.tech','ramesh@j.gmail.com',NULL,NULL,47,47,48,15.00,3.00,NULL,NULL,'2026-06-09 17:51:35',NULL,162.56,'1 Car, 2 Bikes, 2 House , 1 Plot, ',NULL,NULL,NULL,1,NULL),(2,'19002','Karthik','ramakrishna','makam','makam',NULL,1,'2002-02-10','07:23:00',1,4,'2','bangalore','godawari','andrapradesh',NULL,68.00,1,2,1,2,1,2,1,1,1,2,NULL,1,NULL,2,'2026-01-17 09:46:27','2026-05-27 09:13:57',1,1,'9945877803',179,'MCA','Dayananda Sagar College Of Engineering','diploma',170,170,'kabbalamma','M.tech','karthikmakam@gmail.com',NULL,NULL,64,64,NULL,10.00,20.00,NULL,NULL,'2026-04-29 09:14:39',NULL,NULL,'2 Cars, 3 bikes, 2 house, 2 plots, 3 acres land',NULL,NULL,NULL,1,NULL),(3,'19003','Ramakrishna','karthik','makam','Makam',NULL,1,'1999-07-15','08:05:00',2,2,'1','bangalore','Bangalore','karnataka','1',72.00,1,2,2,1,1,2,2,1,1,2,NULL,1,NULL,1,'2026-01-17 13:38:56','2026-07-30 11:37:02',1,1,'1234567890',175,'B.tech','PES University','NA',10,11,'aadinarayana swamy ','M.tech','ramakrishna@gmail.com',NULL,NULL,34,34,35,15.00,5.00,NULL,NULL,'2026-07-30 11:37:02',NULL,NULL,'1 Car, 3 Bikes, 2 house 1 @ Jayanagar , 1 @ AGS Layout , 1 Plot @ Kengeri',NULL,NULL,NULL,1,NULL),(4,'19004','geetha','kumar','krishna','naidu',NULL,2,'2000-02-10','05:01:00',3,3,'2','bangalore','Bangalore south','karnataka','2',72.00,4,4,5,6,1,4,3,2,1,1,NULL,1,NULL,2,'2026-01-19 07:32:58','2026-06-17 08:43:16',1,1,'1234567890',241,'BCA','Dayananda Sagar College Of Engineering','NA',184,9,'Kasapuram Anjaneya Swamy','MCA','geethakumar24@gmail.com',NULL,NULL,NULL,NULL,NULL,20.00,3.00,NULL,NULL,'2026-04-29 09:15:08',NULL,152.40,'1 car \n1 bike \n1 house',NULL,NULL,NULL,1,NULL),(5,'19005','Ram','Makam','','makam',NULL,1,'1998-12-12','01:00:00',1,1,'1','bangalore','bangalore south','Andhra Pradesh',NULL,68.00,1,4,4,0,0,4,4,1,1,2,NULL,1,NULL,2,'2026-01-24 09:37:58','2026-07-17 10:13:33',1,1,'9945877803',258,'SSLC','PES College','telecommunications',NULL,NULL,'Subramanyeshwara Swamy','Diploma',NULL,NULL,NULL,44,44,NULL,NULL,NULL,NULL,NULL,'2026-04-29 09:15:30',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(6,'19006','pavithra','nayak','kumar','',NULL,2,'2003-06-17','02:59:00',2,2,'2','magadi','Bangalore rural','karnataka',NULL,68.00,1,1,0,0,0,0,0,1,1,1,NULL,1,NULL,2,'2026-01-24 11:35:13','2026-07-03 22:29:00',1,1,'1234567890',240,'BCA','Dayananda Sagar College Of Engineering','nil',295,NULL,'Venkateshwara swamy','MCA','pavithrak@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-03 22:29:00',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(7,'19007','suman','Prasad','shetty','katta',NULL,1,'1984-09-13','08:47:00',4,2,'2','paideti','hindupur','andrapradesh',NULL,78.00,2,1,2,0,0,0,0,1,1,2,NULL,1,NULL,2,'2026-01-26 09:48:43','2026-06-17 08:44:40',1,1,'8147147025',243,'BCA','Dayananda Sagar College Of Engineering','diploma',200,295,'Venkateshwara swamy','MCA','sumanshetty@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-05-07 09:00:20',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(8,'19008','lokesh','Guptha','kumar','raaju',NULL,1,'1996-05-25','16:20:00',2,3,'2','Kadapa','medikurthi','Telangna',NULL,80.00,2,1,1,1,0,0,0,0,0,2,NULL,1,NULL,2,'2026-02-19 19:51:23','2026-07-10 08:20:19',1,1,'4569871230',242,'Bcom','RNSIT','CS',112,174,'Shiva','MBA','lokesh@123gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-10 08:20:19',NULL,NULL,NULL,NULL,NULL,NULL,1,'not respomding'),(9,'19009','Ashwini','Kumari','','Somename',NULL,2,'1999-12-12','05:30:00',1,1,'1','bangalore','Bangalore','karnataka',NULL,72.00,1,2,1,1,0,0,0,0,0,2,NULL,1,NULL,2,'2026-03-03 10:46:44','2026-06-17 08:41:56',1,1,'1234567890',239,'Diploma, Btech','BMSIT','nil',112,170,'Venkateshwara swamy','Mtech','karthik@rameshj.com',NULL,NULL,NULL,NULL,NULL,12.00,10.00,NULL,NULL,'2026-05-07 08:24:17',NULL,142.24,'2 cars, 2 bikes, 2 house, 1 land (2 acre)',NULL,NULL,NULL,1,NULL),(10,'19010','Sanjay','','Kumar','Muntimadugu',NULL,1,'1990-12-12','12:25:00',1,1,'1','Ernakulam','Ernakulam','Kerala',NULL,78.00,2,1,1,1,1,1,1,1,1,2,NULL,1,NULL,2,'2026-03-06 07:34:03','2026-06-17 08:40:05',1,1,'1234565890',238,'BCA','Dayananda Sagar College Of Engineering','',295,87,'Jesus Christ','MBA','sanju.samson@bcci.india.test',NULL,NULL,92,92,NULL,30.00,30.00,NULL,NULL,'2026-06-17 08:40:05',NULL,162.56,'2 house, 3 cars, 2 bikes, 2 plots',NULL,NULL,NULL,1,NULL),(11,'19011','Madhu','Kiran','','E',NULL,1,'1995-12-12','00:55:00',1,1,'1','bangalore','Bangalore rural','karnataka',NULL,72.00,1,1,1,1,0,1,1,1,0,2,NULL,1,NULL,2,'2026-03-11 16:36:25','2026-06-17 08:36:33',1,1,'1234567890',237,'BCA','Dayananda Sagar College Of Engineering','telecommunications',283,21,'Venkateshwara swamy','MSC','karthik@rameshj.com',NULL,NULL,33,33,NULL,25.00,30.00,NULL,NULL,'2026-06-15 12:13:15','[{\"id\": \"1773665526835\", \"text\": \"hi hello\", \"hidden\": true, \"staffid\": 2, \"profileid\": 11}]',162.56,'2 own house,\n50k rental income,\n2 cites in bangalore',NULL,'RICE University',NULL,1,NULL),(12,'19012','rohith','Sharma','','sharma',NULL,1,'1990-12-12','06:32:00',3,4,'1','hydrabadh','mumbai','asdfasdf',NULL,72.00,1,1,1,1,1,1,1,1,1,2,NULL,1,NULL,2,'2026-03-17 11:02:01','2026-06-17 08:35:41',1,1,'9945877803',236,'BE','Dayananda Sagar College Of Engineering','nil',55,225,'Venkateshwara swamy','ME','rohith@rameshj.com',NULL,NULL,71,71,NULL,20.00,4.00,NULL,NULL,'2026-05-28 06:58:54','[]',167.64,'2 cars, 2 bike, 2 house ',NULL,NULL,NULL,1,NULL),(13,'19013','Mahendar','Dhoni','','',NULL,1,'1992-07-07','00:45:00',1,2,'1','Ranchi','Ranchi','Bihar',NULL,78.00,1,1,1,1,0,1,1,2,1,2,NULL,1,NULL,2,'2026-03-24 07:59:57','2026-06-25 19:34:51',1,1,'1234567890',235,'BCA','UVCE, Bangalore','nil',21,224,'Venkateshwara swamy','MCA','dhoni@r.com.test',NULL,NULL,89,89,37,50.00,100.00,NULL,NULL,'2026-06-25 19:34:51','[]',177.80,'20 bikes\n8 cars\n3 house\n1 cricket academy',NULL,'VIT tamilnadu',NULL,1,NULL),(14,'19014','Sakshi','Singh','','Singh',NULL,2,'1996-12-12','13:25:00',2,2,'1','Delhi','Delhi','Delhi',NULL,62.00,1,1,1,1,1,1,1,1,1,2,NULL,1,NULL,2,'2026-03-24 08:10:03','2026-06-17 08:24:48',1,1,'1234567891',232,'BCA','RNSIT','nil',170,170,'Venkateshwara swamy','MCA','sakshi@f.com.test',NULL,NULL,69,69,NULL,20.00,3.00,NULL,NULL,'2026-06-09 17:51:32','[]',167.64,'1 car\n1 bike\n1 house \nrental income 25 lakhs',NULL,'Dayananada Sagar College ',NULL,1,NULL),(15,'19015','Kusuma','Kumari','','Makam',NULL,2,'2001-12-12','08:30:00',1,1,'1','Bangalore','Kadapa','Andhra Pradesh',NULL,55.00,1,1,1,1,0,NULL,NULL,NULL,NULL,2,NULL,1,NULL,3,'2026-04-13 07:08:58','2026-07-30 11:37:02',1,1,'9123456789',231,'MBBS','Mandya Institute of Medical Science','nil',18,112,'Venkateshwara Swamy','MD','kusuma@gmail.com.test',NULL,NULL,66,67,NULL,20.00,20.00,NULL,NULL,'2026-07-30 11:37:02','[]',160.02,'Own house 40 x 60\n5 sites around bangalore\nRental income 6L per year',NULL,'Mandya Institute of Medical Science',2,1,NULL),(16,'19016','vyshak','','CV','Chennur',NULL,1,'1997-07-26','12:45:00',1,2,'1','Mysore','Bangalore south','karnataka',NULL,60.00,1,NULL,NULL,NULL,NULL,NULL,NULL,1,0,2,NULL,2,NULL,2,'2026-04-13 09:23:59','2026-08-03 13:55:25',2,5,'8970235264',230,'Bcom','jgi','digital marketing',191,110,'','MBA','cv.vyshak@gmail.com',NULL,NULL,NULL,NULL,NULL,50000.00,8.00,NULL,NULL,'2026-08-03 13:55:25','[]',162.56,'own house , own shop',NULL,'RNS',NULL,1,'no'),(17,'19020','Subramanyam','','','Poojari',NULL,1,'2001-04-04','17:18:00',2,4,'3','bangalore',NULL,NULL,NULL,68.00,1,0,0,0,0,0,0,1,1,2,NULL,1,NULL,2,'2026-05-27 18:48:21','2026-07-03 22:29:00',1,1,'1234567890',229,NULL,NULL,NULL,112,18,NULL,NULL,'subbramanyam9979@gmail.com',NULL,NULL,87,87,88,10.00,15.00,NULL,NULL,'2026-07-03 22:29:00','[]',175.26,'2 own houses \n3 acres of agricultural land \nrental income 50K/M\n2 cars, 2 bikes ',NULL,NULL,NULL,1,'stop'),(18,'21265','SIRI','','','KOTA',NULL,2,'2000-06-02','18:54:00',4,2,'2','BANGALORE',NULL,NULL,NULL,NULL,1,0,0,1,0,0,0,0,0,2,NULL,1,NULL,2,'2026-05-28 06:22:17','2026-06-16 18:54:42',1,1,'9972309784',228,NULL,NULL,NULL,261,112,NULL,NULL,'',NULL,NULL,84,84,83,NULL,NULL,NULL,NULL,'2026-06-16 18:54:42','[]',165.10,'OWN HOUSE',NULL,NULL,NULL,1,'stop looking for profiles for next 3 weeks'),(19,'30000','vyshak','c v ','','chennur',NULL,1,'1997-07-26','12:45:00',1,1,'1','mysore',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,1,0,2,NULL,1,NULL,2,'2026-05-28 11:44:09','2026-07-10 08:17:27',5,5,'9844085118',226,NULL,NULL,NULL,191,295,NULL,NULL,'',NULL,NULL,76,76,73,30.00,8.00,NULL,NULL,'2026-07-10 08:17:27','[{\"id\": \"1779972596795\", \"text\": \"requirement:job\", \"hidden\": false, \"staffid\": 5, \"profileid\": 19}]',162.56,'own house\nown shop\ngetting rents : 1.85,000/- pm',NULL,NULL,NULL,1,''),(20,'20198','Charan','','Muntimadugu','Muntimadugu',NULL,1,'1998-06-17','07:04:00',14,2,'11','Bangalore',NULL,NULL,NULL,67.00,3,0,0,1,0,0,0,0,0,2,NULL,1,NULL,2,'2026-06-13 10:36:33','2026-07-10 08:20:22',1,1,'7896541230',227,NULL,NULL,NULL,15,57,NULL,NULL,'charan123@gmail.com',NULL,NULL,86,86,NULL,95.00,15.00,NULL,NULL,'2026-07-10 08:20:22','[]',152.40,'3 own houses,\n2 cars,\n2Lakh/M rental income\n1 bike',NULL,NULL,NULL,1,'Plan Expired'),(21,'19721','Sanjitha','','','Krishnagiri',NULL,2,'2000-09-12','12:47:00',24,1,'11','BANGALORE',NULL,NULL,NULL,NULL,3,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,2,'2026-07-06 13:03:20','2026-07-10 08:17:27',5,NULL,'1234567890',247,NULL,NULL,NULL,298,299,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-10 08:17:27','[]',165.10,'Own House\nOwn shop',NULL,NULL,NULL,1,''),(22,'21243','Pratham','Santosh','','Chitlur',NULL,1,'1998-04-30','18:30:00',6,2,'3','Bangalore',NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,2,'2026-07-09 13:02:24','2026-07-09 13:08:37',5,NULL,'9113873341',250,NULL,NULL,NULL,300,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-09 13:02:24','[]',170.18,'Rented House (Comined Fabily)\n2 shops in Delhi,Given to rent Rs 1,25,000/- Per Month (Father\'s own Property)',NULL,NULL,NULL,1,''),(23,'21313','K V NIRANJAN GUPTA','','','KUNJETI',NULL,1,'1999-04-05','14:00:00',17,3,'4','MYSORE',NULL,NULL,NULL,NULL,3,0,0,0,0,0,0,0,0,2,NULL,1,NULL,2,'2026-07-10 07:19:47','2026-07-10 08:02:39',1,1,'9844425919',255,NULL,NULL,NULL,301,261,NULL,NULL,'',NULL,NULL,97,97,98,12.00,NULL,NULL,NULL,'2026-07-10 07:47:10','[{\"id\": \"1783670554703\", \"text\": \"prefer only job\", \"hidden\": true, \"staffid\": 1, \"profileid\": 23}]',177.80,'OWN HOUSE (40/60 HOUSE CONSTRUCTED IN HALF SITE)\n2 SITES IN BANGALORE',NULL,NULL,NULL,1,''),(24,'21008','Shreyas ','c r ','','Chitlur',NULL,1,'1996-11-17','12:29:00',22,4,'10','Bangalore',NULL,NULL,NULL,NULL,3,0,NULL,1,NULL,0,NULL,0,NULL,NULL,NULL,1,NULL,2,'2026-07-21 09:58:59','2026-07-21 09:59:47',5,NULL,'',260,NULL,NULL,NULL,300,302,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,12.00,NULL,NULL,'2026-07-21 09:58:59','[]',167.64,'Own House\nGetting rents rs 1,50,000 Per Month',NULL,NULL,NULL,1,''),(25,'21090 ','Satvik','Bhupal','','Bhupal',NULL,1,'1997-03-09','08:15:00',25,2,'11','Hospete',NULL,NULL,NULL,NULL,3,0,NULL,1,NULL,0,NULL,0,NULL,NULL,NULL,1,NULL,2,'2026-07-21 10:45:07','2026-07-21 10:47:35',5,NULL,'',264,NULL,NULL,NULL,174,303,NULL,NULL,'',NULL,NULL,100,101,NULL,NULL,5.00,NULL,NULL,'2026-07-21 10:47:35','[]',180.34,'40/60 House Building is under construction  in Hospet\n',NULL,NULL,NULL,1,''),(26,'21007','Shilpa','D N','','Doolipet',NULL,2,'2001-04-27','22:04:00',5,4,'3','Bangalore',NULL,NULL,NULL,NULL,3,0,NULL,0,NULL,1,NULL,0,NULL,NULL,NULL,1,NULL,2,'2026-07-21 11:11:25','2026-07-21 11:12:15',5,NULL,'',269,NULL,NULL,NULL,152,267,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-21 11:11:25','[]',160.02,'Own House (G+2)',NULL,NULL,NULL,1,''),(27,'20358','Dr PRATHIKSHA','B M','','',NULL,2,'1998-06-01','08:30:00',10,2,'5','',NULL,NULL,NULL,NULL,3,1,1,0,NULL,0,NULL,0,NULL,NULL,NULL,1,NULL,2,'2026-07-22 14:20:16','2026-07-22 14:22:14',5,NULL,'',275,NULL,NULL,NULL,297,301,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-22 14:20:16','[]',162.56,'oWN hOUSE',NULL,NULL,NULL,1,''),(28,'21019','Aisiri','C Harish','','Rokkam',NULL,2,'2001-06-05','23:28:00',18,1,'8','Davangere',NULL,NULL,NULL,NULL,3,0,0,1,0,0,0,0,0,NULL,NULL,1,NULL,2,'2026-08-03 13:09:06','2026-08-03 13:10:05',5,NULL,'',281,NULL,NULL,NULL,297,301,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-08-03 13:09:06','[]',154.94,'Own House',NULL,NULL,NULL,1,''),(29,'21020','Shivani','Vankadari','','Vankadari',NULL,2,'1996-01-07','08:31:00',8,1,'4','Bangalore',NULL,NULL,NULL,NULL,3,0,0,0,0,0,0,0,0,NULL,NULL,1,NULL,1,'2026-08-03 13:48:38','2026-08-03 13:49:58',5,NULL,'',284,NULL,NULL,NULL,297,304,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-08-03 13:48:38','[]',162.56,'Own House\nGetting Rents\n3 Sites in Bangalore',NULL,NULL,NULL,1,'');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profilestarpreference`
--

DROP TABLE IF EXISTS `profilestarpreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profilestarpreference` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profileid` int NOT NULL,
  `birthstar` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profileid` (`profileid`,`birthstar`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profilestarpreference`
--

LOCK TABLES `profilestarpreference` WRITE;
/*!40000 ALTER TABLE `profilestarpreference` DISABLE KEYS */;
INSERT INTO `profilestarpreference` VALUES (230,2,1),(231,2,2),(232,2,3),(233,2,4),(219,4,1),(220,4,2),(221,4,3),(222,4,4),(178,5,1),(179,5,2),(180,6,1),(181,6,3),(197,7,1),(198,7,2),(199,7,3),(200,7,4),(194,8,1),(195,8,2),(196,8,3),(281,9,1),(282,9,2),(234,10,1),(235,10,2),(246,13,2),(247,13,3),(248,13,4),(277,14,1),(278,14,2),(279,14,3),(280,14,4),(283,15,3),(285,18,1),(286,18,2),(284,18,4),(287,21,1),(291,21,12),(288,21,20),(289,21,22),(290,21,25);
/*!40000 ALTER TABLE `profilestarpreference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiletask`
--

DROP TABLE IF EXISTS `profiletask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiletask` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` varchar(50) DEFAULT NULL,
  `profileid` int NOT NULL,
  `description` text,
  `status` tinyint DEFAULT '1',
  `duedate` date DEFAULT NULL,
  `createdby` int DEFAULT NULL,
  `createdat` datetime DEFAULT CURRENT_TIMESTAMP,
  `reason` text,
  `interactionid` int unsigned DEFAULT NULL,
  `is_deleted` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_profile` (`profileid`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiletask`
--

LOCK TABLES `profiletask` WRITE;
/*!40000 ALTER TABLE `profiletask` DISABLE KEYS */;
INSERT INTO `profiletask` VALUES (1,NULL,7,'resume getting the matches after 2 months ',1,NULL,1,'2026-02-10 09:34:17',NULL,NULL,NULL),(2,NULL,7,'ssf',1,NULL,2,'2026-02-10 10:30:25',NULL,NULL,NULL),(3,NULL,7,'ok send thisupdate to profile 4',1,NULL,1,'2026-02-12 09:18:18',NULL,NULL,NULL),(4,NULL,7,'resume after 3 months',1,NULL,1,'2026-02-12 10:00:37',NULL,NULL,NULL),(5,NULL,8,'test',1,'2026-04-10',1,'2026-04-09 13:46:33',NULL,NULL,0),(6,NULL,8,'test follow up task',3,NULL,1,'2026-04-09 13:47:34','test completed and successfull',38,1),(7,NULL,4,'inform profile number 12 that profile number 4 have liked your profile and interested to proceed further for the first meeting',1,NULL,3,'2026-04-11 08:57:45',NULL,39,0),(8,NULL,14,'send more profiles',1,'2026-04-14',3,'2026-04-13 06:26:12',NULL,NULL,0),(9,NULL,12,'arrange for first meeting with profile number 7',3,'2026-04-13',3,'2026-04-13 06:46:27','change in the profile to be met with',NULL,1),(10,NULL,12,'arrange for the first meeting with profile number 4',1,'2026-04-13',3,'2026-04-13 06:51:12',NULL,NULL,0),(11,NULL,4,'inform about the meeting arranged with profile number 12 rohith sharma',1,'2026-04-13',3,'2026-04-13 06:53:08',NULL,NULL,0),(12,NULL,15,'send more profiles',3,'2026-04-14',1,'2026-04-13 07:12:20','sent profiles',40,0),(13,NULL,15,'send this girl profile to them',1,NULL,1,'2026-04-13 07:21:43',NULL,42,0),(14,NULL,15,'testttt',1,NULL,1,'2026-04-29 10:39:24',NULL,53,0),(15,NULL,16,'share more profiles with 19016',1,NULL,1,'2026-05-03 13:46:25',NULL,54,0),(16,NULL,16,'test follow-up task',1,NULL,2,'2026-05-06 09:31:25',NULL,55,0),(17,NULL,12,'liked proile number 19009',1,'2026-05-08',2,'2026-05-07 08:21:43',NULL,NULL,0),(18,NULL,9,'inform this profile that 19012 liked your profile',1,'2026-05-08',2,'2026-05-07 08:22:21',NULL,NULL,0),(19,NULL,9,'inform 19012 that 19009 liked your profile',1,NULL,2,'2026-05-07 08:24:17',NULL,56,0),(20,NULL,14,'inform 19008 that 19014 liked your profile',1,NULL,2,'2026-05-07 08:35:31',NULL,57,0),(21,NULL,16,'test1123',3,NULL,1,'2026-05-07 08:52:53','tteest',58,0),(22,NULL,14,'test 443',1,'2026-05-08',1,'2026-05-07 08:53:29',NULL,NULL,0),(23,NULL,14,'adding task from profile. send photos.',1,'2026-05-09',1,'2026-05-07 08:54:49',NULL,NULL,0),(24,NULL,10,'follow-up with matching horoscopes.',1,'2026-05-11',1,'2026-05-07 08:56:29',NULL,NULL,0),(25,NULL,14,'Will task get added???',1,NULL,1,'2026-05-11 10:57:06',NULL,60,0),(26,NULL,13,'share more profiles',1,NULL,1,'2026-05-11 11:17:47',NULL,61,0),(27,NULL,16,'send profile to 19014',1,NULL,1,'2026-05-11 11:39:52',NULL,NULL,0),(28,NULL,8,'testing add task',1,'2026-05-12',1,'2026-05-11 17:19:49',NULL,NULL,0),(29,NULL,17,'CALL AND GET INFORMATION',1,NULL,1,'2026-05-28 06:54:24','THEY ARE NOT INTERESTED.',66,0),(30,NULL,17,'call',3,'2026-05-29',1,'2026-05-28 11:20:18','they told no',NULL,0),(31,NULL,19,'requirements: job, business abroad',1,'2026-05-28',5,'2026-05-28 12:42:33',NULL,NULL,0),(32,NULL,19,'call 20600',1,'2026-05-30',5,'2026-05-29 12:23:36','they told no',NULL,0),(33,NULL,20,'send more female profiles with the occupation as software engineer',1,NULL,1,'2026-06-16 17:49:21',NULL,69,0);
/*!40000 ALTER TABLE `profiletask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stars`
--

DROP TABLE IF EXISTS `stars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `starname` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stars`
--

LOCK TABLES `stars` WRITE;
/*!40000 ALTER TABLE `stars` DISABLE KEYS */;
INSERT INTO `stars` VALUES (1,'Ashwini'),(2,'Bharani'),(3,'Krittika'),(4,'Rohini'),(5,'Mrigashira'),(6,'Ardra'),(7,'Punarvasu'),(8,'Pushya'),(9,'Ashlesha'),(10,'Magha'),(11,'PurvaPhalguni'),(12,'UttaraPhalguni'),(13,'Hasta'),(14,'Chitra'),(15,'Swati'),(16,'Vishakha'),(17,'Anuradha'),(18,'Jyeshtha'),(19,'Mula'),(20,'Purvashada'),(21,'Uttarashada'),(22,'Shravana'),(23,'Dhanishtha'),(24,'Shatabhishak'),(25,'PurvaBhadrapada'),(26,'UttaraBhadrapada'),(27,'Revati');
/*!40000 ALTER TABLE `stars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `role` tinyint unsigned NOT NULL DEFAULT '1',
  `orgid` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'f@r.com.test','$2b$10$iQIEpke.bhAjAgtW.bNA/ujuEpWOLIZmDA0j7U.KAM6IX.56l41Ee','ACTIVE','2026-01-06 10:56:21','2026-01-24 19:07:12',99,1),(2,'r@f.com.test','$2b$10$MAx0N78p81KWibTyIyi2xeogGkpslpZMMRp42PUWaBR2m.G6Rhvh2','ACTIVE','2026-01-07 02:46:37','2026-01-24 19:07:12',1,1),(3,'user3@gmail.com','$2b$10$fq.VEztg36UQFm8SyEWr1.zLweAbbuwhW9Z2DuSxrvBsnnsh3Ulna','ACTIVE','2026-04-11 08:49:59','2026-04-13 08:15:08',1,1),(4,'karthik26.user@gmail.com','$2b$10$SaXpvbeOwQ2lp2/2OaNu0uTzdh93yTQjgk64iHl4l44TLc/Zv6yV6','ACTIVE','2026-05-15 15:47:14','2026-05-15 15:47:14',1,1),(5,'cv.vyshak@gmail.com','$2b$10$NBqaRGuNuYfgGAwalgduWufhb7/kkey9wmLoQ9GDpan7RRBh4PNgC','ACTIVE','2026-05-28 10:45:39','2026-05-28 10:45:39',1,1),(6,'test1@gmail.com','$2b$10$VIgxFp/8dXaUtTC6eMzdSuPcTYtlxGg2O5Pl2mmv4Djohi9eGy.HG','ACTIVE','2026-05-31 09:49:44','2026-06-17 08:06:20',1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'avvak'
--

--
-- Dumping routines for database 'avvak'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-05 14:20:17
