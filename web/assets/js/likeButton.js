/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.querySelectorAll(".post").forEach(post => {
    const post_id = post.dataset.postId;
    const rating = post.querySelector(".post-rating");
    const button = rating.querySelector(".post-rating-button");
    const count = rating.querySelector(".post-rating-count");
    let isLiked = post.dataset.liked === 'true';

    if (isLiked) {
        rating.classList.add("post-rating-selected");
    }

    button.addEventListener("click", async () => {
        const action = isLiked ? 'unlike' : 'like';
        try {
            const url = `/blahproject/home/${post_id}/${action}`;
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'same-origin'
            });
            
            if (response.ok) {
                const data = await response.json();
                count.textContent = data.like_count;
                isLiked = !isLiked;
                rating.classList.toggle("post-rating-selected");
                post.dataset.liked = isLiked.toString();
            } else {
                console.error('Failed to update likes');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    });
});
