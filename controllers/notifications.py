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
from models.notify_type_model import *
from libraries.crumb import Crumb
from libraries.pagination import Pagination

class index:

    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/notifications')
    def GET(self):
        crumb = Crumb()
        condition = {'receiver':session.user_id}
        total = notify_model().count_table(condition)
        limit = 10
        pagination = Pagination('/notifications', total, limit = limit)
        page = pagination.true_page(web.input(p=1)['p'])
        notify_result = notify_model().get_all(condition, order = 'id DESC', limit = limit, offset = (page-1)*limit)
        notifications = []
        if notify_result is not None:
            for notify in notify_result:
                post = None
                user = None
                comment = None
                notify_type = notify_type_model().get_one({'id':notify.type_id}).name
                user = user_model().get_one({'id':notify.user_id})
                if notify_type == 'post_at':
                    post = post_model().get_one({'id':notify.foreign_id})
                elif notify_type == 'comment' or notify_type == 'comment_at':
                    comment = comment_model().get_one({'id':notify.foreign_id})
                    post = post_model().get_one({'id':comment.post_id})
                notifications.append({'notify':notify, 'post':post, 'user':user, 'comment':comment, 'type':notify_type})
        notify_model().mark_as_read(session.user_id)
        crumb.append('提醒系统')
        return render.notify('提醒系统', crumb.output(), total, notifications, pagination.output())

class check:

    def __init__(self):
        if session.user_id is None:
            return 0
    def POST(self):
        if web.input(ajax = None):
            return notify_model().count_table({'receiver':session.user_id, 'unread':'1'})
        else:
            return '0'

class delete:

    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/notifications')
    def GET(self, id):
        notify = notify_model().get_one({'id':id})
        if notify is not None and notify.receiver == session.user_id:
            notify_model().delete({'id':id})
        raise web.SeeOther('/notifications')