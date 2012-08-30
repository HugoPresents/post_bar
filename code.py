import web
from config.config import *

app = web.application(urls, globals())

if web.config.get('_session') is None:
	session = web.session.Session(app, web.session.DiskStore('sessions'), initializer={'user_id': None})
	web.config._session = session
else:
	session = web.config._session
web.template.Template.globals['session'] = session
if __name__ == "__main__":
	app.run()