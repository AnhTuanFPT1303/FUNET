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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
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
        <!-- navbar -->
        <nav class="navbar custom-navbar">
            <div class="container-fluid d-flex align-items-center">
                <a class="navbar-brand" href="/FUNET/home">
                    <img src="assets/images/logo.png" alt="Logo" style="width: 70px; height: auto;">
                </a>

                <form class="d-flex ms-auto me-auto flex-grow-1" method="get" action="/FUNET/searchServlet">
                    <input class="form-control me-2" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search">
                    <button type="submit" class="btn btn-outline-primary">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>

                <div class="nav-icons d-flex align-items-center justify-content-between">
                    <a href="/FUNET/lmaterialLink" class="lm-icon fa-solid fa-book fa-lg me-3"></a>
                    <a href="/FUNET/marketLink" class="market-icon fa-solid fa-store fa-lg me-3"></a>
                    <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">...</a>
                    <a href="/FUNET/chat" class="mess-icon me-3">
                        <i class="fas fa-comments"></i>
                    </a> 
                </div>
                <form method="post" action="/FUNET/logout">
                    <button type="submit" class="navbar-brand text-primary log-out" style="font-weight: bold">Log out</button>
                </form>
            </div>
        </nav>
    </header>

    <div class="container-fluid">
        <div class="row all-post">
            <nav class="col-2 py-3 bg-light sidebar sticky-sidebar position-sticky" style="top: 76px;">
                <div class="profile-section mb-3 d-flex align-items-center">
                    <a href="profile?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                <button class="user-info-button">
                    <img src="assets/profile_avt/${sessionScope.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                    <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                </button>
            </a>
                </div>
                <form action ="SearchProductServlet" class="d-flex mb-3">
                    <input type="text" class="form-control me-2" name="keyword" placeholder="Find product">
                    <button class="btn btn-outline-primary" type="submit">Search</button>
                </form>

                <div class="btn-group-vertical w-100 mb-3">
                    <a href="/FUNET/home" class="btn btn-outline-primary mb-2">Main Page</a>
                    <a href="/FUNET/notificationServlet" class="btn btn-outline-primary mb-2">Notifications</a>
                    <a href="/FUNET/AddProductServlet" class="btn btn-outline-primary mb-2">Add product to market</a>
                    <a href="/FUNET/SellingProductServlet" class="btn btn-outline-primary mb-2">Yours products</a>
                </div>
            </nav>

            <main class="main-class col-10">
                <h1 class="mb-4 text-center text-primary">Payment Process</h1>
                <!--lỗi-->
                <form action="VNPayServlet" method="get" enctype="multipart/form-data">
                    <input type="hidden" name="cartId" value="${cartId}">
                    <input type="hidden" name="userId" value="${userId}">

                    <div class="form-group">
                        <label for="shippingAddress">Shipping Address:</label>
                        <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" required>
                    </div>

                    <div class="form-group">
                        <label for="orderNotes">Order Note:</label>
                        <textarea class="form-control" id="orderNotes" name="orderNotes" rows="3"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="paymentMethod">Select Payment Method:</label><br>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay" value="VNPay" required>
                            <label class="form-check-label" for="vnpay">VNPay (currently only supports VNPay)</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="totalAmount">Total Amount:</label>
                        <input type="number" class="form-control" id="totalAmount" name="totalAmount" value="${totalAmount}" readonly>
                    </div>

                    <button type="submit" class="btn btn-primary">Proceed to Payment</button>
                </form>

                <c:if test="${not empty cartItems}">
                    <table class="table table-bordered mt-4">
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Action</th>
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
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </c:if>
            </main>
        </div>
    </div>

    <footer class="footer">
        <div class="container text-center">
            <p>&copy; 2024 Your Website. All rights reserved.</p>
        </div>
    </footer>

    <script src="assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>