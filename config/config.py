import os
import web

render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/', base='layout')

web.config.debug = True

pre_fix = 'controllers.'

urls = (
	'/index', pre_fix + 'index.index',
	'/.*', pre_fix + 'index.index'
)