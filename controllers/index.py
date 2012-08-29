# -- coding: utf8 --
import web
from config.config import render
from models import post_model

class index:
    def GET(self):
    	title = '首页'
    	posts = post_model.get_posts()
        return render.index(posts, title)