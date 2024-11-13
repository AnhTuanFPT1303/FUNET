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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
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
                <div class="col-10 main-content">
                    <!-- Phần này dùng để ktra xem người dùng có đơn hàng không -->
                    <div class="container my-4">
                        <div class="buyer-orders mb-5">
                            <h3 class="text-center">Your Purchased Orders</h3>
                            <c:forEach items="${buyerOrdersList}" var="order" varStatus="loop">
                                <div class="order-item border rounded p-3 mb-3">
                                    <h5>Order ID: ${order.order_id}</h5>
                                    <p>Total Amount: $${order.total_amount}</p>
                                    <p>Status: ${order.order_status}</p>

                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Product ID</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${buyerOrderDetails[loop.index]}" var="detail">
                                                <tr>
                                                    <td>${detail.productId}</td>
                                                    <td>${detail.quantity}</td>
                                                    <td>$${detail.price}</td>
                                                    <td>${detail.orderStatus}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <c:if test="${order.order_status == 'ongoing'}">
                                        <form action="UpdateOrderStatusServlet" method="POST">
                                            <input type="hidden" name="orderId" value="${order.order_id}">
                                            <input type="hidden" name="action" value="confirm">
                                            <button type="submit" class="btn btn-success">Confirm Receipt</button>
                                        </form>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="seller-orders">
                            <h3 class="text-center">Orders from Your Products</h3>
                            <c:forEach items="${sellerOrders}" var="order" varStatus="loop">
                                <div class="order-item border rounded p-3 mb-3">
                                    <h5>Order ID: ${order.order_id}</h5>
                                    <p>Buyer ID: ${order.user_id}</p>
                                    <p>Total Amount: $${order.total_amount}</p>
                                    <p>Status: ${order.order_status}</p>

                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Product ID</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${sellerOrderDetails[loop.index]}" var="detail">
                                                <tr>
                                                    <td>${detail.productId}</td>
                                                    <td>${detail.quantity}</td>
                                                    <td>$${detail.price}</td>
                                                    <td>${detail.orderStatus}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <c:if test="${order.order_status == 'Pending'}">
                                        <form action="UpdateOrderStatusServlet" method="POST">
                                            <input type="hidden" name="orderId" value="${order.order_id}">
                                            <input type="hidden" name="action" value="submit">
                                            <button type="submit" class="btn btn-primary">Send Order</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${order.order_status == 'received'}">
                                        <!-- Nút mở modal -->
                                        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#receivePaymentModal">
                                            Receive Payment
                                        </button>

                                        <!-- Modal -->
                                        <div class="modal fade" id="receivePaymentModal" tabindex="-1" aria-labelledby="receivePaymentModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="receivePaymentModalLabel">Confirm Payment Reception</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to receive the payment for this order?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <!-- Form nhận thanh toán -->
                                                        <form action="UpdateOrderStatusServlet" method="POST">
                                                            <input type="hidden" name="orderId" value="${order.order_id}">
                                                            <input type="hidden" name="action" value="getMoney">
                                                            <button type="submit" class="btn btn-warning">Receive Payment</button>
                                                        </form>
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>


                                </div>
                            </c:forEach>
                        </div>
                    </div>

                </div>

                <footer class="bg-light text-center text-lg-start mt-5">
                    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.1);">
                    </div>
                </footer>
                </main>
            </div>
        </div>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
