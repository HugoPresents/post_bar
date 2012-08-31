# -- coding: utf8 --
import web
import time
import hashlib
from config.config import *
from libraries.helper import *
from libraries.error import *

tb = 'user'

login_form = web.form.Form(
    web.form.Textbox('name', notnull, size=30, description="Username:"),
    web.form.Password('password', notnull, size=30, description="Password"),
    web.form.Button('Login')
)

signup_form = web.form.Form(
    web.form.Textbox('name', vname, size=30, description="用户名:"),
    web.form.Textbox('email', vemail, size=30, description="邮箱:"),
    web.form.Password('password', vpass, size=30, description="密码:"),
    web.form.Password('confirm_password', vconfirm_pass, size=30, description="确认密码:"),
    web.form.Button('注册')
)

def get_user(conditions):
    # 如果条件中有 password 键则进行 md5 加密
    if conditions.has_key('password'):
        conditions['password'] = hashlib.md5(conditions['password']).hexdigest()
    where = dict2where(conditions)
    try:
        return db.select(tb, where = where)[0]
    except IndexError:
        return None

def get_users(conditions):
    where = dict2where(conditions)
    return db.select(tb, where = where)

def insert(name, email, password):
    # 对密码进行 md5 加密
    password = hashlib.md5(password).hexdigest()
    condition = {'name' : name}
    user = get_user(condition)
    if user is not None:
        raise ValueExistsError('用户名已经存在')
    condition = {'email' : email}
    user = get_user(condition)
    if user is not None:
        raise ValueExistsError('邮箱已经存在')
    db.insert(tb, name = name, email = email, password = password, regist_time = time.time())