<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        <div class="container-fluid">
            <div class="row all-post">
                <nav class="col-2 py-3 bg-light sidebar sticky-sidebar position-sticky" style="top: 76px;">
                    <div class="profile-section mb-3 d-flex align-items-center">
                        <a href="userpageServlet?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                            <img src="assets/profile_avt/main.jpg" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                            <p class="mb-0 ms-2 ava-name">${"vuaga1260"}</p>
                        </a>
                    </div>
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
                    <h1 class="mb-4 text-center text-primary">Payment Process</h1>

                    <c:if test="${not empty cartItems}">
                        <table class="table table-bordered mt-4">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cartItems}">
                                    <tr>
                                        <td>
                                            <c:forEach var="product" items="${productList}">
                                                <c:if test="${product.productId == item.productId}">${product.productName}</c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${item.quantity}</td>
                                        <td>
                                            <c:forEach var="product" items="${productList}">
                                                <c:if test="${product.productId == item.productId}">${product.price}</c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <c:forEach var="product" items="${productList}">
                                                <c:if test="${product.productId == item.productId}">${product.price * item.quantity}</c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td colspan="3" class="text-end">Total:</td>
                                    <td>${totalAmount}</td>
                                </tr>
                            </tbody>
                        </table>
                    </c:if>

                    <form action="VNPayServlet" method="get" enctype="multipart/form-data" style="max-width: 800px; margin: 0 auto; padding: 20px; background-color: #333; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
                        <input type="hidden" name="cartId" value="${cartId}">
                        <input type="hidden" name="userId" value="${userId}">

                        <!-- Shipping Address -->
                        <div class="form-group mb-3">
                            <label for="shippingAddress" class="text-white">Shipping Address:</label>
                            <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" required style="border-radius: 5px;">
                        </div>

                        <!-- Order Notes -->
                        <div class="form-group mb-3">
                            <label for="orderNotes" class="text-white">Order Note:</label>
                            <textarea class="form-control" id="orderNotes" name="orderNotes" rows="3" style="border-radius: 5px;"></textarea>
                        </div>

                        <!-- Payment Method -->
                        <div class="form-group mb-3">
                            <label for="paymentMethod" class="text-white">Select Payment Method:</label><br>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay" value="VNPay" required>
                                <label class="form-check-label text-white" for="vnpay">VNPay (currently only supports VNPay)</label>
                            </div>
                        </div>

                        <!-- Total Amount -->
                        <div class="form-group mb-3">
                            <label for="totalAmount" class="text-white">Total Amount:</label>
                            <input type="number" class="form-control" id="totalAmount" name="totalAmount" value="${totalAmount}" readonly style="border-radius: 5px;">
                        </div>

                        <button type="submit" class="btn btn-success w-100 py-2">Proceed to Payment</button>
                    </form>
                </main>


            </div>
        </div>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
