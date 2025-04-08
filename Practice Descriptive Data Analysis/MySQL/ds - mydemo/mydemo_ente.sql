-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydemo
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `ente`
--

DROP TABLE IF EXISTS `ente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ente` (
  `idente` int NOT NULL DEFAULT '0',
  `TitoloEnte` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  KEY `_ente` (`idente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ente`
--

LOCK TABLES `ente` WRITE;
/*!40000 ALTER TABLE `ente` DISABLE KEYS */;
INSERT INTO `ente` VALUES (1,'Johns Hopkins SAIS Bologna (Italy)'),(2,'University of Plymouth (UK)'),(3,'University of Marburg (Germany)'),(4,'Università Federico II di Napoli (Italy)'),(7,'IPSOS srl'),(8,'Università La Sapienza'),(9,'Università Cattolica del Sacro Cuore'),(10,'Università di Bologna'),(11,'TIM'),(12,'IPSA'),(14,'Fernando, Universidad Autónoma de Madrid (UAM), Departamento Ciencia Politica y Relaciones Internacionale'),(15,'Sciences Po, Grenoble'),(16,'Technical University, Dresden, Germany'),(17,'Istanbul Bilgi University,  Department of International Relations'),(18,'Scuola Nazionale dell\'Amministrazione'),(19,'Scuola Normale Superiore di Pisa'),(20,'Università di Catania'),(21,'Università di Firenze'),(22,'Ministero dell\'istruzione, dell\'università e della ricerca'),(23,'FSI'),(24,'Cisia'),(25,'Bicocca'),(26,'Università degli Studi di Napoli L\'Orientale'),(27,'Università degli studi di Padova'),(28,'Università degli studi di Firenze'),(29,'Università di Pavia'),(30,'Pontificia Facoltà Teologica Italia Meridionale - Sez. San Luigi, Napoli'),(31,'Agenzia Coesione Territoriale'),(32,'Università per stranieri di Siena'),(33,'Wellesley College'),(34,'Altro'),(35,'SEA');
/*!40000 ALTER TABLE `ente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-14 10:46:32
