import os
import web

render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/tpl/', base='layout')

db = web.database(dbn='mysql', db='post_bar', user='root', pw='rabbit')

web.config.debug = True

pre_fix = 'controllers.'

urls = (
	'/index', pre_fix + 'Index.index',
	'/.*', pre_fix + 'Index.index'
)

web.template.Template.globals['render'] = render