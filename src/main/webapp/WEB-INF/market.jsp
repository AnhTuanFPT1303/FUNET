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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <header id="header">
            <!-- navbar trên -->
            <nav class="navbar custom-navbar">
                <div class="container-fluid d-flex align-items-center">

                    <a class="navbar-brand" href="/home">
                        <img src="assets/images/logo.png" alt="Logo" style="width: 70px; height: auto;">
                    </a>

                    <form class="d-flex ms-auto me-auto flex-grow-1" method="get" action="/searchServlet">
                        <input class="form-control me-2" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search">
                        <button type="submit" class="btn btn-outline-primary">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>

                    <div class="nav-icons d-flex align-items-center justify-content-between">
                        <a href="/lmaterialLink" class="lm-icon fa-solid fa-book fa-lg me-3">
                        </a>
                        <a href="/marketLink" class="market-icon fa-solid fa-store fa-lg me-3"></a>
                        <a href="/friendRequestServlet" class="friend-icon me-3">
                            <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor" class="x19dipnz x1lliihq x1tzjh5l x1k90msu x2h7rmj x1qfuztq" style="--color:var(--secondary-icon)"><path d="M.5 12c0 6.351 5.149 11.5 11.5 11.5S23.5 18.351 23.5 12 18.351.5 12 .5.5 5.649.5 12zm2 0c0-.682.072-1.348.209-1.99a2 2 0 0 1 0 3.98A9.539 9.539 0 0 1 2.5 12zm.84-3.912A9.502 9.502 0 0 1 12 2.5a9.502 9.502 0 0 1 8.66 5.588 4.001 4.001 0 0 0 0 7.824 9.514 9.514 0 0 1-1.755 2.613A5.002 5.002 0 0 0 14 14.5h-4a5.002 5.002 0 0 0-4.905 4.025 9.515 9.515 0 0 1-1.755-2.613 4.001 4.001 0 0 0 0-7.824zM12 5a4 4 0 1 1 0 8 4 4 0 0 1 0-8zm-2 4a2 2 0 1 0 4 0 2 2 0 0 0-4 0zm11.291 1.01a9.538 9.538 0 0 1 0 3.98 2 2 0 0 1 0-3.98zM16.99 20.087A9.455 9.455 0 0 1 12 21.5c-1.83 0-3.54-.517-4.99-1.414a1.004 1.004 0 0 1-.01-.148V19.5a3 3 0 0 1 3-3h4a3 3 0 0 1 3 3v.438a1 1 0 0 1-.01.148z"></path></svg>
                        </a>
                        <a href="/chat" class="mess-icon me-3">
                            <i class="fas fa-comments"></i>
                        </a> 
                    </div>
                    <form method="post" action="/logout">
                        <button type="submit" class="navbar-brand text-primary log-out" style="font-weight: bold">Log out</button>
                    </form>
                </div>
            </nav>
        </header>

        <!-- chức năng ngang -->
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
                    <div class="chat-box mb-3"></div>

                    <form action ="SearchProductServlet" class="d-flex mb-3">
                       <input type="text" class="form-control me-2" name="keyword" placeholder="Find product">
                        <button class="btn btn-outline-primary" type="submit">Search</button>
                    </form>

                    <div class="btn-group-vertical w-100 mb-3">
                        <a href="/home" class="btn btn-outline-primary mb-2">Main Page</a>
                        <a href="/notificationServlet" class="btn btn-outline-primary mb-2">Notifications</a>
                        <a href="/AddProductServlet" class="btn btn-outline-primary mb-2">Add product to market</a>
                        <a href="/SellingProductServlet" class="btn btn-outline-primary mb-2">Yours products</a>
                    </div>
                </nav>
                <main class="main-class col-10">
                    <h2 class="mt-4 mb-5 text-primary d-flex justify-content-center">Product today</h2>


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
                                                                    <form method="post" action="/RemoveItemServlet">
                                                                        <input type="hidden" name="productId" value="${item.productId}">
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
                                    
                                    <form method="post" action="/OrderProcessServlet">
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
                            <div class="col-3 mb-3 productList">
                                <div class="product-card border" style="border: 2px solid black; padding: 10px; text-align: center;">
                                    <h5>${product.productName}</h5>
                                    <img src="${product.product_img}" alt="Item 1" class="img-fluid" style="max-width: 100%;">
                                    <p>Price: ${product.price}</p>
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#infoModal${product.productId}">View info</button>
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
                                                <h5 class="w-100 h-100 producDescription">${product.productDescription}</h5>
                                            </div>


                                                <div class="quantity-container d-flex align-items-center mt-3">
                                                    <button type="button" class="btn btn-secondary" id="decrease${product.productId}" onclick="changeQuantity(${product.productId}, -1)">-</button>
                                                    <input type="text" id="quantity${product.productId}" name="quantity" value="1" class="form-control mx-2 text-center" style="width: 50px;" readonly>
                                                    <button type="button" class="btn btn-secondary" id="increase${product.productId}" onclick="changeQuantity(${product.productId}, 1)">+</button>
                                                </div>


                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <form method="post" action="/AddCartServlet" onsubmit="updateHiddenQuantity(${product.productId})">
                                                        <input type="hidden" name="product_id" value="${product.productId}">
                                                        <input type="hidden" id="hiddenQuantity${product.productId}" name="quantity" value="1">
                                                        <button type="submit" class="btn btn-primary">Add to cart</button>
                                                    </form>

                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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