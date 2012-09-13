#  coding: utf8 
__metaclass__ = type
from models.model import *
from config.config import *

class user_model(model):
    login_form = web.form.Form(
        web.form.Textbox('name', notnull, size=30, description="Username:"),
        web.form.Password('password', notnull, size=30, description="Password"),
        web.form.Button('Login')
    )
    
    signup_form = web.form.Form(
        web.form.Textbox('name', vname, size=30, description="用户名:"),
        web.form.Textbox('email', vemail, size=30, description="邮箱:"),
        web.form.Password('password', vpass, size=30, description="密码:"),
        web.form.Button('注册')
    )
    def __init__(self):
        super(user_model, self).__init__('user')
