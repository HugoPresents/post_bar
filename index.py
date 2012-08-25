import os
import web
urls = (
	'/', 'index',
	'/.*', 'index'
)

web.config.debug = True

render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/tpl/', base='layout')

class index:
    def GET(self):
    	text = 'hello world!'
        return render.index(text)

app = web.application(urls, globals(), autoreload=False)
application = app.wsgifunc()