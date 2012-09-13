# -- coding: utf8 --
from config.config import render
from models.post_model import *
from models.node_model import *
from models.user_model import *
from models.comment_model import *
from libraries.crumb import Crumb

# 显示某节点的文章
class index:
    
    crumb = Crumb()
    
    def GET(self, node_name):
        node = node_model().get_one({'name': node_name})
        if node is None:
            return render.not_fount('未找到节点', '未找到节点')
        else:
            self.crumb.append(node.display_name)
            post_conditions = {'node_id' : node.id}
            posts_result = post_model().get_all(conditions = post_conditions)
            posts = []
            for post_result in posts_result:
                post = {'post':post_result}
                user = user_model().get_one({'id':post_result.user_id})
                post['user'] = user
                node = node_model().get_one({'id':post_result.node_id})
                post['node'] = node
                comment = comment_model().get_one({'post_id':post_result.id}, 'time DESC')
                if comment:
                    comment_user = user_model().get_one({'id':comment.user_id})
                    post['comment_user'] = comment_user
                else:
                    post['comment_user'] = None
                posts.append(post)
            return render.list(posts, node, self.crumb.output())