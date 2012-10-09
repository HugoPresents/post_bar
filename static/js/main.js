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
		}, 'json'
	)
}