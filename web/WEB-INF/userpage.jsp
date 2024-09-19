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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <header id="header">
            <nav class="navbar custom-navbar">
                <div class="container-fluid d-flex align-items-center">
                    <a class="navbar-brand text-primary" href="/FUNET/home" style="font-weight: bold">FUNET</a>
                    <form class="d-flex ms-2 flex-grow-1" method="get" action="/FUNET/searchServlet">
                        <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search">
                        <button type="submit" class="search-button">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    <div class="nav-icons d-flex align-items-center">
                        <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                            <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor" class="x19dipnz x1lliihq x1tzjh5l x1k90msu x2h7rmj x1qfuztq" style="--color:var(--secondary-icon)"><path d="M.5 12c0 6.351 5.149 11.5 11.5 11.5S23.5 18.351 23.5 12 18.351.5 12 .5.5 5.649.5 12zm2 0c0-.682.072-1.348.209-1.99a2 2 0 0 1 0 3.98A9.539 9.539 0 0 1 2.5 12zm.84-3.912A9.502 9.502 0 0 1 12 2.5a9.502 9.502 0 0 1 8.66 5.588 4.001 4.001 0 0 0 0 7.824 9.514 9.514 0 0 1-1.755 2.613A5.002 5.002 0 0 0 14 14.5h-4a5.002 5.002 0 0 0-4.905 4.025 9.515 9.515 0 0 1-1.755-2.613 4.001 4.001 0 0 0 0-7.824zM12 5a4 4 0 1 1 0 8 4 4 0 0 1 0-8zm-2 4a2 2 0 1 0 4 0 2 2 0 0 0-4 0zm11.291 1.01a9.538 9.538 0 0 1 0 3.98 2 2 0 0 1 0-3.98zM16.99 20.087A9.455 9.455 0 0 1 12 21.5c-1.83 0-3.54-.517-4.99-1.414a1.004 1.004 0 0 1-.01-.148V19.5a3 3 0 0 1 3-3h4a3 3 0 0 1 3 3v.438a1 1 0 0 1-.01.148z"></path></svg>
                        </a>
                        <a href="/FUNET/chat" class="mess-icon me-3">
                            <i class="fas fa-comments"></i>
                        </a> 
                    </div>
                    <form method="post" action="/FUNET/logout">
                        <button type="submit" class="navbar-brand text-primary log-out" style="font-weight: bold">Log out</button>
                    </form>
                </div>
            </nav>
        </header>
        <div class="container-fluid">
            <div class="row all-post">
                <nav class="col-2 py-3 bg-light sticky-sidebar">
                    <div class="profile-section mb-3 text-center">
                        <a href="userpageServlet?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                            <img src="assets/profile_avt/${sessionScope.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                            <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                        </a>

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
                    <form action="/FUNET/userpageServlet" method="post" class="mb-4 post-method" enctype="multipart/form-data" onsubmit="document.getElementById('myBtn').disabled = true;">
                        <div class="mb-3">
                            <textarea class="form-control" id="body" name="postContent" rows="2" placeholder="What ya thinking" maxlength="300"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="file-upload" class="custom-file-upload">
                                <i class="fas fa-cloud-upload-alt"></i> Choose Image
                            </label>
                            <input id="file-upload" type="file" name="image" accept=".jpeg, .png, .jpg" style="display:none;" onchange="updateFileName(this)">
                            <span id="file-name"></span>
                        </div>
                        <button id="myBtn" type="submit" class="btn btn-primary" style="padding: 5px 25px;">Post</button>
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
                                <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px; margin-top: 5px; object-fit: cover; ">
                                <small>${post.first_name} ${post.last_name} -- <fmt:formatDate value="${post.post_time}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                            </div>
                            <p style="font-size: 14px;">${post.body}</p>
                            <c:if test="${not empty post.image_path}">
                                <div>
                                    <img src="${post.image_path}" style="max-width : 60%">
                                </div>
                            </c:if>
                            <div class="post-ratings-container">
                                <div class="post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''}">
                                    <button type="button" style="background: none; border: none; cursor: pointer; padding: 0;">
                                        <span class="material-icons" style="color: ${post.likedByCurrentUser ? '#1877f2' : '#65676b'};">
                                            thumb_up
                                        </span>
                                    </button>
                                    <span class="post-rating-count">${post.like_count}</span>
                                </div>
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
                            <!-- Comment form -->
                            <form action="/FUNET/commentServlet" method="post" class="mb-4 post-method">
                                <div class="mb-3">
                                    <textarea class="form-control" id="body" name="commentContent" rows="2" placeholder="Reply" maxlength="300"></textarea>
                                </div>
                                <input type="hidden" name="post_id" value="${post.post_id}">
                                <button type="submit" class="btn btn-primary" style="padding: 5px 25px; margin-top: 5px">Comment</button>
                            </form>
                        </div>
                        <br>
                    </c:forEach>
                </main>
                <aside class="col-2 py-3 bg-light friend-list sticky-sidebar">
                    <h2 style="color: #0d6efd">List Friends</h2>
                    <hr>
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
            <script>
                function updateFileName(input) {
                    var fileName = input.files[0].name;
                    document.getElementById('file-name').textContent = fileName;
                }
            </script>
            <script src="assets/js/likeButton.js" defer></script>
    </body>
</html>
