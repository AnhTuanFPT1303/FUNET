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

                    <div class="nav-icons d-flex align-items-center justify-content-between">
                        <a href="/FUNET/lmaterialLink" class="lm-icon fa-solid fa-book fa-lg me-3">
                        </a>
                        <a href="/FUNET/marketLink" class="market-icon fa-solid fa-store fa-lg me-3"></a>
                        <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                            <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor" class="x19dipnz x1lliihq x1tzjh5l x1k90msu x2h7rmj x1qfuztq" style="--color:var(--secondary-icon)"><path d="M.5 12c0 6.351 5.149 11.5 11.5 11.5S23.5 18.351 23.5 12 18.351.5 12 .5.5 5.649.5 12zm2 0c0-.682.072-1.348.209-1.99a2 2 0 0 1 0 3.98A9.539 9.539 0 0 1 2.5 12zm.84-3.912A9.502 9.502 0 0 1 12 2.5a9.502 9.502 0 0 1 8.66 5.588 4.001 4.001 0 0 0 0 7.824 9.514 9.514 0 0 1-1.755 2.613A5.002 5.002 0 0 0 14 14.5h-4a5.002 5.002 0 0 0-4.905 4.025 9.515 9.515 0 0 1-1.755-2.613 4.001 4.001 0 0 0 0-7.824zM12 5a4 4 0 1 1 0 8 4 4 0 0 1 0-8zm-2 4a2 2 0 1 0 4 0 2 2 0 0 0-4 0zm11.291 1.01a9.538 9.538 0 0 1 0 3.98 2 2 0 0 1 0-3.98zM16.99 20.087A9.455 9.455 0 0 1 12 21.5c-1.83 0-3.54-.517-4.99-1.414a1.004 1.004 0 0 1-.01-.148V19.5a3 3 0 0 1 3-3h4a3 3 0 0 1 3 3v.438a1 1 0 0 1-.01.148z"></path></svg>
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
                        <a href="/FUNET/home" class="btn btn-outline-primary mb-2">Main Page</a>
                        <a href="/FUNET/notificationServlet" class="btn btn-outline-primary mb-2">Notifications</a>
                        <a href="/FUNET/AddProductServlet" class="btn btn-outline-primary mb-2">Add product to market</a>
                        <a href="/FUNET/SellingProductServlet" class="btn btn-outline-primary mb-2">Yours products</a>
                    </div>
                </nav>

                <main class="main-class col-10">

                    <h2 class="mt-4 mb-5 text-primary d-flex justify-content-center">Your Product</h2>
                    <h5 class="text-danger text-center mt-3">${error}</h5>
                    <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-3 mb-3">
                                <div class="product-card border" style="border: 2px solid black; padding: 10px; text-align: center;">
                                    <h5>${product.productName}</h5>
                                    <img src="${product.product_img}" alt="Item 1" class="img-fluid" style="max-width: 100%;">
                                    <p>Price: ${product.price}</p>
                                    <form method="post" action="/FUNET/DeleteProductServlet">
                                        <input type="hidden" name="product_id" value="${product.productId}" />
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <footer
                        class="text-center text-lg-start text-white"
                        style="background-color: #1c2331"
                        >
                        <!-- Section: Social media -->
                        <section
                            class="d-flex justify-content-between p-4"
                            style="background-color: #6351ce"
                            >
                            <!-- Left -->
                            <div class="me-5">
                                <span>Get connected with us on social networks:</span>
                            </div>
                            <!-- Left -->

                            <!-- Right -->
                            <div>
                                <a href="" class="text-white me-4">
                                    <i class="fab fa-facebook-f"></i>
                                </a>
                                <a href="" class="text-white me-4">
                                    <i class="fab fa-twitter"></i>
                                </a>
                                <a href="" class="text-white me-4">
                                    <i class="fab fa-google"></i>
                                </a>
                                <a href="" class="text-white me-4">
                                    <i class="fab fa-instagram"></i>
                                </a>
                                <a href="" class="text-white me-4">
                                    <i class="fab fa-linkedin"></i>
                                </a>
                                <a href="" class="text-white me-4">
                                    <i class="fab fa-github"></i>
                                </a>
                            </div>
                            <!-- Right -->
                        </section>
                        <!-- Section: Social media -->

                        <!-- Section: Links  -->
                        <section class="">
                            <div class="container text-center text-md-start mt-5">
                                <!-- Grid row -->
                                <div class="row mt-3">
                                    <!-- Grid column -->
                                    <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                                        <!-- Content -->
                                        <h6 class="text-uppercase fw-bold">Company name</h6>
                                        <hr
                                            class="mb-4 mt-0 d-inline-block mx-auto"
                                            style="width: 60px; background-color: #7c4dff; height: 2px"
                                            />
                                        <p>
                                            Here you can use rows and columns to organize your footer
                                            content. Lorem ipsum dolor sit amet, consectetur adipisicing
                                            elit.
                                        </p>
                                    </div>
                                    <!-- Grid column -->

                                    <!-- Grid column -->
                                    <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                                        <!-- Links -->
                                        <h6 class="text-uppercase fw-bold">Products</h6>
                                        <hr
                                            class="mb-4 mt-0 d-inline-block mx-auto"
                                            style="width: 60px; background-color: #7c4dff; height: 2px"
                                            />
                                        <p>
                                            <a href="#!" class="text-white">MDBootstrap</a>
                                        </p>
                                        <p>
                                            <a href="#!" class="text-white">MDWordPress</a>
                                        </p>
                                        <p>
                                            <a href="#!" class="text-white">BrandFlow</a>
                                        </p>
                                        <p>
                                            <a href="#!" class="text-white">Bootstrap Angular</a>
                                        </p>
                                    </div>
                                    <!-- Grid column -->

                                    <!-- Grid column -->
                                    <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                                        <!-- Links -->
                                        <h6 class="text-uppercase fw-bold">Useful links</h6>
                                        <hr
                                            class="mb-4 mt-0 d-inline-block mx-auto"
                                            style="width: 60px; background-color: #7c4dff; height: 2px"
                                            />
                                        <p>
                                            <a href="#!" class="text-white">Your Account</a>
                                        </p>
                                        <p>
                                            <a href="#!" class="text-white">Become an Affiliate</a>
                                        </p>
                                        <p>
                                            <a href="#!" class="text-white">Shipping Rates</a>
                                        </p>
                                        <p>
                                            <a href="#!" class="text-white">Help</a>
                                        </p>
                                    </div>
                                    <!-- Grid column -->

                                    <!-- Grid column -->
                                    <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                                        <!-- Links -->
                                        <h6 class="text-uppercase fw-bold">Contact</h6>
                                        <hr
                                            class="mb-4 mt-0 d-inline-block mx-auto"
                                            style="width: 60px; background-color: #7c4dff; height: 2px"
                                            />
                                        <p><i class="fas fa-home mr-3"></i> New York, NY 10012, US</p>
                                        <p><i class="fas fa-envelope mr-3"></i> info@example.com</p>
                                        <p><i class="fas fa-phone mr-3"></i> + 01 234 567 88</p>
                                        <p><i class="fas fa-print mr-3"></i> + 01 234 567 89</p>
                                    </div>
                                    <!-- Grid column -->
                                </div>
                                <!-- Grid row -->
                            </div>
                        </section>
                        <!-- Section: Links  -->

                        <!-- Copyright -->
                        <div
                            class="text-center p-3"
                            style="background-color: rgba(0, 0, 0, 0.2)"
                            >
                            © 2020 Copyright:
                            <a class="text-white" href="https://mdbootstrap.com/"
                               >MDBootstrap.com</a
                            >
                        </div>
                        <!-- Copyright -->
                    </footer>
                </main>
            </div>

        </div>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>


</html>