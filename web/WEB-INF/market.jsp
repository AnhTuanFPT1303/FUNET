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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <header id="header">
            <!-- navbar trên -->
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

                    <div class="nav-icons d-flex align-items-center">
                        <a href="#" class="fa-solid fa-store fa-lg me-3"></a>
                        <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                            <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor"><path d="M.5 12c0 6.351 5.149 11.5 11.5 11.5S23.5 18.351 23.5 12 18.351.5 12 .5.5 5.649.5 12zm2 0c0-.682.072-1.348.209-1.99a2 2 0 0 1 0 3.98A9.539 9.539 0 0 1 2.5 12zm.84-3.912A9.502 9.502 0 0 1 12 2.5a9.502 9.502 0 0 1 8.66 5.588 4.001 4.001 0 0 0 0 7.824 9.514 9.514 0 0 1-1.755 2.613A5.002 5.002 0 0 0 14 14.5h-4a5.002 5.002 0 0 0-4.905 4.025 9.515 9.515 0 0 1-1.755-2.613 4.001 4.001 0 0 0 0-7.824zM12 5a4 4 0 1 1 0 8 4 4 0 0 1 0-8zm-2 4a2 2 0 1 0 4 0 2 2 0 0 0-4 0zm11.291 1.01a9.538 9.538 0 0 1 0 3.98 2 2 0 0 1 0-3.98zM16.99 20.087A9.455 9.455 0 0 1 12 21.5c-1.83 0-3.54-.517-4.99-1.414a1.004 1.004 0 0 1-.01-.148V19.5a3 3 0 0 1 3-3h4a3 3 0 0 1 3 3v.438a1 1 0 0 1-.01.148z"></path></svg>
                        </a>
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

                    <form class="d-flex mb-3">
                        <input class="form-control me-2" type="search" placeholder="Find product" aria-label="Search">
                        <button class="btn btn-outline-primary" type="submit">Search</button>
                    </form>
                    <div class="btn-group-vertical w-100 mb-3">
                        <a href="/FUNET/home" class="btn btn-outline-primary mb-2">Main Page</a>
                        <a href="/FUNET/notificationServlet" class="btn btn-outline-primary mb-2">Notifications</a>
                        <a href="/FUNET/AddProductServlet" class="btn btn-outline-primary mb-2">Add product to market</a>
                        <a href="/FUNET/SellingProductServlet" class="btn btn-outline-primary mb-2">Yours products</a>
                    </div>

                    <div class="accordion" id="accordionCategories">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    Navigation
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionCategories">
                                <div class="accordion-body">
                                    <ul class="list-group">
                                        <li class="btn btn-outline-secondary mb-2"><a href="/FUNET/marketLink" class="text-decoration-none">Market Place</a></li>
                                        <li class="btn btn-outline-secondary mb-2"><a href="/FUNET/lmaterialLink" class="text-decoration-none">Learning Material</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </nav>
                <main class="main-class col-10">
                    <h2 class="mt-4 mb-5 text-primary d-flex justify-content-center">Product today</h2>
                    <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-3 mb-3">
                                <div class="product-card border" style="border: 2px solid black; padding: 10px; text-align: center;">
                                    <h5>${product.productName}</h5>
                                    <img src="${product.product_img}" alt="Item 1" class="img-fluid" style="max-width: 100%; height: auto;">
                                    <p>Price: ${product.price}</p>
                                    <button class="btn btn-primary">Contact to seller</button>
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
