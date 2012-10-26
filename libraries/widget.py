# -- coding: utf8 --
__metaclass__ = type

import web
render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/widget/')

def widget_generator(widget_name):
    eval(widget_name+'().run()')
    
class widget:
    
    def run(self):
        pass