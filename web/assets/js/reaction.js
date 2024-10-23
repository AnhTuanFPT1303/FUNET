/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.post-rating').forEach(function(element) {
        element.addEventListener('click', function(e) {
            e.preventDefault();
            var postId = this.closest('.post').dataset.postId;
            var likeButton = this.querySelector('.material-icons');
            var likeCountElement = this.closest('.post').querySelector('.like-count span');
            fetch('likeServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'postId=' + postId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (data.action === 'liked') {
                        likeButton.style.color = '#1877f2';
                        this.classList.add('post-rating-selected');
                    } else {
                        likeButton.style.color = '#65676b';
                        this.classList.remove('post-rating-selected');
                    }
                    likeCountElement.textContent = data.likeCount;
                } else {
                    console.error('Error:', data.error);
                }
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        });
    });
});


document.addEventListener('DOMContentLoaded', function () {
    const commentForms = document.querySelectorAll('.post-method');

    commentForms.forEach(form => {
        form.addEventListener('submit', function (event) {
            event.preventDefault();
            const formData = new FormData(this);
            const postId = formData.get('post_id');
            const commentContent = formData.get('commentContent');

            if (commentContent.trim() === '') {
                return;
            }

            fetch('/FUNET/commentServlet', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const comment = data.comment;
                    const commentHtml = `
                        <div class="comment mb-2" style="margin-left: 20px;">
                            <div class="comment-header">
                                <img src="assets/profile_avt/${comment.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                <small><strong>${comment.first_name} ${comment.last_name}</strong></small>
                            </div>
                            <div class="comment-body" style="display: flex; justify-content: space-between; align-items: center;">
                                <p style="margin-bottom: 0;" class="comment-text">${comment.comment_text}</p>
                                <div class="comment-options">
                                    <button class="three-dot-btn" data-comment-id="${comment.comment_id}">...</button>
                                    <div class="comment-actions" style="display: none;">
                                        <button class="edit-comment-btn" data-comment-id="${comment.comment_id}">Edit</button>
                                        <form action="/FUNET/deleteCommentServlet" method="post" class="delete-comment-form" style="display: inline;">
                                            <input type="hidden" name="commentId" value="${comment.comment_id}">
                                            <button type="submit" class="delete-comment-btn">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <form action="/FUNET/updateCommentServlet" method="post" class="edit-comment-form" style="display: none;">
                                <input type="hidden" name="commentId" value="${comment.comment_id}">
                                <textarea name="newCommentText" class="form-control">${comment.comment_text}</textarea>
                                <button type="submit" class="btn btn-primary">Save</button>
                                <button type="button" class="btn btn-secondary cancel-edit-comment">Cancel</button>
                            </form>
                        </div>
                    `;
                    const commentsContainer = document.querySelector(`.post[data-post-id="${postId}"] .post-comments`);
                    commentsContainer.insertAdjacentHTML('beforeend', commentHtml);
                    form.reset();
                } else {
                    console.error('Error:', data.error);
                }
            })
            .catch(error => console.error('Error:', error));
        });
    });
});




document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.edit-comment-btn').forEach(button => {
        button.addEventListener('click', function () {
            const commentId = this.getAttribute('data-comment-id');
            const commentText = this.closest('.comment').querySelector('.comment-text');
            const editForm = this.closest('.comment').querySelector('.edit-comment-form');
            commentText.style.display = 'none';
            editForm.style.display = 'block';
        });
    });

    document.querySelectorAll('.cancel-edit-comment').forEach(button => {
        button.addEventListener('click', function () {
            const commentText = this.closest('.comment').querySelector('.comment-text');
            const editForm = this.closest('.comment').querySelector('.edit-comment-form');
            commentText.style.display = 'block';
            editForm.style.display = 'none';
        });
    });

    document.querySelectorAll('.edit-comment-form').forEach(form => {
        form.addEventListener('submit', function (event) {
            event.preventDefault();
            const commentId = this.querySelector('input[name="commentId"]').value;
            const newCommentText = this.querySelector('textarea[name="newCommentText"]').value;
            const commentText = this.closest('.comment').querySelector('.comment-text');

            fetch('/FUNET/updateCommentServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `commentId=${commentId}&newCommentText=${encodeURIComponent(newCommentText)}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    commentText.textContent = newCommentText;
                    commentText.style.display = 'block';
                    this.style.display = 'none';
                } else {
                    alert('Error updating comment');
                }
            });
        });
    });

    document.querySelectorAll('.delete-comment-form').forEach(form => {
        form.addEventListener('submit', function (event) {
            event.preventDefault();
            const commentId = this.querySelector('input[name="commentId"]').value;
            const commentElement = this.closest('.comment');

            fetch('/FUNET/deleteCommentServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `commentId=${commentId}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    commentElement.remove();
                } else {
                    alert('Error deleting comment');
                }
            });
        });
    });
});