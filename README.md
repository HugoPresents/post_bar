post_bar
====================

web.py 的贴吧

1. 为了练手

2. 初步想仿一个V2EX，原谅我太爱它了

3. apache + wsgi + mysql

部署
---------------------

1. Apache + mod_wsgi + mysql 环境

2. 修改 config 目录下 config.py 文件为你的配置

3. 在Apache中创建虚拟主机 example:

<pre>
    &lt;VirtualHost *:80&gt;
		ServerAdmin admin@localhost
		DocumentRoot E:/htdocs/python/post_bar
		ServerName post_bar.localhost
		AddDefaultCharset UTF-8   
		ErrorLog "logs/post_bar.log"
	    CustomLog "logs/post_bar.log" combined
		WSGIScriptAlias / "E:/htdocs/python/post_bar/index.py"
		Alias /static "E:/htdocs/python/post_bar/static"
		AddType text/html .py
	&lt;/VirtualHost&gt;
</pre>

4. ~~很蛋疼的是没有在 MAC 下跑成功，建议在 linux 和 win 下部署~~ MAC 下默认的 python 版本是 2.7.2 从官网下载升级到2.7.3之后就能成功运行了，话说python的版本差异也太大了嘛
