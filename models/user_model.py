#  coding: utf8 
__metaclass__ = type
import web
import base64
from models.model import *
from models.site_model import *
from config.config import *

class user_model(model):
    login_form = web.form.Form(
        web.form.Textbox('name', notnull, size=30, description="用户名", class_='sl'),
        web.form.Password('password', notnull, size=30, description="密码", class_='sl'),
        web.form.Button('登录', class_='super normal button')
    )
    
    signup_form = web.form.Form(
        web.form.Textbox('name', web.form.regexp('^[a-z0-9]+$', ' 请使用小写和数字的组合'), vname, size=30, description="用户名", class_='sl', post='<div class="sep5"></div><span class="fade">请使用半角的 a-z 和数字 0-9 的组合，长度至少为3个字符</span>'),
        web.form.Textbox('email', vemail, size=30, description="邮箱", class_='sl', post='<div class="sep5"></div><span class="fade">请使用真实电子邮箱注册，我们不会将你的邮箱地址分享给任何人</span>'),
        web.form.Password('password', vpass, size=30, description="密码", class_='sl'),
        web.form.Button('注册', class_='super normal button')
    )
    
    setting_form = web.form.Form(
         web.form.Textbox('name', size=30, description="用户名", class_='sl', disabled='disabled'),
         web.form.Textbox('email', vemail, size=30, description="邮箱", class_='sl'),
         web.form.Textbox('signature', web.form.regexp(r".{0,100}$", ' 请不要超过100个字符'), size=30, description="签名", class_='sl'),
         web.form.Textbox('outsite_link', web.form.regexp(r".{0,200}$", ' 请不要超过200个字符'), size=30, description="主页", class_='sl'),
         web.form.Button('保存设置', class_='super normal button')
     )
    
    pass_form = web.form.Form(
        web.form.Password('origin_password', notnull, size=30, description="原密码", class_='sl'),
        web.form.Password('new_password', vpass, size=30, description="新密码", class_='sl'),
        web.form.Password('check_password', vpass, size=30, description="确认密码", class_='sl'),
        web.form.Button('修改密码', class_='super normal button'),
        validators = [web.form.Validator(" 新密码不一致", lambda i: i.new_password == i.check_password)]
    )
    def __init__(self):
        super(user_model, self).__init__('user')
    
    def update_session(self, user_id):
        user = self.get_one({'id':user_id})
        web.config._session.user_id = user.id
        web.config._session.name = user.name
        web.config._session.avatar = user.avatar
        web.config._session.signature = user.signature
        web.config._session.node_favs = user.node_favs
        web.config._session.money = user.money
        web.config._session.posts = user.posts
        web.config._session.post_favs = user.post_favs
        web.config._session.user_favs = user.user_favs
    
    def set_avatar(self, filename, user_id):
        import Image
        import os
        path = 'static/avatar/'
        im = Image.open(path+'tmp/'+filename)
        size = im.size
        if size[0] > size[1]:
            crop_size = size[1]
            left = (size[0]-size[1])/2
            right = size[1] + left
            upper = 0
            lower = size[1]
        else:
            crop_size = size[0]
            left = 0
            right = size[0]
            upper = (size[1]-size[0])/2
            lower = size[0] + upper
        box = (left, upper, right, lower)
        region = im.crop(box)
        region.save(path+'tmp/'+filename)
        user = self.get_one({'id':user_id})
        try:
            os.makedirs(path+'big')
            os.makedirs(path+'normal')
            os.makedirs(path+'tiny')
            os.remove(path+'big/'+user.avatar)
            os.remove(path+'normal/'+user.avatar)
            os.remove(path+'tiny/'+user.avatar)
        except:
            pass
        im = Image.open(path+'tmp/'+filename)
        im.thumbnail((73, 73), Image.ANTIALIAS)
        im.save(path+'big/'+filename, quality = 100)
        im.thumbnail((48, 48), Image.ANTIALIAS)
        im.save(path+'normal/'+filename, quality = 100)
        im.thumbnail((24, 24), Image.ANTIALIAS)
        im.save(path+'tiny/'+filename, quality = 100)
        del im, region
        os.remove(path+'tmp/'+filename)
        self.update({'id':user_id}, {'avatar':filename})
        self.update_session(user_id)
    
    # cost 要带上符号
    def update_money(self, user_id, cost):
        sql = 'UPDATE ' + self._tb + ' SET money = money + ' + str(cost) +' WHERE id=' + str(user_id)
        super(user_model, self).query(sql)
        return self.get_one({'id':user_id}).money

    def auth_cookie(self, handler):
        try:
            if web.config._session.user_id is None:
                auth = web.cookies().get('auth')
                auth_list = base64.decodestring(auth).split('|')
                user = self.get_one({'id':auth_list[1], 'password':auth_list[0]})
                if user is None:
                    web.setcookie('auth', auth, -1)
                else:
                    self.update_session(user.id)
        except:
            pass
        return handler()

    def set_cookie(self, user_id):
        user = self.get_one({'id':user_id})
        auth = base64.encodestring(user.password+'|'+str(user.id))
        web.setcookie('auth', auth, int(site_model().get_option('cookie_expires')))
