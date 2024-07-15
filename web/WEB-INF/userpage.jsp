<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/home.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <style>
            /* Add some decorative elements */
            body {
                background-image: linear-gradient(to bottom, #f8f9fa, #fff);
            }
            .custom-navbar {
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .profile-section, .settings-section {
                background-color: #f7f7f7;
                padding: 10px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .post {
                background-color: #fff;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .post-header {
                color: #337ab7;
            }
            .post-rating-selected > .post-rating-button,
            .post-rating-selected > .post-rating-count {
                color: #337ab7; /* blue color for liked posts */
            }
            .post-rating-button {
                font-size: 18px;
                margin-right: 5px;
            }
            .post-rating-count {
                font-size: 14px;
                margin-left: 5px;
            }
        </style>
    </head>
    <body>
        <header id="header">
            <nav class="navbar custom-navbar">
                <div class="container-fluid d-flex align-items-center">
                    <a class="navbar-brand text-primary" href="/blahproject/home" style="font-weight: bold">BLAH</a>
                    <form class="d-flex ms-2 flex-grow-1" method="get" action="/blahproject/searchServlet">
                        <input class="form-control" name="search-name" type="search" placeholder="Finding in BLAH" aria-label="Search">
                        <input type="submit" value="Submit">
                    </form>
                    <a class="navbar-brand text-primary log-out" href="/blahproject" style="font-weight: bold">Log out</a>
                </div>
            </nav>
        </header>
        <div class="container-fluid">
            <div class="row all-post">
                <nav class="col-2 py-3 bg-light">
                    <div class="profile-section mb-3 text-center">
                        <a href="userpageServlet?userId=${user.user_id}" class="text-decoration-none text-dark d-flex align-items-center">
                            <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                            <p class="ms-3" style="text-align: left;">Name: ${user.first_name} ${user.last_name}</p>
                        </a>
                        <form action="changeAvatarServlet" method="post" class="mt-3 d-flex align-items-center" enctype="multipart/form-data">
                            <input type="file" name="profile_pic" accept=".jpeg, .png, .jpg" class="form-control-file">
                            <button type="submit" class="btn btn-primary ms-2">Change Avatar</button>
                        </form>
                    </div>
                    <hr>
                    <c:if test="${sessionScope.user['user_id'] == user.user_id}">
                        <div class="settings-section mb-3 text-center">
                            <h2>Settings</h2>
                            <form action="settingServlet" method="get">
                                <button type="submit" name="action" value="changeInformation" class="btn btn-secondary mb-2">Change Information</button>
                            </form>
                        </div>
                    </c:if>
                </nav>
                <main class="col-8">
                    <h1 class="mt-3 text-primary home-logo">Welcome to ${user.first_name} ${user.last_name} blog!</h1>
                    <form action="/blahproject/userpageServlet" method="post" class="mb-4 post-method" enctype="multipart/form-data" onsubmit="document.getElementById('myBtn').disabled = true;">
                        <div class="mb-3">
                            <textarea class="form-control" id="body" name="postContent" rows="2" placeholder="What ya thinking" maxlength="300"></textarea>
                        </div>
                        <input type="file" name="image" accept=".jpeg, .png, .jpg">
                        <br>
                        <button id="myBtn" type="submit" class="btn btn-primary" style="padding: 5px 25px; margin-top: 5px;">Post</button>
                    </form>
                    <hr>
                    <h2>Your Timeline</h2>
                    <c:forEach items="${posts}" var="post">
                        <div class="post mb-4" style="overflow-wrap: break-word; border: 1px solid #ddd; padding: 10px; border-radius: 10px;" data-post-id="${post.post_id}" data-liked="${post.likedByCurrentUser}">
                            <div class="post-header">
                                <c:if test="${sessionScope.user['user_id'] == user.user_id}">
                                    <!-- Delete form -->
                                    <div class="delete-button">
                                        <form action="deleteServlet" method="post">
                                            <input type="hidden" name="_method" value="delete">
                                            <input type="hidden" name="postId" value="${post.post_id}">
                                            <button type="submit" class="btn btn-danger delete-button">Delete</button>
                                        </form>
                                    </div>
                                </c:if>
                                    <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px; margin-top: 5px">
                                <small>${post.first_name} ${post.last_name} -- <fmt:formatDate value="${post.post_time}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                            </div>
                            <p style="font-size: 14px;">${post.body}</p>
                            <c:if test="${not empty post.image_path}">
                                <div>
                                    <img src="assets/post_image/${post.image_path}">
                                </div>
                            </c:if>
                            <div class="post-ratings-container">
                                <div class="post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''}">
                                    <span class="post-rating-button material-icons" style="cursor: pointer">thumb_up</span>
                                    <span class="post-rating-count">${post.like_count}</span>
                                </div>
                            </div>
                            <div class="post-comments">
                                <c:forEach var="comment" items="${post.comments}">
                                    <div class="comment mb-2" style="margin-left: 20px;">
                                        <div class="comment-header">
                                            <small><strong>>>${comment.first_name} ${comment.last_name}</strong></small>
                                        </div>
                                        <div class="comment-body">
                                            <p style="margin-bottom: 0;">${comment.comment_text}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- Comment form -->
                            <form action="/blahproject/commentServlet" method="post" class="mb-4 post-method">
                                <div class="mb-3">
                                    <textarea class="form-control" id="body" name="commentContent" rows="2" placeholder="Reply"></textarea>
                                </div>
                                <input type="hidden" name="post_id" value="${post.post_id}">
                                <button type="submit" class="btn btn-primary" style="padding: 5px 25px; margin-top: 5px">Comment</button>
                            </form>
                        </div>
                        <br>
                    </c:forEach>
                </main>
            </div>
    </body>
</html>
