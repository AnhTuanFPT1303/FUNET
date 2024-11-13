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
        <link rel="stylesheet" href="assets/css/lmaterial.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
        <link href="assets/css/logonavbarmk.css" rel="stylesheet">  
        <script>
            function showNotification(message) {
                // Create a notification div
                var notification = document.createElement("div");
                notification.className = "notification success";
                notification.innerHTML = message;

                // Style the notification
                notification.style.position = "fixed";
                notification.style.top = "20px";
                notification.style.right = "20px";
                notification.style.padding = "15px";
                notification.style.backgroundColor = "#4CAF50"; // Success green
                notification.style.color = "#fff";
                notification.style.borderRadius = "5px";
                notification.style.zIndex = "1000";

                // Add the notification to the body
                document.body.appendChild(notification);

                // Automatically remove the notification after 3 seconds
                setTimeout(function () {
                    notification.remove();
                }, 3000);
            }
        </script>
    </head>
    <body>
        <header id="header">
            <div class="flex-container navbar">
                <a href="home" style="text-decoration:none">
                    <div class="logo" style="margin-bottom: 10%">FUNET</div>
                </a>

                <form method="get" action="/searchServlet" id="searchForm">
                    <div class="search-bar" style="margin-top:1%;">
                        <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input" style="padding-left:5%;">
                    </div>
                </form>

                <!-- Các icon ở giữa -->
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
                    <a href="marketLink">
                        <button class="center-button" id="market-btn">
                            <box-icon name='store-alt' type='solid'></box-icon>
                        </button>
                    </a>
                    <a href="/friendRequestServlet" class="friend-btn me-3">
                        <button class="center-button" id="friend-btn">
                            <box-icon name='group' type='solid'></box-icon>
                        </button>
                    </a>
                    <a href="/chat" class="mess-icon" style="margin-right:5px">
                        <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo'></box-icon></span>
                    </a>
                    <span class="icon icon-circle" id="notification-btn" style="display:none">
                        <box-icon name='bell' type='solid'></box-icon>
                    </span>
                    <span class="icon icon-circle" id="user-btn">&#128100;</span>
                </div>

            </div>

        </header>

        <!-- chức năng ngang -->
        <div class="container-fluid">
            <div class="row all-post">
                <nav class="col-2 py-3 bg-light sidebar sticky-sidebar position-sticky" style="top: 76px;">
                    <div class="profile-section mb-3 d-flex align-items-center">
                        <a href="userpageServlet?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                            <img src="assets/profile_avt/main.jpg" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                            <p class="mb-0 ms-2 ava-name">${"vuaga1260"}</p>
                        </a>
                    </div>
                    <div class="chat-box mb-3"></div>

                    <form action ="SearchProductServlet" class="d-flex mb-3">
                        <input type="text" class="form-control me-2" name="keyword" placeholder="Find product">
                        <button class="btn btn-outline-dark fa-solid fa-magnifying-glass" type="submit"></button>
                    </form>

                    <div class="btn-group-vertical w-100 mb-3">
                        <a href="notificationServlet" class="btn btn-outline-dark fa-solid fa-bell mb-2"> Notifications</a>
                        <a href="AddProductServlet" class="btn btn-outline-dark fa-solid fa-plus mb-2"> Add product</a>
                        <a href="SellingProductServlet" class="btn btn-outline-dark fa-solid fa-money-bill mb-2"> Yours products</a>
                    </div>
                </nav>

                <main class="main-class col-10">
                    <h1 class="mb-4 text-center text-dark">Add Product to our market</h1>

                    <form action="ProductUploadServlet" method="post" enctype="multipart/form-data" style="max-width: 600px; margin: 0 auto; padding: 20px; background-color: #333; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="productName" style="color: #fff; font-size: 16px;">Product Name:</label>
                            <input type="text" class="form-control" id="productName" name="productName" required style="padding: 10px; font-size: 14px; border: 1px solid #555; background-color: #444; color: #fff; border-radius: 5px; width: 100%; box-sizing: border-box;">
                        </div>
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="productDescription" style="color: #fff; font-size: 16px;">Product Description:</label>
                            <input type="text" class="form-control" id="productDescription" name="productDescription" required style="padding: 10px; font-size: 14px; border: 1px solid #555; background-color: #444; color: #fff; border-radius: 5px; width: 100%; box-sizing: border-box;">
                        </div>
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="productTag" style="color: #fff; font-size: 16px;">Product Tag:</label>
                            <input type="text" class="form-control" id="productTag" name="productTag" required style="padding: 10px; font-size: 14px; border: 1px solid #555; background-color: #444; color: #fff; border-radius: 5px; width: 100%; box-sizing: border-box;">
                        </div>
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="quantity" style="color: #fff; font-size: 16px;">Quantity:</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" step="0.01" required style="padding: 10px; font-size: 14px; border: 1px solid #555; background-color: #444; color: #fff; border-radius: 5px; width: 100%; box-sizing: border-box;">
                        </div>
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="price" style="color: #fff; font-size: 16px;">Price:</label>
                            <input type="number" class="form-control" id="price" name="price" step="0.01" required style="padding: 10px; font-size: 14px; border: 1px solid #555; background-color: #444; color: #fff; border-radius: 5px; width: 100%; box-sizing: border-box;">
                        </div>
                        <div class="form-group" style="margin-bottom: 20px;">
                            <label for="productImage" style="color: #fff; font-size: 16px;">Product Image:</label>
                            <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*" required style="padding: 10px; font-size: 14px; border: 1px solid #555; background-color: #444; color: #fff; border-radius: 5px; width: 100%; box-sizing: border-box;">
                        </div>
                        <button type="submit" class="btn btn-dark mt-3" style="width: 100%; padding: 10px; font-size: 16px; background-color: #000; color: #fff; border-radius: 5px; border: none; cursor: pointer;">Upload</button>
                    </form>


                    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="updateModalLabel">Update Product</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!-- Form cập nhật sản phẩm -->
                                    <form action="UpdateProductServlet" method="post" enctype="multipart/form-data"> 
                                        <div class="form-group">
                                            <label for="productName">Product Name:</label>
                                            <input type="text" class="form-control" id="productName" name="productName" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="productDescription">Product Description:</label>
                                            <input class="form-control" id="productDescription" name="productDescription" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="productTag">Product Tag:</label>
                                            <input type="text" class="form-control" id="productTag" name="productTag" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="quantity">Quantity:</label>
                                            <input type="number" class="form-control" id="quantity" name="quantity" step="0.01" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="price">Price:</label>
                                            <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="productImage">Product Image:</label>
                                            <input type="file" class="form-control" id="productImage" name="productImage" accept="image/*" required>
                                        </div>
                                        <button type="submit" class="btn btn-dark">Upload</button>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
