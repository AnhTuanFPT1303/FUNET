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
       
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>


        <style>
            
/*
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/CascadeStyleSheet.css to edit this template
*/

/* 
    Created on : Jun 19, 2024, 1:35:13 PM
    Author     : bim26
*/
body {
                font-family: Arial, sans-serif;
                margin: 0;
                background-color: whitesmoke;
            }
            .navbar {
                display: flex;
                align-items: center;
                justify-content: space-around;
                position: relative;
                background-color: #ffffff;
                padding: 10px 20px;
                height: 60px;
                width: 100%;
                top: 0;
                z-index: 1000;
                box-sizing: border-box;
            }

            .center-buttons {
                display: flex;
                gap: 10px;
                justify-content: center;
                align-items: center;
                flex-grow: 1;

            }

            .center-button {
                flex: 1;
                max-width: 80px;
                height: 48px;
                background: none;
                border: none;
                color: black;
                cursor: pointer;
                border-radius: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background-color 0.3s ease;
                margin: 0;
            }




            .logo {
                margin-right: 45px;
                font-size: 24px;
                font-weight: bold;
            }
            .search-bar {
                margin-bottom: 5px;
                margin-bottom: 10px;
            }
            .search-bar input {
                padding: 8px;
                border: none;
                border-radius: 15px;
                height: 30px;
                width: 400px;
                transition: width 0.3s ease;
                outline: 1px solid rgb(133, 130, 130);
            }
            .center-button:hover {
                background-color: #CFC6C6;
            }

            .right-icons {
                display: flex;
                gap: 10px;
                align-items: center;
                width: 500px;
                padding-left:330px;
            }

            .icon {
                font-size: 20px;
                cursor: pointer;
                color: black;
            }
            .icon-circle {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 50px;
                height: 50px;
                background-color: rgb(211, 211, 211);
                border-radius: 50%;
                transition: background-color 0.3s ease;
            }
            .icon-circle:hover {
                background-color: darkgrey;
            }
            .dropdown-menu {
                display: none;
                position: absolute;
                top: 52px;
                right: 20px;
                width: 360px;
                height: 700px;
                background-color: white;
                color: black;
                border-radius: 7px;
                padding: 10px;
                z-index: 1000;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .user-info {
                width: 330px;
                height: 75px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 7px;
                margin-bottom: 10px;
            }
            .user-info-button {
                display: flex;
                align-items: center;
                width: 328px;
                height: 70px;
                border: none;
                background: none;
                cursor: pointer;
                border-radius: 7px;
                padding: 5px;
                transition: background-color 0.3s ease;
            }
            .user-info-button:hover {
                background-color: #f2f2f2;
            }
            .avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                margin-right: 10px;
            }
            .username {
                font-size: 16px;
                font-weight: bold;
            }
            .menu-item {
                align-items: center;
                height: 75px;
                padding: 10px;
                cursor: pointer;
                border-radius: 7px;
                transition: background-color 0.3s ease;
            }

            .user-menu {
                display: none;
                position: absolute;
                top: 50px;
                right: 20px;
                width: 360px;
                max-height: 400px;
                background-color: white;
                color: black;
                border-radius: 7px;
                padding: 10px;
                z-index: 1000;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .user-menu div {
                display: flex;
                align-items: center;
                padding: 10px 0;
                cursor: pointer;
                font-size: 16px;
            }

            .user-menu div:hover {
                background-color: #eee;
            }
            .active-button {
                background-color: rgb(191, 217, 243);
                color: white;
            }
            .container{
                max-width: 100%;
            }
            .RightItem, .UserAvatar{
                margin-top: 20px;
                height: 70px;
                max-width: 350px;
            }
             .RightItem {
                margin-top: 15px;
                height: 60px;
                max-width: 350px;
            }
            .UserAvatar:hover{
                background-color: #e4e6e8;
                border-radius: 7px;
            }
            .RightItem div:hover{
                background-color: #e4e6e8;
                border-radius: 7px;
            }
            .RightItem div{margin-top: 10px;
                display: flex;
                align-items: center;
                padding: 10px 0;
                cursor: pointer;
                font-size: 16px;
                gap:20px;
            }
.post {
    height: auto;
    background-color: #fff;
    border-radius: 15px;
    padding: 10px;
    box-sizing: border-box;
}

.input {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
}

.inputArea {
    flex: 1;
    min-width: 0;
}

.inputArea input {
    border: none;
    border-radius: 15px;
    height: 40px;
    width: 90%;
    transition: width 0.3s ease;
    outline: 1px solid rgb(133, 130, 130);
    box-sizing: border-box;
}
.btn-document{
    display:flex;
    justify-content: space-between;
    width:100%;
   
}


.item {
    flex: 1;
    text-align: center;
    height:50px;
    padding: 10px;
    margin: 5px;
    margin-bottom: 10px;
    transition: transform 0.2s;
    cursor: pointer;
    max-height:400px;
}

.item:hover {
    transform: scale(1.1);
    background-color: #e0e0e0;
    border-radius: 20px;

}
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5); /* Màu nền mờ */
    z-index: 10; /* Đặt lên trên các phần tử khác */
    display: flex;
    justify-content: center;
    align-items: center;
}

.form-container {
    background: white; /* Màu nền cho form */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    z-index: 20; /* Đặt lên trên overlay */
    max-width: 400px; /* Chiều rộng tối đa của form */
    width: 100%; /* Chiều rộng 100% */
    position: absolute; /* Để đặt nó ở giữa */
    left: 50%; /* Căn giữa theo chiều ngang */
    top: 50%; /* Căn giữa theo chiều dọc */
    transform: translate(-50%, -50%); /* Đưa form vào giữa */
}
.post {
    height: auto;
    border-top: 1px solid #ddd;
    padding-top: 10px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 10px;
    padding-top: 10px;
}

.post-header {
    font-weight: bold;
    margin-bottom: 5px;
}

.add-friend {
    border-top: 1px solid #ddd;
    padding-top: 10px;
}

.list-group-item {
    border: none;
    padding-left: 0;
}


.post-ratings-container {
    display: flex;
    justify-content: left;
    padding: 12px 0;
}

.post-rating {
    display: flex;
    align-items: center;
    cursor: default;
}

.post-rating-selected > .post-rating-button,
.post-rating-selected > .post-rating-count {
    color: #009578;
}

.post-rating-button {
    margin-right: 6px;
    color: #555555;
}

.post-rating:not(.post-rating-selected) > .post-rating-button:hover {
    color: #009578;
}


@media screen and (max-width: 768px) {
    .ava-name{
        display: none;
    }
    .friend-list{
        display: none;
    }
    .chat-box{
        display: none;
    }
    .post-method{
        width: 125%;
    }
    .home-logo{
        display: none;
    }
    .all-post{
        margin-top: 5%;
    }
    
}



        </style>
    </head>
    <body>
        <div class="flex-container navbar">
            <div class="logo" style="">Logo</div>
            <div class="search-bar">
                <input type="text" placeholder="Search..." id="search-input">
            </div>
            <div class="center-buttons">
                <button class="center-button" id="home-btn">
                    <box-icon type='solid' name='home'></box-icon>
                </button>
                <button class="center-button" id="video-btn">
                    <box-icon name='videos' type='solid'></box-icon>
                </button>
                <button class="center-button" id="market-btn">
                    <box-icon name='store-alt' type='solid'></box-icon>
                </button>
                <button class="center-button" id="friend-btn">
                    <box-icon name='group' type='solid'></box-icon>
                </button>
            </div>
            <div class="right-icons">
                <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo' ></box-icon></span>
                <span class="icon icon-circle" id="notification-btn"><box-icon name='bell' type='solid' ></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
            </div>

        </div>
        <div class="dropdown-menu" id="messenger-menu">
            <p>Messenger content goes here...</p>
        </div>
        <div class="dropdown-menu" id="notification-menu">
            <p>Notification content goes here...</p>
        </div>
    </div>
    <div class="dropdown-menu" id="notification-menu">
        <p>Notification content goes here...</p>
    </div>
    <div class="user-menu" id="user-menu">
        <div class="user-info">
            <button class="user-info-button">
                <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                <span class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</span>
            </button>
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
            <div class="col-4">
                <div class="UserAvatar">
                    <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                    <span class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</span>        
                </div>
                <div class="RightItem">
                    <div><i class='fas fa-user-friends' > </i>    Friends</div>
                    <div> <box-icon name='group' type='solid' ></box-icon>    Groups  </div>
                    <div> <box-icon type='solid' name='bookmark'></box-icon>    Saved  </div>
                    <div><box-icon name='videos' type='solid'></box-icon> Video </div>
                    <div><box-icon name='store-alt' type='solid'></box-icon> Market</div>
                    <div><box-icon type='solid' name='book'></box-icon> Learning Materials</div>
                    <div><i class='fas fa-gamepad' style='font-size:20px'></i> Game</div>
                    <hr style="border: 1px solid black; width: 100%;"><!-- comment -->

                    <p>Your ShortCut</p>


                </div>




            </div>
            <div class="col-4">
                <div class="post">
                    <section class="input">
                        <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar" style="margin-right: 10px;">
                        <div class="inputArea">
                            <input type="text" placeholder="What ya thinking..." id="posting">
                        </div>
                        <hr style="border: 1px solid black; width: 100%;">
                        <div class="btn-document">
                            <div class="item" id="photoVideoBtn">Photo/Video</div>
                            <div class="item" id="fileBtn">File</div>
                        </div>
                    </section>
                </div>

                <div class="overlay" id="overlay" style="display: none;"></div>

                <div class="form-container" id="formContainer" style="display: none;">
                    <form action="/FUNET/home" method="post" class="mb-4 post-method" enctype="multipart/form-data" id="postForm">
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
                </div>
                <div></div>
            </div>
                        
            <div class="col-4">
                <div class="friendList">
s
                </div>
            </div>
        </div></div>







</div>
</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script>
                                document.getElementById('messenger-btn').addEventListener('click', function () {
                                    toggleMenu('messenger-menu', 'messenger-btn');
                                });

                                document.getElementById('notification-btn').addEventListener('click', function () {
                                    toggleMenu('notification-menu', 'notification-btn');
                                });

                                document.getElementById('user-btn').addEventListener('click', function () {
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
                                document.addEventListener('DOMContentLoaded', function () {
                                    const overlay = document.getElementById('overlay');
                                    const formContainer = document.getElementById('formContainer');
                                    const postingInput = document.getElementById('posting');
                                    const photoVideoBtn = document.getElementById('photoVideoBtn');
                                    const fileBtn = document.getElementById('fileBtn');
                                    const postForm = document.getElementById('postForm');

                                    // Hàm hiển thị form
                                    function showForm() {
                                        overlay.style.display = 'flex'; // Hiển thị overlay
                                        formContainer.style.display = 'block'; // Hiển thị form
                                    }

                                    // Thêm sự kiện click cho input và button
                                    postingInput.addEventListener('click', showForm);
                                    photoVideoBtn.addEventListener('click', showForm);
                                    fileBtn.addEventListener('click', showForm);

                                    // Sự kiện submit cho form
                                    postForm.addEventListener('submit', function (event) {
                                        event.preventDefault(); // Ngăn chặn hành động gửi form mặc định
                                        overlay.style.display = 'none'; // Ẩn overlay
                                        formContainer.style.display = 'none'; // Ẩn form
                                        // Có thể thêm mã gửi form ở đây nếu cần
                                        alert('Form đã được gửi'); // Thông báo cho người dùng
                                    });
                                });

</script>
</body>
</html>
