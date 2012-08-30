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