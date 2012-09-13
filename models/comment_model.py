# -- coding: utf8 --
__metaclass__ = type
import web
from models.model import *
from config.config import *

class comment_model(model):
    form = web.form.Form(
       web.form.Textarea('content', notnull, rows=5, cols=80, description=''),
       web.form.Button('评论')
    )
     
    def __init__(self):
        super(comment_model, self).__init__('comment')