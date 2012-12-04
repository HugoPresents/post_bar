# -- coding: utf8 --
__metaclass__ = type
from models.model import *
from config.config import *

class node_model(model):

    def __init__(self):
        super(node_model, self).__init__('node')
        self.create_form = web.form.Form(
            web.form.Textbox('name', notnull, size=45, description="节点名，用于url，english please", class_='sl'),
            web.form.Textbox('display_name', notnull, size=45, description="显示名", class_='sl'),
            web.form.Textarea('description', notnull, class_='mle tall', description='分类描述'),
            web.form.Button('创建', class_='super normal button')
        )
        self.modify_form = web.form.Form(
            web.form.Textbox('name', size=45, description="node name", class_='sl', disabled="disabled"),
            web.form.Textbox('display_name', notnull, size=45, description="display name", class_='sl'),
            web.form.Textarea('description', notnull, class_='mle tall', description='分类描述'),
            web.form.Button('修改', class_='super normal button')
        )
    
    def set_icon(self, filename, node_id):
        import Image
        import os
        path = 'static/icons/'
        im = Image.open(path+'tmp/'+filename)
        size = im.size
        if size[0] > size[1]:
            crop_size = size[1]
            left = (size[0]-size[1])/2
            right = size[1] + left
            upper = 0
            lower = size[1]
        else:
            crop_size = size[0]
            left = 0
            right = size[0]
            upper = (size[1]-size[0])/2
            lower = size[0] + upper
        box = (left, upper, right, lower)
        region = im.crop(box)
        region.save(path+'tmp/'+filename)
        im = Image.open(path+'tmp/'+filename)
        im.thumbnail((73, 73), Image.ANTIALIAS)
        im.save(path+'big/'+filename)
        im.thumbnail((48, 48), Image.ANTIALIAS)
        im.save(path+'normal/'+filename)
        im.thumbnail((24, 24), Image.ANTIALIAS)
        im.save(path+'tiny/'+filename)
        del im, region
        os.remove(path+'tmp/'+filename)
        self.update({'id':node_id}, {'icon':filename})