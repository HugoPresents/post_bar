# -- coding: utf8 --
import os
import web

render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/', base='layout')

db = web.database(dbn='mysql', db='post_bar', user='root', pw='rabbit')

web.config.debug = True

site_title = 'Post Bar'

pre_fix = 'controllers.'

urls = (
	# 首页
	'/index', pre_fix + 'index.index',
	# 浏览主题
	'/post/(\d+)', pre_fix + 'post.view',
	# 创建主题
	'/create/(\w+)', pre_fix + 'post.create',
	# 节点主题列表
	'/node/(\w+)', pre_fix + 'node.index',
	# 注册
	'/signup', pre_fix + 'user.signup',
	# 登录
	'/login', pre_fix + 'user.login',
	# 注销
	'/logout', pre_fix + 'user.logout',
	# 其他
	'/.*', pre_fix + 'index.index'
)

# 模板全局变量
web.template.Template.globals['render'] = render
web.template.Template.globals['site_title'] = 'Post_bar'