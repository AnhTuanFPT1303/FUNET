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

        <style>
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
                position:sticky;
                index:1000;
            }

            .center-buttons {
                display: flex;
                gap: 10px;
                justify-content: center;
                align-items: center;
                flex-grow: 1;
                margin-left: 10%;

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
                height: 35px;
                width: 250px;
                transition: width 0.3s ease;
                outline: 1px solid rgb(133, 130, 130);
                font-size:15px;
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
                justify-content:flex-end;
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
                width: 40px;
                height: 40px;
                background-color: rgb(211, 211, 211);
                border-radius: 50%;
                transition: background-color 0.3s ease;
            }
            .icon-circle:hover {
                background-color: darkgrey;
            }
            .dropdown-menu {
                display: none;
                position: fixed;

                right: 20px;
                width: 360px;
                height: 500px;
                background-color: white;
                color: black;
                border-radius: 15px;
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
                position: fixed;
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

                width: 350px;

            }

            .UserAvatar:hover{
                background-color: #e4e6e8;
                border-radius: 7px;
            }
            .RightItem div:hover{
                background-color: #e4e6e8;
                border-radius: 7px;
            }
            .RightItem div{
                margin-top: 10px;
                display: flex;
                align-items: center;
                padding: 10px 0;
                cursor: pointer;
                font-size: 16px;
                gap:20px;
            }
            .post {
                height: fit-content;
                background-color: #fff;
                border-radius: 15px;
                padding: 10px;
                box-sizing: border-box;
                margin-top: 30px;
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
                background: rgba(0, 0, 0, 0.5);
                z-index: 10;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .form-container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                z-index: 20;
                max-width: 600px;
                width: 100%;
                position: absolute;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
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

            .three-dot-btn {
                border: none;
                background-color: white;
                outline: none;
                cursor: pointer;
            }
            .edit-comment-btn{
                border: none;
                background-color: white;
                outline: none;
                cursor: pointer;
            }
            .delete-comment-btn{
                border: none;
                background-color: white;
                outline: none;
                cursor: pointer;
            }


            @media screen and (max-width: 1250px) {
                .center-buttons{
                    display:none;
                }
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
            @media screen and (max-width: 1050px) {
                .search-bar input {
                    width:200px;

                }


            }
            @media screen and (max-width: 850px) {
                .search-bar {
                    display:none;
                }
                .logo{
                    display:none;
                }
                .RightItem{
                    margin:0;
                    justify-content: center;
                }
            }




            .form-container {
                width: 554px;
                min-height: 415px;
                margin: 0 auto;
                border: 1px solid #e5e5e5;
                border-radius: 10px;
                padding: 10px;
                background-color: #ffffff;
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
            }

            .form-title {
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                margin: 0;
                height: 15px;
            }

            .form-header {
                display: flex;

                margin: 5px 0 10px 40px;
            }
            .head {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
            }

            .form-title {
                flex-grow: 1;
                text-align: center;
                margin: 0;
            }

            .close-button {
                width: 30px;
                height:30px
                    ;
                border-radius: 50%;
                text-align: center;
            }
            .close-button:hover{
                background-color: #cccfd4;
            }


            .ava-name {
                margin-left: 5px;
                font-size: 14px;
            }

            .hr-line {
                border: 0.5px solid black;
                width: 100%;
                margin:0;

            }

            .textarea-container {
                margin: 0;
                width: 462px;

            }

            .form-control {
                width: 100%;
                height: 125px;
                padding: 10px;
                border-radius: 5px;
                border: none;
                resize: none;
                margin-left:15px;
                margin-bottom:10px;
                font-size: 25px;
                overflow: hidden;
            }
            .form-content {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .upload-section {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
                width: 100%;
                margin-left: auto;
                margin-right: auto;
            }

            .upload-div {
                cursor: pointer;
                font-size: 14px;
                color: #007bff;
                display: flex;
                align-items: center;
            }

            .submit-button {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                color: #ffffff;
                cursor: pointer;
                margin:0;
                align-self: flex-end;
            }

            .submit-button:disabled {
                background-color: #e0e0e0;
            }
        </style>
    </head>
    <body>
        <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%">Logo</div>
            </a>
            <form class="" method="get" action="/FUNET/searchServlet" id="searchForm">
                <div class="search-bar">
                    <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input">

                </div>
            </form>
            <div class="center-buttons">

                <button class="center-button" id="home-btn" href="home">
                    <box-icon type='solid' name='home'></box-icon>
                </button>
                <button class="center-button" id="video-btn">
                    <box-icon name='videos' type='solid'></box-icon>
                </button>
                <button class="center-button" id="market-btn">
                    <box-icon name='store-alt' type='solid'></box-icon>
                </button>
                <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                    <button class="center-button" id="friend-btn">
                        <box-icon name='group' type='solid'></box-icon>
                    </button>                       
                </a>

            </div>
            <div class="right-icons">
                <a href="/FUNET/chat" class="mess-icon me-3" style='margin-left:5px'>
                    <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo' ></box-icon></span>
                </a>
                <span class="icon icon-circle" id="notification-btn"><box-icon name='bell' type='solid' ></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
            </div>

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
            <div class="col-4" style="margin-top:1%;">
                <a href="profile?userId=${sessionScope.user['user_id']}" style="text-decoration:none">
                    <div class="UserAvatar">
                        <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                        <span class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</span>        
                    </div></a>

                <div class="RightItem">
                    <div><i class='fas fa-user-friends' > </i>    Friends</div>
                    <div> <box-icon name='group' type='solid' ></box-icon>    Groups  </div>
                    <a href="savePostServlet" style="text-decoration: none">
                        <div>

                            <box-icon type='solid' name='bookmark'></box-icon> Saved
                        </div>
                    </a>
                    <div><box-icon name='videos' type='solid'></box-icon> Video </div>
                    <a href="marketLink" style="text-decoration: none">
                        <div>

                            <box-icon type='solid' name='store-alt'></box-icon> Market
                        </div>
                    </a>
                    
                    <a href="lmaterialLink" style="text-decoration: none">
                        <div>

                            <box-icon type='solid' name='store-alt'></box-icon> Learning Materials
                        </div>
                    </a>
                    
                    <a href="game" style="text-decoration: none">
                        <div>
                            <box-icon type='solid' class="fas fa-gamepad"></box-icon> Game
                        </div>
                    </a>
                    <hr style="border: 1px solid black; width: 100%;"><!-- comment -->

                    <p>Your ShortCut</p>
                </div>
            </div>
            <div class="col-4">
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
                                <button type="button" class="close-button" aria-label="Close">X</button>
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
                            <div class="post-header d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <img src="assets/profile_avt/${post.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 40px; height: 40px;object-fit: cover;">
                                    <small>${post.first_name} ${post.last_name} -- <fmt:formatDate value="${post.post_time}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                                </div>
                                <span class="thre-dto-btn fas fa-ellipsis-h"></span>
                                <div class="dropdown-save" style="display: none;">
                                    <form action="/FUNET/savePostServlet" method="post">
                                        <input type="hidden" name="postId" value="${post.post_id}">
                                        <c:choose>
                                            <c:when test="${post.savedByCurrentUser}">
                                                <button type="submit" class="btn-warning">
                                                    <i class="fas fa-bookmark me-2"></i>Unsave Post
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="submit" class="btn-primary">
                                                    <i class="far fa-bookmark me-2"></i>Save Post
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </div>
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
                                        <div class="comment-body" style="display: flex; justify-content: space-between; align-items: center;">
                                            <p style="margin-bottom: 0;" class="comment-text">${comment.comment_text}</p>
                                            <div class="comment-options">
                                                <c:if test="${sessionScope.user['user_id'] == comment.user_id}">
                                                    <button class="three-dot-btn" data-comment-id="${comment.comment_id}">...</button>
                                                </c:if>
                                                <div class="comment-actions" style="display: none;">
                                                    <button class="edit-comment-btn" data-comment-id="${comment.comment_id}">Edit</button>
                                                    <form action="/FUNET/deleteCommentServlet" method="post" class="delete-comment-form" style="display: inline;">
                                                        <input type="hidden" name="commentId" value="${comment.comment_id}">
                                                        <button type="submit" class="delete-comment-btn">Delete</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <form action="/FUNET/updateCommentServlet" method="post" class="edit-comment-form" style="display: none;">
                                            <input type="hidden" name="commentId" value="${comment.comment_id}">
                                            <textarea name="newCommentText" class="form-control">${comment.comment_text}</textarea>
                                            <button type="submit" class="btn btn-primary">Save</button>
                                            <button type="button" class="btn btn-secondary cancel-edit-comment">Cancel</button>
                                        </form>
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

            <div class="col-4">
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
        <script src="assets/js/reaction.js" defer></script>

        <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            const style = document.createElement('style');
                                            style.textContent = `
        .post {
            position: relative;
        }
        
        .thre-dto-btn {
            cursor: pointer;
            padding: 5px 10px;
            float: right;
        }
        
        .post .dropdown-save {
            position: absolute;
            right: 10px;
            top: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 8px;
            min-width: 150px;
            z-index: 1000;
        }
        
        .post .dropdown-save button {
            width: 100%;
            padding: 8px 12px;
            border: none;
            background: none;
            text-align: left;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.2s;
        }
        
        .post .dropdown-save button:hover {
            background-color: #f0f2f5;
        }
        
        .post .dropdown-save button.btn-primary {
            color: #1877f2;
        }
        
        .post .dropdown-save button.btn-warning {
            color: #ed6c02;
        }
    `;
                                            document.head.appendChild(style);

                                            const posts = document.querySelectorAll('.post');

                                            posts.forEach(post => {
                                                const threeDotBtn = post.querySelector('.thre-dto-btn');
                                                const dropdownMenu = post.querySelector('.dropdown-save');

                                                if (threeDotBtn && dropdownMenu) {
                                                    threeDotBtn.addEventListener('click', (e) => {
                                                        e.stopPropagation();

                                                        document.querySelectorAll('.post .dropdown-save').forEach(menu => {
                                                            if (menu !== dropdownMenu) {
                                                                menu.style.display = 'none';
                                                            }
                                                        });

                                                        dropdownMenu.style.display = dropdownMenu.style.display === 'none' ? 'block' : 'none';
                                                    });
                                                }
                                            });

                                            document.addEventListener('click', (e) => {
                                                if (!e.target.closest('.thre-dto-btn')) {
                                                    document.querySelectorAll('.post .dropdown-save').forEach(menu => {
                                                        menu.style.display = 'none';
                                                    });
                                                }
                                            });
                                        });
        </script>

        <!-- delete update comment + button"..." -->
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

            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.three-dot-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        const commentId = this.getAttribute('data-comment-id');
                        const actions = this.closest('.comment-options').querySelector('.comment-actions');
                        actions.style.display = actions.style.display === 'none' ? 'block' : 'none';
                    });
                });

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
        <!-- --------- -->
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

//            document.addEventListener('click', function (event) {
//                const messengerMenu = document.getElementById('messenger-menu');
//                const notificationMenu = document.getElementById('notification-menu');
//                const userMenu = document.getElementById('user-menu');
//                const messengerBtn = document.getElementById('messenger-btn');
//                const notificationBtn = document.getElementById('notification-btn');
//                const userBtn = document.getElementById('user-btn');
//
//                if (!messengerMenu.contains(event.target) && !messengerBtn.contains(event.target)) {
//                    messengerMenu.style.display = 'none';
//                    messengerBtn.classList.remove('active-button');
//                }
//                if (!notificationMenu.contains(event.target) && !notificationBtn.contains(event.target)) {
//                    notificationMenu.style.display = 'none';
//                    notificationBtn.classList.remove('active-button');
//                }
//                if (!userMenu.contains(event.target) && !userBtn.contains(event.target)) {
//                    userMenu.style.display = 'none';
//                    userBtn.classList.remove('active-button');
//                }
//            });

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