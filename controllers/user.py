# -- coding: utf8 --
import web
session = web.config._session
import hashlib
import time
import random
import string
from config.config import render
from models.user_model import *
from models.user_meta_model import *
from models.post_model import *
from models.post_thanks_model import *
from models.comment_thanks_model import *
from models.node_model import *
from models.comment_model import *
from models.money_model import *
from models.money_type_model import *
from libraries.error import *
from libraries.crumb import *
from libraries.pagination import *

class login:
    
    form = user_model().login_form
    crumb = Crumb()
    
    def __init__(self):
        if session.user_id:
            raise web.SeeOther('/')
        self.title = '登录'
        self.crumb.append('登录')

    def GET(self):
        return render.login(self.form, self.title, self.crumb.output())
    
    def POST(self):
        if not self.form.validates():
            return render.login(self.form, '登录失败，请重登', self.crumb.output())
        condition = {'name' : self.form.d.name}
        # MD5加密 密码
        #condition['password'] = hashlib.md5(condition['password']).hexdigest()
        user = user_model().get_one(condition)
        if user is None:
            return render.login(self.form, '用户名不存在', self.crumb.output())
        auth_from_form = hashlib.md5(hashlib.md5(self.form.d.password).hexdigest() + user.auth).hexdigest()
        if auth_from_form != user.password:
            return render.login(self.form, '密码错误', self.crumb.output())
        user_model().update_session(user.id)
        user_model().set_cookie(user.id)
        data = web.input();
        try:
            if data['next'] is not None:
                raise web.SeeOther(data['next'])
            else:
                raise web.SeeOther('/')
        except KeyError:
            raise web.SeeOther('/')

class signup:
    
    form = user_model().signup_form
    crumb = Crumb()
    crumb.append('注册')
    
    def GET(self):
        title = '注册'
        return render.signup(self.form, title, self.crumb.output())
    
    def POST(self):
        if not self.form.validates():
            return render.signup(self.form, '注册失败，请重注', self.crumb.output())
        try:
            condition = {'name':self.form.d.name}
            user = user_model().get_one(condition)
            # 对密码进行 md5 加密
            auth = string.join(random.sample(['z','y','x','w','v','u','t','s','r','q','p','o','n','m','l','k','j','i','h','g','f','e','d','c','b','a'], 5)).replace(' ','')
            password = hashlib.md5(hashlib.md5(self.form.d.password).hexdigest() + auth).hexdigest()
            #password = hashlib.md5(self.form.d.password).hexdigest()
            if user is not None:
                raise ValueExistsError('用户名已经存在')
            condition = {'email' : self.form.d.email}
            user = user_model().get_one(condition)
            if user is not None:
                raise ValueExistsError('邮箱已经存在')
            user_model().insert({'name' : self.form.d.name, 'email' : self.form.d.email, 'password' : password, 'regist_time' : time.time(), 'auth' : auth})
        except ValueExistsError, x:
            return render.signup(self.form, x.message, self.crumb.output())
        raise web.SeeOther('/')

# 注销
class logout:
    
    def GET(self):
        session.kill()
        web.setcookie('auth', '', -1)
        raise web.SeeOther('/')

# 设置
class settings:
    
    setting_form = user_model().setting_form
    pass_form = user_model().pass_form
    crumb = Crumb()
    crumb.append('设置')

    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/settings')
    
    def GET(self):
        user = user_model().get_one({'id':session.user_id})
        self.setting_form.name.set_value(user.name)
        self.setting_form.email.set_value(user.email)
        return render.settings('设置', user, self.setting_form, self.pass_form, self.crumb.output())
    def POST(self):
        user = user_model().get_one({'id':session.user_id})
        self.setting_form.name.set_value(user.name)
        if not self.setting_form.validates():
            self.setting_form.name.set_value(user.name)
            self.setting_form.email.set_value(user.email)
            return render.settings('设置', user, self.setting_form, self.pass_form, self.crumb.output())
        else:
            user_model().update({'id':user.id}, {'email':self.setting_form.d.email})
            raise web.SeeOther('/settings')

class password:
    form = user_model().pass_form
    crumb = Crumb()
    
    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/settings/password')
    def GET(self):
        self.crumb.append('设置', '/settings')
        self.crumb.append('修改密码')
        return render.password('修改密码', self.crumb.output(), self.form)
    def POST(self):
        self.crumb.append('设置', '/settings')
        self.crumb.append('修改密码')
        user = user_model().get_one({'id':session.user_id})
        if self.form.validates():
            password = hashlib.md5(hashlib.md5(self.form.d.origin_password).hexdigest() + user.auth).hexdigest()
            if user.password == password:
                auth = string.join(random.sample(['z','y','x','w','v','u','t','s','r','q','p','o','n','m','l','k','j','i','h','g','f','e','d','c','b','a'], 5)).replace(' ','')
                new_password = hashlib.md5(hashlib.md5(self.form.d.new_password).hexdigest() + auth).hexdigest()
                user_model().update({'id':user.id}, {'password':new_password, 'auth':auth})
                raise web.SeeOther('/settings')
            else:
                return render.password('原密码不正确', self.crumb.output(), self.form)
        else:
            return render.password('修改密码', self.crumb.output(), self.form)


class profile:
    
    def GET(self, name):
        limit = 10
        user = user_model().get_one({'name':name})
        if user is None:
            crumb = Crumb()
            crumb.append('会员未找到')
            return render.user_nf('会员未找到', crumb.output())
        else:
            posts_result = post_model().get_all({'user_id':user.id}, limit = limit, order = 'time DESC')
            if len(posts_result) > 0:
                posts = []
                for post_result in posts_result:
                    post = {'post':post_result}
                    node = node_model().get_one({'id':post_result.node_id})
                    post['node'] = node
                    comment = comment_model().get_one({'post_id':post_result.id}, order='time DESC')
                    if comment:
                        comment_user = user_model().get_one({'id':comment.user_id})
                        post['comment_user'] = comment_user
                    else:
                        post['comment_user'] = None
                    posts.append(post)
            else:
                posts = None
            comments_result = comment_model().get_all({'user_id':user.id}, limit = limit, order = 'time DESC')
            if len(comments_result) > 0:
                comments = []
                for comment_result in comments_result:
                    post = post_model().get_one({'id':comment_result.post_id})
                    post_user = user_model().get_one({'id':post.user_id})
                    comment = {'post':post, 'comment':comment_result, 'post_user':post_user}
                    comments.append(comment)
            else:
                comments = None
            following = False
            if session.user_id:
                if user_meta_model().get_one({'user_id':session.user_id, 'meta_key':'follow', 'meta_value':user.id}):
                    following = True
            return render.profile(user.name, user, posts, comments, following)

class avatar:
    
    crumb = Crumb()
    
    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/settings/avatar')
        self.user = user_model().get_one({'id':session.user_id})
    
    def GET(self):
        self.crumb.append('设置', '/settings')
        self.crumb.append('上传头像')
        return render.avatar('上传头像', self.user, self.crumb.output())
    def POST(self):
        import cgi
        import os
        cgi.maxlen = 2 * 1024 * 1024 # 2MB
        try:
            x = web.input(avatar={})
        except ValueError:
            return render.avatar('上传头像', self.user, self.crumb.output(), ' <<超过大小限制')
        if 'avatar' in x:
            #客户端为windows时注意
            filepath=x.avatar.filename.replace('\\','/')
            #获取文件名
            filename=filepath.split('/')[-1]
            #获取后缀
            ext = filename.split('.', 1)[1].lower()
            ext_allow = ('jpg', 'png', 'gif', 'jpeg')
            #判断文件后缀名 
            if ext in ext_allow:
                #要上传的路径
                filedir = 'static/avatar/tmp/'
                try:
                    os.makedirs('static/avatar/tmp')
                except:
                    pass
                filename = str(session.user_id) +'.'+ext
                if os.path.exists(filedir+filename):
                    os.remove(filedir+filename)
                fout = open(filedir + filename, 'wb')
                fout.write(x.avatar.file.read())
                fout.close()
                user_model().set_avatar(filename, self.user.id)
                error = False
            else:
                message = ' <<请上传指定格式文件'
                error = True
        if error:
            return render.avatar('上传头像', self.user, self.crumb.output(), message)
        else:
            raise web.SeeOther('/settings/avatar')

# 收藏的主题
class post_favs():
    crumb = Crumb()
    
    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/my/posts')
    
    def GET(self):
        limit = 10
        self.crumb.append('我收藏的主题')
        user = user_model().get_one({'id':session.user_id})
        pagination = Pagination('/my/posts', user.post_favs, limit = limit)
        if user.post_favs > 0:
            page = pagination.true_page(web.input(p=1)['p'])
            post_favs = user_meta_model().get_all({'user_id':user.id, 'meta_key':'post_fav'}, limit = limit, offset = (page-1)*limit, order = 'id DESC')
            posts = []
            for post_fav in post_favs:
                post_result = post_model().get_one({'id':post_fav.meta_value})
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
        else:
            posts = None
        return render.post_favs('我收藏的主题', user, posts, self.crumb.output(), pagination.output())

# 来自收藏节点的主题
class node_favs:
    
    crumb = Crumb()
    
    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/my/nodes')
    
    def GET(self):
        limit = 10
        self.crumb.append('来自我收藏的节点的最新主题')
        # 取出收藏的节点id
        node_favs = user_meta_model().get_all({'user_id':session.user_id, 'meta_key':'node_fav'})
        if len(node_favs) > 0 :
            nodes = []
            for node_fav in node_favs:
                nodes.append(node_fav.meta_value)
            total_rows = post_model().count_table({'node_id':nodes})
            pagination = Pagination('/my/nodes', total_rows, limit = limit)
            page = pagination.true_page(web.input(p=1)['p'])
            posts_result = post_model().get_all(conditions = {'node_id': nodes}, order = 'time DESC', limit = limit, offset = (page-1)*limit)
            posts = []
            for post_result in posts_result:
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
        else:
            posts = None
            total_rows = 0
            pagination = Pagination('/my/nodes', total_rows)
            page = pagination.true_page(web.input(p=1)['p'])
        return render.node_favs('来自我收藏的节点的最新主题', posts, total_rows, self.crumb.output(), pagination.output())

# 用户创建的主题
class posts:
    
    def GET(self, name):
        limit = 10
        user = user_model().get_one({'name':name})
        crumb = Crumb()
        if user:
            crumb.append(name, '/profile/'+name)
            crumb.append('全部主题')
            total_rows = post_model().count_table({'user_id':user.id})
            pagination = Pagination('/profile/'+name+'/posts', total_rows, limit = limit)
            page = pagination.true_page(web.input(p=1)['p'])
            posts_result = post_model().get_all({'user_id':user.id}, limit = limit, offset = (page-1) * limit, order = 'time DESC')
            posts = []
            for post_result in posts_result:
                post = {'post':post_result}
                node = node_model().get_one({'id':post_result.node_id})
                post['node'] = node
                comment = comment_model().get_one({'post_id':post_result.id}, order='time DESC')
                if comment:
                    comment_user = user_model().get_one({'id':comment.user_id})
                    post['comment_user'] = comment_user
                else:
                    post['comment_user'] = None
                posts.append(post)
            return render.user_posts('全部主题', user,  posts, total_rows, crumb.output(), pagination.output())
        else:
            crumb.append('会员未找到')
            return render.user_nf('会员未找到', crumb.output())

# 用户创建的回复
class comments:
    
    def GET(self, name):
        limit = 10
        user = user_model().get_one({'name':name})
        crumb = Crumb()
        if user:
            crumb.append(name, '/profile/'+name)
            crumb.append('全部回复')
            total = comment_model().count_table({'user_id':user.id})
            pagination = Pagination('/profile/'+name+'/comments', total, limit = limit)
            page = pagination.true_page(web.input(p=1)['p'])
            comments_result = comment_model().get_all({'user_id':user.id}, limit = limit, offset = (page-1)*limit, order = 'time DESC')
            if len(comments_result) > 0:
                comments = []
                for comment_result in comments_result:
                    post = post_model().get_one({'id':comment_result.post_id})
                    post_user = user_model().get_one({'id':post.user_id})
                    comment = {'post':post, 'comment':comment_result, 'post_user':post_user}
                    comments.append(comment)
            else:
                comments = None
            return render.user_comments('全部回复', comments, total, crumb.output(), pagination.output())
        else:
            crumb.append('会员未找到')
            return render.user_nf('会员未找到', crumb.output())

# 关注用户
class follow:
    
    def GET(self, name):
        user = user_model().get_one({'name':name})
        if user is None:
            crumb = Crumb()
            crumb.append('会员未找到')
            return render.user_nf('会员未找到', crumb.output())
        else:
            if session.user_id is None:
                raise web.SeeOther('/login?next=/profile/'+name)
            user_meta_model().unique_insert({'user_id':session.user_id, 'meta_key':'follow', 'meta_value':user.id})
            user_model().update({'id':session.user_id}, {'user_favs':user_meta_model().count_meta({'user_id':session.user_id, 'meta_key':'follow'})})
            user_model().update_session(session.user_id)
            raise web.SeeOther('/profile/'+name)

# 取消关注用户
class unfollow:
    
    def GET(self, name):
        user = user_model().get_one({'name':name})
        if user is None:
            crumb = Crumb()
            crumb.append('会员未找到')
            return render.user_nf('会员未找到', crumb.output())
        else:
            if session.user_id is None:
                raise web.SeeOther('/login?next=/profile/'+name)
            user_meta_model().delete({'user_id':session.user_id, 'meta_key':'follow', 'meta_value':user.id})
            user_model().update({'id':session.user_id}, {'user_favs':user_meta_model().count_meta({'user_id':session.user_id, 'meta_key':'follow'})})
            user_model().update_session(session.user_id)
            raise web.SeeOther('/profile/'+name)

# 来自关注用户的帖子
class following:
    
    crumb = Crumb()
    
    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/user/nodes')
    
    def GET(self):
        limit = 10
        self.crumb.append('我关注的人的最新主题')
        # 取出收藏的节点id
        followings = user_meta_model().get_all({'user_id':session.user_id, 'meta_key':'follow'})
        if len(followings) > 0 :
           user_favs = []
           for following in followings:
               user_favs.append(following.meta_value)
           total_rows = post_model().count_table({'user_id':user_favs})
           pagination = Pagination('/my/following', total_rows, limit = limit)
           page = pagination.true_page(web.input(p=1)['p'])
           posts_result = post_model().get_all(conditions = {'user_id': user_favs}, order = 'time DESC', limit = limit, offset = (page-1)*limit)
           posts = []
           for post_result in posts_result:
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
        else:
           posts = None
           total_rows = 0
           pagination = Pagination('/my/nodes', total_rows)
           page = pagination.true_page(web.input(p=1)['p'])
        return render.following_posts('来自我收藏的节点的最新主题', posts, total_rows, self.crumb.output(), pagination.output())

class balance:
    
    crumb = Crumb()
    
    def __init__(self):
        if session.user_id is None:
            raise web.SeeOther('/login?next=/balance')
        
    def GET(self):
        limit = 20
        total = money_model().count_table({'user_id':session.user_id})
        pagination = Pagination('/balance', total, limit = limit)
        page = pagination.true_page(web.input(p=1)['p'])
        records_result = money_model().get_all({'user_id':session.user_id}, limit = limit, offset = (page-1)*limit, order = 'id DESC')
        money_types_result = money_type_model().get_all()
        money_type = {}
        for money_type_result in money_types_result:
            money_type[money_type_result.id] = money_type_result.name
        records = []
        for record_result in records_result:
            # 发布的帖子或者是评论的帖子
            post = None
            # 发布或者收到的评论
            post_user = None
            post_thanks = None
            comment_thanks = None
            sender = None
            comment = None
            # 评论的用户
            comment_user = None
            try:
                type = money_type[record_result.money_type_id]
                if type == 'post':
                    post = post_model().get_one({'id':record_result.foreign_id})
                if type == 'comment':
                    comment = comment_model().get_one({'id':record_result.foreign_id})
                    comment_user = user_model().get_one({'id':comment.user_id})
                    post = post_model().get_one({'id':comment.post_id})
                if type == 'post_thanks':
                    post_thanks = post_thanks_model().get_one({'id':record_result.foreign_id})
                    post = post_model().get_one({'id':post_thanks.post_id})
                    sender = user_model().get_one({'id':post_thanks.user_id})
                    post_user = user_model().get_one({'id':post.user_id})
                if type == 'comment_thanks':
                    comment_thanks = comment_thanks_model().get_one({'id':record_result.foreign_id})
                    comment = comment_model().get_one({'id':comment_thanks.comment_id})
                    post = post_model().get_one({'id':comment.post_id})
                    comment_user = user_model().get_one({'id':comment.user_id})
                    sender = user_model().get_one({'id':comment_thanks.user_id})
            # 如果数据错误将不把这条记录输出到视图
            except AttributeError:
                continue
            else:
                record = {'record':record_result, 'type':type, 'comment':comment, 'post':post, 'post_user':post_user, 'sender':sender, 'comment_user':comment_user, 'post_thanks':post_thanks, 'comment_thanks':comment_thanks}
                records.append(record)
        self.crumb.append('账户余额')
        return render.money_record('账户余额', records, self.crumb.output(), pagination.output())