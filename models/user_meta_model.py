#  coding: utf8 
__metaclass__ = type
from models.model import *
from config.config import *

class user_meta_model(model):
    def __init__(self):
        super(user_meta_model, self).__init__('user_meta')
    
    def count_meta(self, user_id, meta_key):
        return len(self.get_all({'user_id':user_id, 'meta_key':meta_key}))
        