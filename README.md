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

3. 在Apache中创建形如下面的虚拟主机 example:

<pre>
    &lt;VirtualHost *:80&gt;
		ServerAdmin admin@localhost
		DocumentRoot /var/www/post_bar
		ServerName post_bar.localhost
		AddDefaultCharset UTF-8   
		ErrorLog "logs/post_bar.log"
	    CustomLog "logs/post_bar.log" combined
		WSGIScriptAlias / /var/www/post_bar/index.py
		Alias /static /var/www/post_bar/static
		AddType text/html .py
	&lt;/VirtualHost&gt;
</pre>

4. Mac 下用系统 apache 和 python 没有部署成功过~。建议在 linux 和 win 下部署。 Mac 下默认的 python 版本是 2.7.2 从官网下载升级到2.7.3之后能控制台运行

5. 环境依赖 必须：python 2.7.3、mysql-python、PIL、webpy 0.37、mysql，可选 Apache、mode_wsgi

6. 根目录下的 index.py 是wsgi脚本，code.py 是 web.py 自带服务器脚本。

7. 用Apache 部署请 chown -R apache:apache ./ && chmod -R 755 ./