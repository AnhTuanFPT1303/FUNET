/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.post-method').forEach(function (form) {
        form.addEventListener('submit', function (event) {
            event.preventDefault();
            const formData = new FormData(this);
            const postId = formData.get('post_id');
            fetch('/FUNET/commentServlet', {
                method: 'POST',
                body: new URLSearchParams(formData)
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
                            <div class="comment-body">
                                <p style="margin-bottom: 0;">${comment.comment_text}</p>
                            </div>
                        </div>`;
                    const postElement = document.querySelector(`.post[data-post-id="${postId}"] .post-comments`);
                    postElement.insertAdjacentHTML('beforeend', commentHtml);
                    form.reset();
                } else {
                    console.error('Error:', data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        });
    });
});
