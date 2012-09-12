# -- coding: utf8 --
import web
from models.post_model import *

class index:
    def GET(self):
    	title = '首页'
        posts = post_model().get_all()
        raise
        #posts = post_model.get_all()
    	posts = post_model.get_posts()
        nodes = node_model.get_nodes_with_cat()
        return render.index(nodes, posts, title)