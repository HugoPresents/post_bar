# -- coding: utf8 --
__metaclass__ = type
import web
from config.config import db
from libraries.helper import *

class model:
    __tb = None
    def __init__(self, tb = None):
        self.__tb = tb
    
    def get_one(self, conditions = None, order = None, limit = 1):
        where = dict2where(conditions)
        try:
            return db.select(self.__tb, where = where, order = order, limit = limit)[0]
        except IndexError:
            return None
    
    def get_all(self, conditions = None, order = None, limit = None):
        where = dict2where(conditions)
        return db.select(self.__tb, where = where, order = order, limit = limit)
    
    def insert(self, **values):
        def q(x): return "(" + x + ")"
        
        if values:
            sql_query = 'INSERT INTO '+ self.__tb + q(', '.join(values.keys())) + ' VALUES' + q(', '.join('\''+str(_value)+'\'' for _value in values.values()))
            db.query(sql_query)
            return self.last_insert_id()
        else:
           return None
    
    def last_insert_id(self):
        return db.query('select last_insert_id() as id')[0].id