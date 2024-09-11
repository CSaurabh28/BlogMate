CREATE DATABASE  IF NOT EXISTS `blogmaker` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blogmaker`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: blogmaker
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) NOT NULL,
  `cdesc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Nature',NULL),(2,'Sport',NULL),(3,'Educational',NULL),(4,'Politics',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comId` int NOT NULL AUTO_INCREMENT,
  `comment` varchar(50) NOT NULL,
  `uid` int NOT NULL,
  `pid` int NOT NULL,
  `comDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comId`),
  KEY `uid_idx` (`uid`),
  KEY `pid_idx` (`pid`),
  CONSTRAINT `post_id` FOREIGN KEY (`pid`) REFERENCES `post` (`pId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`uid`) REFERENCES `register` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'hii',1,9,'2024-07-25 10:12:48'),(2,'virat cool',1,9,'2024-07-25 10:12:48'),(3,'cool',1,9,'2024-07-25 11:01:25'),(4,'great',1,9,'2024-07-25 11:03:02'),(12,'nature is at best',1,8,'2024-07-25 11:40:16'),(13,'wow',5,8,'2024-07-25 11:40:54'),(14,'best wishes!',5,6,'2024-07-25 13:30:36'),(15,'beautiful...',1,6,'2024-07-25 13:40:00'),(16,'beauty of nature',5,10,'2024-07-25 14:45:46'),(17,'great?',5,10,'2024-07-25 14:47:16'),(18,'beautiful girls in frame?',1,6,'2024-07-25 14:57:52'),(19,'middleclass will die',1,11,'2024-07-25 15:25:47'),(20,'??',10,12,'2024-07-30 15:23:18'),(21,'wow',1,3,'2024-08-08 09:07:15'),(22,'hitman',12,14,'2024-08-18 07:00:25'),(23,'rohit?',1,14,'2024-08-23 15:07:34');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liked`
--

DROP TABLE IF EXISTS `liked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liked` (
  `lId` int NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`lId`),
  KEY `pid_idx` (`pid`),
  KEY `uid_idx` (`uid`),
  CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `post` (`pId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userid` FOREIGN KEY (`uid`) REFERENCES `register` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked`
--

LOCK TABLES `liked` WRITE;
/*!40000 ALTER TABLE `liked` DISABLE KEYS */;
INSERT INTO `liked` VALUES (116,3,3),(118,2,3),(134,5,4),(142,6,4),(218,5,5),(219,2,5),(234,6,5),(251,8,5),(255,9,5),(258,11,8),(262,5,3),(266,10,1),(267,7,1),(285,6,1),(286,11,1),(292,10,5),(294,11,10),(295,3,1),(297,12,1),(299,14,12),(300,9,12),(301,8,12),(302,7,12),(303,9,1),(304,14,1);
/*!40000 ALTER TABLE `liked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `pId` int NOT NULL AUTO_INCREMENT,
  `pTitle` varchar(100) NOT NULL,
  `pContent` varchar(1000) DEFAULT NULL,
  `pImg` varchar(100) DEFAULT NULL,
  `pDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cId` int DEFAULT NULL,
  `uId` int NOT NULL,
  PRIMARY KEY (`pId`),
  KEY `cid_idx` (`cId`),
  KEY `uid_idx` (`uId`),
  CONSTRAINT `cid` FOREIGN KEY (`cId`) REFERENCES `categories` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid` FOREIGN KEY (`uId`) REFERENCES `register` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (2,'python lang',' it is easy','wc.jpg','2024-07-21 16:30:09',2,3),(3,'India Won the World Cup!!!','India vs Sri Lanka Squad Announcement Live Updates: Big-hitting batter Suryakumar Yadav was on Thursday named captain of the Indian T20 team for the three-match series against Sri Lanka starting July 27, while ODI skipper Rohit Sharma and Virat Kohli were included for the 50-over series against the same team next month.','head1.jpeg','2024-07-21 19:30:24',2,1),(5,'andharban trek is so beautiful',' The trek through Andharban is one of the most refreshing treks in the Sahyadri region. The name ‘Andharban’ is a compound word, coming from Andhar, meaning ‘dark’, and ban, which means ‘forest’. Literally the ‘dark forest’, Andharban is a trail through dense overgrowth, with beautiful views of the Devkund waterfall, Plus Valley and the Tamhini Ghat along the way.','andhar.jpeg','2024-07-23 17:18:48',1,4),(6,'Bcs Students got there farewell!',' boys and girls are enjoying there farewell of class ','farewell.jpg','2024-07-23 17:28:33',3,5),(7,'Worls Cup',' Winner','roko.jpg','2024-07-24 06:39:52',2,6),(8,'Lonavala feels Green in rainy season.',' Nestled in the Sahyadri range of the Western Ghats of India, Lonavala is renowned for its numerous caves that proffer a delightful adventure for those who dare. In fact, the hill station gets its name from the Sanskrit/Prakrit words for \'series of caves\'.','lonavala-in-maharashtra.jpg','2024-07-24 13:27:57',1,1),(9,'Virat 50th Century',' Kohli notched up the 50th hundred off 105 balls, with a flick for two off Lockie Ferguson in the 42nd over of India\'s innings against New Zealand in the first World Cup semi-final here.','virat 50.jpeg','2024-07-24 19:27:17',2,7),(10,'Tigers are getting murdered by citizens',' The Champawat Tiger was a man-eating tigress which purportedly killed some 200 men and women before being driven out of Nepal. She moved to Champawat district in the state of Uttarakhand in North India,','tiger.jpg','2024-07-25 13:32:25',1,5),(11,'The new Budget is declared by goverment',' The 2024 Interim-Union Budget of India provides comprehensive information regarding the projected revenue and government spending for the fiscal year 2024–25, commencing on 1 April 2024 and concluding on 31st March 2025','politics.jpg','2024-07-25 15:02:00',4,5),(12,'andharban treck',' The trek covers a distance of approximately 14 kilometers and takes around 10 hours to complete. It involves crossing three major waterfalls and navigating through a dense and slippery forest. The trail is moderately challenging, requiring good endurance and fitness level.','trek.jpg','2024-07-30 15:22:03',1,10),(13,'Chandu Champion',' Kartik portrays Chandu in this film, which is based on the life of Murlikant Petkar, India\'s first Paralympic gold medalist in freestyle swimming. From fans to critics, members of the film industry and audiences, Kartik has received praise','chandu.jpg','2024-08-14 15:36:54',1,11),(14,'Rohit Sharma: The Hitman of Indian Cricket',' Introduction:\r\nRohit Sharma, fondly known as \"The Hitman,\" is a name that resonates with cricket fans worldwide. Over the years, Rohit has established himself as one of the most prolific and stylish batsmen in modern cricket. His ability to score big and his knack for making centuries, especially in crucial matches, has made him an indispensable part of the Indian cricket team.','1337130.jpg','2024-08-18 07:00:07',2,12);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `register`
--

DROP TABLE IF EXISTS `register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `register` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `mobile` varchar(500) NOT NULL,
  `email` varchar(500) NOT NULL,
  `password` varchar(500) NOT NULL,
  `rdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `profile` varchar(500) DEFAULT 'default.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `register`
--

LOCK TABLES `register` WRITE;
/*!40000 ALTER TABLE `register` DISABLE KEYS */;
INSERT INTO `register` VALUES (1,'saurabh chavan','9970212121','csaurabh465@gmail.com','123','2024-07-19 20:26:53','sau.jpg'),(2,'saurabh','9970212121','csaurabh465@gmail.com','123','2024-07-19 20:41:05','default.png'),(3,'om','9960335350','com28@gmail.com','1','2024-07-21 13:00:26','roko.jpg'),(4,'pratiksha','8767057223','pratu11@gmail.com','1','2024-07-21 22:10:14','prati.jpg'),(5,'pratiksha katkade','8767057223','pratiksha@gmail.com','123','2024-07-23 22:52:49','pratu.jpg'),(6,'Om Kumawat','71233456678','Om@gmail.com','123','2024-07-24 12:08:52','virat.jpg'),(7,'Mohanish Kothawade','9834826596','kothawademohanish@gmail.com','Mohanish@1999','2024-07-25 00:51:24','Mohanish.jpg'),(8,'mohnish','1234567890','mohnish@gmail.com','1','2024-07-25 20:35:46','default.png'),(9,'chetan patil','8421591016','chetanpatil@gmail.com','1','2024-07-27 11:52:29','chetan.jpg'),(10,'asmitadeore169','25677889676','asmita@gmail.com','1','2024-07-30 20:44:12','asmi.jpg'),(11,'siddhesh','9209446006','shewalesiddhu73@gmail.com','1234','2024-08-14 21:01:32','default.png'),(12,'jitesh pawar','8805392898','jiteshpawar1501@gmail.com','jeet1234','2024-08-18 12:19:46','jitesh.jpg'),(13,'rohit pawar','9503584903','rohitpawar2199@gmail.com','1421','2024-08-20 20:22:46','roh.jpg');
/*!40000 ALTER TABLE `register` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-11 11:23:25
