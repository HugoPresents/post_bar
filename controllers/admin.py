# -- coding: utf8 --
__metaclass__ = type
import web
session = web.config._session
from config.config import *
from models.node_model import *
from models.cat_model import *
from models.post_model import *
from models.user_model import *
from models.comment_model import *
from libraries.crumb import Crumb

class index:
    
    def __init__(self):
        if session.user_id != 1:
            raise web.SeeOther('/')
    crumb = Crumb()
    
    def GET(self):
        site_count = {}
        site_count['user'] = user_model().count_table()
        site_count['post'] = post_model().count_table()
        site_count['comment'] = comment_model().count_table()
        cat_result = cat_model().get_all()
        cats = []
        for cat in cat_result:
            node_total = node_model().count_table({'category_id':cat.id})
            cats.append({'cat':cat, 'node_total':node_total})
        self.crumb.append('后台')
        return admin_render.index('管理', site_count, cats, self.crumb.output())