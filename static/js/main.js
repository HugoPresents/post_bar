function check_notify() {
    $.post(
        '/notifications/check', {
            ajax:1
        }, function(data) {
            if(data != '0') {
                $("#notifications").html('<img src="/static/img/dot_orange.png" align="absmiddle"><strong><a href="/notifications">'+data+' 条未读提醒</a></strong>');
                document.title += ' ('+data+')';
            }
        }
    );
}

function click_reply(name) {
    textarea = $('#content');
    var content = textarea.val();
    if(content.length > 0) {
        content += '\n@'+name+' ';
    } else {
        content += '@'+name+' ';
    } 
    textarea.val(content);
    moveEnd(textarea[0]);
    //textarea.focus();
}

function thankReply(comment_id) {
    $.post(
        '/comment/thanks', {
            comment_id:comment_id
        }, function(data) {
            if(data.success == 1) {
                $("#thank_area_"+comment_id).addClass('thanked').html('感谢已发送')
            } else {
                alert(data.msg)
            }
            eval(data.script)
        }, 'json'
    )
}

function thankTopic(post_id) {
    $.post(
        '/post/thanks', {
            post_id:post_id
        }, function(data) {
            if(data.success == 1) {
                $("#topic_thank").html('<span class="f11 gray" style="text-shadow: 0px 1px 0px #fff;">感谢已发送</span>')
            } else {
                alert(data.msg)
            }
            eval(data.script)
        }, 'json'
    )
}

function moveEnd(obj){
    obj.focus();
    var len = obj.value.length;
    if (document.selection) {
        var sel = obj.createTextRange();
        sel.moveStart('character',len);
        sel.collapse();
        sel.select();
    } else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
        obj.selectionStart = obj.selectionEnd = len;
    }
} 