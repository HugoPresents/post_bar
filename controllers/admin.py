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

class admin:
    crumb = Crumb()
    def __init__(self):
        if session.user_id != 1:
            raise web.SeeOther('/')
        self.crumb.append('后台', '/admin')

class index(admin):
    
    def GET(self):
        
        cat_result = cat_model().get_all()
        cats = []
        for cat in cat_result:
            node_total = node_model().count_table({'category_id':cat.id})
            cats.append({'cat':cat, 'node_total':node_total})
        return admin_render.index('后台', cats, self.crumb.output())

class cat(admin):

    form = cat_model().modify_form

    def GET(self, cat_name):
        cat = cat_model().get_one({'name':cat_name})
        if cat is None:
            self.crumb.append('分类不存在')
            return admin_render.cat_nf('分类不存在', self.crumb.output())
        else:
            self.crumb.append(cat.display_name)
            nodes = node_model().get_all({'category_id':cat.id})
            self.form.name.set_value(cat.name)
            self.form.display_name.set_value(cat.display_name)
            self.form.description.set_value(cat.description)
            return admin_render.cat_view(cat.display_name, self.crumb.output(), cat, self.form, nodes)

    def POST(self, cat_name):
        cat = cat_model().get_one({'name':cat_name})
        if cat is None:
            self.crumb.append('分类不存在')
            return admin_render.cat_nf('分类不存在', self.crumb.output())
        else:
            if self.form.validates():
                cat_model().update({'name':cat.name}, {'display_name':self.form.d.display_name, 'description':self.form.d.description})
                web.SeeOther('/admin/cat/'+cat.name)
            else:
                self.form.name.set_value(cat.name)
                self.form.display_name.set_value(cat.display_name)
                self.form.description.set_value(cat.description)
                web.SeeOther('/admin/cat/'+cat.name)

class create_cat(admin):
    form = cat_model.create_form

    def GET(self):
        self.crumb.append('添加新分类')
        return admin_render.create_cat('添加新分类', self.crumb.output(), self.form)
    def POST(self):
        if self.form.validates():
            if cat_model().unique_insert({'name':self.form.d.name}):
                # 为了保证不插入空的display_name的分类，故此
                try:
                    cat_model().update({'name':self.form.d.name}, {'display_name':self.form.d.display_name, 'description':self.form.d.description})
                except:
                    cat_model().delete({'name':self.form.d.name})
                web.SeeOther('/admin/cat/'+self.form.d.name)
            else:
                return admin_render.create_cat('分类名已存在', self.crumb.output(), self.form)

class node(admin):
    form = node_model.modify_form

    def GET(self, node_name):
        node = node_model().get_one({'name':node_name})
        if node is None:
            return admin_render.node_nf('节点不存在', self.crumb.output())
        ##return node
        cat = cat_model().get_one({'id':node.category_id})
        self.form.name.set_value(node.name)
        self.form.display_name.set_value(node.display_name)
        self.form.description.set_value(node.description)
        self.crumb.append(cat.display_name, '/admin/cat/'+cat.name)
        self.crumb.append(node.display_name)
        return admin_render.node_view(node.display_name, self.crumb.output(), node, self.form)

    def POST(self, node_name):
        node = node_model().get_one({'name':node_name})
        if node is None:
            return admin_render.node_nf('节点不存在', self.crumb.output())
        if self.form.validates():
            node_model().update({'name':node.name}, {'display_name':self.form.d.display_name, 'description':self.form.d.description})
            raise web.SeeOther('/admin/node/'+node.name)

class set_node_icon(admin):

    def GET(self, node_name):
        node = node_model().get_one({'name':node_name})
        if node is None:
            return admin_render.node_nf('节点不存在', self.crumb.output())
        cat = cat_model().get_one({'id':node.category_id})
        self.crumb.append(cat.display_name, '/admin/cat/'+cat.name)
        self.crumb.append(node.display_name, '/admin/node/'+node.name)
        self.crumb.append('设置节点图标')
        return admin_render.set_node_icon('设置节点图标', self.crumb.output(), node)

    def POST(self, node_name):
        node = node_model().get_one({'name':node_name})
        if node is None:
            return admin_render.node_nf('节点不存在', self.crumb.output())
        cat = cat_model().get_one({'id':node.category_id})
        self.crumb.append(cat.display_name, '/admin/cat/'+cat.name)
        self.crumb.append(node.display_name, '/admin/node/'+node.name)
        self.crumb.append('设置节点图标')
        import cgi
        import os
        cgi.maxlen = 2 * 1024 * 1024 # 2MB
        try:
            x = web.input(icon={})
        except ValueError:
            return admin_render.set_node_icon('设置节点图标', self.crumb.output(), node, ' <<超过大小限制')
        if 'icon' in x:
            #客户端为windows时注意
            filepath=x.icon.filename.replace('\\','/')
            #获取文件名
            filename=filepath.split('/')[-1]
            #获取后缀
            ext = filename.split('.', 1)[1].lower()
            ext_allow = ('jpg', 'png', 'gif', 'jpeg')
            #判断文件后缀名 
            if ext in ext_allow:
                #要上传的路径
                filedir = 'static/icons/tmp/'
                try:
                    os.makedirs('static/icons/tmp')
                except:
                    pass
                filename = str(session.user_id) +'.'+ext
                if os.path.exists(filedir+filename):
                    os.remove(filedir+filename)
                fout = open(filedir + filename, 'wb')
                fout.write(x.icon.file.read())
                fout.close()
                node_model().set_icon(filename, node.id)
                error = False
            else:
                message = ' <<请上传指定格式文件'
                error = True
        if error:
            return admin_render.set_node_icon('设置节点图标', self.crumb.output(), node, message)
        else:
            raise web.SeeOther('/admin/node/icon/'+node.name)

class create_node(admin):
    form = node_model.create_form

    def GET(self, cat_name):
        cat = cat_model().get_one({'name':cat_name})
        if cat is None:
            self.crumb.append('分类不存在')
            return admin_render.cat_nf('分类不存在', self.crumb.output())
        self.crumb.append(cat.name, '/admin/cat/'+cat.name)
        self.crumb.append('添加新节点')
        return admin_render.create_node('添加新节点', self.crumb.output(), cat, self.form)

    def POST(self, cat_name):
        cat = cat_model().get_one({'name':cat_name})
        if cat is None:
            self.crumb.append('分类不存在')
            return admin_render.cat_nf('分类不存在', self.crumb.output())
        if self.form.validates():
            if node_model().unique_insert({'name':self.form.d.name}):
                # 为了保证不插入空的display_name的节点，故此
                try:
                    node_model().update({'name':self.form.d.name}, {'category_id':cat.id, 'display_name':self.form.d.display_name, 'description':self.form.d.description})                
                except:
                    node_model().delete({'name':self.form.d.name})
                web.SeeOther('/admin/node/'+self.form.d.name)
            else:
                return admin_render.create_cat('节点名已存在', self.crumb.output(), self.form)
