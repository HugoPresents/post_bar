# -- coding: utf8 --
import web
import time
from config.config import render
from models.comment_model import *
from models.post_model import *

class add:
    
    form = comment_model().form
    
    def GET(self, post_id):
        raise web.SeeOther('/post/' + post_id)
    
    def POST(self, post_id):
        if web.config._session.user_id is None:
            raise web.SeeOther('/login')
        post = post_model().get_one({'id':post_id})
        if post is not None:
            if not self.form.validates():
                raise web.SeeOther('/post/' + post_id)
            else:
                comment_model().insert({'user_id' : web.config._session.user_id, 'post_id' : post_id, 'content' : self.form.d.content, 'time' : time.time()})
                post_model().count_comment(post_id)
                raise web.SeeOther('/post/' + post_id)
        else:
             raise web.SeeOther('/post/' + post_id)