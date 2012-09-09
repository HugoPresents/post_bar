# -- coding: utf8 --

# 面包屑导航类
class Crumb:
    
    def __init__(self):
        self.separator = ' > '
        self.content = [['首页', '/']]
    
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
                str += item[0] + self.separator
            else:
                str += '<a href="' + item[1] + '">' + item[0] + '</a>' + self.separator
        self.reset()
        return str[:len(str)-len(self.separator)]
    
    def reset(self):
        self.__init__()