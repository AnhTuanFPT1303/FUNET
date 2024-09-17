$.ajax({
    type: 'POST',
    url: 'userpageServlet',
    data: {action: 'delete', postId: postId},
    success: function() {
        location.reload();
    }
});
