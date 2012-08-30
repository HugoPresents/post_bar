import web
from config.config import db
from models import cat_model

tb = 'node'

def get_nodes():
    return db.select(tb)