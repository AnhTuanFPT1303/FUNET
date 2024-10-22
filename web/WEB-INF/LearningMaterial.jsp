<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ page import="model.Message, dao.MessageDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/learningMaterial.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="assets/css/home.css">
                <link rel="stylesheet" href="assets/css/learningMaterial.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .material-container {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 15px;
                background-color: #fff;
                margin-bottom: 20px;
                text-align: center;
            }
            .material-img {
                max-width: 100%;
                height: auto;
                border-radius: 5px;
            }
            h5 {
                margin-top: 10px;
                color: #007bff;
            }
            .text-muted {
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%">Logo</div>
            </a>
            <form class="" method="get" action="/FUNET/searchServlet" id="searchForm">
                <div class="search-bar">
                    <input  name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input">

                </div>
            </form>


            <div class="center-buttons">
                <div id="home-btn">
                    <a href="/FUNET/home">
                        <button class="center-button" >
                            <div class="btn-content">
                                <box-icon type='solid' name='home'></box-icon>
                            </div>
                        </button>
                </div>


                <a href="home">
                    <button class="center-button" id="video-btn">
                        <div class="btn-content">
                            <box-icon name='videos' type='solid'></box-icon>
                        </div>
                    </button>
                </a>

                <a href="home">
                    <button class="center-button" id="market-btn">
                        <div class="btn-content">
                            <box-icon name='store-alt' type='solid'></box-icon>
                        </div>
                    </button>
                </a>

                <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                    <button class="center-button" id="friend-btn">
                        <div class="btn-content">
                            <box-icon name='group' type='solid'></box-icon>
                        </div>
                    </button>
                </a>
            </div>

            <div class="right-icons">
                <a href="/FUNET/chat" class="mess-icon " style='margin-left:5px'>
                    <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo' ></box-icon></span>
                </a>
                <span class="icon icon-circle" id="notification-btn"><box-icon name='bell' type='solid' ></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
            </div>

        </div>

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


    <!-- chức năng ngang -->
    <div class="container-fluid">
        <div class="row all-post">
            <nav class="col-2 py-3 bg-light sidebar sticky-sidebar position-sticky" style="top: 76px;">
                <h2 class=" text-primary ">Learning Material</h2>
                <form class="d-flex mb-3 search-learning-material-container" method="get" action="/FUNET/searchlearningmaterial">
                    <input class="search-form-controller me-2" name="search-name" type="search" placeholder="Find learning material" aria-label="Search">
                </form>
                <div class="accordion" id="accordionCategories">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Navigation
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionCategories">
                            <div class="accordion-body">
                                <ul class="list-group"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>

            <main class="main-class col-10">
                <div class="row">
                <c:forEach var="material" items="${learningMaterialsList}">
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="material-container">
                            <a href="${material.learningMaterialContext}" download>
                                <img class="material-img" src="${material.learningMaterial_img}" alt="${material.learningMaterialName}">
                            </a>
                            <h5>${material.learningMaterialName}</h5>
                            <p>${material.learningMaterialDescription}</p>
                            <p><small class="text-muted">Subject: ${material.subjectCode}</small></p>
                            <p><small class="text-muted">Published on: ${material.publishDate}</small></p>
                            <small class="text-muted">Review: ${material.review}</small>
                        </div>
                    </div>
                </c:forEach>
            </div>

            </main>
        </div>

    </div>
    <script src="assets/js/bootstrap.min.js"></script>
</body>


</html>