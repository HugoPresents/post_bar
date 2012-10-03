#  coding: utf8 
__metaclass__ = type
from models.model import *
from models.money_option_model import *

class money_model(model):
    def __init__(self):
        super(money_model, self).__init__('money')
        # 将财富配置表数据取出
        self.ruler = {}
        options = money_option_model().get_all()
        for option in options:
            # 转成浮点进行下面的保留小数运算
            self.ruler[option.key] = float(option.value)
    
    def cal_post(self, content):
        length = float(len(unicode(content)))
        cost = self.ruler['post_cost']
        length -= self.ruler['post_length']
        if length > 0:
            cost += self.ruler['post_cost_add'] * (length / 100)
        return cost
    
    def cal_comment(self, content):
        length = foloat(length(unicode(content)))
        cost = self.ruler['comment_cost']
        length -= self.ruler['comment_length']
        if length > 0:
            cost += self.ruler['post_cost_add'] * (length / 100)
        return cost