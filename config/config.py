# -- coding: utf8 --
import os
import web

db = web.database(dbn='mysql', db='post_bar', user='root', pw='rabbit')
render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/', base='layout')
admin_render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/admin', base='layout')

web.config.debug = True

# 模板全局变量
site_title = 'Post_bar'

# 表单验证规则
notnull = web.form.Validator("必填", bool)
vname = web.form.regexp(r".{3,20}$", '用户名长度必须在3-20个字符之间')
vpass = web.form.regexp(r".{5,20}$", '密码长度必须在5-20个字符之间')
vemail = web.form.regexp(r".*@.*", "请输入正确的电子邮箱")