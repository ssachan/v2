# Sequel Pro dump
# Version 1630
# http://code.google.com/p/sequel-pro
#
# Host: localhost (MySQL 5.5.9)
# Database: nero
# Generation Time: 2012-11-09 16:39:51 +0530
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
  `l1Ids` text,
  `l2Ids` text,
  `specialization` varchar(30) DEFAULT NULL,
  `bio` text,
  `experience` text,
  `education` text,
  `streamIds` varchar(50) DEFAULT NULL,
  `totalQuizzes` int(5) DEFAULT '0',
  `rec` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` (`id`,`firstName`,`lastName`,`l1Ids`,`l2Ids`,`specialization`,`bio`,`experience`,`education`,`streamIds`,`totalQuizzes`,`rec`)
VALUES
	(1,'Raghav','Verma','1','1','Tips','One debate that has commanded the attention of ethicists in the modern era has been between consequentialism','FIIT JEE 2009-2010','IIT','1|:2',2,0),
	(2,'Tanuj','Bhojwani','1','2','Exam Strategy',' Jeremy Bentham and John Stuart Mill are famous for propagating utilitarianism, which is the idea that the fundamental moral rule is to strive toward the \"greatest happiness for the greatest number\"','Narayana 2009-2010','IIT','2|:1',9,2),
	(3,'Shobhit','Bhatnagar','1','1|:2','Exam Strategy',' However, in promoting this idea they also necessarily promoted the broader doctrine of consequentialism','FIIT JEE 2009-2010','IIM','1',7,1),
	(4,'Shikhar','Sachan','1','2|:3','Exam Strategy',' Adopting a position opposed to consequentialism, Immanuel Kant argued that moral principles were simply products of reason','Narayana 2009-2010','IIT','1',1,1);

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
  `difficulty` int(1) DEFAULT '0',
  `paraId` int(11) DEFAULT NULL,
  `resourcesIds` text,
  `averageTimeCorrect` int(2) DEFAULT '0',
  `averageTimeIncorrect` int(2) DEFAULT '0',
  `averageTimeUnattempted` int(2) DEFAULT '0',
  `averageCorrect` int(11) DEFAULT '0',
  `averageIncorrect` int(11) DEFAULT '0',
  `averageUnattempted` int(11) DEFAULT '0',
  `allotedTime` int(3) DEFAULT '0',
  `correctScore` int(2) DEFAULT '1',
  `incorrectScore` int(2) DEFAULT '0',
  `optionScore` int(2) DEFAULT '0',
  `unattemptedScore` int(2) DEFAULT '0',
  `mobileFlag` int(1) DEFAULT '0',
  `availableFlag` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` (`id`,`text`,`options`,`correctAnswer`,`explanation`,`l3Id`,`typeId`,`tagIds`,`difficulty`,`paraId`,`resourcesIds`,`averageTimeCorrect`,`averageTimeIncorrect`,`averageTimeUnattempted`,`averageCorrect`,`averageIncorrect`,`averageUnattempted`,`allotedTime`,`correctScore`,`incorrectScore`,`optionScore`,`unattemptedScore`,`mobileFlag`,`availableFlag`)
VALUES
	(1,'Out of 6 people in a group, find the number of ways of selecting 4 people in the group','12|:24|:30|:15','3','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',6,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(2,'Using 8 different english alphabets and 4 different numbers, 5 digit codes are generated. The code contains 3 alphabets and 2 numbers. If in the given code all the characters are distinct, how many such codes can be generated ','40320|:53760|:336|:448|:2240','0','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',3,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(3,'In a foorball tournament each team plays alll the other teams twice, if there there were 90 matches, how many teams played in the tournament','sadada|:bsdfec|:cedece|:hdjjdks|:hdjjdks','2','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',22,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(4,'Letters from the word ANDROID are used to create all possible words using all letters in the given word. How many such words would start with D','1|:2|:2','2','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',15,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(5,'Letters from the word ANDROID are used to create all possible words using all letters in the given word. How many such words would start with A and end in R','120|:240|:60|:480|:None of the above','1','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',24,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(6,'A committee of 7 has to be formed from 5 ladies and 6 gentlemen. How many such committees can be formed which consist of atleast 4 ladies','110|:100|:120|:115|:105','2','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',18,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(7,'Rajat answers questions at random from in a 12 question test in with each question having 4 options (and only 1 option correct). What is the probability that Rajat gets all questions wrong.','1/12|:1/6|:(1/4)^12|:3/4|:(3/4)^12','2','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',5,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(8,'If 2 cards are drawn from a well shuffled pack of cards, what is the probability that both of them are aces','1/15|:1/221|:1/13|:1/17|:1/195','1','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',17,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(9,'If 4 fair coins are tossed, what is the probability of getting 2 heads ? ','3/5|:1/2|:2/5|:3/8|:1/4','3','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',17,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(10,'When two cards are drawn randomly from a pack of cards, what is the probability that both of them are either Aces or both of them are Red in color','(26C2 + 4C2 - 1) / 52C2|:28C2 / 52C2|:26C2 / 52C2|:(26C2 + 4C2) / 52C2|:	None of the above','3','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',2,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(11,'If 2 fair coins are tossed together, what is the probability that both of them show the same face','1/2|:1/4|:3/8|:1/8|:None of the above','0','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',16,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(12,'Ram has a box with 4 Red pens, 3 Blue pens and 3 Green pens. He draws two pens, one after the other. What is the probability that the second pen is Red. ','.33|:.40|:.60|:.44|:None of the above','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',22,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(13,'Ram has a box with 4 Red pens, 3 Blue pens and 3 Green pens. He draws three pens, one after the other. What is the probability that the three pens are of the same color','2/9|:1/4|:1/8|:1/18|:None of the above','3','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',3,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(14,'The average score of a class of 55 students came out to be 16 out of a maximum score of 25. If the teacher misread the scores 15, 17, 21 and 16 as 5, 1, 2, 6 what is the actual average of the class','51|:20|:24|:26|:None of the above','2','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',17,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(15,'The average score of the class was calcuated by 2 different evaluators. The first evaluator came out with an average score of 17 she misread scores of 3 students - 4 as 14, 13 as 8 and 2 as 12. The second evaluator came out with an average score of 15 but also misread scores of 3 students - 18 as 13, 16 as 6 and 17 as 7. What is the number of students who gave the exam','18|:20|:12|:16|:Not enough information','1','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',19,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(16,'The arithmetic mean of multiples of 13 between the numbers 150 and 250 is','195|:221|:208|:214.5|:None of the above','2','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',12,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(17,'A man completes a 10 km journey in time T1 by walking 5 kms at speed V1 and the rest by driving a car at speed V2. What is his average speed:','Geometric Mean of V1 & V2|:T1(V1+V2)/ 10|:Harmonic Mean of V1 & V2	(V1 +V2)/2	|:None of the above','2','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',11,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(18,'Geeta bought 2 varities of pens, the first one costing Rs 13 and the other costing Rs 5 a piece. In total she spent Rs. 133, in how many different ways can she buy pens - ','1|:2|:4|:3|:None of the above','1','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',11,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(19,'The service carries a premium: as of mid-1992, several hundred Washington political insiders paid up to $4500 to read about daily White House activities.','Rationalism is |: the |: emphasis |: on','3',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',13,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(20,'Few things are less important than NBA losses in October—more than half of the league makes the playoffs, including, occasionally, teams with losing records—yet the 0-2 start by the Los Angeles Lakers has been cause for concern','the |: emphasis |: on |: reasoning','0',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',18,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(21,' “I’m not a very happy camper around here right now,” Kobe Bryant said after last night’s loss to the Portland Trailblazers, who are expected to compete to not be the worst team in the league','emphasis |: on |: reasoning |: as','2',' The mailings continued, and the Mattachines? veiled taunt of the most feared man in Washington went unanswered',11,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(22,' The Lakers, meanwhile, have been constructed to be the best: this season they added Dwight Howard, the league’s top center, and Steve Nash, who has been one of its première point guards','on |: reasoning |: as |: a','0',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',14,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(23,' The Lakers represented another iteration—perhaps the ultimate example—of the NBA’s new economic reality','reasoning |: as |: a |: source','0',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',18,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(24,' The super team first came to Miami, when LeBron James and Chris Bosh joined Dwyane Wade, then to New York, where Carmelo Anthony, Amare Stoudemire, and Tyson Chandler have not worked out quite so well','as |: a |: source |: of','3',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',8,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(25,' The idea is: Why build from within when you can buy from without? This wasn’t supposed to happen','a |: source |: of |: knowledge. Empiricism is','2',' The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',19,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(26,' In 2011, the N','source |: of |: knowledge. Empiricism is |: the','2','? But leaders of the left did not rush to embrace the latest insurgent minority',11,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(27,' suffered through protracted labor negotiations with a number of stated goals, one of which was to restore competitive balance to a league that had had only eight different champions in twenty-eight seasons','of |: knowledge. Empiricism is |: the |: emphasis','0',' Betty Friedan viewed lesbians as a ?lavender menace?; Tom Hayden made homosexuals feel unwelcome in Students for a Democratic Society',14,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(28,' (In the past thirteen years, nine different teams won','knowledge. Empiricism is |: the |: emphasis |: on','2',' Hirshman argues that gay groups were actually fortunate in their isolation',8,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(29,') Whether this was an actual goal or one promoted simply to make the owners’ grab for more money less obvious is debatable','the |: emphasis |: on |: observational','0',' ?The more inclusive [a movement] becomes of other identities,? she writes, ?the weaker it gets',8,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(30,' But at least some efforts were made in that direction: revenue sharing between big- and small-market teams increased, and luxury-tax penalties went up for teams that exceed the league salary cap','emphasis |: on |: observational |: evidence','1','? Avoiding, to some extent, the groupthink and the infighting that can plague minority coalitions, the gay-rights movement kept barrelling single-mindedly ahead and, in an astonishingly short period of time, moved from social oblivion to the moral high ground',24,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(31,' Within a few years, we were promised, Milwaukee and Sacramento would be making deep playoff runs','on |: observational |: evidence |: via','1',' The most important consequence of Stonewall was the gay-pride parade that marked the first anniversary of the uprising',6,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(32,' Instead, Miami is again the overwhelming favorite to reach this year’s finals, where they are expected to meet the Lakers','observational |: evidence |: via |: sensory','1',' Amid the sexual carnival of the seventies, gay life started to look fun rather than fearful',10,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(33,' What was not accounted for in the labor negotiations was the fact that some teams will still pay whatever it takes to win: the Lakers’ spending spree will cost them around thirty million in luxury tax this season, which they don’t seem too concerned about','evidence |: via |: sensory |: experience','2',' Politics followed suit',23,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(34,' (According toForbes, Los Angeles is the most valuable team in the league','via |: sensory |: experience |: over','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',15,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(35,') Whether or not they will maintain this stance is another question: like Obamacare, the league’s collective bargaining agreement is ramping up in stages, and by 2015 the Lakers could be paying more than a hundred million in luxury tax alone','sensory |: experience |: over |: other','1','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',18,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(36,' But for now, the cost seems of little concern','experience |: over |: other |: evidence','2','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',14,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(37,' This season, the antidote to Miami and L','over |: other |: evidence |: as','0','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',19,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(38,' was supposed to be the Oklahoma City Thunder','other |: evidence |: as |: the','2','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',5,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(39,' They had built a core of four players—Russell Westbrook, Kevin Durant, Serge Ibaka, and James Harden—by drafting and training all of them','evidence |: as |: the |: source','1','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',11,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(40,' Trades and free-agent signings filled in the surrounding pieces, but they were otherwise homegrown','as |: the |: source |: of','0','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',4,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(41,' Last year, the Thunder met the Heat in the finals, and they were expected to compete with the Lakers for that spot again','the |: source |: of |: knowledge.','1','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',11,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(42,' Then, on Saturday, they traded Harden to Houston','source |: of |: knowledge. |: Rationalism','1','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',12,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(43,' The new league rules, which were supposed to make it easier for a team in Oklahoma to field a roster that could compete with teams in bigger markets, had backfired: Harden wanted the maximum allowable contract, but Oklahoma City’s owners were unwilling to pay the luxury tax','of |: knowledge. |: Rationalism |: claims','1','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',6,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(44,' Meanwhile, Houston—the fourth-largest market in the league—was happy to oblige','knowledge. |: Rationalism |: claims |: that','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',16,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(45,' This leaves the Lakers, even at 0-2, the overwhelming favorites in the West','Rationalism |: claims |: that |: every','3','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',22,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(46,' And a finals between the Lakers and Heat would admittedly be high on entertainment value, both for the outsized personalities involved and because it would be an on-court battle between the old and new styles of play','claims |: that |: every |: possible','0','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',22,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(47,' The Lakers have been constructed with traditional basketball strategy in mind','that |: every |: possible |: object','1','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',16,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(48,' Each player is perfectly suited to his position, and no other: they have a slick passing point guard (Nash), a scoring-machine at the two (Bryant), a bruising small forward (Metta World Peace), an agile and skilled power forward (Pau Gasol), and a dominant center (Howard)','every |: possible |: object |: of','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',6,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(49,' The Heat, meanwhile, are preparing to play a new brand of basketball largely free of traditional positions','possible |: object |: of |: knowledge','0','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',28,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(50,' In practice, they have had players occupy each position in the team’s offensive sets, so that they can be prepared to play anywhere on the court','object |: of |: knowledge |: can','0','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',15,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(51,' This works because the Heat are led by James and Wade, who are skilled and athletic enough to play many different positions','of |: knowledge |: can |: be','1','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',27,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(52,' James is especially hard to confine to one role: he might be most effective rebounding down low on the defensive end, sprinting down court like a point guard, and finishing at the rim like a small forward, all in one play','knowledge |: can |: be |: deduced','0','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',8,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(53,' Placing traditional confines on him simply stops him from doing all that he is capable of','can |: be |: deduced |: from','1',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',4,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(54,' Still, despite their different styles of play, the two teams are essentially the same: creations of the N','be |: deduced |: from |: coherent','3',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',20,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(55,'’s new economic paradigm','deduced |: from |: coherent |: premises','0',' The mailings continued, and the Mattachines? veiled taunt of the most feared man in Washington went unanswered',18,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(56,' Either way, good luck, Milwaukee','from |: coherent |: premises |: without','2',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',19,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(57,'The week after Barack Obama was elected President, I attended a music festival at Arizona State University, in Tempe','coherent |: premises |: without |: observation.','1',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',2,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(58,' Because Veterans Day was the following Tuesday, it was a party weekend at the school, and thousands of students swarmed the main strip','premises |: without |: observation. |: Empiricism','2',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',1,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(59,' The central event of the festival ran long, and around midnight I went with another participant, the writer and filmmaker Paul Festa, in search of somewhere to eat','without |: observation. |: Empiricism |: claims','2',' The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',7,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(60,' The only place we could find was a Jack in the Box','observation. |: Empiricism |: claims |: that','2','? But leaders of the left did not rush to embrace the latest insurgent minority',4,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(61,' We gave our orders at the drive-through window','Empiricism |: claims |: that |: at','1',' Betty Friedan viewed lesbians as a ?lavender menace?; Tom Hayden made homosexuals feel unwelcome in Students for a Democratic Society',14,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(62,' A car was idling there, with several college students inside','claims |: that |: at |: least','2',' Hirshman argues that gay groups were actually fortunate in their isolation',16,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(63,' Moments later, a second car roared the wrong way up the drive-through lane and screeched to a halt','that |: at |: least |: some','0',' ?The more inclusive [a movement] becomes of other identities,? she writes, ?the weaker it gets',14,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(64,' A visibly drunk young man, tall and blond, wearing a standard collegiate uniform of T-shirt over long-sleeved T and jeans, lurched out, shouting, “Some whore called me a faggot!” The cashier handed Paul a strawberry milkshake','at |: least |: some |: knowledge','3','? Avoiding, to some extent, the groupthink and the infighting that can plague minority coalitions, the gay-rights movement kept barrelling single-mindedly ahead and, in an astonishingly short period of time, moved from social oblivion to the moral high ground',21,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(65,' Paul and I are both gay; we traded uneasy glances while the guy carried on','least |: some |: knowledge |: is','1',' The most important consequence of Stonewall was the gay-pride parade that marked the first anniversary of the uprising',5,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(66,' “My parents raised me right,” the blond guy hollered at the students in the second car, who turned out to be his friends','some |: knowledge |: is |: only','2',' Amid the sexual carnival of the seventies, gay life started to look fun rather than fearful',22,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(67,' “And I’m proud of who I am','knowledge |: is |: only |: a','3',' Politics followed suit',26,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(68,'” Paul and I looked at each other again, now in amazement','is |: only |: a |: matter','1','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',23,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(69,' A beefy, sour-faced guy wearing a backward baseball cap came around the corner','only |: a |: matter |: of','1','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',6,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(70,' This, evidently, was the person who had called the blond a faggot','a |: matter |: of |: observation.','2','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',4,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(71,' “I’m going to beat you up,” the newcomer shouted','matter |: of |: observation. |: For','3','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',3,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(72,' A friend was trailing behind him','of |: observation. |: For |: this,','3','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',28,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(73,' Like most gay men, I have been called a faggot a few times','observation. |: For |: this, |: Empiricism','0','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',6,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(74,' I’ve seen friends talk back to homophobes','For |: this, |: Empiricism |: often','0','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',1,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(75,' But I’d never witnessed anything like this: it had a weird theatrical intensity, as if the young man were being goaded by an offstage director','this, |: Empiricism |: often |: cites','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',24,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(76,' “How dare you?” he yelled','Empiricism |: often |: cites |: the','2','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',4,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(77,' “Our forefathers came to this country to escape from their religions and be free','often |: cites |: the |: concept','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',4,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(78,' How dare you, asshole! Don’t you know this is the land of equal opportunity? Go back to fucking Connecticut with your two cars and a garage!” The beefy guy wilted in the face of this semi-coherent invective','cites |: the |: concept |: of tabula','0','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',6,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(79,' He shrugged at his friend, and they started to walk off','the |: concept |: of tabula |: rasa,','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',4,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(80,' The blond guy stumbled after them for a minute or two, bellowing, “In this country, I can marry ANYONE I WANT! Because there’s CHANGE in this country now!” Even after his opponents had disappeared, he continued ranting, his face lit with euphoric rage','concept |: of tabula |: rasa, |: where','0','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',7,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(81,' He had become a little scary, this one-man Stonewall riot','of tabula |: rasa, |: where |: individuals','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',18,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(82,' Eventually, his friends calmed him down, and they left','rasa, |: where |: individuals |: are','1','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',18,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(83,'I am forty-four years old, and I have lived through a startling transformation in the status of gay men and women in the United States','where |: individuals |: are |: not','1','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',27,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(84,' Around the time I was born, homosexual acts were illegal in every state but Illinois','individuals |: are |: not |: born','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',3,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(85,' Lesbians and gays were barred from serving in the federal government','are |: not |: born |: with mental','1','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',16,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(86,' There were no openly gay politicians','not |: born |: with mental |: content and','2',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',7,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(87,' A few closeted homosexuals occupied positions of power, but they tended to make things more miserable for their kind','born |: with mental |: content and |: that','3',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',26,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(88,' Even in the liberal press, homosexuality drew scorn: in The New York Review of Books, Philip Roth denounced the “ghastly pansy rhetoric” of Edward Albee, and a Time cover story dismissed the gay world as a “pathetic little second-rate substitute for reality, a pitiable flight from life','with mental |: content and |: that |: knowledge','3',' The mailings continued, and the Mattachines? veiled taunt of the most feared man in Washington went unanswered',10,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(89,'” David Reuben’s 1969 best-seller, “Everything You Always Wanted to Know About Sex (But Were Afraid to Ask)”—a book I remember perusing shakily at the library—advised that “if a homosexual who wants to renounce homosexuality finds a psychiatrist who knows how to cure homosexuality, he has every chance of becoming a happy, well-adjusted heterosexual','content and |: that |: knowledge |: builds','0',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',5,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(90,'” By the mid-eighties, when I was beginning to ome to terms with my sexuality, a few gay people held political office, many states had dropped long-standing laws criminalizing sodomy, and sundry celebrities had come out','that |: knowledge |: builds |: from','3',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',25,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(91,' (The tennis champion Martina Navratilova did so, memorably, in 1981','knowledge |: builds |: from |: experience','1',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',4,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(92,'But anti-gay crusades on the religious right threatened to roll back this progress','builds |: from |: experience |: or','2',' The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',12,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(93,' In 1986, the Supreme Court, upholding Georgia’s sodomy law, dismissed the notion of constitutional protection for gay sexuality as “at best, facetious','from |: experience |: or |: perception. Epistemological','1','? But leaders of the left did not rush to embrace the latest insurgent minority',26,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(94,'” AIDS was killing thousands of gay men each year','experience |: or |: perception. Epistemological |: solipsism is','2',' Betty Friedan viewed lesbians as a ?lavender menace?; Tom Hayden made homosexuals feel unwelcome in Students for a Democratic Society',11,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(95,' The initial response of the Reagan Administration—and of the mainstream media—is well summarized by a Larry Speakes press briefing in October, 1982: Q: Larry, does the President have any reaction to the announcement [from] the Centers for Disease Control in Atlanta that AIDS is now an epidemic and have over 600 cases','or |: perception. Epistemological |: solipsism is |: the','2',' Hirshman argues that gay groups were actually fortunate in their isolation',1,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(96,' SPEAKES: What’s AIDS','perception. Epistemological |: solipsism is |: the |: idea','2',' ?The more inclusive [a movement] becomes of other identities,? she writes, ?the weaker it gets',8,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(97,' Over a third of them have died','solipsism is |: the |: idea |: that','2','? Avoiding, to some extent, the groupthink and the infighting that can plague minority coalitions, the gay-rights movement kept barrelling single-mindedly ahead and, in an astonishingly short period of time, moved from social oblivion to the moral high ground',26,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(98,' It’s known as “gay plague” No, it is','the |: idea |: that |: the','0',' The most important consequence of Stonewall was the gay-pride parade that marked the first anniversary of the uprising',13,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(99,' I mean it’s a pretty serious thing that one in every three people that get this have died','idea |: that |: the |: existence','1',' Amid the sexual carnival of the seventies, gay life started to look fun rather than fearful',25,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(100,' And I wondered if the President is aware of it','that |: the |: existence |: of','3',' Politics followed suit',26,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(101,' SPEAKES: I don’t have it, Do you','the |: existence |: of |: the','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',2,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(102,' By the time Reagan first spoke at length about AIDS, in May, 1987, the death toll in the U','existence |: of |: the |: world','3','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',26,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(103,' had surpassed twenty thousand','of |: the |: world |: outside','1','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',26,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(104,' What I remember most about my first sexual experience is the fear','the |: world |: outside |: the','1','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',25,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(105,' Today, gay people of a certain age may feel as though they had stepped out of a lavender time machine','world |: outside |: the |: mind','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',25,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(106,' That’s the sensation that hit me when I watched the young man in Tempe shout down a homophobe in the name of the President-elect','outside |: the |: mind |: is','1','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',11,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(107,' Gay marriage is legal in six states and in Washington, D','the |: mind |: is |: an','2','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',22,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(108,' Gays can serve in the military without hiding their sexuality','mind |: is |: an |: unresolvable','3','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',18,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(109,' We’ve seen openly gay judges, congresspeople, mayors (including a four-term mayor of Tempe), movie stars, and talk-show hosts','is |: an |: unresolvable |: question.','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',7,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(110,' Gay film and TV characters are almost annoyingly ubiquitous','Logic |: is |: the |: study','3','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',8,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(111,' The Supreme Court, which finally annulled sodomy laws in 2003, is set to begin examining the marriage issue','is |: the |: study |: of','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',25,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(112,' And the 2012 campaign has shown that Republicans no longer see the gays as a reliable wedge issue: although Mitt Romney opposes same-sex marriage, he has barely mentioned it this fall','the |: study |: of |: the','3','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',27,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(113,' If thirty-two people were to die today in a mass murder at a gay bar, both Obama and Romney would presumably express sympathy for the victims—more than any official in New Orleans did when, back in 1973, an arsonist set fire to the Upstairs Lounge','study |: of |: the |: principles','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',15,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(114,' Gay life in America is hardly carefree, especially outside certain Zip Codes in the big cities','of |: the |: principles |: of','0','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',4,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(115,' Although the religious right has a weaker grip on politics than it once did, it can still chill the air: in August, hundreds of thousands across the country lined up to buy chicken sandwiches in support of Chick-fil-A, whose nonprofit foundation has given millions of dollars to anti-gay groups','the |: principles |: of |: correct reasoning. Arguments use','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',11,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(116,' (Fast food: the final battleground','principles |: of |: correct reasoning. Arguments use |: either','0','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',17,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(117,') Still, gay rights have made such rapid progress that there is an urge to look back and assess what has happened','of |: correct reasoning. Arguments use |: either |: deductive','0','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',3,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(118,' Several new books offer different perspectives on the tectonic shifts of recent decades','correct reasoning. Arguments use |: either |: deductive |: reasoning','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',7,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(119,' Linda Hirshman, in “Victory: The Triumphant Gay Revolution,” delivers a vivid history of a movement that was invented, out of nothing, circa 1950','either |: deductive |: reasoning |: or','2','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',28,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(120,' David Halperin, a leading figure in queer-studies scholarship, sounds a more wistful tone in “How to Be Gay,” celebrating the sharp-elbowed camp culture that many now consider obsolete','deductive |: reasoning |: or |: inductive','0',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',21,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(121,' And Bishop Gene Robinson, in “God Believes in Love: Straight Talk About Gay Marriage,” imagines a future in which the prohibitions of Judeo-Christian scripture have receded','reasoning |: or |: inductive |: reasoning. Deductive','0',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',13,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(122,'One fashionable explanation for the turnabout credits popular culture: out-and-proud celebrities and gay-friendly sitcoms have made straight Americans more comfortable with their other-minded neighbors','or |: inductive |: reasoning. Deductive |: reasoning is','2',' The mailings continued, and the Mattachines? veiled taunt of the most feared man in Washington went unanswered',15,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(123,' When, in May, Vice-President Joe Biden declared his support for gay marriage, prompting Obama to do the same, he said, “Things really begin to change','inductive |: reasoning. Deductive |: reasoning is |: when,','2',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',15,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(124,' when the social culture changes','reasoning. Deductive |: reasoning is |: when, |: given','1',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',26,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(125,' I think ‘Will & Grace’ probably did more to educate the American public than almost anything anybody’s ever done so far','reasoning is |: when, |: given |: certain','1',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',21,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(126,'” Not that long ago, though, Hollywood was regularly portraying gays and lesbians as flouncing sissies, pathetic suicide cases, and serial killers; Vito Russo documented that practice in his 1981 book, “The Celluloid Closet','when, |: given |: certain |: statements','3',' The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',19,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(127,'” A decade later, I joined a demonstration, organized by the San Francisco chapter of Queer Nation, against the movie “Basic Instinct,” which was being filmed in the city, and whose plot featured homicidal lesbians','given |: certain |: statements |: (called premises),','2','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',25,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(128,' My activist career ended there, but the protest, and others like it, made headway','certain |: statements |: (called premises), |: other','0','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',25,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(129,' Belatedly, Hollywood stopped teaching America to fear homosexuality','statements |: (called premises), |: other |: statements','0','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',17,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(130,' The entertainment industry, far from leading the way, caught up with a new social reality','(called premises), |: other |: statements |: (called','2','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',1,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(131,'Three-dimensional people are more persuasive than two-dimensional ones, as Biden surely knows','other |: statements |: (called |: conclusions)','2','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',12,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(132,' In the end, the big change likely came about because, each year, a few thousand more gay people make the awkward announcement to their families and friends, supplanting images from the folklore of disgust','statements |: (called |: conclusions) |: are unavoidably','2','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',6,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(133,' My primary political moment happened when I wrote long, lugubrious letters to my closest friends, finally revealing the rest of me','(called |: conclusions) |: are unavoidably |: implied. Rules','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',3,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(134,' In one, I came out in a footnote on the seventh page, amid pompous but heartfelt quotations from Wallace Stevens: “The greatest poverty is not to live / In a physical world, to feel that one’s desire / Is too difficult to tell from despair','conclusions) |: are unavoidably |: implied. Rules |: of','2','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',23,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(135,'” Harvey Milk always said that this was how the revolution would happen: one lonely kid at a time','are unavoidably |: implied. Rules |: of |: inferences from','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',2,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(136,' Although the formerly unspeakable practices associated with homosexuality are older than recorded history, the notion of a distinct gay identity is a relatively recent invention','implied. Rules |: of |: inferences from |: premises','0','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',4,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(137,' Not until the nineteenth century did anyone have the idea of dividing humanity neatly into those who desire their own sex and those who desire the other','of |: inferences from |: premises |: include','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',25,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(138,' Before then, confusion reigned','inferences from |: premises |: include |: the','2','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',4,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(139,' Gay sex acts were forbidden almost everywhere, but punishment was inconsistent','premises |: include |: the |: most','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',1,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(140,' Between 1786 and 1873, there were only twenty prosecutions for sodomy in New York','include |: the |: most |: popular','0','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',22,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(141,' George Chauncey, in his classic 1994 book, “Gay New York,” evokes a loosey-goosey metropolis at the turn of the last century, in which single men from all classes of society could amuse themselves with fairies—flamboyant, often cross-dressing men, who played the passive role in sex—when girls weren’t readily available','the |: most |: popular |: method, modus','0','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',16,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(142,' Lesbian relationships could flourish under the cover of Boston marriages: socially acceptable alliances between unmarried women, so named for the charged friendship between Olive Chancellor and Verena Tarrant, in Henry James’s “The Bostonians','most |: popular |: method, modus |: ponens,','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',14,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(143,'” The American gay movement drew inspiration from Germany, where, in 1867, a renegade legal scholar named Karl Heinrich Ulrichs went before the Congress of German Jurists, in Munich, to plead for the repeal of sodomy laws','popular |: method, modus |: ponens, |: where','0','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',2,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(144,' He was shouted down, but by the end of the century Magnus Hirschfeld had established the first gay-rights organization, in Berlin','method, modus |: ponens, |: where |: given','2',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',9,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(145,' In Chicago, in 1924, a German immigrant named Henry Gerber, who had studied Hirschfeld’s organization, founded a Society for Human Rights','ponens, |: where |: given |: “A”','2',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',27,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(146,' It was quickly stymied by the police, with the press shuddering at the existence of a “strange sex cult','where |: given |: “A” |: and','1',' The mailings continued, and the Mattachines? veiled taunt of the most feared man in Washington went unanswered',28,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(147,'” Even so, gay subcultures were surreptitiously thriving in large cities','given |: “A” |: and |: “If','0',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',6,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(148,' At the end of the twenties, gay life became almost chic in New York, with curiosity-seekers attending drag balls, Mae West parading gay friends, and the cabaret star Jean Malin presiding over a “pansy craze” in midtown','“A” |: and |: “If |: A','2',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',20,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(149,' “I’d rather be Spanish than mannish,” Malin sang','and |: “If |: A |: then','2',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',26,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(150,' The first creaking open of the closet led to a colossal shove of repression','“If |: A |: then |: B”,','2',' The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',6,1,'3',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(151,' Chauncey’s book gives a queasy sense of a progressive society suddenly grinding in reverse: it seems as though the public-spiritedness of the Depression and the Second World War era required certain individuals to be expelled as scapegoats','A |: then |: B”, |: then','2','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',17,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(152,' New York passed laws against cross-dressing, onstage representations of homosexuals, and gatherings of gays in clubs','then |: B”, |: then |: “B”','1','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',8,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(153,' Police could close a bar if they heard men talking in high-pitched voices','B”, |: then |: “B” |: must','3','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',23,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(154,' In the thirties, the Motion Picture Production Code banned any hint of homosexuality','then |: “B” |: must |: be','3','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',1,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(155,' Leading psychiatrists, abandoning Freud’s relatively nonjudgmental position, described homosexuals as “sexual psychopaths','“B” |: must |: be |: concluded.','0','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',27,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(156,'” There were experiments in electric and pharmacological shock treatment, hormone injection, castration, and lobotomy','must |: be |: concluded. |: A','0','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',17,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(157,' One site of such remedies, Atascadero State Hospital, in California, later became known as “Dachau for queers','be |: concluded. |: A |: common','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',18,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(158,'” The hysteria reached its climax in the fifties, when politicians seized on the idea that lesbians and gays were a security risk','concluded. |: A |: common |: convention','0','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',5,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(159,' Senator Joseph McCarthy set off the witch-hunt when he noted the presence of homosexuals on his infamous list of Communists at the State Department','A |: common |: convention |: for','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',14,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(160,' In 1953, President Dwight Eisenhower signed Executive Order 10450, which banned, among other things, “sexual perversion” in government; the historian David Johnson estimates that some five thousand gay people lost their jobs as a result','common |: convention |: for |: a','2','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',9,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(161,' In an episode loosely dramatized in the novel and film “Advise and Consent,” Senator Lester Hunt, of Wyoming, killed himself after Styles Bridges, a senator from New Hampshire, threatened to expose Hunt’s son as a homosexual','convention |: for |: a |: deductive','0','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',21,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(162,' Bridges still has a highway named after him','for |: a |: deductive |: argument','3','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',18,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(163,' Despite the noxious atmosphere, a more forthright gay culture emerged','a |: deductive |: argument |: is','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',11,1,'2',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(164,' In fact, the inquisition may have only hastened the process','deductive |: argument |: is |: the syllogism.','3','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',3,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(165,' The question lobbed at prospective soldiers during the Second World War—“Are you homosexual?”—raised consciousness rather than suppressing it','argument |: is |: the syllogism. |: An','3','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',20,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(166,' (Wait, am I?) G','is |: the syllogism. |: An |: argument','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',1,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(167,'s who carried the stigma of the “blue discharge,” for homosexual behavior, had nothing to lose by living openly','the syllogism. |: An |: argument |: is','1','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',3,1,'2',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(168,' Lesbians were emboldened by the shakeup of gender roles in the era of Rosie the Riveter and Eleanor Roosevelt','An |: argument |: is |: termed valid if','3',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',23,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(169,' “I venture to predict that there will be a time in the future when gay folk will be accepted as part of regular society,” Edith Eyde wrote in the pioneering magazine Vice Versa, which she distributed via carbon copies','argument |: is |: termed valid if |: its','2',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',7,1,'1',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(170,' And a few literary figures came out: before Gore Vidal and Truman Capote, there was the poet Robert Duncan, who, in his 1944 essay “The Homosexual in Society,” asked liberals to “recognize homosexuals as equals','is |: termed valid if |: its |: conclusion','1','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',25,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(171,'” The first durable gay organization, the Mattachine Society, arose in 1951','termed valid if |: its |: conclusion |: does','2','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',15,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(172,' It was the brainchild of Harry Hay, a cross-dressing Southern Californian who went to high school with John Cage and taught music classes at the People’s Educational Center, in Los Angeles','its |: conclusion |: does |: indeed','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',17,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(173,' Hirshman, in “Victory,” delights in the fact that Hay took inspiration from the writings of the virulently homophobic Stalin, and in particular from Stalin’s definition of nationhood as a “community of language, territory, economic life, and psychological make-up manifested in a community of culture','conclusion |: does |: indeed |: follow','0','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',1,1,'3',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(174,'” Hay decided on these grounds that there should also be a gay nation; he took the name Mattachine from Renaissance bands of dancers dressed as fools','does |: indeed |: follow |: from','1','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',24,1,'1',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(175,' Hay’s radicalism soon caused internal discord, and the Mattachines moved in a less confrontational direction','indeed |: follow |: from |: its','3','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',8,1,'0',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(176,' In public appearances, they made a point of looking respectable, wearing coats and ties','follow |: from |: its |: premises,','3','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',2,1,'0',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(177,' Members of the Daughters of Bilitis, a like-minded lesbian organization, were urged to abandon mannish clothes','from |: its |: premises, |: whether','1','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',27,1,'3',2,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(178,' The way the gay-rights story is usually told, things got moving only in 1969, when a fed-up phalanx of bull dykes, drag queens, and street youths rioted at the Stonewall Inn, in the West Village','its |: premises, |: whether |: the','0','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',7,1,'1',3,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(179,' One advantage of Hirshman’s book—breezily written, but kinetic in its storytelling—is that it honors the activism of the pre-Stonewall era, when any public exposure required considerable courage','premises, |: whether |: the |: premises','1','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',7,1,'2',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1),
	(180,' Political and legal advances, such as a 1958 Supreme Court decision ruling that the gay magazine ONE was not obscene material, were modest but hard won','whether |: the |: premises |: are','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',25,1,'0',1,NULL,NULL,0,0,0,0,0,0,NULL,1,0,NULL,NULL,1,1);

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
  `rec` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `facultyId` int(11) DEFAULT NULL,
  `available` int(1) DEFAULT NULL,
  `mobileFlag` int(1) DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `totalAttempts` int(11) DEFAULT '0',
  `streamId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` (`id`,`questionIds`,`description`,`descriptionShort`,`conceptsTested`,`tags`,`l3Ids`,`l2Ids`,`questionCount`,`allotedTime`,`difficulty`,`rec`,`typeId`,`facultyId`,`available`,`mobileFlag`,`addedOn`,`totalAttempts`,`streamId`)
VALUES
	(1,'21|:22|:23|:24|:25|:26|:27|:28|:29|:30|:31|:22|:23|:24|:15|:16|:17|:18','Within metaphysics itself  metaphysics itself there  itself there are ','Within metaphysics itself ',NULL,NULL,NULL,'1',18,120,0,112,1,4,NULL,NULL,NULL,0,1),
	(2,'1|:2|:3|:4|:5|:6|:7|:8|:9|:10|:11|:12|:13|:14|:15|:16|:17|:18','metaphysics itself there  itself there are  there are a ','metaphysics itself there ',NULL,NULL,NULL,'2|:1',18,120,1,212,1,1,NULL,NULL,NULL,13,1),
	(3,'37|:38|:39|:40|:41|:42|:43|:44|:45|:46|:47|:48|:49|:50|:51|:52|:53|:54','itself there are  there are a  are a wide ','itself there are ',NULL,NULL,NULL,'1',18,120,1,220,1,4,NULL,NULL,NULL,0,2),
	(4,'55|:56|:57|:58|:59|:60|:61|:62|:63|:64|:65|:66|:67|:68|:69|:70|:71|:72','there are a  are a wide  a wide range ','there are a ',NULL,NULL,NULL,'2',18,240,0,211,1,1,NULL,NULL,NULL,0,1),
	(5,'73|:74|:75|:76|:77|:78|:79|:80|:81|:82|:83|:84|:85|:86|:87|:88|:89|:90','are a wide  a wide range  wide range of ','are a wide ',NULL,NULL,NULL,'3',18,120,2,1,1,4,NULL,NULL,NULL,0,1),
	(6,'91|:92|:93|:94|:95|:96|:97|:98|:99|:100|:101|:102|:103|:104|:105|:106|:107|:108','a wide range  wide range of  range of differing ','a wide range ',NULL,NULL,NULL,'3',18,120,2,1,1,4,NULL,NULL,NULL,0,1),
	(7,'109|:110|:111|:112|:113|:114|:115|:116|:117|:118|:119|:120|:121|:122|:123|:124|:125|:126','wide range of  range of differing  of differing philosophical ','wide range of ',NULL,NULL,NULL,'1',18,120,1,200,1,3,NULL,NULL,NULL,0,2),
	(8,'127|:128|:129|:130|:131|:132|:133|:134|:135|:136|:137|:138|:139|:140|:141|:142|:143|:144','range of differing  of differing philosophical  differing philosophical theories. ','range of differing ',NULL,NULL,NULL,'4',18,120,2,222334,1,3,NULL,NULL,NULL,0,1),
	(9,'145|:146|:147|:148|:149|:150|:151|:152|:153|:154|:155|:156|:157|:158|:159|:160|:161|:162','of differing philosophical  differing philosophical theories.  philosophical theories. Idealism, ','of differing philosophical ',NULL,NULL,NULL,'3',18,120,0,55400,1,2,NULL,NULL,NULL,0,1),
	(10,'163|:164|:165|:166|:167|:168|:169|:170|:171|:172|:173|:174|:175|:176|:177|:178|:179|:180','differing philosophical theories.  philosophical theories. Idealism,  theories. Idealism, for ','differing philosophical theories. ',NULL,NULL,NULL,'2',18,120,2,55,1,2,NULL,NULL,NULL,0,1);

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
	(2,1,'[\"3\",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]','[1,0,1,18]','[5,2,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-09 16:32:31'),
	(2,1,'[\"3\",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]','[1,0,1,18]','[5,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-09 16:34:11');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `section_l2` WRITE;
/*!40000 ALTER TABLE `section_l2` DISABLE KEYS */;
INSERT INTO `section_l2` (`id`,`displayName`,`longName`,`l1Id`,`streamId`)
VALUES
	(1,'Algebra','NULL',1,1),
	(2,'Trigonometry','NULL',1,1),
	(3,'Coordinate Geometry','NULL',1,1),
	(4,'Calculus','NULL',1,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

LOCK TABLES `section_l3` WRITE;
/*!40000 ALTER TABLE `section_l3` DISABLE KEYS */;
INSERT INTO `section_l3` (`id`,`displayName`,`longName`,`l2Id`,`streamId`)
VALUES
	(1,'Equations','NULL',1,1),
	(2,'Progressions','NULL',1,1),
	(3,'Logarithms','NULL',1,1),
	(4,'Permutations and Combinations','NULL',1,1),
	(5,'Binomial Theorem','NULL',1,1),
	(6,'Matrices','NULL',1,1),
	(7,'Probability','NULL',1,1),
	(8,'Trigonometric Equations','NULL',2,1),
	(9,'Sine Rule','NULL',2,1),
	(10,'Cosine Rule','NULL',2,1),
	(11,'Half angle formula','NULL',2,1),
	(12,'Inverse Trigonometric functions','NULL',2,1),
	(13,'Cartesian Coordinates','NULL',3,1),
	(14,'Lines','NULL',3,1),
	(15,'Triangles','NULL',3,1),
	(16,'Circle','NULL',3,1),
	(17,'Parabola','NULL',3,1),
	(18,'Ellipse','NULL',3,1),
	(19,'Hyperbola','NULL',3,1),
	(20,'Locus','NULL',3,1),
	(21,'3-D Geometry','NULL',3,1),
	(22,'Functions','NULL',4,1),
	(23,'Limit and continuity','NULL',4,1),
	(24,'Derivatives','NULL',4,1),
	(25,'Rolles and Lagranges Theorem','NULL',4,1),
	(26,'Indefinite and definite integrals','NULL',4,1),
	(27,'Applications of integrations','NULL',4,1),
	(28,'Ordinary Differential Equations','NULL',4,1);

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
