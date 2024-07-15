<%-- 
    Document   : home
    Created on : Jun 10, 2024, 3:20:34 PM
    Author     : bim26
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/home.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    </head>
    <body>
        <header id="header">
            <nav class="navbar custom-navbar">
                <div class="container-fluid d-flex align-items-center">
                    <a class="navbar-brand text-primary" href="/blahproject/home" style="font-weight: bold ">BLAH</a>
                    <form class="d-flex ms-2 flex-grow-1" method="get" action="/blahproject/searchServlet">
                        <input class="form-control" name="search-name" type="search" placeholder="Finding in BLAH" aria-label="Search">
                        <input type="submit" value="Submit">
                    </form>
                    <form method="post" action="/blahproject/logout">
                        <button type="submit" class="navbar-brand text-primary" style="font-weight: bold; margin-right: 1rem;border: 0;">Log out</a>
                    </form>
                </div>
            </nav>
        </header>
        <div class="container-fluid">
            <div class="row all-post">
                <nav class="col-2 py-3 bg-light">   
                    <div class="profile-section mb-3 d-flex align-items-center">
                        <a href="userpageServlet?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                            <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                            <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                        </a>
                    </div>
                    <div class="chat-box mb-3">
                        <h5>Chat box</h5>   
                    </div>
                </nav>

                <main class="main-class col-8">
                    <h1 class="mt-3 text-primary home-logo">HOME</h1>
                      <c:if test="${not empty param.notification}">
                        <div class="alert alert-danger">${param.notification}</div>
                    </c:if> 
                    <form action="/blahproject/home" method="post" class="mb-4 post-method" enctype="multipart/form-data" onsubmit="document.getElementById('myBtn').disabled = true;">
                        <div class="mb-3">
                            <textarea class="form-control" id="body" name="postContent" rows="2" placeholder="What ya thinking" maxlength="300"></textarea>
                        </div>
                        <input type="file" name="image" accept=".jpeg, .png, .jpg">
                        <br>
                        <button id="myBtn" type="submit" class="btn btn-primary" style="padding: 5px 25px; margin-top: 5px;">Post</button>
                    </form>

                    <br>

                    <c:forEach var="post" items="${posts}">
                        <div class="post mb-4" style="overflow-wrap: break-word" data-post-id="${post.post_id}" data-liked="${post.likedByCurrentUser}">
                            <div class="post-header">
                                <img src="assets/profile_avt/${post.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 40px; height: 40px;">
                                <small>${post.first_name} ${post.last_name} -- <fmt:formatDate value="${post.post_time}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                            </div>
                            <p>${post.body}</p> 
                            <c:if test="${not empty post.image_path}">
                                <div>
                                    <img src="assets/post_image/${post.image_path}" style="max-width : 60%">
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
                                            <img src="assets/profile_avt/${comment.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px;">
                                            <small><strong>${comment.first_name} ${comment.last_name}</strong></small>
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


                            <%----%>
                        </div>
                        <br>
                    </c:forEach>
                </main>
                <aside class="col-2 py-3 bg-light friend-list" style="z-index: -5">
                    <h2>List Friends</h2>
                    <ul class="list-group">
                        <li class="list-group-item">Friend 1</li>
                        <li class="list-group-item">Friend 2</li>
                        <li class="list-group-item">Friend 3</li>
                    </ul>
                </aside>
            </div>
        </div>
        <script src="assets/js/likeButton.js" defer></script>
        <script src="assets/js/bootstrap.min.js"></script>   
    </body>
</html>
