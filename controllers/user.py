# -- coding: utf8 --
import web
from config.config import render
from models import user_model

class login:
    
    form = user_model.login_form
    
    def GET(self):
        title = '登录'
        return render.login(self.form, title)
    def POST(self):
        if not form.validates():
            return render.login(self.form, '登录失败，请重登')
        raise web.seeother('/')

class signup:
    
    