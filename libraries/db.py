# -- coding: utf8 --
# 放弃使用该类
from config.config import db
from libraries.helper import *

# 自定义join查询方法
# join dict {'join_talbe': ['cur_field', 'target_field']}
# return dict [{'table' : data, 'table_joined' : data}, {'table' : data, 'table_joined' : data}]

def fetch_join(tb = None, condition = None, join = None, limit = 10, offset = 0):
    if tb is None:
        return None
    where = dict2where(condition)
    result = db.select(tb, where = where, limit = limit, offset = offset)
    if join is None:
        return result
    # 返回的结果列表
    result_joined = []
    for row in result:
        # 遍历出的每一行为一个字典，默认添加{主表：主表该行结果}
        row_joined = {tb : row}
        for join_table, join_fields in join.items():
            condition = {join_fields[1] : getattr(row, join_fields[0])}
            where = dict2where(condition)
            join_table_result = db.select(join_table, where = where)
            # join 查到的结果字典来更新行结果字典
            row_joined.update({join_table : join_table_result})
        #最终将包含join行的结果字典追加到返回的结果列表中
        result_joined.append(row_joined)
    return result_joined