post_bar
====================

web.py 的贴吧

1. 为了练手

2. 初步想仿一个V2EX，原谅我太爱它了

3. apache + wsgi + mysql

4. [demo](http://post_bar.rabbit52.com "post_bar")

部署
---------------------

1. Apache + mod_wsgi + mysql 环境

2. cp index.py.default index.py && cp config/config.py.default config/config.py 并修改相应配置

3. 导入post_bar_init.sql 至数据库

4. Mac 下用系统 apache 和 python 没有部署成功过~。建议在 linux 和 win 下部署。 Mac 下默认的 python 版本是 2.7.2 从官网下载升级到2.7.3之后能控制台运行

5. 环境依赖 必须：python 2.7.3、mysql-python、PIL、webpy 0.37、mysql，可选 Apache、mode_wsgi

6. 根目录下的 index.py 是wsgi脚本，code.py 是 web.py 自带服务器脚本。

7. 用Apache 部署请 chown -R apache:apache ./ && chmod -R 755 ./

8. 在Apache中创建形如下面的虚拟主机 example:
	<pre>
    &lt;VirtualHost *:80&gt;
		ServerAdmin admin@localhost
		DocumentRoot /var/www/post_bar
		ServerName post_bar.localhost 
		ErrorLog "logs/post_bar.log"
	    CustomLog "logs/post_bar.log" combined
		WSGIScriptAlias / /var/www/post_bar/index.py
		Alias /static /var/www/post_bar/static
		AddType text/html .py
	&lt;/VirtualHost&gt;
	</pre>
9. 有疑问请 rabbitzhang52#gmail.com

10. 有人问到开源协议，我对那个确实没什么研究，本身就是抄袭了V2EX的设计，我只想跟大家交流一下python 的开发经验。你可以用这个做任何事只要不侵犯丝毫V2EX的权益。 
10. 