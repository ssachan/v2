# Sequel Pro dump
# Version 1630
# http://code.google.com/p/sequel-pro
#
# Host: localhost (MySQL 5.5.9)
# Database: nero
# Generation Time: 2012-11-27 15:02:47 +0530
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`,`username`,`password`,`firstName`,`lastName`,`email`,`roles`,`createdOn`,`verifiedOn`,`lastsignedinOn`,`deletedOn`,`suspendedOn`,`resetsentOn`,`pics`)
VALUES
	(1,NULL,'aa','aa','aa','aa',NULL,'2012-11-16 15:19:08',NULL,NULL,NULL,NULL,NULL,NULL),
	(2,NULL,'pass','fn','ln','email',NULL,'2012-11-16 15:44:30',NULL,NULL,NULL,NULL,NULL,NULL),
	(3,NULL,'lopl','lopl','lopl','lopl',NULL,'2012-11-16 15:59:26',NULL,NULL,NULL,NULL,NULL,NULL),
	(4,NULL,'test','test','test','test',NULL,'2012-11-25 22:16:04',NULL,NULL,NULL,NULL,NULL,NULL),
	(5,NULL,'lop','lop','lop','lop',NULL,'2012-11-25 22:16:49',NULL,NULL,NULL,NULL,NULL,NULL),
	(6,NULL,'place','place','place','place',NULL,'2012-11-25 22:31:38',NULL,NULL,NULL,NULL,NULL,NULL),
	(24,NULL,NULL,'Shikhar','Sachan','shikhar.sachan@gmail.com',NULL,'2012-11-25 23:49:16',NULL,NULL,NULL,NULL,NULL,NULL),
	(25,NULL,'tt','tt','tt','tt',NULL,'2012-11-26 10:18:04',NULL,NULL,NULL,NULL,NULL,NULL),
	(26,NULL,'ll','ll','ll','ll',NULL,'2012-11-26 10:19:14',NULL,NULL,NULL,NULL,NULL,NULL),
	(27,NULL,'a','a','a','test@t.com',NULL,'2012-11-26 10:57:29',NULL,NULL,NULL,NULL,NULL,NULL),
	(28,NULL,'aaaa','aaaa','aaaa','aa@a.com',NULL,'2012-11-26 11:09:57',NULL,NULL,NULL,NULL,NULL,NULL),
	(29,NULL,'','','','aa@g.com',NULL,'2012-11-27 06:47:37',NULL,NULL,NULL,NULL,NULL,NULL);

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
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `accounts_fb` WRITE;
/*!40000 ALTER TABLE `accounts_fb` DISABLE KEYS */;
INSERT INTO `accounts_fb` (`accountId`,`facebookId`,`linkedOn`,`bio`,`education`,`firstName`,`gender`,`lastName`,`link`,`locale`,`pictures`,`quotes`,`timezone`,`username`,`work`)
VALUES
	(24,675467514,NULL,'find my scribbling here - http://greypad.thinkpluto.com/','test','Shikhar','male','Sachan','https://www.facebook.com/shikhar.sachan','en_US',NULL,NULL,'5.5','shikhar.sachan',NULL);

/*!40000 ALTER TABLE `accounts_fb` ENABLE KEYS */;
UNLOCK TABLES;


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
  `streamId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ascores_l1` WRITE;
/*!40000 ALTER TABLE `ascores_l1` DISABLE KEYS */;
INSERT INTO `ascores_l1` (`accountId`,`score`,`updatedOn`,`l1Id`,`streamId`)
VALUES
	(1,4,'0000-00-00 00:00:00',1,1),
	(1,2,'0000-00-00 00:00:00',2,1);

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
	(1,1,'0000-00-00 00:00:00',1,1);

/*!40000 ALTER TABLE `ascores_l2` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ascores_l3
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ascores_l3`;

CREATE TABLE `ascores_l3` (
  `id` int(11) DEFAULT NULL
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
  `subscribers` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` (`id`,`firstName`,`lastName`,`l1Ids`,`l2Ids`,`specialization`,`bio`,`experience`,`education`,`streamIds`,`totalQuizzes`,`rec`,`subscribers`)
VALUES
	(1,'MS','Gusain','3',NULL,'Organic Chemistry','MS Gusain is a Chemical Engineering graduate of IIT Delhi. He passed out in  He did his Ph.D. from Oxford and came back to India to take coaching classes. His specialization is Chemistry with a focus on organic chemistry\n','FIITJEE: 10 years','IIT Delhi B.Tech 2001','1',3784,58,0),
	(2,'Sikta','Patnaik','3',NULL,'Physical Chemistry','Sikta madam is a graduate of Delhi School of Economics. She has experience of many years teaching chemistry at the best institute in Kolkata and now runs her own coaching centre','FIITJEE: 2 years','Delhi School of Economics, MA 1998','1',7236,127,0),
	(3,'Bhim','Singh','3',NULL,'Inorganic Chemistry','Bhim Singh sir is a graduate of IIT Delhi, having done his Chemical Engineering from 1989-1993. He did his Ph.D. from Oxford and came back to India to teach engineering at NITs\nHe has experience of many years teaching physics at the most renowned institutes in Kota and Delhi\n','VMC: 5 years; Allen: 5 years','IIT Delhi B.Tech 1993','1',6349,122,0),
	(4,'Crack','IIT','1',NULL,'Mechanics, Algebra','Crack IIT is a major coaching institute in Jaipur - they have provided coaching to toppers in the last 5 years. The excellent faculty consists of ex-IITians','Ex-IIT Faculty','Ex-IIT Faculty','1',6258,88,0),
	(5,'Aditya','Saraswati','2',NULL,'Algebra, Probability','Aditya Saraswati is a Mechanical Engineering graduate from 2009.  His specialization is Maths and he is considered to be one of the best maths teachers in India. He has taught some of the toppers of the last few years','Brilliant Tutorials: 5 years','IIT Delhi B.Tech 2009','1',6603,126,0),
	(6,'Dipanjan','Dey','2',NULL,'Coordinate Geometry','Dipanjan Dey is the most famous teacher in West Bengal - his students have obtained the top ranks in IITJEE and WBJEE','Bansals: 3 years','IIT Kharagpur B.Tech 2005','1',2401,46,0),
	(7,'KN','Sharma','2',NULL,'Trigonometry','KN Sharma is a Computer Engineering graduate of IIT Delhi. He passed out in   His specialization is Maths and he is considered to be one of the best maths teachers in India. He has taught some of the toppers of the last few years','FIITJEE: 2 years','IIT Delhi B.Tech 1962','1',2904,99,0),
	(8,'Prashi','Aggarwal','1',NULL,'Mechanics','Prashi is a graduate of IIM Calcutta and is considered to be the best physics teacher in India for IIT Physics','Career Launcher','IIM Calcutta, MBA: 2002','1',4888,75,0),
	(9,'Raj','Gupta','1',NULL,'Electromagnetism','Raj Gupta Sir is a Mechanical Engineering graduate from 1989. He taught engineering at NITs. He has experience of many years teaching naths at the most renowned institutes in Bombay','Brilliant Tutorials: 15 years','IIT Madras, M.Tech, 1989','1',3365,138,0),
	(10,'T','Seetharaman','1',NULL,'Electromagnetism','T Seetharaman is an IIM Ahmedabad graduate, and has worked at some of the best consulting firms in India befoe starting his coaching classes practice','','IIM Ahmedabad, MBA: 2002','1',5802,69,0);

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
INSERT INTO `packages` (`id`,`name`,`details`,`poolId`,`price`,`streamId`)
VALUES
	(1,'Physics Test Series','5|:2',1,250,1);

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



# Dump of table pool
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pool`;

CREATE TABLE `pool` (
  `id` int(11) DEFAULT NULL,
  `quizIds` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pool` WRITE;
/*!40000 ALTER TABLE `pool` DISABLE KEYS */;
INSERT INTO `pool` (`id`,`quizIds`)
VALUES
	(1,'0'),
	(2,'1|:3|:5|:7|:9');

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
  `explanation` text COMMENT 'information on options separated by ''||''',
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
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8;

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` (`id`,`text`,`options`,`correctAnswer`,`explanation`,`l3Id`,`typeId`,`tagIds`,`difficulty`,`paraId`,`resourcesIds`,`averageTimeCorrect`,`averageTimeIncorrect`,`averageTimeUnattempted`,`averageCorrect`,`averageIncorrect`,`averageUnattempted`,`allotedTime`,`correctScore`,`incorrectScore`,`optionScore`,`unattemptedScore`,`mobileFlag`,`availableFlag`)
VALUES
	(1,'Out of 6 people in a group, find the number of ways of selecting 4 people in the group','12|:24|:30|:15','2','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',6,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(2,'Using 8 different english alphabets and 4 different numbers, 5 digit codes are generated. The code contains 3 alphabets and 2 numbers. If in the given code all the characters are distinct, how many such codes can be generated ','40320|:53760|:336|:448|:2240','1|:2|:4','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',3,2,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(3,'In a foorball tournament each team plays alll the other teams twice, if there there were 90 matches, how many teams played in the tournament','','2','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',22,3,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,1,0,0,1,1),
	(4,'Letters from the word ANDROID are used to create all possible words using all letters in the given word. How many such words would start with D','1|:2|:2|:|:23|:45|:66|:78|:80','1|:2|:3|:|:1|:2|:|:0','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',15,4,'1',1,NULL,NULL,0,0,0,0,0,0,0,4,0,1,0,1,1),
	(5,'Letters from the word ANDROID are used to create all possible words using all letters in the given word. How many such words would start with A and end in R','120|:240|:60|:480|:None of the above','1','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',24,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(6,'A committee of 7 has to be formed from 5 ladies and 6 gentlemen. How many such committees can be formed which consist of atleast 4 ladies','110|:100|:120|:115|:105','2','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',18,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(7,'Rajat answers questions at random from in a 12 question test in with each question having 4 options (and only 1 option correct). What is the probability that Rajat gets all questions wrong.','1/12|:1/6|:(1/4)^12|:3/4|:(3/4)^12','2','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',5,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(8,'If 2 cards are drawn from a well shuffled pack of cards, what is the probability that both of them are aces','1/15|:1/221|:1/13|:1/17|:1/195','1','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',17,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(9,'If 4 fair coins are tossed, what is the probability of getting 2 heads ? ','3/5|:1/2|:2/5|:3/8|:1/4','3','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',17,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(10,'When two cards are drawn randomly from a pack of cards, what is the probability that both of them are either Aces or both of them are Red in color','(26C2 + 4C2 - 1) / 52C2|:28C2 / 52C2|:26C2 / 52C2|:(26C2 + 4C2) / 52C2|:	None of the above','3','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',2,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(11,'If 2 fair coins are tossed together, what is the probability that both of them show the same face','1/2|:1/4|:3/8|:1/8|:None of the above','0','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',16,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(12,'Ram has a box with 4 Red pens, 3 Blue pens and 3 Green pens. He draws two pens, one after the other. What is the probability that the second pen is Red. ','.33|:.40|:.60|:.44|:None of the above','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',22,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(13,'Ram has a box with 4 Red pens, 3 Blue pens and 3 Green pens. He draws three pens, one after the other. What is the probability that the three pens are of the same color','2/9|:1/4|:1/8|:1/18|:None of the above','3','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',3,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(14,'The average score of a class of 55 students came out to be 16 out of a maximum score of 25. If the teacher misread the scores 15, 17, 21 and 16 as 5, 1, 2, 6 what is the actual average of the class','51|:20|:24|:26|:None of the above','2','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',17,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(15,'The average score of the class was calcuated by 2 different evaluators. The first evaluator came out with an average score of 17 she misread scores of 3 students - 4 as 14, 13 as 8 and 2 as 12. The second evaluator came out with an average score of 15 but also misread scores of 3 students - 18 as 13, 16 as 6 and 17 as 7. What is the number of students who gave the exam','18|:20|:12|:16|:Not enough information','1','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',19,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(16,'The arithmetic mean of multiples of 13 between the numbers 150 and 250 is','195|:221|:208|:214.5|:None of the above','2','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',12,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(17,'A man completes a 10 km journey in time T1 by walking 5 kms at speed V1 and the rest by driving a car at speed V2. What is his average speed:','Geometric Mean of V1 & V2|:T1(V1+V2)/ 10|:Harmonic Mean of V1 & V2	(V1 +V2)/2	|:None of the above','2','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',11,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(18,'Geeta bought 2 varities of pens, the first one costing Rs 13 and the other costing Rs 5 a piece. In total she spent Rs. 133, in how many different ways can she buy pens - ','1|:2|:4|:3|:None of the above','1','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',11,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(19,'The service carries a premium: as of mid-1992, several hundred Washington political insiders paid up to $4500 to read about daily White House activities.','Rationalismйis |: the |: emphasis |: on','3',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',13,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(20,'Few things are less important than NBA losses in Octoberяmore than half of the league makes the playoffs, including, occasionally, teams with losing recordsяyet the 0-2 start by the Los Angeles Lakers has been cause for concern','the |: emphasis |: on |: reasoning','0',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',18,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(21,' рI\\уm not a very happy camper around here right now,с Kobe Bryant said after last night\\уs loss to the Portland Trailblazers, who are expected to compete to not be the worst team in the league','emphasis |: on |: reasoning |: as','2',' The mailings continued, and the Mattachines\\? veiled taunt of the most feared man in Washington went unanswered',11,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(22,' The Lakers, meanwhile, have been constructed to be the best: this season they added Dwight Howard, the league\\уs top center, and Steve Nash, who has been one of its premi▐re point guards','on |: reasoning |: as |: a','0',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',14,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(23,'The Lakers represented another iterationяperhaps the ultimate exampleяof the NBA\\уs new economic reality','reasoning |: as |: a |: source','0',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',18,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(24,' The super team first came to Miami, when LeBron James and Chris Bosh joined Dwyane Wade, then to New York, where Carmelo Anthony, Amare Stoudemire, and Tyson Chandler have not worked out quite so well','as |: a |: source |: of','3',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',8,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(25,'The idea is: Why build from within when you can buy from without? This wasn\\уt supposed to happen','a |: source |: of |: knowledge.йEmpiricismйis','2','The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',19,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(26,' In 2011, the N','source |: of |: knowledge.йEmpiricismйis |: the','2','? But leaders of the left did not rush to embrace the latest insurgent minority',11,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(27,' suffered through protracted labor negotiations with a number of stated goals, one of which was to restore competitive balance to a league that had had only eight different champions in twenty-eight seasons','of |: knowledge.йEmpiricismйis |: the |: emphasis','0','Betty Friedan viewed lesbians as a ?lavender menace?; Tom Hayden made homosexuals feel unwelcome in Students for a Democratic Society',14,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(28,' (In the past thirteen years, nine different teams won','knowledge.йEmpiricismйis |: the |: emphasis |: on','2','Hirshman argues that gay groups were actually fortunate in their isolation',8,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(29,') Whether this was an actual goal or one promoted simply to make the owners\\у grab for more money less obvious is debatable','the |: emphasis |: on |: observational','0',' ?The more inclusive [a movement] becomes of other identities,? she writes, ?the weaker it gets',8,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(30,' But at least some efforts were made in that direction: revenue sharing between big- and small-market teams increased, and luxury-tax penalties went up for teams that exceed the league salary cap','emphasis |: on |: observational |: evidence','1','? Avoiding, to some extent, the groupthink and the infighting that can plague minority coalitions, the gay-rights movement kept barrelling single-mindedly ahead and, in an astonishingly short period of time, moved from social oblivion to the moral high ground',24,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(31,' Within a few years, we were promised, Milwaukee and Sacramento would be making deep playoff runs','on |: observational |: evidence |: via','1','The most important consequence of Stonewall was the gay-pride parade that marked the first anniversary of the uprising',6,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(32,' Instead, Miami is again the overwhelming favorite to reach this year\\уs finals, where they are expected to meet the Lakers','observational |: evidence |: via |: sensory','1',' Amid the sexual carnival of the seventies, gay life started to look fun rather than fearful',10,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(33,' What was not accounted for in the labor negotiations was the fact that some teams will still pay whatever it takes to win: the Lakers\\у spending spree will cost them around thirty million in luxury tax this season, which they don\\уt seem too concerned about','evidence |: via |: sensory |: experience','2','Politics followed suit',23,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(34,' (According toForbes, Los Angeles is the most valuable team in the league','via |: sensory |: experience |: over','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',15,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(35,') Whether or not they will maintain this stance is another question: like Obamacare, the league\\уs collective bargaining agreement is ramping up in stages, and by 2015 the Lakers could be paying more than a hundred million in luxury tax alone','sensory |: experience |: over |: other','1','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',18,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(36,' But for now, the cost seems of little concern','experience |: over |: other |: evidence','2','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',14,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(37,' This season, the antidote to Miami and L','over |: other |: evidence |: as','0','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',19,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(38,'was supposed to be the Oklahoma City Thunder','other |: evidence |: as |: the','2','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',5,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(39,' They had built a core of four playersяRussell Westbrook, Kevin Durant, Serge Ibaka, and James Hardenяby drafting and training all of them','evidence |: as |: the |: source','1','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',11,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(40,' Trades and free-agent signings filled in the surrounding pieces, but they were otherwise homegrown','as |: the |: source |: of','0','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',4,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(41,' Last year, the Thunder met the Heat in the finals, and they were expected to compete with the Lakers for that spot again','the |: source |: of |: knowledge.','1','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',11,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(42,' Then, on Saturday, they traded Harden to Houston','source |: of |: knowledge. |: Rationalism','1','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',12,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(43,' The new league rules, which were supposed to make it easier for a team in Oklahoma to field a roster that could compete with teams in bigger markets, had backfired: Harden wanted the maximum allowable contract, but Oklahoma City\\уs owners were unwilling to pay the luxury tax','of |: knowledge. |: Rationalism |: claims','1','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',6,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(44,' Meanwhile, Houstonяthe fourth-largest market in the leagueяwas happy to oblige','knowledge. |: Rationalism |: claims |: that','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',16,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(45,' This leaves the Lakers, even at 0-2, the overwhelming favorites in the West','Rationalism |: claims |: that |: every','3','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',22,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(46,' And a finals between the Lakers and Heat would admittedly be high on entertainment value, both for the outsized personalities involved and because it would be an on-court battle between the old and new styles of play','claims |: that |: every |: possible','0','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',22,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(47,'The Lakers have been constructed with traditional basketball strategy in mind','that |: every |: possible |: object','1','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',16,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(48,' Each player is perfectly suited to his position, and no other: they have a slick passing point guard (Nash), a scoring-machine at the two (Bryant), a bruising small forward (Metta World Peace), an agile and skilled power forward (Pau Gasol), and a dominant center (Howard)','every |: possible |: object |: of','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',6,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(49,' The Heat, meanwhile, are preparing to play a new brand of basketball largely free of traditional positions','possible |: object |: of |: knowledge','0','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',28,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(50,' In practice, they have had players occupy each position in the team\\уs offensive sets, so that they can be prepared to play anywhere on the court','object |: of |: knowledge |: can','0','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',15,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(51,' This works because the Heat are led by James and Wade, who are skilled and athletic enough to play many different positions','of |: knowledge |: can |: be','1','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',27,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(52,' James is especially hard to confine to one role: he might be most effective rebounding down low on the defensive end, sprinting down court like a point guard, and finishing at the rim like a small forward, all in one play','knowledge |: can |: be |: deduced','0','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',8,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(53,'Placing traditional confines on him simply stops him from doing all that he is capable of','can |: be |: deduced |: from','1',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',4,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(54,' Still, despite their different styles of play, the two teams are essentially the same: creations of the N','be |: deduced |: from |: coherent','3',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',20,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(55,'\\уs new economic paradigm','deduced |: from |: coherent |: premises','0',' The mailings continued, and the Mattachines\\? veiled taunt of the most feared man in Washington went unanswered',18,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(56,' Either way, good luck, Milwaukee','from |: coherent |: premises |: without','2',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',19,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(57,'The week after Barack Obama was elected President, I attended a music festival at Arizona State University, in Tempe','coherent |: premises |: without |: observation.','1',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',2,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(58,' Because Veterans Day was the following Tuesday, it was a party weekend at the school, and thousands of students swarmed the main strip','premises |: without |: observation. |: Empiricism','2',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',1,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(59,' The central event of the festival ran long, and around midnight I went with another participant, the writer and filmmaker Paul Festa, in search of somewhere to eat','without |: observation. |: Empiricism |: claims','2','The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',7,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(60,'The only place we could find was a Jack in the Box','observation. |: Empiricism |: claims |: that','2','? But leaders of the left did not rush to embrace the latest insurgent minority',4,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(61,'We gave our orders at the drive-through window','Empiricism |: claims |: that |: at','1','Betty Friedan viewed lesbians as a ?lavender menace?; Tom Hayden made homosexuals feel unwelcome in Students for a Democratic Society',14,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(62,' A car was idling there, with several college students inside','claims |: that |: at |: least','2','Hirshman argues that gay groups were actually fortunate in their isolation',16,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(63,' Moments later, a second car roared the wrong way up the drive-through lane and screeched to a halt','that |: at |: least |: some','0',' ?The more inclusive [a movement] becomes of other identities,? she writes, ?the weaker it gets',14,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(64,' A visibly drunk young man, tall and blond, wearing a standard collegiate uniform of T-shirt over long-sleeved T and jeans, lurched out, shouting, рSome whore called me a faggot!с The cashier handed Paul a strawberry milkshake','at |: least |: some |: knowledge','3','? Avoiding, to some extent, the groupthink and the infighting that can plague minority coalitions, the gay-rights movement kept barrelling single-mindedly ahead and, in an astonishingly short period of time, moved from social oblivion to the moral high ground',21,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(65,'Paul and I are both gay; we traded uneasy glances while the guy carried on','least |: some |: knowledge |: is','1','The most important consequence of Stonewall was the gay-pride parade that marked the first anniversary of the uprising',5,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(66,' рMy parents raised me right,с the blond guy hollered at the students in the second car, who turned out to be his friends','some |: knowledge |: is |: only','2',' Amid the sexual carnival of the seventies, gay life started to look fun rather than fearful',22,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(67,'рAnd I\\уm proud of who I am','knowledge |: is |: only |: a','3','Politics followed suit',26,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(68,'с Paul and I looked at each other again, now in amazement','is |: only |: a |: matter','1','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',23,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(69,' A beefy, sour-faced guy wearing a backward baseball cap came around the corner','only |: a |: matter |: of','1','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',6,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(70,' This, evidently, was the person who had called the blond a faggot','a |: matter |: of |: observation.','2','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',4,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(71,' рI\\уm going to beat you up,с the newcomer shouted','matter |: of |: observation. |: For','3','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',3,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(72,'A friend was trailing behind him','of |: observation. |: For |: this,','3','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',28,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(73,' Like most gay men, I have been called a faggot a few times','observation. |: For |: this, |: Empiricism','0','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',6,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(74,'I\\уve seen friends talk back to homophobes','For |: this, |: Empiricism |: often','0','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',1,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(75,' But I\\уd never witnessed anything like this: it had a weird theatrical intensity, as if the young man were being goaded by an offstage director','this, |: Empiricism |: often |: cites','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',24,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(76,'рHow dare you?с he yelled','Empiricism |: often |: cites |: the','2','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',4,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(77,'рOur forefathers came to this country to escape from their religions and be free','often |: cites |: the |: concept','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',4,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(78,' How dare you, asshole! Don\\уt you know this is the land of equal opportunity? Go back to fucking Connecticut with your two cars and a garage!с The beefy guy wilted in the face of this semi-coherent invective','cites |: the |: concept |: ofйtabula','0','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',6,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(79,' He shrugged at his friend, and they started to walk off','the |: concept |: ofйtabula |: rasa,','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',4,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(80,' The blond guy stumbled after them for a minute or two, bellowing, рIn this country, I can marry ANYONE I WANT! Because there\\уs CHANGE in this country now!с Even after his opponents had disappeared, he continued ranting, his face lit with euphoric rage','concept |: ofйtabula |: rasa, |: where','0','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',7,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(81,' He had become a little scary, this one-man Stonewall riot','ofйtabula |: rasa, |: where |: individuals','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',18,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(82,' Eventually, his friends calmed him down, and they left','rasa, |: where |: individuals |: are','1','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',18,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(83,'I am forty-four years old, and I have lived through a startling transformation in the status of gay men and women in the United States','where |: individuals |: are |: not','1','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',27,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(84,' Around the time I was born, homosexual acts were illegal in every state but Illinois','individuals |: are |: not |: born','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',3,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(85,'Lesbians and gays were barred from serving in the federal government','are |: not |: born |: withйmental','1','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',16,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(86,'There were no openly gay politicians','not |: born |: withйmental |: contentйand','2',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',7,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(87,' A few closeted homosexuals occupied positions of power, but they tended to make things more miserable for their kind','born |: withйmental |: contentйand |: that','3',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',26,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(88,' Even in the liberal press, homosexuality drew scorn: in The New York Review of Books, Philip Roth denounced the рghastly pansy rhetoricс of Edward Albee, and a Time cover story dismissed the gay world as a рpathetic little second-rate substitute for reality, a pitiable flight from life','withйmental |: contentйand |: that |: knowledge','3',' The mailings continued, and the Mattachines\\? veiled taunt of the most feared man in Washington went unanswered',10,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(89,'с David Reuben\\уs 1969 best-seller, рEverything You Always Wanted to Know About Sex (But Were Afraid to Ask)сяa book I remember perusing shakily at the libraryяadvised that рif a homosexual who wants to renounce homosexuality finds a psychiatrist who knows how to cure homosexuality, he has every chance of becoming a happy, well-adjusted heterosexual','contentйand |: that |: knowledge |: builds','0',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',5,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(90,'с By the mid-eighties, when I was beginning to ome to terms with my sexuality, a few gay people held political office, many states had dropped long-standing laws criminalizing sodomy, and sundry celebrities had come out','that |: knowledge |: builds |: from','3',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',25,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(91,' (The tennis champion Martina Navratilova did so, memorably, in 1981','knowledge |: builds |: from |: experience','1',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',4,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(92,') But anti-gay crusades on the religious right threatened to roll back this progress','builds |: from |: experience |: or','2','The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',12,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(93,' In 1986, the Supreme Court, upholding Georgia\\уs sodomy law, dismissed the notion of constitutional protection for gay sexuality as рat best, facetious','from |: experience |: or |: perception.йEpistemological','1','? But leaders of the left did not rush to embrace the latest insurgent minority',26,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(94,'с AIDS was killing thousands of gay men each year','experience |: or |: perception.йEpistemological |: solipsismйis','2','Betty Friedan viewed lesbians as a ?lavender menace?; Tom Hayden made homosexuals feel unwelcome in Students for a Democratic Society',11,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(95,' The initial response of the Reagan Administrationяand of the mainstream mediaяis well summarized by a Larry Speakes press briefing in October, 1982: Q: Larry, does the President have any reaction to the announcement [from] the Centers for Disease Control in Atlanta that AIDS is now an epidemic and have over 600 cases','or |: perception.йEpistemological |: solipsismйis |: the','2','Hirshman argues that gay groups were actually fortunate in their isolation',1,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(96,'SPEAKES: What\\уs AIDS','perception.йEpistemological |: solipsismйis |: the |: idea','2',' ?The more inclusive [a movement] becomes of other identities,? she writes, ?the weaker it gets',8,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(97,'Over a third of them have died','solipsismйis |: the |: idea |: that','2','? Avoiding, to some extent, the groupthink and the infighting that can plague minority coalitions, the gay-rights movement kept barrelling single-mindedly ahead and, in an astonishingly short period of time, moved from social oblivion to the moral high ground',26,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(98,' It\\уs known as рgay plagueс No, it is','the |: idea |: that |: the','0','The most important consequence of Stonewall was the gay-pride parade that marked the first anniversary of the uprising',13,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(99,'I mean it\\уs a pretty serious thing that one in every three people that get this have died','idea |: that |: the |: existence','1',' Amid the sexual carnival of the seventies, gay life started to look fun rather than fearful',25,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(100,'And I wondered if the President is aware of it','that |: the |: existence |: of','3','Politics followed suit',26,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(101,' SPEAKES: I don\\уt have it, Do you','the |: existence |: of |: the','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',2,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(102,' By the time Reagan first spoke at length about AIDS, in May, 1987, the death toll in the U','existence |: of |: the |: world','3','This is a simple application of Permutations. Selecting 4 out of 6 is equivalent to 6C4 which is <br> 6!/ (2! 4!) = 15',26,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(103,'had surpassed twenty thousand','of |: the |: world |: outside','1','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',26,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(104,'What I remember most about my first sexual experience is the fear','the |: world |: outside |: the','1','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',25,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(105,' Today, gay people of a certain age may feel as though they had stepped out of a lavender time machine','world |: outside |: the |: mind','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',25,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(106,'That\\уs the sensation that hit me when I watched the young man in Tempe shout down a homophobe in the name of the President-elect','outside |: the |: mind |: is','1','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',11,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(107,' Gay marriage is legal in six states and in Washington, D','the |: mind |: is |: an','2','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',22,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(108,'Gays can serve in the military without hiding their sexuality','mind |: is |: an |: unresolvable','3','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',18,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(109,' We\\уve seen openly gay judges, congresspeople, mayors (including a four-term mayor of Tempe), movie stars, and talk-show hosts','is |: an |: unresolvable |: question.','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',7,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(110,'Gay film and TV characters are almost annoyingly ubiquitous','Logic |: is |: the |: study','3','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',8,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(111,' The Supreme Court, which finally annulled sodomy laws in 2003, is set to begin examining the marriage issue','is |: the |: study |: of','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',25,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(112,' And the 2012 campaign has shown that Republicans no longer see the gays as a reliable wedge issue: although Mitt Romney opposes same-sex marriage, he has barely mentioned it this fall','the |: study |: of |: the','3','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',27,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(113,' If thirty-two people were to die today in a mass murder at a gay bar, both Obama and Romney would presumably express sympathy for the victimsяmore than any official in New Orleans did when, back in 1973, an arsonist set fire to the Upstairs Lounge','study |: of |: the |: principles','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',15,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(114,' Gay life in America is hardly carefree, especially outside certain Zip Codes in the big cities','of |: the |: principles |: of','0','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',4,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(115,' Although the religious right has a weaker grip on politics than it once did, it can still chill the air: in August, hundreds of thousands across the country lined up to buy chicken sandwiches in support of Chick-fil-A, whose nonprofit foundation has given millions of dollars to anti-gay groups','the |: principles |: of |: correctйreasoning.йArgumentsйuse','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',11,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(116,'(Fast food: the final battleground','principles |: of |: correctйreasoning.йArgumentsйuse |: either','0','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',17,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(117,') Still, gay rights have made such rapid progress that there is an urge to look back and assess what has happened','of |: correctйreasoning.йArgumentsйuse |: either |: deductive','0','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',3,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(118,'Several new books offer different perspectives on the tectonic shifts of recent decades','correctйreasoning.йArgumentsйuse |: either |: deductive |: reasoning','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',7,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(119,' Linda Hirshman, in рVictory: The Triumphant Gay Revolution,с delivers a vivid history of a movement that was invented, out of nothing, circa 1950','either |: deductive |: reasoning |: or','2','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',28,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(120,' David Halperin, a leading figure in queer-studies scholarship, sounds a more wistful tone in рHow to Be Gay,с celebrating the sharp-elbowed camp culture that many now consider obsolete','deductive |: reasoning |: or |: inductive','0',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',21,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(121,' And Bishop Gene Robinson, in рGod Believes in Love: Straight Talk About Gay Marriage,с imagines a future in which the prohibitions of Judeo-Christian scripture have receded','reasoning |: or |: inductive |: reasoning.йDeductive','0',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',13,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(122,'One fashionable explanation for the turnabout credits popular culture: out-and-proud celebrities and gay-friendly sitcoms have made straight Americans more comfortable with their other-minded neighbors','or |: inductive |: reasoning.йDeductive |: reasoningйis','2',' The mailings continued, and the Mattachines\\? veiled taunt of the most feared man in Washington went unanswered',15,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(123,' When, in May, Vice-President Joe Biden declared his support for gay marriage, prompting Obama to do the same, he said, рThings really begin to change','inductive |: reasoning.йDeductive |: reasoningйis |: when,','2',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',15,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(124,'when the social culture changes','reasoning.йDeductive |: reasoningйis |: when, |: given','1',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',26,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(125,'I think тWill & Grace\\у probably did more to educate the American public than almost anything anybody\\уs ever done so far','reasoningйis |: when, |: given |: certain','1',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',21,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(126,'с Not that long ago, though, Hollywood was regularly portraying gays and lesbians as flouncing sissies, pathetic suicide cases, and serial killers; Vito Russo documented that practice in his 1981 book, рThe Celluloid Closet','when, |: given |: certain |: statements','3','The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',19,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(127,'с A decade later, I joined a demonstration, organized by the San Francisco chapter of Queer Nation, against the movie рBasic Instinct,с which was being filmed in the city, and whose plot featured homicidal lesbians','given |: certain |: statements |: (calledйpremises),','2','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',25,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(128,' My activist career ended there, but the protest, and others like it, made headway','certain |: statements |: (calledйpremises), |: other','0','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',25,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(129,' Belatedly, Hollywood stopped teaching America to fear homosexuality','statements |: (calledйpremises), |: other |: statements','0','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',17,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(130,' The entertainment industry, far from leading the way, caught up with a new social reality','(calledйpremises), |: other |: statements |: (called','2','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',1,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(131,'Three-dimensional people are more persuasive than two-dimensional ones, as Biden surely knows','other |: statements |: (called |: conclusions)','2','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',12,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(132,' In the end, the big change likely came about because, each year, a few thousand more gay people make the awkward announcement to their families and friends, supplanting images from the folklore of disgust','statements |: (called |: conclusions) |: areйunavoidably','2','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',6,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(133,' My primary political moment happened when I wrote long, lugubrious letters to my closest friends, finally revealing the rest of me','(called |: conclusions) |: areйunavoidably |: implied.йRules','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',3,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(134,' In one, I came out in a footnote on the seventh page, amid pompous but heartfelt quotations from Wallace Stevens: рThe greatest poverty is not to live / In a physical world, to feel that one\\уs desire / Is too difficult to tell from despair','conclusions) |: areйunavoidably |: implied.йRules |: of','2','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',23,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(135,'с Harvey Milk always said that this was how the revolution would happen: one lonely kid at a time','areйunavoidably |: implied.йRules |: of |: inferencesйfrom','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',2,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(136,' Although the formerly unspeakable practices associated with homosexuality are older than recorded history, the notion of a distinct gay identity is a relatively recent invention','implied.йRules |: of |: inferencesйfrom |: premises','0','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',4,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(137,'Not until the nineteenth century did anyone have the idea of dividing humanity neatly into those who desire their own sex and those who desire the other','of |: inferencesйfrom |: premises |: include','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',25,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(138,' Before then, confusion reigned','inferencesйfrom |: premises |: include |: the','2','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',4,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(139,' Gay sex acts were forbidden almost everywhere, but punishment was inconsistent','premises |: include |: the |: most','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',1,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(140,' Between 1786 and 1873, there were only twenty prosecutions for sodomy in New York','include |: the |: most |: popular','0','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',22,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(141,' George Chauncey, in his classic 1994 book, рGay New York,с evokes a loosey-goosey metropolis at the turn of the last century, in which single men from all classes of society could amuse themselves with fairiesяflamboyant, often cross-dressing men, who played the passive role in sexяwhen girls weren\\уt readily available','the |: most |: popular |: method,йmodus','0','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',16,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(142,' Lesbian relationships could flourish under the cover of Boston marriages: socially acceptable alliances between unmarried women, so named for the charged friendship between Olive Chancellor and Verena Tarrant, in Henry James\\уs рThe Bostonians','most |: popular |: method,йmodus |: ponens,','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',14,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(143,'с The American gay movement drew inspiration from Germany, where, in 1867, a renegade legal scholar named Karl Heinrich Ulrichs went before the Congress of German Jurists, in Munich, to plead for the repeal of sodomy laws','popular |: method,йmodus |: ponens, |: where','0','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',2,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(144,' He was shouted down, but by the end of the century Magnus Hirschfeld had established the first gay-rights organization, in Berlin','method,йmodus |: ponens, |: where |: given','2',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',9,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(145,' In Chicago, in 1924, a German immigrant named Henry Gerber, who had studied Hirschfeld\\уs organization, founded a Society for Human Rights','ponens, |: where |: given |: рAс','2',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',27,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(146,' It was quickly stymied by the police, with the press shuddering at the existence of a рstrange sex cult','where |: given |: рAс |: and','1',' The mailings continued, and the Mattachines\\? veiled taunt of the most feared man in Washington went unanswered',28,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(147,'с Even so, gay subcultures were surreptitiously thriving in large cities','given |: рAс |: and |: рIf','0',' ?It is time to open the closet door and let in the fresh air and the sunshine,? Kameny said, in 1968',6,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(148,' At the end of the twenties, gay life became almost chic in New York, with curiosity-seekers attending drag balls, Mae West parading gay friends, and the cabaret star Jean Malin presiding over a рpansy crazeс in midtown','рAс |: and |: рIf |: A','2',' More than any other activist of his generation, he insisted that gay people had to declare themselves openly',20,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(149,' рI\\уd rather be Spanish than mannish,с Malin sang','and |: рIf |: A |: then','2',' He died last year, at the age of eighty-six; his home is now on the National Register of Historic Places',26,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(150,'The first creaking open of the closet led to a colossal shove of repression','рIf |: A |: then |: Bс,','2','The tumult of the sixties allowed the next generation of lesbians and gays to drop the fa?ade of politesse: ?black power? bred ?fag power? and ?dyke power',6,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(151,'Chauncey\\уs book gives a queasy sense of a progressive society suddenly grinding in reverse: it seems as though the public-spiritedness of the Depression and the Second World War era required certain individuals to be expelled as scapegoats','A |: then |: Bс, |: then','2','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',17,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(152,' New York passed laws against cross-dressing, onstage representations of homosexuals, and gatherings of gays in clubs','then |: Bс, |: then |: рBс','1','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',8,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(153,'Police could close a bar if they heard men talking in high-pitched voices','Bс, |: then |: рBс |: must','3','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',23,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(154,' In the thirties, the Motion Picture Production Code banned any hint of homosexuality','then |: рBс |: must |: be','3','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',1,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(155,' Leading psychiatrists, abandoning Freud\\уs relatively nonjudgmental position, described homosexuals as рsexual psychopaths','рBс |: must |: be |: concluded.','0','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',27,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(156,'с There were experiments in electric and pharmacological shock treatment, hormone injection, castration, and lobotomy','must |: be |: concluded. |: A','0','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',17,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(157,' One site of such remedies, Atascadero State Hospital, in California, later became known as рDachau for queers','be |: concluded. |: A |: common','2','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',18,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(158,'с The hysteria reached its climax in the fifties, when politicians seized on the idea that lesbians and gays were a security risk','concluded. |: A |: common |: convention','0','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',5,1,'3',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(159,'Senator Joseph McCarthy set off the witch-hunt when he noted the presence of homosexuals on his infamous list of Communists at the State Department','A |: common |: convention |: for','1','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',14,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(160,' In 1953, President Dwight Eisenhower signed Executive Order 10450, which banned, among other things, рsexual perversionс in government; the historian David Johnson estimates that some five thousand gay people lost their jobs as a result','common |: convention |: for |: a','2','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',9,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(161,' In an episode loosely dramatized in the novel and film рAdvise and Consent,с Senator Lester Hunt, of Wyoming, killed himself after Styles Bridges, a senator from New Hampshire, threatened to expose Hunt\\уs son as a homosexual','convention |: for |: a |: deductive','0','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',21,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(162,'Bridges still has a highway named after him','for |: a |: deductive |: argument','3','For all pens to be of Red color the probability is - 4/10 X 3/9 X 2/8 <br> For all pens to be of Blue color the probability is - 3/10 X 2/9 X 1/8 <br> For all pens to be of Green color the probability is - 3/10 X 2/9 X 1/8 <br> Summng the above 3, the probability is - 1/18',18,1,'3',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(163,' Despite the noxious atmosphere, a more forthright gay culture emerged','a |: deductive |: argument |: is','3','The difference between the actual score and the score calculated by the teacher is: <br> (15-5) + (17-1) + (21-2) + (16-6)',11,1,'2',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(164,' In fact, the inquisition may have only hastened the process','deductive |: argument |: is |: theйsyllogism.','3','The difference between average scores, as calculated by the 2 evaluators is 2. <br> The difference between the total scores for these evaluators will be - 2 X Total number of students. <br> For evaluator 1, the score calcuated is (14-4) + (8-13) + (12-2) = 15 off of the actual score, similarly for evaluator 2, the score calcuated is (13-18) + (6-16) + (7-17) = -25 off of the actual score <br> Hence the difference in the 2 scores is 15 - (-25) = 40 <br> Therefore total students = 40/2 = 20',3,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(165,'The question lobbed at prospective soldiers during the Second World WarярAre you homosexual?сяraised consciousness rather than suppressing it','argument |: is |: theйsyllogism. |: An','3','For calculating the AM, the smallest number in the series is - 156, and there are (250-150) / 13 = 7 terms (7 is the highest integer smaller than the term). Hence the AM will be - 156 + (7-1)/2 * 13 = 208',20,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(166,' (Wait, am I?) G','is |: theйsyllogism. |: An |: argument','3','The average can be calculated as follows: Total Distance / Total Time <br> = 10 / (5/V1 + 5/V2) <br> = 2/ (1/V1 + 1/V2) Which is also the Harmonic Mean of V1 & V2',1,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(167,'s who carried the stigma of the рblue discharge,с for homosexual behavior, had nothing to lose by living openly','theйsyllogism. |: An |: argument |: is','1','Let the no. of pens be x and y. Hence the total cost is 13x + 5y = 133 <br> since the term 5y will always end in either 5 or 0, the other term 13x can end only in 8 or 3 ( for the 2 to sum to 133). <br> Hence we need to look at multiples of 13 which are less than 133 and end in either 8 or 3. This leaves us with: 13 X 1= 13 and 13 X 6 = 78. These should be the only 2 solutions. Just to verify we plug back these numbers in the equation and get: 13 X 1 + 5 X 24 = 133 and 13 X 6 + 5 X 11 = 133',3,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(168,'Lesbians were emboldened by the shakeup of gender roles in the era of Rosie the Riveter and Eleanor Roosevelt','An |: argument |: is |: termedйvalidйif','3',' files reveal, an agent informed Kameny that Hoover wished to be removed from the mailing list',23,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(169,' рI venture to predict that there will be a time in the future when gay folk will be accepted as part of regular society,с Edith Eyde wrote in the pioneering magazine Vice Versa, which she distributed via carbon copies','argument |: is |: termedйvalidйif |: its','2',' Kameny replied that he would put the matter to his board, and his associate added that the director was welcome to attend the next Mattachine convention',7,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(170,' And a few literary figures came out: before Gore Vidal and Truman Capote, there was the poet Robert Duncan, who, in his 1944 essay рThe Homosexual in Society,с asked liberals to рrecognize homosexuals as equals','is |: termedйvalidйif |: its |: conclusion','1','We start by looking at all the coices that can be generated by selecting 3 unique alphabets out of 8 and selecting 2 numbers out of 4. Hence we have 8C3 X 4C2. Having selected the 5 digits now we need to arrange them in all possible manners to have 5! combinations. Hence we have a total to 8C3X4C2X5! combinations, which is 40320. ',25,1,'2',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(171,'с The first durable gay organization, the Mattachine Society, arose in 1951','termedйvalidйif |: its |: conclusion |: does','2','Since each team played two matches with all the opponent teams, the total matches played in the tournament should be nC2 X 2. <br> Hence nC2 = 45 => n(n-1)/2 = 45. Solving for n, we get n = 10',15,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(172,' It was the brainchild of Harry Hay, a cross-dressing Southern Californian who went to high school with John Cage and taught music classes at the People\\уs Educational Center, in Los Angeles','its |: conclusion |: does |: indeed','1','We fix letter D at the first position. Since no other word is repeating, we have the choice of arranging all 6 remaining alphabets in 6! Ways. Hence we have 720 such words',17,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(173,' Hirshman, in рVictory,с delights in the fact that Hay took inspiration from the writings of the virulently homophobic Stalin, and in particular from Stalin\\уs definition of nationhood as a рcommunity of language, territory, economic life, and psychological make-up manifested in a community of culture','conclusion |: does |: indeed |: follow','0','We fix letters A and R at the first and the last position. We have 5 positions to fill with 5 letters and hence 5! Combinations. Now since D is repeating we divide by 2! Hence we have 5!/2! = 60',1,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(174,'с Hay decided on these grounds that there should also be a gay nation; he took the name Mattachine from Renaissance bands of dancers dressed as fools','does |: indeed |: follow |: from','1','The committee can either consist of 4 ladies and 3 gentlemen or 5 ladies and 2 gentlemen, hence: <br> 5C4 X 6C3 + 5C5 X 6C2 <br> =115',24,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(175,' Hay\\уs radicalism soon caused internal discord, and the Mattachines moved in a less confrontational direction','indeed |: follow |: from |: its','3','The number of ways in whichh Rajat can answer the exam - 4^12 <br> For Rajat to get all answers wrong he needs to select one of 3 wrong options for all questions, hence he can answer in 3^12 ways. Therefore the probability of getting all answers wrong is 3^12/4^12',8,1,'0',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(176,' In public appearances, they made a point of looking respectable, wearing coats and ties','follow |: from |: its |: premises,','3','The probability that the first card is an ace - 4/52 <br> The prbability of 2nd card being ace given the first card is a n ace is -3/51. Hence the probability of both the events occuring is - 4/52 X 3/51 = 1/221',2,1,'0',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(177,' Members of the Daughters of Bilitis, a like-minded lesbian organization, were urged to abandon mannish clothes','from |: its |: premises, |: whether','1','The probability of getting 2 heads in a set of 4 coins is when we have 2 heads and 2 tails. The occurance of the same is 4C2 = 4!/2! 2! = 3. <br> Total number of cases = 2^4. <br> Hence probability = 3/8',27,1,'3',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(178,' The way the gay-rights story is usually told, things got moving only in 1969, when a fed-up phalanx of bull dykes, drag queens, and street youths rioted at the Stonewall Inn, in the West Village','its |: premises, |: whether |: the','0','Here the probability includes the following two events: both the cards can be Aces OR be Red in color. Hence the probability will be defined as - P(A) + P (R) - P(A U R) <br> P(A) = 4C2/52C2, P(R) = 26C2/52C2, P(A U R) = 2C2/52C2 . <br> Hence the probability is - (26C2 + 4C2 - 1) / 52C2',7,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(179,' One advantage of Hirshman\\уs bookяbreezily written, but kinetic in its storytellingяis that it honors the activism of the pre-Stonewall era, when any public exposure required considerable courage','premises, |: whether |: the |: premises','1','The following cases can come up when 2 coins are tossed together - HH, HT, TH, TT. <br> The top faces are same for HH & TT, hence the probability of occurance is 1/2',7,1,'2',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(180,' Political and legal advances, such as a 1958 Supreme Court decision ruling that the gay magazine ONE was not obscene material, were modest but hard won','whether |: the |: premises |: are','1','To evaluate the probability, we need to take 2 cases. <br> Case 1: When the first pen is also a Red pen and, <br> Case 2: When the first pen is not a Red pen. <br> For Case 1, since 1 red pen is already gone the probability will be 4/10 X 3/9, while for Case 2, the probability will be 6/10 X 4/9<br> Hence the total probability is - (4X3 + 6X4)/10X9 = .4',25,1,'0',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,1,1),
	(200,'Two large vertical and parallel metal plates having a separation of 1 cm are connected to a DC voltage source of potential difference X. A proton is released at rest midway between the two plates. It is found to move at 45<sup>o</sup> to the vertical JUST after release. Then X is nearly','1 x 10<sup>-5<//sup> V |: 1 x 10<sup>-7<//sup> V |: 1 x 10<sup>-9<//sup> V |: 1 x 10<sup>-10<//sup> V','2','<div>Writing the force equations on the particle, <br>\nmg = qE <br>\n(1.67 x 10<sup>-27<//sup>) x (10) = (1.67 x 10<sup>-19<//sup>)<img src = \"p29.png\"> <br>\n<img src = \"p30.png\"> <br>\nx = 1 x 10<sup>-9<//sup><//div> <div> <img src = \"image1.jpg\"><//div>',44,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(201,'For the circuit given below which of the following is true: <div> <img src = \'image2.jpg\'></div>','The current I through the battery is 7.5mA |: The potential difference across RL is 20V|: The ratios of power dissipated in R1 and R2 is 5 |: If R1 and R2 are interchanged, magnitude of power dissipated in RL will decrease by a factor of 3','0','R<sub>2</sub> and R<sub>L</sub> are in parallel hence <img src = \"p1.png\"> <br>\nR<sub>2L</sub> = 1.2k <br>\nR<sub>2L</sub> in turn is in series with R<sub>1</sub> hence the resistance of the circuit is:<br>\nR = 1.2 + 2 = 3.2 k <br>\nThe current I through battery is <img src = \'p2.png\'> <br> \n(A) is true\n',45,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(202,'<img src = \"image3.jpg\"> <br> A meter bridge is set-up as shown, to determine an unknown resistance X using a standard 10 ohm resistor. The galvanometer shows null point when tapping-key is at 52 cm mark. The end-corrections are 1 cm and 2 cm respectively for the ends A and B.  The determined value of X is:','10.2 ohm |: 10.6 ohm |:\n10.8 ohm |: 11.1 ohm','1',' <img src = \"p3.png\"> <br>\nWhere l<sub>1</sub> and l<sub>2</sub> are the lengths with end corrections<br>\nl<sub>1</sub> = 52 + 1 = 53 cm; l<sub>2</sub> = 48 + 2 = 50 cm<br> <img src = \"p4.png\"> <br>\nX = 10.6',46,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(203,'A spherical metal A of radius R<sub>A</sub> and a solid metal sphere B of radius R<sub>B</sub> \n(< R<sub>A</sub>) are kept far apart and each is given charge. Now a thin metal wire connects them. Which one of the following is false: ','E<sub>A</sub> (inside) = 0 |: Q<sub>A</sub> < Q<sub>B</sub> |:<sub>A</sub> /<sub>B</sub> = R<sub>B</sub> / R<sub>A </sub>|: E<sub>A</sub> (on surface) < E<sub>B</sub> (on surface)','3','E (inside) for metallic shell = 0 <br> <img src =  \"p5.png\"><br>\nSince R<sub>A</sub> > R<sub>B</sub> hence Q<sub>A</sub> > Q<sub>B</sub> => B is false <br> <img src =  \"p6.png\"><br> <img src =  \"p7.png\"> <1 <br> E<sub>A</sub><E<sub>B</sub>',47,1,'1',1,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(204,'For the resistance network shown in the figure, choose the wrong option.<br><img src = \"image4.jpg\"><br>','The current through PQ is zero |: i<sub>1</sub> = 3 A |: The potential at S is more than that at Q |: i<sub>2</sub> = 2 A\n','1','Due to input and output symmetry P & Q and S & T have same potential\nHence PQ and ST have 0 current\nHence R<sub>2</sub> = 6 ohm\nAnd R<sub>3</sub> = 12 ohm\nSince the 2 are in parallel, <br> <img src =  \"p8.png\"><br> <img src =  \"p9.png\"><br> \nQ and P have same potential. Since current is flowing from P to S with a resistance of 2ohm, V<sub>S</sub>< V<sub>P</sub> and hence V<sub>S</sub>< V<sub>Q</sub>\nTo calculate I<sub>2</sub>: \n6 x I<sub>2</sub> = 12 x (3- I<sub>2</sub>)\nI<sub>2</sub> = 2A',44,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(205,'A 2 micro Farad capacitor is charged as shown in figure.<br> <img src = \"image5.jpg\"><br> The percentage of its stored energy dissipated after the switch S is turned to position 2 is:','0% |: 20% |: 75% |: 80%','3','The initial charge: Q = C<sub>1</sub>V\nThe charge is distributed as Q1 and Q2 till the potentials are same.<br><img src =  \"p10.png\"> <br> Hence Q1 = Q/5 and Q2 = 4Q/5 <br> Energy in initial configuration <br> <img src =  \"p12.png\"> <br> Energy in final configuration <br> <img src =  \"p11.png\"><br><img src =  \"p13.png\">',45,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(206,'Two batteries of different EMFs and different internal resistances are connected as shown. The voltage across AB in volts is: <img src = \"image6.jpg\">',' 5 |: 4.5 |: 5.4 |: 3.8','0','Total EMF = 6V <br>\nResistance = 1ohm + 2ohm = 3ohm<br>\nHence, <br> <img src =  \"p14.png\"><br> V<sub>A</sub>-V<sub>B</sub> = 6V  , (1A x 1ohm) <br>\n= 5V',46,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(207,'A thin flexible wire of length L is connected to two adjacent fixed points and carries a current I in the clockwise direction, as shown in the figure. When the system is put in a uniform magnetic field of strength B going into the plane of the paper, the wire takes the shape of a circle. The tension in the wire is:  <img src = \"image7.jpg\">','IBL |: IBL / (pi) |: IBL /2(pi) |: IBL / 4(pi)\n','2','<div>Magnetic force acting upwards <img src =  \"p15.png\"><br> Tension (Vertical) acting downwards = <img src =  \"p16.png\"><br> Applying force balance - <br> 2 T sin(d(theta)/2) = B I (R d(theta)) <img src =  \"p17.png\"><br> T (d(theta)) = B I R (d(theta)) <br>Integrating over theta from 0 to 2(pi) <br> T= IBL/2(pi)</div><div><img src = \"image8.jpg\"></div>',47,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(208,'A few electric field lines for a system of two charges Q<sub>1</sub> and Q<sub>2</sub> fixed at two different points on the x-axis are shown in the figure. These lines suggest that:  <img src = \"image8.jpg\">','|Q1| > |Q2| |: |Q1| < |Q2| |: At a finite distance to the left of Q1 the electric field is zero |:  None of the above\n','0','Since the number of electric field lines of forces emerging from Q<sub>1</sub> is larger than terminating at Q<sub>2</sub>, the value of absolute charge Q<sub>1</sub> would be greater than the absolute value of Q<sub>2</sub><br>\nLet us assume the distance between the 2 charges is d\nAt any distance y, left of Q<sub>1</sub>, the electric field will be: <img src =  \"p18.png\"><br> Since Q<sub>1</sub> > Q<sub>2</sub> and y<sub>2</sub> < (y+d)<sup>2</sup> for a positive y, this term cannot be 0 for any value of y',44,1,'1',2,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(209,'When two identical batteries of internal resistance  each are connected in series across a resistor R, the rate of heat produced in R is J<sub>1</sub>. When the same batteries are connected in parallel across R, the rate is J<sub>2</sub>. If J<sub>1</sub> = 2.25J<sub>2</sub>  then the value of R in is','2.5 |: 4 |: 5 |: 4.3\n','1','Let the potential difference of each battery be V <br>\nFor series, <br>\nV<sub>1</sub> = 2V <br>\nR<sub>1/sub> = R+2<br>\nHence,<br><img src =  \"p19.png\"><br>\nFor parallel,<br>\nV<sub>2</sub> = V\nR<sub>2</sub> = (1 x 1)/(1+1) + R <br> 0.5ohm + R <br> Hence, <img src =  \"p20.png\"> <br>\nSince J<sub>1</sub>/ J<sub>2</sub> = 2.25, ',45,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(210,'A uniformly charged thin spherical shell of radius R carries uniform surface charge density of sigma per unit area. It is made of two hemispherical shells, held together by pressing them with force F (see figure). F is proportional to: <img src = \"image9.jpg\">','<img src =  \"p21.png\"> |: <img src =  \"p22.png\"> |: <img src =  \"p23.png\"> |: <img src =  \"p24.png\">','0','Electrostatic Repulsive Force: <img src =  \"p25.png\"><br> Since F balances this force, hence it is proportional to <img src =  \"p21.png\">',46,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(211,'A series R-C combination is connected to an AC voltage of angular frequency w = 500 radian/s. If the impedance of the R-C circuit is R sqrt(1.25), the time constant (in millisecond) of the circuit is: ','5 |: 2.6 |:  4|:  6\n','2','<img src =  \"p26.png\"> <br> <img src =  \"p27.png\">',47,1,'1',3,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(212,'Test Type 1','1|:2|:2|:|:23|:45|:66|:78|:80','1|:2|:3|:|:1|:2|:|:0',NULL,NULL,4,NULL,0,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(213,'Test Type 2','40320|:53760|:336|:448|:2240','1|:2|:4',NULL,NULL,3,NULL,0,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0),
	(214,'Test Type 3',NULL,'2',NULL,NULL,2,NULL,0,NULL,NULL,0,0,0,0,0,0,0,1,0,0,0,0,0);

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
  `rec` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `facultyId` int(11) DEFAULT NULL,
  `available` int(1) DEFAULT NULL,
  `mobileFlag` int(1) DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `totalAttempts` int(11) DEFAULT '0',
  `streamId` int(11) DEFAULT NULL,
  `maxScore` int(11) DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` (`id`,`questionIds`,`description`,`descriptionShort`,`conceptsTested`,`tags`,`l3Ids`,`l2Ids`,`questionCount`,`allotedTime`,`difficulty`,`ratings`,`rec`,`typeId`,`facultyId`,`available`,`mobileFlag`,`addedOn`,`totalAttempts`,`streamId`,`maxScore`)
VALUES
	(1,'4|:2|:3|:1|:5|:6|:7|:8|:9','Problems from Physical Chemistry<br>Lengthy Calculation Quiz','Problems from Physical Chemistry<br>Lengthy Calculation Quiz','Lengthy Calculation Quiz',NULL,NULL,'1|:2',9,2000,3,NULL,17,NULL,1,NULL,NULL,NULL,2218,1,100),
	(2,'10|:11|:12|:13|:14|:15|:16|:17|:18','Problems from Organic Chemistry<br>Focus on benzene groups','Problems from Organic Chemistry<br>Focus on benzene groups','Focus on benzene groups',NULL,NULL,'12',9,2000,2,NULL,22,NULL,1,NULL,NULL,NULL,753,1,100),
	(3,'19|:20|:21|:22|:23|:24|:25|:26|:27','Problems from Physical Chemistry<br>Tricky Questions','Problems from Physical Chemistry<br>Tricky Questions','Tricky Questions',NULL,NULL,'10',9,2000,2,NULL,11,NULL,2,NULL,NULL,NULL,2429,1,100),
	(4,'28|:29|:30|:31|:32|:33|:34|:35|:36','Problems from Inorganic Chemistry<br>Core Concepts','Problems from Inorganic Chemistry<br>Core Concepts','Core Concepts',NULL,NULL,'11',9,2000,2,NULL,6,NULL,2,NULL,NULL,NULL,3807,1,100),
	(5,'37|:38|:39|:40|:41|:42|:43|:44|:45','Problems from Inorganic Chemistry<br>Tricky Questions','Problems from Inorganic Chemistry<br>Tricky Questions','Tricky Questions',NULL,NULL,'11',9,2000,3,NULL,4,NULL,2,NULL,NULL,NULL,3547,1,100),
	(6,'45|:46|:47|:48|:49|:50|:51|:52|:53','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,1,NULL,17,1,3,NULL,NULL,NULL,1528,1,100),
	(7,'54|:55|:56|:57|:58|:59|:60|:61|:62','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,2,NULL,23,1,4,NULL,NULL,NULL,976,1,100),
	(8,'62|:63|:64|:65|:66|:67|:68|:69|:70','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,1,NULL,17,1,4,NULL,NULL,NULL,3023,1,100),
	(9,'71|:72|:73|:74|:75|:76|:77|:78|:79','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,3,NULL,1,1,1,NULL,NULL,NULL,1730,1,100),
	(10,'80|:81|:82|:83|:84|:85|:86|:87|:88','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,2,NULL,5,1,1,NULL,NULL,NULL,5025,1,100),
	(11,'88|:89|:90|:91|:92|:93|:94|:95|:96','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,3,NULL,1,1,2,NULL,NULL,NULL,5172,1,100),
	(12,'96|:97|:98|:99|:100|:101|:102|:103|:104','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,3,NULL,6,1,2,NULL,NULL,NULL,4601,1,100),
	(13,'105|:106|:107|:108|:109|:110|:111|:112|:113','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,2,NULL,16,1,3,NULL,NULL,NULL,4645,1,100),
	(14,'114|:115|:116|:117|:118|:119|:120|:121|:122','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,3,NULL,2,1,3,NULL,NULL,NULL,5122,1,100),
	(15,'123|:124|:125|:126|:127|:128|:129|:130|:131','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,2,NULL,3,1,1,NULL,NULL,NULL,568,1,100),
	(16,'132|:133|:134|:135|:136|:137|:138|:139|:140','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,3,NULL,11,1,1,NULL,NULL,NULL,389,1,100),
	(17,'141|:142|:143|:144|:145|:146|:147|:148|:149','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,3,NULL,15,1,2,NULL,NULL,NULL,2698,1,100),
	(18,'150|:151|:152|:153|:154|:155|:156|:157|:158','Problems from Full Length Mock<br>','Problems from Full Length Mock<br>','',NULL,NULL,NULL,9,2000,3,NULL,1,1,2,NULL,NULL,NULL,4929,1,100),
	(19,'159|:160|:161|:162|:163|:164|:165|:166|:167','Problems from Probability<br>','Problems from Probability<br>','',NULL,NULL,'1',9,2000,3,NULL,24,NULL,5,NULL,NULL,NULL,2186,1,100),
	(20,'168|:169|:170|:171|:172|:173|:174|:175|:176','Problems from Trigonometry<br>','Problems from Trigonometry<br>','',NULL,NULL,'2',9,2000,3,NULL,7,NULL,5,NULL,NULL,NULL,2225,1,100),
	(21,'105|:106|:107|:108|:109|:110|:111|:112|:113','Problems from All Maths<br>','Problems from All Maths<br>','',NULL,NULL,'3',9,2000,3,NULL,10,NULL,5,NULL,NULL,NULL,4710,1,100),
	(22,'114|:115|:116|:117|:118|:119|:120|:121|:122','Problems from Algebra<br>','Problems from Algebra<br>','',NULL,NULL,'1',9,2000,2,NULL,10,NULL,5,NULL,NULL,NULL,1663,1,100),
	(23,'123|:124|:125|:126|:127|:128|:129|:130|:131','Problems from Probability<br>','Problems from Probability<br>','',NULL,NULL,'2',9,2000,3,NULL,25,NULL,6,NULL,NULL,NULL,2210,1,100),
	(24,'132|:133|:134|:135|:136|:137|:138|:139|:140','Problems from Trigonometry<br>','Problems from Trigonometry<br>','',NULL,NULL,'2',9,2000,2,NULL,2,NULL,6,NULL,NULL,NULL,5247,1,100),
	(25,'141|:142|:143|:144|:145|:146|:147|:148|:149','Problems from All Maths<br>Core Concepts','Problems from All Maths<br>Core Concepts','Core Concepts',NULL,NULL,NULL,9,2000,1,NULL,14,NULL,6,NULL,NULL,NULL,1410,1,100),
	(26,'150|:151|:152|:153|:154|:155|:156|:157|:158','Problems from Algebra<br>','Problems from Algebra<br>','',NULL,NULL,'1',9,2000,2,NULL,25,NULL,6,NULL,NULL,NULL,4874,1,100),
	(27,'159|:160|:161|:162|:163|:164|:165|:166|:167','Problems from Coordinate Geometry<br>','Problems from Coordinate Geometry<br>','',NULL,NULL,'3',9,2000,1,NULL,2,NULL,7,NULL,NULL,NULL,3623,1,100),
	(28,'168|:169|:170|:171|:172|:173|:174|:175|:176','Problems from Coordinate Geometry<br>','Problems from Coordinate Geometry<br>','',NULL,NULL,'3',9,2000,3,NULL,13,NULL,7,NULL,NULL,NULL,840,1,100),
	(29,'71|:72|:73|:74|:75|:76|:77|:78|:79','Problems from Mechanics<br>Tricky Questions','Problems from Mechanics<br>Tricky Questions','Tricky Questions',NULL,NULL,'6',9,2000,3,NULL,5,NULL,8,NULL,NULL,NULL,2367,1,100),
	(30,'80|:81|:82|:83|:84|:85|:86|:87|:88','Problems from Mechanics<br>Core Concepts','Problems from Mechanics<br>Core Concepts','Core Concepts',NULL,NULL,'6',9,2000,1,NULL,11,NULL,8,NULL,NULL,NULL,817,1,100),
	(31,'88|:89|:90|:91|:92|:93|:94|:95|:96','Problems from Electromagnetism<br>Lengthy Calculation Quiz','Problems from Electromagnetism<br>Lengthy Calculation Quiz','Lengthy Calculation Quiz',NULL,NULL,'7',9,2000,1,NULL,6,NULL,8,NULL,NULL,NULL,3335,1,100),
	(32,'96|:97|:98|:99|:100|:101|:102|:103|:104','Problems from Nuclear Physics<br>Lengthy Calculation Quiz','Problems from Nuclear Physics<br>Lengthy Calculation Quiz','Lengthy Calculation Quiz',NULL,NULL,'7',9,2000,2,NULL,25,NULL,9,NULL,NULL,NULL,5159,1,100),
	(33,'200|:201|:202|:203|:204|:205|:206|:207|:208|:209|:210|:211|:212|:213|:214','Problems from Electromagnetism<br>Tricky Questions','Problems from Electromagnetism<br>Tricky Questions','Tricky Questions',NULL,NULL,'7',12,2000,1,NULL,20,NULL,9,NULL,NULL,NULL,204,1,100),
	(34,'1|:2|:3|:4|:5|:6|:7|:8|:9','Problems from Nuclear Physics<br>Core Concepts','Problems from Nuclear Physics<br>Core Concepts','Core Concepts',NULL,NULL,'7',9,2000,3,NULL,16,NULL,9,NULL,NULL,NULL,3960,1,100),
	(35,'10|:11|:12|:13|:14|:15|:16|:17|:18','Problems from Electromagnetism<br>Lengthy Calculation Quiz','Problems from Electromagnetism<br>Lengthy Calculation Quiz','Lengthy Calculation Quiz',NULL,NULL,'7',9,2000,2,NULL,5,NULL,10,NULL,NULL,NULL,432,1,100);

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
	(1,1,'[\"1|:2|:|:2|:|:\",null,null,null,null,null,null,null,null]','[0,1,0]','[6,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-23 17:49:36'),
	(3,24,'[\"1\",null,null,null,null,null,null,null,null]','[0,1,0]','[4,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-25 23:53:23'),
	(2,24,'[\"1\",null,null,null,null,null,null,null,null]','[0,1,0]','[3,null,null,null,null,null,null,null,null]',NULL,NULL,'2012-11-26 08:16:40'),
	(2,28,'[\"2\",\"2\",\"1\",null,null,null,null,null,null]','[1,2,1]','[4,1,2,null,null,null,null,null,null]',NULL,NULL,'2012-11-26 11:10:09'),
	(3,1,'[\"2\",\"3\",\"1\",\"1\",null,null,null,null,null]','[0,4,0]','[3,3,3,2,null,null,null,null,null]',NULL,NULL,'2012-11-27 10:19:42'),
	(4,1,'[\"1\",\"2\",\"2\",\"2\",null,null,null,null,null]','[0,4,0]','[3,3,2,3,null,null,null,null,null]',NULL,NULL,'2012-11-27 13:13:19');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

LOCK TABLES `section_l1` WRITE;
/*!40000 ALTER TABLE `section_l1` DISABLE KEYS */;
INSERT INTO `section_l1` (`id`,`displayName`,`longName`,`streamId`)
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
  PRIMARY KEY (`id`),
  KEY `l1Id` (`l1Id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

LOCK TABLES `section_l2` WRITE;
/*!40000 ALTER TABLE `section_l2` DISABLE KEYS */;
INSERT INTO `section_l2` (`id`,`displayName`,`longName`,`l1Id`,`streamId`)
VALUES
	(1,'Algebra','NULL',1,1),
	(2,'Trigonometry','NULL',1,1),
	(3,'Coordinate Geometry','NULL',1,1),
	(4,'Calculus','NULL',1,1),
	(5,'General','NULL',2,1),
	(6,'Mechanics','NULL',2,1),
	(7,'Electricity and Magnetism','NULL',2,1),
	(8,'Optics','NULL',2,1),
	(9,'Modern Physics','NULL',2,1),
	(10,'Physical Chemistry','NULL',3,1),
	(11,'Inorganic Chemistry','NULL',3,1),
	(12,'Organic Chemistry','NULL',3,1),
	(13,'General','NULL',4,2),
	(14,'Mechanics','NULL',4,2),
	(15,'Electricity and Magnetism','NULL',4,2),
	(16,'Optics','NULL',4,2),
	(17,'Modern Physics','NULL',4,2),
	(18,'Physical Chemistry','NULL',5,2),
	(19,'Inorganic Chemistry','NULL',5,2),
	(20,'Organic Chemistry','NULL',5,2),
	(21,'Biochemistry','NULL',5,2),
	(22,'Diversity in Living World','NULL',6,2),
	(23,'Structures in Plants and Anima','NULL',6,2),
	(24,'Cell Structure and Function','NULL',6,2),
	(25,'Plant Physiology','NULL',6,2),
	(26,'Human Physiology','NULL',6,2),
	(27,'Reproduction','NULL',6,2),
	(28,'Genetics and Evolution','NULL',6,2),
	(29,'Biology and Human Welfare','NULL',6,2),
	(30,'Biotechnology and its applicat','NULL',6,2),
	(31,'Ecology and Environment','NULL',6,2);

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
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8;

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
	(28,'Ordinary Differential Equations','NULL',4,1),
	(29,'Units and Dimensions','NULL',5,1),
	(30,'Physical Experiments','NULL',5,1),
	(31,'Optics Experiments','NULL',5,1),
	(32,'Electricity experiments','NULL',5,1),
	(33,'Heat Experiments','NULL',5,1),
	(34,'Kinematics','NULL',6,1),
	(35,'Newtons Laws','NULL',6,1),
	(36,'Collisions','NULL',6,1),
	(37,'Gravitation','NULL',6,1),
	(38,'Momentum','NULL',6,1),
	(39,'Bulk Matter','NULL',6,1),
	(40,'Fluid dynamics','NULL',6,1),
	(41,'Wave motion','NULL',6,1),
	(42,'Thermal Physics','NULL',6,1),
	(43,'Perfect Gas and Kinetic Theory','NULL',6,1),
	(44,'Electrostatics','NULL',7,1),
	(45,'Capacitance','NULL',7,1),
	(46,'Electric Current','NULL',7,1),
	(47,'Magnetic effects of current and magnetism','NULL',7,1),
	(48,'Electromagnetic induction','NULL',7,1),
	(49,'Electromagnetic waves','NULL',7,1),
	(50,'Reflection and refraction','NULL',8,1),
	(51,'Lenses','NULL',8,1),
	(52,'Prisms','NULL',8,1),
	(53,'Intereference','NULL',8,1),
	(54,'Atoms and Nuclei','NULL',9,1),
	(55,'Radioactive Decay','NULL',9,1),
	(56,'Dual Nature of Matter and Radiation (incl PE effec','NULL',9,1),
	(57,'Waves','NULL',9,1),
	(58,'Electro Chemistry','NULL',10,1),
	(59,'States of matter','NULL',10,1),
	(60,'Thermodynamics','NULL',10,1),
	(61,'Chemical Equilibrium','NULL',10,1),
	(62,'Chemical Kinetics','NULL',10,1),
	(63,'Solutions','NULL',10,1),
	(64,'Surface Chemistry','NULL',10,1),
	(65,'Nuclear Chemistry','NULL',10,1),
	(66,'Ores and Minerals','NULL',11,1),
	(67,'Oxygen compunds','NULL',11,1),
	(68,'Carbon compounds','NULL',11,1),
	(69,'Chlorine Compounds','NULL',11,1),
	(70,'Sulphur Compounds','NULL',11,1),
	(71,'Transition Elements','NULL',11,1),
	(72,'Extractive Metallurgy','NULL',11,1),
	(73,'Qualitative Analysis','NULL',11,1),
	(74,'S-block Elements','NULL',11,1),
	(75,'P-Block Elements','NULL',11,1),
	(76,'d and f block elements','NULL',11,1),
	(77,'General Concepts','NULL',12,1),
	(78,'Alkanes','NULL',12,1),
	(79,'Alkenes and Alkynes','NULL',12,1),
	(80,'Alcohols, Phenols and Ethers','NULL',12,1),
	(81,'Aldehydes, Ketones and Acids','NULL',12,1),
	(82,'Amino acids and peptides','NULL',12,1),
	(83,'Practical Organic Chemistry','NULL',12,1),
	(84,'Units and Dimensions','NULL',13,2),
	(85,'Physical Experiments','NULL',13,2),
	(86,'Optics Experiments','NULL',13,2),
	(87,'Electricity experiments','NULL',13,2),
	(88,'Heat Experiments','NULL',13,2),
	(89,'Kinematics','NULL',14,2),
	(90,'Newtons Laws','NULL',14,2),
	(91,'Collisions','NULL',14,2),
	(92,'Gravitation','NULL',14,2),
	(93,'Momentum','NULL',14,2),
	(94,'Bulk Matter','NULL',14,2),
	(95,'Fluid dynamics','NULL',14,2),
	(96,'Wave motion','NULL',14,2),
	(97,'Thermal Physics','NULL',14,2),
	(98,'Perfect Gas and Kinetic Theory','NULL',14,2),
	(99,'Electrostatics','NULL',15,2),
	(100,'Capacitance','NULL',15,2),
	(101,'Electric Current','NULL',15,2),
	(102,'Magnetic effects of current and magnetism','NULL',15,2),
	(103,'Electromagnetic induction','NULL',15,2),
	(104,'Electromagnetic waves','NULL',15,2),
	(105,'Reflection and refraction','NULL',16,2),
	(106,'Lenses','NULL',16,2),
	(107,'Prisms','NULL',16,2),
	(108,'Intereference','NULL',16,2),
	(109,'Atoms and Nuclei','NULL',17,2),
	(110,'Radioactive Decay','NULL',17,2),
	(111,'Dual Nature of Matter and Radiation (incl PE effec','NULL',17,2),
	(112,'Electronic Devices','NULL',17,2),
	(113,'Electro Chemistry','',18,2),
	(114,'States of matter','',18,2),
	(115,'Thermodynamics','',18,2),
	(116,'Chemical Equilibrium','',18,2),
	(117,'Chemical Kinetics','',18,2),
	(118,'Solutions','',18,2),
	(119,'Surface Chemistry','',18,2),
	(120,'Nuclear Chemistry','',18,2),
	(121,'Ores and Minerals','',19,2),
	(122,'Oxygen compunds','',19,2),
	(123,'Carbon compounds','',19,2),
	(124,'Chlorine Compounds','',19,2),
	(125,'Sulphur Compounds','',19,2),
	(126,'Transition Elements','',19,2),
	(127,'Extractive Metallurgy','',19,2),
	(128,'Qualitative Analysis','',19,2),
	(129,'S-block Elements','',19,2),
	(130,'P-Block Elements','',19,2),
	(131,'d and f block elements','',19,2),
	(132,'General Concepts','',20,2),
	(133,'Alkanes','',20,2),
	(134,'Alkenes and Alkynes','',20,2),
	(135,'Alcohols, Phenols and Ethers','',20,2),
	(136,'Aldehydes, Ketones and Acids','',20,2),
	(137,'Amino acids and peptides','',20,2),
	(138,'Practical Organic Chemistry','',20,2),
	(139,'Environmental chemistry','',21,2),
	(140,'Biomolecules','',21,2),
	(141,'Polymers','',21,2),
	(142,'Classification ','',22,2),
	(143,'Features and classification of plants','',22,2),
	(144,'Features and classification of animals','',22,2),
	(145,'Morphology and Anatomy (plants)','',23,2),
	(146,'Morphology and Anatomy (animals)','',23,2),
	(147,'Cell theory','',24,2),
	(148,'Chemical Constituents of living cells','',24,2),
	(149,'Cell division','',24,2),
	(150,'Transport in plants','',25,2),
	(151,'Mineral Nutrition','',25,2),
	(152,'Photosynthesis','',25,2),
	(153,'Respiration','',25,2),
	(154,'Plant growth and development','',25,2),
	(155,'Digestion and absorption','',26,2),
	(156,'Breathing and respiration','',26,2),
	(157,'Body fluids and circulation','',26,2),
	(158,'Excretory products','',26,2),
	(159,'Locomotion and movement','',26,2),
	(160,'Neural control and coordination','',26,2),
	(161,'Reproduction in organisms','',27,2),
	(162,'Sexual reproduction in plants','',27,2),
	(163,'Human reproduction','',27,2),
	(164,'Reproductive Health','',27,2),
	(165,'Heredity and Variation','',28,2),
	(166,'Inheritance','',28,2),
	(167,'Evolution','',28,2),
	(168,'Health and disease','',29,2),
	(169,'Improvement in food production','',29,2),
	(170,'Microbes in human welfare','',29,2),
	(171,'Genetic Engineering','',30,2),
	(172,'Applications of biotechnology','',30,2),
	(173,'Organisms and environment','',31,2),
	(174,'Ecosystem','',31,2),
	(175,'Biodiversity','',31,2),
	(176,'Environmental issues','',31,2);

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
  KEY `accountId` (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` (`ascoreL1`,`ascoreL2`,`quizzesAttempted`,`accountId`,`streamId`)
VALUES
	(0,0,NULL,1,1),
	(0,0,NULL,2,1),
	(0,0,NULL,3,1),
	(0,0,NULL,6,1),
	(0,0,NULL,24,1),
	(0,0,NULL,25,1),
	(0,0,NULL,26,1),
	(0,0,NULL,27,1),
	(0,0,NULL,28,1),
	(0,0,NULL,29,1);

/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
