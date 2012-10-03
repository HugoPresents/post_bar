# -- coding: utf8 --
import web
import time
from config.config import render
from models.post_model import *
from models.node_model import *
from models.user_model import *
from models.user_meta_model import *
from models.comment_model import *
from models.money_model import *
from models.money_type_model import *
from libraries.crumb import Crumb
from libraries.helper import *

# 查看单个帖子
class view:
    
    crumb = Crumb()
    
    def POST(self, id):
        raise web.SeeOther('/post/' + str(id))
    
    def GET(self, id):
        post_model().add_view(id)
        post = post_model().get_one({'id':id})
        if post is None:
            self.crumb.append('主题未找到')
            return render.post_nf('主题未找到', self.crumb.output())
        else:
            post_fav = False
            if web.config._session.user_id:
                if user_meta_model().get_one({'user_id':web.config._session.user_id, 'meta_key':'post_fav', 'meta_value':post.id}):
                    post_fav = True
            favs = user_meta_model().count_meta({'meta_key':'post_fav','meta_value':id})
            node = node_model().get_one({'id':post.node_id})
            user = user_model().get_one({'id':post.user_id})
            #return user.name
            self.crumb.append(node.display_name, '/node/'+node.name)
            condition = {'post_id' : post.id}
            comments_result = comment_model().get_all(condition, order = 'time ASC')
            comments = []
            if comments_result is not None:
                for comment_result in comments_result:
                    comment_user = user_model().get_one({'id':comment_result.user_id})
                    comments.append({'comment':comment_result, 'user':comment_user})
            form = comment_model().form
            return render.post_view(post, user, comments, form, post_fav, favs, self.crumb.output())

# 创建帖子
class create:
    
    crumb = Crumb()
    form = post_model().form
    
    def GET(self, node_name):
        if web.config._session.user_id is None:
            raise web.SeeOther('/login?next=/post/create/' + node_name)
        conditions = {'name' : node_name}
        node = node_model().get_one(conditions)
        self.crumb.append(node.display_name, '/node/'+node.name)
        self.crumb.append('创建新主题')
        if node is None:
            self.crumb.claer()
            return render.not_found('节点未找到', '节点未找到')
        title = '创建主题'
        return render.create_post(self.form, title, self.crumb.output())
        
    def POST(self, node_name):
        if web.config._session.user_id is None:
            raise web.SeeOther('/login?next=/post/create' + node_name)
        conditions = {'name' : node_name}
        node = node_model().get_one(conditions)
        if node is None:
            return render.not_found('节点未找到', '节点未找到')
        if not self.form.validates():
            return render.create_post(self.form, '创建失败， 请重创:D', self.crumb.output())
        user_model().update_session(web.config._session.user_id)
        cost = money_model().cal_post(self.form.d.content)
        if web.config._session.money < cost:
            self.crumb.append('财富不够')
            return render.no_money('财富不够', '你的财富值不够，不能创建改主题 :(', self.crumb.output())
        title = html_to_db(self.form.d.title)
        content = html_to_db(self.form.d.content)
        post_id = post_model().insert({'title' : title, 'content' : content, 'node_id' : node.id, 'time' : time.time(), 'user_id' : web.config._session.user_id})
        money_type_id = money_type_model().get_one({'name':'post'})['id']
        money_model().insert({'user_id':web.config._session.user_id, 'money_type_id':money_type_id, 'amount':cost, 'foreign_id':post_id})
        user_model().update_money(web.config._session.user_id, -cost)
        user_model().update_session(web.config._session.user_id)
        raise web.seeother('/post/' + str(post_id))

# 收藏帖子
class fav:
    
    crumb = Crumb()
    
    def GET(self, post_id):
        post = post_model().get_one({'id':post_id})
        if post is None:
            self.crumb.append('主题未找到')
            return render.post_nf('主题未找到', self.crumb.output())
        if web.config._session.user_id is None:
            raise web.SeeOther('/login?next=/post/fav/'+post_id)
        user_meta_model().unique_insert({'user_id':web.config._session.user_id, 'meta_key':'post_fav', 'meta_value':post_id})
        user_model().update({'id':web.config._session.user_id}, {'post_favs':user_meta_model().count_meta({'user_id':web.config._session.user_id, 'meta_key':'post_fav'})})
        user_model().update_session(web.config._session.user_id)
        raise web.SeeOther('/post/'+post_id)

class unfav:
    
    def GET(self, post_id):
        if web.config._session.user_id is None:
                raise web.SeeOther('/login?next=/post/unfav/'+post_id)
        user_meta_model().delete({'user_id':web.config._session.user_id, 'meta_key':'post_fav','meta_value':post_id})
        user_model().update({'id':web.config._session.user_id}, {'post_favs':user_meta_model().count_meta({'user_id':web.config._session.user_id, 'meta_key':'post_fav'})})
        user_model().update_session(web.config._session.user_id)
        raise web.SeeOther('/post/'+post_id)