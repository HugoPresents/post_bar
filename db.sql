-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 10 月 09 日 13:49
-- 服务器版本: 5.1.59-community
-- PHP 版本: 5.3.2

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
  `thanks` int(10) DEFAULT '0' COMMENT '感谢数',
  PRIMARY KEY (`id`),
  KEY `comment_user` (`user_id`),
  KEY `comment_post` (`post_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='帖子评论' AUTO_INCREMENT=80 ;

--
-- 转存表中的数据 `comment`
--

INSERT INTO `comment` (`id`, `user_id`, `post_id`, `content`, `time`, `thanks`) VALUES
(1, 2, 1, '测试内容哦！', 1346603234, 0),
(2, 2, 1, '测试内容哦！', 1346603309, 0),
(3, 2, 1, '测试内容哦！', 1346603384, 0),
(4, 2, 1, '测试内容哦！', 1346603396, 0),
(5, 2, 1, '这尼玛什么情况！', 1346603756, 0),
(6, 2, 2, 'SeeOther', 1346603837, 0),
(7, 2, 2, 'SeeOther', 1346603844, 0),
(8, 2, 3, '二哥头吧', 1347693290, 0),
(9, 2, 3, '二哥头吧', 1347694004, 0),
(10, 2, 2, '二哥头吧', 1347694076, 0),
(11, 2, 1, '二哥头吧', 1347694086, 0),
(12, 2, 3, '二国', 1348467126, 0),
(13, 1, 13, '$', 1349273770, 0),
(14, 1, 13, '$', 1349273775, 0),
(15, 1, 13, '$$$$$$$', 1349273778, 0),
(16, 1, 13, '''#~mone', 1349273800, 0),
(17, 1, 13, 'ethgth', 1349273884, 0),
(18, 1, 13, 'ethgth', 1349273887, 0),
(19, 1, 12, '$', 1349281274, 0),
(20, 1, 12, '$', 1349281278, 0),
(21, 1, 12, '$r', 1349281285, 0),
(22, 1, 12, '$rR', 1349281289, 0),
(23, 1, 12, '', 1349281293, 0),
(24, 1, 12, '$TTT', 1349281365, 0),
(25, 1, 12, 'Traceback (most recent call last):\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py", line 1245, in communicate', 1349281630, 0),
(26, 1, 12, 'req.respond()\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py", line 775, in respond', 1349281642, 0),
(27, 1, 12, 'File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform\r\nreturn self.compile_node(tree)\r\nFile "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node\r\nraise WalkerError, (unexpected node type, n)\r\nWalkerError: (unexpected node type, 339)', 1349281868, 0),
(28, 1, 12, 'wragr''a"gerwg''sdfvf"vbf', 1349284013, 0),
(29, 1, 12, 'wragr$a"gerwg''sdfvf"vbf', 1349284013, 0),
(30, 1, 12, 'wragr''a"gerwg''sdfvf"vbf', 1349284118, 0),
(31, 1, 12, '报错如下\r\nTraceback (most recent call last):\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py", line 1245, in communicate\r\nreq.respond()\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py", line 775, in respond\r\nself.server.gateway(self).respond()\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/wsgiserver/__init__.py", line 2018, in respond\r\nresponse = self.req.server.wsgi_app(self.env, self.start_response)\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__\r\nreturn self.app(environ, xstart_response)\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__\r\nreturn self.app(environ, start_response)\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi\r\nresult = self.handle_with_processors()\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors\r\nreturn process(self.processors)\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process\r\nraise self.internalerror()\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror\r\nreturn debugerror.debugerror()\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror\r\nreturn web._InternalError(djangoerror())\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror\r\ndjangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe)\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__\r\ncode = self.compile_template(text, filename)\r\nFile "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template\r\nast = compiler.parse(code)\r\nFile "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse\r\nreturn Transformer().parsesuite(buf)\r\nFile "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite\r\nreturn self.transform(parser.suite(text))\r\nFile "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform\r\nreturn self.compile_node(tree)\r\nFile "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node\r\nraise WalkerError, (''unexpected node type'', n)\r\nWalkerError: (''unexpected node type'', 339)\r\n\r\n搜了好久也无果\r\n我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。\r\n它在 win 和 linux 下都能正常运行哒\r\n谁帮帮我嘛~ 先谢谢了\r\n如果有人能帮我看看代码的问题就太感谢了 T_T\r\nhttps://github.com/Rabbit52/post_bar', 1349284155, 0),
(32, 1, 12, 'File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse\r\nreturn Transformer().parsesuite(buf)\r\nFile "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite\r\nreturn self.transform(parser.suite(text))\r\nFile ', 1349284226, 0),
(33, 1, 12, 'wragr''a"gerwg''sdfvf"vbf', 1349284280, 0),
(34, 1, 12, 'File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File', 1349284288, 0),
(35, 1, 12, 'File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) \r\nFile "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text))\r\n\r\n File', 1349284304, 0),
(36, 1, 12, 'wragr''a"gerwg''sdfvf"vbf', 1349284452, 0),
(37, 1, 12, '$$$', 1349284458, 0),
(38, 1, 12, '<script></script>', 1349284550, 0),
(39, 1, 12, '<script></script>', 1349284560, 0),
(40, 1, 12, '<hwrth ', 1349285456, 0),
(41, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349285576, 0),
(42, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349285687, 0),
(43, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349285897, 0),
(44, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349286063, 0),
(45, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349286174, 0),
(46, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349286233, 0),
(47, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349286334, 0),
(48, 1, 12, 'rver.wsgi_app(self.env, self.start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 306, in __call__ return self.app(environ, xstart_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/httpserver.py", line 274, in __call__ return self.app(environ, start_response) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 279, in wsgi result = self.handle_with_processors() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 249, in handle_with_processors return process(self.processors) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 246, in process raise self.internalerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/application.py", line 478, in internalerror return debugerror.debugerror() File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 305, in debugerror return web._InternalError(djangoerror()) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/debugerror.py", line 290, in djangoerror djangoerror_r = Template(djangoerror_t, filename=__file__, filter=websafe) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 846, in __init__ code = self.compile_template(text, filename) File "/Library/Python/2.7/site-packages/web.py-0.37-py2.7.egg/web/template.py", line 926, in compile_template ast = compiler.parse(code) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 51, in parse return Transformer().parsesuite(buf) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 128, in parsesuite return self.transform(parser.suite(text)) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 124, in transform return self.compile_node(tree) File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/compiler/transformer.py", line 167, in compile_node raise WalkerError, (''unexpected node type'', n) WalkerError: (''unexpected node type'', 339) 搜了好久也无果 我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。 它在 win 和 linux 下都能正常运行哒 谁帮帮我嘛~ 先谢谢了 如果有人能帮我看看代码的问题就太感谢了 T_T https://github.com/Rabbit52/post_bar', 1349286462, 0),
(49, 1, 12, 'rgraga', 1349286574, 0),
(50, 1, 12, 'rgragabhb', 1349286584, 0),
(51, 1, 14, 'rgragabhb', 1349286816, 0),
(52, 1, 14, 'rgragabhb', 1349286829, 0),
(53, 1, 14, 'rgragabhb', 1349286847, 0),
(54, 1, 14, 'rgragabhb', 1349286850, 0),
(55, 1, 14, 'rgragabhb', 1349286905, 0),
(56, 1, 2, '娃儿，不要屁话多', 1349286931, 0),
(57, 1, 2, '娃儿，不要屁话多', 1349286978, 0),
(58, 1, 2, '娃儿，不要屁话多好不好~,,,', 1349286992, 0),
(59, 1, 14, '这是什么情况', 1349621169, 0),
(60, 1, 12, '为什么有这种情况~', 1349622213, 0),
(61, 2, 17, '这尼玛~', 1349622899, 0),
(62, 1, 17, '然后勒', 1349623279, 0),
(63, 1, 17, '为什么有这种情况~', 1349623397, 0),
(64, 1, 17, '为什么有这种情况~', 1349623409, 0),
(65, 1, 17, '为什么有这种情况~', 1349623411, 0),
(66, 1, 17, '为什么有这种情况~', 1349623412, 0),
(67, 1, 17, '为什么有这种情况~', 1349623414, 1),
(68, 1, 17, '为什么有这种情况~', 1349623418, 0),
(69, 1, 17, '为什么有这种情况~', 1349623420, 1),
(70, 1, 17, '为什么有这种情况~', 1349623421, 1),
(71, 1, 17, '为什么有这种情况~', 1349623423, 0),
(72, 1, 17, '为什么有这种情况~', 1349623425, 0),
(73, 1, 17, '为什么有这种情况~', 1349623508, 0),
(74, 1, 17, '为什么有这种情况~', 1349623510, 0),
(75, 1, 17, '为什么有这种情况~', 1349623511, 0),
(76, 1, 17, '为什么有这种情况~', 1349623514, 0),
(77, 1, 17, '为什么有这种情况~', 1349623564, 0),
(78, 1, 17, '为什么有这种情况~', 1349623570, 0),
(79, 1, 17, '为什么有这种情况~', 1349623572, 0);

-- --------------------------------------------------------

--
-- 表的结构 `comment_thanks`
--

CREATE TABLE IF NOT EXISTS `comment_thanks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0',
  `comment_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `comment_thanks_user` (`user_id`),
  KEY `comment_thanks_comment` (`comment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `comment_thanks`
--

INSERT INTO `comment_thanks` (`id`, `user_id`, `comment_id`) VALUES
(8, 1, 65),
(9, 1, 69),
(10, 1, 67),
(11, 1, 70);

-- --------------------------------------------------------

--
-- 表的结构 `money`
--

CREATE TABLE IF NOT EXISTS `money` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `money_type_id` int(10) NOT NULL COMMENT '收支类型',
  `length` int(10) NOT NULL DEFAULT '0' COMMENT '长度',
  `amount` float NOT NULL DEFAULT '0' COMMENT '金额',
  `balance` float NOT NULL DEFAULT '0' COMMENT '余额',
  `foreign_id` int(11) DEFAULT '0' COMMENT '帖子/评论/用户 id',
  PRIMARY KEY (`id`),
  KEY `money_money_type` (`money_type_id`),
  KEY `money_user` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='财富收支表' AUTO_INCREMENT=81 ;

--
-- 转存表中的数据 `money`
--

INSERT INTO `money` (`id`, `user_id`, `money_type_id`, `length`, `amount`, `balance`, `foreign_id`) VALUES
(40, 1, 3, 6, -5, 0, 59),
(43, 1, 3, 9, -5, 0, 60),
(44, 1, 2, 7, -20, 0, 17),
(45, 2, 3, 4, -5, 0, 61),
(46, 1, 3, 4, 5, 0, 61),
(47, 1, 3, 3, -5, 312.06, 62),
(48, 1, 3, 9, -5, 307.06, 63),
(49, 1, 3, 9, -5, 302.06, 64),
(50, 1, 3, 9, -5, 297.06, 65),
(51, 1, 3, 9, -5, 292.06, 66),
(52, 1, 3, 9, -5, 287.06, 67),
(53, 1, 3, 9, -5, 282.06, 68),
(54, 1, 3, 9, -5, 277.06, 69),
(55, 1, 3, 9, -5, 272.06, 70),
(56, 1, 3, 9, -5, 267.06, 71),
(57, 1, 3, 9, -5, 262.06, 72),
(58, 1, 3, 9, -5, 257.06, 73),
(59, 1, 3, 9, -5, 252.06, 74),
(60, 1, 3, 9, -5, 247.06, 75),
(61, 1, 3, 9, -5, 242.06, 76),
(62, 1, 3, 9, -5, 237.06, 77),
(63, 1, 3, 9, -5, 232.06, 78),
(64, 1, 3, 9, -5, 227.06, 79),
(65, 1, 2, 14, -20, 207.06, 18),
(66, 1, 2, 14, -20, 187.06, 19),
(67, 1, 5, 0, -10, 177.06, 68),
(68, 1, 5, 0, -10, 167.06, 79),
(69, 1, 5, 0, -10, 157.06, 74),
(70, 1, 5, 0, 10, 167.06, 74),
(71, 1, 5, 0, -10, 157.06, 64),
(72, 1, 5, 0, 10, 167.06, 64),
(73, 1, 5, 0, -10, 157.06, 65),
(74, 1, 5, 0, 10, 167.06, 65),
(75, 1, 5, 0, -10, 157.06, 69),
(76, 1, 5, 0, 10, 167.06, 69),
(77, 1, 5, 0, -10, 157.06, 67),
(78, 1, 5, 0, 10, 167.06, 67),
(79, 1, 5, 0, -10, 157.06, 70),
(80, 1, 5, 0, 10, 167.06, 70);

-- --------------------------------------------------------

--
-- 表的结构 `money_option`
--

CREATE TABLE IF NOT EXISTS `money_option` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='全站配置' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `money_option`
--

INSERT INTO `money_option` (`id`, `key`, `value`, `comment`) VALUES
(1, 'post_cost', '20', '发帖基础花费财富'),
(2, 'post_cost_add', '1', '帖子每增加100字符花费'),
(3, 'post_length', '200', '帖子基础字符'),
(4, 'comment_length', '100', '评论基础字符'),
(5, 'comment_cost', '5', '评论基础花费'),
(6, 'comment_cost_add', '1', '评论没增加100字花费'),
(7, 'thanks_cost', '10', '感谢花费');

-- --------------------------------------------------------

--
-- 表的结构 `money_type`
--

CREATE TABLE IF NOT EXISTS `money_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='财富的获取或支出类型' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `money_type`
--

INSERT INTO `money_type` (`id`, `name`, `comment`) VALUES
(1, 'invite', '邀请'),
(2, 'post', '主题'),
(3, 'comment', '评论'),
(4, 'post_thanks', '感谢主题'),
(5, 'comment_thanks', '感谢回复');

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
  `thanks` int(10) DEFAULT '0' COMMENT '感谢数',
  PRIMARY KEY (`id`),
  KEY `post_user` (`user_id`),
  KEY `post_node` (`node_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='所有帖子' AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `post`
--

INSERT INTO `post` (`id`, `user_id`, `node_id`, `title`, `content`, `time`, `views`, `comments`, `thanks`) VALUES
(1, 1, 1, '测试标题', '测试内容哦！', 0, 119, 6, 0),
(2, 1, 1, '测试主题', '测试节点测测试主题', 1346336356, 32, 6, 0),
(3, 2, 1, '用户创建主题', '这是用户创建的主题', 1346424167, 110, 3, 0),
(12, 1, 1, '求助，webpy 的东西在ML下跑不起了~', '报错如下\r\n\r\n搜了好久也无果\r\n我成功装上了 web.py 和 python-mysqldb 的, 如果一个 "hello world" 能运行成功，但是这个实在不知道怎么回事了。\r\n它在 win 和 linux 下都能正常运行哒\r\n谁帮帮我嘛~ 先谢谢了\r\n如果有人能帮我看看代码的问题就太感谢了 T_T', 1349271488, 38, 33, 0),
(13, 1, 1, 'test', 'test ''''""#', 1349273760, 9, 6, 0),
(14, 1, 1, 'gwragwrag', 'arebaeb', 1349286641, 8, 6, 0),
(15, 1, 1, '这是测试主题', '这是你没', 1349621198, 1, 0, 0),
(16, 1, 1, '这是测试主题', '这是你没', 1349621383, 1, 0, 0),
(17, 1, 1, '求助，if else 判断不正确~', '这尼玛，坑爹呀', 1349622259, 49, 19, 0),
(18, 1, 1, '阿宾额头和维特哈如果不', '人工犬瘟热和企鹅天河区退还给', 1349623884, 1, 0, 0),
(19, 1, 1, '阿宾额头和维特哈如果不', '人工犬瘟热和企鹅天河区退还给', 1349623893, 2, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `post_thanks`
--

CREATE TABLE IF NOT EXISTS `post_thanks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0',
  `post_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `post_thanks_user` (`user_id`),
  KEY `post_thanks_post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  `money` float DEFAULT '2000' COMMENT '财富',
  `node_favs` int(10) DEFAULT '0' COMMENT '收藏节点数',
  `post_favs` int(10) DEFAULT '0' COMMENT '收藏帖子数',
  `user_favs` int(10) DEFAULT '0' COMMENT '关注成员数',
  `last_session_id` varchar(50) DEFAULT NULL COMMENT '最后登录的session_id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`, `gender`, `regist_time`, `signature`, `avatar`, `outsite_link`, `posts`, `money`, `node_favs`, `post_favs`, `user_favs`, `last_session_id`) VALUES
(1, 'Rabbit_52', 'rabbitzhang52@gmail.com', 'a51e47f646375ab6bf5dd2c42d3e6181', 1, 1346419212, '兔子不舒服斯基', '1.png', NULL, 0, 167.06, 0, 0, 1, NULL),
(2, 'Tuzki_zhang', 'rabbitzhang52@yahoo.com', 'a51e47f646375ab6bf5dd2c42d3e6181', 1, 1346419212, '兔子不舒服斯基', '2.png', NULL, 0, 3995.1, 1, 2, 1, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户扩展表' AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `user_meta`
--

INSERT INTO `user_meta` (`id`, `user_id`, `meta_key`, `meta_value`) VALUES
(2, 2, 'post_fav', '3'),
(4, 2, 'node_fav', '1'),
(5, 2, 'post_fav', '2'),
(7, 2, 'follow', '1'),
(8, 1, 'follow', '2');

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
-- 限制表 `comment_thanks`
--
ALTER TABLE `comment_thanks`
  ADD CONSTRAINT `comment_thanks_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `comment_thanks_comment` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`);

--
-- 限制表 `money`
--
ALTER TABLE `money`
  ADD CONSTRAINT `money_money_type` FOREIGN KEY (`money_type_id`) REFERENCES `money_type` (`id`),
  ADD CONSTRAINT `money_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

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
-- 限制表 `post_thanks`
--
ALTER TABLE `post_thanks`
  ADD CONSTRAINT `post_thanks_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `post_thanks_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);

--
-- 限制表 `user_meta`
--
ALTER TABLE `user_meta`
  ADD CONSTRAINT `user_meta_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
