# -- coding: utf8 --
import web
from config.config import *

app = web.application(urls, globals())

if web.config.get('_session') is None:
	session = web.session.Session(app, web.session.DiskStore('sessions'), initializer={'user_id': None})
	web.config._session = session
else:
	session = web.config._session

# 如果这里不 不将 session 赋值给模板全局变量， 模板中将不能得到此变量
web.template.Template.globals['session'] = session
if __name__ == "__main__":
	app.run()