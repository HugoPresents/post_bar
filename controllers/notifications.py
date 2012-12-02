# -- coding: utf8 --
import web
session = web.config._session
from config.config import render
from models.post_model import *
from models.node_model import *
from models.user_model import *
from models.user_meta_model import *
from models.comment_model import *
from models.notify_model import *
from libraries.crumb import Crumb
from libraries.pagination import Pagination

class index:

    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/notifications')
    def GET(self):
        return None

class check:

    def __init__(self):
        if session.user_id is None:
            return 0
    def POST(self):
        if web.input(ajax = None):
            return notify_model().count_table({'receiver':session.user_id, 'unread':'1'})
        else:
            return '0'