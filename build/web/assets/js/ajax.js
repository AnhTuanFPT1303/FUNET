$.ajax({
    type: 'POST',
    url: 'profile',
    data: {action: 'delete', postId: postId},
    success: function() {
        location.reload();
    }
});
