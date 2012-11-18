# -- coding: utf8 --
__metaclass__ = type

import os
import web
from models.node_model import *
from models.cat_model import *
from models.post_model import *
from models.user_model import *
from models.comment_model import *
render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/widget/')

def generator(widget_name):
    return eval(widget_name+'().run()')
    
class widget:
    
    def run(self):
        pass

class site_statics_widget(widget):


    def run(self):
        site_count = {}
        site_count['user'] = user_model().count_table()
        site_count['post'] = post_model().count_table()
        site_count['comment'] = comment_model().count_table()
        return render.site_statics(site_count)