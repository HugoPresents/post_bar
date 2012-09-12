# -- coding: utf8 --
import web
from config.config import render
from models.post_model import *
from models.node_model import *
from models.user_model import *
from models.comment_model import *
from models.cat_model import *

class index:
    def GET(self):
    	title = '首页'
        posts_result = post_model().get_all(limit = 10)
        posts = []
        for post_result in posts_result:
            post = {'post':post_result}
            user = user_model().get_one({'id':post_result.user_id})
            post['user'] = user
            node = node_model().get_one({'id':post_result.node_id})
            post['node'] = node
            comment = comment_model().get_one({'post_id':post_result.id}, 'time DESC')
            if comment:
                comment_user = user_model().get_one({'id':comment.user_id})
                post['comment_user'] = comment_user
            else:
                post['comment_user'] = None
            posts.append(post)
        cats_result = cat_model().get_all()
        cats = []
        for cat_result in cats_result:
            cat = {'cat':cat_result}
            node = node_model().get_all({'category_id':cat_result.id})
            cat['node'] = node
            cats.append(cat)
        return render.index(cats, posts, title)