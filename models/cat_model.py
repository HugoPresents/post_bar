# -- coding: utf8 --
__metaclass__ = type
import web
from models.model import *
from config.config import *

class cat_model(model):
    
    def __init__(self):
        super(cat_model, self).__init__('category')
        self.create_form = web.form.Form(
            web.form.Textbox('name', notnull, size=45, description="分类名，用于url，english please", class_='sl'),
            web.form.Textbox('display_name', notnull, size=45, description="显示名", class_='sl'),
            web.form.Textarea('description', notnull, class_='mle tall', description='分类描述'),
            web.form.Button('创建', class_='super normal button')
        )
        self.modify_form = web.form.Form(
            web.form.Textbox('name', size=45, description="cat name", class_='sl', disabled="disabled"),
            web.form.Textbox('display_name', notnull, size=45, description="display name", class_='sl'),
            web.form.Textarea('description', notnull, class_='mle tall', description='分类描述'),
            web.form.Button('修改', class_='super normal button')
        )