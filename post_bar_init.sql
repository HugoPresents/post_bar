# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.28)
# Database: post_bar_init
# Generation Time: 2012-12-02 13:16:35 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT '分类名',
  `display_name` varchar(45) NOT NULL COMMENT '显示名',
  `description` text NOT NULL COMMENT '分类描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点分类';



# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `post_id` int(10) DEFAULT NULL COMMENT '帖子id',
  `content` text COMMENT '内容',
  `time` int(10) DEFAULT NULL COMMENT '评论时间',
  `thanks` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `comment_user` (`user_id`),
  KEY `comment_post` (`post_id`),
  CONSTRAINT `comment_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帖子评论';



# Dump of table comment_thanks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment_thanks`;

CREATE TABLE `comment_thanks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `comment_id` int(10) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_thanks_1` (`user_id`),
  KEY `fk_comment_thanks_2` (`comment_id`),
  CONSTRAINT `fk_comment_thanks_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_comment_thanks_2` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table money
# ------------------------------------------------------------

DROP TABLE IF EXISTS `money`;

CREATE TABLE `money` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `money_type_id` int(10) NOT NULL COMMENT '收支类型',
  `length` int(10) NOT NULL DEFAULT '0' COMMENT '长度',
  `amount` float NOT NULL DEFAULT '0' COMMENT '金额',
  `balance` float NOT NULL DEFAULT '0' COMMENT '余额',
  `foreign_id` int(11) DEFAULT '0' COMMENT '帖子/评论/用户 id',
  PRIMARY KEY (`id`),
  KEY `money_money_type` (`money_type_id`),
  KEY `money_user` (`user_id`),
  CONSTRAINT `money_money_type` FOREIGN KEY (`money_type_id`) REFERENCES `money_type` (`id`),
  CONSTRAINT `money_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='财富收支表';



# Dump of table money_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `money_option`;

CREATE TABLE `money_option` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全站配置';

LOCK TABLES `money_option` WRITE;
/*!40000 ALTER TABLE `money_option` DISABLE KEYS */;

INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(1,'post_cost','20','发帖基础花费财富'),
	(2,'post_cost_add','1','帖子每增加100字符花费'),
	(3,'post_length','200','帖子基础字符'),
	(4,'comment_length','100','评论基础字符'),
	(5,'comment_cost','5','评论基础花费'),
	(6,'comment_cost_add','1','评论每增加100字花费'),
	(7,'thanks_cost','10','感谢花费');

/*!40000 ALTER TABLE `money_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table money_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `money_type`;

CREATE TABLE `money_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='财富的获取或支出类型';

LOCK TABLES `money_type` WRITE;
/*!40000 ALTER TABLE `money_type` DISABLE KEYS */;

INSERT INTO `money_type` (`id`, `name`, `comment`)
VALUES
	(1,'invite','邀请'),
	(2,'post','主题'),
	(3,'comment','评论'),
	(4,'post_thanks','感谢主题'),
	(5,'comment_thanks','感谢评论');

/*!40000 ALTER TABLE `money_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table node
# ------------------------------------------------------------

DROP TABLE IF EXISTS `node`;

CREATE TABLE `node` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `category_id` int(10) DEFAULT NULL,
  `name` varchar(45) NOT NULL COMMENT '节点名',
  `display_name` varchar(45) NOT NULL COMMENT '显示名',
  `description` text COMMENT '描述',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `node_category` (`category_id`),
  CONSTRAINT `node_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='所有节点';



# Dump of table notify
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notify`;

CREATE TABLE `notify` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `type_id` int(11) unsigned NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `nofity_user` (`user_id`),
  KEY `notify_user_receiver` (`receiver`),
  KEY `notify__notify_type` (`type_id`),
  CONSTRAINT `nofity_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `notify_user_receiver` FOREIGN KEY (`receiver`) REFERENCES `user` (`id`),
  CONSTRAINT `notify__notify_type` FOREIGN KEY (`type_id`) REFERENCES `notify_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table notify_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notify_type`;

CREATE TABLE `notify_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `notify_type` WRITE;
/*!40000 ALTER TABLE `notify_type` DISABLE KEYS */;

INSERT INTO `notify_type` (`id`, `name`, `comment`)
VALUES
	(1,'comment','收到评论'),
	(2,'post_at','在帖子中提及'),
	(3,'comment_at','在回复中提及');

/*!40000 ALTER TABLE `notify_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `node_id` int(10) DEFAULT NULL COMMENT '节点id',
  `title` text NOT NULL COMMENT '标贴',
  `content` text NOT NULL,
  `time` int(10) NOT NULL COMMENT '发帖时间',
  `views` int(10) DEFAULT '0' COMMENT '围观数',
  `comments` int(10) DEFAULT '0' COMMENT '评论数',
  `thanks` int(10) NOT NULL DEFAULT '0',
  `last_update` int(10) DEFAULT NULL COMMENT '最后更新时间（发帖，评论）',
  PRIMARY KEY (`id`),
  KEY `post_user` (`user_id`),
  KEY `post_node` (`node_id`),
  CONSTRAINT `post_node` FOREIGN KEY (`node_id`) REFERENCES `node` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='所有帖子';



# Dump of table post_thanks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `post_thanks`;

CREATE TABLE `post_thanks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `post_id` int(10) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_thanks_1` (`user_id`),
  KEY `fk_post_thanks_2` (`post_id`),
  CONSTRAINT `fk_post_thanks_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_thanks_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table site
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site`;

CREATE TABLE `site` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;

INSERT INTO `site` (`id`, `key`, `value`)
VALUES
	(1,'title','Post Bar你妹'),
	(2,'description','Web.py 的一个贴吧'),
	(3,'cookie_expires','604800'),
	(4,'site_url','127.0.0.1:8888');

/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL COMMENT '邮箱',
  `password` varchar(45) DEFAULT NULL COMMENT '密码',
  `gender` int(1) DEFAULT '1' COMMENT '性别',
  `regist_time` int(10) DEFAULT NULL COMMENT '注册时间',
  `signature` char(100) DEFAULT NULL COMMENT '签名',
  `avatar` varchar(45) DEFAULT NULL COMMENT '头像',
  `outsite_link` text COMMENT '主页',
  `posts` int(10) DEFAULT '0' COMMENT '发表帖子数',
  `money` float DEFAULT '2000' COMMENT '财富',
  `node_favs` int(10) DEFAULT '0' COMMENT '收藏节点数',
  `post_favs` int(10) DEFAULT '0' COMMENT '收藏帖子数',
  `user_favs` int(10) DEFAULT '0' COMMENT '关注成员数',
  `auth` varchar(5) NOT NULL DEFAULT '' COMMENT '组合加密字符串',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户';



# Dump of table user_meta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_meta`;

CREATE TABLE `user_meta` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `meta_key` varchar(50) NOT NULL,
  `meta_value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_meta_user` (`user_id`),
  CONSTRAINT `user_meta_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户扩展表';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
