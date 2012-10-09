# -- coding: utf8 --
pre_fix = 'controllers.'
urls = (
    # 首页
    '/index', pre_fix + 'index.index',
    # 浏览主题
    '/post/(\d+)', pre_fix + 'post.view',
    # 创建主题
    '/create/(\w+)', pre_fix + 'post.create',
    # 节点主题列表
    '/node/(\w+)', pre_fix + 'node.index',
    # 评论主题
    '/comment/(\d+)', pre_fix + 'comment.add',
    # 感谢评论
    '/comment/thanks', pre_fix + 'comment.thanks',
    # 注册
    '/signup', pre_fix + 'user.signup',
    # 登录
    '/login', pre_fix + 'user.login',
    # 注销
    '/logout', pre_fix + 'user.logout',
    # 设置
    '/settings', pre_fix + 'user.settings',
    # 上传头像
    '/settings/avatar', pre_fix + 'user.avatar',
    # 用户中心
    '/profile/(\w+)', pre_fix + 'user.profile',
    # 财富中心
    '/balance', pre_fix + 'user.balance',
    # 关注用户
    '/follow/(\w+)', pre_fix + 'user.follow',
    # 取消关注
    '/unfollow/(\w+)', pre_fix + 'user.unfollow',
    # 来自关注人的帖子
    '/my/following', pre_fix +'user.following',
    # 收藏帖子
    '/post/fav/(\d+)', pre_fix + 'post.fav',
    # 取消收藏帖子
    '/post/unfav/(\d+)', pre_fix + 'post.unfav',
    # 收藏的主题
    '/my/posts', pre_fix + 'user.post_favs',
    # 用户创建的主题
    '/profile/(\w+)/posts', pre_fix + 'user.posts',
    # 用户创建的回复
    '/profile/(\w+)/comments', pre_fix + 'user.comments',
    # 收藏节点
    '/node/fav/(\w+)', pre_fix + 'node.fav',
    # 收藏节点的主题
    '/my/nodes', pre_fix + 'user.node_favs',
    # 取消收藏节点
    '/node/unfav/(\w+)', pre_fix + 'node.unfav',
    # 其他
    '/.*', pre_fix + 'index.index'
)