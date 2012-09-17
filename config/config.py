# -- coding: utf8 --
import os
import web
from libraries import helper

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
	# 评论主题
	'/comment/(\d+)', pre_fix + 'comment.add',
	# 注册
	'/signup', pre_fix + 'user.signup',
	# 登录
	'/login', pre_fix + 'user.login',
	# 注销
	'/logout', pre_fix + 'user.logout',
	# 设置
	'/settings', pre_fix + 'user.settings',
	# 其他
	'/.*', pre_fix + 'index.index'
)

# 模板全局变量
web.template.Template.globals['render'] = render
web.template.Template.globals['site_title'] = 'Post_bar'
web.template.Template.globals['helper'] = helper

# 表单验证规则
notnull = web.form.Validator("必填", bool)
vname = web.form.regexp(r".{3,20}$", '用户名长度必须在3-20个字符之间')
vpass = web.form.regexp(r".{5,20}$", '密码长度必须在5-20个字符之间')
vemail = web.form.regexp(r".*@.*", "请输入正确的电子邮箱")