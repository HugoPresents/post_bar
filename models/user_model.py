import web
import time
from config.config import db
from libraries.helper import *

tb = 'user'

login_form = web.form.Form(
    web.form.Textbox('name', web.form.notnull, size=30, description="Username:"),
    web.form.Password('pass', web.form.notnull, size=30, description="Password"),
    web.form.Button('Login'),
)

signup_form = web.form.Form(
    web.form.Textbox('name', web.form.notnull, size=30, description="Username:"),
    web.form.Password('pass', web.form.notnull, size=30, description="Password"),
    web.form.Button('Login'),
)

def get_user(conditions):
    where = dict2where(conditions)
    try:
        return db.select(tb, where = where)[0]
    except IndexError:
        return None

def get_users(conditions):
    where = dict2where(conditions)
    return db.select(tb, where = where)

def insert(name, email, password):
    condition = {'name' : name}
    user = get_user(condition)
    if user is not None:
        raise NameExistsError
    condition = {'email' : email}
    user = get_user(conditon)
    if user is not None:
        raise EmailExistsError
    db.insert(tb, name = name, email = email, password = password, regist_time = time.time())