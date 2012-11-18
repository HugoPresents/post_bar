# -- coding: utf8 --
__metaclass__ = type
import web
from models.model import *
from config.config import *

class cat_model(model):
    
    form = web.form.Form(
        web.form.Textbox('name', notnull, size=45, description="cat name", class_='sl'),
        web.form.Textbox('display_name', notnull, size=45, description="display name", class_='sl'),
        web.form.Textarea('description', notnull, class_='mle tall', description='分类描述'),
        web.form.Button('创建', class_='super normal button')
    )
    
    def __init__(self):
        super(cat_model, self).__init__('category')