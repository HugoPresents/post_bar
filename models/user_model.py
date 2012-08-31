# -- coding: utf8 --
import web
import time
import hashlib
from config.config import db
from libraries.helper import *
from libraries.error import *

tb = 'user'

login_form = web.form.Form(
    web.form.Textbox('name', web.form.notnull, size=30, description="Username:"),
    web.form.Password('password', web.form.notnull, size=30, description="Password"),
    web.form.Button('Login'),
)

signup_form = web.form.Form(
    web.form.Textbox('name', web.form.notnull, size=30, description="Username:"),
    web.form.Textbox('email', web.form.notnull, size=30, description="Email:"),
    web.form.Password('password', web.form.notnull, size=30, description="Password:"),
    web.form.Password('confirm_password', web.form.notnull, size=30, description="Confirm password:"),
    web.form.Button('Sign up'),
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