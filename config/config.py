import os
import web

render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/', base='layout')

db = web.database(dbn='mysql', db='post_bar', user='root', pw='rabbit')

web.config.debug = True

site_title = 'Post Bar'

pre_fix = 'controllers.'

urls = (
	'/index', pre_fix + 'index.index',
	'/.*', pre_fix + 'index.index'
)

web.template.Template.globals['render'] = render