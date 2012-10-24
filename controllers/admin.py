# -- coding: utf8 --
__metaclass__ = type
session = web.config._session
from config.config import *
from models.node_model import *
from models.cat_model import *


class index:
    
    def __init__(self):
        if session.user_id != 1:
            raise web.SeeOther('/')
    
    def GET(self):
        return admin_render.index('管理')