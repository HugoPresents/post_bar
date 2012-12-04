# -- coding: utf8 --
import web
session = web.config._session
import time
from config.config import render
from models.comment_model import *
from models.comment_thanks_model import *
from models.post_model import *
from models.money_model import *
from models.money_type_model import *
from models.user_model import *
from models.notify_model import *
from models.notify_type_model import *
from libraries.helper import *

class create:
    
    def __init__(self):
        self.form = comment_model().form
    
    def GET(self, post_id):
        raise web.SeeOther('/post/' + post_id)
    
    def POST(self, post_id):
        if session.user_id is None:
            raise web.SeeOther('/login')
        post = post_model().get_one({'id':post_id})
        if post is not None:
            if not self.form.validates():
                raise web.SeeOther('/post/' + post_id)
            else:
                user_model().update_session(session.user_id)
                length, cost = money_model().cal_comment(self.form.d.content)
                if session.money < cost:
                    self.crumb.append('财富不够')
                    return render.no_money('财富不够', '你的财富值不够，不能创建改主题 :(', self.crumb.output())
                content = html2db(self.form.d.content)
                content, receiver_list = notify_model().convert_content(content)
                create_time = time.time()
                comment_id = comment_model().insert({'user_id' : session.user_id, 'post_id' : post_id, 'content' : content, 'time' : create_time})
                money_type_id = money_type_model().get_one({'name':'comment'})['id']
                money_model().insert({'user_id':session.user_id, 'money_type_id':money_type_id, 'amount':-cost, 'length':length, 'balance':user_model().update_money(session.user_id, -cost), 'foreign_id':comment_id})
                if session.user_id != post.user_id:
                    money_model().insert({'user_id':post.user_id, 'money_type_id':money_type_id, 'amount':cost, 'length':length, 'foreign_id':comment_id, 'balance':user_model().update_money(post.user_id, cost)})
                    # notify
                    notify_model().insert({'user_id':session.user_id, 'receiver':post.user_id, 'type_id':notify_type_model().get_one({'name':'comment'}).id, 'foreign_id':comment_id})
                # notify
                receiver_list = list_diff(receiver_list, [session.name, user_model().get_one({'id':post.user_id}).name])
                notify_model().insert_notify(session.user_id, receiver_list, 'comment_at', comment_id)
                user_model().update_session(session.user_id)
                post_model().update({'id':post_id}, {'last_update':create_time})
                post_model().count_comment(post_id)
                raise web.SeeOther('/post/' + post_id)
        else:
             raise web.SeeOther('/post/' + post_id)

class thanks:
    def POST(self):
        import json
        json_dict = {'success':0, 'msg':'', 'script':''}
        comment_id = web.input(comment_id=None)['comment_id']
        comment = comment_model().get_one({'id':comment_id})
        if comment_id and comment:
            if session.user_id is None:
                post = post_model().get_one({'id':comment.post_id})
                json_dict['msg'] = '你要先登录的亲'
                json_dict['script'] = 'location.href=\'/login?next=/post/'+str(post.id)+'#reply-'+str(comment_id)+'\''
            elif comment.user_id != session.user_id:
                comment_thanks_id = comment_thanks_model().unique_insert({'user_id':session.user_id, 'comment_id':comment_id})
                if comment_thanks_id:
                    comment_thanks_model().update({'id':comment_thanks_id}, {'time':int(time.time())})
                    cost = money_model().cal_thanks()
                    money_type_id = money_type_model().get_one({'name':'comment_thanks'})['id']
                    money_model().insert({'user_id':session.user_id, 'money_type_id':money_type_id, 'amount':-cost, 'balance':user_model().update_money(session.user_id, -cost), 'foreign_id':comment_thanks_id})
                    money_model().insert({'user_id':comment.user_id, 'money_type_id':money_type_id, 'amount':cost, 'foreign_id':comment_thanks_id, 'balance':user_model().update_money(comment.user_id, cost)})
                    comment_model().count_thanks(comment_id)
                    user_model().update_session(session.user_id)
                    json_dict['success'] = 1
                else:
                    json_dict['msg'] = '你已经感谢过了不是吗？'
            else:
                json_dict['msg'] = '你不能感谢你自己不是吗？'
        else:
            json_dict['message'] = '评论不存在'
        return json.dumps(json_dict)