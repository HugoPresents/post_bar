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
                                 
                                 )
    def __init__(self):
        super(user_model, self).__init__('user')