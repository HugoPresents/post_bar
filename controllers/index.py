import web

class index:
    def GET(self):
    	text = 'hello world!'
        return render.index(text)