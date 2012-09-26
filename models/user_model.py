#  coding: utf8 
__metaclass__ = type
from models.model import *
from config.config import *

class user_model(model):
    login_form = web.form.Form(
        web.form.Textbox('name', notnull, size=30, description="用户名", class_='sl'),
        web.form.Password('password', notnull, size=30, description="密码", class_='sl'),
        web.form.Button('登录', class_='super normal button')
    )
    
    signup_form = web.form.Form(
        web.form.Textbox('name', vname, size=30, description="用户名", class_='sl', post='<div class="sep5"></div><span class="fade">请使用半角的 a-z 或数字 0-9</span>'),
        web.form.Textbox('email', vemail, size=30, description="邮箱", class_='sl', post='<div class="sep5"></div><span class="fade">请使用真实电子邮箱注册，我们不会将你的邮箱地址分享给任何人</span>'),
        web.form.Password('password', vpass, size=30, description="密码", class_='sl'),
        web.form.Button('注册', class_='super normal button')
    )
    
    setting_form = web.form.Form(
         web.form.Textbox('name', size=30, description="用户名", class_='sl', disabled='disabled'),
         web.form.Textbox('email', vemail, size=30, description="邮箱", class_='sl'),
         web.form.Button('保存设置', class_='super normal button')
     )
    
    pass_form = web.form.Form(
        web.form.Password('origin_password', notnull, size=30, description="原密码", class_='sl'),
        web.form.Password('new_password', notnull, size=30, description="新密码", class_='sl'),
        web.form.Password('check_password', notnull, size=30, description="确认密码", class_='sl'),
        web.form.Button('修改密码', class_='super normal button')
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
        im = Image.open(path+'tmp/'+filename)
        im.thumbnail((73, 73), Image.ANTIALIAS)
        im.save(path+'big/'+filename)
        im.thumbnail((48, 48), Image.ANTIALIAS)
        im.save(path+'normal/'+filename)
        im.thumbnail((24, 24), Image.ANTIALIAS)
        im.save(path+'tiny/'+filename)
        del im, region
        os.remove(path+'tmp/'+filename)
        self.update({'id':user_id}, {'avatar':filename})
        self.update_session(user_id)
        