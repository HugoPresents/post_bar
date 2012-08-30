import web
from config.config import db
from models import cat_model
from libraries.helper import *

tb = 'node'

def get_nodes():
    return db.select(tb)

def get_node(conditions = None):
    where = dict2where(conditions)
    return db.select(tb, where = where)[0]