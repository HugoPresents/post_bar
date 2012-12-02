# -- coding: utf8 --

import math

class Pagination:
    
    def __init__(self, base_url, total, limit = 10):
        self.base_url = base_url
        self.total = int(math.ceil(float(total)/float(limit)))
        if self.total == 0:
            self.total = 1
        self.limit = limit
        self.cur_page = 1
    
    def output(self):
        prev = ''
        next = ''
        page = '<strong class="fade">' + str(self.cur_page) + '/' + str(self.total) + '</strong>'
        if self.cur_page > 1:
            prev = '<input type="button" onclick="location.href=\'' + self.base_url + '?p=' + str(self.cur_page-1) + '\';" value="‹ 上一页" class="super normal button">'
        if self.cur_page < self.total:
            next = '<input type="button" onclick="location.href=\'' + self.base_url + '?p=' + str(self.cur_page+1)  + '\';" value="下一页 ›" class="super normal button">'
        string = '<table cellpadding="0" cellspacing="0" border="0" width="100%"><tbody><tr>'
        string += '<td width="120" align="left">' + prev + '</td>'
        string += '<td width="auto" align="center">' + page + '</td>'
        string += '<td width="120" align="right">' + next + '</td>'
        string += '</tr></tbody></table>'
        return string
    
    def true_page(self, page):
        page = int(page)
        # 加上等于避免 total=0 时出错
        if page <= 1:
            self.cur_page = 1
        elif page > self.total:
            self.cur_page = self.total
        else:
            self.cur_page = page
        return self.cur_page