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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">

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

            .accordion-collapse {
                transition: max-height 0.3s ease;
                overflow: hidden;
            }
            #learningMaterialForm {
                display: none;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="flex-container navbar" style="box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
            <a href="home" style="text-decoration:none">
                <div class="logo" style="margin-bottom: 10%">Logo</div>
            </a>
            <form class="" method="get" action="/FUNET/searchServlet" id="searchForm">
                <div class="search-bar">
                    <input name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input">
                </div>
            </form>

            <div class="center-buttons">
                <div id="home-btn">
                    <a href="/FUNET/home">
                        <button class="center-button">
                            <div class="btn-content">
                                <box-icon type='solid' name='home'></box-icon>
                            </div>
                        </button>
                    </a>
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
                <a href="/FUNET/chat" class="mess-icon" style='margin-left:5px'>
                    <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo'></box-icon></span>
                </a>
                <span class="icon icon-circle" id="notification-btn"><box-icon name='bell' type='solid'></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
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
                <nav class="col-2 py-3 sidebar sticky-sidebar position-sticky" style="top: 76px;background: white;box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                    <a href="lmaterialLink" style="text-decoration:none;"><h2 class="text-primary">Learning Material</h2></a>      
                    <form class="d-flex mb-3 search-learning-material-container" method="get" action="/FUNET/searchLearningMaterial">
                        <input class="search-form-controller me-2" name="search-name" type="search" placeholder="Find learning material" aria-label="Search">
                    </form>
                    <div class="accordion" id="accordionCategories">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#departmentList" aria-expanded="true" aria-controls="departmentList">
                                    Department
                                </button>
                            </h2>
                            <div id="departmentList" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionCategories">
                                <div class="accordion-body">
                                    <ul class="list-group">
                                        <li class="list-group-item"><a href="/FUNET/learningMaterialDepartmentSearch?departmentId=1" style="text-decoration: none;">Economy</a></li>
                                        <li class="list-group-item"><a href="/FUNET/learningMaterialDepartmentSearch?departmentId=2" style="text-decoration: none;">IT</a></li>
                                        <li class="list-group-item"><a href="/FUNET/learningMaterialDepartmentSearch?departmentId=3" style="text-decoration: none;">Tourism</a></li>
                                        <li class="list-group-item"><a href="/FUNET/learningMaterialDepartmentSearch?departmentId=4" style="text-decoration: none;">Languages</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-primary mt-3" id="toggleFormBtn" style="width:100%;">Add Learning Material</button>
<!--                    <button class="btn btn-secondary mt-3" id="showSavedMaterialsBtn" style="width:100%;">Saved Learning Materials</button>-->

                </nav>

                <main class="main-class col-10" style="margin-top: 1%; position: relative;">
                    <div class="row">
                        <c:forEach var="material" items="${learningMaterialsList}">
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="material-container">
                                    <div class="dropdown">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" style="background-color:white;border: none;">
                                            <i class="fa fa-ellipsis-h" style="color:black;"></i>
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="height:fit-content;width: fit-content;">
                                            <li><a class="dropdown-item" href="#" onclick="showUpdateForm(${material.learningMaterialId}, '${material.learningMaterialName}', '${material.learningMaterialDescription}',  '${material.learningMaterialContext}', '${material.subjectCode}', ${material.departmentId})">Update</a></li>
                                            <li>
                                                <form action="deleteLearningMaterial" method="post" style="display:inline;">
                                                    <input type="hidden" name="id" value="${material.learningMaterialId}">
                                                    <button type="submit" class="dropdown-item">Delete</button>
                                                </form>
                                            </li>
                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="height:fit-content;width: fit-content;">
                                                <li><a class="dropdown-item" href="#" onclick="showUpdateForm(${material.learningMaterialId}, '${material.learningMaterialName}', '${material.learningMaterialDescription}', '${material.learningMaterialContext}', '${material.subjectCode}', ${material.departmentId})">Update</a></li>
                                                <li>
                                                    <form action="deleteLearningMaterial" method="post" style="display:inline;">
                                                        <input type="hidden" name="id" value="${material.learningMaterialId}">
                                                        <button type="submit" class="dropdown-item">Delete</button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </ul>
                                    </div>

                                    <a href="downloadMaterial?name=${material.learningMaterialContext}" >download </a>
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

                <div class="container mt-4" id="learningMaterialForm" enctype="multipart/form-data" style="position: relative; width: 75%; background: none;">
                    <h2>Create Learning Material</h2>
                    <form action="creMaterial" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="name">Name:</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea class="form-control" id="description" name="description" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="subjectCode">Subject Code:</label>
                            <input type="text" class="form-control" id="subjectCode" name="subjectCode" required>
                        </div>
                        <div class="form-group">
                            <label for="departmentId">Department:</label>
                            <select class="form-control" id="departmentId" name="departmentId" required>
                                <option value="1">Economy</option>
                                <option value="2">IT</option>
                                <option value="3">Tourism</option>
                                <option value="4">Languages</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="context">Context File:</label>
                            <input type="file" class="form-control" id="context" name="context" required >
                        </div>
                        <div class="form-group">
                            <label for="review">Review:</label>
                            <input type="text" class="form-control" id="review" name="review" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="position: relative;right: 50%;left: 50%;">Create</button>
                    </form>
                </div>

                <div class="container mt-4" id="updateLearningMaterialForm" enctype="multipart/form-data" style="position: relative; width: 75%; background: none; display: none;">
                    <h2>Update Learning Material</h2>
                    <form action="updateLearningMaterial" method="post">
                        <input type="hidden" id="updateLearningMaterialId" name="id">
                        <div class="form-group">
                            <label for="updateName">Name:</label>
                            <input type="text" class="form-control" id="updateName" name="name" required>
                        </div>
                        <div class="form-group">
                            <label for="updateDescription">Description:</label>
                            <textarea class="form-control" id="updateDescription" name="description" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="updateSubjectCode">Subject Code:</label>
                            <input type="text" class="form-control" id="updateSubjectCode" name="subjectCode" required>
                        </div>
                        <div class="form-group">
                            <label for="updateDepartmentId">Department:</label>
                            <select class="form-control" id="updateDepartmentId" name="departmentId" required>
                                <option value="1">Economy</option>
                                <option value="2">IT</option>
                                <option value="3">Tourism</option>
                                <option value="4">Languages</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="updateImg">Image File:</label>
                            <input type="file" class="form-control" id="updateImg" name="img">
                        </div>
                        <div class="form-group">
                            <label for="updateContext">Context File:</label>
                            <input type="file" class="form-control" id="updateContext" name="context">
                        </div>
                        <div class="form-group">
                            <label for="updateReview">Review:</label>
                            <input type="text" class="form-control" id="updateReview" name="review" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="position: relative;right: 50%;left: 50%;">Update</button>
                    </form>
                </div>
                <script src="assets/js/bootstrap.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
                <script>
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        var departmentList = document.getElementById('departmentList');
                                                        var toggleButton = document.querySelector('.accordion-button');
                                                        var toggleFormBtn = document.getElementById('toggleFormBtn');
                                                        var learningMaterialForm = document.getElementById('learningMaterialForm');
                                                        var updateLearningMaterialForm = document.getElementById('updateLearningMaterialForm');
                                                        var mainContent = document.querySelector('.main-class');



                                                        toggleFormBtn.addEventListener('click', function () {
                                                            if (learningMaterialForm.style.display === 'none') {
                                                                learningMaterialForm.style.display = 'block';
                                                                updateLearningMaterialForm.style.display = 'none';
                                                                mainContent.style.display = 'none';
                                                            } else {
                                                                learningMaterialForm.style.display = 'none';
                                                                mainContent.style.display = 'block';
                                                            }
                                                        });

                                                        document.querySelector('form').addEventListener('submit', function () {
                                                            learningMaterialForm.style.display = 'none';
                                                            updateLearningMaterialForm.style.display = 'none';
                                                            mainContent.style.display = 'block';
                                                        });
                                                    });

                                                    function showUpdateForm(id, name, description, context, subjectCode, departmentId) {
                                                        var updateForm = document.getElementById('updateLearningMaterialForm');
                                                        var mainContent = document.querySelector('.main-class');
                                                        var learningMaterialForm = document.getElementById('learningMaterialForm');

                                                        document.getElementById('updateLearningMaterialId').value = id;
                                                        document.getElementById('updateName').value = name;
                                                        document.getElementById('updateDescription').value = description;
                                                        
                                                        document.getElementById('updateContext').value = context;
                                                        document.getElementById('updateSubjectCode').value = subjectCode;
                                                        document.getElementById('updateDepartmentId').value = departmentId;
                                                        document.getElementById('updateReview').value = review;

                                                        updateForm.style.display = 'block';
                                                        learningMaterialForm.style.display = 'none';
                                                        mainContent.style.display = 'none';
                                                    }
                </script>
                </body>
                </html>