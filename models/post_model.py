#  coding: utf8
__metaclass__ = type
import web
from models.model import *
from models.comment_model import *
from models.post_thanks_model import *
from config.config import *

class post_model(model):
    
    def __init__(self):
        super(post_model, self).__init__('post')
        self.form = web.form.Form(
            web.form.Textarea('title', notnull, class_='mle', description=''),
            web.form.Textarea('content', notnull, class_='mle tall', description=''),
            web.form.Button('创建', class_='super normal button')
        )
    
    def add_view(self, post_id):
        super(post_model, self).query('UPDATE ' + self._tb + ' SET views = views + 1 WHERE id=' + str(post_id))
        
    def count_comment(self, post_id):
        super(post_model, self).query('update ' + self._tb + ' set comments = (select count(*) from ' + comment_model().table_name() + ' where ' + comment_model().table_name() + '.post_id = ' + str(post_id) + ') where id = ' + str(post_id))
    
    def count_thanks(self, post_id):
        super(post_model, self).query('update ' + self._tb + ' set thanks = (select count(*) from ' + post_thanks_model().table_name() + ' where ' + post_thanks_model().table_name() + '.post_id = ' + str(post_id) + ') where id = ' + str(post_id))

    def trends(self, limit = 20, offset = 0, node_id = None):
        select = [
            'p.id',
            'p.title',
            'p.last_update',
            'p.comments',
            'u.id AS post_user_id',
            'u.name AS post_user_name',
            'u.avatar AS post_user_avatar',
            'c.time',
            'c.content',
            'cu.name AS comment_user_name'
        ]

        from_ = [
            'post p',
            'JOIN user u ON p.user_id = u.id',
            'LEFT JOIN comment c ON c.post_id = p.id',
            'LEFT JOIN comment c1 ON c1.post_id = c.post_id AND c1.`time` > c.`time`'
            'LEFT JOIN user cu ON cu.id = c.user_id'
        ]

        where = [
            'c1.time IS NULL'
        ]

        if node_id is not None:
            where.append('p.node_id = $node_id')
        else:
            select.append('n.name AS node_name')
            select.append('n.display_name AS node_display_name')
            from_.append('JOIN node n ON n.id = p.node_id')
        sql = 'SELECT '
        sql += ', '.join(select)
        sql += ' FROM '
        sql += '\n'.join(from_)
        sql += '\n WHERE '
        sql += ' AND '.join(where)
        sql += '''
            GROUP  BY p.id
            ORDER  BY p.last_update DESC
            LIMIT  $offset, $limit
        '''
        return self.db.query(sql, vars = {'limit': limit, 'offset':offset, 'node_id': node_id})