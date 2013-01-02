#  coding: utf8 
__metaclass__ = type
import web
import re
from models.model import *
from models.user_model import *
from models.notify_type_model import *
from libraries.helper import *
class notify_model(model):

    ruler = re.compile('@[a-z0-9]+')

    def __init__(self):
        super(notify_model, self).__init__('notify')
        self.types = {}
        types = notify_type_model().get_all()
        for type_ in types:
            self.types[type_.name] = type_.id

    def convert_content(self, content):
        user_list = unique_list(self.ruler.findall(content))
        user_list_ = []
        for user_name in user_list:
            content = content.replace(user_name, '@<a href="/profile/'+user_name[1:]+'">'+user_name[1:]+'</a>')
            user_list_.append(user_name[1:])
        return content, user_list_

    def insert_notify(self, user_id, user_list, notify_type, foreign_id):
        if isinstance(user_list, list):
            for receiver in user_list:
                user = user_model().get_one({'name':receiver})
                if user is not None:
                    self.insert({'user_id':user_id, 'receiver':user.id, 'type_id':self.types[notify_type], 'foreign_id':foreign_id})
        else:
            user = user_model().get_one({'name':user_list})
            if user is not None:
                self.insert({'user_id':user_id, 'receiver':user.id, 'type_id':self.types[notify_type], 'foreign_id':foreign_id})

    def mark_as_read(self, receiver):
        return self.update({'receiver':receiver}, {'unread':0})

    def check(self, handler):
        if web.config._session.user_id is None:
            web.config._session.notifications = 0
        else:
            web.config._session.notifications = self.count_table({'receiver':web.config._session.user_id, 'unread':'1'})
        return handler()
