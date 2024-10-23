
let select_audience = document.querySelector(".popop-background");
let popop_background = document.querySelector(".Select-audience");
let public_btn_i = document.getElementById('public-btn-i');


public_btn_i.addEventListener("click", function () {
    popop_background.classList.toggle("dis_block");
    select_audience.classList.toggle("dis_block");
});

let popup_close_btn = document.getElementById("popup-close-btn");

popup_close_btn.addEventListener("click", function () {
    select_audience.classList.remove("dis_block");
    popop_background.classList.remove("dis_block");
});

select_audience.addEventListener("click", function () {
    select_audience.classList.remove("dis_block");
    popop_background.classList.remove("dis_block");
});



let public_btn = document.getElementById("public-btn");
let friends_btn = document.getElementById("friends-btn");
let lock_btn = document.getElementById("lock-btn");

let public_li_icon = document.getElementById("public-li-icon");
let friends_li_icon = document.getElementById("friends-li-icon");
let lock_li_icon = document.getElementById("lock-li-icon");

public_btn.addEventListener("click", function () {
    public_btn.classList.add("activ-li-div");
    friends_btn.classList.remove("activ-li-div");

    public_li_icon.classList.add("activ-li-icon");
    public_li_icon.classList.add("fa-dot-circle");

    lock_li_icon.classList.remove("activ-li-icon");
    public_btn_i.classList.remove("fa-lock");
    lock_li_icon.classList.add("fa-circle");
    lock_btn.classList.remove("activ-li-div");

    friends_li_icon.classList.remove("activ-li-icon");
    friends_li_icon.style.color = "#707070";
    friends_li_icon.classList.add("fa-circle");
    friends_li_icon.classList.remove("fa-dot-circle");

    public_btn_i.classList.add("fa-globe-europe");
    public_btn_i.classList.remove("fa-user-friends");

    select_audience.classList.remove("dis_block");
    popop_background.classList.remove("dis_block");
});



friends_btn.addEventListener("click", function () {
    public_btn.classList.remove("activ-li-div");
    friends_btn.classList.add("activ-li-div");

    public_li_icon.classList.remove("activ-li-icon");
    public_li_icon.classList.remove("fa-dot-circle");

    friends_li_icon.classList.add("activ-li-icon");
    friends_li_icon.classList.remove("fa-circle");
    friends_li_icon.classList.add("fa-dot-circle");

    lock_li_icon.classList.remove("activ-li-icon");
    public_btn_i.classList.remove("fa-lock");
    lock_li_icon.classList.add("fa-circle");
    lock_btn.classList.remove("activ-li-div");
    lock_li_icon.classList.remove("fa-dot-circle");

    public_btn_i.classList.remove("fa-globe-europe");
    public_btn_i.classList.add("fa-user-friends");

    select_audience.classList.remove("dis_block")
    popop_background.classList.remove("dis_block")
});


lock_btn.addEventListener("click", function () {
    public_btn.classList.remove("activ-li-div");
    friends_btn.classList.remove("activ-li-div");

    public_li_icon.classList.remove("activ-li-icon");
    public_li_icon.classList.remove("fa-dot-circle");

    friends_li_icon.classList.remove("activ-li-icon");
    friends_li_icon.style.color = "#707070";
    friends_li_icon.classList.add("fa-circle");
    friends_li_icon.classList.remove("fa-dot-circle");

    lock_li_icon.classList.remove("fa-circle");
    lock_li_icon.classList.add("fa-dot-circle");
    lock_li_icon.classList.add("activ-li-icon");
    lock_btn.classList.add("activ-li-div");

    public_btn_i.classList.remove("fa-globe-europe");
    public_btn_i.classList.remove("fa-user-friends");
    public_btn_i.classList.add("fa-lock");

    select_audience.classList.remove("dis_block");
    popop_background.classList.remove("dis_block");
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


