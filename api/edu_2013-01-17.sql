# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.25)
# Database: edu
# Generation Time: 2013-01-17 10:24:41 +0000
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
	(5,NULL,'123456','aa','aa','aa@aa.com',NULL,'2012-12-31 11:09:00',NULL,NULL,NULL,NULL,NULL,NULL);

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
  `score` int(2) DEFAULT '0',
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
	(4,54,'2013-01-15 18:41:07',2,33,2,6,25,1),
	(4,50,'2013-01-15 08:36:35',3,180,0,27,153,1);

/*!40000 ALTER TABLE `ascores_l1` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ascores_l2
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l2`;

CREATE TABLE `ascores_l2` (
  `accountId` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT '0',
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
	(4,50,'2013-01-15 18:41:07',7,4,0,3,1,1),
	(4,54,'2013-01-15 08:23:28',6,26,2,3,21,1),
	(4,50,'2013-01-15 08:23:28',5,3,0,0,3,1),
	(4,50,'2013-01-15 08:36:35',10,180,0,27,153,1);

/*!40000 ALTER TABLE `ascores_l2` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ascores_l3
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l3`;

CREATE TABLE `ascores_l3` (
  `accountId` int(11) NOT NULL,
  `score` int(11) NOT NULL,
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
	(4,50,'2013-01-15 08:23:28',33,3,0,0,3,1),
	(4,54,'2013-01-15 08:23:28',34,16,2,2,12,1),
	(4,50,'2013-01-15 08:23:28',35,10,0,1,9,1),
	(4,50,'0000-00-00 00:00:00',36,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',37,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',38,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',39,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',40,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',41,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',42,0,0,0,0,1),
	(4,50,'0000-00-00 00:00:00',43,0,0,0,0,1),
	(4,48,'2013-01-15 18:40:39',44,2,0,2,0,1),
	(4,47,'2013-01-15 18:40:44',45,1,0,0,1,1),
	(4,48,'2013-01-15 18:41:07',46,1,0,1,0,1),
	(4,48,'2013-01-14 06:54:35',47,0,0,0,0,1),
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
	(4,50,'2013-01-15 08:36:35',61,63,0,9,54,1),
	(4,50,'2013-01-15 08:36:35',62,45,0,9,36,1),
	(4,50,'2013-01-15 08:36:35',63,72,0,9,63,1),
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
	(4,50,'0000-00-00 00:00:00',176,0,0,0,0,1);

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
	('2','',NULL,'Physics Faculty at Rise Institute','Tanuj Bhojwani is an IIT Bombay alumnus, and has co-founded the first IIT-JEE training institute in Kashmir: Rise Institute. Though he is a chemical engineer, his area of expertise is physics','Co-founder, Rise Institute','B. Tech., IIT Bombay, 2010','1',0,0,0,3);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;

INSERT INTO `questions` (`id`, `text`, `options`, `correctAnswer`, `explanation`, `l3Id`, `typeId`, `tagIds`, `difficulty`, `paraId`, `resources`, `averageTimeCorrect`, `averageTimeIncorrect`, `averageTimeUnattempted`, `averageCorrect`, `averageIncorrect`, `averageUnattempted`, `allotedTime`, `correctScore`, `incorrectScore`, `optionInCorrectScore`, `optionCorrectScore`, `unattemptedScore`, `mobileFlag`, `availableFlag`)
VALUES
	(1,'Two large vertical and parallel metal plates having a separation of 1 cm are connected to a DC voltage source of potential difference X. A proton is released at rest midway between the two plates. It is found to move at 45<sup>o</sup> to the vertical JUST after release. Then X is nearly','1*10<sup>-5</sup> V |: 1*10<sup>-7</sup> V |: 1*10<sup>-9</sup> V |: 1*10<sup>-10</sup> V','2','<p>Writing the force equations on the particle,</p><img src = /\"1img1.jpg/\"><p>mg = qE $$1.67 * 10^{-27} * (10) = (1.6 * 10^{-19})\\frac{x}{0.01}$$  $$x =\\frac{1.67 * 10^{-9}}{1.6}$$ $$x=1 * 10^{-9}V$$</p>',44,1,'',1,NULL,'../api/resources/questions/1img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(2,'<p>For the circuit given below which of the following is true:</p> <img src = \"../api/resources/questions/2img1.jpg\">','The current I through the battery is 7.5mA |: The potential difference across RL is 20V|: The ratios of power dissipated in R1 and R2 is 5 |:\n If R1 and R2 are interchanged, magnitude of power dissipated in RL will decrease by a factor of 3','0','<p>R<sub>2</sub> and R<sub>L</sub> are in parallel hence $$R_{2L} = \\frac{6 * 1.5}{6 + 1.5}$$\nR<sub>2L</sub> = 1.2 k~~\\Omega~~ <br>\nR<sub>2L</sub> in turn is in series with R<sub>1</sub> hence the resistance of the circuit is:<br>\nR = 1.2 + 2 = 3.2 k~~\\Omega~~ <br>\nThe current I through battery is $$ i= \\frac{24V}{3.2 * 1000\\Omega} = 7.5 mA $$</p>',45,1,'',2,NULL,'../api/resources/questions/2img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(3,'<img src = \"../api/resources/questions/3img1.jpg\"> <p> A meter bridge is set-up as shown, to determine an unknown resistance \'X\' using a standard 10 ohm resistor. The galvanometer shows null point when tapping-key is at 52 cm mark. The end-corrections are 1 cm and 2 cm respectively for the ends A and B.  The determined value of \'X\' is:</p>','10.2 ohm |: 10.6 ohm |:\n10.8 ohm |: 11.1 ohm','1','<p>$$\\frac{x}{10} = \\frac{l_1}{l_2}$$\nWhere l<sub>1</sub> and l<sub>2</sub> are the lengths with end corrections\nl<sub>1</sub> = 52 + 1 = 53 cm; l<sub>2</sub> = 48 + 2 = 50 cm$$\\frac{x}{10}=\\frac{53cm}{50cm}$$\nX = 10.6 ~~\\Omega~~</p>',46,1,'',1,NULL,'../api/resources/questions/3img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(4,'<p> A spherical metal A of radius R<sub>A</sub> and a solid metal sphere B of radius R<sub>B</sub> \n(< R<sub>A</sub>) are kept far apart and each is given charge \'+Q\'. Now a thin metal wire connects them. Which one of the following is false:</p>','E<sub>A</sub> (inside) = 0 |: Q<sub>A</sub> < Q<sub>B</sub> |: ~~\\sigma_A/ \\sigma_B~~ = R<sub>B</sub> / R<sub>A </sub>|: E<sub>A</sub> (on surface) < E<sub>B</sub> (on surface)','3','<p>E <sub>(inside)</sub> for metallic shell = 0 $$\\frac{Q_A}{4\\pi \\epsilon_oR_A} = \\frac{Q_B}{4\\pi \\epsilon_oR_B}$$ $$\\therefore\\frac{Q_A}{Q_B} = \\frac{R_A}{R_B}$$\nSince R<sub>A</sub> > R<sub>B</sub> hence Q<sub>A</sub> > Q<sub>B</sub> => B is false $$\\frac{Q_A}{R_A}{4\\pi R_A^2} = \\frac{Q_B}{R_B}{4\\pi R_B^2}$$ $$\\therefore \\frac{\\sigma_A}{\\sigma_B} = \\frac{R_B}{R_A}$$ $$\\frac{E_A}{E_B} = \\frac{\\sigma_A}{\\sigma_B} = \\frac{R_B}{R_A} < 1$$ E<sub>A</sub><E<sub>B</sub> </p>',47,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(5,'<p>For the resistance network shown in the figure, choose the wrong option.</p><img src = \"../api/resources/questions/5img1.jpg\">','The current through PQ is zero |: i<sub>1</sub> = 3 A |: The potential at S is more than that at Q |: i<sub>2</sub> = 2 A\n','1','<p>Due to input and output symmetry P & Q and S & T have same potential\nHence PQ and ST have 0 current\n Hence R<sub>2</sub> = ~~6\\Omega~~\nAnd R<sub>3</sub> = ~~12\\Omega~~\nSince the 2 are in parallel, $$\\therefore R_1 = \\frac {6 * 12}{6 + 12} = 4\\Omega$$ $$i_1 = 12/4 = 3 A$$\nQ and P have same potential. Since current is flowing from P to S with a resistance of ~~2\\Omega~~, V<sub>S</sub>< V<sub>P</sub> and hence V<sub>S</sub>< V<sub>Q</sub>\nTo calculate I<sub>2</sub>:\n6 * I<sub>2</sub> = 12 * (3-I<sub>2</sub>)\nI<sub>2</sub> = 2A</p>',44,1,'',2,NULL,'../api/resources/questions/5img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(6,'<p>A ~~2\\mu~~F capacitor is charged as shown in figure.<br> <img src = \"../api/resources/questions/6img1.jpg\"><br> The percentage of its stored energy dissipated after the switch S is turned to position 2 is:</p>','0% |: 20% |: 75% |: 80%','3','<p>The initial charge: Q = C<sub>1</sub>V\nThe charge is distributed as Q1 and Q2 till the potentials are same.$$\\frac{Q_1}{Q_2} = \\frac{C_1}{C_2} = \\frac{2\\mu F}{8\\mu F} = \\frac{1}{4}$$ $$\\therefore Q_1 = Q/5, Q_2 = 4Q/5 $$ Hence Q1 = Q/5 and Q2 = 4Q/5 <br> Energy in initial configuration $$ E_i = \\frac{1}{2}\\frac{Q^2}{C_1} $$ $$\\therefore E_i = \\frac{Q^2}{4}$$ Energy in final configuration $$E_f = \\frac{1}{2}\\frac{Q^2_1}{C_1} + \\frac{1}{2}\\frac{Q^2_2}{C_2} $$ $$\\therefore E_f = \\frac{Q^2}{20}$$ $$E_{dissipated} = \\frac{Q^2}{4} - \\frac{Q^2}{20} = \\frac{Q^2}{5}$$ $$ \\%_{dissipated} = \\frac{E_{dissipated}}{E_i} = \\frac{\\frac{Q^2}{5}}{\\frac{Q^2}{4}} = 80\\%$$</p>',45,1,'',2,NULL,'../api/resources/questions/6img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(7,'<p>Two batteries of different EMFs and different internal resistances are connected as shown. The voltage across AB in volts is: </p><img src = \"../api/resources/questions/7img1.jpg\">',' 5 |: 4.5 |: 5.4 |: 3.8','0','<p>Total EMF = 6V - 3V = 3V<br>\nResistance = ~~1 \\Omega + 2 \\Omega = 3 \\Omega~~<br>',46,1,'',2,NULL,'../api/resources/questions/7img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(8,'<p>A thin flexible wire of length L is connected to two adjacent fixed points and carries a current I in the clockwise direction, as shown in the figure. When the system is put in a uniform magnetic field of strength B going into the plane of the paper, the wire takes the shape of a circle. The tension in the wire is:</p>  <img src = \"../api/resources/questions/8img1.jpg\">','IBL |: IBL / ~~\\pi~~ |: IBL /2~~\\pi~~ |: IBL / 4~~\\pi~~\n','2','<img src = \"../api/resources/questions/8img2.jpg\"> <p>Magnetic force acting upwards ~~=Bl * dl = Bl * Rd\\Theta~~ <br> Tension (Vertical) acting downwards = ~~2T * sin \\frac{d\\Theta}{2}~~<br> Applying force balance - <br> $$2 T sin(\\frac{d\\Theta}{2}) = B I (R d\\Theta)~~ &nbsp&nbsp&nbsp&nbsp  ~~sin\\frac{d\\Theta}{2} = \\frac{d\\Theta}{2}$$ $$T (d\\Theta) = B I R (d\\Theta)$$ Integrating over ~~\\Theta~~ from 0 to ~~2\\pi~~ $$ T= \\frac{IBL}{2\\pi}$$',47,1,'',3,NULL,'../api/resources/questions/8img1.jpg|:../api/resources/questions/8img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(9,'<p>A few electric field lines for a system of two charges Q<sub>1</sub> and Q<sub>2</sub> fixed at two different points on the x-axis are shown in the figure. These lines suggest that:</p>  <img src = \"../api/resources/questions/9img1.jpg\">','~~\\left|Q1\\right|~~ > ~~\\left|Q2\\right|~~|: ~~\\left|Q1\\right|~~ < ~~\\left|Q2\\right|~~ |: At a finite distance to the left of Q1 the electric field is zero |:  None of the above\n','0','<p>Since the number of electric field lines of forces emerging from Q<sub>1</sub> is larger than terminating at Q<sub>2</sub>, the value of absolute charge Q<sub>1</sub> would be greater than the absolute value of Q<sub>2</sub><br>\nLet us assume the distance between the 2 charges is d\nAt any distance y, left of Q<sub>1</sub>, the electric field will be: $$E_{left} = \\frac{Q_1}{4\\pi\\epsilon_oy^2} - \\frac{Q_2}{4\\pi\\epsilon_o(y+d)^2}$$ Since Q<sub>1</sub> > Q<sub>2</sub> and y<sub>2</sub> < (y+d)<sup>2</sup> for a positive y, this term cannot be 0 for any value of y</p>',44,1,'',2,NULL,'../api/resources/questions/9img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(10,'<p>When two identical batteries of internal resistance 1~~\\Omega~~ each are connected in series across a resistor R, the rate of heat produced in R is J<sub>1</sub>. When the same batteries are connected in parallel across R, the rate is J<sub>2</sub>. If J<sub>1</sub> = 2.25J<sub>2</sub>  then the value of R in ~~\\Omega~~ is</p>','2.5 |: 4 |: 5 |: 4.3\n','1','Let the potential difference of each battery be V <br>\nFor series - <br>\nV<sub>1</sub> = 2V <br>\nR<sub>1</sub> = R+2<br>\nHence, $$J_1 = (\\frac{2V}{R + 2})^2 * R$$ For parallel - <br>\nV<sub>2</sub> = V\nR<sub>2</sub> = (1 * 1)/(1+1) + R <br> = 1/2 + R <br> Hence,  $$J_2 = (\\frac{V}{R+1/2})^2 * R$$ Since J<sub>1</sub>/J<sub>2</sub> = 2.25,    R=4~~\\Omega~~',45,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(11,'<p>A uniformly charged thin spherical shell of radius R carries uniform surface charge density of σ per unit area. It is made of two hemispherical shells, held together by pressing them with force F (see figure). F is proportional to: <img src = \"../api/resources/questions/11img1.jpg\"></p>','$$\\frac{\\sigma^2R^2}{\\epsilon_o}$$|:$$\\frac{\\sigma^2R}{\\epsilon_o}$$|:$$\\frac{\\sigma^2}{\\epsilon_oR}$$|:$$\\frac{\\sigma^2}{\\epsilon_o^2R^2}$$','0','Electrostatic Repulsive Force: $$F_{ele} \\propto = \\frac{\\sigma^2\\pi R^2}{\\epsilon_o}$$ Since F balances this force, hence it is proportional to $$\\frac{\\sigma^2R^2}{\\epsilon_o}$$',46,1,'',3,NULL,'../api/resources/questions/11img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(12,'A series R-C combination is connected to an AC voltage of angular frequency \\omega = 500 radian/s. If the impedance of the R-C circuit is R ~~\\sqrt{1.25}~~, the time constant (in millisecond) of the circuit is: ','5 |: 2.6 |:  4|:  6\n','2','<p>$$Z = R\\sqrt{1.25} = (\\sqrt{R^2 + \\frac{1}{\\omega C}})^2$$ $$\\frac{1}{4}R^2 = (\\frac{1}{\\omega C})^2$$ $$ \\frac{1}{4}R^2 = \\frac{1}{500C}$$ $$\\therefore\\tau = RC = \\frac{1}{250}s = 4 ms$$ </p>',47,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(13,'<p>How many milliliters of 0.1M H<sub>2</sub>SO<sub>4</sub> must be added to 50mL of 0.1M NaOH to give a solution that has a concentration of 0.05M in H<sub>2</sub>SO<sub>4</sub></p>','400 mL|:50 mL|:200 mL|:100 mL','3','<p>Vml 0.1M H<sub>2</sub>SO<sub>4</sub> + 50ml 0.1M NaOH ~~\\rightarrow~~ (V + 50)ml 0.05M H<sub>2</sub>SO<sub>4</sub><br><br>0.1 X V = (V + 50) X 0.05 + 2.5<br><br>\nV = 100ml</p>',61,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(14,'<p>An unknown amino acid has 0.032% Sulphur. If each molecule has one S-atom only, 1.0 g of amino acid has ____ molecules:</p>','6.02 X 10<sup>18</sup>|:\n6.02 X 10<sup>19</sup>|:\n6.02 X 10<sup>21</sup>|:\n6.02 X 10<sup>23</sup>','0','<p>Weight of sulpher in 1 gram <br><br>= 0.032 * 1 * 1/100 <br><br>= 3.2 * 10<sup>-4</sup> g<br><br>Mol of S = 3.2 * 10<sup>-4</sup>/32 = 10<sup>-5</sup><br><br>\nNo. of S atoms = 10<sup>-5</sup> * 6.023 * 10<sup>23</sup> <br><br> = 6.023 * 10<sup>18</sup> </p>',63,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(15,'<p>In the reaction, 8 Al + 3 Fe<sub>3</sub>O<sub>4</sub> ~~\\rightarrow~~ 4 Al<sub>2</sub>O<sub>3</sub> + 9 Fe, the number of electrons transferred from reductant to oxidant is: </p>','8|:4|:7|:24','3','<p>8 Al + 3 Fe<sub>3</sub>O<sub>4</sub> ~~\\rightarrow~~ 4 Al<sub>2</sub>O<sub>3</sub> + 9 Fe <br><br> Oxidation state of Al changes from 0 to +3 <br><br>=> No. of e<sup>-</sup> lost by 8 Al is 3 * 8 = 24 </p>',63,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(16,'<p>In the reaction, H<sub>3</sub>PO<sub>4</sub> + Ca(OH)<sub>2</sub>~~\\rightarrow~~ CaHPO<sub>4</sub> + 2H<sub>2</sub>O, the equivalent mass of H<sub>3</sub>PO<sub>4</sub> is: </p>','49|:32.7|:196|:98','0','<p>H<sub>3</sub>PO<sub>4</sub> + Ca(OH)<sub>2</sub>~~\\rightarrow~~ CaHPO<sub>4</sub> + 2H<sub>2</sub>O <br><br> In the given reaction H<sub>3</sub>PO<sub>4</sub> reacts as a dibasic acid, hence x = 2  <br><br>=> E(H<sub>3</sub>PO<sub>4</sub>) = M(H<sub>3</sub>PO<sub>4</sub>) / 2 = 98/2 = 49  </p>',61,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(17,'<p>Oxidation States of Chlorine in CaOCl<sub>2</sub> (bleaching powder) is/ are: </p>','+1 and -1|:+1 only|:-1 only|:None of these','0','<p>CaOCl<sub>2</sub> (bleaching powder), the structure is: <br> <br> One Cl exists as Chloride (CL<sup>-</sup>) and the other as OCl<sup>-</sup> (Oxy Chloride) </p>',61,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(18,'<p>6.54 g of Zn reacts with 0.25 M HNO3 solution. Volume of HNO3 consumed is: </p>','0.8 L|:0.25 L|:1.6 L|:None of these','2','<p>Zn + 4 HNO<sub>3</sub> → Zn(NO<sub>3</sub>)<sub>2</sub> + 2NO<sub>2</sub> + H<sub>2</sub>O<br><br>\nThe above equation is not of the type X + Y ~~\\rightarrow~~ A + B <br><br> In X + Y ~~\\rightarrow~~A + B type of reactions, central atoms of oxidizing agent and reducing agent should be in single molecules in product; for example, <br> <br>\n FeSO<sub>4</sub> + KMnO<sub>4</sub> + H<sub>2</sub>SO<sub>4</sub> ~~\\rightarrow~~ Fe<sub>2</sub>(SO<sub>4</sub>)<sub>3</sub> + MnSO<sub>4</sub> + K<sub>2</sub>SO<sub>4</sub> + H<sub>2</sub>0</p>',62,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(19,'<p>The molar ratio of Fe<sup>2+</sup> to Fe<sup>3+</sup> in a mixture of FeSO<sub>4</sub> and Fe<sub>2</sub>(SO<sub>4</sub>)<sub>3</sub> having equal number of sulphate ions is:</p>','1:2|:3:2|:2:3|:None of these','3','<p>FeSO<sub>4</sub> ~~\\rightarrow~~ Fe<sub>2+</sub> + S0<sub>4</sub><sup>2-</sup> <br><br>Fe<sub>2</sub>(SO<sub>4</sub>)<sub>3</sub> ~~\\rightarrow~~  2Fe<sup>3+</sup> + 3SO<sub>4</sub><sup>2-</sup><br><br>Ratio of Fe<sup>2+</sup> to Fe<sup>3+</sup>=  ~~\\frac{3}{2}~~</p>',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(20,'<p>To remove permanent hardness (due to presence of CaSO<sub>4</sub>) of a 1 L sample of water, 10 mL of N/50 washing soda (Na<sub>2</sub>CO<sub>3</sub>) solution was added and the mixture was boiled and filtered. The filtrate was neutralized with 6 mL of N/50 HCl. The degree of hardness of water in ppm is ___.</p>','','4','<p>CaSO<sub>4</sub> + Na<sub>2</sub>CO<sub>3</sub> ~~\\rightarrow~~ CaCO<sub>3</sub> + Na<sub>2</sub>SO<sub>4</sub><br><br>  meq of HCl = meq of Na<sub>2</sub>CO<sub>3</sub> (excess) = 6/50<br><br>  meq of Na<sub>2</sub>CO<sub>3</sub> used with CaCO<sub>3</sub> = total meq of Na<sub>2</sub>CO<sub>3</sub> - excess meqs<br><br> = 10 X (1/50) - 6 X (1/50) = 2/25 = meq of CaCO<sub>3</sub><br><br> => wt. of CaCO<sub>3</sub> in 1 L sample = 2/25 X 50 = 4 mg<br><br> => degree of hardness = 4 ppm </p>',63,3,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(21,'<p>KMnO<sub>4</sub> reacts with KHC<sub>2</sub>O<sub>4</sub> in absence of any external acid. If stoichiometric co-efficient of KMnO<sub>4</sub> is 1 in the balanced reaction, then the co-efficient of KHC<sub>2</sub>O<sub>4</sub> is ___. </p>','','8','<p>$$( 8H^+ + 5e^- + MnO4^- \\rightarrow Mn^{2+} + 4H_20) * 2 $$ $$(C_2O_4^{2-} \\rightarrow 2CO_2 + 2e^- ) * 5$$  <table  style=\"text-align: center\"><tr><td>~~2MnO_4^-~~</td><td> +</td> <td>~~16 H^+~~</td><td> +</td> <td>~~5C_2O_4^{2-}~~</td> <td>~~\\rightarrow~~</td> <td>~~2Mn^{2+}~~</td> <td>+</td> <td>~~8H_2O~~</td> <td>+</td> <td>~~10CO_2~~</td></tr><tr><td>~~2MnO_4^-~~</td> <td>+</td> <td>~~11H^+~~</td> <td>+</td> <td>~~5HC_2O_4^-~~</td><td> ~~\\rightarrow~~</td> <td>~~2Mn^{2+}~~</td><td> +</td> <td>~~8H_2O~~</td> <td>+</td> <td>~~10CO_2~~</td></tr><tr><td>~~2K^+~~</td><td></td><td>~~11K^+ + 11C_2O_4^{2-}~~</td><td></td><td>~~5K^+~~</td><td></td><td>~~2K^+~~</td><td></td><td> ~~11K^+~~</td><td></td><td>~~ 11C_2O_4^{2-}~~</td><td></td><td> ~~ 5K^+~~</td></tr></table> $$ 2KMnO_4 + 16 KHC_2O_4\\rightarrow 2MnC_2O_4 + 8H_2O + 10CO_2 + 9K_2C_2O_4$$   Answer: 8 </p>',61,3,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(22,'1.8 g of Oxalic Acid (COOH)<sub>2</sub>.xH<sub>2</sub>O are dissolved in water and the volume made upto 250ml. On titration, 21ml of this solution requires 24ml of N/10 NaOH solution for complete neutralization. The value of x is: ','1|:2|:3|:None of these','1','meq of NaOH = meq of oxalic acid in 21 ml = 24 X 1/10 <br> meq of oxalic acid in 250ml = (24 X 1/10) X (250 / 21) <br> meq of oxalic acid  <br>= (1.8 / (M0 / 2)) X 1000 = (24 X 1/10) X (250/21)  => <br>M<sub>0</sub> = 126 = 90 + 18x  => x = 2',63,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(23,'<p>How much NaOH should be added to 1 L of a buffer solution containing 0.1 M each of CH<sub>3</sub>COOH and CH<sub>3</sub>COONa so as to increase pH by 0.5 units.  (K<sub>a</sub> = 10<sup>-5</sup>)</p>','0.032|:0.041|:0.052|:0.01','2','<table style = \"text-align:center\"> <tr> <td></td><td>CH<sub>3</sub>COOH </td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp &nbsp</td> <td> CH<sub>3</sub>COO<sup>-</sup></td> <td> +</td> <td>H<sup>+</sup></td></tr><tr><td>t=0 &nbsp</td><td>0.1</td><td></td><td>0.1</td><td></td><td>-</td></tr><tr><td>t=t<sub>eq</sub>&nbsp </td><td>(0.1-x)</td><td> </td><td>(0.1+x)</td><td></td><td>x</td></tr></table><br>=>(0.1x) / (0.1)  = 10<sup>-5</sup><br><br>x = 10<sup>-5</sup><br><br>Initial pH = 5<br>pH<sub>new</sub> = 5.5<br><br><table style = \"text-align:center\"> <tr> <td>CH<sub>3</sub>COOH </td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp </td> <td> CH<sub>3</sub>COO<sup>-</sup></td> <td> +</td> <td>H<sup>+</sup></td></tr><tr><td>(0.1 - z)</td><td></td><td>(0.1 + z)</td><td></td><td>10<sup>5.5</sup> </td></tr></table><br>$$\\frac{(0.1+z)}{(0.1-z)}* 10^{-5.5} = 10^5 $$ $$=>0.1+z  = 0.1\\sqrt{10}-\\sqrt{10}z$$ $$z = \\frac{0.1(\\sqrt{10}-1)}{(\\sqrt{10}+1)}$$=0.052',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(24,'<p>20 ml solution of 0.1 M weak base BOH is titrated with 0.1 M HCl solution. [H<sup>+</sup>] at end point is (Kb = 5 X 10<sup>-12</sup>): </p>','10-2|:9 X 10-3|:1.15 X 10-2|:None of these','2','<p><table style = \"text-align:center\"> <tr> <td></td><td>B<sup>+</sup></td><td> + </td><td>H<sub>2</sub>O</td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp </td> <td> BOH</td> <td> + </td> <td>H<sup> + </sup></td></tr><tr><td>t=0 &nbsp</td><td>2/40</td><td></td><td>-</td><td></td><td>-</td><td></td><td>-</td></tr><tr><td>t=t<sub>eq</sub> &nbsp</td><td>2/40-x</td><td></td><td>-</td> <td></td><td>x</td><td></td><td>x</td></tr></table> <br>$$K_h = K_w / K_b \\frac{10^{-14}}{5 * 10^{-10}}$$ $$ K_h= 2 * 10^{-3} $$ $$\\frac{x.x}{\\frac{1}{20}-x} = 2 * 10^{-3}$$ $$x = 9*10^{-3}$$</p>',61,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(25,'<p>Which of the following relation is correct ? All are 1 L solution (use K<sub>a</sub> = K<sub>b</sub> = 10<sup>-5</sup>) <br> 0.1 mol NaOH + 0.1 mol HCl ~~\\rightarrow~~ pH<sub>1</sub><br>0.01 mol NaOH + 0.1 mol NH<sub>4</sub>Cl ~~\\rightarrow~~ pH<sub>2</sub> <br> 0.01 mol NH<sub>4</sub>OH + 0.01 mol CH<sub>3</sub>COOH ~~\\rightarrow~~ pH<sub>3</sub> <br> 0.01 mol CH<sub>3</sub>COOH + 0.01 mol HCl ~~\\rightarrow~~ pH<sub>4</sub></p>','pH<sub>4</sub> < pH<sub>1</sub> = pH<sub>3</sub> < pH<sub>2</sub>|:pH<sub>4</sub> < pH<sub>1</sub> < pH<sub>3</sub> < pH<sub>4</sub>|:pH<sub>4</sub> < pH<sub>2</sub> < pH<sub>1</sub> < pH<sub>3</sub>|:pH<sub>1</sub> < <sub>pH3</sub> < <sub>pH4</sub> < <sub>pH2</sub>','0','<p>0.1mol NaOH + 0.1mol HCl ~~\\rightarrow~~ pH = 7  <br><br>0.01mol NH<sub>4</sub>OH + 0.01mol CH<sub>3</sub>COOH ~~\\rightarrow~~ pH = 7<br> <br> (since K<sub>a</sub> = K<sub>b</sub> = 10<sup>-7</sup>)  <br><br> 0.01 mol CH<sub>3</sub>COOH + 0.01 mol HCl ~~\\rightarrow~~ pH < 7  <br><br>0.01 mol NaOH + 0.1 mol NH<sub>4</sub>Cl ~~\\rightarrow~~ pH > 7 <br> \n<table style = \"text-align:center\"> <tr> <td></td><td>NH<sub>4</sub>OH </td><td> &nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp </td> <td> CH<sub>4</sub><sup>+</sup></td> <td> +</td> <td>OH<sup>-</sup></td></tr><tr><td>t=0 &nbsp</td><td>-</td><td></td><td>0.1</td><td></td><td>0.01</td></tr><tr><td>t=t<sub>eq</sub>&nbsp</td><td>0.01</td><td></td><td>0.09</td><td></td><td>x</td></tr></table><br><br> x = ~~1/9 * 10^{-5} ~~</p>',63,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(26,'<p>The equilibrium constant for the reaction: <br><br>~~N_{2(g)} + O_{2(g)} \\rightleftharpoons 2NO_{(g)} is 4 * 10^{-4}~~ at 200K<br><br> In the presence of a catalyst, the equilibrium is attained 10 times faster. Therefore the equilibrium constant in presence of a catalyst at 200 K is: </p>','~~4*10^-3~~|:~~4*10^-4~~|:~~4*10^-5~~|:None of these','1','<p>K<sub>eq</sub> does not change even if the catalyst is changed</p>',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(27,'<p>For the reaction in equilibrium<br><br> &nbsp  ~~2NOBr_{(g)} \\rightleftharpoons 2NO_{(g)} + Br_{2(g)}~~   if ~~P_{(Br2)} = P/9~~ at equilibrium and P is the total pressure. The ratio of K<sub>p</sub> / P is equal to: </p>','1/9|:1/81|:1/27|:1/5','1','<p><table style=\"text-align: center\"><tr><td></td><td>~~2NOBr_{(g)}~~</td> <td>&nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp</td> <td>~~2NO_{(g)}~~</td> <td>+</td> <td>~~Br_{2(g)}~~</td></tr><tr><td>t = t<sub>eq</sub> &nbsp</td> <td>~~P_o - x~~</td><td></td><td> x </td><td></td> <td>x/2<td> </tr></table><br> We are given:$$P_{(Br_2)eq} = x/2 = P/9 => x = 2P/9  $$ $$P_{(NO)eq} = 2P/9$$ $$ P_{(T)eq} = P_o + x/2 = P $$ $$ =>P_o = 8P/9$$ $$=> P_o - x = 2P/3$$ $$K_p = \\frac{P(NO)^2 P(Br_2)^1}{P(NOBr)^2} =\\frac {(\\frac{2P}{9})^2.(\\frac{P}{9})}{(\\frac{2P}{3})^2} = \\frac{1}{81}.P$$</p>',62,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(28,'<p>~~PCl_5~~ dissociates in a closed container as:$$PCl_{5(g)} \\rightleftharpoons  PCl_{3(g)} + Cl_{2(g)}$$ If total pressure at equilibrium of the reaction mixture is P, and the degree of dissociation of ~~PCl_5~~ is ~~\\alpha~~ , the partial pressure of ~~PCl_3~~ will be:</p>','~~P.[\\frac{\\alpha}{\\alpha +1}]~~|:~~P.[\\frac{2\\alpha}{\\alpha -1}]~~|:~~P.[\\frac{\\alpha}{\\alpha -1}]~~|:~~P.[\\frac{\\alpha}{1 - \\alpha}]~~','0','<table style=\"text-align: center\"><tr><td>~~PCl_{5(g)}~~</td><td> ~~\\rightleftharpoons~~</td><td> ~~PCl_{3(g)}~~</td><td> + </td><td>~~Cl_{2(g)}~~</td></tr><tr><td>~~a - a\\alpha~~</td><td></td><td>~~a\\alpha~~</td><td></td><td>~~a\\alpha~~</td><td></tr></table>$$P(PCl_{3(g)})_{eq} = \\frac{a\\alpha}{a + a\\alpha}.P$$ $$\\frac {\\alpha}{1 + 1\\alpha}.P$$',61,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(29,'<p>Equal volumes of two solutions of HCl are mixed. One solution has a pH 1 while the other has a pH 6. The pH of the resulting solution is:</p>','Less than 1|:Between 1 & 2|:4|:7','1','<p>1L of (pH=1) solution + 1L of (pH=6) solution <br>$$=>[H^+]mix = \\frac{10^{-1} +10^{-6}}{2}\\approx\\frac{10^{-1}}{2}$$ <br>pH = 1.3</p>',61,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(30,'<p>The equilibrium constants K<sub>p1</sub> and K<sub>p2</sub> for the reactions X -> 2Y and Z -> P + Q, respectively are in the ratio of 1:9. If the degree of dissociation of X and Z are equal, then the ratio of total pressures at these equilibria is:  (Assume all species to be gaseous)</p>','1:9|:1:1|:1:3|:1:36','3','<p><table style=\"text-align: center\"><tr><td></td><td>&nbspX&nbsp</td><td>&nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp</td><td>&nbsp2Y&nbsp</td></tr><tr><td>t=teq&nbsp</td><td>(a - a ~~\\alpha~~)</td> <td></td><td>2aα</td></tr></table>$$Kp_1 = \\frac{(\\frac{2a\\alpha P1}{a+a\\alpha})^2}{(\\frac{(a-a\\alpha) P1}{a+a\\alpha})^1} \\Rightarrow Kp_1 = \\frac{4\\alpha^2}{1 - \\alpha^2}P_1$$ <table style=\"text-align: center\"><tr><td></td> <td>Z</td><td>&nbsp&nbsp&nbsp~~\\rightleftharpoons~~&nbsp&nbsp&nbsp</td><td>P</td><td>+</td><td>Q</td></tr><tr><td>t=t<sub>eq</sub>&nbsp</td><td>~~c-c\\alpha~~</td> <td></td> <td>~~c\\alpha~~</td><td></td><td>~~c\\alpha~~</td></tr></table> $$Kp_2 = \\frac{(\\frac{c\\alpha P2}{c+a\\alpha})^2}{(\\frac{(c-c\\alpha) P2}{c+c\\alpha})^1} \\Rightarrow Kp_2 = \\frac{4\\alpha^2}{1-\\alpha^2}P_2$$ $$\\frac{Kp_1}{Kp_2} = \\frac{4P_1}{P_2} \\Rightarrow \\frac{1}{9} = \\frac{4P_1}{P_2} \\Rightarrow \\frac{P_1}{P_2} = \\frac{1}{36} $$</p>',63,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(31,'<p>XY<sub>2</sub> dissociates as:$$XY_{2(g)} \\rightleftharpoons XY_{(g)} + Y_{(g)}$$ When the initial pressure of XY<sub>2</sub> is 600 mm of Hg, the total equilibrium pressure is 800 mm Hg. Calculate K<sub>P</sub> for the reaction, assuming that the volume of the system remains unchanged</p>','50|:100|:166.6|:400','2','<p><table style=\"text-align: center\"><tr><td></td><td> ~~XY_{2(g)}~~</td><td>~~\\rightleftharpoons~~</td> <td> ~~XY_{(g)}~~</td><td> +</td><td>~~Y_{(g)}~~</td></tr><tr><td>t=0&nbsp</td><td>600</td><td></td><td>-</td><td></td><td>-</td></tr><tr><td>t=t<sub>eq</sub>&nbsp</td><td>600-x</td><td></td><td>x</td><td></td><td>x</td></tr></table> $$(P_T)_{eq} = 600 + x = 800 $$ $$\\Rightarrow x = 200$$ $$K_{p} = \\frac{x.x}{600-x} = \\frac{200.200}{600-200} = 100mm Hg$$</p>',63,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(32,'<p>Consider the reaction, $$A^- + H_2O \\rightleftharpoons  HA + OH^-$$ The K_a value for acid HA is 1.0 X 10<sup>-6</sup>. What is the value of K for this reaction?</p>','1.0 X 10<sup>6</sup>|:1.0 X 10<sup>-8</sup>|:1.0 X 10<sup>8</sup>|:1.0 X 10<sup>-5</sup>','1','<p> $$ A^- + H_2O \\rightleftharpoons HA + OH^-$$ K<sub>c</sub> = K<sub>w</sub> / K<sub>a</sub><br>= 10<sup>-14</sup> / 10<sup>-6</sup> <br> = 10<sup>-8</sup> </p>',63,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(33,'<p>A ball thrown vertically upwards with a velocity \'u\' reaches a maximum height of \'h\'. If the maximum height reached by the ball is to be doubled, then it should be thrown up with velocity</p>','2u|:4u|:~~\\sqrt2u~~|:~~\\sqrt3u~~','2','<img src=\"../api/resources/questions/33img1.jpg\" height = \"200\"><p>By conservation of mechanical energy $$mgh = \\frac{1}{2}mu^2$$ For double height:$$mg(2h) = \\frac{1}{2}mv^2$$ $$\\Rightarrow v^2 = 2u^2 $$ $$ v = \\sqrt2 u $$</p>',34,1,'',1,NULL,'../api/resources/questions/33img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(34,'A simple pendulum is released from the horizontal position \'H\' as shown. If \'m\' denotes the mass of the bob and \'l\' the length of the pendulum, the gain in KE at the position P is\n','~~\\frac{\\sqrt3mgl}{2}~~|:~~\\frac{mgl}{2}~~|:~~\\frac{mgl}{\\sqrt2}~~|:~~\\frac{mgl}~~','0','By conservation of energy between positions H \nand P<br>&nbsp&nbsp mg(l cos 30<sup>o</sup>) = 1/2 mv<sup>2</sup> - 0<br><br>&nbsp&nbsp KE = mgl cos 30<sup>o</sup> = ~~\\frac{\\sqrt3mgl}{2}~~<br> <img src=\"../api/resources/questions/34img1.jpg\" height = \"200\">',34,1,'',2,NULL,'../api/resources/questions/34img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(35,'<p>If the PE of the particle that moves along the x-axis under the action of a single conservative force is given by: $$U(x) = \\frac{a}{x^2} - \\frac{b}{x^3} $$ Then the PE of the particle at equilibrium is:</p>','$$\\frac{27b^3}{a^2}$$|:$$\\frac{4a^3}{27b^2}$$|:0|:$$\\frac{4b^3}{27a^2}$$','2','<p>U(x) = a/x<sup>2</sup> - b/x<sup>3</sup><br><br>Since F = -dU/dx<br><br>\nF = 2a/x<sup>3</sup> - 3b/x<sup>4</sup><br><br>\nAt equilibrium F = 0 => x = 3b/2a (substituting in U(x))\n$$\\Rightarrow U =\\frac{4a^3}{27b^2}$$</p>\n',35,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(36,'<p>The PE of a spring that is stretched by 1 cm is \'U\'. If it is stretched further by 2cm, the PE stored in it becomes</p>','2U|:3U|:8U|:9U','3','<p>$$(\\Delta x)_{initial} = 1 cm = 1/100 m$$\n$$(\\Delta x)_{final} = (1 + 2 ) cm = 3/100 m$$\n$$U_{final}  = \\frac{1}{2} k (\\Delta x)^2_{initial}$$\n $$ = \\frac{1}{2} k (\\frac{3}{100})^2 = 9 U_{initial}$$</p>',35,1,'',1,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(37,'<p>Based on the paragraph, answer the following. <br><br>Maximum elongation in the spring will be\n</p>','x/2|:x|:2x|:3x','1','<p>Let the velocities at some instant be V<sub>a</sub> and V<sub>b</sub> of block \'a\' and \'b\' as shown </p><img src=\"../api/resources/questions/37img2.jpg\" height = \"200\"><p>As there is no external force acting on the system of the two blocks, their momentum must be conserved<br><br>\nInitial momentum (when released) = 0<br><br> $$m_bV_b - m_aV_a =0  \\Rightarrow m_bV_b = m_aV_a$$ Elongation will be maximum when V<sub>a</sub> and V<sub>b</sub> become zero.<br><br>By conservation of energy:<br>$$\\frac{1}{2}kx^2 + \\frac{1}{2} m_a0^2 + \\frac{1}{2} m_b0^2 = \\frac{1}{2}k(\\Delta l)^2 + \\frac{1}{2} m_a0^2 + \\frac{1}{2} \nm_b0^2$$\n~~ \\Rightarrow \\Delta~~|= x (max elongation)</p>',35,1,'',2,1,'../api/resources/questions/37img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(38,'<p>Based on the paragraph, answer the following.<br><br>KE<sub>a</sub>/KE<sub>b</sub> when the spring attains its natural length will be</p>','1/8|:1/2|:2|:1/2~~\\sqrt2~~','2','<p>Let the velocities at some instant be V<sub>a</sub> and V<sub>b</sub> of block \'a\' and \'b\' as shown </p><img src=\"../api/resources/questions/38img01.jpg\" height = \"200\"><p>As there is no external force acting on the system of the two blocks, their momentum must be conserved<br><br>\nInitial momentum (when released) = 0<br><br>$$m_bV_b - m_aV_a =0  \\Rightarrow m_bV_b = m_aV_a$$ Elongation will be maximum when V<sub>a</sub> and V<sub>b</sub> become zero.$$\\frac{KE_a}{KE_b} = \\frac{1/2m_av_a^2}{1/2m_bv_b^2} = \\frac{m_av_a.v_a}{m_bv_b.v_b}=\\frac{v_a}{v_b}=\\frac{m_b}{m_a}$$ =>KE<sub>ratio</sub> = 2</p>\n',35,1,'',3,1,'../api/resources/questions/38img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(39,'<p>A body at rest, under the action of a constant force attains a velocity V in time T. The instantaneous power delivered to the body at time \'t\' is proportional to (for t<T)</p>','~~\\frac{V}{T}t~~|:~~\\frac{V^2}{T}t^2~~|:~~\\frac{V^2}{T^2}t~~|:~~\\frac{V^2}{T^2}t^2~~','2','<p>P = Fv  (v is the velocity at time \'t\')<br><br>Given velocity is V after time T<br><br>Ta + 0 = V &nbsp &nbsp v = 0 + at<br><br>v/t = V/T, hence v = Vt/T<br><br>F = m x a = mV/T $$P = m\\frac{V^2}{T^2}t$$</p> ',34,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(40,'<p>A particle of mass \'m\' moves along a straight line on a smooth horizontal surface under the action of a force that develops a constant power \'P\'. Distance covered by the particle as its speed increases from v to 2v is</p>','$$\\frac{7mv^3}{3P}$$|:$$\\frac{9mv^3}{5P}$$|:$$\\frac{12mv^3}{5P}$$|:$$\\frac{11mv^3}{7P}$$','0','<p> Constant Power  P = Fv<br> $$P = m\\frac{dv}{dt}v$$ $$P = mv\\frac{dv}{dx}\\frac{dx}{dt} \\Rightarrow P = mv^2\\frac{dv}{dx}$$ Integrating&nbsp&nbsp ~~\\int_{x}^{x+d}P.dx = \\int_{v}^{2v}mv^2.dx~~ $$P*d = \\frac{Tmv^3}{3}$$ $$\\Rightarrow d = \\frac{7mv^3}{3P} $$</p>',34,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(41,'<p> A block moving with a speed of 5 m/s on a smooth horizontal surface compresses a spring of spring constant 100 N/m attached to a wall by a maximum extent of 10cm. Work done by the spring force on the block (until maximum compression) is :</p><img src=\"../api/resources/questions/41img1.jpg\" height = \"200\">','+5J|:-5J|:+0.5J|:-0.5J','3','<p> $$W_{spring force}   = -(1/2 kx_{max}^2)$$ $$ = -1/2 (100) (10/100)^2 $$   = -0.5 J</p>',35,1,'',2,NULL,'../api/resources/questions/41img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(42,'<p>An object of mass 4 kg is dropped from a height  of 20 m above the ground in atmospheric air. It reaches the ground with a speed of 16m/s falling vertically. Work done by air drag on the body is : </p>','288 J|:-288 J|:512 J|:-512 J','1','<p>By the work energy theorm: </p><img src=\"../api/resources/questions/42img1.jpg\" height = \"200\"><p><table style= \"text-align: center\"><tr><td>Work Done by All Forces on a Particle</td><td> &nbsp&nbsp=&nbsp&nbsp </td><td>Change in KE of the Particle</td></tr><tr><td>W<sub>gvt</sub> + W<sub>airdrag</sub></td><td> &nbsp&nbsp=&nbsp&nbsp </td><td>~~\\Delta~~KE</td></tr></table> <br>\nmgh + W<sub>airdrag</sub> = 1/2 x 4 x 16<sup>2</sup> - 0<br><br>\nW<sub>airdrag</sub> = -288 J </p>',34,1,'',1,NULL,'../api/resources/questions/42img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(43,'<p>A block of mass 4kg falls on a light spring fixed to the ground from a height of 15 cm above the spring. If the spring constant is 2000 N/m, maximum compression in the spring will be:</p>\n','~~\\sqrt{15}cm~~|:2~~\\sqrt{15} cm~~|:10 cm|:20 cm','2','<p>Let the maximum compression in the spring be x cm. <br><br>At the instant of maximum compression vel of block = 0<br><br>By conservation of energy $$ \\frac{mg(h+x)}{100} = \\frac{1}{2}k(\\frac{x}{100})^2$$ => x = 10 cm</p>',34,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(44,'<p>An object of mass 4kg is moving along the +ve x-axis starting from the origin at t=0, such that its position x varies with time t as x<sup>2</sup> = 16t<sup>3</sup> ; x is in mts and t is in seconds. \nWork done on the object as a function of time can be shown as:</p>','<img src=\"../api/resources/questions/44img1.jpg\" height = \"200\">|:<img src=\"../api/resources/questions/44img2.jpg\" height = \"200\">|:<img src=\"../api/resources/questions/44img3.jpg\" height = \"200\">|:<img src=\"../api/resources/questions/44img4.jpg\" height = \"200\">','2','x<sup>2</sup> = 16t3 &nbsp&nbsp=>&nbsp&nbsp  x = 4t<sup>3/2</sup> <br>Differentiating, we get &nbsp  ~~v = 4 * 3/2 *t^{1/2} = 6\\sqrt t~~<br>\nFurther differentiating,  &nbsp a = 6 * 1/2 * t^{-1/2} = 4/\\sqrt t\n<br><br>\nF = ma = 12/\\sqrt t<br>Also v = dx/dt = 6\\sqrt t  &nbsp=>&nbsp dx = 6\\sqrt t.dt<br>dW = F.dx = 72.dt<br> dW = F.dx = 72.dt <br>W = ~~\\int_{0}^{t} 72.dt = 72t~~<br><br>W = 72t',35,1,'',3,NULL,'../api/resources/questions/44img1.jpg|:../api/resources/questions/44img2.jpg|:../api/resources/questions/44img3.jpg|:../api/resources/questions/44img4.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(45,'<p> Work done from t=3 seconds to t=5 seconds is </p>','72 J|:144 J|:100 J|:88 J','1','<p> dW = F.dx = 72.dt <br><br>W = ~~\\int_{3}^{5}72.dt = 144J~~<br><br>W = 144 J </p>',34,1,'',3,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(46,'<p> A man weighing 80 kgs is standing on a trolley weighing 320 kgs. The trolley is resting on frictionless horizontal rails. If the man starts walking on the trolley along the rails with a speed of 1m/s relative to the trolley, then after 4 seconds, the magnitude of his displacement relative to the ground will be </p>','5m|:4m|:3m|:3.2m','3','<p> Lets consider right side as +ve x direction </p> <img src=\"../api/resources/questions/46img1.jpg\" height = \"200\"><p>~~_t\\vec{V}_m = \\hat{i}~~ &nbsp&nbsp ~~\\vec{V}_t = -v\\hat{i}~~<br><br>~~\\vec{V}_m = _t\\vec{V}_m + \\vec{V}_t~~<br><br>&nbsp&nbsp= ~~(1-v)\\hat{i}~~<br><br>As no external force acts on the trolley man system in the horizontal direction, the momentum of the system in the horizontal direction must be conserved. <br><br>&nbsp&nbsp~~M_{man}V_m + M_{trolley}V_t = 0~~   (initial momentum)<br><br>&nbsp&nbsp ~~80 (1-v)\\hat{i} - 320v\\hat{i} = 0 <br><br> => 1-v = 4v <br>=> v = 1.5m/s<br>=>\\vec{V}_m=4/5\\hat{i} \\Rightarrow \\left |\\Delta\\vec{r}\\right| = 4/5* 4 = 3.2m~~ </p>',35,1,'',2,NULL,'../api/resources/questions/46img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(47,'<p> An object of mass \'m\' moving with velocity \'v\' is directly approaching another object of the same mass at rest. The K.E. of this system as viewed from the center of mass of their system is </p>','(mv<sup>2</sup>)/4|:(mv<sup>2</sup>)|:(mv<sup>2</sup>)/8|:(mv<sup>2</sup>)/2','0','<p> Lets consider right side as +ve x direction</p><img src=\"../api/resources/questions/47img1.jpg\" height = \"200\"><p> $$\\vec{V}_{cm}=\\frac{m_1\\vec{V}_1+m_2\\vec{V}_2}{m_1+m_2}$$ &nbsp &nbsp &nbsp v/2(towards right) <br><br> ~~KE_{from center of mass}~~ = 1/2 m(-v/2)<sup>2</sup> + 1/2 m(v/2)<sup>2</sup> <br> = 1/4 mv<sup>2</sup> </p>',33,1,'',2,NULL,'../api/resources/questions/47img1.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(48,'<p> Particle \'x\' (mass = 4kg) and \'y\'(mass = 9kg) move directly towards each other, collide and then separate moving away from each other. If ~~\\Delta \\vec{v_x}~~ is change in velocity of x, and ~~\\Delta\\vec{v_y}~~ that of y, then, $$\\frac{\\left|\\Delta \\vec{v_x}\\right|} {\\left|\\Delta \\vec{v_y}\\right|}$$ is: </p>','4/9|:9/4|:2/3|:3/2','2','<img src=\"../api/resources/questions/48img1.jpg\" height = \"200\">&nbsp&nbsp&nbsp&nbsp<img src=\"physics048img2.jpg\" height = \"200\"><p> Let direction towards right be +ve direction $$\\Delta \\vec{v_y}  = v_2 \\hat{i} -(-u_2 \\hat{i}) = (v_2 + u_2) \\hat{i}$$ $$\\Delta \\vec{v_x}  = -v_1 \\hat{i} -(u_1 \\hat{i}) = -(v_1 + u_1) \\hat{i}$$\nBy conservation of linear momentum $$ 4u_1 \\hat{i} - 9u_2 \\hat{i} = -4v_1\\hat{i} + 9v_2 \\hat{i}$$ $$4(v_1 + u_1) \\hat{i} = 9 (v_2 + u_2) \\hat{i} $$ $$ [\\frac{\\left|\\Delta \\vec{v_x}\\right|} {\\left|\\Delta \\vec{v_y}\\right|}] = \\frac{(v_1+u_1}{v_2+u_2}=\\frac{9}{2}$$</p>',35,1,'',3,NULL,'../api/resources/questions/48img1.jpg|:../api/resources/questions/48img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(49,'<p>A ball collides directly with another similar ball at rest. K.E. of the system is reduced by half due to the impact. The value of co-efficient of restitution is </p>','1/2|:1/4|:0|:~~1/\\sqrt2~~','2','<img src=\"../api/resources/questions/49img1.jpg\" height = \"200\">&nbsp&nbsp&nbsp&nbsp<img src=\"../api/resources/questions/49img2.jpg\" height = \"200\"> <p>Conserving Momentum: <br>&nbsp&nbsp&nbsp&nbsp mv<sub>1</sub> + mv<sub>2</sub> = mv<br><br>\nand KE is reduced to half:<br>&nbsp&nbsp&nbsp&nbsp~~1/2 [ 1/2 mv^2] = [ 1/2 mv_1^2 + 1/2 mv_2^2] ~~<br><br>\n~~ \\Rightarrow v_1 + v_2 = v~~ and ~~v_1^2 + v_2^2 = v^2/2~~<br><br>~~\\Rightarrow v_1 = v_2 = v/2~~, hence e = 0 </p>',35,1,'',3,NULL,'../api/resources/questions/49img1.jpg|:../api/resources/questions/49img2.jpg',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(50,'<p>A body of mass 2kg at rest is acted upon by a force as shown in the graph. The magnitude of momentum of the body after 6 seconds is (in N-s)</p>','50|:100|:25|:60','2','<p>By impulse momentum theorem: <br><br>\n~~\\vec{Impulse} = \\vec{\\Delta P}~~ and ~~\\left|\\vec{Impulse}\\right| =~~ Area under F-t graph<br><br>Area = ~~1/2 * 2 * 10 + 10 * (6-2) = 50 N-s~~<br><br>~~\\left|\\vec{P_f} - \\vec{P_i}\\right| = 50~~&nbsp&nbsp&nbsp&nbsp ~~ \\vec{P_i} = 0~~ (starts from rest)<br><br>~~\\left|\\vec{P_f}\\right| = 50 N-s~~</p>',33,1,'',2,NULL,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(51,'<p>Based on the paragraph, answer the following</p><p>Velocity of center of mass of the system (A + B + Spring) before collision is:</p>','~~26 \\hat{i} m/s~~|:~~0 \\hat{i} m/s~~|:~~10 \\hat{i} m/s~~|:~~1\\hat{i} m/s~~\n','3','<p> We can create a table for the velocity of block \'A\' and Block \'B\'. Right direction is given to be +ve x direction <table style=\"text-align: center\" frame = \"border\"> <tr><td></td><td>Velocity (M<sub>a</sub> = 6kg)&nbsp&nbsp</td><td>&nbsp&nbspVelocity (M<sub>b</sub> = 4kg)</td></tr><tr><td> Initial:</td><td>~~3\\hat{i}~~</td><td>-~~2\\hat{i}~~</td></tr><tr><td>Max Compression:</td><td></td><td></td></tr><tr><td>\'A\' at Rest:</td><td>0</td><td></td></tr><tr><td>Final:</td><td></td><td></td></tr></table><br><br>\nInitial energy   = (KE)<sub>Block A</sub> + (KE)<sub>Block B</sub> + (PE)<sub>Spring</sub> <br>\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp     = 1/2 * 6 * 32  + 1/2 * 4 * 22 + 0 = 35J <br><br>\nInitial momentum  = ~~\\left|\\vec{(M_aV_a)}_{initial} + \\vec{(M_bV_b)}_{initial}\\right| ~~<br>\n&nbsp&nbsp&nbsp&nbsp     = 6 * 3 + 4 * (-2) = 10 N-s <br><br>\nCalculating the velocity of center of mass (V<sub>cm</sub>) <br><br>\n~~V_{cm}  = (m_aV_a + m_bV_b) / (m_a + m_b)~~<br> ~~= (18 \\hat{i} - 8 \\hat{i}) / 10 ~~<br>~~ = \\hat{i}~~ </p>',33,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(52,'<p>Based on the paragraph, answer the following. <ul> <li>Let LM denote Linear Momentum of system,</li><li>KE denote Kinetic Energy of the system,</li><li>ME denote Mechanical Energy of the system</li></ul>Then, which of the following is conserved<br></p>','LM & KE|:Only KE|:LM &ME|:Only LM','2','<p> Let the system be: Block A, Block B & Spring<br><br>Since there is no external force on the system in the horizontal direction : <br>\n<ol><li>Linear momentum of the system in horizontal direction must be conserved</li>\n<li>Velocity of center of mass of the system will be a constant</li></ol><br>\nAlso mechanical energy of the system will be conserved as there are no dissipative forces acting on the system</p>',34,1,'',3,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(53,'<p> Based on the paragraph, answer the following. <br><br>Final velocity of A is </p>','~~\\hat{i} m/s~~|:~~ -\\hat{i} m/s~~|:~~0 \\hat{i} m/s~~|:~~5/3 \\hat{i} m/s~~','1','<p> The block will separate when spring comes back to the natural length (let v<sub>1</sub>, v<sub>2</sub> be the velocities): <br><br>\nBy COLM  6v<sub>1</sub> + 4v<sub>2</sub> = 10<br>\nBy COE     ~~1/2 * 6 * v_1^2 + 1/2 * 4 * v_2^2 = 35~~<br><br>  On solving<br>\n&nbsp&nbsp&nbsp&nbsp v<sub>1</sub> = 3, -1 <br><br>Final velocity of ~~A = -\\hat{i}~~ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(54,'<p> Based on the paragraph, answer the following.<br><br>Final velocity of the center of mass of the system (A + B + spring) is </p>','~~\\hat{i} m/s~~|:~~5/3 \\hat{i} m/s~~|:~~10 \\hat{i} m/s~~|:~~5/2 \\hat{i} m/s~~','0','<p> Since there is no external force on the system in the horizontal direction :<br>\n<ol><li>Linear momentum of the system in horizontal direction must be conserved</li><li>Velocity of center of mass of the system will be a constant</li><ol><br><br>Hence as in Q19, the velocity V<sub>cm</sub> is ~~\\hat{i}~~ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(55,'<p> Based on the paragraph, answer the following. <br><br>When block \'A\' comes to momentary rest during the compression process, the velocity of block \'B\' is </p>','0 m/s|:~~5/3 \\hat{i} m/s~~|:~~5/2 \\hat{i} m/s~~|:~~\\hat{i} m/s~~','2','<p> When block \'A\' comes to rest v<sub>a</sub> = 0<br><br>By conservation of linear momentum (COLM) <br><br>~~6 * 0 + 4 * v_b\\hat{i} = ~~ Initial Momentum ~~= 10 \\hat{i} ~~<br>  $$\\Rightarrow v_b = 10/4 \\hat{i} = 5/2 \\hat{i}$$ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(56,'<p> Based on the paragraph, answer the following.<br><br>When block \'A\' comes to momentary rest during the compression process, the compression in the spring is (in cms) </p>','~~6\\sqrt{3}~~|:~~6\\sqrt{2}~~|:9|:12','3','<p> Let x cm be the compression, applying conservation of energy (COE):$$ 1/2 * kx^2/100^2 + 0 + 1/2 * 4 * 25/4 = 35 $$ On Solving:<br>  $$x = 6\\sqrt{3} cm$$ </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0),
	(57,'<p> Based on the paragraph, answer the following. <br><br>The maximum compression in the spring is (in cms)</p>','~~6\\sqrt{3}~~|:12|:15|:9','3','<p> During max compression ~~v_a = v_b~~, by COLM<br><br> ~~6 * v_a + 4 * v_b = 10 \\hat{i}~~ <br><br>~~v_a = v_b = \\hat{i}~~<br><br>By COE :<br> &nbsp &nbsp &nbsp ~~1/2 * kx_2 + 1/2 * (6+4) * 12 = 35~~ <br> On solving: x = 12 cm </p>',34,1,'',2,2,'',0,0,0,0,0,0,0,4,-1,0,0,0,0,0);

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
	(1,'1|:2|:3|:4|:5|:6|:7|:8|:9|:10|:11|:12','Advanced Questions on Electricity & Magnetism','Questions on Electricity & Magnetism from the last 4 years IIT-JEE papers','Electricity & Magnetism','IIT JEE','44|:45|:46|:47','7',12,3600,2,NULL,0,2,3,NULL,NULL,NULL,0,1,36),
	(2,'13|:14|:15|:16|:17|:18|:19|:20|:21|:22|:23|:24|:25|:26|:27|:28|:29|:30|:31|:32','Covers Redox Reactions , Stoichiometry, Chemical and Ionic Equilibrium','Advanced questions on Physicl Chemistry','Physical Chemistry','','61|:62|:63','10',20,3600,2,NULL,0,2,1,NULL,NULL,NULL,0,1,100),
	(3,'33|:34|:35|:36|:37|:38|:39|:40|:41|:42|:43|:44|:45|:46|:47|:48|:49|:50|:51|:52|:53|:54|:55|:56|:57','Practice Set on Kinematics & Collisions','Medium difficulty question to strengthen the key topics of Kinematics and Collisions','Mechanics','','34|:35','6',25,3600,2,NULL,0,2,2,NULL,NULL,NULL,0,1,100);

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
	(4,5,'0',3397,48,-1,'2013-01-15 05:23:24',NULL),
	(4,33,'1',9213,50,-1,'2013-01-15 08:03:31',NULL),
	(4,34,'0',3617,50,2,'2013-01-15 08:03:40',NULL),
	(4,34,'0',5131,52,2,'2013-01-15 08:06:21',NULL),
	(4,35,'1',2375,50,-1,'2013-01-15 08:06:25',NULL),
	(4,33,'1',2913,54,-1,'2013-01-15 08:23:28',NULL),
	(4,34,'',188993,54,0,'2013-01-15 08:23:28',NULL),
	(4,35,'',636010,50,0,'2013-01-15 08:23:28',NULL),
	(4,36,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,37,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,38,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,39,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,40,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,41,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,42,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,43,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,44,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,45,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,46,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,47,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,48,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,49,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,50,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,51,'',0,50,0,'2013-01-15 08:23:28',NULL),
	(4,52,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,53,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,54,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,55,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,56,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,57,'',0,54,0,'2013-01-15 08:23:28',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:25:33',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:25:33',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:25:33',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:25:33',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:26:43',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:26:43',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:26:43',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:26:43',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:28:15',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:28:15',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:28:15',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:28:15',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:28:15',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:28:15',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:28:15',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:28:15',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:28:16',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:28:16',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:28:51',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:28:51',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:28:51',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:28:51',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:30:15',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:30:15',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:30:15',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:30:15',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:32:18',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:32:18',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:32:18',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:32:18',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:32:42',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:32:42',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:32:42',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:32:42',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:33:57',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:33:57',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:33:57',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:33:57',NULL),
	(4,13,'2',1527,50,-1,'2013-01-15 08:36:35',NULL),
	(4,14,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,15,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,16,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,17,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,18,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,19,'1',2481,50,-1,'2013-01-15 08:36:35',NULL),
	(4,20,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,21,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,22,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,23,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,24,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,25,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,26,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,27,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,28,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,29,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,30,'1',2511,50,-1,'2013-01-15 08:36:35',NULL),
	(4,31,'',0,50,0,'2013-01-15 08:36:35',NULL),
	(4,32,'',0,50,0,'2013-01-15 08:36:35',NULL);

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
  `state` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;

INSERT INTO `results` (`quizId`, `accountId`, `selectedAnswers`, `score`, `timePerQuestion`, `timeTaken`, `data`, `timestamp`, `attemptedAs`, `startTime`, `endTime`, `state`)
VALUES
	(2,4,NULL,NULL,NULL,NULL,'[{\"t\":\"1358218527054\",\"e\":\"10\"},{\"t\":\"1358218527073\",\"e\":\"3\",\"q\":\"13\"},{\"t\":\"1358218527944\",\"e\":\"0\",\"q\":\"13\",\"o\":\"2\"},{\"t\":\"1358218528600\",\"e\":\"4\",\"q\":\"13\"},{\"t\":\"1358218528603\",\"e\":\"3\",\"q\":\"19\"},{\"t\":\"1358218529225\",\"e\":\"0\",\"q\":\"19\",\"o\":\"2\"},{\"t\":\"1358218529349\",\"e\":\"1\",\"q\":\"19\",\"o\":\"2\"},{\"t\":\"1358218530046\",\"e\":\"0\",\"q\":\"19\",\"o\":\"1\"},{\"t\":\"1358218531084\",\"e\":\"4\",\"q\":\"19\"},{\"t\":\"1358218531087\",\"e\":\"3\",\"q\":\"30\"},{\"t\":\"1358218531661\",\"e\":\"0\",\"q\":\"30\",\"o\":\"2\"},{\"t\":\"1358218532193\",\"e\":\"1\",\"q\":\"30\",\"o\":\"2\"},{\"t\":\"1358218532193\",\"e\":\"0\",\"q\":\"30\",\"o\":\"3\"},{\"t\":\"1358218532756\",\"e\":\"1\",\"q\":\"30\",\"o\":\"3\"},{\"t\":\"1358218532756\",\"e\":\"0\",\"q\":\"30\",\"o\":\"1\"},{\"t\":\"1358218533598\",\"e\":\"4\",\"q\":\"30\"},{\"t\":\"1358218533598\",\"e\":\"8\"}]','2013-01-15 08:36:35',1,'2013-01-15 04:22:44',NULL,20),
	(3,4,NULL,NULL,NULL,NULL,'[{\"t\":\"1358217965162\",\"e\":\"10\"},{\"t\":\"1358217965181\",\"e\":\"3\",\"q\":\"33\"},{\"t\":\"1358217967022\",\"e\":\"0\",\"q\":\"33\",\"o\":\"1\"},{\"t\":\"1358217968094\",\"e\":\"4\",\"q\":\"33\"},{\"t\":\"1358217968097\",\"e\":\"3\",\"q\":\"34\"},{\"t\":\"1358217969176\",\"e\":\"4\",\"q\":\"34\"},{\"t\":\"1358217969177\",\"e\":\"8\"},{\"t\":\"1358218156011\",\"e\":\"4\",\"q\":\"34\"},{\"t\":\"1358218156016\",\"e\":\"3\",\"q\":\"35\"},{\"t\":\"1358218157987\",\"e\":\"4\",\"q\":\"35\"},{\"t\":\"1358218157987\",\"e\":\"8\"},{\"t\":\"1358218235275\",\"e\":\"4\",\"q\":\"35\"},{\"t\":\"1358218235275\",\"e\":\"8\"},{\"t\":\"1358218293411\",\"e\":\"4\",\"q\":\"35\"},{\"t\":\"1358218293411\",\"e\":\"8\"},{\"t\":\"1358218320622\",\"e\":\"4\",\"q\":\"35\"},{\"t\":\"1358218320623\",\"e\":\"8\"},{\"t\":\"1358218408795\",\"e\":\"4\",\"q\":\"35\"},{\"t\":\"1358218408796\",\"e\":\"8\"}]','2013-01-15 08:23:28',1,'2013-01-15 04:31:24',NULL,2),
	(1,4,NULL,NULL,NULL,NULL,'[{\"t\":\"1358255462818\",\"e\":\"3\",\"q\":\"3\"},{\"t\":\"1358255464993\",\"e\":\"0\",\"q\":\"3\",\"o\":\"2\"},{\"t\":\"1358255467002\",\"e\":\"4\",\"q\":\"3\"}]','2013-01-15 18:41:07',2,'2013-01-15 04:47:01',NULL,3);

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
  `weightage` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `l1Id` (`l1Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `section_l2` WRITE;
/*!40000 ALTER TABLE `section_l2` DISABLE KEYS */;

INSERT INTO `section_l2` (`id`, `displayName`, `longName`, `l1Id`, `streamId`, `weightage`)
VALUES
	(1,'Algebra','NULL',1,1,1),
	(2,'Trigonometry','NULL',1,1,1),
	(3,'Coordinate Geometry','NULL',1,1,1),
	(4,'Calculus','NULL',1,1,1),
	(5,'General','NULL',2,1,1),
	(6,'Mechanics','NULL',2,1,1),
	(7,'Electricity and Magnetism','NULL',2,1,1),
	(8,'Optics','NULL',2,1,1),
	(9,'Modern Physics','NULL',2,1,1),
	(10,'Physical Chemistry','NULL',3,1,1),
	(11,'Inorganic Chemistry','NULL',3,1,1),
	(12,'Organic Chemistry','NULL',3,1,1),
	(13,'General','NULL',4,2,1),
	(14,'Mechanics','NULL',4,2,1),
	(15,'Electricity and Magnetism','NULL',4,2,1),
	(16,'Optics','NULL',4,2,1),
	(17,'Modern Physics','NULL',4,2,1),
	(18,'Physical Chemistry','NULL',5,2,1),
	(19,'Inorganic Chemistry','NULL',5,2,1),
	(20,'Organic Chemistry','NULL',5,2,1),
	(21,'Biochemistry','NULL',5,2,1),
	(22,'Diversity in Living World','NULL',6,2,1),
	(23,'Structures in Plants and Anima','NULL',6,2,1),
	(24,'Cell Structure and Function','NULL',6,2,1),
	(25,'Plant Physiology','NULL',6,2,1),
	(26,'Human Physiology','NULL',6,2,1),
	(27,'Reproduction','NULL',6,2,1),
	(28,'Genetics and Evolution','NULL',6,2,1),
	(29,'Biology and Human Welfare','NULL',6,2,1),
	(30,'Biotechnology and its applicat','NULL',6,2,1),
	(31,'Ecology and Environment','NULL',6,2,1);

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
  `weightage` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `section_l3` WRITE;
/*!40000 ALTER TABLE `section_l3` DISABLE KEYS */;

INSERT INTO `section_l3` (`id`, `displayName`, `longName`, `l2Id`, `streamId`, `weightage`)
VALUES
	(1,'Sets, Relations & Functions','',1,1,1),
	(2,'Equations','',1,1,1),
	(3,'Complex Numbers','',1,1,1),
	(4,'Progressions','',1,1,1),
	(5,'Logarithms','',1,1,1),
	(6,'Permutations and Combinations','',1,1,1),
	(7,'Binomial Theorem','',1,1,1),
	(8,'Matrices','',1,1,1),
	(9,'Probability','',1,1,1),
	(10,'Mathematical Induction','',1,1,1),
	(11,'Trigonometric Equations','',2,1,1),
	(12,'Sine Rule','',2,1,1),
	(13,'Cosine Rule','',2,1,1),
	(14,'Half angle formula','',2,1,1),
	(15,'Inverse Trigonometric functions','',2,1,1),
	(16,'Cartesian Coordinates','',3,1,1),
	(17,'Lines','',3,1,1),
	(18,'Triangles','',3,1,1),
	(19,'Circle','',3,1,1),
	(20,'Conic Sections','',3,1,1),
	(21,'Locus','',3,1,1),
	(22,'3-D Geometry','',3,1,1),
	(23,'Limit and Continuity','',4,1,1),
	(24,'Derivatives','',4,1,1),
	(25,'Rolle\'s and Lagrange\'s Theorem','',4,1,1),
	(26,'Indefinite and definite integrals','',4,1,1),
	(27,'Applications of integrations','',4,1,1),
	(28,'Ordinary Differential Equations','',4,1,1),
	(29,'Units and Dimensions','',5,1,1),
	(30,'Physical Experiments','',5,1,1),
	(31,'Optics Experiments','',5,1,1),
	(32,'Electricity experiments','',5,1,1),
	(33,'Heat Experiments','',5,1,1),
	(34,'Kinematics','',6,1,1),
	(35,'Newtons Laws','',6,1,1),
	(36,'Collisions','',6,1,1),
	(37,'Gravitation','',6,1,1),
	(38,'Momentum','',6,1,1),
	(39,'Bulk Matter','',6,1,1),
	(40,'Fluid dynamics','',6,1,1),
	(41,'Wave motion','',6,1,1),
	(42,'Thermal Physics','',6,1,1),
	(43,'Perfect Gas and Kinetic Theory','',6,1,1),
	(44,'Electrostatics','',7,1,1),
	(45,'Capacitance','',7,1,1),
	(46,'Electric Current','',7,1,1),
	(47,'Magnetic effects of current and magnetism','',7,1,1),
	(48,'Electromagnetic Induction','',7,1,1),
	(49,'Electromagnetic Waves','',7,1,1),
	(50,'Reflection and Refraction','',8,1,1),
	(51,'Lenses','',8,1,1),
	(52,'Prisms','',8,1,1),
	(53,'Intereference','',8,1,1),
	(54,'Atoms and Nuclei','',9,1,1),
	(55,'Radioactive Decay','',9,1,1),
	(56,'Dual Nature of Matter and Radiation (incl PE effec','',9,1,1),
	(57,'Waves','',9,1,1),
	(58,'Mole Concept','',10,1,1),
	(59,'Electro Chemistry','',10,1,1),
	(60,'States of Matter','',10,1,1),
	(61,'Thermodynamics','',10,1,1),
	(62,'Chemical Equilibrium','',10,1,1),
	(63,'Ionic Equilibrium','',10,1,1),
	(64,'Chemical Kinetics','',10,1,1),
	(65,'Solutions','',10,1,1),
	(66,'Surface Chemistry','',10,1,1),
	(67,'Nuclear Chemistry','',10,1,1),
	(68,'Stoichiometry','',10,1,1),
	(69,'Redox Reactions','',10,1,1),
	(70,'Solid State ','',10,1,1),
	(71,'Ores and Minerals','',11,1,1),
	(72,'Extractive Metallurgy','',11,1,1),
	(73,'Qualitative Analysis','',11,1,1),
	(74,'S-Block Elements','',11,1,1),
	(75,'P-Block Elements','',11,1,1),
	(76,'D and F Block Elements','',11,1,1),
	(77,'General Concepts','',12,1,1),
	(78,'Alkanes, Alkenes and Alkynes','',12,1,1),
	(79,'Isomerism','',12,1,1),
	(80,'Alcohols, Phenols and Ethers','',12,1,1),
	(81,'Aldehydes, Ketones and Acids','',12,1,1),
	(82,'Biomolecules','',12,1,1),
	(83,'Practical Organic Chemistry','',12,1,1),
	(84,'Aromatic Compounds','',12,1,1),
	(85,'Units and Dimensions','NULL',13,2,1),
	(86,'Physical Experiments','NULL',13,2,1),
	(87,'Optics Experiments','NULL',13,2,1),
	(88,'Electricity experiments','NULL',13,2,1),
	(89,'Heat Experiments','NULL',13,2,1),
	(90,'Kinematics','NULL',14,2,1),
	(91,'Newtons Laws','NULL',14,2,1),
	(92,'Collisions','NULL',14,2,1),
	(93,'Gravitation','NULL',14,2,1),
	(94,'Momentum','NULL',14,2,1),
	(95,'Bulk Matter','NULL',14,2,1),
	(96,'Fluid dynamics','NULL',14,2,1),
	(97,'Wave motion','NULL',14,2,1),
	(98,'Thermal Physics','NULL',14,2,1),
	(99,'Perfect Gas and Kinetic Theory','NULL',14,2,1),
	(100,'Electrostatics','NULL',15,2,1),
	(101,'Capacitance','NULL',15,2,1),
	(102,'Electric Current','NULL',15,2,1),
	(103,'Magnetic effects of current and magnetism','NULL',15,2,1),
	(104,'Electromagnetic induction','NULL',15,2,1),
	(105,'Electromagnetic waves','NULL',15,2,1),
	(106,'Reflection and refraction','NULL',16,2,1),
	(107,'Lenses','NULL',16,2,1),
	(108,'Prisms','NULL',16,2,1),
	(109,'Intereference','NULL',16,2,1),
	(110,'Atoms and Nuclei','NULL',17,2,1),
	(111,'Radioactive Decay','NULL',17,2,1),
	(112,'Dual Nature of Matter and Radiation (incl PE effec','NULL',17,2,1),
	(113,'Electronic Devices','NULL',17,2,1),
	(114,'Electro Chemistry','',18,2,1),
	(115,'States of matter','',18,2,1),
	(116,'Thermodynamics','',18,2,1),
	(117,'Chemical Equilibrium','',18,2,1),
	(118,'Chemical Kinetics','',18,2,1),
	(119,'Solutions','',18,2,1),
	(120,'Surface Chemistry','',18,2,1),
	(121,'Nuclear Chemistry','',18,2,1),
	(122,'Ores and Minerals','',19,2,1),
	(123,'Oxygen compunds','',19,2,1),
	(124,'Carbon compounds','',19,2,1),
	(125,'Chlorine Compounds','',19,2,1),
	(126,'Sulphur Compounds','',19,2,1),
	(127,'Transition Elements','',19,2,1),
	(128,'Extractive Metallurgy','',19,2,1),
	(129,'Qualitative Analysis','',19,2,1),
	(130,'S-block Elements','',19,2,1),
	(131,'P-Block Elements','',19,2,1),
	(132,'d and f block elements','',19,2,1),
	(133,'General Concepts','',20,2,1),
	(134,'Alkanes','',20,2,1),
	(135,'Alkenes and Alkynes','',20,2,1),
	(136,'Alcohols, Phenols and Ethers','',20,2,1),
	(137,'Aldehydes, Ketones and Acids','',20,2,1),
	(138,'Amino acids and peptides','',20,2,1),
	(139,'Practical Organic Chemistry','',20,2,1),
	(140,'Environmental chemistry','',21,2,1),
	(141,'Biomolecules','',21,2,1),
	(142,'Polymers','',21,2,1),
	(143,'Classification ','',22,2,1),
	(144,'Features and classification of plants','',22,2,1),
	(145,'Features and classification of animals','',22,2,1),
	(146,'Morphology and Anatomy (plants)','',23,2,1),
	(147,'Morphology and Anatomy (animals)','',23,2,1),
	(148,'Cell theory','',24,2,1),
	(149,'Chemical Constituents of living cells','',24,2,1),
	(150,'Cell division','',24,2,1),
	(151,'Transport in plants','',25,2,1),
	(152,'Mineral Nutrition','',25,2,1),
	(153,'Photosynthesis','',25,2,1),
	(154,'Respiration','',25,2,1),
	(155,'Plant growth and development','',25,2,1),
	(156,'Digestion and absorption','',26,2,1),
	(157,'Breathing and respiration','',26,2,1),
	(158,'Body fluids and circulation','',26,2,1),
	(159,'Excretory products','',26,2,1),
	(160,'Locomotion and movement','',26,2,1),
	(161,'Neural control and coordination','',26,2,1),
	(162,'Reproduction in organisms','',27,2,1),
	(163,'Sexual reproduction in plants','',27,2,1),
	(164,'Human reproduction','',27,2,1),
	(165,'Reproductive Health','',27,2,1),
	(166,'Heredity and Variation','',28,2,1),
	(167,'Inheritance','',28,2,1),
	(168,'Evolution','',28,2,1),
	(169,'Health and disease','',29,2,1),
	(170,'Improvement in food production','',29,2,1),
	(171,'Microbes in human welfare','',29,2,1),
	(172,'Genetic Engineering','',30,2,1),
	(173,'Applications of biotechnology','',30,2,1),
	(174,'Organisms and environment','',31,2,1),
	(175,'Ecosystem','',31,2,1),
	(176,'Biodiversity','',31,2,1),
	(177,'Environmental issues','',31,2,1);

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
	(0,0,'[\"2\",\"3\",\"1\"]',4,1),
	(0,0,NULL,5,1);

/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
