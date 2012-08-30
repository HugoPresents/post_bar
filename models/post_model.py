import web
import time
from config.config import db

tb = 'post'

form = web.form.Form(
	web.form.Textbox('title', web.form.notnull, size=30, description="Post title:"),
	web.form.Textarea('content', web.form.notnull, rows=20, cols=80, description="Post content"),
	web.form.Button('Post entry'),
)

def get_posts(offset = 0, limit = 10):
	return db.select(tb, offset = offset, limit = limit)

def insert(title, content):
	db.insert(tb, title = title, content = content, time = time.time(), user_id = 1, node_id = 1)