-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 09 月 27 日 14:25
-- 服务器版本: 5.5.16
-- PHP 版本: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `post_bar`
--

-- --------------------------------------------------------

--
-- 表的结构 `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT '分类名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='节点分类' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, '测试分类');

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `post_id` int(10) DEFAULT NULL COMMENT '帖子id',
  `content` text COMMENT '内容',
  `time` int(10) DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`),
  KEY `comment_user` (`user_id`),
  KEY `comment_post` (`post_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='帖子评论' AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `comment`
--

INSERT INTO `comment` (`id`, `user_id`, `post_id`, `content`, `time`) VALUES
(1, 2, 1, '测试内容哦！', 1346603234),
(2, 2, 1, '测试内容哦！', 1346603309),
(3, 2, 1, '测试内容哦！', 1346603384),
(4, 2, 1, '测试内容哦！', 1346603396),
(5, 2, 1, '这尼玛什么情况！', 1346603756),
(6, 2, 2, 'SeeOther', 1346603837),
(7, 2, 2, 'SeeOther', 1346603844),
(8, 2, 3, '二哥头吧', 1347693290),
(9, 2, 3, '二哥头吧', 1347694004),
(10, 2, 2, '二哥头吧', 1347694076),
(11, 2, 1, '二哥头吧', 1347694086),
(12, 2, 3, '二国', 1348467126);

-- --------------------------------------------------------

--
-- 表的结构 `node`
--

CREATE TABLE IF NOT EXISTS `node` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `category_id` int(10) DEFAULT NULL,
  `name` varchar(45) NOT NULL COMMENT '节点名',
  `display_name` varchar(45) NOT NULL COMMENT '显示名',
  `description` text COMMENT '描述',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`),
  KEY `node_category` (`category_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='所有节点' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `node`
--

INSERT INTO `node` (`id`, `category_id`, `name`, `display_name`, `description`, `icon`) VALUES
(1, 1, 'test', '测试节点', '测试节点的描述', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `node_id` int(10) DEFAULT NULL COMMENT '节点id',
  `title` text NOT NULL COMMENT '标贴',
  `content` text NOT NULL,
  `time` int(10) NOT NULL COMMENT '发帖时间',
  `views` int(10) DEFAULT '0' COMMENT '围观数',
  `comments` int(10) DEFAULT '0' COMMENT '评论数',
  PRIMARY KEY (`id`),
  KEY `post_user` (`user_id`),
  KEY `post_node` (`node_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='所有帖子' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `post`
--

INSERT INTO `post` (`id`, `user_id`, `node_id`, `title`, `content`, `time`, `views`, `comments`) VALUES
(1, 1, 1, '测试标题', '测试内容哦！', 0, 117, 6),
(2, 1, 1, '测试主题', '测试节点测测试主题', 1346336356, 22, 3),
(3, 2, 1, '用户创建主题', '这是用户创建的主题', 1346424167, 98, 3);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
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
  `node_favs` int(10) DEFAULT '0' COMMENT '收藏节点数',
  `post_favs` int(10) DEFAULT '0' COMMENT '收藏帖子数',
  `user_favs` int(10) DEFAULT '0' COMMENT '关注成员数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`, `gender`, `regist_time`, `signature`, `avatar`, `outsite_link`, `posts`, `node_favs`, `post_favs`, `user_favs`) VALUES
(1, 'Rabbit_52', 'rabbitzhang52@gmail.com', 'a51e47f646375ab6bf5dd2c42d3e6181', 1, 1346419212, '兔子不舒服斯基', NULL, NULL, 0, 0, 0, 0),
(2, 'Tuzki_zhang', 'rabbitzhang52@yahoo.com', 'a51e47f646375ab6bf5dd2c42d3e6181', 1, 1346419212, '兔子不舒服斯基', '2.jpg', NULL, 0, 0, 2, 0);

-- --------------------------------------------------------

--
-- 表的结构 `user_meta`
--

CREATE TABLE IF NOT EXISTS `user_meta` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `meta_key` varchar(50) NOT NULL,
  `meta_value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_meta_user` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户扩展表' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `user_meta`
--

INSERT INTO `user_meta` (`id`, `user_id`, `meta_key`, `meta_value`) VALUES
(2, 2, 'post_fav', '3'),
(3, 2, 'post_fav', '2');

--
-- 限制导出的表
--

--
-- 限制表 `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `node`
--
ALTER TABLE `node`
  ADD CONSTRAINT `node_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_node` FOREIGN KEY (`node_id`) REFERENCES `node` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `user_meta`
--
ALTER TABLE `user_meta`
  ADD CONSTRAINT `user_meta_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
