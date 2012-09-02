# -- coding: utf8 --
import web
import time
from config.config import *
from libraries.helper import *

form = web.form.Form(
    web.form.Textarea('content', notnull, rows=5, cols=80, description=''),
    web.form.Button('评论')
)

tb = 'comment'

def get_comments(conditions):
    where = dict2where(conditions)
    return db.select(tb, where = where)

def insert(user_id, post_id, content):
    db.insert(tb, user_id = user_id, post_id=post_id, content = content, time = time.time())