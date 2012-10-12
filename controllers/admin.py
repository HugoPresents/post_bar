# -- coding: utf8 --
import web
from config.config import *
from models.node_model import *
from models.cat_model import *

class index:
    
    def GET(self):
        return admin_render.index('管理')