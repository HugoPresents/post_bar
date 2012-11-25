# -- coding: utf8 --
__metaclass__ = type
import web
from models.model import *
from config.config import *

class site_model(model):

    form = web.form.Form(
        web.form.Textbox('title', notnull, size=45, description="站点标题", class_='sl'),
        web.form.Textarea('description', notnull, class_='mle tall', description='站点描述'),
        web.form.Button('保存', class_='super normal button')
    )

    def __init__(self):
        super(site_model, self).__init__('site')

    def get_options(self):
        site = {}
        for site_option in self.get_all():
            site[site_option.key] = site_option.value
        return site

    def get_option(self, key):
        return self.get_one({'key':key}).value