function updatePrivacy(mode, element) {
    const form = element.closest('.updatePrivacyForm');
    form.querySelector('.privacyMode').value = mode;
    form.submit();
    const post = element.closest('.post');
    const privacyIcon = post.querySelector('.public-btn-i');

    if (mode === 'public') {
        privacyIcon.classList.remove('fa-user-friends', 'fa-lock');
        privacyIcon.classList.add('fa-globe-europe');
    } else if (mode === 'friend') {
        privacyIcon.classList.remove('fa-globe-europe', 'fa-lock');
        privacyIcon.classList.add('fa-user-friends');
    } else if (mode === 'private') {
        privacyIcon.classList.remove('fa-globe-europe', 'fa-user-friends');
        privacyIcon.classList.add('fa-lock');
    }
}

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.public-btn-i').forEach(button => {
        button.addEventListener('click', function () {
            const post = this.closest('.post');
            post.querySelector('.Select-audience').classList.toggle('dis_block');
            post.querySelector('.popop-background').classList.toggle('dis_block');
        });
    });

    document.querySelectorAll('.popup-close-btn').forEach(button => {
        button.addEventListener('click', function () {
            const post = this.closest('.post');
            post.querySelector('.Select-audience').classList.remove('dis_block');
            post.querySelector('.popop-background').classList.remove('dis_block');
        });
    });

    document.querySelectorAll('.Select-audience').forEach(background => {
        background.addEventListener('click', function () {
            const post = this.closest('.post');
            post.querySelector('.Select-audience').classList.remove('dis_block');
            post.querySelector('.popop-background').classList.remove('dis_block');
        });
    });

    document.querySelectorAll('.post').forEach(post => {
        const privacyMode = post.querySelector('.privacyMode').value;
        const privacyIcon = post.querySelector('.public-btn-i');

        if (privacyMode === 'public') {
            privacyIcon.classList.add('fa-globe-europe');
        } else if (privacyMode === 'friend') {
            privacyIcon.classList.add('fa-user-friends');
        } else if (privacyMode === 'private') {
            privacyIcon.classList.add('fa-lock');
        }
    });
});


document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.three-dot-btn').forEach(button => {
        button.addEventListener('click', function () {
            const commentId = this.getAttribute('data-comment-id');
            const actions = this.closest('.comment-options').querySelector('.comment-actions');
            actions.style.display = actions.style.display === 'none' ? 'block' : 'none';
        });
    });

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
});

