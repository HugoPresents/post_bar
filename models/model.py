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
        if param:
            def q(x): return "(" + x + ")"
            
            if values:
                _keys = SQLQuery.join(values.keys(), ', ')
                _values = SQLQuery.join([sqlparam(v) for v in values.values()], ', ')
                sql_query = "INSERT INTO %s " % self.tb + q(_keys) + ' VALUES ' + q(_values)
                db.query(sql_query)
                return self.last_insert_id()
        else:
           return None
    
    def last_insert_id(self):
        return db.query('select last_insert_id() as id')[0].id