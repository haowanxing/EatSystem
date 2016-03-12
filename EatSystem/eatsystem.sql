# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.6.19)
# Database: eatsystem
# Generation Time: 2016-03-12 05:38:37 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table admins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `aid` varchar(25) NOT NULL DEFAULT '',
  `aname` varchar(25) NOT NULL DEFAULT '',
  `apwd` varchar(225) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;

INSERT INTO `admins` (`id`, `aid`, `aname`, `apwd`)
VALUES
	(1,'admin','系统管理员','123');

/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table custorms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custorms`;

CREATE TABLE `custorms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` varchar(25) NOT NULL DEFAULT '',
  `cname` varchar(25) NOT NULL DEFAULT '',
  `cpwd` varchar(225) NOT NULL DEFAULT '',
  `cphone` bigint(20) NOT NULL,
  `cmail` varchar(100) NOT NULL,
  `cadr` varchar(250) NOT NULL DEFAULT '无',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cid` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

LOCK TABLES `custorms` WRITE;
/*!40000 ALTER TABLE `custorms` DISABLE KEYS */;

INSERT INTO `custorms` (`id`, `cid`, `cname`, `cpwd`, `cphone`, `cmail`, `cadr`)
VALUES
	(1,'haowanxing','小济同学','123123',13296687974,'york_mail@qq.com','中南民族大学'),
	(3,'admin','管理员','admin',0,'kk','?'),
	(4,'0','???','adadad',0,'kk','无'),
	(6,'','','',0,'','无'),
	(7,'hello','姚康华','0000',13296696714,'无','522');

/*!40000 ALTER TABLE `custorms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table distribution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `distribution`;

CREATE TABLE `distribution` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `disid` varchar(25) NOT NULL DEFAULT '',
  `dispwd` varchar(125) NOT NULL DEFAULT '',
  `disname` varchar(25) NOT NULL DEFAULT '',
  `disphone` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `disid` (`disid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

LOCK TABLES `distribution` WRITE;
/*!40000 ALTER TABLE `distribution` DISABLE KEYS */;

INSERT INTO `distribution` (`id`, `disid`, `dispwd`, `disname`, `disphone`)
VALUES
	(1,'0','','未分配',0),
	(2,'0910','1111','Mr.Luo',13323332323),
	(3,'0911','2222','雷军',15334541231),
	(4,'0912','3333','西门子',13934854333),
	(5,'0913','123456','haowanxing',123456),
	(6,'0914','123123','小康',13321112929);

/*!40000 ALTER TABLE `distribution` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eat_cart
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eat_cart`;

CREATE TABLE `eat_cart` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` varchar(25) NOT NULL DEFAULT '',
  `gid` varchar(50) NOT NULL DEFAULT '',
  `gnum` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `gid` (`gid`),
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `custorms` (`cid`),
  CONSTRAINT `gid` FOREIGN KEY (`gid`) REFERENCES `goods` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table goods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gid` varchar(50) NOT NULL,
  `gname` varchar(50) NOT NULL DEFAULT '',
  `gdesc` varchar(125) NOT NULL DEFAULT '',
  `gpic` varchar(256) NOT NULL DEFAULT 'img/none.jpg',
  `gprice` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gid` (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;

INSERT INTO `goods` (`id`, `gid`, `gname`, `gdesc`, `gpic`, `gprice`)
VALUES
	(1,'1001','无花果干','特价250g只要9块9','img/none.jpg',9.9),
	(2,'1002','蒙古牛肉套餐','牛肉+3素随搭任意选！','img/none.jpg',12),
	(3,'1003','卫龙辣条2','原价￥1.5，特价促销只要￥1.2','img/none.jpg',1.2),
	(4,'1004','酸辣土豆丝','土豆的香,酸酸辣辣的真棒','img/none.jpg',4.5),
	(5,'1005','红烧猪蹄','独家秘制，醇香可口','img/none.jpg',15),
	(6,'1006','手撕包菜','香气扑鼻，精选新鲜蔬菜','img/none.jpg',8),
	(7,'1007','油炸花生米','最棒的下酒菜','img/none.jpg',3.5),
	(8,'1008','小份水果拼盘','西瓜、哈密瓜、火龙果、等','img/none.jpg',16);

/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `oid` varchar(25) NOT NULL DEFAULT '',
  `cid` varchar(25) NOT NULL DEFAULT '',
  `cname` varchar(25) NOT NULL DEFAULT '',
  `gid` varchar(225) NOT NULL DEFAULT '',
  `gnum` int(11) NOT NULL DEFAULT '1',
  `cphone` bigint(20) NOT NULL DEFAULT '0',
  `cadr` varchar(250) NOT NULL DEFAULT '',
  `otime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ostat` int(11) NOT NULL DEFAULT '1',
  `disid` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `distribution` (`disid`),
  KEY `goods` (`gid`),
  KEY `custorms` (`cid`),
  CONSTRAINT `custorms` FOREIGN KEY (`cid`) REFERENCES `custorms` (`cid`),
  CONSTRAINT `distribution` FOREIGN KEY (`disid`) REFERENCES `distribution` (`disid`),
  CONSTRAINT `goods` FOREIGN KEY (`gid`) REFERENCES `goods` (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;

INSERT INTO `orders` (`id`, `oid`, `cid`, `cname`, `gid`, `gnum`, `cphone`, `cadr`, `otime`, `ostat`, `disid`)
VALUES
	(1,'74178672912125662041','haowanxing','','1002',2,0,'','2015-11-19 18:15:04',2,'0'),
	(3,'05971558338614808685','haowanxing','','1004',1,0,'','2015-11-19 18:45:21',5,'0'),
	(4,'61699194545217015299','haowanxing','','1001',1,0,'','2015-11-19 19:30:08',4,'0'),
	(5,'04848092394335349526','haowanxing','','1003',3,0,'','2015-11-19 20:31:04',1,'0'),
	(6,'10488876051884914200','haowanxing','','1001',1,13296687974,'中南民族大学','2015-12-09 11:38:00',2,'0913'),
	(7,'40089282262720337179','haowanxing','小济同学','1004',1,13296687974,'中南民族大学','2015-12-09 13:46:59',1,'0913'),
	(8,'06711989911019020529','haowanxing','小济同学','1003',2,13296687974,'中南民族大学','2015-12-15 08:24:25',3,'0913'),
	(9,'83647173247754287314','hello','姚康华','1001',5,13296696714,'522','2015-12-16 22:46:44',3,'0913'),
	(10,'85481498969429650311','hello','姚康华','1001',1,13296696714,'522','2015-12-17 18:13:00',1,'0');

/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
