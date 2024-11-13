<%-- 
    Document   : home
    Created on : Jun 10, 2024, 3:20:34 PM
    Author     : bim26
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ page import="model.Message, dao.MessageDao" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Social Network</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">    
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link href="assets/css/home.css" rel="stylesheet">    
        <link href="assets/css/logonavbar.css" rel="stylesheet">   
    </head>
    <body>
        <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%">FUNET</div>
            </a>
            <form class="" method="get" action="/searchServlet" id="searchForm">
                <div class="search-bar" style="margin-top:1%;">
                    <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input" style="padding-left:5%;">

                </div>
            </form>
            <div class="center-buttons">
                <a href="home">
                    <button class="center-button" id="home-btn">
                        <box-icon type='solid' name='home'></box-icon>
                    </button>
                </a>
                <a href="lmaterialLink"> 
                    <button class="center-button" id="video-btn">
                        <box-icon type='solid' name='book'></box-icon>
                    </button>
                </a>
                <a href="marketLink">
                    <button class="center-button" id="market-btn">
                        <box-icon name='store-alt' type='solid'></box-icon>
                    </button>
                </a>
                <a href="/friendRequestServlet" class="friend-icon me-3">
                    <button class="center-button" id="friend-btn">
                        <box-icon name='group' type='solid'></box-icon>
                    </button>
                </a>
            </div>
            <div class="right-icons">
                <a href="/chat" class="mess-icon" style='margin-left:5px'>
                    <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo'></box-icon></span>
                </a>
                <span class="icon icon-circle" id="notification-btn" style="display:none"><box-icon name='bell' type='solid' ></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
            </div>

        </div>

        <div class="dropdown-menu" id="notification-menu">
            <p>Notification content goes here...</p>
        </div>
    
    <div class="dropdown-menu" id="notification-menu">
        <p>Notification content goes here...</p>
    </div>
    <div class="user-menu" id="user-menu" >
        <div class="user-info">
            <a href="profile?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                <button class="user-info-button">
                    <img src="data:image/jpg;base64,${sessionScope.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                    <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                </button>
            </a>
        </div>
        <div class="menu-item">
<a href="setting" style="text-decoration: none">
            <box-icon name='cog' type='solid' style="margin-right:3%; margin-left:1%; width: 50%;">Settings</box-icon>Settings
</a>
        </div>
         <div class="menu-item">
        </div>

        <form method="post" action="/logout" style="display: inline; width: 100%;">
            <div class="menu-item" style="display: flex; align-items: center; cursor: pointer; width: 100%;">
                <box-icon type='solid' name='log-out'style=" margin-left:1%;"></box-icon>
                <button type="submit" style="border: none; background: none; color: black; font-size: 16px; margin-left: 5px; cursor: pointer; flex: 1; text-align: left;">
                    Log Out
                </button>
            </div>
        </form>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-4 dashBoard" style="margin-top:1%;">
                <a href="profile?userId=${sessionScope.user['user_id']}" style="text-decoration:none; width: fit-content;">
                    <div class="UserAvatar" >
                        <img src="data:image/jpg;base64,${user.profile_pic}" class="img-fluid rounded-circle avatar" style="margin-left:1%;">
                        <span class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</span>        
                    </div></a>

                <div class="RightItem">
                    <a href="/friendRequestServlet" style="text-decoration: none">
                         <div><i class='fas fa-user-friends'style="margin-left:5%;" > </i>    Friends</div>
                    </a>                   
                    <a href="savePostServlet" style="text-decoration: none">
                        <div>
                            <box-icon type='solid' name='bookmark'style="margin-left:5%;"></box-icon> Saved
                        </div>
                    </a>
                    <a href="marketLink" style="text-decoration: none">
                         <div><box-icon name='store-alt' type='solid'style="margin-left:5%;"></box-icon> Market</div>
                    </a>
                   
                    <a href="lmaterialLink"style="text-decoration: none"> 
                        <div><box-icon type='solid' name='book'style="margin-left:5%;"></box-icon> Learning Materials</div>
                    </a>
                    <a href="game" style="text-decoration: none"><div><i class='fas fa-gamepad' style='font-size:20px;margin-left:5%;'></i> Game</div></a>
                    
                    <hr style="border: 1px solid black; width: 100%;"><!-- comment -->

                </div>
            </div>
            <div class="col-4 mainContainer">
                <div class="post">
                    <section class="input">
                        <a href="profile?userId=${sessionScope.user['user_id']}" style="text-decoration:none"  ><img src="data:image/jpg;base64,${user.profile_pic}"  class="img-fluid rounded-circle avatar2" style="margin-right: 10px;"></a> 
                        <div class="inputArea">
                            <input type="text" placeholder="What ya thinking..." id="posting">
                        </div>
                        <hr style="border: 1px solid black; width: 100%; margin:0;">
                        <div class="btn-document">
                            <div class="item" id="photoVideoBtn" >Photo</div>
                            <div class="item" id="photoVideoBtn">Video</div>
                        </div>
                    </section>
                </div>

                <div class="overlay" id="overlay" style="display: none;"></div>

                <div class="form-container" id="formContainer" style="display: none;">
                    <form action="/home" method="post" enctype="multipart/form-data" onsubmit="document.getElementById('myBtn').disabled = true;">
                        <div class="form-content">
                            <div class="head"><p class="form-title">Create post</p>
                                <button type="button" class="close-button" aria-label="Close">X</button>
                            </div>
                            <hr class="hr-line">
                            <div class="form-header">                        
                                <a href="profile?userId=${sessionScope.user['user_id']}" style="text-decoration:none"  ><img src="data:image/jpg;base64,${sessionScope.user['profile_pic']}" class="avatar"></a> 
                                <p class="mb-0 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                            </div>
                            <div class="textarea-container"　id="formContainer">
                                <textarea class="form-control" id="body" name="postContent" placeholder="What ya thinking" maxlength="300" oninput="adjustFontSize()"></textarea>
                            </div>
                            <hr class="hr-line" >
                            <div class="upload-section" style="margin-top:0;margin-bottom:1%;">
                                <div class="item" style="height:50px; padding-top:3%;">
                                    <label for="photo-upload">
                                        <i class="fas fa-cloud-upload-alt"></i> Photo
                                    </label>
                                    <input id="photo-upload" type="file" name="image" accept=".jpeg, .png, .jpg" style="display: none;" onchange="updateFileName(this)">
                                </div>
                                <div class="item"style="height:50px; padding-top:3%;">
                                    <label for="file-upload">
                                        <i class="fas fa-file-alt"></i> Video
                                    </label>
                                    <input id="file-upload" type="file" name="file" accept=".txt, .pdf, .docx" style="display: none;" onchange="updateFileName(this)">
                                </div>
                            </div>
                        </div>
                        <button id="myBtn" type="submit" class="submit-button">Post</button>
                    </form>
                </div>


                 <div>
                    <c:forEach var="post" items="${posts}">
                        <div class="post mb-4" style="overflow-wrap: break-word" data-post-id="${post.post_id}" data-liked="${post.likedByCurrentUser}">
                            <div class="post-header d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <img src="data:image/jpg;base64,${post.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 40px; height: 40px;object-fit: cover;">
                                    <small>${post.first_name} ${post.last_name} -- <fmt:formatDate value="${post.post_time}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                                </div>
                                <span class="thre-dto-btn fas fa-ellipsis-h"></span>
                                <div class="dropdown-save" style="display: none;">
                                    <form action="/savePostServlet" method="post">
                                        <input type="hidden" name="postId" value="${post.post_id}">
                                        <c:choose>
                                            <c:when test="${post.savedByCurrentUser}">
                                                <button type="submit" class="btn-warning">
                                                    <i class="fas fa-bookmark me-2"></i>Unsave Post
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="submit" class="btn-primary">
                                                    <i class="far fa-bookmark me-2"></i>Save Post
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </div>
                            </div>

                            <c:if test="${post.isShared}">

                                <div class="original-post-info d-flex align-items-center">
                                    <img src="data:image/jpg;base64,${post.originalPosterAvatar}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px;object-fit: cover;">
                                    <small>${post.originalPosterName}</small>
                                </div>
                            </c:if>
                            <p>${post.body}</p> 
                            <c:if test="${not empty post.image_path}">
                                <div>

                                    <c:choose>
                                        <c:when test="${post.type == 'image'}">
                                            <img src="${post.image_path}" style="max-width : 100%">
                                        </c:when>
                                        <c:otherwise>
                                            <video style="max-width: 100%" controls>
                                                <source src="${post.image_path}" type="video/mp4">
                                                
                                            </video>
                                        </c:otherwise>
                                    </c:choose>

                                </div>
                            </c:if>


                            <div class="post-ratings-container">
                                <div class="post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''}" style="margin-left:2%;">
                                    <button type="button" style="background: none; border: none; cursor: pointer; padding: 0;">
                                        <span class="material-icons" style="color: ${post.likedByCurrentUser ? '#1877f2' : '#65676b'};">
                                            thumb_up
                                        </span>
                                    </button>
                                    <span class="like-count"><span class="post-rating-count">${post.like_count}</span></span>
                                </div>
                                <%-- <c:if test="${!post.isShared}"> --%>
                              
                                <div class="post-share" style="margin-left:73%">
                                    <form action="sharePostServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="postId" value="${post.post_id}">
                                        <input type="hidden" name="sourceUrl" value="home">
                                        <button type="submit" class="btn btn-link">Share</button>
                                    </form>
                                    <span class="post-share-count">${post.shareCount}</span>
                                </div>
                                <%--   </c:if> --%>
                            </div>
                            <div class="post-comments">
                                <c:forEach var="comment" items="${post.comments}">
                                    <div class="comment mb-2" style="margin-left: 20px;">
                                        <div class="comment-header">
                                            <img src="data:image/jpg;base64,${comment.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                            <small><strong>${comment.first_name} ${comment.last_name}</strong></small>
                                        </div>
                                        <div class="comment-body" style="display: flex; justify-content: space-between; align-items: center;">
                                            <p style="margin-bottom: 0;" class="comment-text">${comment.comment_text}</p>
                                            <div class="comment-options">
                                                <c:if test="${sessionScope.user['user_id'] == comment.user_id}">
                                                    <button class="three-dot-btn" data-comment-id="${comment.comment_id}">...</button>
                                                </c:if>
                                                <div class="comment-actions" style="display: none; flex-direction:column;">
                                                    
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
                                            <textarea name="newCommentText" class="form-control" style="margin-left: 0px; margin-top: 10px">${comment.comment_text}</textarea>
                                            <button type="submit" class="btn btn-primary">Save</button>
                                            <button type="button" class="btn btn-secondary cancel-edit-comment">Cancel</button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </div>


                            <form action="/commentServlet" method="post" id="commentform" class="mb-4 post-method">
                                <div class="mb-3">
                                    <input type="text" class="form-control" style="border-radius: 20px;width: 90%; height: 30px;margin-bottom:0;" id="body" name="commentContent" maxlength="300" rows="2" placeholder="Comment" style="width:80%; height: 35px">
                                </div>
                                <input type="hidden" name="sourceUrl" value="home">
                                <input type="hidden" name="post_id" value="${post.post_id}">
                            </form>


                            <%----%>
                        </div>
                        <br>
                    </c:forEach>
                </div>
            </div>

            <div class="col-4 listFriend">
                <aside class="col-2 py-3  friend-list sticky-sidebar" style="width:90%;justify-content: end;display:grid;">
                    <h2 style="color: #0d6efd">List Friends</h2>
                    <hr style="margin:0;border:solid black 1px">
                    <c:forEach var="friend" items="${friends}">
                        <div class="post mb-4 d-flex align-items-center friends" style="overflow-wrap: break-word;border: none;background: none;">
                            <a href="profile?userId=${friend.user_id}" class="user-link friend" data-user-id="${friend.user_id}" style="text-decoration:none;">
                                <img src="data:image/jpg;base64,${friend.profile_pic}" alt="avatar picture" class="img-fluid rounded-circle avatar me-2" style="width: 50px; height: 50px; object-fit: cover;">
                                 <small>${friend.first_name} ${friend.last_name}</small>
                            </a>
                           
                        </div>
                    </c:forEach>
                     
                </aside>
            </div>
        </div>
    </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
         <script src="assets/js/reaction.js" defer></script>

        <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            const style = document.createElement('style');
                                            style.textContent = `
        .post {
            position: relative;
        }
        
        .thre-dto-btn {
            cursor: pointer;
            padding: 5px 10px;
            float: right;
        }
        
        .post .dropdown-save {
            position: absolute;
            right: 10px;
            top: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 8px;
            min-width: 150px;
            z-index: 1000;
        }
        
        .post .dropdown-save button {
            width: 100%;
            padding: 8px 12px;
            border: none;
            background: none;
            text-align: left;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.2s;
        }
        
        .post .dropdown-save button:hover {
            background-color: #f0f2f5;
        }
        
        .post .dropdown-save button.btn-primary {
            color: #1877f2;
        }
        
        .post .dropdown-save button.btn-warning {
            color: #ed6c02;
        }
    `;
                                            document.head.appendChild(style);

                                            const posts = document.querySelectorAll('.post');

                                            posts.forEach(post => {
                                                const threeDotBtn = post.querySelector('.thre-dto-btn');
                                                const dropdownMenu = post.querySelector('.dropdown-save');

                                                if (threeDotBtn && dropdownMenu) {
                                                    threeDotBtn.addEventListener('click', (e) => {
                                                        e.stopPropagation();

                                                        document.querySelectorAll('.post .dropdown-save').forEach(menu => {
                                                            if (menu !== dropdownMenu) {
                                                                menu.style.display = 'none';
                                                            }
                                                        });

                                                        dropdownMenu.style.display = dropdownMenu.style.display === 'none' ? 'block' : 'none';
                                                    });
                                                }
                                            });

                                            document.addEventListener('click', (e) => {
                                                if (!e.target.closest('.thre-dto-btn')) {
                                                    document.querySelectorAll('.post .dropdown-save').forEach(menu => {
                                                        menu.style.display = 'none';
                                                    });
                                                }
                                            });
                                        });
        </script>

        <!-- delete update comment + button"..." -->
        <script>
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
        </script>
        <!-- --------- -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const searchInput = document.getElementById('search-input');
                const searchForm = document.getElementById('searchForm');

                searchInput.addEventListener('keypress', function (event) {
                    if (event.key === 'Enter') {
                        event.preventDefault();
                        searchForm.submit();
                    }
                });
            });

            document.getElementById('messenger-btn').addEventListener('click', function () {
                toggleMenu('messenger-menu', 'messenger-btn');
            });

            document.getElementById('notification-btn').addEventListener('click', function () {
                toggleMenu('notification-menu', 'notification-btn');
            });

            document.getElementById('user-btn').addEventListener('click', function () {
                toggleMenu('user-menu', 'user-btn');
            });

//            document.addEventListener('click', function (event) {
//                const messengerMenu = document.getElementById('messenger-menu');
//                const notificationMenu = document.getElementById('notification-menu');
//                const userMenu = document.getElementById('user-menu');
//                const messengerBtn = document.getElementById('messenger-btn');
//                const notificationBtn = document.getElementById('notification-btn');
//                const userBtn = document.getElementById('user-btn');
//
//                if (!messengerMenu.contains(event.target) && !messengerBtn.contains(event.target)) {
//                    messengerMenu.style.display = 'none';
//                    messengerBtn.classList.remove('active-button');
//                }
//                if (!notificationMenu.contains(event.target) && !notificationBtn.contains(event.target)) {
//                    notificationMenu.style.display = 'none';
//                    notificationBtn.classList.remove('active-button');
//                }
//                if (!userMenu.contains(event.target) && !userBtn.contains(event.target)) {
//                    userMenu.style.display = 'none';
//                    userBtn.classList.remove('active-button');
//                }
//            });

            function toggleMenu(menuId, btnId) {
                const menu = document.getElementById(menuId);
                const button = document.getElementById(btnId);
                const otherMenuIds = ['messenger-menu', 'notification-menu', 'user-menu'].filter(id => id !== menuId);
                const otherButtons = ['messenger-btn', 'notification-btn', 'user-btn'].filter(id => id !== btnId);

                if (menu.style.display === 'none' || menu.style.display === '') {
                    menu.style.display = 'block';
                    button.classList.add('active-button');
                    otherMenuIds.forEach(id => document.getElementById(id).style.display = 'none');
                    otherButtons.forEach(id => document.getElementById(id).classList.remove('active-button'));
                } else {
                    menu.style.display = 'none';
                    button.classList.remove('active-button');
                }
            }
            document.addEventListener('DOMContentLoaded', function () {
                const overlay = document.getElementById('overlay');
                const formContainer = document.getElementById('formContainer');
                const postingInput = document.getElementById('posting');
                const photoVideoBtn = document.getElementById('photoVideoBtn');
                const fileBtn = document.getElementById('fileBtn');
                const closeButton = document.querySelector('.close-button');

                function showForm() {
                    overlay.style.display = 'flex';
                    formContainer.style.display = 'block';
                }

                function hideForm() {
                    overlay.style.display = 'none';
                    formContainer.style.display = 'none';
                }

                postingInput.addEventListener('click', showForm);
                photoVideoBtn.addEventListener('click', showForm);
                fileBtn.addEventListener('click', showForm);

                closeButton.addEventListener('click', hideForm);
                overlay.addEventListener('click', function (event) {
                    if (event.target === overlay) {
                        hideForm();
                    }
                });
                postForm.addEventListener('submit', function (event) {
                    event.preventDefault();
                    hideForm();

                });
            });


            document.addEventListener('DOMContentLoaded', function () {
                const textarea = document.getElementById('body');
                const formContainer = document.getElementById('formContainer');
                const baseFormHeight = 415;
                const initialTextareaHeight = 125;
                textarea.addEventListener('input', function () {
                    adjustFontSizeAndFormHeight();
                });
                function adjustFontSizeAndFormHeight() {
                    const maxLines = 3;
                    const initialFontSize = 25;
                    const reducedFontSize = 15;
                    textarea.style.fontSize = initialFontSize + 'px';
                    textarea.style.height = 'auto';

                    const lineHeight = parseInt(window.getComputedStyle(textarea).lineHeight);
                    const lines = Math.floor(textarea.scrollHeight / lineHeight);
                    if (lines > maxLines) {
                        textarea.style.fontSize = reducedFontSize + 'px';
                    }
                    textarea.style.height = textarea.scrollHeight + 'px';
                    const textareaExtraHeight = textarea.scrollHeight - initialTextareaHeight;
                    formContainer.style.height = (baseFormHeight + textareaExtraHeight) + 'px';
                }
            });
        </script>



</body>
</html>
