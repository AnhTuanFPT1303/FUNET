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
        <link rel="stylesheet" type="text/css" href="assets/css/test.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
    </head>

    <body>
        <section class="cover-image-section">
            <header class="cover-hader-site">
                <img src="assets/profile_avt/${sessionScope.user['profile_pic']}">
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
                            <img src="assets/profile_avt/${sessionScope.user['profile_pic']}">
                        </a>
                        <span class="fas fa-camera"></span>
                    </div>
                </div>
                <div class="profile-name-info">
                    <h1>
                        <span class="pro-txt">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</span>
                        <span id="nik-name"></span>
                    </h1>
                    <p>
                        <span class="fir-count-txt">
                            <span id="friend_count">1000</span> Friends
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
                        <p id="bio-text">Coder lỏ</p>
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
                                    3641
                                </span>
                                Friends
                            </p>
                        </span>

                        <div class="see-all-images"><a href="#">See All Friends</a></div>

                        <!-- Write for each to output some friend here -->
                        <div class="see-all-images"><a href="#">See All Friends</a></div>

                        <div class="at9-images">
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
            </div>
        </section>
    </body>
</html>
