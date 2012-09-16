# -- coding: utf8 --
import web
import hashlib
import time
from config.config import render
from models.user_model import *
from libraries.error import *
from libraries.crumb import *

class login:
    
    form = user_model().login_form
    crumb = Crumb()
    
    def GET(self):
        title = '登录'
        self.crumb.append('登录')
        return render.login(self.form, title, self.crumb.output())
    
    def POST(self):
        if not self.form.validates():
            return render.login(self.form, '登录失败，请重登')
        condition = {'name' : self.form.d.name, 'password' : self.form.d.password}
        # MD5加密 密码
        condition['password'] = hashlib.md5(condition['password']).hexdigest()
        user = user_model().get_one(condition)
        if user is None:
            return render.login(self.form, '登录失败，请重登')
        web.config._session.user_id = user.id
        web.config._session.name = user.name
        raise web.seeother('/')

class signup:
    
    form = user_model().signup_form
    crumb = Crumb()
    
    def GET(self):
        title = '注册'
        self.crumb.append('注册')
        return render.signup(self.form, title, self.crumb.output())
    
    def POST(self):
        #return self.form.d.password + '|' + self.form.d.confirm_password
        if not self.form.validates():
            return render.signup(self.form, '注册失败，请重注')
        try:
            condition = {'name':self.form.d.name}
            user = user_model().get_one(condition)
            #user_model.insert(self.form.d.name, self.form.d.email, self.form.d.password)
            # 对密码进行 md5 加密
            password = hashlib.md5(self.form.d.password).hexdigest()
            user = get_user(condition)
            if user is not None:
                raise ValueExistsError('用户名已经存在')
            condition = {'email' : email}
            user = user_model().get_one(condition)
            if user is not None:
                raise ValueExistsError('邮箱已经存在')
            user_model().insert(name = name, email = email, password = password, regist_time = time.time())
        except ValueExistsError, x:
            return render.signup(self.form, x.message)
        raise web.seeother('/')

# 注销
class logout:
    
    def GET(self):
        web.config._session.kill()
        raise web.SeeOther('/')