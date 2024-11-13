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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

                    <h2 class="mt-4 mb-5 text-dark d-flex justify-content-center">Your Product</h2>
                    <h5 class="text-danger text-center mt-3">${error}</h5>
                    <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-3 mb-3">
                                <div class="product-card border" style="border: 2px solid black; padding: 10px; text-align: center;">
                                    <h5>${product.productName}</h5>
                                    <img src="${product.product_img}" alt="Item 1" class="img-fluid" style="max-width: 100%;">
                                    <p>Quantity: ${product.quantity}</p>
                                    <p>Price: ${product.price}</p>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#updateModal${product.productId}">Update</button>

                                    <!-- Modal with unique ID for each product -->
                                    <div class="modal fade" id="updateModal${product.productId}" tabindex="-1" aria-labelledby="updateModalLabel${product.productId}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="updateModalLabel${product.productId}">Update Product: ${product.productName}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="UpdateProductServlet" method="post" class="update-product-form">
                                                        <input type="hidden" name="product_id" value="${product.productId}">

                                                        <div class="mb-3">
                                                            <label for="quantity${product.productId}" class="form-label">Quantity:</label>
                                                            <input type="number" class="form-control" id="quantity${product.productId}" 
                                                                   name="quantity" value="${product.quantity}" min="1" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="price${product.productId}" class="form-label">Price:</label>
                                                            <input type="number" class="form-control" id="price${product.productId}" 
                                                                   name="price" value="${product.price}" min="0.01" step="0.01" required>
                                                        </div>

                                                        <div class="alert alert-danger d-none" role="alert" id="error${product.productId}"></div>

                                                        <button type="submit" class="btn btn-dark">Update Product</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <form method="post" action="DeleteProductServlet" class="mt-2">
                                        <input type="hidden" name="product_id" value="${product.productId}" />
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </main>
            </div>

        </div>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const forms = document.querySelectorAll('.update-product-form');

                forms.forEach(form => {
                    form.addEventListener('submit', function (e) {
                        const quantity = parseInt(this.querySelector('input[name="quantity"]').value);
                        const price = parseFloat(this.querySelector('input[name="price"]').value);
                        const errorDiv = this.querySelector('.alert-danger');

                        if (quantity <= 0 || price <= 0) {
                            e.preventDefault();
                            errorDiv.textContent = 'Quantity and price must be greater than 0';
                            errorDiv.classList.remove('d-none');
                        } else {
                            errorDiv.classList.add('d-none');
                        }
                    });
                });
            });
        </script>
    </body>


</html>