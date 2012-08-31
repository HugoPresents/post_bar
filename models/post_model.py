# -- coding: utf8 --
import web
import time
from config.config import db
from libraries.helper import *

tb = 'post'

form = web.form.Form(
	web.form.Textbox('title', web.form.notnull, size=30, description="Post title:"),
	web.form.Textarea('content', web.form.notnull, rows=20, cols=80, description="Post content"),
	web.form.Button('Post entry'),
)

def get_posts(conditions = None, offset = None, limit = 10):
	where = dict2where(conditions)
	return db.select(tb, where = where, offset = offset, limit = limit)

def get_post(id):
	try:
		return db.select(tb, where = 'id=' + id)[0]
	except IndexError:
		return None

def insert(title, content, node_id, user_id):
	db.insert(tb, title = title, content = content, time = time.time(), user_id = user_id, node_id = node_id)