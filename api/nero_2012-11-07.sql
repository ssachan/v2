# Sequel Pro dump
# Version 1630
# http://code.google.com/p/sequel-pro
#
# Host: localhost (MySQL 5.5.9)
# Database: nero
# Generation Time: 2012-11-07 11:02:52 +0530
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account_fb
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_fb`;

CREATE TABLE `account_fb` (
  `accountId` int(11) NOT NULL,
  `facebookId` bigint(20) DEFAULT NULL,
  `linkedOn` datetime DEFAULT NULL,
  `bio` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `education` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstName` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastName` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `pictures` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `quotes` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `work` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`accountId`),
  CONSTRAINT `account_fb_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table account_google
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_google`;

CREATE TABLE `account_google` (
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
  KEY `accountId` (`accountId`),
  CONSTRAINT `account_google_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`,`username`,`password`,`firstName`,`lastName`,`email`,`roles`,`createdOn`,`verifiedOn`,`lastsignedinOn`,`deletedOn`,`suspendedOn`,`resetsentOn`,`pics`)
VALUES
	(1,'shikhar',NULL,'shikhar','sachan','shikhar.sachan@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,'raghav',NULL,'raghav','verma','email@mskd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ascores_l1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l1`;

CREATE TABLE `ascores_l1` (
  `accountId` int(11) DEFAULT NULL,
  `score` int(2) DEFAULT '0',
  `updatedOn` datetime DEFAULT NULL,
  `l1Id` int(11) DEFAULT NULL,
  `streamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ascores_l1` WRITE;
/*!40000 ALTER TABLE `ascores_l1` DISABLE KEYS */;
INSERT INTO `ascores_l1` (`accountId`,`score`,`updatedOn`,`l1Id`,`streamId`)
VALUES
	(1,2,NULL,1,1),
	(1,4,NULL,2,1),
	(1,3,NULL,3,1);

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
  `streamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ascores_l2` WRITE;
/*!40000 ALTER TABLE `ascores_l2` DISABLE KEYS */;
INSERT INTO `ascores_l2` (`accountId`,`score`,`updatedOn`,`l2Id`,`streamId`)
VALUES
	(1,2,'0000-00-00 00:00:00',1,1),
	(1,3,'0000-00-00 00:00:00',1,1),
	(1,8,'0000-00-00 00:00:00',1,1),
	(1,5,'0000-00-00 00:00:00',2,1);

/*!40000 ALTER TABLE `ascores_l2` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ascores_l3
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l3`;

CREATE TABLE `ascores_l3` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
  KEY `streamId` (`streamId`),
  CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`streamId`) REFERENCES `streams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` (`id`,`displayName`,`fullName`,`streamId`)
VALUES
	(1,NULL,NULL,NULL);

/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table faculty
# ------------------------------------------------------------

DROP TABLE IF EXISTS `faculty`;

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `specialization` varchar(30) DEFAULT NULL,
  `bio` text,
  `experience` text,
  `education` text,
  `streamIds` varchar(50) DEFAULT NULL,
  `quizIds` varchar(500) DEFAULT NULL,
  `studentsSubscribed` varchar(500) DEFAULT NULL,
  `rating` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` (`id`,`firstName`,`lastName`,`specialization`,`bio`,`experience`,`education`,`streamIds`,`quizIds`,`studentsSubscribed`,`rating`)
VALUES
	(1,'fac1','fac11',NULL,NULL,'FIIT JEE 2009-2010, Narayana 2009-2010',NULL,'1|:2','',NULL,NULL),
	(2,'fac2',NULL,NULL,NULL,NULL,NULL,'2|:1',NULL,NULL,NULL),
	(3,'fac3',NULL,NULL,NULL,NULL,NULL,'2|:1|:3',NULL,NULL,NULL),
	(4,'fac4','fac3',NULL,NULL,NULL,NULL,'2|:3|:4',NULL,NULL,NULL);

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
INSERT INTO `insight_type` (`id`,`type`)
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

LOCK TABLES `insights` WRITE;
/*!40000 ALTER TABLE `insights` DISABLE KEYS */;
INSERT INTO `insights` (`id`,`text`,`typeId`)
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
INSERT INTO `package_type` (`id`,`name`)
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
  `packages` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` (`id`,`packages`)
VALUES
	(NULL,NULL);

/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table para
# ------------------------------------------------------------

DROP TABLE IF EXISTS `para`;

CREATE TABLE `para` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(50) DEFAULT NULL,
  `questionIds` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'question ids separated by ||',
  `questionCount` int(2) DEFAULT NULL,
  `resourceIds` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `l3Id` int(11) DEFAULT NULL,
  `difficulty` int(1) DEFAULT NULL,
  `mobileFlag` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table question_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `question_tags`;

CREATE TABLE `question_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `question_tags` WRITE;
/*!40000 ALTER TABLE `question_tags` DISABLE KEYS */;
INSERT INTO `question_tags` (`id`,`name`)
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `question_type` WRITE;
/*!40000 ALTER TABLE `question_type` DISABLE KEYS */;
INSERT INTO `question_type` (`id`,`type`)
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
  `explanation` varchar(5000) CHARACTER SET ascii DEFAULT NULL COMMENT 'information on options separated by ''||''',
  `l3Id` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `tagIds` varchar(30) DEFAULT NULL,
  `difficulty` int(1) DEFAULT NULL,
  `paraId` int(11) DEFAULT NULL,
  `resourcesIds` text,
  `averageTimeCorrect` int(2) DEFAULT NULL,
  `averageTimeIncorrect` int(2) DEFAULT NULL,
  `averageTimeUnattempted` int(2) DEFAULT NULL,
  `allotedTime` timestamp NULL DEFAULT NULL,
  `correctScore` int(2) DEFAULT NULL,
  `incorrectScore` int(2) DEFAULT NULL,
  `optionScore` int(2) DEFAULT NULL,
  `unattemptedScore` int(2) DEFAULT NULL,
  `facultyId` int(11) DEFAULT NULL,
  `mobileFlag` int(1) DEFAULT '1',
  `availableFlag` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` (`id`,`text`,`options`,`correctAnswer`,`explanation`,`l3Id`,`typeId`,`tagIds`,`difficulty`,`paraId`,`resourcesIds`,`averageTimeCorrect`,`averageTimeIncorrect`,`averageTimeUnattempted`,`allotedTime`,`correctScore`,`incorrectScore`,`optionScore`,`unattemptedScore`,`facultyId`,`mobileFlag`,`availableFlag`)
VALUES
	(1,'Out of 6 people in a group, find the number of ways of selecting 4 people in the group','12|:24|:30|:10|:15','4','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',1,1,'1',1,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(2,'Using 8 different english alphabets and 4 different numbers, 5 digit codes are generated. The code contains 3 alphabets and 2 numbers. If in the given code all the characters are distinct, how many such codes can be generated ','40320|:53760|:336|:448|:2240','0','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',1,2,'1',2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(3,'In a foorball tournament each team plays alll the other teams twice, if there there were 90 matches, how many teams played in the tournament','sadada|:bsdfec|:cedece|:hdjjdks|:hdjjdks','2','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',1,3,'1',2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(4,'Letters from the word ANDROID are used to create all possible words using all letters in the given word. How many such words would start with D','1|:2|:2','2','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',1,4,'1',1,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(5,'Letters from the word ANDROID are used to create all possible words using all letters in the given word. How many such words would start with A and end in R','120|:240|:60|:480|:None of the above','1','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',1,NULL,'1',2,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(6,'A committee of 7 has to be formed from 5 ladies and 6 gentlemen. How many such committees can be formed which consist of atleast 4 ladies','110|:100|:120|:115|:105','2','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',1,NULL,'1',2,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(7,'Rajat answers questions at random from in a 12 question test in with each question having 4 options (and only 1 option correct). What is the probability that Rajat gets all questions wrong.','1/12|:1/6|:(1/4)^12|:3/4|:(3/4)^12','4','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',1,NULL,'1',2,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(8,'If 2 cards are drawn from a well shuffled pack of cards, what is the probability that both of them are aces','1/15|:1/221|:1/13|:1/17|:1/195','1','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',1,NULL,'2',1,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(9,'If 4 fair coins are tossed, what is the probability of getting 2 heads ? ','3/5|:1/2|:2/5|:3/8|:1/4','3','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',1,NULL,'2',1,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(10,'When two cards are drawn randomly from a pack of cards, what is the probability that both of them are either Aces or both of them are Red in color','(26C2 + 4C2 - 1) / 52C2|:28C2 / 52C2|:26C2 / 52C2|:(26C2 + 4C2) / 52C2|:	None of the above','4','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',1,NULL,'1',1,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(11,'If 2 fair coins are tossed together, what is the probability that both of them show the same face','1/2|:1/4|:3/8|:1/8|:None of the above','0','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',1,NULL,'2',1,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(12,'Ram has a box with 4 Red pens, 3 Blue pens and 3 Green pens. He draws two pens, one after the other. What is the probability that the second pen is Red. ','.33|:.40|:.60|:.44|:None of the above','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',1,NULL,'2',2,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(13,'Ram has a box with 4 Red pens, 3 Blue pens and 3 Green pens. He draws three pens, one after the other. What is the probability that the three pens are of the same color','2/9|:1/4|:1/8|:1/18|:None of the above','3','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',1,NULL,'2',2,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(14,'The average score of a class of 55 students came out to be 16 out of a maximum score of 25. If the teacher misread the scores 15, 17, 21 and 16 as 5, 1, 2, 6 what is the actual average of the class','51|:20|:24|:26|:None of the above','2','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',1,NULL,NULL,3,14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(15,'The average score of the class was calcuated by 2 different evaluators. The first evaluator came out with an average score of 17 she misread scores of 3 students - 4 as 14, 13 as 8 and 2 as 12. The second evaluator came out with an average score of 15 but also misread scores of 3 students - 18 as 13, 16 as 6 and 17 as 7. What is the number of students who gave the exam','18|:20|:12|:16|:Not enough information','1','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',1,NULL,NULL,3,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(16,'The arithmetic mean of multiples of 13 between the numbers 150 and 250 is','195|:221|:208|:214.5|:None of the above','2','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',1,NULL,NULL,3,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(17,'A man completes a 10 km journey in time T1 by walking 5 kms at speed V1 and the rest by driving a car at speed V2. What is his average speed:','Geometric Mean of V1 & V2|:T1(V1+V2)/ 10|:Harmonic Mean of V1 & V2	(V1 +V2)/2	|:None of the above','2','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',1,NULL,NULL,2,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(18,'Geeta bought 2 varities of pens, the first one costing Rs 13 and the other costing Rs 5 a piece. In total she spent Rs. 133, in how many different ways can she buy pens - ','1|:2|:4|:3|:None of the above','1','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',1,NULL,NULL,3,18,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(19,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. Western music theory is easier to comprehend and work with than Indian music theory\r2. The great western composer Wolfgang Amadeus Mozart had once said that neither a lofty degree of intelligence nor imagination nor both together go to the making of a genius\r3. The symposium on the use of music to treat depression will create more awareness on the beneficial effects of classical music\r4. The beauty of music cannot be seen or analyzed but has been experienced by each and every one of us','FJFJ|:JFJJ|:JIJJ|:JFJF|:IFJJ','1','The first statement is a Judgement, since it is an opinion and may vary from person to person\rThe second statement is a quote by a famous composer, something that can be verified - therefore Fact\rThe third statement is a judgement, since it is based on someones opinion of how things will shape up in the future\rThe fourth statement is a judgement since it is very subjective to the approval or disapproval of other people and cannot be verified',NULL,NULL,NULL,2,19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(20,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. The first feature film presented as a talkie was The Jazz Singer released in October 1927\r2. The film Lord of the Rings was dubbed in 57 other languages so as to cater to international audiences\r3. It is impossible to capture the spirit of a book in a movie adaptation\r4. The director Peter Jackson has admitted that his movie adaptation cannot match the greatness of the trilogy by JRR Tolkien','FIJF|:FJJF|:JIJF|:JIJI|:FJIF','0','The first statement is clearly a fact. The second is inferred from the fact that the movie was dubbed into 57 languages, making it an inference. The third statement is an opinion, hence a judgement. The fourth is a statement made by the movie\'s director and can thus be verified, making it a fact',NULL,NULL,NULL,2,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(21,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. Alexander III of Macedon was a king of Macedon, a state in northern ancienct Greece\r2. Alexander\'s legacy includes the cultural diffusion his conquests engendered\r3. His father Philip could have ruled the empire for another 20 years had he not been assasinated\r4. Alexander conquered 20 countries during his reign; one of the contributors of his success was the strong kingdom and experienced army that he inherited from his father','FIJF|:IFIJ|:FJJI|:FFJI|:FIJI','3','The first statement is clearly a fact as it is stated he was a king of ancient Greece. The second talks about his legacy of spreading culture which can again be verified. The third statement is an opinion, hence a judgement. The fourth is an inference as it talks about the possible reason why he was able to conquer 20 countries',NULL,NULL,NULL,3,21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(22,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. Mergers and acquisitions are the indication of a progressing economy\r2. The most critical challenge in a merger is the alignment of organization structure and values in the 2 companies\r3. The valuation of a company should be validated by management consulting firms\r4. To build buy-in, a company must earn the trust of the employees of the company being taken over','FJFJ|:FFJJ|:JJJJ|:JFJF|:FJJJ','2','All the statements are judgements since they are opinions being expressed and cannot be validated. Look for keywords like \"usually\", \"must\" and \"should\" and any statement that cannot in whole or part be verified',NULL,NULL,NULL,3,22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(23,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. Studies have shown that the more the number of moving parts in an industrial design, the more likely it is to require regular maintenance\r2. The growth output of the industrial sector was close to 8% last year. This can be attributed to strong fundamentals in manufacturing\r3. It is better to avoid machines that require regular maintenance\r4. The recent work by the R&D team of Maruti would lead to cheaper automobiles in the years to come','IIJI|:FFJJ|:FFJI|:IFJI|:FIJI','4','The first statement talks about the result of a study and can thus be classified as a fact. The second gives the possible reason for increase in growth output, making it an inference. The thirds statement is an opinion which can be challenged - therefore it is a judgement. The fourth is an inference as it explores the possibility of cheaper automobiles manufactured by Maruti based on their recent R&D work',NULL,NULL,NULL,4,23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(24,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. Policies can help in both subjective and objective decision making\r2. As seen from India\'s growth in the last 3 years, policy reforms are extremely important\r3. Policies frequently have side effects or unintended consequences\r4. India\'s economic policy reforms were started 15 years ago','JIJF|:FIJF|:JFJF|:JIFF|:FIIF','0','The first statement is a debatable opinion and hence a judgement. The second gives the possible reason for increase in growth output, making it an inference. The third statement is an opinion which can be challenged - therefore it is a judgement. The fourth is a fact as it states something that happened 15 years ago and can be verified',NULL,NULL,NULL,3,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(25,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. The BSE Sensex is composed of 30 of the largest and most actively traded stocks representative of various industrial sectors of the Indian economy\r2. The base value of the SENSEX is taken as 100 on April 1, 1979, and its base year as 1978-79\r3. The sensex is expected to fall with sharp rise in dollar value\r4.  The free float market capitalization method is the best method to calculate the index','JFJJ|:JIJJ|:FIJI|:FFJI|:FFJJ','4','The first 2 statements discuss facts about the BSE. The third and fourth are opinions and are thus classified as Judgements',NULL,NULL,NULL,1,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(26,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. A recent trend in supporting life imprisonment sentences over the death penalty is seen to have led to reduction in number of such offences \r2. A recent trend in death penalty sentences has been the reduction in the number of such offences\r3. Recent trends in death penalty sentences will not be allowed to carry on for long with such a vigilant populace\r4.  The death penalty is the deterrent that reduces the total number of such offences','FIJJ|:IFJJ|:IIFJ|:IIJJ|:JFJJ','1','The first statement uses the trend to infer the reduction in number of offences. The second statement is a fact as it talks about the observed historical trend itself. The third and fourth are opinions on the death penalty and its effects, both of which can be easily disputed',NULL,NULL,NULL,3,26,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(27,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. Seeing the history of solar systems similar to our own, we can estimate that our sun will only increase in intensity over the next few years\r2. The recent asteroid collisions with the moon might lead to disturbances in satellite transmissions\r3. The sun is a star\r4.  The expedition to Mars was successful','IFFJ|:FIFJ|:IIFJ|:IJFJ|:IJFI','2','The first two statements follow the structure: Fact..what is expected to happen based on fact - they are thus inferences. The third statement is clearly a fact while the fourth is an opinion; the success of the Mars expedition is subjective and cannot be verified',NULL,NULL,NULL,2,27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(28,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. More than 9 million combatants were killed\r2. World War I (WWI) was a global war centred in Europe that began on 28 July 1914 and lasted until 11 November 1918\r3. German industrial and economic power had grown greatly after unification and the foundation of the Empire in 1871\r4.  Events on the home fronts were as tumultuous as on the battle fronts','IFFJ|:FJJJ|:FFJJ|:FFFJ|:FIFF','3','The first three statements state facts. The last statement is somebody\'s opinion comparing the events on the home front and the battle front',NULL,NULL,NULL,2,28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(29,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. 54 percent of India\'s population defecates in the open according to the latest report by WHO and UNICEF\r2. The work performed in the field of sanitation by men such as Fuad Lokhandwala is likely to make a significant difference to the lives of thousands\r3. It is shameful that we cannot build clean toilets, but we have a nuclear weapon\r4.  The silence by the central government clearly shows that the political class is least bothered about the country','FIJI|:FFJI|:FFJF|:FIJJ|:FIII','0','Check the statement 4 - it is an inference because it uses a fact to make a logical deduction. Similarly, statement 2 is an inference because it uses a fact to infer something. Also, the third statement is an opinion, making it a judgement. The only option satisfying all these criteria is A',NULL,NULL,NULL,4,29,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(30,'Classify the following statements as one of the following:\r<u>Facts</u>, which deal with the pieces of information that one has heard, seen or read, and which are open to discovery or verification (indicated with an \"\"F\"\" in the answer option)\r<u>Inferences</u>, which are the conclusions drawn about the unknown, on the basis of the known (indicated with an \"\"I\"\" in the answer option)\r<u>Judgements</u>, which are the opinions that imply approval or disapproval of persons, objects, situations and occurencesin the past, the present or future(indicated with a \"\"J\"\" in the answer option)\r\r1. The ambience of the restaurant is spectacular\r2. The food is sourced from local organic farms\r3. If we look at the last few weeks\' turnover, the restaurant is all set to become a success\r4. In our country, 40 percent of urban families eat at restaurants every week','JJJF|:JFIF|:JFFJ|:JIFF|:FIFF','1','The first statement is an opinion; the statements 2 and 4 are facts while statement 3 infers the chances of the restaurant  based on past trends. Even if we consider the third statement, only the option B satisfies the criteria of the third statement being an inference',NULL,NULL,NULL,1,30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(31,'Two poles of height \'a\' and \'b\' units respectively are \'c\' units apart on a plane surface. The height \'h\' of the point of intersection of the lines joining the top of each pole to the foot of opposite poles is  - ','AM of the 2 poles|:GM of the 2 poles|:HM/2 of the 2 poles|: None of the above|:Cannot be determined','0',NULL,10,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(32,'There are 10 children standing in line with each having a certain number of candies. If the first child distributes the candies to the remaining nine such that he doubles their candies, he will be left with just one candy. If the tenth child takes away one candy from each of the remaining nine then he will have eight candies less than the number of candies that the first child initially had. What is the number of candies held  by 8th child if child 2 to 9 held the same number of candies','1|:2|:3|:4|:Cannot be determined','1',NULL,14,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(33,'Six years ago, the age of a person was two years more than five times the age of his son. Four years hence, his age will be two years less than three times the age of his son. After how many years from now will their combined age be 100 years.','24 years|:19 years|:14 years|:25 years|:Cannot be determined','2',NULL,14,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
	(34,'A fraction becomes half if the numerator is increased by 1 and the denominator by 3. It becomes 2/5 if the numerator is increased by 2 and the denominator by 7. Find the fraction:','1/2|:4/7|:1/5|:2/3|:None of the above','2',NULL,14,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1);

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
  `l3Ids` varchar(11) DEFAULT NULL,
  `l2Ids` varchar(11) DEFAULT NULL,
  `questionCount` int(3) DEFAULT NULL,
  `allotedTime` int(11) DEFAULT NULL,
  `examIds` varchar(100) DEFAULT NULL,
  `difficulty` int(1) DEFAULT NULL,
  `ratings` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `facultyId` int(11) DEFAULT NULL,
  `available` int(1) DEFAULT NULL,
  `mobileFlag` int(1) DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `totalAttempts` int(11) DEFAULT '0',
  `streamId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` (`id`,`questionIds`,`description`,`descriptionShort`,`conceptsTested`,`tags`,`l3Ids`,`l2Ids`,`questionCount`,`allotedTime`,`examIds`,`difficulty`,`ratings`,`typeId`,`facultyId`,`available`,`mobileFlag`,`addedOn`,`totalAttempts`,`streamId`)
VALUES
	(1,'1|:2|:3|:4|:5|:6|:7|:8|:31','ldec1','descshort','some random text','tricky','1',NULL,10,100,NULL,3,NULL,NULL,1,NULL,NULL,NULL,16,1),
	(2,'8|:9|:10|:11',NULL,NULL,NULL,NULL,'1',NULL,4,20,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,3,1),
	(3,'21|:22|:23|:24|:25|:26|:27|:28|:29|:30',NULL,NULL,NULL,NULL,'1',NULL,10,20,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,0,2),
	(4,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,1),
	(5,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,1),
	(6,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,0,1),
	(7,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,0,1),
	(8,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,0,1),
	(9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL);

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
INSERT INTO `quizzes_type` (`id`,`type`)
VALUES
	(1,'full'),
	(2,'sectional');

/*!40000 ALTER TABLE `quizzes_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table resources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resources`;

CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `results`;

CREATE TABLE `results` (
  `quizId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  `selectedAnswers` text,
  `score` text,
  `timePerQuestion` text NOT NULL,
  `timeTaken` text,
  `toggleData` text,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` (`quizId`,`accountId`,`selectedAnswers`,`score`,`timePerQuestion`,`timeTaken`,`toggleData`,`timestamp`)
VALUES
	(1,1,'[0,2,1,null,null,null,null,null,null]','[0,3]','[3,2,3,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 12:23:45'),
	(1,1,'[0,2,null,null,null,null,null,null,null]','[0,2]','[3,2,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 12:24:14'),
	(1,1,'[0,1,2,null,null,null,null,null,null]','[1,2]','[3,4,2,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 12:24:36'),
	(1,1,'[0,1,2,0,null,null,null,null,null]','[1,3]','[3,3,2,2,null,null,null,null,null]',NULL,NULL,'2012-11-06 12:32:22'),
	(1,1,'[0,2,null,1,3,null,null,null,null]','[0,4]','[3,2,1,2,2,null,null,null,null]',NULL,NULL,'2012-11-06 12:32:49'),
	(2,1,'[null,1,2,1]','[0,3]','[2,2,2,3]',NULL,NULL,'2012-11-06 12:43:58'),
	(2,1,'[\"1\",\"2\",null,null]','[1,1]','[3,3,null,null]',NULL,NULL,'2012-11-06 12:50:02'),
	(1,1,'[\"1\",\"3\",\"1\",null,null,null,null,null,null]','[0,3]','[4,1,2,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 12:53:34'),
	(2,1,'[\"1\",\"3\",\"1\",null]','[2,1]','[3,2,1,null]',NULL,NULL,'2012-11-06 12:54:11'),
	(1,1,'[\"2\",null,null,null,null,null,null,null,null]','[0,1]','[3,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 12:57:11'),
	(1,1,'[\"1\",null,null,null,null,null,null,null,null]','[0,1]','[2,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 13:04:25'),
	(1,1,'[\"1\",null,null,null,null,null,null,null,null]','[0,1]','[3,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 13:31:30'),
	(1,1,'[\"2\",\"1\",null,null,null,null,null,null,null]','[0,2]','[3,2,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 13:32:07'),
	(1,1,'[\"1\",null,null,null,null,null,null,null,null]','[0,1]','[3,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 13:32:48'),
	(2,1,'[\"1\",\"3\",null,null]','[2,0]','[4,2,1,null]',NULL,NULL,'2012-11-06 13:33:40'),
	(2,1,'[\"1\",\"3\",null,null]','[2,0]','[4,2,null,null]',NULL,NULL,'2012-11-06 13:34:44'),
	(1,1,'[\"1\",\"2\",\"1\",null,null,null,null,null,null]','[0,3]','[3,2,2,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 13:36:24'),
	(1,1,'[\"1\",\"2\",\"1\",null,null,null,null,null,null]','[0,3]','[4,2,2,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:08:49'),
	(1,1,'[\"1\",\"3\",\"1\",null,null,null,null,null,null]','[0,3]','[3,3,2,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:10:42'),
	(1,1,'[null,null,null,null,null,null,null,null,null]','[0,0]','[3,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:13:31'),
	(1,1,'[\"1\",\"3\",\"1\",null,null,null,null,null,null]','[0,3]','[3,3,3,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:20:23'),
	(1,1,'[\"1\",\"2\",\"3\",null,null,null,null,null,null]','[0,3]','[3,3,2,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:23:55'),
	(1,1,'[\"2\",\"1\",null,null,null,null,null,null,null]','[0,2]','[3,3,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:24:51'),
	(1,1,'[\"1\",\"3\",null,null,null,null,null,null,null]','[0,2]','[3,2,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:25:58'),
	(1,1,'[\"1\",\"3\",null,null,null,null,null,null,null]','[0,2]','[4,2,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:27:34'),
	(1,1,'[\"2\",null,null,null,null,null,null,null,null]','[0,1]','[3,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-06 14:31:04'),
	(1,1,'[\"1\",\"2\",\"3\",\"1\",null,null,null,null,null]','[0,4]','[6,5,2,2,12,null,null,null,null]',NULL,NULL,'2012-11-06 19:13:12');

/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`,`name`)
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `section_l1` WRITE;
/*!40000 ALTER TABLE `section_l1` DISABLE KEYS */;
INSERT INTO `section_l1` (`id`,`displayName`,`longName`,`streamId`)
VALUES
	(1,'QA','Quantitative Ability','1'),
	(2,'DI','Data Interpretation','1'),
	(3,'VA','Verbal Ability','1'),
	(4,'LR','Logical Reasoning','1');

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
  PRIMARY KEY (`id`),
  KEY `l1Id` (`l1Id`),
  CONSTRAINT `section_l2_ibfk_1` FOREIGN KEY (`l1Id`) REFERENCES `section_l1` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

LOCK TABLES `section_l2` WRITE;
/*!40000 ALTER TABLE `section_l2` DISABLE KEYS */;
INSERT INTO `section_l2` (`id`,`displayName`,`longName`,`l1Id`,`streamId`)
VALUES
	(1,'Number System',NULL,1,1),
	(2,'Ratios',NULL,1,1),
	(3,'Measurements',NULL,1,1),
	(4,'Geometry',NULL,1,1),
	(5,'Equations',NULL,1,1),
	(6,'Permutations & Combinations',NULL,1,1),
	(7,'Percentages',NULL,1,1),
	(8,'Data Interpretation',NULL,2,1),
	(9,'Data Sufficiency',NULL,2,1),
	(10,'Reading Comprehension',NULL,3,1),
	(11,'Vocabulary Based',NULL,3,1),
	(12,'Verbal Reasoning',NULL,3,1),
	(13,'Sentence Correction',NULL,3,1),
	(14,'Jumbled paragraphs',NULL,3,1),
	(15,'Deductions',NULL,4,1),
	(16,'Distribution',NULL,4,1),
	(17,'Venn Diagrams',NULL,4,1),
	(18,'Quant Based',NULL,4,1),
	(19,'Logical Connectors',NULL,4,1);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

LOCK TABLES `section_l3` WRITE;
/*!40000 ALTER TABLE `section_l3` DISABLE KEYS */;
INSERT INTO `section_l3` (`id`,`displayName`,`longName`,`l2Id`,`streamId`)
VALUES
	(1,'Statistics',NULL,1,1),
	(2,'Number Base',NULL,1,1),
	(3,'Progressions',NULL,1,1),
	(4,'Logarithms',NULL,1,1),
	(5,'Ratio & Proportion',NULL,2,1),
	(6,'Mixture & Solutions',NULL,2,1),
	(7,'Time-Speed-Distance',NULL,3,1),
	(8,'Work-Time-Partnerships',NULL,3,1),
	(9,'Pipes & Cistern',NULL,3,1),
	(10,'2D Geometry',NULL,4,1),
	(11,'Trigonometry',NULL,4,1),
	(12,'Coordinate Geometry',NULL,4,1),
	(13,'Mensuration',NULL,4,1),
	(14,'Linear Equations',NULL,5,1),
	(15,'Quadratic and Polynomial Equal',NULL,5,1),
	(16,'Inequalities & Modulus',NULL,5,1),
	(17,'Operator Based Questions',NULL,5,1),
	(18,'Set Theory, Venn Diagrams',NULL,6,1),
	(19,'Permutation & Combination',NULL,6,1),
	(20,'Probability',NULL,6,1),
	(21,'Simple and Compound Interest',NULL,7,1),
	(22,'Installment Payments',NULL,7,1),
	(23,'Percentages',NULL,7,1),
	(24,'Profit & Loss',NULL,7,1),
	(25,'Data Tables',NULL,8,1),
	(26,'Bar Charts',NULL,8,1),
	(27,'Pie Charts',NULL,8,1),
	(28,'Pert Charts',NULL,8,1),
	(29,'Line-Area Graphs',NULL,8,1),
	(30,'Venn Diagrams',NULL,8,1),
	(31,'Network Diagram',NULL,8,1),
	(32,'Quant Based',NULL,9,1),
	(33,'Reasoning Based',NULL,9,1),
	(34,'Main Idea Questions',NULL,10,1),
	(35,'Specific Idea Questions or Dir',NULL,10,1),
	(36,'Implied Idea Questions',NULL,10,1),
	(37,'Logical Structure Questions',NULL,10,1),
	(38,'Tone or Attitude Questions',NULL,10,1),
	(39,'Continued Idea Questions',NULL,10,1),
	(40,'Synonyms and Word Meanings',NULL,11,1),
	(41,'Antonyms',NULL,11,1),
	(42,'Word Usage in Sentence',NULL,11,1),
	(43,'Analogies',NULL,11,1),
	(44,'Logical complement of an idea ',NULL,12,1),
	(45,'Fact-Inference-Judgement',NULL,12,1),
	(46,'Summary of a paragraph',NULL,12,1),
	(47,'Jumbled Sentence',NULL,NULL,1),
	(48,'Jumbled Paragraph',NULL,NULL,1),
	(49,'Jumbled Paragraph with fixed sentences',NULL,NULL,1),
	(50,'Deductions - independent sentences with linkages',NULL,15,1),
	(51,'Binary Logic - Statements with 2 way logic',NULL,15,1),
	(52,'Logical Connectives - if, then statement ',NULL,15,1),
	(53,'Sequencing - ordering in single line or in a circl',NULL,16,1),
	(54,'Distribution - placing along a 2d space',NULL,16,1),
	(55,'Selection - Small group or individuals are selecte',NULL,17,1),
	(56,'Venn Diagrams',NULL,17,1),
	(57,'Geometry Based Reasoning',NULL,18,1),
	(58,'Quant Based Reasoning',NULL,18,1),
	(59,'Order & Sequence - gives comparison between object',NULL,19,1),
	(60,'Routes & Networks - connection between multiple no',NULL,19,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `streams` WRITE;
/*!40000 ALTER TABLE `streams` DISABLE KEYS */;
INSERT INTO `streams` (`id`,`displayName`,`topFacultyIds`,`basicInfo`,`quizIds`,`sampleQuizIds`)
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
  KEY `accountId` (`accountId`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` (`ascoreL1`,`ascoreL2`,`quizzesAttempted`,`accountId`,`streamId`)
VALUES
	(1,0,NULL,1,1);

/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
