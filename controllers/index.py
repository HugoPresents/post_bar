# -- coding: utf8 --
import web
session = web.config._session 
from config.config import render
from models.post_model import *
from models.node_model import *
from models.user_model import *
from models.comment_model import *
from models.cat_model import *
from libraries.crumb import Crumb
from libraries.pagination import *

class index:
    def GET(self):
    	title = '首页'
        #sql = 'SELECT post_id FROM comment GROUP BY post_id ORDER BY MAX(time) DESC LIMIT 20'
        #post_ids = post_model().query_result(sql)
        post_results = post_model().get_all(order='last_update DESC', limit=20)
        posts = []
        for post_result in post_results:
            #post_result = post_model().get_one({'id':row.post_id})
            post = {'post':post_result}
            user = user_model().get_one({'id':post_result.user_id})
            post['user'] = user
            node = node_model().get_one({'id':post_result.node_id})
            post['node'] = node
            comment = comment_model().get_one({'post_id':post_result.id}, order='time DESC')
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

class recent:
    def GET(self):
        #sql = 'SELECT post_id FROM comment GROUP BY post_id ORDER BY MAX(time) DESC LIMIT 20'
        #post_ids = post_model().query_result(sql)
        crumb = Crumb()
        limit = 50
        total = post_model().count_table()
        pagination = Pagination('/recent', total, limit = limit)
        page = pagination.true_page(web.input(p=1)['p'])
        post_results = post_model().get_all(limit = limit, offset= (page-1)*limit, order = 'time DESC')
        posts = []
        for post_result in post_results:
            #post_result = post_model().get_one({'id':row.post_id})
            post = {'post':post_result}
            user = user_model().get_one({'id':post_result.user_id})
            post['user'] = user
            node = node_model().get_one({'id':post_result.node_id})
            post['node'] = node
            comment = comment_model().get_one({'post_id':post_result.id}, order='time DESC')
            if comment:
                comment_user = user_model().get_one({'id':comment.user_id})
                post['comment_user'] = comment_user
            else:
                post['comment_user'] = None
            posts.append(post)
        crumb.append('最近的主题')
        return render.recent('最近的主题', total, crumb.output(), posts, pagination.output())

class about:
    def GET(self):
        crumb = Crumb()
        crumb.append('关于')
        return render.about('关于', crumb.output())
