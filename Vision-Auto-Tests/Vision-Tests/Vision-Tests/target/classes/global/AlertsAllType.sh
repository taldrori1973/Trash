#!/bin/bash

if [ -z "$1" ]; then
	echo "Plase provide num of rows" >&2
	exit 1
fi
i=1
echo '-- MySQL dump 10.13  Distrib 5.1.49, for unknown-linux-gnu (x86_64)
--
-- Host: localhost    Database: vision
-- ------------------------------------------------------
-- Server version	5.1.49-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='\''+00:00'\'' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table 'alert'
--

DROP TABLE IF EXISTS `vision_ng`.`alert`;
CREATE TABLE `vision_ng`.`alert` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `module` smallint(6) NOT NULL,
  `devicetype` smallint(6) NOT NULL,
  `severity` smallint(6) NOT NULL,
  `raisedtime` timestamp NULL DEFAULT NULL,
  `message` text DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `deviceormid` varchar(255) DEFAULT NULL,
  `deviceip` varchar(255) DEFAULT NULL,
  `devicename` varchar(255) DEFAULT NULL,
  `trapsid` varchar(255) DEFAULT NULL,
  `port` varchar(255) DEFAULT NULL,
  `cleared` bit(1) NOT NULL,
  `clearedtime` timestamp NULL DEFAULT NULL,
  `acknowledged` bit(1) NOT NULL,
  `acknowledgedtime` timestamp  NULL DEFAULT NULL,
  `mailed` bit(1) NOT NULL,
  `alert_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
CREATE INDEX raisedtime ON vision_ng.alert (raisedtime) USING BTREE;
CREATE INDEX deviceormid ON vision_ng.alert (deviceormid) USING BTREE;
CREATE INDEX alerts_for_ui ON vision_ng.alert (cleared, module, devicetype, severity, deviceormid, raisedtime) USING BTREE;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;'

DATE=$(date +%Y-%m-%d\ %H:%M:%S)
i=0
while [ $i -lt $1 ]
do

	echo "INSERT INTO \`alert\` VALUES ($i,1,2,1,'$DATE','Device Security-Critical-DefensePro','radware',NULL,'172.16.22.25','172.16.22.25',NULL,NULL,'\0',NULL,0 ,NULL,'\0',6666);"
	echo "INSERT INTO \`alert\` VALUES ($i+1,2,3,2,'$DATE','Device General-Major-Vision','radware',NULL,'172.17.164.144','172.17.164.144',NULL,NULL,'\0',NULL,0 ,NULL,'\0',6666);"
	echo "INSERT INTO \`alert\` VALUES ($i+2,3,5,3,'$DATE','Vision General-Minor-Alteon','radware',NULL,'172.16.62.63_vADC-1','172.16.163.1',NULL,NULL,'\0',NULL,0 ,NULL,'\0',6666);"
	echo "INSERT INTO \`alert\` VALUES ($i+3,4,2,4,'$DATE','Vision Configuration-Warning-DefensePro','radware',NULL,'172.16.22.25','172.16.22.25',NULL,NULL,'\0',NULL,0 ,NULL,'\0',6666);"
	echo "INSERT INTO \`alert\` VALUES ($i+4,5,3,5,'$DATE','Vision Control-Info-Vision','radware',NULL,'172.17.164.144','172.17.164.144',NULL,NULL,'\0',NULL,0 ,NULL,'\0',6666);"
    echo "INSERT INTO \`alert\` VALUES ($i+5,6,5,1,'$DATE','Security Reporting-Critical-Alteon','radware',NULL,'172.16.62.63_vADC-2','172.16.163.2',NULL,NULL,'\0',NULL,0 ,NULL,'\0',6666);"

let i+=6;
done
echo '/*!40000 ALTER TABLE 'alert' ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-03-09 14:01:48'

