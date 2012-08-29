import web

from config.config import db

tb = 'post'

def get_posts(offset = 0, limit = 10):
	return db.select(tb, offset = offset, limit = limit)