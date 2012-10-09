# -- coding: utf8 --
__metaclass__ = type
import web
from models.model import *
from config.config import *

class comment_thanks_model(model):
    
    def __init__(self):
        super(comment_thanks_model, self).__init__('comment_thanks')