-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 34.93.27.54    Database: social_network
-- ------------------------------------------------------
-- Server version	8.0.26-google

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'ac540a22-a1dc-11ec-9f32-42010aa00003:1-290';

--
-- Dumping events for database 'social_network'
--

--
-- Dumping routines for database 'social_network'
--
/*!50003 DROP PROCEDURE IF EXISTS `spPostAdd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `spPostAdd`(
	IN v_title VARCHAR(50),
    IN v_content VARCHAR(255),
	IN v_user INT(11)
    )
BEGIN

	INSERT INTO post (`title`, 
		`content`, 
		`created_by`)
	VALUES (v_title, v_content, v_user);
                
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spPostGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `spPostGet`(
	-- fetch single records
	IN id INT,
	IN search VARCHAR(50),

	-- for pagination
	IN `offset` INT,
	IN `rows` INT,

	-- for sorting
	IN `sort-col` VARCHAR(50),
	IN `sort-dir` VARCHAR(4),

	-- for returning only total count of matching records
	IN `count-only` BIT
)
BEGIN
	
	SET `offset` = COALESCE(`offset`, 0);
	SET `rows` = COALESCE(`rows`, 2147483647);

	-- if count-only is true make sure to increase the rows to getch to max limit
	IF COALESCE(`count-only`, 0) = 1 THEN SET `rows` = 2147483647; END IF;

	SET `sort-col` = COALESCE(`sort-col`, 'title');
	SET `sort-dir` = COALESCE(`sort-dir`, 'asc');

	IF search IS NOT NULL THEN
		SET search = CONCAT("%", search, "%");
	END IF;

	DROP TEMPORARY TABLE IF EXISTS spPostGetTemp;

	CREATE TEMPORARY TABLE spPostGetTemp
	SELECT 
		p.id,
		p.title,
        p.content,
        p.created_by,
        p.created_at,
        p.updated_at
        FROM post p
	WHERE 
		p.deleted = FALSE 
	AND
		(id IS NULL OR p.id = id)
	AND
		(search IS NULL OR CONCAT_WS(' ', p.title) like search)
	ORDER BY
		CASE WHEN `sort-col` = 'name' AND `sort-dir` = 'asc' THEN title END ASC,
		CASE WHEN `sort-col` = 'name' AND `sort-dir` = 'desc' THEN title END DESC
	LIMIT `offset`, `rows`;
    
	IF COALESCE(`count-only`, 0) THEN
		SELECT ROW_COUNT() AS ROW_COUNT;
	ELSE
		SELECT * FROM spPostGetTemp;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spPostUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `spPostUpdate`(
	IN id int,
	IN v_title VARCHAR(255),
	IN v_content VARCHAR(255),
    IN v_deleted BIT,
	IN update_all BIT
)
BEGIN

	 UPDATE post p
	 SET 
		p.title = IF(COALESCE(update_all, true) = true OR v_title IS NOT NULL, v_title, p.title),
        p.content = IF(COALESCE(update_all, true) = true OR v_content IS NOT NULL, v_content, p.content),
		p.deleted = IF(COALESCE(update_all, true) = true OR v_deleted IS NOT NULL, v_deleted, p.deleted)
	 WHERE p.id = id;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-12 14:09:44
