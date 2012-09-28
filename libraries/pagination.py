# -- coding: utf8 --

import math

class Pagination:
    
    def __init__(self, base_url, total, limit = 10):
        self.base_url = base_url
        self.total = int(total/limit)
        if total % limit > 0:
            self.total += 1
        self.limit = limit
    
    def output(self, cur_page = 1):
        cur_page = int(cur_page)
        prev = ''
        next = ''
        page = ''
        page += '<strong class="fade">' + str(cur_page) + '/' + str(self.total) + '</strong>'
        if cur_page > 1:
            prev = '<input type="button" onclick="location.href=\'' + self.base_url + '?p=' + str(cur_page-1) + '\';" value="‹ 上一页" class="super normal button">'
        if cur_page < self.total:
            next = '<input type="button" onclick="location.href=\'' + self.base_url + '?p=' + str(cur_page+1)  + '\';" value="下一页 ›" class="super normal button">'
        string = '<table cellpadding="0" cellspacing="0" border="0" width="100%"><tbody><tr>'
        string += '<td width="120" align="left">' + prev + '</td>'
        string += '<td width="auto" align="center">' + page + '</td>'
        string += '<td width="120" align="right">' + next + '</td>'
        string += '</tr></tbody></table>'
        return string
    
    def true_page(self, page):
        page = int(page)
        if page < 1:
            return 1
        if page > self.total:
            return self.total
        return page