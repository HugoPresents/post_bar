# -- coding: utf8 --
# 辅助函数库

# 将字典转换成sql where字符串
def dict2where(dict):
    if dict is not None:
        where_str = ''
        for key, value in dict.items():
            where_str += str(key) + '=\'' + str(value) + '\'AND '
        where_len = len(where_str)
        where = where_str[0 : where_len-4]
        return where
    else:
        return None

# 时间戳转为到现在的时间差
def stamp2during(stamp = 0):
    import time
    from math import ceil
    # 对当前时间向上取整，防止出现负数~
    cur_time = int(ceil(time.time()))
    during = cur_time-stamp
    if during < 30:
        return str(during) + '秒前'
    if during < 60:
        return '半分钟前'
    if during < 3600:
        return str(int(during/60)) + '分钟前'
    if during < 24*3600:
        return str(int(during/3600)) + '小时前'
    if during < 365*24*3600:
        return str(int(during/(24*3600))) + '天前'
    #return str(int(during/(24*3600))) + '天前'
    ltime=time.localtime(stamp)
    return time.strftime("%Y-%m-%d %H:%m:%S %p", ltime)

# 时间戳转为时间
def cur_date(format = "%Y-%m-%d %H:%m:%S %p"):
    import time
    import datetime
    return datetime.datetime.now().strftime(format)
