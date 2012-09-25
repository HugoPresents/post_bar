# -- coding: utf8 --
import web
import hashlib
import time
from config.config import render
from models.user_model import *
from models.post_model import *
from models.node_model import *
from models.comment_model import *
from libraries.error import *
from libraries.crumb import *

class login:
    
    form = user_model().login_form
    crumb = Crumb()
    
    def __init__(self):
        if web.config._session.user_id:
            raise web.SeeOther('/')
    
    def GET(self):
        title = '登录'
        self.crumb.append('登录')
        return render.login(self.form, title, self.crumb.output())
    
    def POST(self):
        if not self.form.validates():
            return render.login(self.form, '登录失败，请重登')
        condition = {'name' : self.form.d.name, 'password' : self.form.d.password}
        # MD5加密 密码
        condition['password'] = hashlib.md5(condition['password']).hexdigest()
        user = user_model().get_one(condition)
        if user is None:
            return render.login(self.form, '登录失败，请重登')
        user_model().update_session(user.id)
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
            password = hashlib.md5(self.form.d.password).hexdigest()
            user = get_user(condition)
            if user is not None:
                raise ValueExistsError('用户名已经存在')
            condition = {'email' : email}
            user = user_model().get_one(condition)
            if user is not None:
                raise ValueExistsError('邮箱已经存在')
            user_model().insert({'name' : name, 'email' : email, 'password' : password, 'regist_time' : time.time()})
        except ValueExistsError, x:
            return render.signup(self.form, x.message, self.crumb.output())
        raise web.seeOther('/')

# 注销
class logout:
    
    def GET(self):
        web.config._session.kill()
        raise web.SeeOther('/')

# 设置
class settings:
    
    settings_form = user_model().setting_form
    pass_form = user_model().pass_form
    crumb = Crumb()
    crumb.append('设置')
    
    def __init__(self):
        if web.config._session.user_id is None:
            raise web.SeeOther('/login?next=/settings')
    
    def GET(self):
        user = user_model().get_one({'id':web.config._session.user_id})
        self.settings_form.name.set_value(user.name)
        self.settings_form.email.set_value(user.email)
        return render.settings('设置', self.settings_form, self.pass_form, self.crumb.output())
    def POST(self):
        user = user_model().get_one({'id':web.config._session.user_id})
        self.settings_form.name.set_value(user.name)
        if not self.settings_form.validates():
            self.settings_form.name.set_value(user.name)
            self.settings_form.email.set_value(user.email)
            return render.settings('设置', self.settings_form, self.pass_form, self.crumb.output())
        else:
            user_model().update({'id':user.id}, email=self.settings_form.d.email)
            raise web.SeeOther('/settings')

class profile:
    
    def GET(self, name):
        user = user_model().get_one({'name':name})
        if user is None:
            crumb = Crumb()
            crumb.append('会员未找到')
            return render.user_nf('会员未找到', crumb.output())
        else:
            posts_result = post_model().get_all({'user_id':user.id}, limit = 10, order = 'time DESC')
            if len(posts_result) > 0:
                posts = []
                for post_result in posts_result:
                    post = {'post':post_result}
                    node = node_model().get_one({'id':post_result.node_id})
                    post['node'] = node
                    comment = comment_model().get_one({'post_id':post_result.id}, 'time DESC')
                    if comment:
                        comment_user = user_model().get_one({'id':comment.user_id})
                        post['comment_user'] = comment_user
                    else:
                        post['comment_user'] = None
                    posts.append(post)
            else:
                posts = None
            comments_result = comment_model().get_all({'user_id':user.id}, limit = 10, order = 'time DESC')
            if len(comments_result) > 0:
                comments = []
                for comment_result in comments_result:
                    post = post_model().get_one({'id':comment_result.post_id})
                    post_user = user_model().get_one({'id':post.user_id})
                    comment = {'post':post, 'comment':comment_result, 'post_user':post_user}
                    comments.append(comment)
            else:
                comments = None
            return render.profile(user.name, user, posts, comments)

class avatar:
    
    crumb = Crumb()
    
    def __init__(self):
        if web.config._session.user_id is None:
            raise web.SeeOther('/login?next=/settings/avatar')
    
    def GET(self):
        self.crumb.append('设置', '/settings/')
        self.crumb.append('上传头像')
        user = user_model().get_one({'id':web.config._session.user_id})
        return render.avatar('上传头像', user, self.crumb.output())
    def POST(self):
        x = web.input(myfile={})
        if 'myfile' in x:
            filepath=x.myfile.filename.replace('\\','/')                                       #客户端为windows时注意
            filename=filepath.split('/')[-1]                                                           #获取文件名
            ext = filename.split('.', 1)[1]                                                              #获取后缀
            if ext == 'jpg':                                                                                       #判断文件后缀名
                homedir = os.getcwd()
                filedir = '%s/static/upload' %homedir #要上传的路径
                now=datetime.now()
                t ="%d%d%d%d%d%d" %(now.year,now.month,now.day,now.hour,now.minute,now.second) #以时间作为文件名
                filename = t+'.'+ext
                fout = open(filedir +'/'+ filename,'w')
                fout.write(x.myfile.file.read())
                fout.close()
                message = u'OK！'
                error = False
            else:
                message = '请上传jpg格式的文件！'
                error = True