# -- coding: utf8 --
__metaclass__ = type
import web
from models.model import *
from models.comment_thanks_model import *
from config.config import *

class comment_model(model):
     
    def __init__(self):
        super(comment_model, self).__init__('comment')
        self.form = web.form.Form(
            web.form.Textarea('content',
                notnull,
                rows=5,
                cols=80,
                description='',
                post='<div class="sep10"></div>',
                class_='mll'
            ),
            web.form.Button('回复',class_='super normal button')
        )
    
    def count_thanks(self, comment_id):
        super(comment_model, self).query('update ' + self._tb + ' set thanks = (select count(*) from ' + comment_thanks_model().table_name() + ' where ' + comment_thanks_model().table_name() + '.comment_id = ' + str(comment_id) + ') where id = ' + str(comment_id))