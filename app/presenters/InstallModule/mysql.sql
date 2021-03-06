-- MySQL dump 10.13  Distrib 5.5.54, for Linux (x86_64)
--
-- Host: localhost    Database: pavel_new
-- ------------------------------------------------------
-- Server version	5.5.54

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acl_privilege`
--

DROP TABLE IF EXISTS `acl_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_privilege` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `privilege` varchar(100) DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acl_privilege__acl_resource` (`resource_id`),
  CONSTRAINT `acl_privilege__acl_resource` FOREIGN KEY (`resource_id`) REFERENCES `acl_resource` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_privilege`
--

LOCK TABLES `acl_privilege` WRITE;
/*!40000 ALTER TABLE `acl_privilege` DISABLE KEYS */;
INSERT INTO `acl_privilege` VALUES (1,NULL,'Bez omezení',NULL,0),(4,1,'Zobrazení seznamu dokumentů','',0),(6,19,'Práce se subjekty','',0),(7,20,'Práce s přílohami','',0),(8,18,'Práce se spisy','',0),(9,2,'Přístup do Epodatelny','',0),(10,23,'E-podatelna - evidence','',0),(11,22,'E-podatelna - přílohy','',0),(12,24,'E-podatelna - subjekty','',0),(13,26,'Spojování dokumentů','',0),(15,29,'Vyhledávání','',0),(16,NULL,'Je vedoucí','is_vedouci',0),(24,37,'Výpravna','',0),(25,38,'Zobrazení zpráv','',0),(27,40,'Odesílání datových zpráv','odesilani',0),(30,3,'Zobrazit','',0),(31,6,'Zobrazit / měnit','',0),(32,9,'Zobrazit / měnit','',0),(33,10,'Zobrazit / měnit','',0),(34,11,'Zobrazit / měnit','',0),(35,12,'Zobrazit / měnit','',0),(36,13,'Zobrazit','',0),(37,14,'Zobrazit / měnit','',0),(38,15,'Zobrazit / měnit','',0),(39,16,'Zobrazit / měnit','',0),(40,17,'Zobrazit','',0),(41,21,'Zobrazit / měnit','',0),(42,41,'Čtení dokumentů svojí org. jednotky','cist_moje_oj',0),(43,41,'Čtení všech dokumentů','cist_vse',0),(44,41,'Změny dokumentů svojí org. jednotky','menit_moje_oj',0),(45,42,'Příjem dokumentů a spisů','prijem_dokumentu',20),(46,42,'Čtení dokumentů a spisů','cist_dokumenty',10),(47,42,'Upravit skartační režim','zmenit_skartacni_rezim',30),(48,42,'Zařadit dokumenty do skartačního řízení','skartacni_navrh',40),(49,42,'Skartační řízení','skartacni_rizeni',50),(50,43,'Zobrazit','zobrazit',10),(51,43,'Měnit','menit',20),(52,43,'Mazat','mazat',30),(53,41,'Otevření uzavřeného dokumentu','znovu_otevrit',10),(54,44,'Vytvořit žádost','vytvorit',0),(55,44,'Schválit žádost','schvalit',0);
/*!40000 ALTER TABLE `acl_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_resource`
--

DROP TABLE IF EXISTS `acl_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(150) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_resource`
--

LOCK TABLES `acl_resource` WRITE;
/*!40000 ALTER TABLE `acl_resource` DISABLE KEYS */;
INSERT INTO `acl_resource` VALUES (1,'Spisovka_DokumentyPresenter',NULL,'Seznam dokumentů'),(2,'Epodatelna_DefaultPresenter',NULL,'E-podatelna - úvodní obrazovka'),(3,'Admin_DefaultPresenter',NULL,'Administrace - úvodní obrazovka'),(4,'Spisovka_UzivatelPresenter',NULL,'Přihlašování a změna osobních údajů uživatele'),(5,'Spisovka_DefaultPresenter',NULL,'Úvodní obrazovka'),(6,'Admin_ZamestnanciPresenter',NULL,'Administrace - zaměstnanci'),(9,'Admin_OpravneniPresenter',NULL,'Administrace - oprávnění'),(10,'Admin_OrgjednotkyPresenter',NULL,'Administrace - organizační jednotky'),(11,'Admin_NastaveniPresenter',NULL,'Administrace - nastavení'),(12,'Admin_SubjektyPresenter',NULL,'Administrace - subjekty'),(13,'Admin_PrilohyPresenter',NULL,'Administrace - soubory'),(14,'Admin_CiselnikyPresenter',NULL,'Administrace - číselníky'),(15,'Admin_SpisyPresenter',NULL,'Administrace - spisy'),(16,'Admin_SpisznakPresenter',NULL,'Administrace - spisové znaky'),(17,'Admin_ProtokolPresenter',NULL,'Administrace - protokoly'),(18,'Spisovka_SpisyPresenter',NULL,'Spisy'),(19,'Spisovka_SubjektyPresenter',NULL,'Subjekty'),(20,'Spisovka_PrilohyPresenter',NULL,'Přílohy'),(21,'Admin_EpodatelnaPresenter',NULL,'Administrace - nastavení e-podatelny'),(22,'Epodatelna_PrilohyPresenter',NULL,'Epodatelna - zobrazení přílohy'),(23,'Epodatelna_EvidencePresenter',NULL,'Epodatelna - evidence'),(24,'Epodatelna_SubjektyPresenter',NULL,'Epodatelna - subjekt'),(26,'Spisovka_SpojitPresenter',NULL,'Spisovka - spojení dokumentů'),(28,'Install_DefaultPresenter',NULL,'Instalace'),(29,'Spisovka_VyhledatPresenter',NULL,'Vyhledávání'),(30,'Admin_AkonverzePresenter',NULL,'Administrace - Autorizovaná konverze'),(37,'Spisovka_VypravnaPresenter',NULL,'Výpravna'),(38,'Spisovka_ZpravyPresenter',NULL,'Zprávy'),(40,'DatovaSchranka',NULL,'Datová schránka'),(41,'Dokument',NULL,'Dokumenty'),(42,'Spisovna',NULL,'Spisovna'),(43,'Sestava',NULL,'Sestavy'),(44,'Zapujcka',NULL,'Spisovna - zápůjčky');
/*!40000 ALTER TABLE `acl_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_role`
--

DROP TABLE IF EXISTS `acl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `fixed_id` int(10) unsigned DEFAULT NULL,
  `orgjednotka_id` int(10) unsigned DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `note` varchar(250) DEFAULT NULL,
  `fixed` tinyint(4) DEFAULT '0',
  `order` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `sekvence` varchar(150) NOT NULL,
  `sekvence_string` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acl_role__orgjednotka` (`orgjednotka_id`),
  KEY `acl_role__acl_role` (`parent_id`),
  CONSTRAINT `acl_role__orgjednotka` FOREIGN KEY (`orgjednotka_id`) REFERENCES `orgjednotka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `acl_role__acl_role` FOREIGN KEY (`parent_id`) REFERENCES `acl_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_role`
--

LOCK TABLES `acl_role` WRITE;
/*!40000 ALTER TABLE `acl_role` DISABLE KEYS */;
INSERT INTO `acl_role` VALUES (1,NULL,NULL,NULL,'admin','administrátor','Pracovník, který má na starost správu spisové služby',2,NULL,1,'2016-12-07 12:58:30','2016-12-07 12:58:30','1','admin.1'),(3,1,NULL,NULL,'superadmin','SuperAdmin','Administrátor se super právy.\\nMůže manipulovat s jakýmikoli daty. Včetně dokumentů bez ohledu na vlastníka a stavu. ',2,NULL,1,'2016-12-07 12:58:30','2016-12-07 12:58:30','1.3','admin.1#superadmin.3'),(4,NULL,NULL,NULL,'referent','pracovník','(referent) Základní role pracovníka spisové služby',1,NULL,1,'2016-12-07 12:58:30','2016-12-07 12:58:30','4','referent.4'),(5,4,NULL,NULL,'vedouci','sekretariát','(vedoucí) Rozšířená role pracovníka spisové služby. Může nahlížet na podřízené uzly',1,NULL,1,'2016-12-07 12:58:30','2016-12-07 12:58:30','4.5','referent.4#vedouci.5'),(6,4,NULL,NULL,'podatelna','pracovník podatelny','Pracovník podatelny, který může přijímat nebo odesílat dokumenty',1,NULL,1,'2016-12-07 12:58:30','2016-12-07 12:58:30','4.6','referent.4#podatelna.6'),(7,4,NULL,NULL,'spisovna','pracovník spisovny','Má na starost spisovnu',1,NULL,1,'2016-12-07 12:58:30','2016-12-07 12:58:30','4.7','referent.4#skartacni_dohled.7'),(8,4,NULL,NULL,'skartacni_komise','člen skartační komise','člen skartační komise, která rozhoduje o skartaci nebo archivaci dokumentu.',1,NULL,1,'2016-12-07 12:58:30','2016-12-07 12:58:30','4.8','referent.4#skartacni_komise.8');
/*!40000 ALTER TABLE `acl_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_role_to_privilege`
--

DROP TABLE IF EXISTS `acl_role_to_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role_to_privilege` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `privilege_id` int(10) unsigned NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `acl_role_to_privilege__acl_privilege` (`privilege_id`),
  KEY `acl_role_to_privilege__acl_role` (`role_id`),
  CONSTRAINT `acl_role_to_privilege__acl_privilege` FOREIGN KEY (`privilege_id`) REFERENCES `acl_privilege` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `acl_role_to_privilege__acl_role` FOREIGN KEY (`role_id`) REFERENCES `acl_role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_role_to_privilege`
--

LOCK TABLES `acl_role_to_privilege` WRITE;
/*!40000 ALTER TABLE `acl_role_to_privilege` DISABLE KEYS */;
INSERT INTO `acl_role_to_privilege` VALUES (1,1,1,'Y'),(6,4,4,'Y'),(7,4,7,'Y'),(8,4,50,'Y'),(9,4,8,'Y'),(10,4,13,'Y'),(11,4,6,'Y'),(14,4,15,'Y'),(15,5,16,'Y'),(16,6,9,'Y'),(17,6,10,'Y'),(18,6,11,'Y'),(19,6,12,'Y'),(29,6,24,'Y'),(62,3,1,'Y'),(64,4,27,'Y'),(70,4,42,'Y'),(71,7,45,'Y'),(72,7,46,'Y'),(73,8,46,'Y'),(74,7,47,'Y'),(75,8,47,'Y'),(76,7,48,'Y'),(77,8,48,'Y'),(78,8,49,'Y'),(79,4,51,'Y'),(80,5,44,'Y'),(81,4,54,'Y'),(82,7,54,'Y'),(83,7,55,'Y');
/*!40000 ALTER TABLE `acl_role_to_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_workflow`
--

DROP TABLE IF EXISTS `backup_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_workflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dokument_id` int(11) NOT NULL,
  `prideleno_id` int(10) unsigned DEFAULT NULL,
  `orgjednotka_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `stav_dokumentu` int(11) NOT NULL DEFAULT '0',
  `stav_osoby` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=neprirazen,1=prirazen,2=dokoncen,100>storno',
  `date` datetime NOT NULL,
  `poznamka` text,
  `date_predani` datetime DEFAULT NULL,
  `aktivni` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_workflow`
--

LOCK TABLES `backup_workflow` WRITE;
/*!40000 ALTER TABLE `backup_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cislo_jednaci`
--

DROP TABLE IF EXISTS `cislo_jednaci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cislo_jednaci` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `podaci_denik` varchar(80) NOT NULL DEFAULT 'default',
  `rok` year(4) NOT NULL,
  `poradove_cislo` int(11) DEFAULT NULL,
  `urad_zkratka` varchar(50) DEFAULT NULL,
  `urad_poradi` int(11) DEFAULT NULL,
  `orgjednotka_id` int(10) unsigned DEFAULT NULL,
  `org_poradi` int(11) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `user_poradi` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cislo_jednaci__orgjednotka` (`orgjednotka_id`),
  KEY `cislo_jednaci__user` (`user_id`),
  CONSTRAINT `cislo_jednaci__orgjednotka` FOREIGN KEY (`orgjednotka_id`) REFERENCES `orgjednotka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cislo_jednaci__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cislo_jednaci`
--

LOCK TABLES `cislo_jednaci` WRITE;
/*!40000 ALTER TABLE `cislo_jednaci` DISABLE KEYS */;
/*!40000 ALTER TABLE `cislo_jednaci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dokument`
--

DROP TABLE IF EXISTS `dokument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dokument` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dokument_typ_id` int(11) NOT NULL,
  `zpusob_doruceni_id` int(10) unsigned DEFAULT NULL,
  `cislo_jednaci_id` int(11) DEFAULT NULL,
  `zpusob_vyrizeni_id` int(10) unsigned DEFAULT NULL,
  `spousteci_udalost_id` int(11) DEFAULT NULL,
  `spis_id` int(11) DEFAULT NULL,
  `jid` varchar(100) NOT NULL,
  `nazev` varchar(100) NOT NULL,
  `popis` text,
  `cislo_jednaci` varchar(50) DEFAULT NULL,
  `poradi` smallint(6) NOT NULL DEFAULT '1',
  `cislo_jednaci_odesilatele` varchar(50) DEFAULT NULL,
  `podaci_denik` varchar(45) DEFAULT NULL,
  `podaci_denik_poradi` int(11) DEFAULT NULL,
  `podaci_denik_rok` year(4) DEFAULT NULL,
  `spisovy_znak_id` int(11) DEFAULT NULL,
  `skartacni_znak` enum('A','S','V') DEFAULT NULL,
  `skartacni_lhuta` int(11) DEFAULT NULL,
  `poznamka` text,
  `lhuta` smallint(6) NOT NULL DEFAULT '30',
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime DEFAULT NULL,
  `user_created` int(10) unsigned NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_modified` int(10) unsigned DEFAULT NULL,
  `datum_vzniku` datetime NOT NULL,
  `pocet_listu` int(11) DEFAULT NULL,
  `pocet_listu_priloh` int(11) DEFAULT NULL,
  `nelistinne_prilohy` varchar(150) DEFAULT NULL,
  `vyrizeni_pocet_listu` int(11) DEFAULT NULL,
  `vyrizeni_pocet_priloh` int(11) DEFAULT NULL,
  `vyrizeni_typ_prilohy` varchar(150) DEFAULT NULL,
  `ulozeni_dokumentu` text,
  `datum_vyrizeni` datetime DEFAULT NULL,
  `poznamka_vyrizeni` text,
  `datum_spousteci_udalosti` date DEFAULT NULL,
  `cislo_doporuceneho_dopisu` varchar(150) DEFAULT NULL,
  `owner_user_id` int(10) unsigned NOT NULL,
  `owner_orgunit_id` int(10) unsigned DEFAULT NULL,
  `is_forwarded` bit(1) NOT NULL DEFAULT b'0',
  `forward_user_id` int(10) unsigned DEFAULT NULL,
  `forward_orgunit_id` int(10) unsigned DEFAULT NULL,
  `forward_note` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dokument__cislo_jednaci` (`cislo_jednaci_id`),
  KEY `dokument__dokument_typ` (`dokument_typ_id`),
  KEY `dokument__user1` (`forward_user_id`),
  KEY `dokument__orgjednotka1` (`forward_orgunit_id`),
  KEY `dokument__user2` (`owner_user_id`),
  KEY `dokument__orgjednotka2` (`owner_orgunit_id`),
  KEY `dokument__spisovy_znak` (`spisovy_znak_id`),
  KEY `dokument__spousteci_udalost` (`spousteci_udalost_id`),
  KEY `dokument__user3` (`user_created`),
  KEY `dokument__user4` (`user_modified`),
  KEY `dokument__zpusob_doruceni` (`zpusob_doruceni_id`),
  KEY `dokument__zpusob_vyrizeni` (`zpusob_vyrizeni_id`),
  KEY `dokument__spis` (`spis_id`),
  CONSTRAINT `dokument__spis` FOREIGN KEY (`spis_id`) REFERENCES `spis` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__cislo_jednaci` FOREIGN KEY (`cislo_jednaci_id`) REFERENCES `cislo_jednaci` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__dokument_typ` FOREIGN KEY (`dokument_typ_id`) REFERENCES `dokument_typ` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__orgjednotka1` FOREIGN KEY (`forward_orgunit_id`) REFERENCES `orgjednotka` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `dokument__orgjednotka2` FOREIGN KEY (`owner_orgunit_id`) REFERENCES `orgjednotka` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `dokument__spisovy_znak` FOREIGN KEY (`spisovy_znak_id`) REFERENCES `spisovy_znak` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__spousteci_udalost` FOREIGN KEY (`spousteci_udalost_id`) REFERENCES `spousteci_udalost` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__user1` FOREIGN KEY (`forward_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__user2` FOREIGN KEY (`owner_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__user3` FOREIGN KEY (`user_created`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__user4` FOREIGN KEY (`user_modified`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__zpusob_doruceni` FOREIGN KEY (`zpusob_doruceni_id`) REFERENCES `zpusob_doruceni` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument__zpusob_vyrizeni` FOREIGN KEY (`zpusob_vyrizeni_id`) REFERENCES `zpusob_vyrizeni` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dokument`
--

LOCK TABLES `dokument` WRITE;
/*!40000 ALTER TABLE `dokument` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dokument_odeslani`
--

DROP TABLE IF EXISTS `dokument_odeslani`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dokument_odeslani` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dokument_id` int(11) NOT NULL,
  `subjekt_id` int(11) NOT NULL,
  `zpusob_odeslani_id` int(10) unsigned NOT NULL,
  `epodatelna_id` int(11) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `datum_odeslani` datetime NOT NULL,
  `zprava` text,
  `druh_zasilky` varchar(200) DEFAULT NULL,
  `cena` float DEFAULT NULL,
  `hmotnost` float DEFAULT NULL,
  `cislo_faxu` varchar(100) DEFAULT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  `poznamka` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stav` (`stav`),
  KEY `dokument_odeslani__dokument` (`dokument_id`),
  KEY `dokument_odeslani__epodatelna` (`epodatelna_id`),
  KEY `dokument_odeslani__subjekt` (`subjekt_id`),
  KEY `dokument_odeslani__user` (`user_id`),
  KEY `dokument_odeslani__zpusob_odeslani` (`zpusob_odeslani_id`),
  CONSTRAINT `dokument_odeslani__dokument` FOREIGN KEY (`dokument_id`) REFERENCES `dokument` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `dokument_odeslani__epodatelna` FOREIGN KEY (`epodatelna_id`) REFERENCES `epodatelna` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument_odeslani__subjekt` FOREIGN KEY (`subjekt_id`) REFERENCES `subjekt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument_odeslani__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument_odeslani__zpusob_odeslani` FOREIGN KEY (`zpusob_odeslani_id`) REFERENCES `zpusob_odeslani` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dokument_odeslani`
--

LOCK TABLES `dokument_odeslani` WRITE;
/*!40000 ALTER TABLE `dokument_odeslani` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokument_odeslani` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dokument_to_file`
--

DROP TABLE IF EXISTS `dokument_to_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dokument_to_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dokument_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dokument_to_file__dokument` (`dokument_id`),
  KEY `dokument_to_file__file` (`file_id`),
  KEY `dokument_to_file__user` (`user_id`),
  CONSTRAINT `dokument_to_file__dokument` FOREIGN KEY (`dokument_id`) REFERENCES `dokument` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `dokument_to_file__file` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument_to_file__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dokument_to_file`
--

LOCK TABLES `dokument_to_file` WRITE;
/*!40000 ALTER TABLE `dokument_to_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokument_to_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dokument_to_subjekt`
--

DROP TABLE IF EXISTS `dokument_to_subjekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dokument_to_subjekt` (
  `dokument_id` int(11) NOT NULL,
  `subjekt_id` int(11) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `typ` enum('A','O','AO') NOT NULL DEFAULT 'AO',
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`dokument_id`,`subjekt_id`),
  KEY `dokument_to_subjekt__subjekt` (`subjekt_id`),
  KEY `dokument_to_subjekt__user` (`user_id`),
  CONSTRAINT `dokument_to_subjekt__dokument` FOREIGN KEY (`dokument_id`) REFERENCES `dokument` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `dokument_to_subjekt__subjekt` FOREIGN KEY (`subjekt_id`) REFERENCES `subjekt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dokument_to_subjekt__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dokument_to_subjekt`
--

LOCK TABLES `dokument_to_subjekt` WRITE;
/*!40000 ALTER TABLE `dokument_to_subjekt` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokument_to_subjekt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dokument_typ`
--

DROP TABLE IF EXISTS `dokument_typ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dokument_typ` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(100) NOT NULL,
  `popis` varchar(255) DEFAULT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `smer` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-prichozi, 1-odchozi',
  `podatelna` tinyint(1) NOT NULL DEFAULT '1',
  `referent` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dokument_typ`
--

LOCK TABLES `dokument_typ` WRITE;
/*!40000 ALTER TABLE `dokument_typ` DISABLE KEYS */;
INSERT INTO `dokument_typ` VALUES (1,'příchozí',NULL,1,0,1,0),(2,'vlastní',NULL,1,1,0,1);
/*!40000 ALTER TABLE `dokument_typ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `druh_zasilky`
--

DROP TABLE IF EXISTS `druh_zasilky`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `druh_zasilky` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(150) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `druh_zasilky`
--

LOCK TABLES `druh_zasilky` WRITE;
/*!40000 ALTER TABLE `druh_zasilky` DISABLE KEYS */;
INSERT INTO `druh_zasilky` VALUES (1,'obyčejné',1,10),(2,'doporučené',1,20),(3,'balík',1,40),(4,'do vlastních rukou',1,420),(5,'dodejka',1,410),(6,'cenné psaní',1,30),(7,'cizina',1,60),(8,'EMS',1,50),(9,'dobírka',1,400);
/*!40000 ALTER TABLE `druh_zasilky` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epodatelna`
--

DROP TABLE IF EXISTS `epodatelna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epodatelna` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dokument_id` int(11) DEFAULT NULL,
  `subjekt_id` int(11) DEFAULT NULL,
  `file_id` int(11) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `odchozi` bit(1) NOT NULL DEFAULT b'0',
  `typ` char(1) NOT NULL,
  `poradi` int(11) DEFAULT NULL,
  `rok` year(4) DEFAULT NULL,
  `email_id` varchar(200) DEFAULT NULL,
  `isds_id` varchar(45) DEFAULT NULL,
  `predmet` varchar(200) NOT NULL DEFAULT '',
  `popis` text,
  `odesilatel` varchar(200) NOT NULL DEFAULT '',
  `adresat` varchar(100) NOT NULL DEFAULT '',
  `prijato_dne` datetime DEFAULT NULL,
  `doruceno_dne` datetime DEFAULT NULL,
  `prilohy` text,
  `identifikator` text,
  `evidence` varchar(100) DEFAULT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '0',
  `stav_info` varchar(255) DEFAULT NULL,
  `email_signed` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stav` (`stav`),
  KEY `odchozi` (`odchozi`),
  KEY `epodatelna__dokument` (`dokument_id`),
  KEY `epodatelna__file` (`file_id`),
  KEY `epodatelna__subjekt` (`subjekt_id`),
  KEY `epodatelna__user` (`user_id`),
  CONSTRAINT `epodatelna__dokument` FOREIGN KEY (`dokument_id`) REFERENCES `dokument` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `epodatelna__file` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `epodatelna__subjekt` FOREIGN KEY (`subjekt_id`) REFERENCES `subjekt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `epodatelna__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epodatelna`
--

LOCK TABLES `epodatelna` WRITE;
/*!40000 ALTER TABLE `epodatelna` DISABLE KEYS */;
/*!40000 ALTER TABLE `epodatelna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `nazev` varchar(255) NOT NULL COMMENT 'jmeno souboru nebo nazev',
  `popis` varchar(255) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL COMMENT 'mime typ souboru',
  `real_name` varchar(255) NOT NULL COMMENT 'skutečné jmeno souboru file.ext',
  `real_path` varchar(255) NOT NULL COMMENT 'realna cesta k souboru ',
  `date_created` datetime DEFAULT NULL,
  `user_created` int(10) unsigned NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_modified` int(10) unsigned NOT NULL,
  `guid` varchar(45) NOT NULL COMMENT 'jednoznacny identifikator',
  `md5_hash` varchar(45) NOT NULL COMMENT 'otisk souboru pro overeni pravosti',
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `file__user1` (`user_created`),
  KEY `file__user2` (`user_modified`),
  CONSTRAINT `file__user1` FOREIGN KEY (`user_created`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `file__user2` FOREIGN KEY (`user_modified`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_historie`
--

DROP TABLE IF EXISTS `file_historie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_historie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `typ` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'typ prilohy. Defaultne: (1)main, (2)enclosure, (3)signature, (4)meta, (5)source',
  `nazev` varchar(255) NOT NULL COMMENT 'jmeno souboru nebo nazev',
  `popis` varchar(45) DEFAULT NULL,
  `mime_type` varchar(60) DEFAULT NULL COMMENT 'mime typ souboru',
  `real_name` varchar(255) NOT NULL COMMENT 'skutečné jmeno souboru file.ext',
  `real_path` varchar(255) NOT NULL COMMENT 'realna cesta k souboru ',
  `real_type` varchar(45) NOT NULL DEFAULT 'FILE' COMMENT 'typ fyzickeho mista. Default FILE - lokalni fyzicke misto',
  `date_created` datetime DEFAULT NULL,
  `user_created` int(10) unsigned NOT NULL,
  `guid` varchar(45) NOT NULL COMMENT 'jednoznacny identifikator',
  `md5_hash` varchar(45) NOT NULL COMMENT 'otisk souboru pro overeni pravosti',
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `file_historie__file` (`file_id`),
  KEY `file_historie__user` (`user_created`),
  CONSTRAINT `file_historie__file` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `file_historie__user` FOREIGN KEY (`user_created`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_historie`
--

LOCK TABLES `file_historie` WRITE;
/*!40000 ALTER TABLE `file_historie` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_historie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_access`
--

DROP TABLE IF EXISTS `log_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `user_agent` varchar(200) DEFAULT NULL,
  `stav` tinyint(4) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_access__user` (`user_id`),
  CONSTRAINT `log_access__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_access`
--

LOCK TABLES `log_access` WRITE;
/*!40000 ALTER TABLE `log_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_dokument`
--

DROP TABLE IF EXISTS `log_dokument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_dokument` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dokument_id` int(11) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `typ` tinyint(4) NOT NULL,
  `poznamka` text,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_dokument__dokument` (`dokument_id`),
  KEY `log_dokument__user` (`user_id`),
  CONSTRAINT `log_dokument__dokument` FOREIGN KEY (`dokument_id`) REFERENCES `dokument` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `log_dokument__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_dokument`
--

LOCK TABLES `log_dokument` WRITE;
/*!40000 ALTER TABLE `log_dokument` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_dokument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_spis`
--

DROP TABLE IF EXISTS `log_spis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_spis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spis_id` int(11) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `typ` tinyint(4) NOT NULL,
  `poznamka` text,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_spis__spis` (`spis_id`),
  KEY `log_spis__user` (`user_id`),
  CONSTRAINT `log_spis__spis` FOREIGN KEY (`spis_id`) REFERENCES `spis` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `log_spis__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_spis`
--

LOCK TABLES `log_spis` WRITE;
/*!40000 ALTER TABLE `log_spis` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_spis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orgjednotka`
--

DROP TABLE IF EXISTS `orgjednotka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orgjednotka` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `plny_nazev` varchar(200) DEFAULT NULL,
  `zkraceny_nazev` varchar(100) NOT NULL,
  `ciselna_rada` varchar(30) NOT NULL,
  `note` varchar(2000) DEFAULT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `user_created` int(10) unsigned NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_modified` int(10) unsigned NOT NULL,
  `sekvence` varchar(150) NOT NULL,
  `sekvence_string` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ciselna_rada` (`ciselna_rada`),
  KEY `parent_id` (`parent_id`),
  KEY `orgjednotka__user1` (`user_created`),
  KEY `orgjednotka__user2` (`user_modified`),
  CONSTRAINT `orgjednotka__user1` FOREIGN KEY (`user_created`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orgjednotka__user2` FOREIGN KEY (`user_modified`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orgjednotka`
--

LOCK TABLES `orgjednotka` WRITE;
/*!40000 ALTER TABLE `orgjednotka` DISABLE KEYS */;
/*!40000 ALTER TABLE `orgjednotka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osoba`
--

DROP TABLE IF EXISTS `osoba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osoba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prijmeni` varchar(255) NOT NULL,
  `jmeno` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `titul_pred` varchar(50) DEFAULT NULL,
  `titul_za` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `pozice` varchar(50) DEFAULT NULL,
  `stav` tinyint(4) NOT NULL,
  `date_created` datetime NOT NULL,
  `user_created` int(10) unsigned DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_modified` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `osoba__user1` (`user_created`),
  KEY `osoba__user2` (`user_modified`),
  CONSTRAINT `osoba__user1` FOREIGN KEY (`user_created`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `osoba__user2` FOREIGN KEY (`user_modified`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osoba`
--

LOCK TABLES `osoba` WRITE;
/*!40000 ALTER TABLE `osoba` DISABLE KEYS */;
/*!40000 ALTER TABLE `osoba` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sestava`
--

DROP TABLE IF EXISTS `sestava`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sestava` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(60) NOT NULL,
  `popis` varchar(150) DEFAULT NULL,
  `parametry` varchar(4000) DEFAULT NULL,
  `sloupce` varchar(1000) NOT NULL,
  `typ` tinyint(4) NOT NULL DEFAULT '1',
  `filtr` bit(1) NOT NULL DEFAULT b'0',
  `seradit` varchar(50) DEFAULT NULL,
  `zobrazeni_dat` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sestava`
--

LOCK TABLES `sestava` WRITE;
/*!40000 ALTER TABLE `sestava` DISABLE KEYS */;
INSERT INTO `sestava` VALUES (1,'Podací deník',NULL,NULL,'smer,cislo_jednaci,spis,datum_vzniku,subjekty,cislo_jednaci_odesilatele,pocet_listu,pocet_listu_priloh,pocet_souboru,nazev,vyridil,zpusob_vyrizeni,datum_odeslani,spisovy_znak,skartacni_znak,skartacni_lhuta,zaznam_vyrazeni',2,'',NULL,NULL);
/*!40000 ALTER TABLE `sestava` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `name` varchar(50) CHARACTER SET ascii NOT NULL,
  `value` varchar(2000) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('db_revision','1450'),('db_tables_renamed','true'),('epodatelna_auto_load_new_messages','true'),('epodatelna_copy_email_into_documents_note','true'),('notification_enabled_receive_document','true'),('spisovna_display_borrowed_documents','true'),('upgrade_needed','false'),('users_can_change_their_data','true');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `souvisejici_dokument`
--

DROP TABLE IF EXISTS `souvisejici_dokument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `souvisejici_dokument` (
  `dokument_id` int(11) NOT NULL,
  `spojit_s_id` int(11) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`dokument_id`,`spojit_s_id`),
  KEY `souvisejici_dokument__dokument2` (`spojit_s_id`),
  KEY `souvisejici_dokument__user` (`user_id`),
  CONSTRAINT `souvisejici_dokument__dokument1` FOREIGN KEY (`dokument_id`) REFERENCES `dokument` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `souvisejici_dokument__dokument2` FOREIGN KEY (`spojit_s_id`) REFERENCES `dokument` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `souvisejici_dokument__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `souvisejici_dokument`
--

LOCK TABLES `souvisejici_dokument` WRITE;
/*!40000 ALTER TABLE `souvisejici_dokument` DISABLE KEYS */;
/*!40000 ALTER TABLE `souvisejici_dokument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spis`
--

DROP TABLE IF EXISTS `spis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `spousteci_udalost_id` int(11) DEFAULT NULL,
  `spisovy_znak_id` int(10) DEFAULT NULL,
  `nazev` varchar(80) NOT NULL,
  `popis` varchar(200) NOT NULL,
  `typ` char(1) CHARACTER SET ascii NOT NULL DEFAULT 'S',
  `sekvence` varchar(150) NOT NULL,
  `sekvence_string` varchar(1000) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  `user_created` int(10) unsigned DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_modified` int(10) unsigned DEFAULT NULL,
  `skartacni_znak` enum('A','S','V') DEFAULT NULL,
  `skartacni_lhuta` int(11) DEFAULT NULL,
  `datum_uzavreni` datetime DEFAULT NULL,
  `orgjednotka_id` int(10) unsigned DEFAULT NULL,
  `orgjednotka_id_predano` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nazev` (`nazev`),
  KEY `spisovy_znak_id` (`spisovy_znak_id`),
  KEY `orgjednotka_id` (`orgjednotka_id`),
  KEY `orgjednotka_id_predano` (`orgjednotka_id_predano`),
  KEY `typ` (`typ`),
  KEY `stav` (`stav`),
  KEY `spis__spousteci_udalost` (`spousteci_udalost_id`),
  KEY `spis__user1` (`user_created`),
  KEY `spis__user2` (`user_modified`),
  CONSTRAINT `spis__orgjednotka1` FOREIGN KEY (`orgjednotka_id`) REFERENCES `orgjednotka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `spis__orgjednotka2` FOREIGN KEY (`orgjednotka_id_predano`) REFERENCES `orgjednotka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `spis__spousteci_udalost` FOREIGN KEY (`spousteci_udalost_id`) REFERENCES `spousteci_udalost` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `spis__user1` FOREIGN KEY (`user_created`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `spis__user2` FOREIGN KEY (`user_modified`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `spis__spisovy_znak` FOREIGN KEY (`spisovy_znak_id`) REFERENCES `spisovy_znak` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spis`
--

LOCK TABLES `spis` WRITE;
/*!40000 ALTER TABLE `spis` DISABLE KEYS */;
/*!40000 ALTER TABLE `spis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spisovy_znak`
--

DROP TABLE IF EXISTS `spisovy_znak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spisovy_znak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `nazev` varchar(80) NOT NULL,
  `popis` varchar(200) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `sekvence` varchar(150) NOT NULL,
  `sekvence_string` varchar(1000) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_created` int(11) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_modified` int(11) DEFAULT NULL,
  `skartacni_znak` enum('A','S','V') DEFAULT NULL,
  `skartacni_lhuta` int(11) DEFAULT NULL,
  `spousteci_udalost_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nazev` (`nazev`),
  KEY `spisovy_znak__spousteci_udalost` (`spousteci_udalost_id`),
  KEY `spisovy_znak__spisovy_znak` (`parent_id`),
  CONSTRAINT `spisovy_znak__spousteci_udalost` FOREIGN KEY (`spousteci_udalost_id`) REFERENCES `spousteci_udalost` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `spisovy_znak__spisovy_znak` FOREIGN KEY (`parent_id`) REFERENCES `spisovy_znak` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spisovy_znak`
--

LOCK TABLES `spisovy_znak` WRITE;
/*!40000 ALTER TABLE `spisovy_znak` DISABLE KEYS */;
/*!40000 ALTER TABLE `spisovy_znak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spousteci_udalost`
--

DROP TABLE IF EXISTS `spousteci_udalost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spousteci_udalost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(600) NOT NULL,
  `poznamka` varchar(2000) DEFAULT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `poznamka_k_datumu` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spousteci_udalost`
--

LOCK TABLES `spousteci_udalost` WRITE;
/*!40000 ALTER TABLE `spousteci_udalost` DISABLE KEYS */;
INSERT INTO `spousteci_udalost` VALUES (1,'Skartační lhůta začíná plynout po ztrátě platnosti dokumentu.',NULL,1,'ukončení platnosti dokumentu'),(2,'Skartační lhůta začíná plynout po ukončení záruky.',NULL,1,'ukončení záruky'),(3,'Skartační lhůta začíná plynout po uzavření dokumentu.',NULL,2,'uzavření/vyřízení dokumentu'),(4,'Skartační lhůta počíná plynout po zařazení dokumentů z předávacích protokolů do skartačního řízení (předávací protokoly).',NULL,1,'zařazení dokumentů'),(5,'Skartační lhůta začíná plynout po vyhodnocení dokumentu (Podkladový materiál k výkazům).',NULL,1,'vyhotovení dokumentu'),(6,'Skartační lhůta začíná běžet po roce, v němž byla výpočetní a jiná technika naposledy použita, nebo po ukončení používání příslušného software (Provozní dokumentace, licence).',NULL,1,'posledního použití nebo ukončení použití'),(7,'Skartační lhůta začíná plynout po vyhlášení výsledků voleb.',NULL,1,'vyhlášení výsledku voleb'),(8,'Skartační lhůta začíná plynout po zrušení zařízení.',NULL,1,'zrušení zařízení'),(9,'Nabytí účinnosti.',NULL,1,'nabytí účinnosti'),(10,'Rozhodnutí, nabytí právní moci.',NULL,1,'rozhodnutí'),(11,'Uvedení objektu do provozu.',NULL,1,'uvedení objektu do provozu'),(12,'Ukončení studia.',NULL,1,'ukončení studia'),(13,'Ukončení pobytu.',NULL,1,'ukončení pobytu'),(14,'Ukončení pracovního/služebního poměru.',NULL,1,'ukončení pracovního/služebního poměru'),(15,'Skartační lhůta u dokumentů celostátně vyhlášeného referenda začíná plynout po vyhlášení výsledků referenda prezidentem republiky ve Sbírce zákonů, popřípadě po vyhlášení nálezu Ústavního soudu, kterým rozhodl, že postup při provádění referenda nebyl v souladu s ústavním zákonem o referendu o přistoupení České republiky k Evropské unii nebo zákonem vydaným k jeho provedení s povinností zachování tří nepoužitých hlasovacích lístků pro referendum pro uložení v příslušném archivu.',NULL,1,'vyhlášení výsledků referenda'),(16,'Skartační lhůta u dokumentů krajského referenda začíná plynout po vyhlášení výsledků referenda s povinností zachování tří nepoužitých hlasovacích lístků pro referendum pro uložení v příslušném archivu.',NULL,1,'vyhlášení výsledků referenda');
/*!40000 ALTER TABLE `spousteci_udalost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stat`
--

DROP TABLE IF EXISTS `stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(150) NOT NULL,
  `kod` varchar(5) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `kod` (`kod`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stat`
--

LOCK TABLES `stat` WRITE;
/*!40000 ALTER TABLE `stat` DISABLE KEYS */;
INSERT INTO `stat` VALUES (1,'Česká republika','CZE',1),(2,'Slovenská republika','SVK',1),(3,'Islámská republika Afghánistán','AFG',0),(4,'Albánská republika','ALB',0),(5,'Antarktida','ATA',0),(6,'Alžírská demokratická a lidová republika','DZA',0),(7,'Americká Samoa','ASM',0),(8,'Andorrské knížectví','AND',0),(9,'Angolská republika','AGO',0),(10,'Antigua a Barbuda','ATG',0),(11,'Ázerbájdžánská republika','AZE',0),(12,'Argentinská republika','ARG',0),(13,'Austrálie','AUS',0),(14,'Rakouská republika','AUT',0),(15,'Bahamské společenství','BHS',0),(16,'Království Bahrajn','BHR',0),(17,'Bangladéšská lidová republika','BGD',0),(18,'Arménská republika','ARM',0),(19,'Barbados','BRB',0),(20,'Belgické království','BEL',0),(21,'Bermudy','BMU',0),(22,'Bhútánské království','BTN',0),(23,'Mnohonárodní stát Bolívie','BOL',0),(24,'Bosna a Hercegovina','BIH',0),(25,'Republika Botswana','BWA',0),(26,'Bouvetův ostrov','BVT',0),(27,'Brazilská federativní republika','BRA',0),(28,'Belize','BLZ',0),(29,'Britské indickooceánské území','IOT',0),(30,'Šalomounovy ostrovy','SLB',0),(31,'Britské Panenské ostrovy','VGB',0),(32,'Republika Kosovo','XKO',0),(33,'Brunej Darussalam','BRN',0),(34,'Bulharská republika','BGR',0),(35,'Republika Myanmarský svaz','MMR',0),(36,'Republika Burundi','BDI',0),(37,'Běloruská republika','BLR',0),(38,'Kambodžské království','KHM',0),(39,'Kamerunská republika','CMR',0),(40,'Kanada','CAN',0),(41,'Kapverdská republika','CPV',0),(42,'Kajmanské ostrovy','CYM',0),(43,'Středoafrická republika','CAF',0),(44,'Srílanská demokratická socialistická republika','LKA',0),(45,'Čadská republika','TCD',0),(46,'Chilská republika','CHL',0),(47,'Čínská lidová republika','CHN',0),(48,'Tchaj-wan (čínská provincie)','TWN',0),(49,'Vánoční ostrov','CXR',0),(50,'Kokosové (Keelingovy) ostrovy','CCK',0),(51,'Kolumbijská republika','COL',0),(52,'Komorský svaz','COM',0),(53,'Mayotte','MYT',0),(54,'Konžská republika','COG',0),(55,'Demokratická republika Kongo','COD',0),(56,'Cookovy ostrovy','COK',0),(57,'Kostarická republika','CRI',0),(58,'Chorvatská republika','HRV',0),(59,'Kubánská republika','CUB',0),(60,'Kyperská republika','CYP',0),(61,'Beninská republika','BEN',0),(62,'Dánské království','DNK',0),(63,'Dominické společenství','DMA',0),(64,'Dominikánská republika','DOM',0),(65,'Ekvádorská republika','ECU',0),(66,'Salvadorská republika','SLV',0),(67,'Republika Rovníková Guinea','GNQ',0),(68,'Etiopská federativní demokratická republika','ETH',0),(69,'Eritrea','ERI',0),(70,'Estonská republika','EST',0),(71,'Faerské ostrovy','FRO',0),(72,'Falklandské ostrovy (Malvíny)','FLK',0),(73,'Jižní Georgie a Jižní Sandwichovy ostrovy','SGS',0),(74,'Fidžijská republika','FJI',0),(75,'Finská republika','FIN',0),(76,'Alandské ostrovy','ALA',0),(77,'Francouzská republika','FRA',0),(78,'Francouzská Guyana','GUF',0),(79,'Francouzská Polynésie','PYF',0),(80,'Francouzská jižní území','ATF',0),(81,'Džibutská republika','DJI',0),(82,'Gabonská republika','GAB',0),(83,'Gruzie','GEO',0),(84,'Gambijská republika','GMB',0),(85,'Okupované palestinské území','PSE',0),(86,'Spolková republika Německo','DEU',0),(87,'Ghanská republika','GHA',0),(88,'Gibraltar','GIB',0),(89,'Republika Kiribati','KIR',0),(90,'Řecká republika','GRC',0),(91,'Grónsko','GRL',0),(92,'Grenada','GRD',0),(93,'Guadeloupe','GLP',0),(94,'Guam','GUM',0),(95,'Guatemalská republika','GTM',0),(96,'Guinejská republika','GIN',0),(97,'Guyanská republika','GUY',0),(98,'Republika Haiti','HTI',0),(99,'Heardův ostrov a McDonaldovy ostrovy','HMD',0),(100,'Svatý stolec (Vatikánský městský stát)','VAT',0),(101,'Honduraská republika','HND',0),(102,'Zvláštní administrativní oblast Číny Hongkong','HKG',0),(103,'Maďarsko','HUN',0),(104,'Islandská republika','ISL',0),(105,'Indická republika','IND',0),(106,'Indonéská republika','IDN',0),(107,'Íránská islámská republika','IRN',0),(108,'Irácká republika','IRQ',0),(109,'Irsko','IRL',0),(110,'Stát Izrael','ISR',0),(111,'Italská republika','ITA',0),(112,'Republika Pobřeží Slonoviny','CIV',0),(113,'Jamajka','JAM',0),(114,'Japonsko','JPN',0),(115,'Republika Kazachstán','KAZ',0),(116,'Jordánské hášimovské království','JOR',0),(117,'Keňská republika','KEN',0),(118,'Korejská lidově demokratická republika','PRK',0),(119,'Korejská republika','KOR',0),(120,'Stát Kuvajt','KWT',0),(121,'Kyrgyzská republika','KGZ',0),(122,'Laoská lidově demokratická republika','LAO',0),(123,'Libanonská republika','LBN',0),(124,'Království Lesotho','LSO',0),(125,'Lotyšská republika','LVA',0),(126,'Liberijská republika','LBR',0),(127,'Libye','LBY',0),(128,'Lichtenštejnské knížectví','LIE',0),(129,'Litevská republika','LTU',0),(130,'Lucemburské velkovévodství','LUX',0),(131,'Zvláštní administrativní oblast Číny Macao','MAC',0),(132,'Madagaskarská republika','MDG',0),(133,'Republika Malawi','MWI',0),(134,'Malajsie','MYS',0),(135,'Maledivská republika','MDV',0),(136,'Republika Mali','MLI',0),(137,'Maltská republika','MLT',0),(138,'Martinik','MTQ',0),(139,'Mauritánská islámská republika','MRT',0),(140,'Mauricijská republika','MUS',0),(141,'Spojené státy mexické','MEX',0),(142,'Monacké knížectví','MCO',0),(143,'Mongolsko','MNG',0),(144,'Moldavská republika','MDA',0),(145,'Černá Hora','MNE',0),(146,'Montserrat','MSR',0),(147,'Marocké království','MAR',0),(148,'Mosambická republika','MOZ',0),(149,'Sultanát Omán','OMN',0),(150,'Namibijská republika','NAM',0),(151,'Republika Nauru','NRU',0),(152,'Nepálská federativní demokratická republika','NPL',0),(153,'Nizozemské království','NLD',0),(154,'Curaçao','CUW',0),(155,'Aruba','ABW',0),(156,'Svatý Martin (nizozemská část)','SXM',0),(157,'Bonaire, Svatý Eustach a Saba','BES',0),(158,'Nová Kaledonie','NCL',0),(159,'Republika Vanuatu','VUT',0),(160,'Nový Zéland','NZL',0),(161,'Nikaragujská republika','NIC',0),(162,'Nigerská republika','NER',0),(163,'Nigerijská federativní republika','NGA',0),(164,'Niue','NIU',0),(165,'Ostrov Norfolk','NFK',0),(166,'Norské království','NOR',0),(167,'Společenství Ostrovy Severní Mariany','MNP',0),(168,'Menší odlehlé ostrovy USA','UMI',0),(169,'Federativní státy Mikronésie','FSM',0),(170,'Republika Marshallovy ostrovy','MHL',0),(171,'Republika Palau','PLW',0),(172,'Pákistánská islámská republika','PAK',0),(173,'Panamská republika','PAN',0),(174,'Papua Nová Guinea','PNG',0),(175,'Paraguayská republika','PRY',0),(176,'Peruánská republika','PER',0),(177,'Filipínská republika','PHL',0),(178,'Pitcairn','PCN',0),(179,'Polská republika','POL',0),(180,'Portugalská republika','PRT',0),(181,'Republika Guinea-Bissau','GNB',0),(182,'Demokratická republika Východní Timor','TLS',0),(183,'Portoriko','PRI',0),(184,'Stát Katar','QAT',0),(185,'Réunion','REU',0),(186,'Rumunsko','ROU',0),(187,'Ruská federace','RUS',0),(188,'Republika Rwanda','RWA',0),(189,'Svatý Bartoloměj','BLM',0),(190,'Svatá Helena, Ascension a Tristan da Cunha','SHN',0),(191,'Svatý Kryštof a Nevis','KNA',0),(192,'Anguilla','AIA',0),(193,'Svatá Lucie','LCA',0),(194,'Svatý Martin (francouzská část)','MAF',0),(195,'Saint Pierre a Miquelon','SPM',0),(196,'Svatý Vincenc a Grenadiny','VCT',0),(197,'Republika San Marino','SMR',0),(198,'Demokratická republika Svatý Tomáš a Princův ostrov','STP',0),(199,'Království Saúdská Arábie','SAU',0),(200,'Senegalská republika','SEN',0),(201,'Republika Srbsko','SRB',0),(202,'Seychelská republika','SYC',0),(203,'Republika Sierra Leone','SLE',0),(204,'Singapurská republika','SGP',0),(205,'Vietnamská socialistická republika','VNM',0),(206,'Slovinská republika','SVN',0),(207,'Somálská republika','SOM',0),(208,'Jihoafrická republika','ZAF',0),(209,'Republika Zimbabwe','ZWE',0),(210,'Španělské království','ESP',0),(211,'Jihosúdánská republika','SSD',0),(212,'Súdánská republika','SDN',0),(213,'Západní Sahara','ESH',0),(214,'Surinamská republika','SUR',0),(215,'Svalbard a Jan Mayen','SJM',0),(216,'Svazijské království','SWZ',0),(217,'Švédské království','SWE',0),(218,'Švýcarská konfederace','CHE',0),(219,'Syrská arabská republika','SYR',0),(220,'Republika Tádžikistán','TJK',0),(221,'Thajské království','THA',0),(222,'Republika Togo','TGO',0),(223,'Tokelau','TKL',0),(224,'Království Tonga','TON',0),(225,'Republika Trinidad a Tobago','TTO',0),(226,'Spojené arabské emiráty','ARE',0),(227,'Tuniská republika','TUN',0),(228,'Turecká republika','TUR',0),(229,'Turkmenistán','TKM',0),(230,'Ostrovy Turks a Caicos','TCA',0),(231,'Tuvalu','TUV',0),(232,'Ugandská republika','UGA',0),(233,'Ukrajina','UKR',0),(234,'Bývalá jugoslávská republika Makedonie','MKD',0),(235,'Egyptská arabská republika','EGY',0),(236,'Spojené království Velké Británie a Severního Irska','GBR',0),(237,'Guernsey','GGY',0),(238,'Jersey','JEY',0),(239,'Ostrov Man','IMN',0),(240,'Tanzanská sjednocená republika','TZA',0),(241,'Spojené státy americké','USA',0),(242,'Americké Panenské ostrovy','VIR',0),(243,'Burkina Faso','BFA',0),(244,'Uruguayská východní republika','URY',0),(245,'Republika Uzbekistán','UZB',0),(246,'Bolívarovská republika Venezuela','VEN',0),(247,'Ostrovy Wallis a Futuna','WLF',0),(248,'Nezávislý stát Samoa','WSM',0),(249,'Jemenská republika','YEM',0),(250,'Zambijská republika','ZMB',0);
/*!40000 ALTER TABLE `stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjekt`
--

DROP TABLE IF EXISTS `subjekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjekt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `type` varchar(15) NOT NULL,
  `ic` varchar(8) DEFAULT NULL,
  `dic` varchar(12) DEFAULT NULL,
  `nazev_subjektu` varchar(255) DEFAULT NULL,
  `jmeno` varchar(24) DEFAULT NULL,
  `prijmeni` varchar(35) DEFAULT NULL,
  `prostredni_jmeno` varchar(35) DEFAULT NULL,
  `titul_pred` varchar(35) DEFAULT NULL,
  `titul_za` varchar(10) DEFAULT NULL,
  `rodne_jmeno` varchar(35) DEFAULT NULL,
  `datum_narozeni` date DEFAULT NULL,
  `misto_narozeni` varchar(48) DEFAULT NULL,
  `okres_narozeni` varchar(48) DEFAULT NULL,
  `stat_narozeni` varchar(3) DEFAULT NULL,
  `adresa_mesto` varchar(48) DEFAULT NULL,
  `adresa_ulice` varchar(48) DEFAULT NULL,
  `adresa_cp` varchar(10) DEFAULT NULL,
  `adresa_co` varchar(10) DEFAULT NULL,
  `adresa_psc` varchar(10) DEFAULT NULL,
  `adresa_stat` varchar(3) DEFAULT NULL,
  `narodnost` varchar(80) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `telefon` varchar(150) DEFAULT NULL,
  `id_isds` varchar(50) DEFAULT NULL,
  `poznamka` varchar(4000) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_created` int(10) unsigned NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `user_modified` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subjekt__user1` (`user_created`),
  KEY `subjekt__user2` (`user_modified`),
  CONSTRAINT `subjekt__user1` FOREIGN KEY (`user_created`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `subjekt__user2` FOREIGN KEY (`user_modified`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjekt`
--

LOCK TABLES `subjekt` WRITE;
/*!40000 ALTER TABLE `subjekt` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjekt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(4) NOT NULL,
  `osoba_id` int(11) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `last_ip` varchar(15) DEFAULT NULL,
  `external_auth` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `orgjednotka_id` int(10) unsigned DEFAULT NULL,
  `force_logout` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `USERNAME` (`username`),
  KEY `user__orgjednotka` (`orgjednotka_id`),
  KEY `user__osoba` (`osoba_id`),
  CONSTRAINT `user__orgjednotka` FOREIGN KEY (`orgjednotka_id`) REFERENCES `orgjednotka` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `user__osoba` FOREIGN KEY (`osoba_id`) REFERENCES `osoba` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_settings` (
  `id` int(10) unsigned NOT NULL,
  `settings` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_settings__user` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_to_role`
--

DROP TABLE IF EXISTS `user_to_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_to_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_to_role__user` (`user_id`),
  KEY `user_to_role__acl_role` (`role_id`),
  CONSTRAINT `user_to_role__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `user_to_role__acl_role` FOREIGN KEY (`role_id`) REFERENCES `acl_role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_to_role`
--

LOCK TABLES `user_to_role` WRITE;
/*!40000 ALTER TABLE `user_to_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_to_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zapujcka`
--

DROP TABLE IF EXISTS `zapujcka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zapujcka` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dokument_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `duvod` varchar(1000) DEFAULT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `date_od` date NOT NULL,
  `date_do` date DEFAULT NULL,
  `date_do_skut` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dokument_id` (`dokument_id`),
  KEY `user_id` (`user_id`),
  KEY `stav` (`stav`),
  CONSTRAINT `zapujcka__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zapujcka`
--

LOCK TABLES `zapujcka` WRITE;
/*!40000 ALTER TABLE `zapujcka` DISABLE KEYS */;
/*!40000 ALTER TABLE `zapujcka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zpusob_doruceni`
--

DROP TABLE IF EXISTS `zpusob_doruceni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zpusob_doruceni` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazev` varchar(80) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `fixed` tinyint(1) NOT NULL DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `epodatelna` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zpusob_doruceni`
--

LOCK TABLES `zpusob_doruceni` WRITE;
/*!40000 ALTER TABLE `zpusob_doruceni` DISABLE KEYS */;
INSERT INTO `zpusob_doruceni` VALUES (1,'emailem',1,1,NULL,1),(2,'datovou schránkou',1,1,NULL,1),(3,'datovým nosičem',1,1,NULL,0),(4,'faxem',1,1,NULL,0),(5,'v listinné podobě',1,1,NULL,0);
/*!40000 ALTER TABLE `zpusob_doruceni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zpusob_odeslani`
--

DROP TABLE IF EXISTS `zpusob_odeslani`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zpusob_odeslani` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazev` varchar(80) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `fixed` tinyint(4) NOT NULL DEFAULT '0',
  `note` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zpusob_odeslani`
--

LOCK TABLES `zpusob_odeslani` WRITE;
/*!40000 ALTER TABLE `zpusob_odeslani` DISABLE KEYS */;
INSERT INTO `zpusob_odeslani` VALUES (1,'e-mailem',1,1,NULL),(2,'datovou schránkou',1,1,NULL),(3,'poštou',1,1,NULL),(4,'faxem',1,1,''),(5,'osobní převzetí',1,1,'');
/*!40000 ALTER TABLE `zpusob_odeslani` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zpusob_vyrizeni`
--

DROP TABLE IF EXISTS `zpusob_vyrizeni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zpusob_vyrizeni` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazev` varchar(80) NOT NULL,
  `stav` tinyint(4) NOT NULL DEFAULT '1',
  `fixed` tinyint(1) NOT NULL DEFAULT '0',
  `note` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zpusob_vyrizeni`
--

LOCK TABLES `zpusob_vyrizeni` WRITE;
/*!40000 ALTER TABLE `zpusob_vyrizeni` DISABLE KEYS */;
INSERT INTO `zpusob_vyrizeni` VALUES (1,'vyřízení dokumentem',1,1,NULL),(2,'postoupení',1,1,NULL),(3,'vzetí na vědomí',1,1,NULL),(4,'jiný způsob',1,1,'U tohoto způsobu je nutné vždy vyplnit poznámku k vyřízení.');
/*!40000 ALTER TABLE `zpusob_vyrizeni` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-04 16:52:55
