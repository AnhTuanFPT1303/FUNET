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
            var likeCountElement = this.querySelector('.post-rating-count');

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