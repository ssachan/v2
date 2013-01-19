# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.25)
# Database: edu
# Generation Time: 2013-01-19 20:41:36 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET ascii DEFAULT NULL,
  `password` varchar(20) CHARACTER SET ascii DEFAULT NULL,
  `firstName` varchar(20) CHARACTER SET ascii DEFAULT NULL,
  `lastName` varchar(20) CHARACTER SET ascii DEFAULT NULL,
  `email` varchar(40) CHARACTER SET ascii DEFAULT NULL,
  `roles` text,
  `createdOn` datetime DEFAULT NULL,
  `verifiedOn` datetime DEFAULT NULL,
  `lastsignedinOn` datetime DEFAULT NULL,
  `deletedOn` datetime DEFAULT NULL,
  `suspendedOn` datetime DEFAULT NULL,
  `resetsentOn` datetime DEFAULT NULL,
  `pics` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;

INSERT INTO `accounts` (`id`, `username`, `password`, `firstName`, `lastName`, `email`, `roles`, `createdOn`, `verifiedOn`, `lastsignedinOn`, `deletedOn`, `suspendedOn`, `resetsentOn`, `pics`)
VALUES
	(1,NULL,'himanshu','Himanshu','Bhutani','him.bhutani@gmail.com','3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,NULL,'ashwin','Ashwin','M','ashwin.rsmd@gmail.com','3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,NULL,'tanuj','Tanuj','Bhojwani','tanuj.bhojwani@gmail.com','3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,NULL,'aa','aa','aa','a@a.com',NULL,'2012-12-28 20:42:09',NULL,NULL,NULL,NULL,NULL,NULL),
	(5,NULL,'123456','aa','aa','aa@aa.com',NULL,'2012-12-31 11:09:00',NULL,NULL,NULL,NULL,NULL,NULL),
	(6,NULL,'anirban','Anirban','Naskar','anirbanaskar@gmail.com','3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,'arpit','demo1234','Arpit','Agarwal','arpit@tlabs.in','3','2012-12-31 11:09:00',NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table accounts_fb
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accounts_fb`;

CREATE TABLE `accounts_fb` (
  `accountId` int(11) NOT NULL,
  `facebookId` bigint(20) DEFAULT NULL,
  `linkedOn` datetime DEFAULT NULL,
  `bio` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `education` text,
  `firstName` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastName` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `pictures` text,
  `quotes` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `work` text,
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table accounts_google
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accounts_google`;

CREATE TABLE `accounts_google` (
  `accountId` int(11) DEFAULT NULL,
  `googleId` int(25) DEFAULT NULL,
  `familyName` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `givenName` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `verifiedEmail` int(1) DEFAULT NULL,
  `linkedOn` datetime DEFAULT NULL,
  KEY `accountId` (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ascores_l1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l1`;

CREATE TABLE `ascores_l1` (
  `accountId` int(11) DEFAULT NULL,
  `score` float DEFAULT '0',
  `updatedOn` datetime DEFAULT NULL,
  `l1Id` int(11) DEFAULT NULL,
  `numQuestions` int(11) DEFAULT NULL,
  `numCorrect` int(11) DEFAULT NULL,
  `numIncorrect` int(11) DEFAULT NULL,
  `numUnattempted` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ascores_l1` WRITE;
/*!40000 ALTER TABLE `ascores_l1` DISABLE KEYS */;

INSERT INTO `ascores_l1` (`accountId`, `score`, `updatedOn`, `l1Id`, `numQuestions`, `numCorrect`, `numIncorrect`, `numUnattempted`, `streamId`)
VALUES
	(4,10,'2013-01-08 00:00:00',1,0,0,0,0,1),
	(4,83.0433,'2013-01-20 00:31:55',2,388,17,43,328,1),
	(4,49.9487,'2013-01-19 22:05:25',3,201,0,30,171,1),
	(7,55.0548,'0000-00-00 00:00:00',1,10,4,6,0,1),
	(7,48.7134,'0000-00-00 00:00:00',2,10,3,7,0,1),
	(7,55.9434,'2013-01-18 17:33:34',3,30,7,4,19,1),
	(7,56.0734,'0000-00-00 00:00:00',4,10,0,10,0,1),
	(7,55.3601,'0000-00-00 00:00:00',5,10,2,8,0,1),
	(7,58.6417,'0000-00-00 00:00:00',6,10,2,8,0,1);

/*!40000 ALTER TABLE `ascores_l1` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ascores_l2
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l2`;

CREATE TABLE `ascores_l2` (
  `accountId` int(11) DEFAULT NULL,
  `score` float DEFAULT '0',
  `updatedOn` datetime DEFAULT NULL,
  `l2Id` int(11) DEFAULT NULL,
  `numQuestions` int(11) DEFAULT NULL,
  `numCorrect` int(11) DEFAULT NULL,
  `numIncorrect` int(11) DEFAULT NULL,
  `numUnattempted` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ascores_l2` WRITE;
/*!40000 ALTER TABLE `ascores_l2` DISABLE KEYS */;

INSERT INTO `ascores_l2` (`accountId`, `score`, `updatedOn`, `l2Id`, `numQuestions`, `numCorrect`, `numIncorrect`, `numUnattempted`, `streamId`)
VALUES
	(4,10,'2013-01-08 00:00:00',1,0,0,0,0,1),
	(4,74.9167,'2013-01-19 22:04:57',7,149,12,16,121,1),
	(4,58.3,'2013-01-20 00:31:55',6,209,5,27,177,1),
	(4,50,'2013-01-20 00:31:54',5,30,0,0,30,1),
	(4,49.8462,'2013-01-19 22:05:25',10,201,0,30,171,1),
	(7,54.5,'0000-00-00 00:00:00',1,10,7,3,0,1),
	(7,58.6,'0000-00-00 00:00:00',2,10,9,1,0,1),
	(7,52.2857,'0000-00-00 00:00:00',3,10,1,9,0,1),
	(7,54.8334,'0000-00-00 00:00:00',4,10,8,2,0,1),
	(7,42.6,'0000-00-00 00:00:00',5,10,1,9,0,1),
	(7,54.8,'0000-00-00 00:00:00',6,10,7,3,0,1),
	(7,44.6668,'0000-00-00 00:00:00',7,10,0,10,0,1),
	(7,52,'0000-00-00 00:00:00',8,10,8,2,0,1),
	(7,49.5,'0000-00-00 00:00:00',9,10,10,0,0,1),
	(7,60.5385,'2013-01-18 17:33:34',10,30,9,2,19,1),
	(7,62.6668,'0000-00-00 00:00:00',11,10,1,9,0,1),
	(7,44.625,'0000-00-00 00:00:00',12,10,8,2,0,1),
	(7,49.8,'0000-00-00 00:00:00',13,10,7,3,0,1),
	(7,58.4,'0000-00-00 00:00:00',14,10,6,4,0,1),
	(7,65.1668,'0000-00-00 00:00:00',15,10,8,2,0,1),
	(7,63,'0000-00-00 00:00:00',16,10,1,9,0,1),
	(7,44,'0000-00-00 00:00:00',17,10,3,7,0,1),
	(7,51.25,'0000-00-00 00:00:00',18,10,1,9,0,1),
	(7,64,'0000-00-00 00:00:00',19,10,4,6,0,1),
	(7,58.8571,'0000-00-00 00:00:00',20,10,10,0,0,1),
	(7,47.3333,'0000-00-00 00:00:00',21,10,6,4,0,1),
	(7,34.6666,'0000-00-00 00:00:00',22,10,1,9,0,1),
	(7,82,'0000-00-00 00:00:00',23,10,5,5,0,1),
	(7,53.3333,'0000-00-00 00:00:00',24,10,0,10,0,1),
	(7,62,'0000-00-00 00:00:00',25,10,9,1,0,1),
	(7,60.1668,'0000-00-00 00:00:00',26,10,10,0,0,1),
	(7,63.25,'0000-00-00 00:00:00',27,10,7,3,0,1),
	(7,67.9999,'0000-00-00 00:00:00',28,10,1,9,0,1),
	(7,57.9999,'0000-00-00 00:00:00',29,10,6,4,0,1),
	(7,52.5,'0000-00-00 00:00:00',30,10,5,5,0,1),
	(7,52.5,'0000-00-00 00:00:00',31,10,2,8,0,1);

/*!40000 ALTER TABLE `ascores_l2` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ascores_l3
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l3`;

CREATE TABLE `ascores_l3` (
  `accountId` int(11) NOT NULL,
  `score` float NOT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `l3id` int(11) DEFAULT NULL,
  `numQuestions` int(11) DEFAULT NULL,
  `numCorrect` int(11) DEFAULT NULL,
  `numIncorrect` int(11) DEFAULT NULL,
  `numUnattempted` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ascores_l3` WRITE;
/*!40000 ALTER TABLE `ascores_l3` DISABLE KEYS */;

INSERT INTO `ascores_l3` (`accountId`, `score`, `updatedOn`, `l3id`, `numQuestions`, `numCorrect`, `numIncorrect`, `numUnattempted`, `streamId`)
VALUES
	(4,50,'0000-00-00 00:00:00',1,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',2,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',3,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',4,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',5,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',6,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',7,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',8,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',9,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',10,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',11,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',12,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',13,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',14,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',15,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',16,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',17,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',18,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',19,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',20,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',21,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',22,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',23,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',24,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',25,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',26,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',27,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',28,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',29,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',30,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',31,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',32,0,0,0,0,1),
	(4,50,'2013-01-20 00:31:54',33,30,0,0,30,1),
	(4,57,'2013-01-20 00:31:55',34,93,4,12,77,1),
	(4,54,'2013-01-20 00:31:54',35,116,1,15,100,1),
	(4,50,'0000-00-00 00:00:00',36,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',37,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',38,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',39,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',40,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',41,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',42,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',43,0,0,0,0,1),
	(4,46.5,'2013-01-19 22:04:57',44,39,0,15,24,1),
	(4,47,'2013-01-18 13:40:41',45,37,0,0,37,1),
	(4,74,'2013-01-18 13:40:41',46,37,12,1,24,1),
	(4,48,'2013-01-18 13:40:41',47,36,0,0,36,1),
	(4,50,'0000-00-00 00:00:00',48,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',49,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',50,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',51,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',52,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',53,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',54,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',55,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',56,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',57,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',58,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',59,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',60,0,0,0,0,1),
	(4,48,'2013-01-19 22:05:25',61,71,0,12,59,1),
	(4,50,'2013-01-19 22:05:25',62,50,0,9,41,1),
	(4,50,'2013-01-19 22:05:25',63,80,0,9,71,1),
	(4,50,'0000-00-00 00:00:00',64,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',65,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',66,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',67,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',68,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',69,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',70,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',71,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',72,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',73,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',74,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',75,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',76,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',77,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',78,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',79,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',80,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',81,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',82,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',83,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',84,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',85,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',86,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',87,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',88,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',89,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',90,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',91,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',92,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',93,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',94,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',95,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',96,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',97,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',98,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',99,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',100,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',101,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',102,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',103,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',104,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',105,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',106,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',107,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',108,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',109,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',110,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',111,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',112,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',113,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',114,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',115,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',116,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',117,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',118,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',119,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',120,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',121,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',122,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',123,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',124,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',125,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',126,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',127,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',128,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',129,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',130,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',131,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',132,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',133,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',134,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',135,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',136,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',137,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',138,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',139,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',140,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',141,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',142,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',143,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',144,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',145,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',146,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',147,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',148,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',149,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',150,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',151,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',152,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',153,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',154,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',155,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',156,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',157,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',158,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',159,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',160,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',161,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',162,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',163,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',164,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',165,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',166,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',167,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',168,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',169,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',170,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',171,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',172,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',173,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',174,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',175,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',176,0,0,0,0,1),
	(7,25,'2013-01-18 16:17:02',1,0,0,0,0,1),
	(7,64,'2013-01-18 16:17:02',2,0,0,0,0,1),
	(7,70,'2013-01-18 16:17:02',3,0,0,0,0,1),
	(7,22,'2013-01-18 16:17:02',4,0,0,0,0,1),
	(7,35,'2013-01-18 16:17:02',5,0,0,0,0,1),
	(7,81,'2013-01-18 16:17:02',6,0,0,0,0,1),
	(7,85,'2013-01-18 16:17:02',7,0,0,0,0,1),
	(7,81,'2013-01-18 16:17:02',8,0,0,0,0,1),
	(7,20,'2013-01-18 16:17:02',9,0,0,0,0,1),
	(7,62,'2013-01-18 16:17:02',10,0,0,0,0,1),
	(7,58,'2013-01-18 16:17:02',11,0,0,0,0,1),
	(7,52,'2013-01-18 16:17:02',12,0,0,0,0,1),
	(7,85,'2013-01-18 16:17:02',13,0,0,0,0,1),
	(7,61,'2013-01-18 16:17:02',14,0,0,0,0,1),
	(7,37,'2013-01-18 16:17:02',15,0,0,0,0,1),
	(7,75,'2013-01-18 16:17:02',16,0,0,0,0,1),
	(7,38,'2013-01-18 16:17:02',17,0,0,0,0,1),
	(7,76,'2013-01-18 16:17:02',18,0,0,0,0,1),
	(7,84,'2013-01-18 16:17:02',19,0,0,0,0,1),
	(7,47,'2013-01-18 16:17:02',20,0,0,0,0,1),
	(7,23,'2013-01-18 16:17:02',21,0,0,0,0,1),
	(7,23,'2013-01-18 16:17:02',22,0,0,0,0,1),
	(7,45,'2013-01-18 16:17:02',23,0,0,0,0,1),
	(7,82,'2013-01-18 16:17:02',24,0,0,0,0,1),
	(7,28,'2013-01-18 16:17:02',25,0,0,0,0,1),
	(7,83,'2013-01-18 16:17:02',26,0,0,0,0,1),
	(7,63,'2013-01-18 16:17:02',27,0,0,0,0,1),
	(7,28,'2013-01-18 16:17:02',28,0,0,0,0,1),
	(7,35,'2013-01-18 16:17:02',29,0,0,0,0,1),
	(7,36,'2013-01-18 16:17:02',30,0,0,0,0,1),
	(7,22,'2013-01-18 16:17:02',31,0,0,0,0,1),
	(7,40,'2013-01-18 16:17:02',32,0,0,0,0,1),
	(7,80,'2013-01-18 16:17:02',33,0,0,0,0,1),
	(7,73,'2013-01-18 16:17:02',34,0,0,0,0,1),
	(7,43,'2013-01-18 16:17:02',35,0,0,0,0,1),
	(7,24,'2013-01-18 16:17:02',36,0,0,0,0,1),
	(7,64,'2013-01-18 16:17:02',37,0,0,0,0,1),
	(7,37,'2013-01-18 16:17:02',38,0,0,0,0,1),
	(7,85,'2013-01-18 16:17:02',39,0,0,0,0,1),
	(7,64,'2013-01-18 16:17:02',40,0,0,0,0,1),
	(7,80,'2013-01-18 16:17:02',41,0,0,0,0,1),
	(7,53,'2013-01-18 16:17:02',42,0,0,0,0,1),
	(7,25,'2013-01-18 16:17:02',43,0,0,0,0,1),
	(7,74,'2013-01-18 16:17:02',44,0,0,0,0,1),
	(7,23,'2013-01-18 16:17:02',45,0,0,0,0,1),
	(7,43,'2013-01-18 16:17:02',46,0,0,0,0,1),
	(7,58,'2013-01-18 16:17:02',47,0,0,0,0,1),
	(7,42,'2013-01-18 16:17:02',48,0,0,0,0,1),
	(7,28,'2013-01-18 16:17:02',49,0,0,0,0,1),
	(7,52,'2013-01-18 16:17:02',50,0,0,0,0,1),
	(7,69,'2013-01-18 16:17:02',51,0,0,0,0,1),
	(7,32,'2013-01-18 16:17:02',52,0,0,0,0,1),
	(7,55,'2013-01-18 16:17:02',53,0,0,0,0,1),
	(7,24,'2013-01-18 16:17:02',54,0,0,0,0,1),
	(7,23,'2013-01-18 16:17:02',55,0,0,0,0,1),
	(7,64,'2013-01-18 16:17:02',56,0,0,0,0,1),
	(7,87,'2013-01-18 16:17:02',57,0,0,0,0,1),
	(7,67,'2013-01-18 16:17:02',58,0,0,0,0,1),
	(7,73,'2013-01-18 16:17:02',59,0,0,0,0,1),
	(7,31,'2013-01-18 16:17:02',60,0,0,0,0,1),
	(7,82,'2013-01-18 17:33:34',61,7,0,1,6,1),
	(7,76,'2013-01-18 17:33:34',62,5,0,0,5,1),
	(7,52,'2013-01-18 17:33:34',63,8,0,0,8,1),
	(7,72,'2013-01-18 16:17:02',64,0,0,0,0,1),
	(7,58,'2013-01-18 16:17:02',65,0,0,0,0,1),
	(7,75,'2013-01-18 16:17:02',66,0,0,0,0,1),
	(7,77,'2013-01-18 16:17:02',67,0,0,0,0,1),
	(7,31,'2013-01-18 16:17:02',68,0,0,0,0,1),
	(7,22,'2013-01-18 16:17:02',69,0,0,0,0,1),
	(7,71,'2013-01-18 16:17:02',70,0,0,0,0,1),
	(7,76,'2013-01-18 16:17:02',71,0,0,0,0,1),
	(7,82,'2013-01-18 16:17:02',72,0,0,0,0,1),
	(7,33,'2013-01-18 16:17:02',73,0,0,0,0,1),
	(7,82,'2013-01-18 16:17:02',74,0,0,0,0,1),
	(7,66,'2013-01-18 16:17:02',75,0,0,0,0,1),
	(7,37,'2013-01-18 16:17:02',76,0,0,0,0,1),
	(7,34,'2013-01-18 16:17:02',77,0,0,0,0,1),
	(7,33,'2013-01-18 16:17:02',78,0,0,0,0,1),
	(7,59,'2013-01-18 16:17:02',79,0,0,0,0,1),
	(7,42,'2013-01-18 16:17:02',80,0,0,0,0,1),
	(7,66,'2013-01-18 16:17:02',81,0,0,0,0,1),
	(7,38,'2013-01-18 16:17:02',82,0,0,0,0,1),
	(7,55,'2013-01-18 16:17:02',83,0,0,0,0,1),
	(7,30,'2013-01-18 16:17:02',84,0,0,0,0,1),
	(7,42,'2013-01-18 16:17:02',85,0,0,0,0,1),
	(7,58,'2013-01-18 16:17:02',86,0,0,0,0,1),
	(7,75,'2013-01-18 16:17:02',87,0,0,0,0,1),
	(7,39,'2013-01-18 16:17:02',88,0,0,0,0,1),
	(7,35,'2013-01-18 16:17:02',89,0,0,0,0,1),
	(7,58,'2013-01-18 16:17:02',90,0,0,0,0,1),
	(7,51,'2013-01-18 16:17:02',91,0,0,0,0,1),
	(7,28,'2013-01-18 16:17:02',92,0,0,0,0,1),
	(7,43,'2013-01-18 16:17:02',93,0,0,0,0,1),
	(7,84,'2013-01-18 16:17:02',94,0,0,0,0,1),
	(7,81,'2013-01-18 16:17:02',95,0,0,0,0,1),
	(7,82,'2013-01-18 16:17:02',96,0,0,0,0,1),
	(7,68,'2013-01-18 16:17:02',97,0,0,0,0,1),
	(7,67,'2013-01-18 16:17:02',98,0,0,0,0,1),
	(7,22,'2013-01-18 16:17:02',99,0,0,0,0,1),
	(7,71,'2013-01-18 16:17:02',100,0,0,0,0,1),
	(7,48,'2013-01-18 16:17:02',101,0,0,0,0,1),
	(7,79,'2013-01-18 16:17:02',102,0,0,0,0,1),
	(7,62,'2013-01-18 16:17:02',103,0,0,0,0,1),
	(7,61,'2013-01-18 16:17:02',104,0,0,0,0,1),
	(7,70,'2013-01-18 16:17:02',105,0,0,0,0,1),
	(7,38,'2013-01-18 16:17:02',106,0,0,0,0,1),
	(7,79,'2013-01-18 16:17:02',107,0,0,0,0,1),
	(7,84,'2013-01-18 16:17:02',108,0,0,0,0,1),
	(7,51,'2013-01-18 16:17:02',109,0,0,0,0,1),
	(7,47,'2013-01-18 16:17:02',110,0,0,0,0,1),
	(7,36,'2013-01-18 16:17:02',111,0,0,0,0,1),
	(7,27,'2013-01-18 16:17:02',112,0,0,0,0,1),
	(7,66,'2013-01-18 16:17:02',113,0,0,0,0,1),
	(7,71,'2013-01-18 16:17:02',114,0,0,0,0,1),
	(7,38,'2013-01-18 16:17:02',115,0,0,0,0,1),
	(7,88,'2013-01-18 16:17:02',116,0,0,0,0,1),
	(7,39,'2013-01-18 16:17:02',117,0,0,0,0,1),
	(7,22,'2013-01-18 16:17:02',118,0,0,0,0,1),
	(7,37,'2013-01-18 16:17:02',119,0,0,0,0,1),
	(7,55,'2013-01-18 16:17:02',120,0,0,0,0,1),
	(7,60,'2013-01-18 16:17:02',121,0,0,0,0,1),
	(7,69,'2013-01-18 16:17:02',122,0,0,0,0,1),
	(7,63,'2013-01-18 16:17:02',123,0,0,0,0,1),
	(7,84,'2013-01-18 16:17:02',124,0,0,0,0,1),
	(7,62,'2013-01-18 16:17:02',125,0,0,0,0,1),
	(7,54,'2013-01-18 16:17:02',126,0,0,0,0,1),
	(7,75,'2013-01-18 16:17:02',127,0,0,0,0,1),
	(7,39,'2013-01-18 16:17:02',128,0,0,0,0,1),
	(7,31,'2013-01-18 16:17:02',129,0,0,0,0,1),
	(7,78,'2013-01-18 16:17:02',130,0,0,0,0,1),
	(7,90,'2013-01-18 16:17:02',131,0,0,0,0,1),
	(7,59,'2013-01-18 16:17:02',132,0,0,0,0,1),
	(7,66,'2013-01-18 16:17:02',133,0,0,0,0,1),
	(7,62,'2013-01-18 16:17:02',134,0,0,0,0,1),
	(7,30,'2013-01-18 16:17:02',135,0,0,0,0,1),
	(7,46,'2013-01-18 16:17:02',136,0,0,0,0,1),
	(7,80,'2013-01-18 16:17:02',137,0,0,0,0,1),
	(7,89,'2013-01-18 16:17:02',138,0,0,0,0,1),
	(7,39,'2013-01-18 16:17:02',139,0,0,0,0,1),
	(7,41,'2013-01-18 16:17:02',140,0,0,0,0,1),
	(7,46,'2013-01-18 16:17:02',141,0,0,0,0,1),
	(7,55,'2013-01-18 16:17:02',142,0,0,0,0,1),
	(7,48,'2013-01-18 16:17:02',143,0,0,0,0,1),
	(7,21,'2013-01-18 16:17:02',144,0,0,0,0,1),
	(7,35,'2013-01-18 16:17:02',145,0,0,0,0,1),
	(7,66,'2013-01-18 16:17:02',146,0,0,0,0,1),
	(7,90,'2013-01-18 16:17:02',147,0,0,0,0,1),
	(7,55,'2013-01-18 16:17:02',148,0,0,0,0,1),
	(7,69,'2013-01-18 16:17:02',149,0,0,0,0,1),
	(7,36,'2013-01-18 16:17:02',150,0,0,0,0,1),
	(7,90,'2013-01-18 16:17:02',151,0,0,0,0,1),
	(7,39,'2013-01-18 16:17:02',152,0,0,0,0,1),
	(7,85,'2013-01-18 16:17:02',153,0,0,0,0,1),
	(7,63,'2013-01-18 16:17:02',154,0,0,0,0,1),
	(7,33,'2013-01-18 16:17:02',155,0,0,0,0,1),
	(7,57,'2013-01-18 16:17:02',156,0,0,0,0,1),
	(7,26,'2013-01-18 16:17:02',157,0,0,0,0,1),
	(7,88,'2013-01-18 16:17:02',158,0,0,0,0,1),
	(7,76,'2013-01-18 16:17:02',159,0,0,0,0,1),
	(7,38,'2013-01-18 16:17:02',160,0,0,0,0,1),
	(7,76,'2013-01-18 16:17:02',161,0,0,0,0,1),
	(7,76,'2013-01-18 16:17:02',162,0,0,0,0,1),
	(7,77,'2013-01-18 16:17:02',163,0,0,0,0,1),
	(7,52,'2013-01-18 16:17:02',164,0,0,0,0,1),
	(7,48,'2013-01-18 16:17:02',165,0,0,0,0,1),
	(7,88,'2013-01-18 16:17:02',166,0,0,0,0,1),
	(7,78,'2013-01-18 16:17:02',167,0,0,0,0,1),
	(7,38,'2013-01-18 16:17:02',168,0,0,0,0,1),
	(7,87,'2013-01-18 16:17:02',169,0,0,0,0,1),
	(7,27,'2013-01-18 16:17:02',170,0,0,0,0,1),
	(7,60,'2013-01-18 16:17:02',171,0,0,0,0,1),
	(7,43,'2013-01-18 16:17:02',172,0,0,0,0,1),
	(7,62,'2013-01-18 16:17:02',173,0,0,0,0,1),
	(7,88,'2013-01-18 16:17:02',174,0,0,0,0,1),
	(7,44,'2013-01-18 16:17:02',175,0,0,0,0,1),
	(7,78,'2013-01-18 16:17:02',176,0,0,0,0,1);

/*!40000 ALTER TABLE `ascores_l3` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table creditHistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `creditHistory`;

CREATE TABLE `creditHistory` (
  `accountId` int(11) DEFAULT NULL,
  `refilledOn` timestamp NULL DEFAULT NULL,
  `creditsAdded` int(11) DEFAULT NULL,
  KEY `accountId` (`accountId`),
  CONSTRAINT `credithistory_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table devices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `devices`;

CREATE TABLE `devices` (
  `accountId` int(11) DEFAULT NULL,
  `deviceId` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `deviceName` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `devicePlatform` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `deviceVersion` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exams
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exams`;

CREATE TABLE `exams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayName` varchar(50) DEFAULT NULL,
  `fullName` varchar(200) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `streamId` (`streamId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;

INSERT INTO `exams` (`id`, `displayName`, `fullName`, `streamId`)
VALUES
	(1,NULL,NULL,NULL);

/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fac_contact
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fac_contact`;

CREATE TABLE `fac_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `about` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table faculty
# ------------------------------------------------------------

DROP TABLE IF EXISTS `faculty`;

CREATE TABLE `faculty` (
  `l1Ids` text,
  `l2Ids` text,
  `specialization` varchar(20) DEFAULT NULL,
  `bioShort` varchar(120) DEFAULT NULL,
  `bio` text,
  `experience` text,
  `education` text,
  `streamIds` varchar(50) DEFAULT NULL,
  `totalQuizzes` int(5) DEFAULT '0',
  `rec` int(11) DEFAULT '0',
  `subscribers` int(11) DEFAULT '0',
  `accountId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;

INSERT INTO `faculty` (`l1Ids`, `l2Ids`, `specialization`, `bioShort`, `bio`, `experience`, `education`, `streamIds`, `totalQuizzes`, `rec`, `subscribers`, `accountId`)
VALUES
	('3','',NULL,'Physical Chemistry Specialist; B. Tech, IIT Guwahati','Himanshu is a specialist in Physical Chemistry. He completed his B.Tech. from IIT Guwahati in Chemical Engineering. With a combined coaching experience of 3 years, multiple All India Ranks (AIR) under 100 have had the  opportunity to study key physical chemistry concepts with him','Physical Chemistry - 3 years','B. Tech., IIT Guwahati, 2009','1',0,0,0,1),
	('2','',NULL,'Physics Faculty at Kartikkey Classes;  IIT Madras','Ashwin is a B. Tech. from IIT Madras. He specializes in Physics and is a founding member at Kartikkey classes. His unique approach to teaching physics has got him excellent reviews from all students','Co-founder, Physics faculty - Kartikkey Classes','B. Tech., IIT Madras, 2010','1',0,0,0,2),
	('2','',NULL,'Physics Faculty at Rise Institute','Tanuj Bhojwani is an IIT Bombay alumnus, and has co-founded the first IIT-JEE training institute in Kashmir: Rise Institute. Though he is a chemical engineer, his area of expertise is physics','Co-founder, Rise Institute','B. Tech., IIT Bombay, 2010','1',0,0,0,3),
	('2',NULL,NULL,'Physics Faculty at Education Helpline',NULL,NULL,'B. Tech., IIT Delhi, 2010','1',0,0,0,6),
	('3','',NULL,'Physical Chemistry Specialist; B. Tech, IIT Guwahati','Himanshu is a specialist in Physical Chemistry. He completed his B.Tech. from IIT Guwahati in Chemical Engineering. With a combined coaching experience of 3 years, multiple All India Ranks (AIR) under 100 have had the  opportunity to study key physical chemistry concepts with him','Physical Chemistry - 3 years','B. Tech., IIT Guwahati, 2009','1',0,0,0,1),
	('2','',NULL,'Physics Faculty at Kartikkey Classes;  IIT Madras','Professor Ashwin is a Physics teacher who has been active in the coaching industry for the last 3 years. He is a B.Tech from IIT Madras in Electrical Engineering. Originally hailing from Chennai, he is the co-founder of Kartikkey Classes in Delhi and his students say he has the most innovative way to teach Physics concepts\n\n','Not satisfied with a corporate career, Ashwin returned to his roots to take up teaching. As a teacher of engineering entrance, he specializes in physics - with a focus on mechanics and electricity. \nHe co-founded Kartikkey classes with Prof Vinod Aagrawal and Prof Rajesh Ramrakhyani and was the head of physics there. His aptitude and sincerity for teaching and mentoring students has to be seen to be believed','Ashwin did his schooling primarily in Chennai itself - he was a topper throughout his school years. Having obtained a rank of 700 in the IIT JEE, he opted for a course in Electrical Engineering at IIT Madras. At the institute, he was a prolific performer and published 2 papers in his final year.','1',0,0,0,2),
	('2','',NULL,'Physics Faculty at Rise Institute','Tanuj Bhojwani is an IIT Bombay alumnus, and has co-founded the first IIT-JEE training institute in Kashmir: Rise Institute. Though he is a chemical engineer, his area of expertise is physics','Co-founder, Rise Institute','B. Tech., IIT Bombay, 2010','1',0,0,0,3),
	('2',NULL,NULL,'Physics Faculty at Education Helpline',NULL,NULL,'B. Tech., IIT Delhi, 2010','1',0,0,0,6);

/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table insight_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `insight_type`;

CREATE TABLE `insight_type` (
  `id` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `insight_type` WRITE;
/*!40000 ALTER TABLE `insight_type` DISABLE KEYS */;

INSERT INTO `insight_type` (`id`, `type`)
VALUES
	(1,'post-test'),
	(2,'dashboard'),
	(3,'analytics');

/*!40000 ALTER TABLE `insight_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table insights
# ------------------------------------------------------------

DROP TABLE IF EXISTS `insights`;

CREATE TABLE `insights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `insights` WRITE;
/*!40000 ALTER TABLE `insights` DISABLE KEYS */;

INSERT INTO `insights` (`id`, `text`, `typeId`)
VALUES
	(1,'Your accuracy was very low while you utilized less than half the time. Focus more on accuracy than time',NULL),
	(2,'Give more time to the questions to improve on your accuracy I <%num%>',NULL),
	(3,'You are doing excellent on the time strategy, work on improving accuracy in the extra time you save',NULL),
	(4,'Rockstar',NULL),
	(5,'Your accuracy was very low while you did not utilize all the time',NULL),
	(6,'Give more time to the questions to improve on your accuracy',NULL),
	(7,'You are doing good on the time strategy, work on improving accuracy in the extra time you save ',NULL),
	(8,'Rockstar',NULL),
	(9,'You need to work on improving your accuracy',NULL),
	(10,'There is still scope of improvement in the accuracy',NULL),
	(11,'Your time strategy seems to be working, get your accuracy up there too',NULL),
	(12,'You are doing well on both time and accuracy. Lets give you a tougher challenge',NULL),
	(13,'Get back to concepts',NULL),
	(14,'Better time strategy will help you pick easier questions and improve your accuracy',NULL),
	(15,'Better time strategy will help you pick easier questions and improve your accuracy',NULL),
	(16,'While you did well, you could have picked a better set of questions to answers if you managed time well',NULL),
	(17,'Easy questions you did not attempt',NULL),
	(18,'Easy questions you got wrong',NULL),
	(19,'Difficult questions you got right',NULL),
	(20,'Wasted time on calculation based questions',NULL),
	(21,'You toggled too many times between the options and got it wrong',NULL),
	(22,'You toggled too many times between the options but eventually got it wrong',NULL);

/*!40000 ALTER TABLE `insights` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table package_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `package_type`;

CREATE TABLE `package_type` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `package_type` WRITE;
/*!40000 ALTER TABLE `package_type` DISABLE KEYS */;

INSERT INTO `package_type` (`id`, `name`)
VALUES
	(1,'Basic'),
	(2,'Custom');

/*!40000 ALTER TABLE `package_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table packages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `packages`;

CREATE TABLE `packages` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `details` text,
  `poolId` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;

INSERT INTO `packages` (`id`, `name`, `details`, `poolId`, `price`, `streamId`)
VALUES
	(1,'All Tests','5|:2',1,500,1);

/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table para
# ------------------------------------------------------------

DROP TABLE IF EXISTS `para`;

CREATE TABLE `para` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text,
  `questionIds` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'question ids separated by ||',
  `questionCount` int(2) DEFAULT NULL,
  `resources` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `l3Id` int(11) DEFAULT NULL,
  `difficulty` int(1) DEFAULT NULL,
  `mobileFlag` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `para` WRITE;
/*!40000 ALTER TABLE `para` DISABLE KEYS */;

INSERT INTO `para` (`id`, `text`, `questionIds`, `questionCount`, `resources`, `l3Id`, `difficulty`, `mobileFlag`)
VALUES
	(1,'<p>Two blocks \\\'A\\\' and \\\'B\\\' of mass \\\'m\\\' and \\\'2m\\\' kgs respectively are connected by a light spring and placed on a smooth horizontal surface. The blocks are now pressed towards each other so that the compression in the spring is \\\'x\\\' and then released. </p><img src=\"../api/resources/questions/37img1.jpg\" height = \"200\">','37|:38',2,'../api/resources/questions/p1img1.jpg',34,2,NULL),
	(2,'<p>A block A of mass 8kg is moving towards the right with a speed of 3m/s on a horizontal frictionless surface. Another block B of mass 4kg with a spring (massless, k = 50000/12 Nm<sup>-1</sup>) attached to it, is moving towards left with speed 2m/s. At some instant, A collides with the spring attached to B. After some time, the spring has maximum compression and then the blocks move independently with their final velocities.</p><img src=\"../api/resources/questions/p1img1.jpg\" height = \"200\"><p>Take the direction towards right as +ve x direction. Assume spring force is conservative and no kinetic energy is converted to internal energy of spring in the form of heat. Assume no sound is generated on collision.</p>','51|:52|:53|:54|:55|:56',7,'../api/resources/questions/p2img1.jpg',34,2,NULL);

/*!40000 ALTER TABLE `para` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pool
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pool`;

CREATE TABLE `pool` (
  `id` int(11) DEFAULT NULL,
  `quizIds` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pool` WRITE;
/*!40000 ALTER TABLE `pool` DISABLE KEYS */;

INSERT INTO `pool` (`id`, `quizIds`)
VALUES
	(1,'1|:2|:3');

/*!40000 ALTER TABLE `pool` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table purchases
# ------------------------------------------------------------

DROP TABLE IF EXISTS `purchases`;

CREATE TABLE `purchases` (
  `accountId` int(11) NOT NULL,
  `packageId` int(11) NOT NULL,
  `purchasedOn` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table question_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question_tags`;

CREATE TABLE `question_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `question_tags` WRITE;
/*!40000 ALTER TABLE `question_tags` DISABLE KEYS */;

INSERT INTO `question_tags` (`id`, `name`)
VALUES
	(1,'lengthy'),
	(2,'calculations');

/*!40000 ALTER TABLE `question_tags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table question_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question_type`;

CREATE TABLE `question_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `question_type` WRITE;
/*!40000 ALTER TABLE `question_type` DISABLE KEYS */;

INSERT INTO `question_type` (`id`, `type`)
VALUES
	(1,'single-option'),
	(2,'multiple-option'),
	(3,'integer-answer'),
	(4,'matrix-type');

/*!40000 ALTER TABLE `question_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table questions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text,
  `options` text COMMENT 'options separated by ''||''',
  `correctAnswer` varchar(100) DEFAULT NULL,
  `explanation` text COMMENT 'information on options separated by ''||''',
  `l3Id` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `tagIds` varchar(30) DEFAULT NULL,
  `difficulty` int(1) DEFAULT '0',
  `paraId` int(11) DEFAULT NULL,
  `resources` text,
  `averageTimeCorrect` int(2) DEFAULT '0',
  `averageTimeIncorrect` int(2) DEFAULT '0',
  `averageTimeUnattempted` int(2) DEFAULT '0',
  `averageCorrect` int(11) DEFAULT '0',
  `averageIncorrect` int(11) DEFAULT '0',
  `averageUnattempted` int(11) DEFAULT '0',
  `allotedTime` int(3) DEFAULT '0',
  `correctScore` int(2) DEFAULT '1',
  `incorrectScore` int(2) DEFAULT '0',
  `optionInCorrectScore` int(2) DEFAULT '0',
  `optionCorrectScore` int(2) DEFAULT '0',
  `unattemptedScore` int(2) DEFAULT '0',
  `mobileFlag` int(1) DEFAULT '0',
  `availableFlag` int(1) DEFAULT '0',
  `videoSrc` varchar(30) DEFAULT NULL,
  `posterSrc` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;

INSERT INTO `questions` (`id`, `text`, `options`, `correctAnswer`, `explanation`, `l3Id`, `typeId`, `tagIds`, `difficulty`, `paraId`, `resources`, `averageTimeCorrect`, `averageTimeIncorrect`, `averageTimeUnattempted`, `averageCorrect`, `averageIncorrect`, `averageUnattempted`, `allotedTime`, `correctScore`, `incorrectScore`, `optionInCorrectScore`, `optionCorrectScore`, `unattemptedScore`, `mobileFlag`, `availableFlag`, `videoSrc`, `posterSrc`)
VALUES
	(1,'<p>Two large vertical and parallel metal plates having a separation of 1 cm are connected to a DC voltage source of potential difference X. A proton is released at rest midway between the two plates. It is found to move at 45<sup>o</sup> to the vertical JUST after release. Then X is nearly</p>','1*10<sup>-5</sup> V |: 1*10<sup>-7</sup> V |: 1*10<sup>-9</sup> V |: 1*10<sup>-10</sup> V','2','<p>Writing the force equations on the particle,</p><img src = \"../api/resources/questions/1img1.jpg\"><p>mg = qE $$1.67 * 10^{-27} * (10) = (1.6 * 10^{-19})\\frac{x}{0.01}$$  $$x =\\frac{1.67 * 10^{-9}}{1.6}$$ $$x=1 * 10^{-9}V$$</p>',44,1,'',1,NULL,'../api/resources/questions/1img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(2,'<p>For the circuit given below which of the following is true:</p> <img src = \"../api/resources/questions/2img1.jpg\">','The current I through the battery is 7.5mA |: The potential difference across RL is 20V|: The ratios of power dissipated in R1 and R2 is 5 |:\n If R1 and R2 are interchanged, magnitude of power dissipated in RL will decrease by a factor of 3','0','<p>R<sub>2</sub> and R<sub>L</sub> are in parallel hence $$R_{2L} = \\frac{6 * 1.5}{6 + 1.5}$$\nR<sub>2L</sub> = 1.2 k~~\\Omega~~ <br>\nR<sub>2L</sub> in turn is in series with R<sub>1</sub> hence the resistance of the circuit is:<br>\nR = 1.2 + 2 = 3.2 k~~\\Omega~~ <br>\nThe current I through battery is $$ i= \\frac{24V}{3.2 * 1000\\Omega} = 7.5 mA $$</p>',45,1,'',2,NULL,'../api/resources/questions/2img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(3,'<img src = \"../api/resources/questions/3img1.jpg\"> <p> A meter bridge is set-up as shown, to determine an unknown resistance \'X\' using a standard 10 ohm resistor. The galvanometer shows null point when tapping-key is at 52 cm mark. The end-corrections are 1 cm and 2 cm respectively for the ends A and B.  The determined value of \'X\' is:</p>','10.2 ohm |: 10.6 ohm |:\n10.8 ohm |: 11.1 ohm','1','<p>$$\\frac{x}{10} = \\frac{l_1}{l_2}$$\nWhere l<sub>1</sub> and l<sub>2</sub> are the lengths with end corrections\nl<sub>1</sub> = 52 + 1 = 53 cm; l<sub>2</sub> = 48 + 2 = 50 cm$$\\frac{x}{10}=\\frac{53cm}{50cm}$$\nX = 10.6 ~~\\Omega~~</p>',46,1,'',1,NULL,'../api/resources/questions/3img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(4,'<p> A spherical metal A of radius R<sub>A</sub> and a solid metal sphere B of radius R<sub>B</sub> \n(< R<sub>A</sub>) are kept far apart and each is given charge \'+Q\'. Now a thin metal wire connects them. Which one of the following is false:</p>','E<sub>A</sub> (inside) = 0 |: Q<sub>A</sub> < Q<sub>B</sub> |: ~~\\sigma_A/ \\sigma_B~~ = R<sub>B</sub> / R<sub>A </sub>|: E<sub>A</sub> (on surface) < E<sub>B</sub> (on surface)','3','<p>E <sub>(inside)</sub> for metallic shell = 0 $$\\frac{Q_A}{4\\pi \\epsilon_oR_A} = \\frac{Q_B}{4\\pi \\epsilon_oR_B}$$ $$\\therefore\\frac{Q_A}{Q_B} = \\frac{R_A}{R_B}$$\nSince R<sub>A</sub> > R<sub>B</sub> hence Q<sub>A</sub> > Q<sub>B</sub> => B is false $$\\frac{Q_A}{R_A}{4\\pi R_A^2} = \\frac{Q_B}{R_B}{4\\pi R_B^2}$$ $$\\therefore \\frac{\\sigma_A}{\\sigma_B} = \\frac{R_B}{R_A}$$ $$\\frac{E_A}{E_B} = \\frac{\\sigma_A}{\\sigma_B} = \\frac{R_B}{R_A} < 1$$ E<sub>A</sub><E<sub>B</sub> </p>',47,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(5,'<p>For the resistance network shown in the figure, choose the wrong option.</p><img src = \"../api/resources/questions/5img1.jpg\">','The current through PQ is zero |: i<sub>1</sub> = 3 A |: The potential at S is more than that at Q |: i<sub>2</sub> = 2 A\n','1','<p>Due to input and output symmetry P & Q and S & T have same potential\nHence PQ and ST have 0 current\n Hence R<sub>2</sub> = ~~6\\Omega~~\nAnd R<sub>3</sub> = ~~12\\Omega~~\nSince the 2 are in parallel, $$\\therefore R_1 = \\frac {6 * 12}{6 + 12} = 4\\Omega$$ $$i_1 = 12/4 = 3 A$$\nQ and P have same potential. Since current is flowing from P to S with a resistance of ~~2\\Omega~~, V<sub>S</sub>< V<sub>P</sub> and hence V<sub>S</sub>< V<sub>Q</sub><br>\nTo calculate I<sub>2</sub>:\n6 * I<sub>2</sub> = 12 * (3-I<sub>2</sub>)\nI<sub>2</sub> = 2A</p>',44,1,'',2,NULL,'../api/resources/questions/5img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(6,'<p>A ~~2\\mu~~F capacitor is charged as shown in figure.<br> <img src = \"../api/resources/questions/6img1.jpg\"><br> The percentage of its stored energy dissipated after the switch S is turned to position 2 is:</p>','0% |: 20% |: 75% |: 80%','3','<p>The initial charge: Q = C<sub>1</sub>V\nThe charge is distributed as Q1 and Q2 till the potentials are same.$$\\frac{Q_1}{Q_2} = \\frac{C_1}{C_2} = \\frac{2\\mu F}{8\\mu F} = \\frac{1}{4}$$ $$\\therefore Q_1 = Q/5, Q_2 = 4Q/5 $$ Hence Q1 = Q/5 and Q2 = 4Q/5 <br> Energy in initial configuration $$ E_i = \\frac{1}{2}\\frac{Q^2}{C_1} $$ $$\\therefore E_i = \\frac{Q^2}{4}$$ Energy in final configuration $$E_f = \\frac{1}{2}\\frac{Q^2_1}{C_1} + \\frac{1}{2}\\frac{Q^2_2}{C_2} $$ $$\\therefore E_f = \\frac{Q^2}{20}$$ $$E_{dissipated} = \\frac{Q^2}{4} - \\frac{Q^2}{20} = \\frac{Q^2}{5}$$ $$ \\%_{dissipated} = \\frac{E_{dissipated}}{E_i} = \\frac{\\frac{Q^2}{5}}{\\frac{Q^2}{4}} = 80\\%$$</p>',45,1,'',2,NULL,'../api/resources/questions/6img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(7,'<p>Two batteries of different EMFs and different internal resistances are connected as shown. The voltage across AB in volts is: </p><img src = \"../api/resources/questions/7img1.jpg\">',' 5 |: 4.5 |: 5.4 |: 3.8','0','<p>Total EMF = 6V - 3V = 3V<br>\nResistance = ~~1 \\Omega + 2 \\Omega = 3 \\Omega~~<br>',46,1,'',2,NULL,'../api/resources/questions/7img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(8,'<p>A thin flexible wire of length L is connected to two adjacent fixed points and carries a current I in the clockwise direction, as shown in the figure. When the system is put in a uniform magnetic field of strength B going into the plane of the paper, the wire takes the shape of a circle. The tension in the wire is:</p>  <img src = \"../api/resources/questions/8img1.jpg\">','IBL |: IBL / ~~\\pi~~ |: IBL /2~~\\pi~~ |: IBL / 4~~\\pi~~\n','2','<img src = \"../api/resources/questions/8img2.jpg\"> <p>Magnetic force acting upwards ~~=Bl * dl = Bl * Rd\\Theta~~ <br> Tension (Vertical) acting downwards = ~~2T * sin \\frac{d\\Theta}{2}~~<br> Applying force balance - <br> $$2 T sin(\\frac{d\\Theta}{2}) = B I (R d\\Theta)~~ &nbsp&nbsp&nbsp&nbsp  ~~sin\\frac{d\\Theta}{2} = \\frac{d\\Theta}{2}$$ $$T (d\\Theta) = B I R (d\\Theta)$$ Integrating over ~~\\Theta~~ from 0 to ~~2\\pi~~ $$ T= \\frac{IBL}{2\\pi}$$',47,1,'',3,NULL,'../api/resources/questions/8img1.jpg|:../api/resources/questions/8img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(9,'<p>A few electric field lines for a system of two charges Q<sub>1</sub> and Q<sub>2</sub> fixed at two different points on the x-axis are shown in the figure. These lines suggest that:</p>  <img src = \"../api/resources/questions/9img1.jpg\">','~~\\left|Q1\\right|~~ > ~~\\left|Q2\\right|~~|: ~~\\left|Q1\\right|~~ < ~~\\left|Q2\\right|~~ |: At a finite distance to the left of Q1 the electric field is zero |:  None of the above\n','0','<p>Since the number of electric field lines of forces emerging from Q<sub>1</sub> is larger than terminating at Q<sub>2</sub>, the value of absolute charge Q<sub>1</sub> would be greater than the absolute value of Q<sub>2</sub><br>\nLet us assume the distance between the 2 charges is d\nAt any distance y, left of Q<sub>1</sub>, the electric field will be: $$E_{left} = \\frac{Q_1}{4\\pi\\epsilon_oy^2} - \\frac{Q_2}{4\\pi\\epsilon_o(y+d)^2}$$ Since Q<sub>1</sub> > Q<sub>2</sub> and y<sub>2</sub> < (y+d)<sup>2</sup> for a positive y, this term cannot be 0 for any value of y</p>',44,1,'',2,NULL,'../api/resources/questions/9img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(10,'<p>When two identical batteries of internal resistance 1~~\\Omega~~ each are connected in series across a resistor R, the rate of heat produced in R is J<sub>1</sub>. When the same batteries are connected in parallel across R, the rate is J<sub>2</sub>. If J<sub>1</sub> = 2.25J<sub>2</sub>  then the value of R in ~~\\Omega~~ is</p>','2.5 |: 4 |: 5 |: 4.3\n','1','<p>Let the potential difference of each battery be V <br>\nFor series - <br>\nV<sub>1</sub> = 2V <br>\nR<sub>1</sub> = R+2<br>\nHence, $$J_1 = (\\frac{2V}{R + 2})^2 * R$$ For parallel - <br>\nV<sub>2</sub> = V\nR<sub>2</sub> = (1 * 1)/(1+1) + R <br> = 1/2 + R <br> Hence,  $$J_2 = (\\frac{V}{R+1/2})^2 * R$$ Since J<sub>1</sub>/J<sub>2</sub> = 2.25,    R=4~~\\Omega~~</p>',45,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(11,'<p>A uniformly charged thin spherical shell of radius R carries uniform surface charge density of σ per unit area. It is made of two hemispherical shells, held together by pressing them with force F (see figure). F is proportional to: <br><img src = \"../api/resources/questions/11img1.jpg\"></p>','$$\\frac{\\sigma^2R^2}{\\epsilon_o}$$|:$$\\frac{\\sigma^2R}{\\epsilon_o}$$|:$$\\frac{\\sigma^2}{\\epsilon_oR}$$|:$$\\frac{\\sigma^2}{\\epsilon_o^2R^2}$$','0','<p>Electrostatic Repulsive Force: $$F_{ele} \\propto = \\frac{\\sigma^2\\pi R^2}{\\epsilon_o}$$ Since F balances this force, hence it is proportional to $$\\frac{\\sigma^2R^2}{\\epsilon_o}$$</p>',46,1,'',3,NULL,'../api/resources/questions/11img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(12,'<p>A series R-C combination is connected to an AC voltage of angular frequency ~~\\omega~~ = 500 radian/s. If the impedance of the R-C circuit is R ~~\\sqrt{1.25}~~, the time constant (in millisecond) of the circuit is: </p>','5 |: 2.6 |:  4|:  6\n','2','<p>$$Z = R\\sqrt{1.25} = (\\sqrt{R^2 + \\frac{1}{\\omega C}})^2$$ $$\\frac{1}{4}R^2 = (\\frac{1}{\\omega C})^2$$ $$ \\frac{1}{4}R^2 = \\frac{1}{500C}$$ $$\\therefore\\tau = RC = \\frac{1}{250}s = 4 ms$$ </p>',47,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(13,'<p>How many milliliters of 0.1M H<sub>2</sub>SO<sub>4</sub> must be added to 50mL of 0.1M NaOH to give a solution that has a concentration of 0.05M in H<sub>2</sub>SO<sub>4</sub></p>','400 mL|:50 mL|:200 mL|:100 mL','3','<p>Vml 0.1M H<sub>2</sub>SO<sub>4</sub> + 50ml 0.1M NaOH ~~\\rightarrow~~ (V + 50)ml 0.05M H<sub>2</sub>SO<sub>4</sub><br><br>0.1 X V = (V + 50) X 0.05 + 2.5<br><br>\nV = 100ml</p>',61,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(14,'<p>An unknown amino acid has 0.032% Sulphur. If each molecule has one S-atom only, 1.0 g of amino acid has ____ molecules:</p>','6.02 X 10<sup>18</sup>|:\n6.02 X 10<sup>19</sup>|:\n6.02 X 10<sup>21</sup>|:\n6.02 X 10<sup>23</sup>','0','<p>Weight of sulpher in 1 gram <br><br>= 0.032 * 1 * 1/100 <br><br>= 3.2 * 10<sup>-4</sup> g<br><br>Mol of S = 3.2 * 10<sup>-4</sup>/32 = 10<sup>-5</sup><br><br>\nNo. of S atoms = 10<sup>-5</sup> * 6.023 * 10<sup>23</sup> <br><br> = 6.023 * 10<sup>18</sup> </p>',63,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(15,'<p>In the reaction, 8 Al + 3 Fe<sub>3</sub>O<sub>4</sub> ~~\\rightarrow~~ 4 Al<sub>2</sub>O<sub>3</sub> + 9 Fe, the number of electrons transferred from reductant to oxidant is: </p>','8|:4|:7|:24','3','<p>8 Al + 3 Fe<sub>3</sub>O<sub>4</sub> ~~\\rightarrow~~ 4 Al<sub>2</sub>O<sub>3</sub> + 9 Fe <br><br> Oxidation state of Al changes from 0 to +3 <br><br>=> No. of e<sup>-</sup> lost by 8 Al is 3 * 8 = 24 </p>',63,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(16,'<p>In the reaction, H<sub>3</sub>PO<sub>4</sub> + Ca(OH)<sub>2</sub>~~\\rightarrow~~ CaHPO<sub>4</sub> + 2H<sub>2</sub>O, the equivalent mass of H<sub>3</sub>PO<sub>4</sub> is: </p>','49|:32.7|:196|:98','0','<p>H<sub>3</sub>PO<sub>4</sub> + Ca(OH)<sub>2</sub>~~\\rightarrow~~ CaHPO<sub>4</sub> + 2H<sub>2</sub>O <br><br> In the given reaction H<sub>3</sub>PO<sub>4</sub> reacts as a dibasic acid, hence x = 2  <br><br>=> E(H<sub>3</sub>PO<sub>4</sub>) = M(H<sub>3</sub>PO<sub>4</sub>) / 2 = 98/2 = 49  </p>',61,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(17,'<p>Oxidation States of Chlorine in CaOCl<sub>2</sub> (bleaching powder) is/ are: </p>','+1 and -1|:+1 only|:-1 only|:None of these','0','<p>CaOCl<sub>2</sub> (bleaching powder), the structure is: <br> <br> One Cl exists as Chloride (CL<sup>-</sup>) and the other as OCl<sup>-</sup> (Oxy Chloride) </p>',61,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(18,'<p>6.54 g of Zn reacts with 0.25 M HNO3 solution. Volume of HNO3 consumed is: </p>','0.8 L|:0.25 L|:1.6 L|:None of these','2','<p>Zn + 4 HNO<sub>3</sub> → Zn(NO<sub>3</sub>)<sub>2</sub> + 2NO<sub>2</sub> + H<sub>2</sub>O<br><br>\nThe above equation is not of the type X + Y ~~\\rightarrow~~ A + B <br><br> In X + Y ~~\\rightarrow~~A + B type of reactions, central atoms of oxidizing agent and reducing agent should be in single molecules in product; for example, <br> <br>\n FeSO<sub>4</sub> + KMnO<sub>4</sub> + H<sub>2</sub>SO<sub>4</sub> ~~\\rightarrow~~ Fe<sub>2</sub>(SO<sub>4</sub>)<sub>3</sub> + MnSO<sub>4</sub> + K<sub>2</sub>SO<sub>4</sub> + H<sub>2</sub>0</p>',62,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(19,'<p>The molar ratio of Fe<sup>2+</sup> to Fe<sup>3+</sup> in a mixture of FeSO<sub>4</sub> and Fe<sub>2</sub>(SO<sub>4</sub>)<sub>3</sub> having equal number of sulphate ions is:</p>','1:2|:3:2|:2:3|:None of these','3','<p>FeSO<sub>4</sub> ~~\\rightarrow~~ Fe<sub>2+</sub> + S0<sub>4</sub><sup>2-</sup> <br><br>Fe<sub>2</sub>(SO<sub>4</sub>)<sub>3</sub> ~~\\rightarrow~~  2Fe<sup>3+</sup> + 3SO<sub>4</sub><sup>2-</sup><br><br>Ratio of Fe<sup>2+</sup> to Fe<sup>3+</sup>=  ~~\\frac{3}{2}~~</p>',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(20,'<p>To remove permanent hardness (due to presence of CaSO<sub>4</sub>) of a 1 L sample of water, 10 mL of N/50 washing soda (Na<sub>2</sub>CO<sub>3</sub>) solution was added and the mixture was boiled and filtered. The filtrate was neutralized with 6 mL of N/50 HCl. The degree of hardness of water in ppm is ___.</p>','','4','<p>CaSO<sub>4</sub> + Na<sub>2</sub>CO<sub>3</sub> ~~\\rightarrow~~ CaCO<sub>3</sub> + Na<sub>2</sub>SO<sub>4</sub><br><br>  meq of HCl = meq of Na<sub>2</sub>CO<sub>3</sub> (excess) = 6/50<br><br>  meq of Na<sub>2</sub>CO<sub>3</sub> used with CaCO<sub>3</sub> = total meq of Na<sub>2</sub>CO<sub>3</sub> - excess meqs<br><br> = 10 X (1/50) - 6 X (1/50) = 2/25 = meq of CaCO<sub>3</sub><br><br> => wt. of CaCO<sub>3</sub> in 1 L sample = 2/25 X 50 = 4 mg<br><br> => degree of hardness = 4 ppm </p>',63,3,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(21,'<p>KMnO<sub>4</sub> reacts with KHC<sub>2</sub>O<sub>4</sub> in absence of any external acid. If stoichiometric co-efficient of KMnO<sub>4</sub> is 1 in the balanced reaction, then the co-efficient of KHC<sub>2</sub>O<sub>4</sub> is ___. </p>','','8','<p>$$( 8H^+ + 5e^- + MnO4^- \\rightarrow Mn^{2+} + 4H_20) * 2 $$ $$(C_2O_4^{2-} \\rightarrow 2CO_2 + 2e^- ) * 5$$  <table  style=\"text-align: center\"><tr><td>~~2MnO_4^-~~</td><td> +</td> <td>~~16 H^+~~</td><td> +</td> <td>~~5C_2O_4^{2-}~~</td> <td>~~\\rightarrow~~</td> <td>~~2Mn^{2+}~~</td> <td>+</td> <td>~~8H_2O~~</td> <td>+</td> <td>~~10CO_2~~</td></tr><tr><td>~~2MnO_4^-~~</td> <td>+</td> <td>~~11H^+~~</td> <td>+</td> <td>~~5HC_2O_4^-~~</td><td> ~~\\rightarrow~~</td> <td>~~2Mn^{2+}~~</td><td> +</td> <td>~~8H_2O~~</td> <td>+</td> <td>~~10CO_2~~</td></tr><tr><td>~~2K^+~~</td><td></td><td>~~11K^+ + 11C_2O_4^{2-}~~</td><td></td><td>~~5K^+~~</td><td></td><td>~~2K^+~~</td><td></td><td> ~~11K^+~~</td><td></td><td>~~ 11C_2O_4^{2-}~~</td><td></td><td> ~~ 5K^+~~</td></tr></table> $$ 2KMnO_4 + 16 KHC_2O_4\\rightarrow 2MnC_2O_4 + 8H_2O + 10CO_2 + 9K_2C_2O_4$$   Answer: 8 </p>',61,3,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(22,'<p>1.8 g of Oxalic Acid (COOH)<sub>2</sub>.xH<sub>2</sub>O are dissolved in water and the volume made upto 250ml. On titration, 21ml of this solution requires 24ml of N/10 NaOH solution for complete neutralization. The value of x is: </p>','1|:2|:3|:None of these','1','<p>meq of NaOH = meq of oxalic acid in 21 ml = 24 X 1/10 <br> meq of oxalic acid in 250ml = (24 X 1/10) X (250 / 21) <br> meq of oxalic acid  <br>= (1.8 / (M0 / 2)) X 1000 = (24 X 1/10) X (250/21)  => <br>M<sub>0</sub> = 126 = 90 + 18x  => x = 2</p>',63,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(23,'<p>How much NaOH should be added to 1 L of a buffer solution containing 0.1 M each of CH<sub>3</sub>COOH and CH<sub>3</sub>COONa so as to increase pH by 0.5 units.  (K<sub>a</sub> = 10<sup>-5</sup>)</p>','0.032|:0.041|:0.052|:0.01','2','<table style = \"text-align:center\"> <tr> <td></td><td>CH<sub>3</sub>COOH </td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp &nbsp</td> <td> CH<sub>3</sub>COO<sup>-</sup></td> <td> +</td> <td>H<sup>+</sup></td></tr><tr><td>t=0 &nbsp</td><td>0.1</td><td></td><td>0.1</td><td></td><td>-</td></tr><tr><td>t=t<sub>eq</sub>&nbsp </td><td>(0.1-x)</td><td> </td><td>(0.1+x)</td><td></td><td>x</td></tr></table><br>=>(0.1x) / (0.1)  = 10<sup>-5</sup><br><br>x = 10<sup>-5</sup><br><br>Initial pH = 5<br>pH<sub>new</sub> = 5.5<br><br><table style = \"text-align:center\"> <tr> <td>CH<sub>3</sub>COOH </td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp </td> <td> CH<sub>3</sub>COO<sup>-</sup></td> <td> +</td> <td>H<sup>+</sup></td></tr><tr><td>(0.1 - z)</td><td></td><td>(0.1 + z)</td><td></td><td>10<sup>5.5</sup> </td></tr></table><br>$$\\frac{(0.1+z)}{(0.1-z)}* 10^{-5.5} = 10^5 $$ $$=>0.1+z  = 0.1\\sqrt{10}-\\sqrt{10}z$$ $$z = \\frac{0.1(\\sqrt{10}-1)}{(\\sqrt{10}+1)}$$=0.052',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(24,'<p>20 ml solution of 0.1 M weak base BOH is titrated with 0.1 M HCl solution. [H<sup>+</sup>] at end point is (Kb = 5 X 10<sup>-12</sup>): </p>','10-2|:9 X 10-3|:1.15 X 10-2|:None of these','2','<p><table style = \"text-align:center\"> <tr> <td></td><td>B<sup>+</sup></td><td> + </td><td>H<sub>2</sub>O</td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp </td> <td> BOH</td> <td> + </td> <td>H<sup> + </sup></td></tr><tr><td>t=0 &nbsp</td><td>2/40</td><td></td><td>-</td><td></td><td>-</td><td></td><td>-</td></tr><tr><td>t=t<sub>eq</sub> &nbsp</td><td>2/40-x</td><td></td><td>-</td> <td></td><td>x</td><td></td><td>x</td></tr></table> <br>$$K_h = K_w / K_b \\frac{10^{-14}}{5 * 10^{-10}}$$ $$ K_h= 2 * 10^{-3} $$ $$\\frac{x.x}{\\frac{1}{20}-x} = 2 * 10^{-3}$$ $$x = 9*10^{-3}$$</p>',61,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(25,'<p>Which of the following relation is correct ? All are 1 L solution (use K<sub>a</sub> = K<sub>b</sub> = 10<sup>-5</sup>) <br> 0.1 mol NaOH + 0.1 mol HCl ~~\\rightarrow~~ pH<sub>1</sub><br>0.01 mol NaOH + 0.1 mol NH<sub>4</sub>Cl ~~\\rightarrow~~ pH<sub>2</sub> <br> 0.01 mol NH<sub>4</sub>OH + 0.01 mol CH<sub>3</sub>COOH ~~\\rightarrow~~ pH<sub>3</sub> <br> 0.01 mol CH<sub>3</sub>COOH + 0.01 mol HCl ~~\\rightarrow~~ pH<sub>4</sub></p>','pH<sub>4</sub> < pH<sub>1</sub> = pH<sub>3</sub> < pH<sub>2</sub>|:pH<sub>4</sub> < pH<sub>1</sub> < pH<sub>3</sub> < pH<sub>4</sub>|:pH<sub>4</sub> < pH<sub>2</sub> < pH<sub>1</sub> < pH<sub>3</sub>|:pH<sub>1</sub> < <sub>pH3</sub> < <sub>pH4</sub> < <sub>pH2</sub>','0','<p>0.1mol NaOH + 0.1mol HCl ~~\\rightarrow~~ pH = 7  <br><br>0.01mol NH<sub>4</sub>OH + 0.01mol CH<sub>3</sub>COOH ~~\\rightarrow~~ pH = 7<br> <br> (since K<sub>a</sub> = K<sub>b</sub> = 10<sup>-7</sup>)  <br><br> 0.01 mol CH<sub>3</sub>COOH + 0.01 mol HCl ~~\\rightarrow~~ pH < 7  <br><br>0.01 mol NaOH + 0.1 mol NH<sub>4</sub>Cl ~~\\rightarrow~~ pH > 7 <br> \n<table style = \"text-align:center\"> <tr> <td></td><td>NH<sub>4</sub>OH </td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp </td> <td> CH<sub>4</sub><sup>+</sup></td> <td> +</td> <td>OH<sup>-</sup></td></tr><tr><td>t=0 &nbsp</td><td>-</td><td></td><td>0.1</td><td></td><td>0.01</td></tr><tr><td>t=t<sub>eq</sub>&nbsp</td><td>0.01</td><td></td><td>0.09</td><td></td><td>x</td></tr></table><br><br> x = ~~1/9 * 10^{-5} ~~</p>',63,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(26,'<p>The equilibrium constant for the reaction: <br><br>~~N_{2(g)} + O_{2(g)} \\rightleftharpoons 2NO_{(g)} is 4 * 10^{-4}~~ at 200K<br><br> In the presence of a catalyst, the equilibrium is attained 10 times faster. Therefore the equilibrium constant in presence of a catalyst at 200 K is: </p>','~~4*10^-3~~|:~~4*10^-4~~|:~~4*10^-5~~|:None of these','1','<p>K<sub>eq</sub> does not change even if the catalyst is changed</p>',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(27,'<p>For the reaction in equilibrium<br><br> &nbsp  ~~2NOBr_{(g)} \\rightleftharpoons 2NO_{(g)} + Br_{2(g)}~~   if ~~P_{(Br2)} = P/9~~ at equilibrium and P is the total pressure. The ratio of K<sub>p</sub> / P is equal to: </p>','1/9|:1/81|:1/27|:1/5','1','<p><table style=\"text-align: center\"><tr><td></td><td>~~2NOBr_{(g)}~~</td> <td>&nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp</td> <td>~~2NO_{(g)}~~</td> <td>+</td> <td>~~Br_{2(g)}~~</td></tr><tr><td>t = t<sub>eq</sub> &nbsp</td> <td>~~P_o - x~~</td><td></td><td> x </td><td></td> <td>x/2<td> </tr></table><br> We are given:$$P_{(Br_2)eq} = x/2 = P/9 => x = 2P/9  $$ $$P_{(NO)eq} = 2P/9$$ $$ P_{(T)eq} = P_o + x/2 = P $$ $$ =>P_o = 8P/9$$ $$=> P_o - x = 2P/3$$ $$K_p = \\frac{P(NO)^2 P(Br_2)^1}{P(NOBr)^2} =\\frac {(\\frac{2P}{9})^2.(\\frac{P}{9})}{(\\frac{2P}{3})^2} = \\frac{1}{81}.P$$</p>',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(28,'<p>~~PCl_5~~ dissociates in a closed container as:$$PCl_{5(g)} \\rightleftharpoons  PCl_{3(g)} + Cl_{2(g)}$$ If total pressure at equilibrium of the reaction mixture is P, and the degree of dissociation of ~~PCl_5~~ is ~~\\alpha~~ , the partial pressure of ~~PCl_3~~ will be:</p>','~~P.[\\frac{\\alpha}{\\alpha +1}]~~|:~~P.[\\frac{2\\alpha}{\\alpha -1}]~~|:~~P.[\\frac{\\alpha}{\\alpha -1}]~~|:~~P.[\\frac{\\alpha}{1 - \\alpha}]~~','0','<table style=\"text-align: center\"><tr><td>~~PCl_{5(g)}~~</td><td> ~~\\rightleftharpoons~~</td><td> ~~PCl_{3(g)}~~</td><td> + </td><td>~~Cl_{2(g)}~~</td></tr><tr><td>~~a - a\\alpha~~</td><td></td><td>~~a\\alpha~~</td><td></td><td>~~a\\alpha~~</td><td></tr></table>$$P(PCl_{3(g)})_{eq} = \\frac{a\\alpha}{a + a\\alpha}.P$$ $$\\frac {\\alpha}{1 + 1\\alpha}.P$$',61,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(29,'<p>Equal volumes of two solutions of HCl are mixed. One solution has a pH 1 while the other has a pH 6. The pH of the resulting solution is:</p>','Less than 1|:Between 1 & 2|:4|:7','1','<p>1L of (pH=1) solution + 1L of (pH=6) solution <br>$$=>[H^+]mix = \\frac{10^{-1} +10^{-6}}{2}\\approx\\frac{10^{-1}}{2}$$ <br>pH = 1.3</p>',61,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(30,'<p>The equilibrium constants K<sub>p1</sub> and K<sub>p2</sub> for the reactions X -> 2Y and Z -> P + Q, respectively are in the ratio of 1:9. If the degree of dissociation of X and Z are equal, then the ratio of total pressures at these equilibria is:  (Assume all species to be gaseous)</p>','1:9|:1:1|:1:3|:1:36','3','<p><table style=\"text-align: center\"><tr><td></td><td>&nbspX&nbsp</td><td>&nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp</td><td>&nbsp2Y&nbsp</td></tr><tr><td>t=teq&nbsp</td><td>(a - a ~~\\alpha~~)</td> <td></td><td>2aα</td></tr></table>$$Kp_1 = \\frac{(\\frac{2a\\alpha P1}{a+a\\alpha})^2}{(\\frac{(a-a\\alpha) P1}{a+a\\alpha})^1} \\Rightarrow Kp_1 = \\frac{4\\alpha^2}{1 - \\alpha^2}P_1$$ <table style=\"text-align: center\"><tr><td></td> <td>Z</td><td>&nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp</td><td>P</td><td>+</td><td>Q</td></tr><tr><td>t=t<sub>eq</sub>&nbsp</td><td>~~c-c\\alpha~~</td> <td></td> <td>~~c\\alpha~~</td><td></td><td>~~c\\alpha~~</td></tr></table> $$Kp_2 = \\frac{(\\frac{c\\alpha P2}{c+a\\alpha})^2}{(\\frac{(c-c\\alpha) P2}{c+c\\alpha})^1} \\Rightarrow Kp_2 = \\frac{4\\alpha^2}{1-\\alpha^2}P_2$$ $$\\frac{Kp_1}{Kp_2} = \\frac{4P_1}{P_2} \\Rightarrow \\frac{1}{9} = \\frac{4P_1}{P_2} \\Rightarrow \\frac{P_1}{P_2} = \\frac{1}{36} $$</p>',63,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(31,'<p>XY<sub>2</sub> dissociates as:$$XY_{2(g)} \\rightleftharpoons XY_{(g)} + Y_{(g)}$$ When the initial pressure of XY<sub>2</sub> is 600 mm of Hg, the total equilibrium pressure is 800 mm Hg. Calculate K<sub>P</sub> for the reaction, assuming that the volume of the system remains unchanged</p>','50|:100|:166.6|:400','2','<p><table style=\"text-align: center\"><tr><td></td><td> ~~XY_{2(g)}~~</td><td>~~\\rightleftharpoons~~</td> <td> ~~XY_{(g)}~~</td><td> +</td><td>~~Y_{(g)}~~</td></tr><tr><td>t=0&nbsp</td><td>600</td><td></td><td>-</td><td></td><td>-</td></tr><tr><td>t=t<sub>eq</sub>&nbsp</td><td>600-x</td><td></td><td>x</td><td></td><td>x</td></tr></table> $$(P_T)_{eq} = 600 + x = 800 $$ $$\\Rightarrow x = 200$$ $$K_{p} = \\frac{x.x}{600-x} = \\frac{200.200}{600-200} = 100mm Hg$$</p>',63,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(32,'<p>Consider the reaction, $$A^- + H_2O \\rightleftharpoons  HA + OH^-$$ The K_a value for acid HA is 1.0 X 10<sup>-6</sup>. What is the value of K for this reaction?</p>','1.0 X 10<sup>6</sup>|:1.0 X 10<sup>-8</sup>|:1.0 X 10<sup>8</sup>|:1.0 X 10<sup>-5</sup>','1','<p> $$ A^- + H_2O \\rightleftharpoons HA + OH^-$$ K<sub>c</sub> = K<sub>w</sub> / K<sub>a</sub><br>= 10<sup>-14</sup> / 10<sup>-6</sup> <br> = 10<sup>-8</sup> </p>',63,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(33,'<p>A ball thrown vertically upwards with a velocity \'u\' reaches a maximum height of \'h\'. If the maximum height reached by the ball is to be doubled, then it should be thrown up with velocity</p>','2u|:4u|:~~\\sqrt2u~~|:~~\\sqrt3u~~','2','<img src=\"../api/resources/questions/33img1.jpg\"\n><p>By conservation of mechanical energy $$mgh = \\frac{1}{2}mu^2$$ For double height:$$mg(2h) = \\frac{1}{2}mv^2$$ $$\\Rightarrow v^2 = 2u^2 $$ $$ v = \\sqrt2 u $$</p>',34,1,'',1,NULL,'../api/resources/questions/33img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(34,'<p>A simple pendulum is released from the horizontal position \'H\' as shown. If \'m\' denotes the mass of the bob and \'l\' the length of the pendulum, the gain in KE at the position P is</p>\n','~~\\frac{\\sqrt3mgl}{2}~~|:~~\\frac{mgl}{2}~~|:~~\\frac{mgl}{\\sqrt2}~~|:~~mgl~~','0','<p>By conservation of energy between positions H \nand P<br>&nbsp&nbsp mg(l cos 30<sup>o</sup>) = 1/2 mv<sup>2</sup> - 0<br><br>&nbsp&nbsp KE = mgl cos 30<sup>o</sup> = ~~\\frac{\\sqrt3mgl}{2}~~<br> <img src=\"../api/resources/questions/34img1.jpg\" \n></p>',34,1,'',2,NULL,'../api/resources/questions/34img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(35,'<p>If the PE of the particle that moves along the x-axis under the action of a single conservative force is given by: $$U(x) = \\frac{a}{x^2} - \\frac{b}{x^3} $$ Then the PE of the particle at equilibrium is:</p>','$$\\frac{27b^3}{a^2}$$|:$$\\frac{4a^3}{27b^2}$$|:0|:$$\\frac{4b^3}{27a^2}$$','2','<p>U(x) = a/x<sup>2</sup> - b/x<sup>3</sup><br><br>Since F = -dU/dx<br><br>\nF = 2a/x<sup>3</sup> - 3b/x<sup>4</sup><br><br>\nAt equilibrium F = 0 => x = 3b/2a (substituting in U(x))\n$$\\Rightarrow U =\\frac{4a^3}{27b^2}$$</p>\n',35,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(36,'<p>The PE of a spring that is stretched by 1 cm is \'U\'. If it is stretched further by 2cm, the PE stored in it becomes</p>','2U|:3U|:8U|:9U','3','<p>$$(\\Delta x)_{initial} = 1 cm = 1/100 m$$\n$$(\\Delta x)_{final} = (1 + 2 ) cm = 3/100 m$$\n$$U_{final}  = \\frac{1}{2} k (\\Delta x)^2_{initial}$$\n $$ = \\frac{1}{2} k (\\frac{3}{100})^2 = 9 U_{initial}$$</p>',35,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(37,'<p>Based on the paragraph, answer the following. <br><br>Maximum elongation in the spring will be\n</p>','x/2|:x|:2x|:3x','1','<p>Let the velocities at some instant be V<sub>a</sub> and V<sub>b</sub> of block \'a\' and \'b\' as shown </p><img src=\"../api/resources/questions/q37img2.jpg\"><p>As there is no external force acting on the system of the two blocks, their momentum must be conserved<br><br>\nInitial momentum (when released) = 0<br><br> $$m_bV_b - m_aV_a =0  \\Rightarrow m_bV_b = m_aV_a$$ Elongation will be maximum when V<sub>a</sub> and V<sub>b</sub> become zero.<br><br>By conservation of energy:<br>$$\\frac{1}{2}kx^2 + \\frac{1}{2} m_a0^2 + \\frac{1}{2} m_b0^2 = \\frac{1}{2}k(\\Delta l)^2 + \\frac{1}{2} m_a0^2 + \\frac{1}{2} \nm_b0^2$$\n~~ \\Rightarrow \\Delta~~l= x (max elongation)</p>',35,1,'',2,1,'../api/resources/questions/37img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(38,'<p>Based on the paragraph, answer the following.<br><br>KE<sub>a</sub>/KE<sub>b</sub> when the spring attains its natural length will be</p>','1/8|:1/2|:2|:1/2~~\\sqrt2~~','2','<p>Let the velocities at some instant be V<sub>a</sub> and V<sub>b</sub> of block \'a\' and \'b\' as shown </p><img src=\"../api/resources/questions/q38img01.jpg\"><p>As there is no external force acting on the system of the two blocks, their momentum must be conserved<br><br>\nInitial momentum (when released) = 0<br><br>$$m_bV_b - m_aV_a =0  \\Rightarrow m_bV_b = m_aV_a$$ Elongation will be maximum when V<sub>a</sub> and V<sub>b</sub> become zero.$$\\frac{KE_a}{KE_b} = \\frac{1/2m_av_a^2}{1/2m_bv_b^2} = \\frac{m_av_a.v_a}{m_bv_b.v_b}=\\frac{v_a}{v_b}=\\frac{m_b}{m_a}$$ =>KE<sub>ratio</sub> = 2</p>\n',35,1,'',3,1,'../api/resources/questions/38img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(39,'<p>A body at rest, under the action of a constant force attains a velocity V in time T. The instantaneous power delivered to the body at time \'t\' is proportional to (for t<T)</p>','$$\\frac{V}{T}t$$|:$$\\frac{V^2}{T}t^2$$|:$$\\frac{V^2}{T^2}t$$|:$$\\frac{V^2}{T^2}t^2$$','2','<p>P = Fv  (v is the velocity at time \'t\')<br><br>Given velocity is V after time T<br><br>Ta + 0 = V &nbsp &nbsp v = 0 + at<br><br>v/t = V/T, hence v = Vt/T<br><br>F = m x a = mV/T $$P = m\\frac{V^2}{T^2}t$$</p> ',34,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(40,'<p>A particle of mass \'m\' moves along a straight line on a smooth horizontal surface under the action of a force that develops a constant power \'P\'. Distance covered by the particle as its speed increases from v to 2v is</p>','$$\\frac{7mv^3}{3P}$$|:$$\\frac{9mv^3}{5P}$$|:$$\\frac{12mv^3}{5P}$$|:$$\\frac{11mv^3}{7P}$$','0','<p> Constant Power  P = Fv<br> $$P = m\\frac{dv}{dt}v$$ $$P = mv\\frac{dv}{dx}\\frac{dx}{dt} \\Rightarrow P = mv^2\\frac{dv}{dx}$$ Integrating&nbsp&nbsp ~~\\int_{x}^{x+d}P.dx = \\int_{v}^{2v}mv^2.dx~~ $$P*d = \\frac{Tmv^3}{3}$$ $$\\Rightarrow d = \\frac{7mv^3}{3P} $$</p>',34,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(41,'<p> A block moving with a speed of 5 m/s on a smooth horizontal surface compresses a spring of spring constant 100 N/m attached to a wall by a maximum extent of 10cm. Work done by the spring force on the block (until maximum compression) is :</p><img src=\"../api/resources/questions/41img1.jpg\" height = \"200\">','+5J|:-5J|:+0.5J|:-0.5J','3','<p> $$W_{spring force}   = -(1/2 kx_{max}^2)$$ $$ = -1/2 (100) (10/100)^2 $$   = -0.5 J</p>',35,1,'',2,NULL,'../api/resources/questions/41img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(42,'<p>An object of mass 4 kg is dropped from a height  of 20 m above the ground in atmospheric air. It reaches the ground with a speed of 16m/s falling vertically. Work done by air drag on the body is : </p>','288 J|:-288 J|:512 J|:-512 J','1','<p>By the work energy theorm: </p><img src=\"../api/resources/questions/42img1.jpg\" height = \"200\"><p><table style= \"text-align: center\"><tr><td>Work Done by All Forces on a Particle</td><td> &nbsp&nbsp=&nbsp&nbsp </td><td>Change in KE of the Particle</td></tr><tr><td>W<sub>gvt</sub> + W<sub>airdrag</sub></td><td> &nbsp&nbsp=&nbsp&nbsp </td><td>~~\\Delta~~KE</td></tr></table> <br>\nmgh + W<sub>airdrag</sub> = 1/2 x 4 x 16<sup>2</sup> - 0<br><br>\nW<sub>airdrag</sub> = -288 J </p>',34,1,'',1,NULL,'../api/resources/questions/42img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(43,'<p>A block of mass 4kg falls on a light spring fixed to the ground from a height of 15 cm above the spring. If the spring constant is 2000 N/m, maximum compression in the spring will be:</p>\n','~~\\sqrt{15}cm~~|:2~~\\sqrt{15} cm~~|:10 cm|:20 cm','2','<p>Let the maximum compression in the spring be x cm. <br><br>At the instant of maximum compression vel of block = 0<br><br>By conservation of energy $$ \\frac{mg(h+x)}{100} = \\frac{1}{2}k(\\frac{x}{100})^2$$ => x = 10 cm</p>',34,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(44,'<p>An object of mass 4kg is moving along the +ve x-axis starting from the origin at t=0, such that its position x varies with time t as x<sup>2</sup> = 16t<sup>3</sup> ; x is in mts and t is in seconds. \nWork done on the object as a function of time can be shown as:</p>','<img src=\"../api/resources/questions/44img1.jpg\" height = \"200\">|:<img src=\"../api/resources/questions/44img2.jpg\" height = \"200\">|:<img src=\"../api/resources/questions/44img3.jpg\" height = \"200\">|:<img src=\"../api/resources/questions/44img4.jpg\">','2','<p>x<sup>2</sup> = 16t<sup>3</sup> &nbsp&nbsp=>&nbsp&nbsp  x = 4t<sup>3/2</sup> <br>Differentiating, we get &nbsp  ~~v = 4 * 3/2 *t^{1/2} = 6\\sqrt t~~<br>\nFurther differentiating,  &nbsp a = ~~6 * 1/2 * t^{-1/2} = 4\\sqrt t~~\n<br><br>\nF = ma = 12/\\sqrt t<br>Also v = dx/dt = ~~6\\sqrt t~~  &nbsp=>&nbsp dx = 6\\sqrt t.dt<br>dW = F.dx = 72.dt<br> dW = F.dx = 72.dt <br>W = ~~\\int_{0}^{t} 72.dt = 72t~~<br><br>W = 72t</p>',35,1,'',3,NULL,'../api/resources/questions/44img1.jpg|:../api/resources/questions/44img2.jpg|:../api/resources/questions/44img3.jpg|:../api/resources/questions/44img4.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(45,'<p> Work done from t=3 seconds to t=5 seconds is </p>','72 J|:144 J|:100 J|:88 J','1','<p> dW = F.dx = 72.dt <br><br>W = ~~\\int_{3}^{5}72.dt = 144J~~<br><br>W = 144 J </p>',34,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(46,'<p> A man weighing 80 kgs is standing on a trolley weighing 320 kgs. The trolley is resting on frictionless horizontal rails. If the man starts walking on the trolley along the rails with a speed of 1m/s relative to the trolley, then after 4 seconds, the magnitude of his displacement relative to the ground will be </p>','5m|:4m|:3m|:3.2m','3','<p> Lets consider right side as +ve x direction </p> <img src=\"../api/resources/questions/46img1.jpg\" height = \"200\"><p>~~_t\\vec{V}_m = \\hat{i}~~ &nbsp&nbsp ~~\\vec{V}_t = -v\\hat{i}~~<br><br>~~\\vec{V}_m = _t\\vec{V}_m + \\vec{V}_t~~<br><br>&nbsp&nbsp= ~~(1-v)\\hat{i}~~<br><br>As no external force acts on the trolley man system in the horizontal direction, the momentum of the system in the horizontal direction must be conserved. <br><br>&nbsp&nbsp~~M_{man}V_m + M_{trolley}V_t = 0~~   (initial momentum)<br><br>&nbsp&nbsp ~~80 (1-v)\\hat{i} - 320v\\hat{i} = 0~~ <br><br> ~~=> 1-v = 4v <br>=> v = 1.5m/s~~<br>~~=>\\vec{V}_m=4/5\\hat{i} \\Rightarrow \\left |\\Delta\\vec{r}\\right| = 4/5* 4 = 3.2m~~ </p>',35,1,'',2,NULL,'../api/resources/questions/46img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(47,'<p> An object of mass \'m\' moving with velocity \'v\' is directly approaching another object of the same mass at rest. The K.E. of this system as viewed from the center of mass of their system is </p>','(mv<sup>2</sup>)/4|:(mv<sup>2</sup>)|:(mv<sup>2</sup>)/8|:(mv<sup>2</sup>)/2','0','<p> Lets consider right side as +ve x direction</p><img src=\"../api/resources/questions/47img1.jpg\" height = \"200\"><p> $$\\vec{V}_{cm}=\\frac{m_1\\vec{V}_1+m_2\\vec{V}_2}{m_1+m_2}$$ &nbsp &nbsp &nbsp v/2(towards right) <br><br> ~~KE_{from\\, center\\, of\\, mass}~~ = 1/2 m(-v/2)<sup>2</sup> + 1/2 m(v/2)<sup>2</sup> <br> = 1/4 mv<sup>2</sup> </p>',33,1,'',2,NULL,'../api/resources/questions/47img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(48,'<p> Particle \'x\' (mass = 4kg) and \'y\'(mass = 9kg) move directly towards each other, collide and then separate moving away from each other. If ~~\\Delta \\vec{v_x}~~ is change in velocity of x, and ~~\\Delta\\vec{v_y}~~ that of y, then, $$\\frac{\\left|\\Delta \\vec{v_x}\\right|} {\\left|\\Delta \\vec{v_y}\\right|} \\, is:$$ </p>','4/9|:9/4|:2/3|:3/2','2','<img src=\"../api/resources/questions/48img1.jpg\">&nbsp&nbsp&nbsp&nbsp<img src=\"48img2.jpg\" height = \"200\"><p> Let direction towards right be +ve direction $$\\Delta \\vec{v_y}  = v_2 \\hat{i} -(-u_2 \\hat{i}) = (v_2 + u_2) \\hat{i}$$ $$\\Delta \\vec{v_x}  = -v_1 \\hat{i} -(u_1 \\hat{i}) = -(v_1 + u_1) \\hat{i}$$\nBy conservation of linear momentum $$ 4u_1 \\hat{i} - 9u_2 \\hat{i} = -4v_1\\hat{i} + 9v_2 \\hat{i}$$ $$4(v_1 + u_1) \\hat{i} = 9 (v_2 + u_2) \\hat{i} $$ $$ [\\frac{\\left|\\Delta \\vec{v_x}\\right|} {\\left|\\Delta \\vec{v_y}\\right|}] = \\frac{(v_1+u_1}{v_2+u_2}=\\frac{9}{2}$$</p>',35,1,'',3,NULL,'../api/resources/questions/48img1.jpg|:../api/resources/questions/48img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(49,'<p>A ball collides directly with another similar ball at rest. K.E. of the system is reduced by half due to the impact. The value of co-efficient of restitution is </p>','1/2|:1/4|:0|:~~1/\\sqrt2~~','2','<img src=\"../api/resources/questions/49img1.jpg\" >&nbsp&nbsp&nbsp&nbsp<img src=\"../api/resources/questions/49img2.jpg\" height = \"200\"> <p>Conserving Momentum: <br>&nbsp&nbsp&nbsp&nbsp mv<sub>1</sub> + mv<sub>2</sub> = mv<br><br>\nand KE is reduced to half:<br>&nbsp&nbsp&nbsp&nbsp~~1/2 [ 1/2 mv^2] = [ 1/2 mv_1^2 + 1/2 mv_2^2] ~~<br><br>\n~~ \\Rightarrow v_1 + v_2 = v~~ and ~~v_1^2 + v_2^2 = v^2/2~~<br><br>~~\\Rightarrow v_1 = v_2 = v/2~~, hence e = 0 </p>',35,1,'',3,NULL,'../api/resources/questions/49img1.jpg|:../api/resources/questions/49img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(50,'<p>A body of mass 2kg at rest is acted upon by a force as shown in the graph. The magnitude of momentum of the body after 6 seconds is (in N-s)</p>','50|:100|:25|:60','2','<p>By impulse momentum theorem: <br><br>\n~~\\vec{Impulse} = \\vec{\\Delta P}~~ and ~~\\left|\\vec{Impulse}\\right| =~~ Area under F-t graph<br><br>Area = ~~1/2 * 2 * 10 + 10 * (6-2) = 50 N-s~~<br><br>~~\\left|\\vec{P_f} - \\vec{P_i}\\right| = 50~~&nbsp&nbsp&nbsp&nbsp ~~ \\vec{P_i} = 0~~ (starts from rest)<br><br>~~\\left|\\vec{P_f}\\right| = 50 N-s~~</p>',33,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(51,'<p>Based on the paragraph, answer the following</p><p>Velocity of center of mass of the system (A + B + Spring) before collision is:</p>','~~26 \\hat{i} m/s~~|:~~0 \\hat{i} m/s~~|:~~10 \\hat{i} m/s~~|:~~1\\hat{i} m/s~~\n','3','<p> We can create a table for the velocity of block \'A\' and Block \'B\'. Right direction is given to be +ve x direction <table style=\"text-align: center\" frame = \"border\"> <tr><td></td><td>Velocity (M<sub>a</sub> = 6kg)&nbsp&nbsp</td><td>&nbsp&nbspVelocity (M<sub>b</sub> = 4kg)</td></tr><tr><td> Initial:</td><td>~~3\\hat{i}~~</td><td>-~~2\\hat{i}~~</td></tr><tr><td>Max Compression:</td><td></td><td></td></tr><tr><td>\'A\' at Rest:</td><td>0</td><td></td></tr><tr><td>Final:</td><td></td><td></td></tr></table><br><br>\nInitial energy   = (KE)<sub>Block A</sub> + (KE)<sub>Block B</sub> + (PE)<sub>Spring</sub> <br>\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp     = 1/2 * 6 * 32  + 1/2 * 4 * 22 + 0 = 35J <br><br>\nInitial momentum  = ~~\\left|\\vec{(M_aV_a)}_{initial} + \\vec{(M_bV_b)}_{initial}\\right| ~~<br>\n&nbsp&nbsp&nbsp&nbsp     = 6 * 3 + 4 * (-2) = 10 N-s <br><br>\nCalculating the velocity of center of mass (V<sub>cm</sub>) <br><br>\n~~V_{cm}  = (m_aV_a + m_bV_b) / (m_a + m_b)~~<br> ~~= (18 \\hat{i} - 8 \\hat{i}) / 10 ~~<br>~~ = \\hat{i}~~ </p>',33,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(52,'<p>Based on the paragraph, answer the following. <ul> <li>Let LM denote Linear Momentum of system,</li><li>KE denote Kinetic Energy of the system,</li><li>ME denote Mechanical Energy of the system</li></ul>Then, which of the following is conserved<br></p>','LM & KE|:Only KE|:LM &ME|:Only LM','2','<p> Let the system be: Block A, Block B & Spring<br><br>Since there is no external force on the system in the horizontal direction : <br>\n<ol><li>Linear momentum of the system in horizontal direction must be conserved</li>\n<li>Velocity of center of mass of the system will be a constant</li></ol><br>\nAlso mechanical energy of the system will be conserved as there are no dissipative forces acting on the system</p>',34,1,'',3,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(53,'<p> Based on the paragraph, answer the following. <br><br>Final velocity of A is </p>','~~\\hat{i} m/s~~|:~~ -\\hat{i} m/s~~|:~~0 \\hat{i} m/s~~|:~~5/3 \\hat{i} m/s~~','1','<p> The block will separate when spring comes back to the natural length (let v<sub>1</sub>, v<sub>2</sub> be the velocities): <br><br>\nBy COLM  6v<sub>1</sub> + 4v<sub>2</sub> = 10<br>\nBy COE     ~~1/2 * 6 * v_1^2 + 1/2 * 4 * v_2^2 = 35~~<br><br>  On solving<br>\n&nbsp&nbsp&nbsp&nbsp v<sub>1</sub> = 3, -1 <br><br>Final velocity of ~~A = -\\hat{i}~~ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(54,'<p> Based on the paragraph, answer the following.<br><br>Final velocity of the center of mass of the system (A + B + spring) is </p>','~~\\hat{i} m/s~~|:~~5/3 \\hat{i} m/s~~|:~~10 \\hat{i} m/s~~|:~~5/2 \\hat{i} m/s~~','0','<p> Since there is no external force on the system in the horizontal direction :<br>\n<ol><li>Linear momentum of the system in horizontal direction must be conserved</li><li>Velocity of center of mass of the system will be a constant</li><ol><br>Hence as in Q19, the velocity V<sub>cm</sub> is ~~\\hat{i}~~ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(55,'<p> Based on the paragraph, answer the following. <br><br>When block \'A\' comes to momentary rest during the compression process, the velocity of block \'B\' is </p>','0 m/s|:~~5/3 \\hat{i} m/s~~|:~~5/2 \\hat{i} m/s~~|:~~\\hat{i} m/s~~','2','<p> When block \'A\' comes to rest v<sub>a</sub> = 0<br><br>By conservation of linear momentum (COLM) <br><br>~~6 * 0 + 4 * v_b\\hat{i} = ~~ Initial Momentum ~~= 10 \\hat{i} ~~<br>  $$\\Rightarrow v_b = 10/4 \\hat{i} = 5/2 \\hat{i}$$ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(56,'<p> Based on the paragraph, answer the following.<br><br>When block \'A\' comes to momentary rest during the compression process, the compression in the spring is (in cms) </p>','~~6\\sqrt{3}~~|:~~6\\sqrt{2}~~|:9|:12','3','<p> Let x cm be the compression, applying conservation of energy (COE):$$ 1/2 * kx^2/100^2 + 0 + 1/2 * 4 * 25/4 = 35 $$ On Solving:<br>  $$x = 6\\sqrt{3} cm$$ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(57,'<p> Based on the paragraph, answer the following. <br><br>The maximum compression in the spring is (in cms)</p>','~~6\\sqrt{3}~~|:12|:15|:9','3','<p> During max compression ~~v_a = v_b~~, by COLM<br><br> ~~6 * v_a + 4 * v_b = 10 \\hat{i}~~ <br><br>~~v_a = v_b = \\hat{i}~~<br><br>By COE :<br> &nbsp &nbsp &nbsp ~~1/2 * kx_2 + 1/2 * (6+4) * 1^2 = 35~~ <br><br> On solving: x = 12 cm </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(58,'<p>A single force acting on a body exerts an impulse J changing its speed from u to v. The direction of force and the object\'s motion are along the same line. Then the work done by force is: </p>','~~J(v-u)~~|:~~J(v+u)~~|:$$J\\frac{(v+u)}{2}$$|:$$J\\frac{(v-u)}{2}$$','2','<p>By Work-Energy Theorem (W = ~~\\Delta~~KE) <br>\n W = 1/2 mv<sup>2</sup> - 1/2 mu<sup>2</sup>    - eqn 1 <br><br>\n\nBy Impulse-Momentum Theorem (Impulse = ~~\\Delta~~ p) <br>\n J = m(v-u)    - eqn 2 <br><br>\n \nFrom eqn 1 <br>\n W = m/2 (v-u) (v+u)<br>\nSubstituting value from eqn 2 $$W = J\\frac{v+u}{2}$$',35,1,'',1,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(59,'<p> A uniform rod of length \'L\' and density \'~~\\rho~~\' is pulled along a smooth horizontal floor with acceleration \'a\' by applying a horizontal force at one of its ends. Then the magnitude of the stress developed at the transverse cross-section through the midpoint of the rod is: </p>','~~\\rho~~La|:1/2~~\\rho~~La|:2~~\\rho~~La|:4~~\\rho~~La','1','<img src = \"../api/resources/questions/q59img1.jpg\"> <br>Cross-section of midpoint is shown - <br> \n $$ F = m * a$$\n $$= (\\rho AL) * a $$\n\nAt the midpoint, tension developed = F/2 <br> <br>\n\nAnd Stress = Force / Area = F/2A = ~~1/2 \\rho La~~\n',35,1,'',2,0,'../api/resources/questions/q59img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(60,'<p> A 2kg block rests on a frictionless incline of angle 30<sup>o</sup> supported by a spring as shown in the figure. Spring constant of the spring is 10 N/m. If the block is pulled down the incline 1 meter from the original position shown in the figure and then released, the spring force of the spring at the instant of release will be : </p><img src = \"../api/resources/questions/q60img1.jpg\">','10N|:5N|:15N|:20N','3','<p>At initial position ~~k(\\rho~~x) = mg sin~~\\Theta~~ <br><br>$$ \\Delta x = \\frac{2 *10 *1/2}{10} = 1m$$ Block is pulled further down by 1m <br><br>Hence total elongation = 2m <br><br>Spring Force = 2 x k = 20N </p>',35,1,'',1,0,'../api/resources/questions/q60img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(61,'<p> In the figure shown below, Initially the spring (of a spring constant\'k\') is unstretched when the block of mass \'m\' is released from rest. Assuming all contacting surfaces to be smooth.\nThe maximum stretch in the spring after the block is released will be: \n</p><img src = \"../api/resources/questions/q61img1.jpg\"> ','mg/k|:2mg/k|:mg/2k|:4mg/k','0','<p>Constraint relationship <br>\n~~x_1 + (x_1 - x_2) + \\pi~~ a = constant (length of string)\n\'a\' is radius of pulley and is also a constant </p> <img src = \"../api/resources/questions/q61img2.jpg\"> <p>Therefore, <br>   ~~2x_1 - x_2 = c~~ <br><br> For a change in x<sub>1</sub>, x<sub>2</sub> will be constrained as <br><br>    ~~ 2\\Delta x_1 - \\Delta x_2 = 0  \\Rightarrow \\Delta x_2 = 2\\Delta x_1~~ <br><br> When the spring stretches by length ~~(\\Delta x_2 = \\Delta l)~~ the pulley will move down by length ~~\\Delta x_1 = \\Delta l/2~~<br><br> <p>The stretch in the spring will be maximum when the block moves down and comes to momentary rest again. <br><br>\nConserving energy between this point and initial state: <br>  mg (~~\\Delta l/2) = 1/2k (\\Delta l)2 \\Rightarrow \\Delta l = mg/k~~</p>',35,1,'',1,0,'../api/resources/questions/q61img1.jpg|:../api/resources/questions/q61img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(62,'<p>In the figure shown below (spring constant \'k\'), assuming all contacting surfaces to be smooth. <br>\nThe stretch in the spring when the system is in equilibrium will be \n</p><img src = \"../api/resources/questions/q62img1.jpg\">','mg/k|:2mg/k|:mg/2k|:4mg/k','1','<p> Free Body Diagram at equilibrium </p><img src = \"../api/resources/questions/q62img2.jpg\"> <p> Let x be elongation in the spring at equilibrium. <br><br> kx = T/2 (for spring) <br>\nT = mg (for block) <br>\n=> x = mg/2k',35,1,'',2,0,'../api/resources/questions/q62img1.jpg|:../api/resources/questions/q62img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(63,'<p> 3 blocks of mass 1kg, 2kg and 3kg are in contact with each other on a frictionless horizontal floor. A horizontal force is applied so that all the blocks move together with a constant acceleration on 2m/s <sup>2</sup>. The contact force between block 1 and block 2 is: </p><img src = \"../api/resources/questions/q63img1.jpg\"> ','6N|:10N|:4N|:9N','1','<p> Free Body Diagram of blocks - </p> <img src = \"../api/resources/questions/q63img2.jpg\">  <p> $$F - N_1 = 1 * a$$\n$$N_1 - N_2 = 2 * a$$\n$$N_2 = 3 * a $$\nPutting a = 2m/~~s^2~~ and solving \n$$N_1 = 10N$$',35,1,'',3,0,'../api/resources/questions/q63img1.jpg|:../api/resources/questions/qq63img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(64,'<p>3 blocks of mass 2kg, 3kg, 5kg are connected by two light massless inextensible string as shown and lie on a smooth horizintal table. A force F = 20 N is applied on the 5 kg block. Tension in the string connecting the 3 kg and 5 kg blocks is:  (F to be updated on 5 kg block)</p><img src = \"../api/resources/questions/q64img1.jpg\"> ','6N|:8N|:16N|:10N','3','<p> Free Body Diagrams of blocks -</p><img src = \"../api/resources/questions/q64img2.jpg\"> <p> $$20 - T_1 = 5a$$ $$T_1 - T_2 = 3a$$ $$T_2 = 2a$$\nAdding the above equations\n$$ 10a = 20 \\Rightarrow a = 2m/s^2 $$\n$$T_1 = 10 N$$',34,1,'',2,0,'../api/resources/questions/q64img1.jpg|:../api/resources/questions/qq63img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(65,'<p>The equal weights A, B & C of mass 3 kg each are hanging on two light strings passing over a smooth fixed pulley as shown. When the system is released the tension in the string connecting weights \'B\' and \'C\' is: </p><img src = \"../api/resources/questions/q65img1.jpg\"> ','20N|:15N|:6N|:9N','0','<p>Free Body Diagrams of blocks -</p><img src = \"../api/resources/questions/q65img2.jpg\"> <img src = \"../api/resources/questions/q65img3.jpg\"> <p>Newton\'s II-Law for the 3 blocks, A: [T<sub>1</sub>-mg = ma]  B: [mg +T<sub>2</sub> - T<sub>1</sub>= ma] C: [mg-T<sub>2</sub> = ma] <br><br>On Adding mg = 3ma, <br>Therefore, a = g/3 and T<sub>2</sub> = 20N',34,1,'',3,0,'../api/resources/questions/q65img1.jpg|:../api/resources/questions/qq65img2.jpg|:../api/resources/questions/qq65img3.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(66,'<p> Two blocks \'A\' and \'B\' of mass m<sub>a</sub> and m<sub>b</sub> are connected together by a light massless spring on a smooth floor. A force \'F\' acts on mass \'B\' as shown. At the instant shown the block \'A\' has an acceleration \'a\' towards right. What is the acceleration of block \'B\' with respect to block \'A\'</p><img src=\"../api/resources/questions/q66img1.jpg\">','$$\\frac{F-(m_a+m_b)a}{m_b}$$|:$$\\frac{F+(m_a+m_b)a}{m_b}$$|:$$\\frac{F-(m_a+m_b)a}{m_a}$$|:$$\\frac{F-(m_a-m_b)a}{m_a}$$','0','<p>Free Body Diagrams of blocks - </p><img src=\"../api/resources/questions/q66img2.jpg\"><img src=\"../api/resources/questions/q66img3.jpg\"> <p>\n  <table> <tr><td>Block A:</td><td><td>&nbsp &nbsp &nbsp &nbsp></td><td>Block B:</td></tr><tr> kx = m<sub>a</sub>a</td><td></td><td> F - kx = m<sub>b</sub>a<sup>\'</sup><br> F - m<sub>a</sub>a = m<sub>b</sub>a<sup>\'</sup></td></tr></table>\nAcceleration of B relative to A  = a<sub>b</sub> - a<sub>a</sub> <br>\n     =$$a^{\'} - aa^{\'} - a = \\frac{F}{m_b}a - \\frac{m_a}{m_b}a = \\frac{F-(m_a+m_b) a} {m_b}$$',35,1,'',2,0,'../api/resources/questions/q66img1.jpg|:../api/resources/questions/q66img2.jpg|:../api/resources/questions/q66img3.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(67,'<p>The ~~\\Delta~~l of the spring when the block \'B\' just leaves contact from the wall is:</p>','~~+\\sqrt{\\frac{m}{k}v}~~|:~~+2\\sqrt{\\frac{m}{k}v}~~|:~~-\\sqrt{\\frac{m}{k}v}~~|:0','3','<p>Block \'B\' will leave contact from the wall when the spring force begins to act on it towards right. <br><br>Initially the spring compresses then comes back to natural length and then starts to elongate.<br><br>At this point, it just starts to elongate, the direction of force on Block B will be towards right and it leaves contact.<br><br>We know that at natural length, ~~\\Delta~~l = 0</p>',34,1,'',1,3,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(68,'<p>The speed of block \'A\' when block \'B\' just leaves contact from the wall is  </p>','2v|:v|:0|:~~\\sqrt{2}~~','1','<p>Block \'B\' will leave contact from the wall when the spring force begins to act on it towards right. <br><br>Initially the spring compresses then comes back to natural length and then starts to elongate. At this point, the direction of force on Block B will be towards right and it leaves contact.<br><br>By conservation of energy at this point:\n 1/2 mv<sup>2</sup> = 1/2 mv<sub>A</sub><sup>2</sup> (since ~~\\Delta~~l = 0)<br>  Therefore, v<sub>A</sub> = v  \n<br><br>Also note that the maximum elongation in the spring will be when both blocks move towards right with speed v/2</p>',34,1,'',2,3,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(69,'<p>A block of mass 20kg is suspended through two light spring balances as shown in the figure.<br>Then,<img src=\"../api/resources/questions/q69img1.jpg\"></p>','Both will show not reading|:Lower scale will show 20 kg reading and upper scale 0 kg|:Both will show 20 kg reading|:Their readings are in between 0 and 20 kg with their sum = 20kg','2','<p>Spring balance reads the force that acts on the spring side of the spring balance: <br> Free Body Diagram of the objects</p><img src=\"../api/resources/questions/q69img2.jpg\"><p>T = N = N<sup>\'</sup> = 20 kgf</p>',35,1,'',3,0,'../api/resources/questions/q69img1.jpg|:../api/resources/questions/q69img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(70,'<p>Reading of spring balance (A)~~\\rightarrow ~~X1 and spring balance (B)~~\\rightarrow~~X2 then </p><img src=\"../api/resources/questions/70img1.jpg\"><img src=\"../api/resources/questions/70img2.jpg\">','X<sub>1</sub> = X<sub>2</sub> = 8g|:X<sub>1</sub> < 8g , X<sub>2</sub> = 8g|:X<sub>1</sub> = 8g , X<sub>2</sub> < 8g|:X<sub>1</sub> > 8g , X<sub>2</sub> = 8g','1','<p>Making Free Body Diagrams: </p> <img src=\"../api/resources/questions/70img3.jpg\"><img src=\"../api/resources/questions/70img4.jpg\"><p>T<sub>1</sub> = 6g<br>T<sub>2</sub> = 8g\n',34,1,'',3,0,'../api/resources/questions/q70img1.jpg|:../api/resources/questions/q70img2.jpg|:../api/resources/questions/q70img3.jpg|:../api/resources/questions/q70img4.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(71,'<p>A string of negligible mass passing over a clamped pulley of mass \'m\' supports a block of mass \'M\' as shown. The magnitude of force by the clamp on the pulley is: </p><img src=\"../api/resources/questions/71img1.jpg\">','~~\\sqrt{2}mg~~|:~~\\sqrt{2}Mg~~|:~~(\\sqrt{(M+m)^2+m^2g})mg~~|:~~\\sqrt{M+m}^2+M^2g~~','3','<table><tr><td>Free body diagram of pulley:</td><td>&nbsp&nbsp&nbsp&nbsp&nbsp</td><td>Free body diagram of block:</td></tr></table><img src=\"../api/resources/questions/71img2.jpg\"><img src=\"../api/resources/questions/71img3.jpg\"><p>Let F be the force exerted by the clamp $$ F = \\sqrt{(T + mg)^2 + T^2}$$',35,1,'',2,0,'../api/resources/questions/q71img1.jpg|:../api/resources/questions/q71img2.jpg|:../api/resources/questions/q71img3.jpg|:../api/resources/questions/q71img4.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(72,'<p>The minimum value of \'F\' so that the blocks start sliding on the floor is: </p>','25N|:18N|:15N|:30N','0','<p>For the blocks to move the applied force must overcome the force of maximum static friction at both the blocks. </p><img src=\"../api/resources/questions/72img1.jpg\"><img src=\"../api/resources/questions/72img2.jpg\"><img src=\"../api/resources/questions/72img3.jpg\"><table><tr><td>~~(f_{s1})_{max}~~</td><td>= 0.5 * 3 * 10</td><td>&nbsp&nbsp&nbsp&nbsp</td> <td>~~(f_{s2})_{max}~~</td><td>= 0.5 * 2 * 10</td></tr><tr><td></td><td>= 15N</td><td></td><td></td><td>= 10N</td></tr></table><p>Hence F<sub>min</sub> = 25N and T = 10N </p>',33,1,'',2,4,'../api/resources/questions/q72img1.jpg|:../api/resources/questions/q72img2.jpg|:../api/resources/questions/q72img3.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(73,'<p>When F=20 N, The tension in the string is</p>','15N|:10N|:5N|:20N','2','<img src=\"../api/resources/questions/73img1.jpg\"><img src=\"../api/resources/questions/73img2.jpg\"> <p>For F=20 N, Free Body Diagram tells us<br><br>F = 20 N, T = 5 N<br><br>\n f<sub>s1</sub>= 15 N, f<sub>s2</sub>= 5 N\n',35,1,'',3,4,'../api/resources/questions/q73img1.jpg|:../api/resources/questions/q73img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(74,'<p>When F=20 N, The ratio of frictional force on the 2 kg block to that on the 3 kg block is</p>','2/3|:1/3|:1|:0','1','<img src=\"../api/resources/questions/74img1.jpg\"><img src=\"../api/resources/questions/74img2.jpg\"><p>From FBD -<br><br>F = 20 N, T = 5 N  f<sub>s1</sub>= 15N, f<sub>s2</sub>= 5N<br><br> f<sub>s2</sub>/f<sub>s1</sub> = 5/15 = 1/3',35,1,'',3,4,'../api/resources/questions/q74img1.jpg|:../api/resources/questions/q74img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(75,'<p>Which of the following statements is/are always true. </p>','If the net external force acting on a particle is zero, then the particle must be at rest.|:If a particle is at rest at some particular instant, then the net external force on it must be zero at that instant|:If the speed of a particle is changing with time, then the particle must be accelerated|:If a particle covers 0 distance in time \'st\' then its displacement in that time interval must be 0','2|:3','<p>(A) and (B) contradict Newton\'s laws <br><br>(C) and (D) are correct</p>',33,2,'',2,0,'',0,0,0,0,0,0,0,4,0,0,0,0,0,0,NULL,NULL),
	(76,'<p>Then after a very long time: </p>','Block will come to rest with respect to the plank|:Block will fall down from the plank|:Velocity of block will be 4m/s|:Friction force of the block will be 0','0|:2|:3','<p>As there is slipping between the block and the plank, frictional force will be kinetic in nature. </p><img src=\"../api/resources/questions/76img1.jpg\"><img src=\"../api/resources/questions/76img2.jpg\"><p>In the FBDs (only horizontal forces are shown)</p><table><tr><td>~~f_k = \\mu * N~~</td><td>&nbsp&nbsp&nbsp</td><td>= ~~\\mu~~ * (mass of block * g)<br>= 0.5 * 2 * 10 = 10N</td><tr><table><p>Taking right as the +ve direction ~~a_b = -5m/s^2~~ &nbsp &nbsp &nbsp &nbsp ~~a_p = 10/3 m/s^2~~<br><br>~~V_b = 10 - 5t~~ &nbsp &nbsp &nbsp &nbsp ~~ V_p = 0 + 10/3 t~~<br><br>When V<sub>b</sub> = V<sub>p</sub> , slipping will stop and friction force will disappear and both bodies will move together as a single unit. Equating the two -<br><br>10 - 5t = 10/3t <br>T = 1.2 sec<br>V<sub>b</sub> = V<sub>p</sub> = 4m/s </p>',33,2,'',2,5,'../api/resources/questions/q76img1.jpg|:../api/resources/questions/q76img2.jpg',0,0,0,0,0,0,0,4,0,0,0,0,0,0,NULL,NULL),
	(77,'<p>Loss in mechanical energy due to friction after a long time will be:</p>','84J|:60J|:24J|:100J','1','<p>Loss in mechanical energy = KE<sub>initial</sub> - KE<sub>final</sub><br><br> = 1/2 * 2 * 102 - [ 1/2 * 2 * 42 + 1/2 * 3 * 42] = 60J</p>',34,1,'',3,5,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(78,'<p>The position of a particle moving along the x-axis is expressed as x = at<sup>3</sup> + bt<sup>2</sup> + ct + d </p>','6a|:2b|:a+b|:a+c','1','<p>We know that -\n~~\\frac{\\mathrm{d}x }{\\mathrm{d} t} = v \\;\\;\\;\\;\n\\frac{\\mathrm{d}v }{\\mathrm{d} t} = a ~~\n$$\\Rightarrow \\frac{\\mathrm{d^2}x }{\\mathrm{d} t^2} = a$$\n=> Acceleration = 6at + 2b<br>\nSo, at t = 0, acceleration = 2b</p>',34,1,'',1,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(79,'<p>A particle projected vertically upwards returns to the ground in time T. Which graph best represents the correct variation of velocity (v) against time (T)  \n</p>','<img src=\"../api/resources/questions/q79img1.jpg\" />|:\n<img src=\"../api/resources/questions/q79img2.jpg\" />|:\n<img src=\"../api/resources/questions/q79img3.jpg\" />|:\n<img src=\"../api/resources/questions/q79img4.jpg\" />','0','<p>At t = 0, v = max velocity <br>\nAt t = t/2, v = 0  as it has reached its maximum height <br>\nAt t = t, v = -max velocity when it reaches the bottom <br>\n<br>\nThe graph would look like - <br>\n<img src = \"../api/resources/questions/q79img1.jpg\" />\n </p>',35,1,'',2,0,'../api/resources/questions/q79img1.jpg|:\n../api/resources/questions/q79img2.jpg|:\n../api/resources/questions/q79img3.jpg|:\n../api/resources/questions/q79img4.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(80,'<p>2 particles are simultaneously projected in opposite directions horizontally from a given point in space where gravity \'g\' is uniform. If u<sub>1</sub> and u<sub>2</sub> be their initial speeds, then the time \'t\' after which their  velocities are mutually perpendicular is given by - \n </p>','$$\\frac{\\sqrt{u_1u_2}}{g}$$|:\n$$\\frac{\\sqrt{u_1^2+u_2^2}}{g}$$|:\n$$\\frac{\\sqrt{u_1(u_1+u_2)}}{g}$$|:\n$$\\frac{\\sqrt{u_2(u_1+u_2)}}{g}$$','0','<p>Drawing the vector diagram: <br>\n<img src=\"../api/resources/questions/q80img1.jpg\" /> <br>\n$$tan\\theta=\\frac{gt}{u_1}=\\frac{u_2}{gt}$$\n$$\\Rightarrow (gt)^2 = u_1u_2 $$\n$$\\Rightarrow t = \\frac{\\sqrt{u_1u_2}}{g}$$\n </p>',35,1,'',1,0,'../api/resources/questions/q80img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(81,'<p>The velocity v of a particle as a function of its position (x) is expressed as \n~~v = \\sqrt{c_1 - c_2x}~~\nWhere c<sub>1</sub> and c<sub>2</sub> are positive constants. The acceleration of the particle is:\n</p>','c<sub>2</sub>|:\n(c<sub>1</sub> + c<sub>2)/2</sub>|:\nc<sub>1</sub> - c<sub>2</sub>|:\n-c<sub>2</sub>','3','<p>$$a = \\frac{\\mathrm{d}v }{\\mathrm{d} t} = \\frac{\\mathrm{d}v }{\\mathrm{d} x} \\frac{\\mathrm{d}x }{\\mathrm{d} t}  = v \\frac{\\mathrm{d}v }{\\mathrm{d} x}$$\n\nBut ~~v = \\sqrt{c_1 - c_2x}~~\n\n$$a = \\frac{\\mathrm{d}v }{\\mathrm{d} t} = \\frac{\\mathrm{d}v }{\\mathrm{d} x} \\frac{\\mathrm{d}x }{\\mathrm{d} t}  = v \\frac{\\mathrm{d}v }{\\mathrm{d} x}$$\n\n$$\\therefore a = \\sqrt{c_1 - c_2x}\\;\\:  \\frac{\\mathrm{d} (\\sqrt{c_1 - c_2x)}}{\\mathrm{d} x}) $$\n\n$$a = \\sqrt{c_1 - c_2x}\\;\\:  \\frac{-c_2}{2\\sqrt{c_1 - c_2x}}$$\n\n$$a = -\\frac{c_2}{2} $$ \n</p>',34,1,'',1,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(82,'<p>Which of the following do not represent uniformly accelerated motion ?</p>','$$x = \\sqrt{\\frac{(t+a)}{b}}$$|:\n$$x = \\frac{(t+a)}{b}$$|:\n$$t = \\sqrt{\\frac{(x+a)}{b}}$$|:\n$$x = \\sqrt{(t+a)}$$','0|:1|:3','<p>In the case of uniform acceleration, x can be expressed as a function of t of the form:<br>\nx = at<sup>2</sup> + bt + c<br>\nOnly in option ( C ) is the equation of the above form: bt<sup>2</sup> = x + a </p>',34,2,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(83,'<p>3 particles A, B and C are projected from the top of a tower with the same speed - A is thrown straight upwards, B straight down and C horizontally. They hit the ground with speeds v<sub>A</sub>, v<sub>B</sub> and v<sub>C</sub> Which of the following is correct?</p>','~~v_A = v_B = v_C~~|:~~v_A = v_B > v_C~~|:~~v_A > v_B = v_C~~|:~~v_B > v_C > v_A~~','0','<p><img src=\"../api/resources/questions/q83img1.jpg\" />\n<img src=\"../api/resources/questions/q83img2.jpg\" />\n<img src=\"../api/resources/questions/q83img3.jpg\" /> <br> \nIn all cases particle was projected from a same height and with same speed but different direction. From the work energy theorem - \nCase A: ~~\\frac{1}{2}mv^2 + mgh = \\frac{1}{2}mv_a^2~~<br>\nCase B: ~~\\frac{1}{2}mv^2 + mgh = \\frac{1}{2}mv_b^2~~<br>\nCase C: ~~\\frac{1}{2}mv^2 + mgh = \\frac{1}{2}mv_c^2~~<br>\n\nFrom the above equations, we see that - \n~~v_A = v_B = v_C~~\n</p>',34,1,'',3,0,'../api/resources/questions/q83img1.jpg|:\n../api/resources/questions/q83img2.jpg|:\n../api/resources/questions/q83img3.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(84,'<p>A particle moves in the x-y plane according to the equations\n~~x = a\\: sinwt \\; y = bsin \\: wt~~ </p>','A parabolic path|:A circular path|:A straight line having slope b/a|:An elliptical path','3','<p>~~x = a\\: sinwt \\; y = bcos \\: wt~~\nSquaring both sides - <br>\n~~x^2 = a^2\\: sin^2wt \\;\\: y^2 = b^2cos^2wt~~ \n\n$$\\frac{x^2}{a^2} = \\: sin^2wt \\;\\: \\frac{y^2}{b^2} = cos^2wt$$\n\nAdding the 2 equations  - \n$$\\frac{x^2}{a^2}+\\frac{y^2}{b^2} = 1$$ <br>\nWhich is the equation of an elliptical path\n</p>',35,1,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(85,'<p>A projectile can have same range from 2 angles of projection with same initial speed. If h1 and h2 be the maximum heights, then\n</p>','R = ~~\\sqrt{h_1h_2}~~|:~~R = \\sqrt{2h_1h_2}~~|:R = ~~2\\sqrt{h_1h_2}~~|:R =~~ 4\\sqrt{h_1h_2}~~','2','<p>For same range, angle of projection should be θ and (90 - \\theta)\n$$R_1 = \\frac{u^2 sin2\\theta}{g} \\;  R_2 = \\frac{u^2 sin[2(90 - \\theta)]}{g}$$\n\n$$R_1 = R_2 = \\frac{u^2 sin2\\theta}{g}$$\n\n$$h_1 = \\frac{u^2 sin^2\\theta}{g}$$\n$$h_2 = \\frac{u^2 sin^2(90 - \\theta)}{g} = \\frac{u^2 cos^2\\theta}{g}$$\n\nMultiplying h<sub>1</sub> and h<sub>2</sub>, we get -\n$$h_1h_2 = \\frac{u^4 sin^2\\theta cost^2\\theta}{g^2} = \\frac{u^4 (sin2\\theta)^2}{g^2} = \\frac{R^2}{4}$$\n\n$$R = 2\\sqrt{h_1h_2}$$\n\n</p>',35,1,'',3,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(86,'<p>A particle A moves due north at 3 km/hr; another particle due west at 4 km/hr. Find the relative velocity of A w.r.t. B, and its direction\n </p>','5 km/hr, 37<sup>o</sup> north of east of B|:\n5 km/hr, 37<sup>o</sup> east of north of B|:\n5 km/hr, 45<sup>o</sup> east of north of B|:\n5 km/hr, 53<sup>o</sup> north of east of B','3','<p>Draw vector diagram - \n\n<img src =\"../api/resources/questions/q86img1.jpg\" />\n\n~~\\underset{v_A}{\\rightarrow}~~ = 3 km/hr towards North\n~~\\underset{v_B}{\\rightarrow} ~~ = 4 km/hr towards West\n~~\\underset{v_AB}{\\rightarrow} ~~ = 5 km/hr towards 37<sup>o</sup> North of East (from the figure)</p>',35,1,'',2,0,'../api/resources/questions/q86img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(87,'<p>A body moving with a uniform acceleration has velocities of u and v when passing through points A and B in its path. The velocity of the body midway between A and B is</p> \n ','$$\\frac{u+v}{2}$$|:$$\\frac{\\sqrt{uv}}{2}$$|:$$\\frac{\\sqrt{u^2 + v^2}}{2}$$|:None of these','2','<p> <img src= \"../api/resources/questions/q87img1.jpg\" /> <br>\n\n$$a = \\frac{{v^2 - u^2}}{2S}$$\n<br>\nFor a distance S/2:\n$$v\'^2 = u^2 + 2a\\frac{S}{2}$$\n$$v\'^2 = u^2 + 2\\frac{v^2 - u^2}{2S}\\frac{S}{2}$$\n$$v\'^2 = u^2 + \\frac{v^2 - u^2}{2}$$\n\n$$v\' = \\sqrt{\\frac{u^2 + v^2}{2}}$$</p>',34,1,'',1,0,'../api/resources/questions/q87img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(88,'<p>2 cars are moving in the same direction with same speed of 30 km/h. They are separated by a distance of 5 km. What is the speed of a car moving in the opposite direction if  it crosses the 2 cars at an interval of 4 minutes?\n</p>','45 km/hr|:35 km/hr|:25km/hr|:12.5 km/h','0|:3','<p>The distance between the 2 cars = 5 km<br>Let the speed of the car is v. So,<br>\n$$ \\frac{5}{30+v} = 4\\; mins = \\frac{1}{15} \\;hr$$\nv + 30 = 75\n<br>v = 45 km/hr\n<br>Converting to m/s, we get - <br>v = 12.5 m/s</p>',34,2,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(89,'<p>2 ships are resting on sea at distances a and b from a fixed point O respectively. They start moving towards the point O with constant velocities v1 and v2. If the ships subtend an angle θ at O, find the shortest distance of their separation\n </p>','$$\\frac{(av_2 - bv_1)sin\\theta}{\\sqrt{v_1^2 + v_2^2 - 2v_1v_2cos\\theta}}$$|:\n$$\\frac{(av_2 - bv_1)cos\\theta}{\\sqrt{v_1^2 + v_2^2 - 2v_1v_2cos\\theta}}$$|:\n$$\\frac{(av_2sin\\theta - bv_1cos\\theta)}{\\sqrt{v_1^2 + v_2^2 - 2v_1v_2cos\\theta}}$$|:\n$$\\frac{(av_2cos\\theta - bv_1sin\\theta)}{\\sqrt{v_1^2 + v_2^2 - 2v_1v_2cos\\theta}}$$','0','<p><img src= \"../api/resources/questions/q89img1.jpg\" /> <br>Separation S = AB\n~~=OA^2 + OB^2 - 2OAOBcos\\theta~~\n\nwhere OA = (a - v<sub>1</sub>t) ; OB  = (b - v<sub>2</sub>t)\n\nFor S to be least -\n$$\\frac{\\mathrm{d}S^2 }{\\mathrm{d} t} = 0  \\;\\;\\;(i) $$\n$$ \\frac{\\mathrm{d^2}S^2 }{\\mathrm{d} t^2} > 0 \\;\\;\\;(ii)$$\n\nDifferentiating both sides wrt t and applying condition (i) -\n\n~~2 (a - v_1t) (-v_1) + 2 (-v2) (b - v2t) \n          + 2av_2 (cosθ) + 2bv_1cos θ  - 4v_1v_2(cos θ)t  = 0~~\n<br> Solving for t, \n$$t = \\frac{av_1 + bv_2  - (av1+bv2)cos\\theta}{v_1^2 + v_2^2 - 2v_1v_2cos\\theta}$$\n<br>\nSubstituting values for S, we get - \n $$S = \\frac{(av_2 - bv_1)sin\\theta}{\\sqrt{v_1^2 + v_2^2 - 2v_1v_2cos\\theta}}$$\n</p>',35,1,'',3,0,'../api/resources/questions/q89img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(90,'<p>On a cricket field, the batsman is at the origin of co-ordinates and a fielder stands in position ~~(46 \\vec{i} + 28 \\vec{j})~~ m. The batsman hits the ball so it rolls along the ground with constant velocity (7.5i  + 10j ) m/s. The fielder can run with a speed of 5 m/s. If he starts to run immediately after the ball is hit, what is the shortest time in which he could intercept the ball?\n</p>','','4','<p>The ball\'s position at time t, ~~(7.5) t \\hat{ i}  +  (10)t \\hat{j}~~ <br>\nLet the fielder run with velocity  ~~5(cos\\theta \\vec{i} + sin\\theta \\vec{j})~~ <br>\n\nAt interception of ball by fielder, we can equate components - <br>\n~~7.5t = 46 + 5tcos\\theta~~ <br>\n~~10t = 28 + 5tsin\\theta~~ <br>\n\nUsing ~~cos^2\\theta + sin^2\\theta = 1~~ <br>\n~~(\\frac{7.5t - 46}{5t})^2 + (\\frac{10t - 28}{5t})^2 = 1~~ <br>\nWhich simplifies to ~~t\\approx4s~~</p>',35,3,'',3,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(91,'<p>The driver of a train moving at a speed v1 sights a goods train a distance \'d\' ahead of him on the same track moving in the same direction with a slower speed v2. He puts on brakes and gives his train a constant retardation \'a\'. There will be no collision for a minimum distance of \n</p>','$$\\frac{at^2}{2}$$|:$$2(v_1  - v_2)t - \\frac{at^2}{2}$$|:$$(v_1  - v_2)t - \\frac{at^2}{4}$$|:$$(v_1  - v_2)t - \\frac{at^2}{2}$$','3','<p>Train A has retardation \'a\' and a relative velocity ~~v_1 - v_2~~\n<br>\nIf the train has to stop (w.r.t. train B) before distance \'d\' - <br><br>\n\n~~S = (v_1 - v_2)t - \\frac{at^2}{2}~~<br><br>\nThe minimum distance \'d\' is \n~~(v_1 - v_2)t - \\frac{at^2}{2}~~\n</p>',34,1,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(92,'<p>A motor boat with its engine on, running along the river and blown over by a horizontal wind, is observed to travel at 20km/hr in a direction 53<sup>o</sup> east of north. The velocity of the boat with its engine on, in still water and blown over by the horizontal wind is 4 km/hr eastward and the velocity of the boat with its engine on, over the running river in the absence of wind is 8 km/hr south. The velocity of the boat in magnitude is </p>','13.75 km/hr|:29 km.hr|:23.3 km/hr|:31.1 km/hr','2','<p>~~\\vec{v_b}~~ = Velocity of boat over still water <br>\n~~\\vec{v_w}~~  = Velocity of wind wrt ground <br>\n~~\\vec{v_r}~~ = Velocity of river wrt ground <br>\n<br>~~\\vec{v_b} + \\vec{v_w} +\\vec{v_r} = 20(sin 53^o \\vec{i} + cos 53^o \\vec{j})~~ <br>\n~~\\vec{v_b} + \\vec{v_w} = 4 \\vec{i}~~\n~~\\vec{v_b} + \\vec{v_r} = -8 \\vec{j}~~\n<br>\nSolving equations, we get - <br>\n~~v_b = -12\\vec{i} - 20\\vec{j}~~<br>\n\n~~\\left |\\vec{v_b}  \\right | = 23.32 km/hr~~</p>',34,1,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(93,'<p>An observer in a train moving with a uniform velocity finds that a car moving parallel to the train has a speed of 10 km/hr in the direction of motion of the train. An object falls from the car and the observer in the train notices that the car has moved on for one minute, turned back, and moved with a speed of 10 km/hr and picked up the object 2 minutes after turning. Find the velocity of the train relative to the ground. \nAssume that the object comes to rest immediately after fall from the point of view of the observer on the ground\n</p>','3.34 km/hr|:6.67 km/hr|:13.34 km/hr|:None of these','0','<p>Velocity of train wrt ground                         = ~~v_T~~ <br>\nVelocity of car in the first part of journey    = ~~v_e~~ <br>\nVelocity of car in the first part of journey    = ~~v\'_e~~ <br>\nDistance of the point where the object fell  = xkm <br>\n\n~~v_e - v_T = \\frac{1}{6}~~  (km/min) <br>\n ~~v\'_e + v_T = \\frac{1}{6}~~  (km/min) <br>\n~~(\\frac{x}{v_e} = 1~~ <br>\n~~(\\frac{x}{v\'_e} = 2~~<br>\nSolving these, we get - \n~~v_T  = 3.34 km/hr~~\n</p>',35,1,'',3,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(94,'<p>An elevator ascends with an upward acceleration of 1.2 m/s<sup>2</sup>. At the instant when its upward speed is 2.4 m/s, a loose bolt drops from the ceiling of the elevator 2.7m above the floor of the elevator. Calculate the time of flight of the bolt from the ceiling to the floor \n</p>','0.7s|:0.3s|:0.9s|:0.5s','0','<p>Let <br>\nDownward displacement of bolt relative to shaft       = ~~r_1~~ <br>\nUpward displacement of lift before bolt reaches floor=  ~~r_2~~<br>\n\nThen ~~r_1 = -2.4t + \\frac{1}{2} 9.8 t^2 = -2.4t + 4.9t^2~~  <br>\n~~r_2 = 2.4t + \\frac{1}{2} 1.2 t^2 = 2.4t + 0.6t^2~~ <br>\n\nBut ~~r_1 + r_2~~ = 2.7m <br>\n\n~~5.5t^2 = 2.7~~ <br>\n~~t = 0.7s~~    (neglecting negative value)\n   \n</p>',35,1,'',3,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(95,'<p>A 2m wide truck is moving with uniform speed 8m/s along a straight horizontal road. A man starts to cross the road with a uniform speed v when the truck is 4m away from him. What is the minimum value of v, so that the man can cross the road safely?</p>','~~\\frac{6}{\\sqrt{5}}m/s~~|:\n~~\\frac{4}{\\sqrt{5}}m/s~~|:\n~~\\frac{3}{\\sqrt{5}}m/s~~|:\n~~\\frac{8}{\\sqrt{5}}m/s~~','3','<img src=\"../api/resources/questions/q95img1.jpg\" />\n<p>For safe crossing, the man must reach R by the time truck covers a distance equal to  (4 + 2cotθ)\n\nSo,\n$$\\frac{4+2cot\\theta }{8} = \\frac{2}{vsin\\theta}$$\n$$\\Rightarrow v = \\frac{ 8}{2sin\\theta + cos\\theta}$$\nFor v to be minimum,<br>\n$$ \\frac{\\mathrm{d}v }{\\mathrm{d} \\theta} = 0$$\n$$\\Rightarrow  2 cos\\theta  - sin\\theta  = 0$$\n$$\\Rightarrow tan\\theta  = 2$$\nSubstituting values, we get\nv = ~~\\frac{8}{\\sqrt{5}}~~ m/s\n</p>',35,1,'',2,0,'../api/resources/questions/q95img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(96,'<p>A boy is running on a horizontal road with a velocity of 5 m/s. At what angle should he hold his umbrella in order to protect himself from the rain, if the rain is falling vertically with a velocity of 10 m/s\n</p>','~~tan^{-2}~~|:\n~~cos^{-1}({\\frac{1}{\\sqrt{5}}})~~|:\n~~sin^{-1}({\\frac{1}{\\sqrt{5}}})~~|:\n~~cos^{-1}(\\sqrt{5})~~','0|:1','<p> To obtain the relative velocity of rain w.r.t boy, a velocity triangle is formed between v<sub>b</sub> and v<sub>r</sub> as shown:\n<img src=\"../api/resources/questions/q96img1.jpg\" />\n<br>\n~~tan\\Theta~~ = (10/5) = 2<br>\n~~\\Theta~~ = tan<sup>-1</sup>(2)\n</p>',35,2,'',2,0,'../api/resources/questions/q96img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(97,'<p>A train moves due east with a velocity of <sub>v_1</sub>  = 20 m/s and a car moves due north with a velocity of <sub>v_2</sub> = 15 m/s. Find the velocity of the car as observed by a passenger sitting in the train\n</p>','25 m/s at an angle tan<sup>-1</sup>(4/3) north of west|:\n25 m/s at an angle tan<sup>-1</sup>(4/3) west of north|:\n25 m/s at an angle tan<sup>-1</sup>(5/3) west of north|:\n25 m/s at an angle tan<sup>-1</sup>(5/3) north of west\n\n','1','<p> <img src=\"../api/resources/questions/q97img1.jpg\" />\n\nMagnitude: ~~\\vec{v_21} = \\left |\\vec{v_2} - \\vec{v_1}  \\right |~~ <br>\n ~~\\vec{v_21} = \\sqrt{v_1^2 + v_2^2} ~~\n ~~\\vec{v_21} = 25m/s~~\n\nDirection:  ~~\\vec{v_21}~~ <br> \n~~tan^{-1}(20/15)~~ <br>\n~~tan^{-1}(4/3)~~ west of north\n\n</p>',34,1,'',3,0,'../api/resources/questions/q97img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(98,'<p>If potential difference across ~~3\\mu~~ F is 4V, then total energy stored in all capacitors is:\n<img src=\"../api/resources/questions/q98img1.jpg\" />\n </p>','~~400\\mu~~ J|:~~800\\mu~~ J|:~~1200\\mu~~ J|:Cannot be calculated as emf of cell is not given','1','<p><img src=\"../api/resources/questions/q98img2.jpg\" />\n~~V_{BC}  = 4V~~ <br>\n~~C_{eq} (B,C) = 3\\mu F + 5\\mu F + 2\\mu F = 10\\mu F~~ <br>\nq stored in ~~10\\mu F~~ is: <br>\n~~q = 10\\mu F. 4V = 40\\mu C~~ <br>\nNow  5~~\\mu~~ F,  10~~\\mu~~ F and  10/7~~\\mu~~ F are in series combination. <br>\nHence q through them is the same, i.e. 40~~\\mu~~ C <br>\nAlso ~~C_{eq}~~ across AB is <br>\n$$\\frac{1}{C_{eq}} = \\frac{1}{5} + \\frac{1}{10} + \\frac{1}{\\frac{10}{7}}$$\n~~C_{eq} = 1\\mu F~~ <br>\n\nTherefore, energy stored is - <br>\n~~\\frac{q^2}{2C} = \\frac{(40\\mu C)^2}{(2.1\\mu F)} = 800\\mu J~~</p>',61,1,'',1,0,'../api/resources/questions/q98img1',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(99,'<p>The equivalent capacitance between the points A and B of a combination shown in the figure is: \n<img src=\"../api/resources/questions/q99img1.jpg\" />\n</p>','C|:2C|:C/2|:None of these','1','<p><img src=\"../api/resources/questions/q99img2.jpg\" /> <br>\nUsing series combination of capacitors, this can be modified into - <br>\n<img src=\"../api/resources/questions/q99img3.jpg\" /> <br>\nFurther simplifies to - \n<img src=\"../api/resources/questions/q99img4.jpg\" /> <br>\nNow since points ‘A’, ‘B’, ‘C’ and ‘D’ are all connected by superconductors. Hence potential is same for all. Hence ~~C_A~~ and ~~C_B~~ are short circuited.\n<img src=\"../api/resources/questions/q99img5.jpg\" /> <br>\n~~\\Rightarrow C_{eq} = 2C~~</p>',63,1,'',2,0,'../api/resources/questions/q99img1|:../api/resources/questions/q99img2|:../api/resources/questions/q99img3|:../api/resources/questions/q99img4|:../api/resources/questions/q99img5',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(100,'<p>A capacitor of capacitance ~~C_1~~ and potential difference \nV is connected across an uncharged capacitor of capacity ~~C_2~~. The new potential difference across each capacitor is:\n </p>','$$\\frac{C_1V}{C_1 + C_2}$$|:\n$$\\frac{C_2V}{C_1 + C_2}$$|:\n$$\\frac{C_1 + C_2}{V}$$|:\nNone of these','0','<p><img src=\"../api/resources/questions/q100img1.jpg\" /> <br>\n~~C_1~~ is charged to potential difference V, hence it has q=~~C_1~~V\n<img src=\"../api/resources/questions/q100img2.jpg\" /> <br>\nNow when they are connected, q flows out of ~~C_1~~ and stores at ~~C_2~~ such that potential across them becomes same\n$$\\frac{C_1V - q}{C_1} = \\frac{q}{C_2}$$\n$$q = \\frac{C_1C_2V}{C_1 + C_2}$$\n$$\\therefore  V_{C_2} = \\frac{q}{C_2} $$\n\n$$=\\frac{C_1V}{C_1 + C_2}$$\n </p>',63,1,'',1,0,'../api/resources/questions/q100img1.jpg|:\n../api/resources/questions/q100img2.jpg|:',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(101,'<p>There are two concentric metallic spherical shells A and B as shown in the figure.  If A is earthed and shell B is given a charge \'Q\' then the \'E\' and \'V\' at ~~r( a\\leq  r \\leq  b)~~ <img src=\"../api/resources/questions/q101img1.jpg\" />\n</p>','$$\\frac{-aQ}{4\\pi \\epsilon b r^2}\\; , \\;  \\frac{Q}{4\\pi \\epsilon b }(1 + \\frac{b}{r})$$|:\n$$\\frac{-aQ}{4\\pi \\epsilon b r^2}\\; , \\;  \\frac{Q}{4\\pi \\epsilon b }(1 - \\frac{b}{r})$$|:\n$$\\frac{-aQ}{4\\pi \\epsilon b r^2}\\; , \\;  \\frac{Q}{4\\pi \\epsilon b }(1 - \\frac{a}{r})$$|:\nNone of these','2','<p>Lets assume charge ~~q~~ accumulates on the small sphere <br>\n<img src=\"../api/resources/questions/q101img1.jpg\" />\n$$V_p = \\frac{q}{4\\pi \\epsilon a} + \\frac{Q}{4\\pi \\epsilon b}$$\n$$V_p = 0$$\n$$\\therefore \\frac{q}{4\\pi \\epsilon a} + \\frac{Q}{4\\pi \\epsilon b} = 0$$\n$$q =  - \\frac{aQ}{b}$$\n<br>\n~~E~~ at ~~r~~ (~~a\\leq r\\leq b~~) <br>\n$$ = \\frac{-aQ}{4\\pi \\epsilon b r^2} $$\n\n<br>Now calculating ~~V~~ at ~~r~~ (~~a\\leq r\\leq b~~) <br>\n$$=\\frac{q}{4\\pi \\epsilon r} + \\frac{Q}{4\\pi \\epsilon b}$$\n$$=\\frac{aQ}{4\\pi \\epsilon b r} + \\frac{Q}{4\\pi \\epsilon b}$$\n$$\\frac{Q}{4\\pi \\epsilon b }(1 - \\frac{a}{r})$$\n</p>',61,1,'',1,0,'../api/resources/questions/q101img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(102,'<p>The equivalent capacitance of a combination shown in the figure:\n<img src=\"../api/resources/questions/q102img1.jpg\" />\n </p>','C|:\n2C|:\nC/2|:\nNone of these','1','<p><img src=\"../api/resources/questions/q102img2.jpg\" /> \n<br>\n~~C_{AB}~~ is short-circuited. Therefore the circuit becomes :  \n<img src=\"../api/resources/questions/q102img3.jpg\" /> \n~~\\therefore C_{eq} = 2C~~\n</p>',61,1,'',2,0,'../api/resources/questions/q102img1.jpg|:../api/resources/questions/q102img2.jpg|:../api/resources/questions/q102img3.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(103,'<p>Figure shows a spherical capacitor of capacitance C whose inner and outer radii are R and 2R respectively. The new capacitance of the system if these two spheres are connected by a thin wire is: <br>\n<img src=\"../api/resources/questions/q103img1.jpg\" />\n </p>','C|:\n2C|:\n0|:\nInfinity','1','<p>If 2 plates of a capacitor are connected by any metallic wire, it gets short-circuited. So, initially\n$$C = \\frac{4\\pi \\epsilon}{(\\frac{1}{R} -  \\frac{1}{2R})}    =  4\\pi \\epsilon R$$\nAfter short circuit, the potential of the outer and inner sphere becomes the same. Hence outer sphere acts as a capacitor. <br>\n$$C\' = \\frac{4\\pi \\epsilon}{(\\frac{1}{2R} -  \\frac{1}{\\infty })}    =  4\\pi \\epsilon (2R)$$\n<br> ~~\\therefore C\' = 2C~~\n\n</p>',62,1,'',3,0,'../api/resources/questions/q103img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(104,'<p>The figure shows a circuit of four capacitors. The effective capacitance between X and Y is <br>\n<img src=\"../api/resources/questions/q104img1.jpg\" />\n</p>','~~\\frac{5}{6}\\mu F~~|: ~~\\frac{7}{6}\\mu F~~|: ~~\\frac{5}{3}\\mu F~~|: ~~1\\mu F~~','2','<p><img src=\"../api/resources/questions/q104img2.jpg\" /> <br>\nWhich can be simplified to - \n<img src=\"../api/resources/questions/q104img3.jpg\" /> <br>\nNow,  <br>\n~~C_{eq}(AB) = 2\\mu F~~ <br>\n\nBy series combination of capacitors - <br>\n$$C_{eq}(AC) = \\frac{1.2}{1+2} = \\frac{2}{3}\\mu F$$\n\nBy parallel combination of capacitors - <br>\n$$C_{eq}(AC) = \\frac{1.2}{1+2} = \\frac{2}{3}\\mu F$$\n\n</p>',62,1,'',2,0,'../api/resources/questions/q104img1.jpg|:\n../api/resources/questions/q104img2.jpg|:\n../api/resources/questions/q104img3.jpg\n',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(105,'<p>Effective capacitance of the shown network across any two junctions is  (if the capacitance of each capacitor is C) : <br>\n<img src=\"../api/resources/questions/q105img1.jpg\" />\n</p>','C/2|:C|:3C/2|:2C','3','<p><img src=\"../api/resources/questions/q105img1.jpg\" />\n\nThis translates to the following circuit - <br>\n<img src=\"../api/resources/questions/q105img2.jpg\" /> <br>\n\nFor loop BADEB \nUsing the wheatstone bridge principle - \n~~\\frac{C_{AB}}{C_{BC}} = \\frac{C_{AD}{C_{CD}}~~\n\nC_{eq} of BADEB is C <br>\n<img src=\"../api/resources/questions/q105img3.jpg\" /> <br>~~\\therefore C_{eq} = 2C~~\n</p>',63,1,'',3,0,'../api/resources/questions/q105img1.jpg|:\n../api/resources/questions/q105img2.jpg|:\n../api/resources/questions/q105img3.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(106,'<p>The total capacity of the system of capacitors between M and N is: <br>\n<img src=\"../api/resources/questions/q106img1.jpg\" />\n </p>','~~1\\mu F~~|:~~2\\mu F~~|:~~3\\mu F~~|:None of these','0','<p>Simplifying the given circuit in a series of steps using series and parallel combination - <br>\n<img src=\"../api/resources/questions/q106img1.jpg\" /> <br>\n<img src=\"../api/resources/questions/q106img2.jpg\" /> <br>\n<img src=\"../api/resources/questions/q106img3.jpg\" /> <br>\n<img src=\"../api/resources/questions/q106img4.jpg\" /> <br>\n<img src=\"../api/resources/questions/q106img5.jpg\" /> <br> \n<img src=\"../api/resources/questions/q106img6.jpg\" /> <br>\n~~C_{eq} = 1\\mu F~~\n</p>',61,1,'',2,0,'../api/resources/questions/q106img1.jpg|:../api/resources/questions/q106img2.jpg|:../api/resources/questions/q106img3.jpg|:../api/resources/questions/q106img4.jpg|:../api/resources/questions/q106img5.jpg|:../api/resources/questions/q106img6.jpg|:\n\n',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(107,'<p>A parallel plate capacitor of area A, plate separation d and capacitance C is filled with three different dielectric materials having dielectric constants ~~k_1~~, ~~k_2~~ and ~~k_3~~ as shown.  If a single dielectric materials is to be used to have the same capacitance C in this capacitor, then its dielectric constant ~~k~~ is given by\n<img src=\"../api/resources/questions/q107img1.jpg\" /> </p> \n ','$$\\frac{1}{k} = \\frac{1}{2(k_1+k_2)} + \\frac{1}{2k_3}$$ |:\n$$\\frac{1}{k} = \\frac{1}{k_1+k_2} + \\frac{1}{2k_3} $$|:\n$$k = \\frac{k_1k_2}{k_1+k_2} + 2k_3 $$|:\n~~k = k_1 + k_2 + k_3~~','2','<p> The capacitor C3 can be split into - <br>\n<img src=\"../api/resources/questions/q107img2.jpg\" /> <br>\nC2 and C3 can be split as follows: <br>\n<img src=\"../api/resources/questions/q107img3.jpg\" /><br>\n~~C_{eq1}~~ of ~~C1~~ and ~~C2~~ = ~~C1~~ + ~~C2~~  = \n$$(k_1 + k_2) \\frac{A\\epsilon}{d} $$<br>\n\n$$C_{eq} = \\frac{C_{eq1} C3}{C_{eq1}+C3}$$\nSubstituting values for ~~C_{eq1}~~ and C3 - <br> \n$$C_{eq} = \\frac{2k_3 (k_1 + k_2)}{k_1 + k_2 + 2k_3} \\frac{A\\epsilon}{d}$$\nTo calculate equivalent capacitance - \n$$C_{eq} = K_{eq} \\frac{A\\epsilon}{d}$$ $$\\therefore \\frac{1}{k} = \\frac{1}{k_1+k_2} + \\frac{1}{2k_3} $$',63,1,'',1,0,'../api/resources/questions/q107img1.jpg|:\n../api/resources/questions/q107img2.jpg|:\n../api/resources/questions/q107img3.jpg|:',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(108,'<p>Equivalent capacitance between 2 and 3 of the arrangement shown having plate area A is \n<img src=\"../api/resources/questions/q108img1.jpg\" />\n</p>','$$\\frac{2A\\epsilon}{d} $$|:\n$$\\frac{3A\\epsilon}{d}$$ |:\n$$\\frac{A\\epsilon}{d}$$|:\nNone of these','1','<p>Converting the circuit in a series of steps - <br>\n<img src=\"../api/resources/questions/q108img1.jpg\" /> <br>\n~~\\Rightarrow~~ <img src=\"../api/resources/questions/q108img2.jpg\" /> <br>\n~~\\Rightarrow~~ <img src=\"../api/resources/questions/q108img3.jpg\" /> <br>\n~~\\Rightarrow~~ <img src=\"../api/resources/questions/q108img4.jpg\" /> <br>\n\n$$\\therefore C_{eq} = \\frac{C}{2} + C = \\frac{3C}{2} = \\frac{3A\\epsilon }{d}$$\n',62,1,'',2,0,'../api/resources/questions/q108img1.jpg|:\n../api/resources/questions/q108img2.jpg|:\n../api/resources/questions/q108img3.jpg|:\n../api/resources/questions/q108img4.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(109,'<p>The effective capacity between A and B in figure shown:\n<img src=\"../api/resources/questions/q109img1.jpg\" />\n </p>','~~\\frac{2C}{3}~~|:~~\\frac{4C}{3}~~|:~~\\frac{3C}{2}~~|: None of these ','0','<p><img src=\"../api/resources/questions/q109img1.jpg\" /> <br>\n~~C_{PQ},\\; C_{QR}\\;~~ and ~~C_{RB}~~ are in parallel combination - \n$$\\Delta V_{PQ} = V_P = V_B$$\n$$\\Delta V_{QR} = V_P = V_B$$\n$$\\Delta V_{RB} = V_P = V_B$$\n$$\\therefore C_{eq}(P,B) = 3C$$\n$$C_{eq} (A,B) = 3C/2$$ <br>\n(as 3C and 3C are in series)\n</p>',61,1,'',3,0,'../api/resources/questions/q109img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(110,'<p>A hollow metallic sphere of radius 9 cm is charged with 5nC. The potential difference between the centre and the surface is:\n</p>','100V|:1000V|:0V|:500V','2','<p><img src=\"../api/resources/questions/q110img1.jpg\" />\nCharge on the hollow metallic sphere Q = 5x10<sup>-9</sup> <br>\nDraw a Gaussian surface of radius x from the centre of the sphere<br>\nCharge enclosed = 0 <br>\n$$\\phi = 0$$\n$$\\Rightarrow \\int E.ds = 0$$\n$$\\therefore E = 0$$\n\n$$E = -\\frac{\\mathrm{d} V}{\\mathrm{d} x}$$\n$$dV = 0$$\n~~\\therefore V~~= constant\n<br><br>Hence potential difference between center and surface is 0.\n\n</p>',63,1,'',3,0,'../api/resources/questions/q110img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(111,'<p>The driver of a train moving at a speed v1 sights a goods train a distance \'d\' ahead of him on the same track moving in the same direction with a slower speed v2. He puts on brakes and gives his train a constant retardation \'a\'. There will be no collision for a minimum distance of \n</p>','~~\\frac{at^2}{2}~~|:~~2(v_1  - v_2)t - \\frac{at^2}{2}~~|:~~(v_1  - v_2)t - \\frac{at^2}{4}~~|:~~(v_1  - v_2)t - \\frac{at^2}{2}~~','3','<p>Train A has retardation \'a\' and a relative velocity ~~v_1 - v_2~~\n<br>\nIf the train has to stop (w.r.t. train B) before distance \'d\' - <br><br>\n\n~~S = (v_1 - v_2)t - \\frac{at^2}{2}~~<br><br>\nThe minimum distance \'d\' is \n~~(v_1 - v_2)t - \\frac{at^2}{2}~~\n</p>',62,1,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(112,'<p>Electric field in a region is given by ~~E=2x \\vec{i}~~ V/m where x is in meter. The potential difference between \npoints (-2, 0, 0) and (1, 0, 0) is:  </p>',' -5V|: 5V|:-3V|:3V','3','<p>$$E = 2x \\vec{i}$$\n\n$$dV = -E_xdx - E_ydy - E_zdz$$\n$$V = -\\int_{x_1}^{x_2} E_xdx - \\int_{y_1}^{y_2} E_ydy - \\int_{z_1}^{z_2} E_zdz $$\n$$V = -\\int_{x_1}^{x_2} 2xdx - \\int_{y_1}^{y_2} 0dy - \\int_{z_1}^{z_2} 0dz$$ \n $$= (-x^2)|_{(-1)} - (-x^2)|_{(-2)}$$ <br>\n= -(1-4) <br>\n = 3V\n</p>',62,1,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(113,'<p>A coil of resistance ~~10\\Omega ~~ has a flux change of .05 Wb to 0.55 Wb in 0.1 sec. What is the induced current? \n</p>','5A|:0.5A|:0.05A|:50A','1','<p>$$R = 10\\Omega \\;\\; $$\n$$\\phi_{initial} = 0.55\\;Wb$$\n$$\\phi_{final} = 0.05\\;Wb$$\n$$\\Delta t = 0.1s$$\nInduced EMF = <br>\n$$\\frac{\\mathrm{d}\\phi }{\\mathrm{d} t}\n= \\frac{\\phi_{final} - \\phi_{initial}}{\\Delta t} $$\n $$= \\frac{0.05 - 0.55}{0.1} = 5V$$\n\n$$I = \\frac{V}{R} = \\frac{5}{10}$$\n= 0.5A\n</p>',61,1,'',3,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(114,'<p>A magnet placed vertically is falling freely over a cylindrical coil placed over a horizontal surface as \nShown. The acceleration of the magnet is: \n</p>','Equal to g|: Greater than g|: Less than g|: Data Insufficient','2','<p>By Lens Law, current will be induced in the coil which will oppose the motion of magnet <br>\n<br>\nHence acceleration will be less than g\n\n</p>',61,1,'',3,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(115,'<p>In a series resonant circuit, the a.c. voltage across \nresistance R, inductance L and capacitance C are 5V, 10V \nand 10V respectively. The a.c. voltage applied to the circuit will be:\n</p>','20V|:\n10V|:\n5V|:\n25V','2','<p>At resonance, |~~V_C~~| = |~~V_L~~| but in opposite phase. Hence they neutralize each other. The whole voltage applied by a.c. is consumed by the resistance only.   <br>\n<img src=\"../api/resources/questions/q115img1.jpg\" /> <br>\n~~\\therefore V = 5V~~ across the circuit\n</p>',63,1,'',2,0,'../api/resources/questions/q115img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(116,'<p>A sinusoidal voltage is applied across a series combination of resistance R and inductor L. The amplitude of the current in the circuit is\n\n</p>','$$\\frac{V_o}{\\sqrt{R^2 + w^2L^2}}$$|:\n$$\\frac{V_o}{\\sqrt{R^2 - w^2L^2}}$$|:\n$$\\frac{V_o sin\\omega t}{\\sqrt{R^2 + w^2L^2}}$$|:\n$$\\frac{V_o}{R}$$','0','<p> $$Z = \\sqrt{R^2 + (X_L - X_C)^2}$$\n~~\\because X_C = 0~~ <br>\n$$Z = \\sqrt{R^2 + (\\omega^2L^2)}$$\n$$tan\\phi = \\frac{wL}{R}$$\n$$i = i_o sin(wt + \\phi)$$\n$$i = \\frac{V_o}{Z} sin(\\omega t + tan^{-1}(\\frac{\\omega L}{R}))$$ <br>\nAmplitude  = $$\\frac{V_o}{\\sqrt{R^2 + w^2L^2}}$$\n</p>',63,1,'',2,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL),
	(117,'<p>Reactance of a capacitor of 1/~~\\pi~~ farad at 50 Hz is\n</p>','0.01 ~~Omega~~ |:\n0.1 ~~Omega~~ |:\n1.0 ~~Omega~~|:\nNone of the above\n\n','1','<p> Reactance is calculated as - <br>\n$$X_C = \\frac{1}{\\omega C}$$\n\n~~\\omega~~ is calculated as ~~\\omega = 2\\pi f ~~ <br>\nAs f  = 50, ~~\\omega= 100 \\pi~~ <br>\n\n$$\\therefore X_C = \\frac{1}{100\\pi\\; \\frac{1}{\\pi}}$$\n~~ = 0.01 \\Omega~~\n</p>',63,1,'',3,0,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0,NULL,NULL);

/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table quizzes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `quizzes`;

CREATE TABLE `quizzes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionIds` varchar(200) DEFAULT NULL COMMENT 'string of question_list_ids separated by ||',
  `description` text,
  `descriptionShort` varchar(100) DEFAULT NULL,
  `conceptsTested` text,
  `tags` text,
  `l3Ids` varchar(50) DEFAULT NULL,
  `l2Ids` varchar(50) DEFAULT NULL,
  `questionCount` int(3) DEFAULT NULL,
  `allotedTime` int(11) DEFAULT NULL,
  `difficulty` int(1) DEFAULT NULL,
  `ratings` varchar(10) DEFAULT NULL,
  `rec` int(11) NOT NULL DEFAULT '0',
  `typeId` int(11) DEFAULT NULL,
  `facultyId` int(11) DEFAULT NULL,
  `available` int(1) DEFAULT NULL,
  `mobileFlag` int(1) DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `totalAttempts` int(11) NOT NULL DEFAULT '0',
  `streamId` int(11) DEFAULT NULL,
  `maxScore` int(11) DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;

INSERT INTO `quizzes` (`id`, `questionIds`, `description`, `descriptionShort`, `conceptsTested`, `tags`, `l3Ids`, `l2Ids`, `questionCount`, `allotedTime`, `difficulty`, `ratings`, `rec`, `typeId`, `facultyId`, `available`, `mobileFlag`, `addedOn`, `totalAttempts`, `streamId`, `maxScore`)
VALUES
	(1,'1|:2|:3|:4|:5|:6|:7|:8|:9|:10|:11|:12','Questions on Electricity & Magnetism from the last 4 years IIT-JEE papers','Advanced questions on Electricity and Magnetism','Electricity & Magnetism','IIT JEE','44|:45|:46|:47','7',12,3600,2,NULL,0,2,3,NULL,NULL,NULL,0,1,36),
	(2,'13|:14|:15|:16|:17|:18|:19|:20|:21|:22|:23|:24|:25|:26|:27|:28|:29|:30|:31|:32','Covers Redox Reactions , Stoichiometry, Chemical and Ionic Equilibrium','Advanced questions on Physical Chemistry','Physical Chemistry','','61|:62|:63','10',20,3600,2,NULL,0,2,1,NULL,NULL,NULL,0,1,100),
	(3,'33|:34|:35|:36|:37|:38|:39|:40|:41|:42|:43|:44|:45|:46|:47|:48|:49|:50|:51|:52|:53|:54|:55|:56|:57','Medium difficulty question to strengthen the key topics of Kinematics and Collisions','Practice on Kinematics and Collisions','Mechanics','','34|:35','6',25,3600,2,NULL,0,2,2,NULL,NULL,NULL,0,1,100),
	(4,'58|:59|:60|:61|:62|:63|:64|:65|:66|:67|:68|:69|:70|:71|:72|:73|:74|:75|:76|:77','JEE advanced level question to strengthen the key topics of Kinematics and Collisions','Advanced problems on Kinematics and Collisions','Mechanics','','34|:35','6',20,3600,2,NULL,0,2,2,NULL,NULL,NULL,0,1,100),
	(5,'78|:79|:80|:81|:82|:83|:84|:85|:86|:87|:88|:89|:90|:91|:92|:93|:94|:95|:96|:97','The set includes easy to medium questions on the topics of Relatve Velocity','Basic Question on Kinematics','Mechanics','','34|:35','6',20,3600,2,NULL,0,2,6,NULL,NULL,NULL,0,1,100),
	(6,'98|:99|:100|:101|:102|:103|:104|:105|:106|:107|:108|:109|:110|:111|:112|:113|:114|:115|:116|:117','The set includes easy to medium questions on AC circuits. This test is for students comfortable with DC circuits but looking to practice the topic of AC','Basic Question on Alternating Currents / Circuits','Electricity & Magnetism','','45|:46','7',20,3600,2,NULL,0,2,6,NULL,NULL,NULL,0,1,100);

/*!40000 ALTER TABLE `quizzes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table quizzes_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `quizzes_queue`;

CREATE TABLE `quizzes_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) NOT NULL,
  `quizId` int(11) NOT NULL,
  `deviceId` int(11) NOT NULL,
  `syncTimeStamp` bigint(20) NOT NULL,
  `optionsSelected` varchar(200) DEFAULT NULL,
  `timeTaken` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table quizzes_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `quizzes_type`;

CREATE TABLE `quizzes_type` (
  `id` int(11) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `quizzes_type` WRITE;
/*!40000 ALTER TABLE `quizzes_type` DISABLE KEYS */;

INSERT INTO `quizzes_type` (`id`, `type`)
VALUES
	(1,'full'),
	(2,'sectional');

/*!40000 ALTER TABLE `quizzes_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table redeem
# ------------------------------------------------------------

DROP TABLE IF EXISTS `redeem`;

CREATE TABLE `redeem` (
  `purchaseId` int(11) DEFAULT NULL,
  `remaining` text,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table resources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resources`;

CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table responses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `responses`;

CREATE TABLE `responses` (
  `accountId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `optionSelected` text,
  `timeTaken` int(11) DEFAULT NULL,
  `abilityScoreBefore` int(11) DEFAULT NULL,
  `delta` int(11) DEFAULT NULL,
  `timeStamp` timestamp NULL DEFAULT NULL,
  `status` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;

INSERT INTO `responses` (`accountId`, `questionId`, `optionSelected`, `timeTaken`, `abilityScoreBefore`, `delta`, `timeStamp`, `status`)
VALUES
	(7,13,'1',131589,83,-1,'2013-01-18 17:33:34','2'),
	(7,14,'',0,52,0,'2013-01-18 17:33:34','4'),
	(7,15,'',0,52,0,'2013-01-18 17:33:34','4'),
	(7,16,'',0,82,0,'2013-01-18 17:33:34','4'),
	(7,17,'',0,82,0,'2013-01-18 17:33:34','4'),
	(7,18,'',0,76,0,'2013-01-18 17:33:34','4'),
	(7,19,'',0,76,0,'2013-01-18 17:33:34','4'),
	(7,20,'',0,52,0,'2013-01-18 17:33:34','4'),
	(7,21,'',0,82,0,'2013-01-18 17:33:34','4'),
	(7,22,'',0,52,0,'2013-01-18 17:33:34','4'),
	(7,23,'',0,76,0,'2013-01-18 17:33:34','4'),
	(7,24,'',0,82,0,'2013-01-18 17:33:34','4'),
	(7,25,'',0,52,0,'2013-01-18 17:33:34','4'),
	(7,26,'',0,76,0,'2013-01-18 17:33:34','4'),
	(7,27,'',0,76,0,'2013-01-18 17:33:34','4'),
	(7,28,'',0,82,0,'2013-01-18 17:33:34','4'),
	(7,29,'',0,82,0,'2013-01-18 17:33:34','4'),
	(7,30,'',0,52,0,'2013-01-18 17:33:34','4'),
	(7,31,'',0,52,0,'2013-01-18 17:33:34','4'),
	(7,32,'',0,52,0,'2013-01-18 17:33:34','4'),
	(4,1,'0',3431,47,-1,'2013-01-19 22:04:57','2'),
	(4,13,'0',3984,50,-1,'2013-01-19 22:05:25','2'),
	(4,14,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,15,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,16,'',0,49,0,'2013-01-19 22:05:25','4'),
	(4,17,'',0,49,0,'2013-01-19 22:05:25','4'),
	(4,18,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,19,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,20,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,21,'',0,49,0,'2013-01-19 22:05:25','4'),
	(4,22,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,23,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,24,'',0,49,0,'2013-01-19 22:05:25','4'),
	(4,25,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,26,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,27,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,28,'1',1841,49,-1,'2013-01-19 22:05:25','2'),
	(4,29,'',0,48,0,'2013-01-19 22:05:25','4'),
	(4,30,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,31,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,32,'',0,50,0,'2013-01-19 22:05:25','4'),
	(4,33,'1',2032,58,-1,'2013-01-20 00:31:54','2'),
	(4,34,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,35,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,36,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,37,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,38,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,39,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,40,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,41,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,42,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,43,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,44,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,45,'',1165,57,0,'2013-01-20 00:31:54','4'),
	(4,46,'3',1761,50,4,'2013-01-20 00:31:54','1'),
	(4,47,'',3039,50,0,'2013-01-20 00:31:54','3'),
	(4,48,'',0,54,0,'2013-01-20 00:31:54','4'),
	(4,49,'',0,54,0,'2013-01-20 00:31:54','4'),
	(4,50,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,51,'',0,50,0,'2013-01-20 00:31:54','4'),
	(4,52,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,53,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,54,'',0,57,0,'2013-01-20 00:31:54','4'),
	(4,55,'',0,57,0,'2013-01-20 00:31:55','4'),
	(4,56,'',0,57,0,'2013-01-20 00:31:55','4'),
	(4,57,'',0,57,0,'2013-01-20 00:31:55','4');

/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `results`;

CREATE TABLE `results` (
  `quizId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  `selectedAnswers` text,
  `score` text,
  `timePerQuestion` text,
  `timeTaken` text,
  `data` text,
  `timestamp` datetime DEFAULT NULL,
  `attemptedAs` int(11) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `state` int(10) DEFAULT NULL,
  `numCorrect` int(11) DEFAULT NULL,
  `numIncorrect` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;

INSERT INTO `results` (`quizId`, `accountId`, `selectedAnswers`, `score`, `timePerQuestion`, `timeTaken`, `data`, `timestamp`, `attemptedAs`, `startTime`, `endTime`, `state`, `numCorrect`, `numIncorrect`)
VALUES
	(1,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-18 17:29:24',NULL,NULL,NULL,NULL),
	(2,7,'[\"1\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]',NULL,'[131589,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]',NULL,'[{\"t\":\"1358510483105\",\"e\":\"10\"},{\"t\":\"1358510483129\",\"e\":\"3\",\"q\":\"13\"},{\"t\":\"1358510484818\",\"e\":\"0\",\"q\":\"13\",\"o\":\"0\"},{\"t\":\"1358510485475\",\"e\":\"1\",\"q\":\"13\",\"o\":\"0\"},{\"t\":\"1358510485475\",\"e\":\"0\",\"q\":\"13\",\"o\":\"1\"},{\"t\":\"1358510614718\",\"e\":\"4\",\"q\":\"13\"},{\"t\":\"1358510614719\",\"e\":\"8\"}]','2013-01-18 17:33:34',1,'2013-01-18 17:31:16',NULL,20,NULL,NULL),
	(1,4,NULL,NULL,NULL,NULL,'[{\"t\":\"1358613293628\",\"e\":\"3\",\"q\":\"1\"},{\"t\":\"1358613295062\",\"e\":\"0\",\"q\":\"1\",\"o\":\"0\"},{\"t\":\"1358613297059\",\"e\":\"4\",\"q\":\"1\"}]','2013-01-19 22:04:57',2,'2013-01-19 22:04:49',NULL,0,NULL,NULL),
	(2,4,'[\"0\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"1\",\"\",\"\",\"\",\"\"]',NULL,'[3984,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1841,0,0,0,0]',NULL,'[{\"t\":\"1358613319215\",\"e\":\"10\"},{\"t\":\"1358613319233\",\"e\":\"3\",\"q\":\"13\"},{\"t\":\"1358613320700\",\"e\":\"0\",\"q\":\"13\",\"o\":\"0\"},{\"t\":\"1358613323217\",\"e\":\"4\",\"q\":\"13\"},{\"t\":\"1358613323221\",\"e\":\"3\",\"q\":\"28\"},{\"t\":\"1358613323982\",\"e\":\"0\",\"q\":\"28\",\"o\":\"1\"},{\"t\":\"1358613325062\",\"e\":\"4\",\"q\":\"28\"},{\"t\":\"1358613325062\",\"e\":\"8\"}]','2013-01-19 22:05:25',1,'2013-01-19 22:05:18',NULL,20,NULL,NULL),
	(3,4,'[\"1\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"3\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]',NULL,'[2032,0,0,0,0,0,0,0,0,0,0,0,1165,1761,3039,0,0,0,0,0,0,0,0,0,0]',NULL,'[{\"t\":\"1358622106744\",\"e\":\"10\"},{\"t\":\"1358622106771\",\"e\":\"3\",\"q\":\"33\"},{\"t\":\"1358622107879\",\"e\":\"0\",\"q\":\"33\",\"o\":\"1\"},{\"t\":\"1358622108803\",\"e\":\"4\",\"q\":\"33\"},{\"t\":\"1358622108806\",\"e\":\"3\",\"q\":\"45\"},{\"t\":\"1358622109971\",\"e\":\"4\",\"q\":\"45\"},{\"t\":\"1358622109974\",\"e\":\"3\",\"q\":\"46\"},{\"t\":\"1358622110775\",\"e\":\"0\",\"q\":\"46\",\"o\":\"3\"},{\"t\":\"1358622111735\",\"e\":\"4\",\"q\":\"46\"},{\"t\":\"1358622111738\",\"e\":\"3\",\"q\":\"47\"},{\"t\":\"1358622114777\",\"e\":\"4\",\"q\":\"47\"},{\"t\":\"1358622114777\",\"e\":\"8\"}]','2013-01-20 00:31:55',1,'2013-01-20 00:31:43',NULL,25,NULL,NULL);

/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;

INSERT INTO `roles` (`id`, `name`)
VALUES
	(1,'Admin'),
	(2,'student'),
	(3,'faculty');

/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table section_l1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `section_l1`;

CREATE TABLE `section_l1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayName` varchar(30) DEFAULT NULL,
  `longName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `streamId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `section_l1` WRITE;
/*!40000 ALTER TABLE `section_l1` DISABLE KEYS */;

INSERT INTO `section_l1` (`id`, `displayName`, `longName`, `streamId`)
VALUES
	(1,'Maths','NULL','1'),
	(2,'Physics','NULL','1'),
	(3,'Chemistry','NULL','1'),
	(4,'Physics','NULL','2'),
	(5,'Chemistry','NULL','2'),
	(6,'Biology','NULL','2');

/*!40000 ALTER TABLE `section_l1` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table section_l2
# ------------------------------------------------------------

DROP TABLE IF EXISTS `section_l2`;

CREATE TABLE `section_l2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayName` varchar(30) DEFAULT NULL,
  `longName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `l1Id` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL,
  `weightage` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `l1Id` (`l1Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `section_l2` WRITE;
/*!40000 ALTER TABLE `section_l2` DISABLE KEYS */;

INSERT INTO `section_l2` (`id`, `displayName`, `longName`, `l1Id`, `streamId`, `weightage`)
VALUES
	(1,'Algebra','NULL',1,1,0.25),
	(2,'Trigonometry','NULL',1,1,0.25),
	(3,'Coordinate Geometry','NULL',1,1,0.25),
	(4,'Calculus','NULL',1,1,0.25),
	(5,'General','NULL',2,1,0.2),
	(6,'Mechanics','NULL',2,1,0.2),
	(7,'Electricity and Magnetism','NULL',2,1,0.2),
	(8,'Optics','NULL',2,1,0.2),
	(9,'Modern Physics','NULL',2,1,0.2),
	(10,'Physical Chemistry','NULL',3,1,0.333333),
	(11,'Inorganic Chemistry','NULL',3,1,0.333333),
	(12,'Organic Chemistry','NULL',3,1,0.333333),
	(13,'General','NULL',4,2,0.2),
	(14,'Mechanics','NULL',4,2,0.2),
	(15,'Electricity and Magnetism','NULL',4,2,0.2),
	(16,'Optics','NULL',4,2,0.2),
	(17,'Modern Physics','NULL',4,2,0.2),
	(18,'Physical Chemistry','NULL',5,2,0.25),
	(19,'Inorganic Chemistry','NULL',5,2,0.25),
	(20,'Organic Chemistry','NULL',5,2,0.25),
	(21,'Biochemistry','NULL',5,2,0.25),
	(22,'Diversity in Living World','NULL',6,2,0.1),
	(23,'Structures in Plants and Anima','NULL',6,2,0.1),
	(24,'Cell Structure and Function','NULL',6,2,0.1),
	(25,'Plant Physiology','NULL',6,2,0.1),
	(26,'Human Physiology','NULL',6,2,0.1),
	(27,'Reproduction','NULL',6,2,0.1),
	(28,'Genetics and Evolution','NULL',6,2,0.1),
	(29,'Biology and Human Welfare','NULL',6,2,0.1),
	(30,'Biotechnology and its applicat','NULL',6,2,0.1),
	(31,'Ecology and Environment','NULL',6,2,0.1);

/*!40000 ALTER TABLE `section_l2` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table section_l3
# ------------------------------------------------------------

DROP TABLE IF EXISTS `section_l3`;

CREATE TABLE `section_l3` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayName` varchar(50) DEFAULT NULL,
  `longName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `l2Id` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL,
  `weightage` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `section_l3` WRITE;
/*!40000 ALTER TABLE `section_l3` DISABLE KEYS */;

INSERT INTO `section_l3` (`id`, `displayName`, `longName`, `l2Id`, `streamId`, `weightage`)
VALUES
	(1,'Sets, Relations & Functions','',1,1,0.1),
	(2,'Equations','',1,1,0.1),
	(3,'Complex Numbers','',1,1,0.1),
	(4,'Progressions','',1,1,0.1),
	(5,'Logarithms','',1,1,0.1),
	(6,'Permutations and Combinations','',1,1,0.1),
	(7,'Binomial Theorem','',1,1,0.1),
	(8,'Matrices','',1,1,0.1),
	(9,'Probability','',1,1,0.1),
	(10,'Mathematical Induction','',1,1,0.1),
	(11,'Trigonometric Equations','',2,1,0.2),
	(12,'Sine Rule','',2,1,0.2),
	(13,'Cosine Rule','',2,1,0.2),
	(14,'Half angle formula','',2,1,0.2),
	(15,'Inverse Trigonometric functions','',2,1,0.2),
	(16,'Cartesian Coordinates','',3,1,0.142857),
	(17,'Lines','',3,1,0.142857),
	(18,'Triangles','',3,1,0.142857),
	(19,'Circle','',3,1,0.142857),
	(20,'Conic Sections','',3,1,0.142857),
	(21,'Locus','',3,1,0.142857),
	(22,'3-D Geometry','',3,1,0.142857),
	(23,'Limit and Continuity','',4,1,0.166667),
	(24,'Derivatives','',4,1,0.166667),
	(25,'Rolle\'s and Lagrange\'s Theorem','',4,1,0.166667),
	(26,'Indefinite and definite integrals','',4,1,0.166667),
	(27,'Applications of integrations','',4,1,0.166667),
	(28,'Ordinary Differential Equations','',4,1,0.166667),
	(29,'Units and Dimensions','',5,1,0.2),
	(30,'Physical Experiments','',5,1,0.2),
	(31,'Optics Experiments','',5,1,0.2),
	(32,'Electricity experiments','',5,1,0.2),
	(33,'Heat Experiments','',5,1,0.2),
	(34,'Kinematics','',6,1,0.1),
	(35,'Newtons Laws','',6,1,0.1),
	(36,'Collisions','',6,1,0.1),
	(37,'Gravitation','',6,1,0.1),
	(38,'Momentum','',6,1,0.1),
	(39,'Bulk Matter','',6,1,0.1),
	(40,'Fluid dynamics','',6,1,0.1),
	(41,'Wave motion','',6,1,0.1),
	(42,'Thermal Physics','',6,1,0.1),
	(43,'Perfect Gas and Kinetic Theory','',6,1,0.1),
	(44,'Electrostatics','',7,1,0.166667),
	(45,'Capacitance','',7,1,0.166667),
	(46,'Electric Current','',7,1,0.166667),
	(47,'Magnetic effects of current and magnetism','',7,1,0.166667),
	(48,'Electromagnetic Induction','',7,1,0.166667),
	(49,'Electromagnetic Waves','',7,1,0.166667),
	(50,'Reflection and Refraction','',8,1,0.25),
	(51,'Lenses','',8,1,0.25),
	(52,'Prisms','',8,1,0.25),
	(53,'Intereference','',8,1,0.25),
	(54,'Atoms and Nuclei','',9,1,0.25),
	(55,'Radioactive Decay','',9,1,0.25),
	(56,'Dual Nature of Matter and Radiation (incl PE effec','',9,1,0.25),
	(57,'Waves','',9,1,0.25),
	(58,'Mole Concept','',10,1,0.0769231),
	(59,'Electro Chemistry','',10,1,0.0769231),
	(60,'States of Matter','',10,1,0.0769231),
	(61,'Thermodynamics','',10,1,0.0769231),
	(62,'Chemical Equilibrium','',10,1,0.0769231),
	(63,'Ionic Equilibrium','',10,1,0.0769231),
	(64,'Chemical Kinetics','',10,1,0.0769231),
	(65,'Solutions','',10,1,0.0769231),
	(66,'Surface Chemistry','',10,1,0.0769231),
	(67,'Nuclear Chemistry','',10,1,0.0769231),
	(68,'Stoichiometry','',10,1,0.0769231),
	(69,'Redox Reactions','',10,1,0.0769231),
	(70,'Solid State ','',10,1,0.0769231),
	(71,'Ores and Minerals','',11,1,0.166667),
	(72,'Extractive Metallurgy','',11,1,0.166667),
	(73,'Qualitative Analysis','',11,1,0.166667),
	(74,'S-Block Elements','',11,1,0.166667),
	(75,'P-Block Elements','',11,1,0.166667),
	(76,'D and F Block Elements','',11,1,0.166667),
	(77,'General Concepts','',12,1,0.125),
	(78,'Alkanes, Alkenes and Alkynes','',12,1,0.125),
	(79,'Isomerism','',12,1,0.125),
	(80,'Alcohols, Phenols and Ethers','',12,1,0.125),
	(81,'Aldehydes, Ketones and Acids','',12,1,0.125),
	(82,'Biomolecules','',12,1,0.125),
	(83,'Practical Organic Chemistry','',12,1,0.125),
	(84,'Aromatic Compounds','',12,1,0.125),
	(85,'Units and Dimensions','NULL',13,2,0.2),
	(86,'Physical Experiments','NULL',13,2,0.2),
	(87,'Optics Experiments','NULL',13,2,0.2),
	(88,'Electricity experiments','NULL',13,2,0.2),
	(89,'Heat Experiments','NULL',13,2,0.2),
	(90,'Kinematics','NULL',14,2,0.1),
	(91,'Newtons Laws','NULL',14,2,0.1),
	(92,'Collisions','NULL',14,2,0.1),
	(93,'Gravitation','NULL',14,2,0.1),
	(94,'Momentum','NULL',14,2,0.1),
	(95,'Bulk Matter','NULL',14,2,0.1),
	(96,'Fluid dynamics','NULL',14,2,0.1),
	(97,'Wave motion','NULL',14,2,0.1),
	(98,'Thermal Physics','NULL',14,2,0.1),
	(99,'Perfect Gas and Kinetic Theory','NULL',14,2,0.1),
	(100,'Electrostatics','NULL',15,2,0.166667),
	(101,'Capacitance','NULL',15,2,0.166667),
	(102,'Electric Current','NULL',15,2,0.166667),
	(103,'Magnetic effects of current and magnetism','NULL',15,2,0.166667),
	(104,'Electromagnetic induction','NULL',15,2,0.166667),
	(105,'Electromagnetic waves','NULL',15,2,0.166667),
	(106,'Reflection and refraction','NULL',16,2,0.25),
	(107,'Lenses','NULL',16,2,0.25),
	(108,'Prisms','NULL',16,2,0.25),
	(109,'Intereference','NULL',16,2,0.25),
	(110,'Atoms and Nuclei','NULL',17,2,0.25),
	(111,'Radioactive Decay','NULL',17,2,0.25),
	(112,'Dual Nature of Matter and Radiation (incl PE effec','NULL',17,2,0.25),
	(113,'Electronic Devices','NULL',17,2,0.25),
	(114,'Electro Chemistry','',18,2,0.125),
	(115,'States of matter','',18,2,0.125),
	(116,'Thermodynamics','',18,2,0.125),
	(117,'Chemical Equilibrium','',18,2,0.125),
	(118,'Chemical Kinetics','',18,2,0.125),
	(119,'Solutions','',18,2,0.125),
	(120,'Surface Chemistry','',18,2,0.125),
	(121,'Nuclear Chemistry','',18,2,0.125),
	(122,'Ores and Minerals','',19,2,0.0909091),
	(123,'Oxygen compunds','',19,2,0.0909091),
	(124,'Carbon compounds','',19,2,0.0909091),
	(125,'Chlorine Compounds','',19,2,0.0909091),
	(126,'Sulphur Compounds','',19,2,0.0909091),
	(127,'Transition Elements','',19,2,0.0909091),
	(128,'Extractive Metallurgy','',19,2,0.0909091),
	(129,'Qualitative Analysis','',19,2,0.0909091),
	(130,'S-block Elements','',19,2,0.0909091),
	(131,'P-Block Elements','',19,2,0.0909091),
	(132,'d and f block elements','',19,2,0.0909091),
	(133,'General Concepts','',20,2,0.142857),
	(134,'Alkanes','',20,2,0.142857),
	(135,'Alkenes and Alkynes','',20,2,0.142857),
	(136,'Alcohols, Phenols and Ethers','',20,2,0.142857),
	(137,'Aldehydes, Ketones and Acids','',20,2,0.142857),
	(138,'Amino acids and peptides','',20,2,0.142857),
	(139,'Practical Organic Chemistry','',20,2,0.142857),
	(140,'Environmental chemistry','',21,2,0.333333),
	(141,'Biomolecules','',21,2,0.333333),
	(142,'Polymers','',21,2,0.333333),
	(143,'Classification ','',22,2,0.333333),
	(144,'Features and classification of plants','',22,2,0.333333),
	(145,'Features and classification of animals','',22,2,0.333333),
	(146,'Morphology and Anatomy (plants)','',23,2,0.5),
	(147,'Morphology and Anatomy (animals)','',23,2,0.5),
	(148,'Cell theory','',24,2,0.333333),
	(149,'Chemical Constituents of living cells','',24,2,0.333333),
	(150,'Cell division','',24,2,0.333333),
	(151,'Transport in plants','',25,2,0.2),
	(152,'Mineral Nutrition','',25,2,0.2),
	(153,'Photosynthesis','',25,2,0.2),
	(154,'Respiration','',25,2,0.2),
	(155,'Plant growth and development','',25,2,0.2),
	(156,'Digestion and absorption','',26,2,0.166667),
	(157,'Breathing and respiration','',26,2,0.166667),
	(158,'Body fluids and circulation','',26,2,0.166667),
	(159,'Excretory products','',26,2,0.166667),
	(160,'Locomotion and movement','',26,2,0.166667),
	(161,'Neural control and coordination','',26,2,0.166667),
	(162,'Reproduction in organisms','',27,2,0.25),
	(163,'Sexual reproduction in plants','',27,2,0.25),
	(164,'Human reproduction','',27,2,0.25),
	(165,'Reproductive Health','',27,2,0.25),
	(166,'Heredity and Variation','',28,2,0.333333),
	(167,'Inheritance','',28,2,0.333333),
	(168,'Evolution','',28,2,0.333333),
	(169,'Health and disease','',29,2,0.333333),
	(170,'Improvement in food production','',29,2,0.333333),
	(171,'Microbes in human welfare','',29,2,0.333333),
	(172,'Genetic Engineering','',30,2,0.5),
	(173,'Applications of biotechnology','',30,2,0.5),
	(174,'Organisms and environment','',31,2,0.25),
	(175,'Ecosystem','',31,2,0.25),
	(176,'Biodiversity','',31,2,0.25),
	(177,'Environmental issues','',31,2,0.25);

/*!40000 ALTER TABLE `section_l3` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table streams
# ------------------------------------------------------------

DROP TABLE IF EXISTS `streams`;

CREATE TABLE `streams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayName` varchar(50) DEFAULT NULL,
  `topFacultyIds` varchar(100) DEFAULT NULL,
  `basicInfo` text,
  `quizIds` text,
  `sampleQuizIds` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `streams` WRITE;
/*!40000 ALTER TABLE `streams` DISABLE KEYS */;

INSERT INTO `streams` (`id`, `displayName`, `topFacultyIds`, `basicInfo`, `quizIds`, `sampleQuizIds`)
VALUES
	(1,'Engineering',NULL,NULL,NULL,NULL),
	(2,'Medical',NULL,NULL,NULL,NULL),
	(3,'Civil Services',NULL,NULL,NULL,NULL),
	(4,'Law',NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `streams` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table students
# ------------------------------------------------------------

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `ascoreL1` int(1) DEFAULT '0',
  `ascoreL2` int(1) DEFAULT '0',
  `quizzesAttempted` text,
  `accountId` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL,
  KEY `accountId` (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;

INSERT INTO `students` (`ascoreL1`, `ascoreL2`, `quizzesAttempted`, `accountId`, `streamId`)
VALUES
	(0,0,'[\"1\",\"2\",\"3\"]',4,1),
	(0,0,NULL,5,1),
	(0,0,'[\"1\",\"2\"]',7,1);

/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
