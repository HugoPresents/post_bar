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
