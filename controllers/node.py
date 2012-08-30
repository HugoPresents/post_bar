# -- coding: utf8 --
from config.config import render
from models import post_model
from models import node_model

# 显示某节点的文章
class index:
    def GET(self, node_name):
        node = node_model.get_node({'name': node_name})
        if node is None:
            return render.not_fount('未找到节点', '未发现改节点')
        else:
            post_conditions = {'node_id' : node.id}
            posts = post_model.get_posts(conditions = post_conditions)
            return render.list(posts, node.description)