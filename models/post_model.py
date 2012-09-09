# -- coding: utf8 --
import web
import time
from config.config import *
from libraries.helper import *
from libraries.db import *

tb = 'post'

form = web.form.Form(
	web.form.Textbox('title', notnull, size=30, description="标题"),
	web.form.Textarea('content', notnull, rows=20, cols=80, description="正文"),
	web.form.Button('发表')
)

def get_posts(conditions = None, offset = None, limit = 10):
	#where = dict2where(conditions)
	join = {'user' : ['user_id', 'id'], 'node' : ['node_id', 'id']}
	return fetch_join(tb = tb, condition = conditions, join = join)
	return db.select(tb, where = where, offset = offset, limit = limit)

def get_post(id):
	try:
		return db.select(tb, where = 'id=' + id)[0]
	except IndexError:
		return None

def insert(title, content, node_id, user_id):
	db.insert(tb, title = title, content = content, time = time.time(), user_id = user_id, node_id = node_id)