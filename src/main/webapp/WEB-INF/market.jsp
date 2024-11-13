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
        <link rel="stylesheet" href="assets/css/market.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
        <link href="assets/css/logonavbarmk.css" rel="stylesheet">  
    </head>
    <body>
        <header id="header">
            <!-- navbar trên -->
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
                <main class="main-class col-10" style="min-height: 750px">
                    <h2 class="mt-4 mb-5 text-dark d-flex justify-content-center">Product today</h2>


                    <button class="shopping-cart-icon fa-solid fa-cart-shopping" data-toggle="modal" data-target="#orderModal"></button>
                    <div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="gradingModalLabel">Your shopping cart</h5>
                                </div>
                                <div class="modal-body">
                                    <!-- Hiển thị nội dung giỏ hàng -->
                                    <c:if test="${not empty cartItems}">
                                        <table class="table table-bordered">
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
                                                                <c:if test="${product.productId == item.productId}">
                                                                    ${product.productName}
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>${item.quantity}</td>
                                                        <td>
                                                            <c:forEach var="product" items="${productList}">
                                                                <c:if test="${product.productId == item.productId}">
                                                                    ${product.price}
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>
                                                            <c:forEach var="product" items="${productList}">
                                                                <c:if test="${product.productId == item.productId}">
                                                                    ${product.price * item.quantity}
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>
                                                            <c:forEach var="product" items="${productList}">
                                                                <c:if test="${product.productId == item.productId}">
                                                                    <form method="post" action="RemoveItemServlet">
                                                                        <input type="hidden" name="productId" value="${item.productId}">
                                                                        <input type="hidden" value="${item.quantity}" name="quantity">
                                                                        <button type="submit" class="btn btn-danger">Remove</button>
                                                                    </form>
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td>Total Amount:</td>
                                                    <td>${totalAmount}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </c:if>
                                    <c:if test="${empty cartItems}">
                                        <p>Your cart is empty.</p>
                                    </c:if>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                                    <form method="post" action="OrderProcessServlet">
                                        <input type="hidden" name="cartId" value="${cartId}">
                                        <input type="hidden" name="totalAmount" value="${totalAmount}">
                                        <button type="submit" class="btn btn-success">Confirm Payment</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <c:if test="${product.quantity > 0}">
                                <c:if test="${userId != product.userId}">
                                    <div class="col-3 mb-3 productList">
                                        <div class="product-card border" style="border: 2px solid black; padding: 10px; text-align: center;">
                                            <h5>${product.productName}</h5>
                                            <img src="${product.product_img}" alt="Item 1" class="img-fluid" style="max-width: 100%;">
                                            <p>Quantity: ${product.quantity}</p>
                                            <p>Price: ${product.price}</p>
                                            <button type="button" class="btn btn-dark" data-toggle="modal" data-target="#infoModal${product.productId}">View info</button>
                                        </div>
                                        <div class="modal fade" id="infoModal${product.productId}" tabindex="-1" role="dialog" aria-labelledby="infoModalLabel${product.productId}" aria-hidden="true">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="infoModalLabel${product.productId}">${product.productName}</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        <img class="w-100 h-100 productImg" src="${product.product_img}" alt="img" style="width: auto;">
                                                    </div>
                                                    <div class="modal-body">
                                                        <h5 class="w-100 h-100 producDescription">${product.productTag}</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        <h5 class="w-100 h-100 producDescription">${product.productDescription}</h5>
                                                    </div>
                                                    <div class="quantity-container d-flex align-items-center mt-3">
                                                        <button type="button" class="btn btn-secondary" id="decrease${product.productId}" onclick="changeQuantity(${product.productId}, -1)">-</button>
                                                        <input type="text" id="quantity${product.productId}" name="quantity" value="1" class="form-control mx-2 text-center" style="width: 50px;" readonly>
                                                        <button type="button" class="btn btn-secondary" id="increase${product.productId}" onclick="changeQuantity(${product.productId}, 1)">+</button>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <form method="post" action="AddCartServlet" onsubmit="updateHiddenQuantity(${product.productId})">
                                                            <input type="hidden" name="product_id" value="${product.productId}">
                                                            <input type="hidden" id="hiddenQuantity${product.productId}" name="quantity" min="1">
                                                            <button type="submit" class="btn btn-primary">Add to cart</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script>

                                                            function changeQuantity(productId, change) {
                                                                let quantityInput = document.getElementById("quantity" + productId);
                                                                let currentQuantity = parseInt(quantityInput.value);

                                                                let newQuantity = currentQuantity + change;
                                                                if (newQuantity >= 1) { // Không cho phép quantity âm
                                                                    quantityInput.value = newQuantity;
                                                                }
                                                            }

                                                            function updateHiddenQuantity(productId) {
                                                                let quantityInput = document.getElementById("quantity" + productId);
                                                                let hiddenQuantityInput = document.getElementById("hiddenQuantity" + productId);
                                                                hiddenQuantityInput.value = quantityInput.value;
                                                            }
        </script>
    </body>
</html>
