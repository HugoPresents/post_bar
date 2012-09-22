# -- coding: utf8 --
__metaclass__ = type
import web
from config.config import db
from libraries.helper import *

class model:
    _tb = None
    def __init__(self, tb = None):
        self._tb = tb
    
    def get_one(self, conditions = None, order = None, limit = 1):
        where = dict2where(conditions)
        try:
            return db.select(self._tb, where = where, order = order, limit = limit)[0]
        except IndexError:
            return None
    
    def get_all(self, conditions = None, order = None, limit = None):
        where = dict2where(conditions)
        return db.select(self._tb, where = where, order = order, limit = limit)
    
    def insert(self, **values):
        def q(x): return "(" + x + ")"
        if values:
            sql_query = 'INSERT INTO '+ self._tb + q(', '.join(values.keys())) + ' VALUES' + q(', '.join('\''+str(_value)+'\'' for _value in values.values()))
            db.query(sql_query)
            return self.last_insert_id()
        else:
           return None
    
    def update(self, condition, **values):
        where = dict2where(condition)
        update = dict2update(values)
        if values is not None:
            sql_query = 'UPDATE ' + self._tb + ' SET ' + update + ' WHERE ' + where + ' LIMIT 1'
            db.query(sql_query)
        return True
    
    def query(self, sql):
        db.query(sql)
    
    def last_insert_id(self):
        return db.query('select last_insert_id() as id')[0].id
    
    def table_name(self):
        return self._tb