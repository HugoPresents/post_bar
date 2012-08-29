import web
from config.config import *

app = web.application(urls, globals())
if __name__ == "__main__":
	app.run()