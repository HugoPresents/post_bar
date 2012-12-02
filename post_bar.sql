# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.28)
# Database: post_bar
# Generation Time: 2012-12-02 13:16:47 +0000
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

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;

INSERT INTO `category` (`id`, `name`, `display_name`, `description`)
VALUES
	(1,'test','分类名','分类描述这里'),
	(4,'test2','能添加？','分类描述');

/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;

INSERT INTO `comment` (`id`, `user_id`, `post_id`, `content`, `time`, `thanks`)
VALUES
	(1,2,1,'测试内容哦！',1346603234,0),
	(2,2,1,'测试内容哦！',1346603309,0),
	(3,2,1,'测试内容哦！',1346603384,0),
	(4,2,1,'测试内容哦！',1346603396,0),
	(5,2,1,'这尼玛什么情况！',1346603756,0),
	(6,2,2,'SeeOther',1346603837,0),
	(7,2,2,'SeeOther',1346603844,0),
	(8,2,3,'二哥头吧',1347693290,0),
	(9,2,3,'二哥头吧',1347694004,0),
	(10,2,2,'二哥头吧',1347694076,0),
	(11,2,1,'二哥头吧',1347694086,0),
	(12,2,3,'二国',1348467126,0),
	(13,1,13,'$',1349273770,0),
	(14,1,13,'$',1349273775,0),
	(15,1,13,'$$$$$$$',1349273778,0),
	(16,1,13,'\'#~mone',1349273800,0),
	(17,1,13,'ethgth',1349273884,0),
	(18,1,13,'ethgth',1349273887,0),
	(19,1,12,'$',1349281274,0),
	(20,1,12,'$',1349281278,1),
	(21,1,12,'$r',1349281285,0),
	(22,1,12,'$rR',1349281289,0),
	(23,1,12,'',1349281293,0),
	(24,1,12,'$TTT',1349281365,0),
	(25,1,12,'Traceback (most recent call last):\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py\", line 1245, in communicate',1349281630,0),
	(26,1,12,'req.respond()\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py\", line 775, in respond',1349281642,0),
	(27,1,12,'File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform\r\nreturn self.compile_node(tree)\r\nFile \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node\r\nraise WalkerError, (unexpected node type, n)\r\nWalkerError: (unexpected node type, 339)',1349281868,0),
	(28,1,12,'wragr\'a\"gerwg\'sdfvf\"vbf',1349284013,0),
	(29,1,12,'wragr$a\"gerwg\'sdfvf\"vbf',1349284013,0),
	(30,1,12,'wragr\'a\"gerwg\'sdfvf\"vbf',1349284118,0),
	(31,1,12,'报错如下\r\nTraceback (most recent call last):\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py\", line 1245, in communicate\r\nreq.respond()\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py\", line 775, in respond\r\nself.server.gateway(self).respond()\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py\", line 2018, in respond\r\nresponse = self.req.server.wsgi_app(self.env, self.start_response)\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__\r\nreturn self.app(environ, xstart_response)\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__\r\nreturn self.app(environ, start_response)\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi\r\nresult = self.handle_with_processors()\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors\r\nreturn process(self.processors)\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process\r\nraise self.internalerror()\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror\r\nreturn debugerror.debugerror()\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror\r\nreturn web._InternalError(djangoerror())\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror\r\ndjangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe)\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__\r\ncode = self.compile_template(text, filename)\r\nFile \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template\r\nast = compiler.parse(code)\r\nFile \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse\r\nreturn Transformer().parsesuite(buf)\r\nFile \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite\r\nreturn self.transform(parser.suite(text))\r\nFile \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform\r\nreturn self.compile_node(tree)\r\nFile \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node\r\nraise WalkerError, (\'unexpected node type\', n)\r\nWalkerError: (\'unexpected node type\', 339)\r\n\r\n搜了好久也无果\r\n我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。\r\n它在 win 和 linux 下都能正常运行哒\r\n谁帮帮我嘛~ 先谢谢了\r\n如果有人能帮我看看代码的问题就太感谢了 T_T\r\nhttps://github.com/Rabbit52/post_bar',1349284155,0),
	(32,1,12,'File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse\r\nreturn Transformer().parsesuite(buf)\r\nFile \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite\r\nreturn self.transform(parser.suite(text))\r\nFile ',1349284226,0),
	(33,1,12,'wragr\'a\"gerwg\'sdfvf\"vbf',1349284280,0),
	(34,1,12,'File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File',1349284288,0),
	(35,1,12,'File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) \r\nFile \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text))\r\n\r\n File',1349284304,0),
	(36,1,12,'wragr\'a\"gerwg\'sdfvf\"vbf',1349284452,0),
	(37,1,12,'$$$',1349284458,0),
	(38,1,12,'<script></script>',1349284550,0),
	(39,1,12,'<script></script>',1349284560,0),
	(40,1,12,'<hwrth ',1349285456,0),
	(41,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349285576,0),
	(42,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349285687,0),
	(43,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349285897,0),
	(44,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349286063,0),
	(45,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349286174,0),
	(46,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349286233,0),
	(47,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349286334,0),
	(48,1,12,'rver.wsgi_app(self.env, self.start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 306, in __call__ return self.app(environ, xstart_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py\", line 274, in __call__ return self.app(environ, start_response) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 279, in wsgi result = self.handle_with_processors() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 249, in handle_with_processors return process(self.processors) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 246, in process raise self.internalerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py\", line 478, in internalerror return debugerror.debugerror() File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 305, in debugerror return web._InternalError(djangoerror()) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py\", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 846, in __init__ code = self.compile_template(text, filename) File \"/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py\", line 926, in compile_template ast = compiler.parse(code) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 51, in parse return Transformer().parsesuite(buf) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 128, in parsesuite return self.transform(parser.suite(text)) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 124, in transform return self.compile_node(tree) File \"/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py\", line 167, in compile_node raise WalkerError, (\'unexpected node type\', n) WalkerError: (\'unexpected node type\', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar',1349286462,0),
	(49,1,12,'rgraga',1349286574,0),
	(50,1,12,'rgragabhb',1349286584,0),
	(51,1,14,'rgragabhb',1349286816,0),
	(52,1,14,'rgragabhb',1349286829,0),
	(53,1,14,'rgragabhb',1349286847,0),
	(54,1,14,'rgragabhb',1349286850,0),
	(55,1,14,'rgragabhb',1349286905,0),
	(56,1,2,'娃儿，不要屁话多',1349286931,0),
	(57,1,2,'娃儿，不要屁话多',1349286978,1),
	(58,1,2,'娃儿，不要屁话多好不好~,,,',1349286992,1),
	(59,1,14,'这是什么情况',1349621169,0),
	(60,1,12,'为什么有这种情况~',1349622213,0),
	(61,2,17,'这尼玛~',1349622899,0),
	(62,1,17,'然后勒',1349623279,1),
	(63,1,17,'为什么有这种情况~',1349623397,0),
	(64,1,17,'为什么有这种情况~',1349623409,0),
	(65,1,17,'为什么有这种情况~',1349623411,0),
	(66,1,17,'为什么有这种情况~',1349623412,0),
	(67,1,17,'为什么有这种情况~',1349623414,0),
	(68,1,17,'为什么有这种情况~',1349623418,0),
	(69,1,17,'为什么有这种情况~',1349623420,0),
	(70,1,17,'为什么有这种情况~',1349623421,0),
	(71,1,17,'为什么有这种情况~',1349623423,0),
	(72,1,17,'为什么有这种情况~',1349623425,0),
	(73,1,17,'为什么有这种情况~',1349623508,0),
	(74,1,17,'为什么有这种情况~',1349623510,0),
	(75,1,17,'为什么有这种情况~',1349623511,0),
	(76,1,17,'为什么有这种情况~',1349623514,0),
	(77,1,17,'为什么有这种情况~',1349623564,0),
	(78,1,17,'为什么有这种情况~',1349623570,0),
	(79,1,17,'为什么有这种情况~',1349623572,0),
	(80,1,18,'评论一下下勒',1353134455,0),
	(81,1,20,'oin',1353246613,0),
	(82,1,1,'&lt;a&gt;&lt;/a&gt;',1353771447,0),
	(83,1,20,'&lt;a&gt;&lt;/a&gt;',1353771525,0),
	(84,3,1,'&lt;a&gt;&lt;/a&gt;',1353777606,0),
	(85,3,1,'&lt;a&gt;&lt;/a&gt;',1353814319,0),
	(86,3,1,'&lt;a&gt;&lt;/a&gt;',1353814353,0),
	(87,1,14,'你现在还给我缓存不~？？？？',1353821270,0),
	(88,1,14,'你现在还给我缓存不~？？？？',1353821939,0),
	(89,1,14,'你现在还给我缓存不~？？？？',1353821972,0),
	(90,1,12,'zuixin',1353824058,0),
	(91,1,3,'二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧二哥头吧',1353848502,0),
	(92,1,14,'马上回复',1354120896,0),
	(93,2,35,'@tuzki',1354439619,0),
	(94,2,35,'@tuzki test',1354439642,0),
	(95,2,35,'@<a href=\"/profile/tuzki\">tuzki</a> @<a href=\"/profile/demo\">demo</a> @<a href=\"/profile/rabbit52\">rabbit52</a>',1354440477,0),
	(96,2,35,'@<a href=\"/profile/tuzki\">tuzki</a> @<a href=\"/profile/demo\">demo</a> @<a href=\"/profile/rabbit52\">rabbit52</a>',1354448677,0),
	(97,3,12,'@<a href=\"/profile/rabbit52\">rabbit52</a> 我给你说嘛',1354453266,0),
	(98,3,36,'@<a href=\"/profile/rabbit52\">rabbit52</a> 我给你说嘛',1354453298,0);

/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `comment_thanks` WRITE;
/*!40000 ALTER TABLE `comment_thanks` DISABLE KEYS */;

INSERT INTO `comment_thanks` (`id`, `user_id`, `comment_id`, `time`)
VALUES
	(1,2,62,1353133939),
	(2,2,57,1354440985),
	(3,2,58,1354441101),
	(4,2,20,1354441266);

/*!40000 ALTER TABLE `comment_thanks` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `money` WRITE;
/*!40000 ALTER TABLE `money` DISABLE KEYS */;

INSERT INTO `money` (`id`, `user_id`, `money_type_id`, `length`, `amount`, `balance`, `foreign_id`)
VALUES
	(40,1,3,6,-5,0,59),
	(43,1,3,9,-5,0,60),
	(44,1,2,7,-20,0,17),
	(45,2,3,4,-5,0,61),
	(46,1,3,4,5,0,61),
	(47,1,3,3,-5,312.06,62),
	(48,1,3,9,-5,307.06,63),
	(49,1,3,9,-5,302.06,64),
	(50,1,3,9,-5,297.06,65),
	(51,1,3,9,-5,292.06,66),
	(52,1,3,9,-5,287.06,67),
	(53,1,3,9,-5,282.06,68),
	(54,1,3,9,-5,277.06,69),
	(55,1,3,9,-5,272.06,70),
	(56,1,3,9,-5,267.06,71),
	(57,1,3,9,-5,262.06,72),
	(58,1,3,9,-5,257.06,73),
	(59,1,3,9,-5,252.06,74),
	(60,1,3,9,-5,247.06,75),
	(61,1,3,9,-5,242.06,76),
	(62,1,3,9,-5,237.06,77),
	(63,1,3,9,-5,232.06,78),
	(64,1,3,9,-5,227.06,79),
	(65,1,2,14,-20,207.06,18),
	(66,1,2,14,-20,187.06,19),
	(67,2,4,0,-10,3985.1,3),
	(68,1,4,0,10,197.06,3),
	(69,2,5,0,-10,3975.1,1),
	(70,1,5,0,10,207.06,1),
	(71,2,4,0,-10,3965.1,4),
	(72,1,4,0,10,217.06,4),
	(73,1,4,0,-10,207.06,5),
	(74,2,4,0,10,3975.1,5),
	(75,1,3,6,-5,202.06,80),
	(76,1,2,12,-20,182.06,20),
	(77,1,3,3,-5,177.06,81),
	(78,1,3,7,-5,172.06,82),
	(79,1,3,7,-5,167.06,83),
	(80,3,3,7,-5,1995,84),
	(81,1,3,7,5,172.06,84),
	(82,3,3,7,-5,1990,85),
	(83,1,3,7,5,177.06,85),
	(84,3,3,7,-5,1985,86),
	(85,1,3,7,5,182.06,86),
	(86,1,3,14,-5,177.06,87),
	(87,1,3,14,-5,172.06,88),
	(88,1,3,14,-5,167.06,89),
	(89,1,2,7,-20,147.06,21),
	(90,1,3,6,-5,142.06,90),
	(91,1,3,1300,-17,125.06,91),
	(92,2,3,1300,17,3992.1,91),
	(93,1,3,4,-5,120.06,92),
	(94,1,2,7,-20,100.06,22),
	(95,1,2,18,-20,80.06,23),
	(96,1,2,18,-20,60.06,24),
	(97,1,2,18,-20,40.06,25),
	(98,1,2,73,-20,20.06,26),
	(99,1,2,73,-20,0.0599976,27),
	(100,1,2,18,-20,7999980,28),
	(101,1,2,18,-20,7999960,29),
	(102,1,2,18,-20,7999940,30),
	(103,1,2,18,-20,7999920,31),
	(104,1,2,18,-20,7999900,32),
	(105,1,2,18,-20,7999880,33),
	(106,1,2,18,-20,7999860,34),
	(107,1,2,18,-20,7999840,35),
	(108,2,4,0,-10,3982.1,6),
	(109,1,4,0,10,7999850,6),
	(110,2,4,0,-10,3972.1,7),
	(111,1,4,0,10,7999860,7),
	(112,2,3,6,-5,3967.1,93),
	(113,1,3,6,5,7999860,93),
	(114,2,3,11,-5,3962.1,94),
	(115,1,3,11,5,7999870,94),
	(116,2,2,6,-20,3942.1,36),
	(117,2,3,22,-5,3937.1,95),
	(118,1,3,22,5,7999880,95),
	(119,2,5,0,-10,3927.1,2),
	(120,1,5,0,10,7999880,2),
	(121,2,5,0,-10,3917.1,3),
	(122,1,5,0,10,7999900,3),
	(123,2,5,0,-10,3907.1,4),
	(124,1,5,0,10,7999900,4),
	(125,2,3,22,-5,3902.1,96),
	(126,1,3,22,5,7999910,96),
	(127,2,2,9,-20,3882.1,37),
	(128,3,3,15,-5,1980,97),
	(129,1,3,15,5,7999920,97),
	(130,3,2,17,-20,1960,38),
	(131,3,3,15,-5,1955,98),
	(132,2,3,15,5,3887.1,98);

/*!40000 ALTER TABLE `money` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `node` WRITE;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;

INSERT INTO `node` (`id`, `category_id`, `name`, `display_name`, `description`, `icon`)
VALUES
	(1,1,'test','测试节点','测试节点的描述\r\n哎哟，不错哦','1.png'),
	(4,1,'Tuzki','兔斯基','兔斯基节点的描述',NULL),
	(5,4,'rabbit','兔斯基','兔斯基节点的描述','1.png');

/*!40000 ALTER TABLE `node` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `notify` WRITE;
/*!40000 ALTER TABLE `notify` DISABLE KEYS */;

INSERT INTO `notify` (`id`, `user_id`, `receiver`, `type_id`, `foreign_id`, `unread`)
VALUES
	(1,2,1,1,96,0),
	(4,3,1,1,97,0),
	(5,3,1,2,38,0),
	(7,3,1,3,98,0);

/*!40000 ALTER TABLE `notify` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;

INSERT INTO `post` (`id`, `user_id`, `node_id`, `title`, `content`, `time`, `views`, `comments`, `thanks`, `last_update`)
VALUES
	(1,1,1,'测试标题','测试内容哦！',1346336356,132,10,0,1346336356),
	(2,1,1,'测试主题','测试节点测测试主题',1346336356,35,6,0,1346336356),
	(3,2,1,'用户创建主题','这是用户创建的主题',1346424167,120,4,1,1353848502),
	(12,1,1,'求助，webpy 的东西在ML下跑不起了~','报错如下\r\n\r\n搜了好久也无果\r\n我成功装上了 web.py 和 python-mysqldb 的, 如果一个 \"hello world\" 能运行成功，但是这个实在不知道怎么回事了。\r\n它在 win 和 linux 下都能正常运行哒\r\n谁帮帮我嘛~ 先谢谢了\r\n如果有人能帮我看看代码的问题就太感谢了 T_T',1349271488,53,35,0,1354453266),
	(13,1,1,'test','test \'\'\"\"#',1349273760,10,6,0,1346336356),
	(14,1,1,'gwragwrag','arebaeb',1349286641,18,10,0,1354120896),
	(15,1,1,'这是测试主题','这是你没',1349621198,3,0,0,1346336356),
	(16,1,1,'这是测试主题','这是你没',1349621383,1,0,0,1346336356),
	(17,1,1,'求助，if else 判断不正确~','这尼玛，坑爹呀',1349622259,35,19,0,1346336356),
	(18,1,1,'阿宾额头和维特哈如果不','人工犬瘟热和企鹅天河区退还给',1349623884,5,1,1,1346336356),
	(19,1,1,'阿宾额头和维特哈如果不','人工犬瘟热和企鹅天河区退还给',1349623893,8,0,1,1346336356),
	(20,1,1,'你妹的，如果我再创建一个主题呢','你会不会给我涨一个？？？',1353221040,11,2,0,1346336356),
	(21,1,4,'卧槽，怎么会有重复的节点名','这是什么情况啊',1353823226,1,0,0,1346336356),
	(22,1,1,'&lt;a&gt;test&lt;/a&gt;','content',1354122609,2,0,0,1354122609),
	(23,1,1,'测试提醒系统','@<a href=\"/profile/t\">t</a>uzki\r\n你能听见我在呼唤你吗',1354437842,0,0,0,1354437842),
	(24,1,1,'测试提醒系统','@<a href=\"/profile/t\">t</a>uzki\r\n你能听见我在呼唤你吗',1354437863,1,0,0,1354437863),
	(25,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a>\r\n你能听见我在呼唤你吗',1354437927,4,0,0,1354437927),
	(26,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a>\r\n你能听见我在呼唤你吗\r\n&lt;a href=\"javascript:location.reload();\"&gt;Click Me!&lt;/a&gt;',1354438066,1,0,0,1354438066),
	(27,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a>\r\n你能听见我在呼唤你吗\r\n&lt;a href=\"javascript:location.reload();\"&gt;Click Me!&lt;/a&gt;',1354438202,2,0,0,1354438202),
	(28,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438369,0,0,0,1354438369),
	(29,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438400,0,0,0,1354438400),
	(30,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438475,0,0,0,1354438475),
	(31,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438490,0,0,0,1354438490),
	(32,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438511,0,0,0,1354438511),
	(33,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438526,0,0,0,1354438526),
	(34,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438548,1,0,1,1354438548),
	(35,1,1,'测试提醒系统','@<a href=\"/profile/tuzki\">tuzki</a> 你能听见我在呼唤你吗？',1354438689,35,4,1,1354448677),
	(36,2,1,'ceshi ','@<a href=\"/profile/tuzki\">tuzki</a>',1354439661,5,1,0,1354453298),
	(37,2,1,'ceshi ','@<a href=\"/profile/rabbit52\">rabbit52</a>',1354448695,3,0,0,1354448695),
	(38,3,1,'tes','我再给你说嘛\r\n@<a href=\"/profile/rabbit52\">rabbit52</a>',1354453289,1,0,0,1354453289);

/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `post_thanks` WRITE;
/*!40000 ALTER TABLE `post_thanks` DISABLE KEYS */;

INSERT INTO `post_thanks` (`id`, `user_id`, `post_id`, `time`)
VALUES
	(3,2,19,1353133885),
	(4,2,18,1353133972),
	(5,1,3,1353134024),
	(6,2,34,1354439247),
	(7,2,35,1354439436);

/*!40000 ALTER TABLE `post_thanks` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `name`, `email`, `password`, `gender`, `regist_time`, `signature`, `avatar`, `outsite_link`, `posts`, `money`, `node_favs`, `post_favs`, `user_favs`, `auth`)
VALUES
	(1,'rabbit52','rabbitzhang52@gmail.com','f5caf37dae4bdbe417d98569b0549bba',1,1346419212,'签名在此','1.jpg','rabbit52.com',0,7999920,0,2,1,'komfw'),
	(2,'tuzki','rabbitzhang52@yahoo.com','eece25c32e2facc831227fbbef5ceec6',1,1346419212,'兔子不舒服斯基','2.png',NULL,0,3887.1,1,2,1,'test'),
	(3,'demo','demo@demo.com','eece25c32e2facc831227fbbef5ceec6',1,1353777567,NULL,NULL,NULL,0,1955,0,0,0,'test');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `user_meta` WRITE;
/*!40000 ALTER TABLE `user_meta` DISABLE KEYS */;

INSERT INTO `user_meta` (`id`, `user_id`, `meta_key`, `meta_value`)
VALUES
	(2,2,'post_fav','3'),
	(4,2,'node_fav','1'),
	(5,2,'post_fav','2'),
	(7,2,'follow','1'),
	(8,1,'follow','2'),
	(9,1,'post_fav','3'),
	(10,1,'post_fav','20');

/*!40000 ALTER TABLE `user_meta` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
