#  coding: utf8 
__metaclass__ = type
import web
from models.model import *
from config.config import *

class post_model(model):
	form = web.form.Form(
		web.form.Textbox('title', notnull, size=30, description="标题"),
		web.form.Textarea('content', notnull, rows=20, cols=80, description="正文"),
		web.form.Button('发表')
	)
	def __init__(self):
		super(post_model, self).__init__('post')