import web
from config.config import db
from libraries.helper import *

tb = 'category'

def get_cats():
    return db.select(tb)

def get_cat(conditions = None):
    where = dict2where(conditions)
    try:
        return db.select(tb, where = where)[0]
    except IndexError:
        return None