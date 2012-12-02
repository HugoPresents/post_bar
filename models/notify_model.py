#  coding: utf8 
__metaclass__ = type

import re
from models.user_model import *
from libraries.helper import *
class notify_model(model):

    ruler = re.compile('@[a-z0-9]')

    def __init__(self):
        super(money_model, self).__init__('notify')
        self.types = {}
        types = nofity_type_model().get_all()
        for type_ in types:
            self.types[type_.name] = type_.id

    def convert_content(content):
        user_list = unique_list(ruler.findall(content))
        for user_name in user_list:
            content = content.replace(user_name, '@<a href="/profile/'+user_name[1:]+'">'+user_name[1:]+'</a>')
        return content

    def insert_nofity(user_id, user_list, notify_type):
        if isinstance(user_list, list):
            for receiver in user_list:
                