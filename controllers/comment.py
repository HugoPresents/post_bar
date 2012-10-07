# -- coding: utf8 --
import web
import time
from config.config import render
from models.comment_model import *
from models.post_model import *
from models.money_model import *
from models.money_type_model import *
from models.user_model import *
from libraries.helper import *

class add:
    
    form = comment_model().form
    
    def GET(self, post_id):
        raise web.SeeOther('/post/' + post_id)
    
    def POST(self, post_id):
        if web.config._session.user_id is None:
            raise web.SeeOther('/login')
        post = post_model().get_one({'id':post_id})
        if post is not None:
            if not self.form.validates():
                raise web.SeeOther('/post/' + post_id)
            else:
                user_model().update_session(web.config._session.user_id)
                length, cost = money_model().cal_comment(self.form.d.content)
                if web.config._session.money < cost:
                    self.crumb.append('财富不够')
                    return render.no_money('财富不够', '你的财富值不够，不能创建改主题 :(', self.crumb.output())
                content = html2db(self.form.d.content)
                comment_id = comment_model().insert({'user_id' : web.config._session.user_id, 'post_id' : post_id, 'content' : content, 'time' : int(time.time())})
                money_type_id = money_type_model().get_one({'name':'comment'})['id']
                money_model().insert({'user_id':web.config._session.user_id, 'money_type_id':money_type_id, 'amount':-cost, 'length':length, 'balance':user_model().update_money(web.config._session.user_id, -cost), 'foreign_id':comment_id})
                if web.config._session.user_id != post.user_id:
                    money_model().insert({'user_id':post.user_id, 'money_type_id':money_type_id, 'amount':cost, 'length':length, 'foreign_id':comment_id, 'balance':user_model().update_money(post.user_id, cost)})
                user_model().update_session(web.config._session.user_id)
                post_model().count_comment(post_id)
                raise web.SeeOther('/post/' + post_id)
        else:
             raise web.SeeOther('/post/' + post_id)