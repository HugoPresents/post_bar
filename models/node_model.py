import web
from config.config import db
from models import cat_model
from libraries.helper import *

tb = 'node'

def get_nodes(conditions = None):
    where = dict2where(conditions)
    return db.select(tb, where = where)

def get_nodes_with_cat():
    cats = cat_model.get_cats()
    nodes_all = {}
    for cat in cats:
        conditions = {'category_id' : cat.id}
        nodes = get_nodes(conditions)
        nodes_all.update({'$cat.name' : nodes})
    return nodes_all
        

def get_node(conditions = None):
    where = dict2where(conditions)
    return db.select(tb, where = where)[0]