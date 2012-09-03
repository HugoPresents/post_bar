# -- coding: utf8 --
from config.config import db
from libraries.helper import *

# 自定义join查询方法
# join dict {'join_talbe': ['cur_field', 'target_field']}
# return dict {{'table_name' : data, 'table_name' : data}, {'table_name' : data, 'table_name' : data}}

def fetch_join(tb = None, condition = None, join = None, limit = 10, offset = 0):
    if tb is None:
        return None
    where = dict2where(condition)
    result = db.select(tb, where = where, limit = limit, offset = offset)
    if join is None:
        return result
    result_joined = {}
    for row in result:
        for join_table, join_fields in join.items():
            print row.user_id
            condition = {join_fields[1] : row.join_fields[0]}
            where = dict2where(condition)
            join_table_result = db.select(join_table, where = where)
            result_joined += {tb : row, join_table : join_table_result}
    del result
    return result_joined