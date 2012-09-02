# -- coding: utf8 --
import web
from config.config import render
from models import comment_model
from models import post_model

class add:
    
    form = comment_model.form
    
    def GET(self, post_id):
        raise web.SeeOther('/post/' + post_id)
    
    def POST(self, post_id):
        if web.config._session.user_id is None:
            raise web.SeeOther('/login')
        post = post_model.get_post(post_id)
        if post is not None:
            if not self.form.validates():
                raise web.SeeOther('/post/' + post_id)
            else:
                comment_model.insert(web.config._session.user_id, post_id, self.form.d.content)
                raise web.SeeOther('/post/' + post_id)
        else:
             raise web.SeeOther('/post/' + post_id)