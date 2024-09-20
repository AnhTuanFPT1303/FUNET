<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Social Network</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/home.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    </head>
    <body>
        <header id="header">
            <nav class="navbar navbar-expand-lg bg-blue text-white shadow-sm sticky-top">
                <div class="container-fluid">
                    <a class="navbar-brand text-white me-2" href="/FUNET/home" style="font-weight: bold">BLAH</a>
                    <form class="d-flex me-auto" method="get" action="/FUNET/searchServlet">
                        <input class="form-control me-2 rounded-pill" name="search-name" type="search" placeholder="Finding in BLAH" aria-label="Search">
                    </form>
                    <div class="d-flex justify-content-center align-items-center navbar-btn-container">
                        <button class="btn btn-light rounded-pill nav-btn mx-3">
                            <i class="fas fa-home fa-lg"></i>
                        </button>
                        <button class="btn btn-light rounded-pill nav-btn mx-3">
                            <i class="fas fa-users fa-lg"></i>
                        </button>
                        <button class="btn btn-light rounded-pill nav-btn mx-3">
                            <i class="fas fa-store fa-lg"></i>
                        </button>
                    </div>
                    <div class="d-flex align-items-center ms-auto">
                        <div class="dropdown me-2">
                            <button class="btn btn-light rounded-circle" type="button" id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-bell fa-lg"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-large" aria-labelledby="notificationDropdown">
                                <li><a class="dropdown-item" href="#">Notification 1</a></li>
                                <li><a class="dropdown-item" href="#">Notification 2</a></li>
                                <li><a class="dropdown-item" href="#">Notification 3</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">See All Notifications</a></li>
                            </ul>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-light rounded-circle" type="button" id="settingsDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-cog fa-lg"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-large" aria-labelledby="settingsDropdown">
                                <li><a class="dropdown-item" href="#">Profile</a></li>
                                <li><a class="dropdown-item" href="#">Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Report</a></li>
                                <li><a class="dropdown-item" href="/FUNET/logout">Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <div class="container-fluid mt-5 pt-3">
            <div class="row">
                <!-- Fixed Sidebar Left -->
                <nav class="col-2 py-3 bg-light fixed-sidebar aside-left">
                    <div class="profile-section mb-3 d-flex align-items-center">
                        <a href="userpageServlet?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                            <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                            <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                        </a>
                    </div>
                    <div class="d-flex flex-column">
                        <button class="btn btn-light mb-2 text-start"><i class="fas fa-users me-2"></i> Groups</button>
                        <button class="btn btn-light mb-2 text-start"><i class="fas fa-chalkboard me-2"></i> Classes</button>
                        <button class="btn btn-light mb-2 text-start"><i class="fas fa-store me-2"></i> Marketplace</button>
                        <button class="btn btn-light mb-2 text-start"><i class="fas fa-book me-2"></i> Study Materials</button>
                        <button class="btn btn-light mb-2 text-start"><i class="fas fa-calendar me-2"></i> Schedule</button>
                        <button class="btn btn-light mb-2 text-start"><i class="fas fa-gamepad me-2"></i> Game</button>
                    </div>
                </nav>

                <!-- Main Content -->
                <div class="col-md-8 content-wrapper">
                    <main class="main-class">
                        <h1 class="mt-3 text-primary home-logo">HOME</h1>

                        <!-- Thông báo nếu có lỗi -->
                        <c:if test="${not empty param.notification}">
                            <div class="alert alert-danger">${param.notification}</div>
                        </c:if>

                        <!-- Form đăng bài -->
                        <div class="container">
                            <div class="form-container" id="formContainer">
                                <form id="postForm" action="/FUNET/home" method="post" class="mb-4 post-method" enctype="multipart/form-data" onsubmit="document.getElementById('myBtn').disabled = true;">
                                    <div class="mb-3">
                                        <textarea class="form-control" id="body" name="postContent" rows="2" placeholder="What ya thinking" maxlength="300"></textarea>
                                    </div>
                                    <input type="file" name="image" accept=".jpeg, .png, .jpg">
                                    <br>
                                    <button id="myBtn" type="submit" class="btn btn-primary" style="padding: 5px 25px; margin-top: 5px;">Post</button>
                                </form>
                            </div>
                        </div>

                        <div class="notification" id="notification"></div>
                        <div class="overlay" id="overlay" style="display:none;"></div>
                    </main>

                    <!-- Vòng lặp hiển thị các bài post -->
                    <c:forEach var="post" items="${posts}">
                        <div class="post mb-4" style="overflow-wrap: break-word" data-post-id="${post.post_id}" data-liked="${post.likedByCurrentUser}">
                            <div class="post-header">
                                <img src="assets/profile_avt/${post.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 40px; height: 40px;">
                                <small>${post.first_name} ${post.last_name} -- 
                                    <fmt:formatDate value="${post.post_time}" pattern="yyyy-MM-dd HH:mm:ss" />
                                </small>
                            </div>

                            <!-- Nội dung bài post -->
                            <p>${post.body}</p>

                            <!-- Hình ảnh nếu có -->
                            <c:if test="${not empty post.image_path}">
                                <div>
                                    <img src="assets/post_image/${post.image_path}" style="max-width : 60%">
                                </div>
                            </c:if>

                            <!-- Số lượng lượt like -->
                            <div class="post-ratings-container">
                                <div class="post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''}">
                                    <span class="post-rating-button material-icons" style="cursor: pointer">thumb_up</span>
                                    <span class="post-rating-count">${post.like_count}</span>
                                </div>
                            </div>

                            <!-- Vòng lặp hiển thị các bình luận -->
                            <div class="post-comments">
                                <c:forEach var="comment" items="${post.comments}">
                                    <div class="comment mb-2" style="margin-left: 20px;">
                                        <div class="comment-header">
                                            <img src="assets/profile_avt/${comment.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px;">
                                            <small><strong>${comment.first_name} ${comment.last_name}</strong></small>
                                        </div>
                                        <div class="comment-body">
                                            <p style="margin-bottom: 0;">${comment.comment_text}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Form để người dùng bình luận -->
                            <form action="/FUNET/commentServlet" method="post" class="mb-4 post-method">
                                <div class="mb-3">
                                    <textarea class="form-control" id="body" name="commentContent" rows="2" placeholder="Reply"></textarea>
                                </div>
                                <input type="hidden" name="postId" value="${post.post_id}">
                                <button type="submit" class="btn btn-primary" style="padding: 5px 25px; margin-top: 5px;">Comment</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>






            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script>
                                    const form = document.getElementById('postForm');
                                    const formContainer = document.querySelector('.form-container');
                                    const overlay = document.getElementById('overlay');
                                    const notification = document.getElementById('notification');

                                    formContainer.addEventListener('click', () => {
                                        formContainer.classList.add('expanded');
                                        overlay.style.display = 'block';
                                    });

                                    overlay.addEventListener('click', () => {
                                        formContainer.classList.remove('expanded');
                                        overlay.style.display = 'none';
                                    });

                                    form.addEventListener('submit', (e) => {
                                        e.preventDefault();
                                        form.classList.add('was-validated');

                                        if (form.checkValidity()) {
                                            const formData = new FormData(form);

                                            fetch(form.action, {
                                                method: form.method,
                                                body: formData
                                            })
                                                    .then(response => {
                                                        if (!response.ok) {
                                                            throw new Error('Failed to submit post');
                                                        }
                                                        return response.json();
                                                    })
                                                    .then(data => {
                                                        notification.textContent = 'Post submitted successfully!';
                                                        notification.style.display = 'block';

                                                        setTimeout(() => {
                                                            notification.style.display = 'none';
                                                            form.reset();
                                                            form.classList.remove('was-validated');
                                                            formContainer.classList.remove('expanded');
                                                            overlay.style.display = 'none';
                                                        }, 3000);
                                                    })
                                                    .catch(error => {
                                                        notification.textContent = 'Failed to submit post. Please try again!';
                                                        notification.style.display = 'block';
                                                        setTimeout(() => {
                                                            notification.style.display = 'none';
                                                        }, 3000);
                                                    });
                                        }
                                    });
                                    document.getElementById('postForm').addEventListener('submit', function (event) {
                                        event.preventDefault();
                                        const form = this;
                                        const formData = new FormData(form);

                                        const submitBtn = document.getElementById('myBtn');
                                        submitBtn.disabled = true;

                                        fetch(form.action, {
                                            method: form.method,
                                            body: formData
                                        })
                                                .then(response => response.text())
                                                .then(data => {

                                                    const postList = document.querySelector('.post-list');
                                                    postList.innerHTML = data + postList.innerHTML;


                                                    form.reset();
                                                    submitBtn.disabled = false;

                                                    formContainer.classList.remove('expanded');
                                                    overlay.style.display = 'none';
                                                })
                                                .catch(error => {
                                                    console.error('Error submitting the post:', error);
                                                    submitBtn.disabled = false;
                                                });
                                    });



    </script>
</body>
</html>
