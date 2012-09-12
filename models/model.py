# -- coding: utf8 --
import web
from config.config import db
from libraries.helper import *

class model:
    tb = None
    def __init__(self, tb = None):
        self.tb = tb
    
    def get_one(self, conditions, order = None, limit = 1):
        where = dict2where(conditions)
        try:
            return db.select(self.tb, where = where, order = order, limit = limit)[0]
        except IndexError:
            return None
    
    def get_all(self, conditions, order = None, limit = None):
        where = dict2where(conditions)
        return db.select(self.tb, order = order, limit = limit)
    
    def insert(self, **param):
        if param is None:
            return None
        else:
            #sql = 'INSERT INTO %s' % (self.tb)
            sql = ''
            for key, value in param.item():
                sql += '%s=\'%s\', '