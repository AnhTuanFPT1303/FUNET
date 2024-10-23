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

        <link rel="stylesheet" type="text/css" href="assets/css/home.css">


    </head>
    <body>
        <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%">Logo</div>
            </a>
            <form class="" method="get" action="/FUNET/searchServlet" id="searchForm">
                <div class="search-bar">
                    <input  name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input">

                </div>
            </form>


            <div class="center-buttons">
                <div id="home-btn">
                    <a href="/FUNET/home">
                        <button class="center-button" >
                            <div class="btn-content">
                                <box-icon type='solid' name='home'></box-icon>
                            </div>
                        </button>
                </div>


                <a href="home">
                    <button class="center-button" id="video-btn">
                        <div class="btn-content">
                            <box-icon name='videos' type='solid'></box-icon>
                        </div>
                    </button>
                </a>

                <a href="home">
                    <button class="center-button" id="market-btn">
                        <div class="btn-content">
                            <box-icon name='store-alt' type='solid'></box-icon>
                        </div>
                    </button>
                </a>

                <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                    <button class="center-button" id="friend-btn">
                        <div class="btn-content">
                            <box-icon name='group' type='solid'></box-icon>
                        </div>
                    </button>
                </a>
            </div>



            <div class="right-icons">
                <a href="/FUNET/chat" class="mess-icon " style='margin-left:5px'>
                    <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo' ></box-icon></span>
                </a>
                <span class="icon icon-circle" id="notification-btn"><box-icon name='bell' type='solid' ></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
            </div>

        </div>

    </div>
    <div class="user-menu" id="user-menu">
        <div class="user-info">
            <a href="profile?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                <button class="user-info-button">
                    <img src="assets/profile_avt/${sessionScope.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                    <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                </button>
            </a>
        </div>
        <div class="menu-item">
            <box-icon name='cog' type='solid'>Settings</box-icon>Settings
        </div>
        <div class="menu-item">
            <box-icon name='error-circle'></box-icon>Report
        </div>
        <div class="menu-item">
            <box-icon name='moon' type='solid'></box-icon>Dark Mode
        </div>

        <form method="post" action="/FUNET/logout" style="display: inline; width: 100%;">
            <div class="menu-item" style="display: flex; align-items: center; cursor: pointer; width: 100%;">
                <box-icon type='solid' name='log-out'></box-icon>
                <button type="submit" style="border: none; background: none; color: black; font-size: 16px; margin-left: 5px; cursor: pointer; flex: 1; text-align: left;">
                    Log Out
                </button>
            </div>
        </form>
    </div>
    <div class="container"><div class="row">
            <div class="col-4 dashboard" style="margin-top:1%;">
                <a href="profile?userId=${sessionScope.user['user_id']}" style="text-decoration:none">
                    <div class="UserAvatar">
                        <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                        <span class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</span>        
                    </div></a>

                <div class="RightItem">
                    <div><i class='fas fa-user-friends' > </i>    Friends</div>
                    <div> <box-icon name='group' type='solid' ></box-icon>    Groups  </div>
                    <div> <box-icon type='solid' name='bookmark'></box-icon>    Saved  </div>
                    <div><box-icon name='videos' type='solid'></box-icon> Video </div>
                    <div><box-icon name='store-alt' type='solid'></box-icon> Market</div>
                    <a href="lmaterialLink" style="text-decoration: none;"> <div><box-icon type='solid' name='book'></box-icon> Learning Materials</div> </a>
                   
                    <a href="game" style="text-decoration: none;"> <div><i class='fas fa-gamepad' style='font-size:20px'></i> Game</div></a>
                    <hr style="border: 1px solid black; width: 100%;"><!-- comment -->
                    <a href="dashBoard" style="text-decoration: none;" ><div><box-icon type='solid' name='dashboard'></box-icon> Dashboard</div>
</a>

                    <p>Your ShortCut</p>
                </div>
            </div>
            <div class="col-4 postContainer">
                <div class="post">
                    <section class="input">
                        <a href="profile?userId=${sessionScope.user['user_id']}" style="text-decoration:none"  ><img src="assets/profile_avt/${user.profile_pic}"  class="img-fluid rounded-circle avatar" style="margin-right: 10px;"></a> 
                        <div class="inputArea">
                            <input type="text" placeholder="What ya thinking..." id="posting">
                        </div>
                        <hr style="border: 1px solid black; width: 100%;">
                        <div class="btn-document">
                            <div class="item" id="photoVideoBtn" >Photo/Video</div>
                            <div class="item" id="fileBtn">File</div>
                        </div>
                    </section>
                </div>

                <div class="overlay" id="overlay" style="display: none;"></div>

                <div class="form-container" id="formContainer" style="display: none;">
                    <form action="/FUNET/home" method="post" enctype="multipart/form-data" onsubmit="document.getElementById('myBtn').disabled = true;">
                        <div class="form-content">
                            <div class="head"><p class="form-title">Create post</p>
                                <button type="button" class="close-button" aria-label="Close" style="border:none;">X</button>
                            </div>

                            <hr class="hr-line">
                            <div class="form-header">                        <a href="profile?userId=${sessionScope.user['user_id']}" style="text-decoration:none"  ><img src="assets/profile_avt/${sessionScope.user['profile_pic']}" class="avatar"></a> 


                                <p class="mb-0 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                            </div>
                            <div class="textarea-container"　id="formContainer">
                                <textarea class="form-control" id="body" name="postContent" placeholder="What ya thinking" maxlength="300" oninput="adjustFontSize()"></textarea>
                            </div>
                            <hr class="hr-line">
                            <div class="upload-section">
                                <div class="item">
                                    <label for="photo-upload">
                                        <i class="fas fa-cloud-upload-alt"></i> Photo/Video
                                    </label>
                                    <input id="photo-upload" type="file" name="image" accept=".jpeg, .png, .jpg" style="display: none;" onchange="updateFileName(this)">
                                </div>
                                <div class="item">
                                    <label for="file-upload">
                                        <i class="fas fa-file-alt"></i> File
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
                            <div class="post-header">
                                <img src="assets/profile_avt/${post.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 40px; height: 40px;object-fit: cover;">
                                <small>${post.first_name} ${post.last_name} -- <fmt:formatDate value="${post.post_time}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                            </div>
                            <c:if test="${post.isShared}">

                                <div class="original-post-info d-flex align-items-center">
                                    <img src="assets/profile_avt/${post.originalPosterAvatar}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px;object-fit: cover;">
                                    <small>${post.originalPosterName}</small>
                                </div>
                            </c:if>
                            <p>${post.body}</p> 
                            <c:if test="${not empty post.image_path}">
                                <div>
                                    <img src="assets/post_image/${post.image_path}" style="max-width : 100%">
                                </div>
                            </c:if>


                            <div class="post-ratings-container">
                                <div class="post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''}">
                                    <button type="button" style="background: none; border: none; cursor: pointer; padding: 0;">
                                        <span class="material-icons" style="color: ${post.likedByCurrentUser ? '#1877f2' : '#65676b'};">
                                            thumb_up
                                        </span>
                                    </button>
                                    <span class="like-count"><span class="post-rating-count">${post.like_count}</span></span>
                                </div>
                                <%-- <c:if test="${!post.isShared}"> --%>
                                <div class="post-share">
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
                                            <img src="assets/profile_avt/${comment.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                            <small><strong>${comment.first_name} ${comment.last_name}</strong></small>
                                        </div>
                                        <div class="comment-body">
                                            <p style="margin-bottom: 0;">${comment.comment_text}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>


                            <form action="/FUNET/commentServlet" method="post" id="commentform" class="mb-4 post-method">
                                <div class="mb-3">
                                    <input type="text" class="form-control" style="border-radius: 20px;width: 90%; height: 30px;" id="body" name="commentContent" maxlength="300" rows="2" placeholder="Comment" style="width:80%; height: 35px">
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

            <div class="col-4 friendContainer">
                <aside class="col-2 py-3  friend-list sticky-sidebar" style="width:90%;justify-content: end;display:grid;">
                    <h2 style="color: #0d6efd">List Friends</h2>
                    <hr style="margin:0;border:solid black 1px">
                    <c:forEach var="friend" items="${friends}">
                        <div class="post mb-4 d-flex align-items-center" style="overflow-wrap: break-word">
                            <a href="#" class="user-link friend" data-user-id="${friend.user_id}">
                                <img src="assets/profile_avt/${friend.profile_pic}" alt="avatar picture" class="img-fluid rounded-circle avatar me-2" style="width: 50px; height: 50px; object-fit: cover;">
                            </a>
                            <small>${friend.first_name} ${friend.last_name}</small>
                        </div>
                    </c:forEach>
                </aside>
            </div>
        </div>











        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/likeButton.js" defer></script>


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

                                        document.addEventListener('DOMContentLoaded', function () {
                                            document.getElementById('messenger-btn').addEventListener('click', function (event) {
                                                event.stopPropagation();
                                                toggleMenu('messenger-menu', 'messenger-btn');
                                            });

                                            document.getElementById('notification-btn').addEventListener('click', function (event) {
                                                event.stopPropagation();
                                                toggleMenu('notification-menu', 'notification-btn');
                                            });

                                            document.getElementById('user-btn').addEventListener('click', function (event) {
                                                event.stopPropagation();
                                                toggleMenu('user-menu', 'user-btn');
                                            });

                                            document.addEventListener('click', function (event) {
                                                const messengerMenu = document.getElementById('messenger-menu');
                                                const notificationMenu = document.getElementById('notification-menu');
                                                const userMenu = document.getElementById('user-menu');
                                                const messengerBtn = document.getElementById('messenger-btn');
                                                const notificationBtn = document.getElementById('notification-btn');
                                                const userBtn = document.getElementById('user-btn');

                                                if (!messengerMenu.contains(event.target) && !messengerBtn.contains(event.target)) {
                                                    messengerMenu.style.display = 'none';
                                                    messengerBtn.classList.remove('active-button');
                                                }
                                                if (!notificationMenu.contains(event.target) && !notificationBtn.contains(event.target)) {
                                                    notificationMenu.style.display = 'none';
                                                    notificationBtn.classList.remove('active-button');
                                                }
                                                if (!userMenu.contains(event.target) && !userBtn.contains(event.target)) {
                                                    userMenu.style.display = 'none';
                                                    userBtn.classList.remove('active-button');
                                                }
                                            });

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
                                        });
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
                                        document.addEventListener('DOMContentLoaded', function () {
                                            const commentForm = document.getElementById('commentForm');
                                            const commentInput = document.getElementById('body');

                                            commentInput.addEventListener('keydown', function (event) {
                                                if (event.key === 'Enter' && !event.shiftKey) {
                                                    event.preventDefault();
                                                    if (commentInput.value.trim() !== '') {
                                                        commentForm.submit();
                                                    }
                                                }
                                            });
                                        });

                                        document.addEventListener('DOMContentLoaded', function () {
                                            const currentUrl = window.location.href;
                                            const centerButtons = document.querySelectorAll('.center-button');

                                            centerButtons.forEach(button => {
                                                const buttonUrl = button.closest('a').href;
                                                if (currentUrl === buttonUrl) {
                                                    button.classList.add('active');
                                                }
                                            });
                                        });




        </script>

</body>
</html>