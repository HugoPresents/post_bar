import sys, os
abspath = os.path.dirname(__file__)
sys.path.append(abspath)
os.chdir(abspath)
import web
from config.config import *

app = web.application(urls, globals(), autoreload = True)

if web.config.get('_session') is None:
    session = web.session.Session(app, web.session.DiskStore('sessions'), initializer={'user_id': None})
    #curdir = os.path.dirname(__file__)
    #session = web.session.Session(app, web.session.DiskStore(os.path.join(curdir,'sessions')), initializer={'user_id': None})
    web.config._session = session
else:
    session = web.config._session
    
web.template.Template.globals['session'] = session  
application = app.wsgifunc()
#if __name__ == "__main__":
#    app.run()