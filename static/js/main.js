function thankReply(comment_id) {
	$.post(
		'/comment/thanks', {
			comment_id:comment_id
		}, function(data) {
			if(data.success == 1) {
				alert('success')
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
				alert('success')
			} else {
				alert(data.msg)
			}
			eval(data.script)
		}, 'json'
	)
}
