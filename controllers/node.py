# -- coding: utf8 --
from config.config import render
from models import post_model
from models import node_model
from libraries.crumb import Crumb

# 显示某节点的文章
class index:
    
    crumb = Crumb()
    
    def GET(self, node_name):
        node = node_model.get_node({'name': node_name})
        if node is None:
            return render.not_fount('未找到节点', '未找到节点')
        else:
            self.crumb.append(node.display_name)
            post_conditions = {'node_id' : node.id}
            posts = post_model.get_posts(conditions = post_conditions)
            return render.list(posts, node, self.crumb.output())