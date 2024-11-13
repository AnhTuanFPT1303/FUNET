<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
         <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
 <link href="assets/css/logonavbar.css" rel="stylesheet"> 
    </head>
    <body>
       <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%">FUNET</div>
            </a>
            <form class="" method="get" action="/FUNET/searchServlet" id="searchForm">
                <div class="search-bar" style="margin-top:1%; margin-left:1%">
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
                <a href="market">
                    <button class="center-button" id="market-btn">
                        <box-icon name='store-alt' type='solid'></box-icon>
                    </button>
                </a>
                <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                    <button class="center-button" id="friend-btn">
                        <box-icon name='group' type='solid'></box-icon>
                    </button>
                </a>
            </div>
            <div class="right-icons">
                <a href="/FUNET/chat" class="mess-icon" style='margin-left:5px'>
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
                    <img src="assets/profile_avt/${sessionScope.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                    <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                </button>
            </a>
        </div>
        <div class="menu-item">
            <box-icon name='cog' type='solid' style="margin-right:3%; margin-left:1%;">Settings</box-icon>Settings
        </div>
        <div class="menu-item" >
            <box-icon name='error-circle'style="margin-right:3%; margin-left:1%;"></box-icon>Report
        </div>
        

        <form method="post" action="/FUNET/logout" style="display: inline; width: 100%;">
            <div class="menu-item" style="display: flex; align-items: center; cursor: pointer; width: 100%;">
                <box-icon type='solid' name='log-out'style=" margin-left:1%;"></box-icon>
                <button type="submit" style="border: none; background: none; color: black; font-size: 16px; margin-left: 5px; cursor: pointer; flex: 1; text-align: left;">
                    Log Out
                </button>
            </div>
        </form>
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
                    <img src="assets/profile_avt/${sessionScope.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                    <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                </button>
            </a>
        </div>
        <div class="menu-item">
            <box-icon name='cog' type='solid' style="margin-right:3%; margin-left:1%;">Settings</box-icon>Settings
        </div>
        <div class="menu-item" >
            <box-icon name='error-circle'style="margin-right:3%; margin-left:1%;"></box-icon>Report
        </div>
        

        <form method="post" action="/FUNET/logout" style="display: inline; width: 100%;">
            <div class="menu-item" style="display: flex; align-items: center; cursor: pointer; width: 100%;">
                <box-icon type='solid' name='log-out'style=" margin-left:1%;"></box-icon>
                <button type="submit" style="border: none; background: none; color: black; font-size: 16px; margin-left: 5px; cursor: pointer; flex: 1; text-align: left;">
                    Log Out
                </button>
            </div>
        </form>
    </div>
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
                                    <script src="assets/js/logonavbar.js" defer></script>

            <script>
                function updateFileName(input) {
                    var fileName = input.files[0].name;
                    document.getElementById('file-name').textContent = fileName;
                }
            </script>
            <script src="assets/js/likeButton.js" defer></script>
    </body>
</html>
