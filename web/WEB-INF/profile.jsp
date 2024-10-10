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
    </head>

    <body>
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
                <img src="assets/profile_avt/${user.profile_pic}">
                <div class="cover-image-div">
                    <div class="cover-image-edite-btn">
                        <button>
                            <i class="fas fa-camera"></i>
                            Edit Cover Photo
                        </button>
                    </div>
                </div>
            </header>
        </section>
        <section class="profile-section">
            <div class="profile-section-in">
                <div class="profile-image-site">
                    <div class="profile-image-div">
                        <a href="#">
                            <img src="assets/profile_avt/${user.profile_pic}">
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
                <div class="profile-button-site">
                    <div class="btn-site-pro">
                        <span class="edit-profile-btn">
                            <i class="fas fa-pen"></i>
                            Edit Profile
                        </span>
                    </div>
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
                        <h4>Intro</h4>
                        <p>Xin chào</p>
                        <!--
                                <div class="bio-btn-click">
                                        <input class="input-box" type="text" value="MD Mehedi Hasan">
                                        <p class="length-count-txt">
                                                <span id="length-count">101</span> characters remaining
                                        </p>
                                        <div class="putlic-c-o-btn">
                                                <div>
                                                        <p><span class="fas fa-globe-europe"></span> Public</p>
                                                </div>
                                                <div class="button-site-js">
                                                        <button id="cencel-btn">Cencel</button>
                                                        <button id="save-btn">Save</button>
                                                </div>
                                        </div>
                                </div>
                                <button id="bio-edit-btn" class="edit-bio btn">Edit Bio</button>
                        -->
                        <!--	
                                <ul>
                                        <li><i class="fas fa-briefcase"></i> Works at
                                                <a href="#">Sad Mia</a>
                                        </li>

                                        <li><i class="fas fa-graduation-cap"></i> Went to
                                                <a href="#">kamarkhali high school</a>
                                        </li>

                                        <li><i class="fas fa-home"></i> Lives in
                                                <a href="#">Dhaka, Bangladesh</a>
                                        </li>

                                        <li><i class="fas fa-map-marker-alt"></i> From
                                                <a href="#">Faridpur, Dhaka, Bangladesh</a>
                                        </li>
                                        <li><i class="fas fa-heart"></i> Single</li>
                                        <li><i class="fas fa-globe"></i> <a href="#">
                                                        sadmia.com
                                                </a></li>
                                </ul>
                        -->
                        <!--	
                                <button class="edit-bio btn">Edit Details</button>

                                <div class="Hobbies-show">
                                        <span><i class="fas fa-laptop-code"></i> Learning to Code</span>

                                        <span><i class="fas fa-laptop-code"></i>Code</span>

                                        <span><i class="fas fa-book"></i>Learning</span>

                                        <span><i class="fas fa-camera-retro"></i>Photography</span>
                                </div>

                                <button class="edit-bio btn">Edit Hobbies</button>
                        -->

                        <button class="edit-bio btn">Edit Featured</button>
                    </div>

                    <div class="box-design images-site">

                        <span>Photos</span>

                        <div class="see-all-images"><a href="#">See All Photos</a></div>

                        <div class="at9-images">
                            <c:forEach var="post" items="${posts}">
                                <c:if test="${not empty post.image_path}">
                                    <div class="images-div">
                                        <img src="assets/post_image/${post.image_path}" alt="User posted image">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="box-design friends-site">

                        <span>Friends <br>
                            <p>
                                <span>
                                    <!-- friend count here -->
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
                                    <img src="assets/profile_avt/${friend.profile_pic}" alt="${friend.first_name} ${friend.last_name}">
                                    <p><a href="#" class="user-link friend" data-user-id="${friend.user_id}">${friend.first_name} ${friend.last_name}</a></p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- Output end here -->
                </section>
                <section class="post-info">
                    <div class="box-design">
                        <div class="post-upload-T">
                            <div class="profil-ing-div">
                                <a href="#">
                                    <img src="assets/profile_avt/${user.profile_pic}">
                                </a>
                            </div>
                            <div class="text-post">
                                <span>Share your mind</span>
                            </div>
                        </div>
                        <div class="photo-upload">
                            <div class="post-upl">
                                <p><i class="fas fa-images"></i> Photo/Video</p>
                            </div>
                            <div class="post-upl">
                                <p><i class="fas fa-flag"></i> Life Event</p>
                            </div>
                        </div>
                    </div>
                    <!--                                POST LOAD HERE                         -->
                    <c:forEach items="${posts}" var="post">
                        <div class="box-design post" data-post-id="${post.post_id}" data-liked="${post.likedByCurrentUser}">
                            <div class="post-information">
                                <%--
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
                                --%>
                                <div class="profil-ing-div post-profile-img">
                                    <a href="#" id="profile-link">
                                        <img src="assets/profile_avt/${user.profile_pic}">
                                    </a>
                                </div>
                                <div class="user-info">

                                    <h2><a href=""#>${post.first_name} ${post.last_name}</a></h2>
                                    <div class="privacy-info"> 
                                        <p><a href="#"><fmt:formatDate value="${post.post_time}" pattern="dd-MM" /></a></p>
                                        <i id="public-btn-i" class="fas fa-user-friends"></i>
                                    </div>

                                    <span>
                                        <div class="Select-audience">
                                            <div class="header-popap">
                                                <p class="h-pop">Select audience</p>
                                                <span id="popup-close-btn" class="fas fa-times"></span>
                                            </div>

                                            <div class="content-popaap">
                                                <ul>
                                                    <li id="public-btn">
                                                        <div class="icon-div">
                                                            <i class="fas fa-globe-europe"></i>
                                                        </div>
                                                        <div class="text-aria">
                                                            <h2>Public</h2>
                                                            <p>Anyone on or off Facebook</p>
                                                            <i id="public-li-icon" class="far fa-circle"></i>
                                                        </div>
                                                    </li>

                                                    <li class="activ-li-div" id="friends-btn">
                                                        <div class="icon-div">
                                                            <i class="fas fa-user-friends frind-icon"></i>
                                                        </div>
                                                        <div class="text-aria">
                                                            <h2>Friends</h2>
                                                            <p>Your friends on Facebook</p>
                                                            <i id="friends-li-icon"
                                                               class="far fa-dot-circle activ-li-icon"></i>
                                                        </div>
                                                    </li>

                                                    <li id="lock-btn">
                                                        <div class="icon-div">
                                                            <i class="fas fa-lock"></i>
                                                        </div>
                                                        <div class="text-aria">
                                                            <h2 class="onlu-me">Only Me</h2>
                                                            <i id="lock-li-icon" class="far fa-circle"></i>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </span>
                                </div>
                                <span class="thre-dto-btn fas fa-ellipsis-h"></span>
                            </div>
                            <p class="post-text-show">${post.body}</p>
                            <c:if test="${not empty post.image_path}">
                                <div class=div-post-images>
                                    <img class="post-images" src="assets/post_image/${post.image_path}">
                                </div>
                            </c:if>
                            <div class="post-reaction">
                                <div class="reaction">
                                    <div class="reaction-count">
                                        <div class="icon-show mid like-icon-bg">
                                            <i class="fas fa-thumbs-up"></i>
                                        </div>
                                        <div>
                                            <!--Like count show here-->
                                            <p class="like-count"><span>${post.like_count}</span></p>

                                        </div>
                                    </div>
                                    <div>
                                        <p>
                                            <!--Comment count show here-->
                                            <a href="#">1 Comments</a>
                                            <!--Share count show here-->
                                            <a href="#">1 Share</a>
                                        </p>
                                    </div>
                                </div>

                            </div>

                            <div class="activate">
                                <div class="lcs-btn lcs-btn_i post-rating ${post.likedByCurrentUser ? 'post-rating-selected' : ''}">
                                    <p>
                                        <span class="material-icons" style="color: ${post.likedByCurrentUser ? '#1877f2' : '#65676b'};">
                                            thumb_up
                                        </span>
                                        <span class="post-icon-text_i">${post.likedByCurrentUser ? 'Liked' : 'Like'}</span>
                                    </p>
                                </div>
                                <div class="lcs-btn">
                                    <p><i class="far fa-comment-alt"></i> Comment</p>
                                </div>
                                <div class="lcs-btn">
                                    <p><i class="fas fa-share"></i> Share</p>
                                </div>
                            </div>
                            <div class="comment-site">
                                <div class="profil-ing-div">
                                    <a href="#">
                                        <img src="assets/profile_avt/${sessionScope.user['profile_pic']}">
                                    </a>
                                </div>
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment…">
                                    <div class="comment-icon-div">
                                        <div>
                                            <i class="far fa-grin-alt"></i>
                                        </div>
                                        <div>
                                            <i class="fas fa-camera"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </section>
            </div>
        </section>
        <script src="assets/js/profile.js"></script>
        <script src="assets/js/bootstrap.min.js"></script> 
        <script src="assets/js/likeButton.js" defer></script>
    </body>
</html>
