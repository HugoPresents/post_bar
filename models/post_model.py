#  coding: utf8 
__metaclass__ = type
import web
from models.model import *
from models.comment_model import *
from config.config import *

class post_model(model):
	form = web.form.Form(
		web.form.Textarea('title', notnull, class_='mle', description=''),
		web.form.Textarea('content', notnull, class_='mle tall', description=''),
		web.form.Button('创建', class_='super normal button')
	)
	def __init__(self):
		super(post_model, self).__init__('post')
	
	def add_view(self, post_id):
		super(post_model, self).query('UPDATE ' + self._tb + ' SET views = views + 1 WHERE id=' + str(post_id))
		
	def count_comment(self, post_id):
		super(post_model, self).query('update ' + self._tb + ' set comments = (select count(*) from ' + comment_model().table_name() + ' where comment.post_id = ' + str(post_id) + ') where id = ' + str(post_id))