# -- coding: utf8 --

# 面包屑导航类
from models.site_model import *
class Crumb:
    
    def __init__(self):
        self.separator = '<span class="chevron">&nbsp;›&nbsp;</span>'

        self.content = [[site_model().get_option('title'), '/']]
    
    def set_separator(self, separator):
        self.separator = separator
    
    def append(self, name, url = None):
        self.content.append([name, url])
    
    def output(self):
        str = ''
        i = 0
        for item in self.content:
            i += 1
            if item[1] is None:
                str += item[0]
            else:
                str += '<a href="' + item[1] + '">' + item[0] + '</a>'
            if i < len(self.content):
                str += self.separator
        self.clear()
        return str
    
    def clear(self):
        self.__init__()