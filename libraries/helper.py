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

def stamp2time(stamp = 0):
    import time
    cur_time = time.time()
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
    return time.strftime("%Y-%m-%d %H:%M:%S", ltime)