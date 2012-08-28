import sys, os
abspath = os.path.dirname(__file__)
sys.path.append(abspath)
os.chdir(abspath)
import web
from config.config import *

app = web.application(urls, globals(), autoreload=False)
application = app.wsgifunc()