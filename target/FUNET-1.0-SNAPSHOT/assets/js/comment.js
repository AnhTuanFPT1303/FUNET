/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener('DOMContentLoaded', function() {
    const commentForms = document.querySelectorAll('.post-method');

    commentForms.forEach(form => {
        const commentInput = form.querySelector('input[name="commentContent"]');
        
        form.addEventListener('keydown', function(event) {
            if (event.key === 'Enter' && !event.shiftKey) {
                event.preventDefault();
                if (commentInput.value.trim() !== '') {
                    submitComment(form);
                }
            }
        });

        form.addEventListener('submit', function(event) {
            event.preventDefault();
            if (commentInput.value.trim() !== '') {
                submitComment(form);
            }
        });
    });

    function submitComment(form) {
        const formData = new FormData(form);
        const postId = formData.get('post_id');
        const commentContent = formData.get('commentContent');

        fetch('/commentServlet', {
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
                                    <form action="/deleteCommentServlet" method="post" class="delete-comment-form" style="display: inline;">
                                        <input type="hidden" name="commentId" value="${comment.comment_id}">
                                        <button type="submit" class="delete-comment-btn">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <form action="/updateCommentServlet" method="post" class="edit-comment-form" style="display: none;">
                            <input type="hidden" name="commentId" value="${comment.comment_id}">
                            <textarea name="newCommentText" class="form-control">${comment.comment_text}</textarea>
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn btn-secondary cancel-edit-comment">Cancel</button>
                        </form>
                    </div>
                `;
                
                const post = document.querySelector(`.post[data-post-id="${postId}"]`);
                const commentSection = post.querySelector('.comment-site');
                commentSection.insertAdjacentHTML('afterend', commentHtml);
                
                form.reset();

                const newComment = post.querySelector(`.comment:last-child`);
                initializeCommentButtons(newComment);
            } else {
                console.error('Error:', data.error);
            }
        })
        .catch(error => console.error('Error:', error));
    }

    // Function to initialize comment buttons
    function initializeCommentButtons(comment) {
        const threeDotBtn = comment.querySelector('.three-dot-btn');
        const commentActions = comment.querySelector('.comment-actions');
        const editBtn = comment.querySelector('.edit-comment-btn');
        const editForm = comment.querySelector('.edit-comment-form');
        const cancelEditBtn = comment.querySelector('.cancel-edit-comment');
        const commentText = comment.querySelector('.comment-text');

        if (threeDotBtn) {
            threeDotBtn.addEventListener('click', () => {
                commentActions.style.display = commentActions.style.display === 'none' ? 'block' : 'none';
            });
        }

        if (editBtn) {
            editBtn.addEventListener('click', () => {
                commentText.style.display = 'none';
                editForm.style.display = 'block';
                commentActions.style.display = 'none';
            });
        }

        if (cancelEditBtn) {
            cancelEditBtn.addEventListener('click', () => {
                commentText.style.display = 'block';
                editForm.style.display = 'none';
            });
        }
    }
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

            fetch('/updateCommentServlet', {
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

            fetch('/deleteCommentServlet', {
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