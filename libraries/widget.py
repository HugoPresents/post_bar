# -- coding: utf8 --
__metaclass__ = type

import os
import web
import time
import datetime
from models.node_model import *
from models.cat_model import *
from models.post_model import *
from models.user_model import *
from models.comment_model import *
render = web.template.render(os.path.abspath(os.path.dirname(__file__)) + '/../tpl/widget/')

def generator(widget_name):
    return eval(widget_name+'().run()')
    
class widget:
    
    def run(self):
        pass

# 站点统计小组件
class site_statics_widget(widget):
    def run(self):
        site_count = {}
        site_count['user'] = user_model().count_table()
        site_count['post'] = post_model().count_table()
        site_count['comment'] = comment_model().count_table()
        return render.site_statics(site_count)

# 今日热议主题小组件
class hot_posts_today_widget(widget):
    def run(self):
        ltime = time.localtime(time.time())
        time_start = int(time.mktime(datetime.datetime(ltime.tm_year, ltime.tm_mon, ltime.tm_mday).timetuple()))
        time_end = time_start + 24 * 60 * 60
        sql = 'SELECT `post_id` FROM comment WHERE `time` >= '+str(time_start)+' AND `time` <= '+str(time_end)+' GROUP BY post_id ORDER BY count(post_id) DESC LIMIT 10'
        post_ids = comment_model().query_result(sql)
        posts = []
        for row in post_ids:
            post = post_model().get_one({'id':row.post_id})
            user = user_model().get_one({'id':post.user_id})
            posts.append({'post':post, 'user':user})
        return render.hot_posts_tody(posts)

class user_panel_widget(widget):
    def run(self):
        return render.user_panel()

class ga_widget(widget):
    def run(self):
        return render.ga()