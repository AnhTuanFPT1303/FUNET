<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search Result</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="assets/css/logonavbar.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%; color: black">FUNET</div>
            </a>
            <form class="" method="get" action="/FUNET/searchServlet" id="searchForm">
                <div class="search-bar" style="margin-left: 15px">
                    <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input">

                </div>
            </form>
            <div class="center-buttons">
                <a href="home">
                    <button class="center-button" id="home-btn">
                        <box-icon type='solid' name='home'></box-icon>
                    </button>
                </a>
                <a href="video">
                    <button class="center-button" id="video-btn">
                        <box-icon name='school' type='solid'></box-icon>
                    </button>
                </a>
                <a href="market">
                    <button class="center-button" id="market-btn">
                        <box-icon name='store-alt' type='solid'></box-icon>
                    </button>
                </a>
                <a href="/FUNET/friendRequestServlet" class="friend-icon me-3">
                    <button class="center-button" id="friend-btn">
                        <box-icon name='group' type='solid'></box-icon>
                    </button>
                </a>
            </div>
            <div class="right-icons">
                <a href="/FUNET/chat" class="mess-icon" style='margin-left:5px'>
                    <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo'></box-icon></span>
                </a>
                <span class="icon icon-circle" id="notification-btn"><box-icon name='bell' type='solid' ></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
            </div>

        </div>

        <div class="dropdown-menu" id="notification-menu">
            <p>Notification content goes here...</p>
        </div>
    </div>
    <div class="dropdown-menu" id="notification-menu">
        <p>Notification content goes here...</p>
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

    <div class="container-fluid">
        <div class="row all-post">
            <nav class="col-2 py-3">

            </nav>

            <main class="col-8">
                <h1 class="mt-3 text-primary home-logo">Search Result</h1>
                <hr>
                <c:forEach var="userResult" items="${usersWithStatus}">
                    <c:set var="userSearched" value="${userResult.key}" />
                    <c:set var="userStatus" value="${userResult.value}" />
                    <div class="post mb-4 d-flex align-items-center" style="overflow-wrap: break-word">
                        <a href="profile?userId=${userSearched.user_id}">
                            <img src="assets/profile_avt/${userSearched.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px;">
                        </a>
                        <a href="profile?userId=${userSearched.user_id}" style="margin-left: 5px">${userSearched.first_name} ${userSearched.last_name}</a>
                        <c:choose>
                            <c:when test="${userStatus == 'pending'}">
                                <button class="btn btn-secondary btn-sm" style="margin-left: auto;" disabled>Invited</button>
                            </c:when>
                            <c:when test="${userStatus == 'accepted'}">
                                <button class="btn btn-secondary btn-sm" style="margin-left: auto;" disabled>Friend</button>
                            </c:when>
                            <c:when test="${userStatus == 'reverse_pending'}">
                                <form style="margin-left: auto;" action="friendRequestServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="userRequest" value="${userSearched.user_id}">
                                    <button class="btn btn-primary btn-sm response-request" onclick="ajaxInviteResponse(this)" data-user-id="${userSearched.user_id}" data-action="acceptFriend" type="button">Accept</button>
                                    <button class="btn btn-primary btn-sm response-request" onclick="ajaxInviteResponse(this)" data-user-id="${userSearched.user_id}" data-action="rejectFriend" type="button">Reject</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-primary btn-sm invite-friend" onclick="ajaxInviteSend(this)" data-user-id="${userSearched.user_id}" style="margin-left: auto;">Add Friend</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <hr>
                </c:forEach>

            </main>

            <aside class="col-2 py-3 friend-list">
            </aside>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="assets/js/jquery-3.7.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/ajaxInviteFriend.js"></script>
    <script src="assets/js/logonavbar.js"></script>

</body>
</html>
