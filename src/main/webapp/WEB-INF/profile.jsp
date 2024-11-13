<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/all.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/profile.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <link rel="stylesheet" type="text/css" href="assets/css/logonavbar.css">
    </head>

    <body>
        <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%; color: black;">FUNET</div>
            </a>
            <form class="" method="get" action="/searchServlet" id="searchForm">
                <div class="search-bar" style="margin-top:1%;">
                    <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input" style="padding-left:5%; margin-left: 10px">

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
                        <img src="data:image/png;base64,${sessionScopte.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
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


            <form method="post" action="/logout" style="display: inline; width: 100%;">
                <div class="menu-item" style="display: flex; align-items: center; cursor: pointer; width: 100%;">
                    <box-icon type='solid' name='log-out'style=" margin-left:1%;"></box-icon>
                    <button type="submit" style="border: none; background: none; color: black; font-size: 16px; margin-left: 5px; cursor: pointer; flex: 1; text-align: left;">
                        Log Out
                    </button>
                </div>
            </form>
        </div>

        <div class="popop-background"></div>
        <div class="thim-div">
            <div class="hadr-thim-bar">
                <span id="thim-button" class="fas fa-caret-right"></span>
                <p>Background</p>
                <div class="bg-color">
                    <div id="bg-c-1" class="bg-color-1"></div>
                    <div id="bg-c-2" class="bg-color-2"></div>
                    <div id="bg-c-3" class="bg-color-3"></div>
                    <div id="bg-c-4" class="bg-color-4"></div>
                    <div id="bg-c-5" class="bg-color-5"></div>
                    <div id="bg-c-6" class="bg-color-6"></div>
                </div>
                <br>
                <p>Text Color</p>
                <div class="bg-color">
                    <div id="txt-c-1" class="bg-color-1"></div>
                    <div id="txt-c-2" class="bg-color-2"></div>
                    <div id="txt-c-3" class="bg-color-3"></div>
                    <div id="txt-c-4" class="bg-color-4"></div>
                    <div id="txt-c-5" class="bg-color-5"></div>
                    <div id="txt-c-6" class="bg-color-6"></div>
                </div>
            </div>
        </div>
        <section class="cover-image-section">
            <header class="cover-hader-site">
                <img src="data:image/png;base64,${user.profile_pic}">
                <div class="cover-image-div">
                    <div class="cover-image-edite-btn">
                        <a href="setting" style="text-decoration: none">
                            <button>
                                <i class="fas fa-camera"></i>
                                Edit Cover Photo
                            </button>
                        </a>
                    </div>
                </div>
            </header>
        </section>
        <section class="profile-section">
            <div class="profile-section-in">
                <div class="profile-image-site">
                    <div class="profile-image-div">
                        <a href="setting" style="text-decoration: none">
                            <img src="data:image/png;base64,${user.profile_pic}">
                        </a>
                        <span class="fas fa-camera"></span>
                    </div>
                </div>
                <div class="profile-name-info">
                    <h1>
                        <span class="pro-txt">${user.first_name} ${user.last_name}</span>
                        <span id="nik-name"></span>
                    </h1>
                    <p>
                        <span class="fir-count-txt">
                            <span id="friend_count">${friendCount}</span> Friends
                        </span>
                    </p>
                </div>
            </div>
        </section>
        <section class="full-navbar">
            <nav class="navbar-site">
                <ul compact="txt-color-c">
                    <a href="#">
                        <li class=" txt-cc activ-navbar">Posts</li>
                    </a>
                    <a href="#">
                        <li class=" txt-cc">About</li>
                    </a>
                    <a href="#">
                        <li class=" txt-cc">Friends</li>
                    </a>
                    <a href="#" id="photo-nav">
                        <li class=" txt-cc">Photo</li>
                    </a>
                    <a href="#" id="video-nav">
                        <li class=" txt-cc">Video</li>
                    </a>
                </ul>
                <div class="nav-btn">
                    <i class="fas fa-ellipsis-h"></i>
                </div>
            </nav>
        </section>
        <section class="post-section">
            <div class="post-section-in">
                <section class="info-section">
                    <div class="about-info">
                        <div class="user-introduction">
                            <h2>Introduction</h2>
                            <p id="user-intro-text">${user.user_introduce}</p>
                            <c:if test="${sessionScope.user['user_id'] == user.user_id}">
                                <button id="edit-intro-btn" class="btn btn-primary">Edit Introduction</button>
                            </c:if>
                            <form id="edit-intro-form" action="userIntroduceServlet" method="post" style="display: none;">
                                <input type="text" name="userIntro" class="form-control" placeholder="Introduce yourself..." value="${user.user_introduce}">
                                <button type="submit" class="btn btn-success">Save</button>
                                <button type="button" id="cancel-edit-btn" class="btn btn-secondary">Cancel</button>
                            </form>
                        </div>
                    </div>

                    <div class="box-design images-site">

                        <span>Photos</span>

                        <div class="see-all-images"><a href="#">See All Photos</a></div>

                        <div class="at9-images">
                            <c:forEach var="post" items="${posts}">

                                <c:if test="${post.type == 'image'}">
                                    <img src="${post.image_path}" style="max-width : 100%">
                                </c:if>

                            </c:forEach>
                        </div>
                    </div>

                    <div class="box-design friends-site">

                        <span>Friends <br>
                            <p>
                                <span>
                                    ${friendCount}
                                </span>
                                Friends
                            </p>
                        </span>
                        <div class="see-all-images"><a href="#">See All Friends</a></div>
                        <div class="at9-images">
                            <!-- Write for each to output some friend here -->
                            <c:forEach var="friend" items="${friends}">
                                <div class="images-div">
                                    <img src="data:image/png;base64,${friend.profile_pic}" alt="${friend.first_name} ${friend.last_name}">
                                    <p><a href="profile?userId=${friend.user_id}" class="user-link friend" data-user-id="${friend.user_id}">${friend.first_name} ${friend.last_name}</a></p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- Output end here -->
                </section>
                <section class="post-info">
                    <div class="box-design">
                        <c:if test="${sessionScope.user['user_id'] == user.user_id}">
                        <form action="/home" method="post" enctype="multipart/form-data" onsubmit="document.getElementById('myBtn').disabled = true;" id="commentForm">
                            <div class="post-upload-T">
                                <div class="profil-ing-div">
                                    <a href="#">
                                        <img src="data:image/png;base64,${user.profile_pic}">
                                    </a>
                                </div>
                                <div class="">

                                    <input type="text" class="form-control" id="body" name="postContent" placeholder="What ya thinking" maxlength="300" oninput="adjustFontSize()">
                                    <input type="hidden" name="sourceUrl" value="profile">


                                </div>
                            </div>
                            <div class="photo-upload" style="display: flex; justify-content: center; gap: 100px; margin: 0 auto;">
                                <div class="post-upl">
                                    <label for="photo-upload-image" style="margin-top:10px">
                                        <i class="fas fa-images"></i> Photo
                                    </label>
                                    <input id="photo-upload-image" type="file" name="image" accept=".jpeg, .png, .jpg" style="display: none;" onchange="updateFileName(this)">
                                </div>
                                <div class="post-upl">
                                    <label for="photo-upload-video">
                                        <i class="fas fa-video" style="margin-top:10px"></i> Video
                                    </label>
                                    <input id="photo-upload-video" type="file" name="video" accept=".mp4, .webm, .mpeg" style="display: none;" onchange="updateFileName(this)">
                                </div>
                            </div>
                            </c:if>

                        </form>
                    </div>
                    <!--                                POST LOAD HERE                         -->
                    <c:forEach items="${posts}" var="post">
                        <div class="box-design post" data-post-id="${post.post_id}" data-liked="${post.likedByCurrentUser}">
                            <div class="post-information">



                                <div class="profil-ing-div post-profile-img">
                                    <a href="#" id="profile-link">
                                        <img src="data:image/png;base64,${user.profile_pic}">
                                    </a>
                                </div>
                                <div class="user-info" style="box-shadow: 0 4px 8px rgba(0, 0, 0, 0)">

                                    <h2><a href=""#>${post.first_name} ${post.last_name}</a></h2>

                                    <div class="privacy-info"> 
                                        <p><a href="#"><fmt:formatDate value="${post.post_time}" pattern="dd-MM" /></a></p>
                                            <c:if test="${sessionScope.user['user_id'] == user.user_id}">
                                            <span class="public-btn-i fa-solid fa-gear" style="margin-left: 10px"></span>
                                        </c:if>
                                    </div>

                                    <c:if test="${post.isShared}">

                                        <div class="original-post-info d-flex align-items-center">
                                            <img src="data:image/jpg;base64,${post.originalPosterAvatar}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px;object-fit: cover;">
                                            <small>${post.originalPosterName}</small>
                                        </div>
                                    </c:if>

                                    <form action="updatePostServlet" method="post" class="update-form" enctype="multipart/form-data" style="display: none;">
                                        <input type="hidden" name="postId" value="${post.post_id}">
                                        <textarea name="newBody" class="form-control">${post.body}</textarea>
                                        <button type="submit" class="btn btn-primary">Update</button>
                                        <div class="item">
                                            <label for="photo-upload">
                                                <i class="fas fa-cloud-upload-alt"></i> Photo
                                            </label>
                                            <input id="photo-upload" type="file" name="newImage" accept=".jpeg, .png, .jpg" style="display: none;" onchange="updateFileName(this)">
                                            <label for="photo-upload">
                                                <i class="fas fa-cloud-upload-alt"></i> Video
                                            </label>
                                            <input id="photo-upload" type="file" name="newImage" accept=".mp4, .webm" style="display: none;" onchange="updateFileName(this)">
                                        </div>
                                        <button type="button" class="btn btn-secondary cancel-update">Cancel</button>
                                    </form>

                                    <span>
                                        <div class="Select-audience">
                                            <div class="header-popap">
                                                <p class="h-pop">Select audience</p>
                                                <span class="popup-close-btn fas fa-times"></span>
                                            </div>

                                            <div class="content-popaap">
                                                <form class="updatePrivacyForm" action="updatePrivateServlet" method="post">
                                                    <input type="hidden" name="postId" value="${post.post_id}">
                                                    <input type="hidden" name="privacyMode" class="privacyMode">
                                                    <ul>
                                                        <li class="public-btn" onclick="updatePrivacy('public', this)">
                                                            <div class="icon-div">
                                                                <i class="fas fa-globe-europe"></i>
                                                            </div>
                                                            <div class="text-aria">
                                                                <h2>Public</h2>
                                                                <p>Anyone on or off FUNET</p>
                                                                <i class="public-li-icon far fa-circle"></i>
                                                            </div>
                                                        </li>
                                                        <li class="activ-li-div friends-btn" onclick="updatePrivacy('friend', this)">
                                                            <div class="icon-div">
                                                                <i class="fas fa-user-friends frind-icon"></i>
                                                            </div>
                                                            <div class="text-aria">
                                                                <h2>Friends</h2>
                                                                <p>Your friends on FUNET</p>
                                                                <i class="friends-li-icon far fa-dot-circle activ-li-icon"></i>
                                                            </div>
                                                        </li>
                                                        <li class="lock-btn" onclick="updatePrivacy('private', this)">
                                                            <div class="icon-div">
                                                                <i class="fas fa-lock"></i>
                                                            </div>
                                                            <div class="text-aria">
                                                                <h2 class="onlu-me">Only Me</h2>
                                                                <i class="lock-li-icon far fa-circle"></i>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </form>
                                            </div>
                                        </div>
                                    </span>
                                </div>
                                <span class="thre-dto-btn fas fa-ellipsis-h"></span>
                                <c:if test="${sessionScope.user['user_id'] == user.user_id}">
                                    <div class="dropdown-menu" style="display: none; position: absolute;right: 0;width: 0;height: 100px;">
                                        <form action="updatePostServlet" method="post" class="update-form" enctype="multipart/form-data" style="display: none;">
                                            <input type="hidden" name="postId" value="${post.post_id}">
                                            <textarea name="newBody" class="form-control">${post.body}</textarea>
                                            <button type="submit" class="btn btn-primary">Update</button>
                                            <div class="item">
                                                <label for="photo-upload">
                                                    <i class="fas fa-cloud-upload-alt"></i> Photo/Video
                                                </label>
                                                <input id="photo-upload" type="file" name="newImage" accept=".jpeg, .png, .jpg" style="display: none;" onchange="updateFileName(this)">
                                            </div>
                                            <button type="button" class="btn btn-secondary cancel-update">Cancel</button>
                                        </form>
                                        <!-- Update button -->
                                        <c:if test="${!post.isShared}">
                                            <button class="btn btn-primary show-update-form update-post-btn" data-post-id="${post.post_id}" onclick="UpdatePostClick('${post.post_id}', '${post.body}')">Update</button>
                                        </c:if>
                                        <form action="deleteServlet" method="post" class="delete-form">
                                            <input type="hidden" name="_method" value="delete">
                                            <input type="hidden" name="postId" value="${post.post_id}">
                                            <button type="submit" class="btn btn-link">Delete</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                            <p class="post-text-show">${post.body}</p>
                            <c:if test="${not empty post.image_path}">
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
                            </c:if>
                            <div class="post-reaction">
                                <div class="reaction">
                                    <div class="reaction-count post-ratings-container">
                                        <div class="icon-show mid like-icon-bg">
                                            <i class="fas fa-thumbs-up"></i>
                                        </div>
                                        <div class="post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''}" data-liked="${post.likedByCurrentUser}">
                                            <!--Like count show here-->
                                            <p class="like-count"><span>${post.like_count}</span></p>

                                        </div>
                                    </div>
                                    <div>
                                        <p>
                                            <!--Comment count show here-->
                                            <%--   <a href="#">1 Comments</a> --%>
                                            <!--Share count show here-->
                                            <a href="#" class="share-link">${post.shareCount} Shares</a>
                                        </p>
                                    </div>
                                </div>

                            </div>

                            <div class="activate d-flex justify-content-around mt-2">
                                <div class="lcs-btn lcs-btn_i post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''} d-flex align-items-center" style="background: white">
                                    <span class="material-icons" style="color: ${post.likedByCurrentUser ? '#1877f2' : '#65676b'};">
                                        thumb_up
                                    </span>
                                    <span class="post-icon-text_i ms-1" style="margin-top: 5px; font-weight: bold">${post.likedByCurrentUser ? 'Liked' : 'Like'}</span>
                                </div>
                                <div class="lcs-btn d-flex align-items-center" style="font-weight: bold">
                                    <i class="far fa-comment-alt"></i>
                                    <span class="ms-1">Comment</span>
                                </div>
                                <div class="lcs-btn d-flex align-items-center" style="background: white">
                                    <form action="sharePostServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="postId" value="${post.post_id}">
                                        <input type="hidden" name="sourceUrl" value="profile">
                                        <button type="submit" class="btn btn-link p-0 d-flex align-items-center" style="background:white; text-decoration: none">
                                            <i class="fas fa-share"></i>
                                            <span class="ms-1">Share</span>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="comment-site">
                                <div class="profil-ing-div">
                                    <a href="#">
                                        <img src="data:image/png;base64,${sessionScope.user['profile_pic']}">
                                    </a>
                                </div>
                                <div class="comment-input">
                                    <form action="/commentServlet" method="post" class="mb-4 post-method" id="commentForm" enctype="multipart/form-data">
                                        <div class="mb-3">
                                            <input type="text" class="form-control" id="body" name="commentContent" maxlength="300" rows="2" placeholder="Write a comment…">
                                        </div>
                                        <input type="hidden" name="sourceUrl" value="profile">
                                        <input type="hidden" name="post_id" value="${post.post_id}">

                                        <!-- 
                                    <div class="comment-icon-div">
                                        <div>
                                            <i class="far fa-grin-alt"></i>
                                        </div>
                                        <div>
                                             <label for="photo-upload">
                                            <i class="fas fa-camera"></i>
                                            <input id="photo-upload" type="file" name="commentImage" accept=".jpeg, .png, .jpg">
                                             </label>
                                        </div>
                                    </div>
                                        -->
                                    </form>
                                </div>
                            </div>
                            <c:forEach var="comment" items="${post.comments}">
                                <div class="comment mb-2" style="margin-left: 20px;">
                                    <div class="comment-header">
                                        <img src="data:image/png;base64,${comment.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                        <small><strong>${comment.first_name} ${comment.last_name}</strong></small>
                                    </div>
                                    <div class="comment-body" style="display: flex; justify-content: space-between; align-items: center;">
                                        <p style="margin-bottom: 0;" class="comment-text">${comment.comment_text}</p>
                                        <div class="comment-options">
                                            <c:if test="${sessionScope.user['user_id'] == comment.user_id}">
                                                <button class="three-dot-btn" data-comment-id="${comment.comment_id}">...</button>
                                            </c:if>
                                            <div class="comment-actions" style="display: none;">
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
                                        <textarea name="newCommentText" class="form-control">${comment.comment_text}</textarea>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                        <button type="button" class="btn btn-secondary cancel-edit-comment">Cancel</button>
                                    </form>
                                </div>
                            </c:forEach>

                        </div>
                    </c:forEach>
                </section>
            </div>
            <!-- Thêm modal để hiển thị form cập nhật bài đăng -->
            <div class="modal fade" id="updatePostModal" tabindex="-1" aria-labelledby="updatePostModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updatePostModalLabel">Update Post</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="updatePostForm" method="post" enctype="multipart/form-data">
                            <div class="modal-body">
                                <input type="hidden" name="postId" id="postIdInput">
                                <div class="mb-3">
                                    <label for="newBody" class="form-label" id="formupdateidcontent">New Content</label>
                                    <textarea class="form-control" id="newBody" name="newBody" rows="2"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="newImage" class="form-label" id="formupdateidimage photo-upload">New Image</label>
                                    <input type="file" class="form-control" id="newImage" name="newImage" accept=".jpeg, .png, .jpg, .mp4" onchange="updateFileName(this)">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="assets/js/profile.js"></script>
        <script src="assets/js/bootstrap.min.js"></script> 
        <script src="assets/js/likeButton.js" defer></script>
        <script src="assets/js/comment.js" defer></script>

        <script>


                                        function UpdatePostClick(id, body) {
                                            document.getElementById('postIdInput').value = id;
                                            document.getElementById('newBody').value = body;

                                            $('#updatePostModal').modal('show');
                                        }
                                        $('#updatePostForm').on('submit', function (event) {
                                            event.preventDefault();

                                            var formData = new FormData(this);

                                            $.ajax({
                                                url: 'updatePostServlet',
                                                type: 'POST',
                                                data: formData,
                                                contentType: false,
                                                processData: false,
                                                success: function (response) {
                                                    if (response.trim() === 'success') {

                                                        $('#updatePostModal').modal('hide');
                                                        location.reload();
                                                    } else {

                                                        alert('Error updating post server: ' + response);
                                                    }
                                                },
                                                error: function (xhr, status, error) {

                                                    alert('Error updating post ajax: ' + error);
                                                }
                                            });
                                        });
        </script>


        <script>
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

        </script>

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
        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const posts = document.querySelectorAll('.post');

                posts.forEach(post => {
                    const showUpdateFormBtn = post.querySelector('.show-update-form');
                    const updateForm = post.querySelector('.update-form');
                    const cancelUpdateBtn = post.querySelector('.cancel-update');

                    if (showUpdateFormBtn) {
                        showUpdateFormBtn.addEventListener('click', () => {
                            // updateForm.style.display = 'block';
                            showUpdateFormBtn.style.display = 'none';
                        });
                    }

                    if (cancelUpdateBtn) {
                        cancelUpdateBtn.addEventListener('click', () => {
                            // updateForm.style.display = 'none';
                            showUpdateFormBtn.style.display = 'block';
                        });
                    }
                });
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const editBtn = document.getElementById('edit-intro-btn');
                const editForm = document.getElementById('edit-intro-form');
                const cancelBtn = document.getElementById('cancel-edit-btn');
                const introText = document.getElementById('user-intro-text');

                editBtn.addEventListener('click', function () {
                    editForm.style.display = 'block';
                    introText.style.display = 'none';
                    editBtn.style.display = 'none';
                });

                cancelBtn.addEventListener('click', function () {
                    editForm.style.display = 'none';
                    introText.style.display = 'block';
                    editBtn.style.display = 'block';
                });
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const posts = document.querySelectorAll('.post');
                posts.forEach(post => {
                    const threeDotBtn = post.querySelector('.thre-dto-btn');
                    const dropdownMenu = post.querySelector('.dropdown-menu');
                    const showUpdateFormBtn = post.querySelector('.show-update-form');
                    const updateForm = post.querySelector('.update-form');
                    const cancelUpdateBtn = post.querySelector('.cancel-update');
                    threeDotBtn.addEventListener('click', () => {
                        dropdownMenu.style.display = dropdownMenu.style.display === 'none' ? 'block' : 'none';
                    });
                    if (showUpdateFormBtn) {
                        showUpdateFormBtn.addEventListener('click', () => {
                            //   updateForm.style.display = 'block';
                            showUpdateFormBtn.style.display = 'none';
                            dropdownMenu.style.display = 'none';
                        });
                    }

                    if (cancelUpdateBtn) {
                        cancelUpdateBtn.addEventListener('click', () => {
                            // updateForm.style.display = 'none';
                            showUpdateFormBtn.style.display = 'block';
                        });
                    }
                });
                document.addEventListener('click', function (event) {
                    if (!event.target.closest('.post')) {
                        document.querySelectorAll('.dropdown-menu').forEach(menu => {
                            menu.style.display = 'none';
                        });
                    }
                });
            });
        </script> 
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
