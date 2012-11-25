# -- coding: utf8 --
import sys
if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')
import web
from config.config import *
from config.urls import *
from libraries import helper
from libraries import widget
from models.site_model import *
from models.user_model import *

#web.template.Template.globals['render'] = render
#web.template.Template.globals['admin_render'] = admin_render
#web.template.Template.globals['site_title'] = site_title
web.template.Template.globals['helper'] = helper
web.template.Template.globals['widget'] = widget
web.template.Template.globals['site_options'] = site_model().get_options()

app = web.application(urls, globals())

if web.config.get('_session') is None:
    session = web.session.Session(app, web.session.DiskStore('sessions'), initializer={'user_id': None})
    web.config._session = session
else:
    session = web.config._session

#user_model.auth_cookie()
app.add_processor(user_model().auth_cookie)

# 如果这里不 不将 session 赋值给模板全局变量， 模板中将不能得到此变量
web.template.Template.globals['session'] = session
#web.template.Template.globals['site_url'] = 'http://127.0.0.1:8080'
if __name__ == "__main__":
    app.run()