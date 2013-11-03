# -- coding: utf8 --
import web
session = web.config._session
from config.config import render
from models.post_model import *
from models.node_model import *
from models.user_model import *
from models.user_meta_model import *
from models.comment_model import *
from libraries.crumb import Crumb
from libraries.pagination import Pagination

# 显示某节点的文章
class index:
    
    def __init__(self):
        self.crumb = Crumb()
    
    def GET(self, node_name):
        limit = 10
        node = node_model().get_one({'name': node_name})
        if node is None:
            self.crumb.append('节点未找到')
            return render.node_nf('节点未找到', self.crumb.output())
        else:
            self.crumb.append(node.display_name)
            node_fav = False
            if session.user_id:
                if user_meta_model().get_one({'user_id':session.user_id, 'meta_key':'node_fav', 'meta_value':node.id}):
                    node_fav = True
            total_rows = post_model().count_table({'node_id':node.id})
            pagination = Pagination('/node/'+node_name, total_rows, limit = limit)
            page = pagination.true_page(web.input(p=1)['p'])
            posts = post_model().trends(limit, (page-1) * limit, node.id)
            return render.node_posts(posts, node, total_rows, node_fav, self.crumb.output(), pagination.output())

class fav:
    
    def __init__(self):
        self.crumb = Crumb()
    
    def GET(self, node_name):
        node = node_model().get_one({'name': node_name})
        if node is None:
            self.crumb.append('节点未找到')
            return render.node_nf('节点未找到', self.crumb.output())
        if session.user_id is None:
            raise web.SeeOther('/login?next=/node/'+node_name)
        user_meta_model().unique_insert({'user_id':session.user_id, 'meta_key':'node_fav', 'meta_value':node.id})
        user_model().update({'id':session.user_id}, {'node_favs':user_meta_model().count_meta({'user_id':session.user_id, 'meta_key':'node_fav'})})
        user_model().update_session(session.user_id)
        raise web.SeeOther('/node/'+node_name)

class unfav:
    
    def __init__(self):
        self.crumb = Crumb()
    
    def GET(self, node_name):
        node = node_model().get_one({'name': node_name})
        if node is None:
            self.crumb.append('节点未找到')
            return render.node_nf('节点未找到', self.crumb.output())
        if session.user_id is None:
            raise web.SeeOther('/login?next=/node/'+node_name)
        user_meta_model().delete({'user_id':session.user_id, 'meta_key':'node_fav', 'meta_value':node.id})
        user_model().update({'id':session.user_id}, {'node_favs':user_meta_model().count_meta({'user_id':session.user_id, 'meta_key':'node_fav'})})
        user_model().update_session(session.user_id)
        raise web.SeeOther('/node/'+node_name)