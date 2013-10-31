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
        posts = post_model().trends()

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
        posts = post_model().trends(limit, (page-1) * limit)
        crumb.append('最近的主题')
        return render.recent('最近的主题', total, crumb.output(), posts, pagination.output())

class about:
    def GET(self):
        crumb = Crumb()
        crumb.append('关于')
        return render.about('关于', crumb.output())
