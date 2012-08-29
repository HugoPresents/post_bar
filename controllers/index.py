import web
from config.config import render

render = config.render

class Index:
    def GET(self):
    	text = 'hello world!'
        return render.index(text)