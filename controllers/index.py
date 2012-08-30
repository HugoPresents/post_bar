# -- coding: utf8 --
import web
from config.config import render
from models import post_model
from models import node_model

class index:
    def GET(self):
    	title = '首页'
    	posts = post_model.get_posts()
        nodes = node_model.get_nodes_with_cat()
        return render.index(nodes, posts, title)