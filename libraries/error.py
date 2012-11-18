# -- coding: utf8 --

# 自定义错误类

# 自定义值已经存在错误
class ValueExistsError(Exception):
    def __init__(self, message):
        Exception.__init__(self)
        self.message = message