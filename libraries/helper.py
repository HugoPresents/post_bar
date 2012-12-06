# -- coding: utf8 --
# 辅助函数库

# 将字典转换成sql where字符串
def dict2where(dict):
    if dict is not None:
        where_str = ''
        for key, value in dict.items():
            if isinstance(value, list):
                where_str += '`'+str(key)+'`' + ' in (' + ', '.join('\''+str(_value)+'\'' for _value in value) + ') AND'
            else:
                where_str += '`'+str(key)+'`' + '=\'' + str(value) + '\' AND '
        where_len = len(where_str)
        where = where_str[0 : where_len-4]
        return where
    else:
        return None

# 将字典转换成sql update语句
def dict2update(dict):
    if dict is not None:
        update_str = ''
        for key,value in dict.items():
            update_str += '`'+str(key)+'`' + '=\'' + str(value) + '\','
        update_len = len(update_str)
        update = update_str[0:update_len-1]
        return update

# 时间戳转为到现在的时间差
def stamp2during(stamp = 0):
    import time
    from math import ceil
    # 对当前时间向上取整，防止出现负数~
    cur_time = int(ceil(time.time()))
    during = cur_time-stamp
    if during < 30:
        return str(during) + ' 秒前'
    if during < 60:
        return '半分钟前'
    if during < 3600:
        return str(int(during/60)) + ' 分钟前'
    if during < 24*3600:
        return str(int(during/3600)) + ' 小时前'
    if during < 365*24*3600:
        return str(int(during/(24*3600))) + ' 天前'
    #return str(int(during/(24*3600))) + '天前'
    ltime=time.localtime(stamp)
    return time.strftime("%Y-%m-%d %H:%m:%S %p", ltime)

# 将时间戳转为合适格式时间
def stamp2time(stamp = 0):
    import time
    ltime=time.localtime(stamp)
    return time.strftime("%Y-%m-%d %H:%m:%S %p", ltime)

# 时间戳转为时间
def cur_date(format = "%Y-%m-%d %H:%m:%S %p"):
    import time
    import datetime
    return datetime.datetime.now().strftime(format)

def avatar_url(avatar, mode = 'normal'):
    import os
    avatar = str(avatar)
    path = 'static/avatar/'+mode+'/'
    if os.path.exists(path+avatar) and avatar != '':
        return '/'+path+avatar
    else:
        return '/'+path+'default.jpg'

def icon_url(icon, mode = 'normal'):
    import os
    icon = str(icon)
    path = 'static/icons/'+mode+'/'
    if os.path.exists(path+icon) and icon != '':
        return '/'+path+icon
    else:
        return '/'+path+'default.jpg'

def display_money(money):
    money = int(money)
    string = ''
    gold = 0
    silver = 0
    bronze = 0
    if money >= 10000:
        gold = money // 10000
        money = money % 10000
        string += str(gold) + ' '
        string += '<img src="/static/img/gold.png" alt="G" align="absmiddle" border="0" style="padding-bottom: 2px;">'
    if money >= 100:
        silver = money // 100
        money = money % 100
        if gold:
            string += ' '
        string += str(silver) + ' '
        string += '<img src="/static/img/silver.png" alt="S" align="absmiddle" border="0" style="padding-bottom: 2px;">'
    bronze = money
    if silver:
        string += ' '
    if bronze <= 0 and (gold or silver):
        pass
    else:
        string += str(bronze) + ' '
        string += '<img src="/static/img/bronze.png" alt="B" align="absmiddle" border="0">'
    return string

#转成html实体
def str2entity(str):
    import htmlentitydefs
    str = unicode(str)
    to = u''
    for i in str:
        if ord(i) in htmlentitydefs.codepoint2name:
            name = htmlentitydefs.codepoint2name.get(ord(i))
            to += "&" + name + ";"
    else:
        to += i
    return to

def html2db(str):
    #str = str.encode()
    str = str.replace("'", "\\'").replace('"', '\\"').replace('$', '\\$').replace('<', '&lt;').replace('>', '&gt;')
    return str 

def unique_list(list_):
    u_list = []
    for item in list_:
        if item not in u_list:
            u_list.append(item)
    return u_list

def list_diff(list_1, list_2):
    list_ = []
    for item in list_1:
        if item not in list_2:
            list_.append(item)
    return list_

def strip_tags(html):
    from HTMLParser import HTMLParser
    html=html.strip()
    html=html.strip("\n")
    result=[]
    parse=HTMLParser()
    parse.handle_data=result.append
    parse.feed(html)
    parse.close()
    return "".join(result)