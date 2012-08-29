#import sys, os
#abspath = os.path.dirname(__file__)
#sys.path.append(abspath)
#os.chdir(abspath)
import web
from config.config import *

app = web.application(urls, globals())
application = app.wsgifunc()
#if __name__ == "__main__":
#    app.run()