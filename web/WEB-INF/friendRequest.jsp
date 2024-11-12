<%-- 
    Document   : friendRequest
    Created on : Jul 7, 2024, 1:13:02 AM
    Author     : HELLO
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Friend Request</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/friendRequest.css">
        <link rel="stylesheet" href="assets/css/logonavbar.css">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>

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

    <div class="friend-request-page">
        <div class="friend-requests-container">
            <h2>Pending Friend Requests</h2>
            <c:forEach var="friendRequest" items="${pendingList}">
                <div class="friend-request-card">
                    <c:set var="splitRequest" value="${fn:split(friendRequest, '.')}"/>
                    <div class="user-info">
                        <img src="assets/profile_avt/${splitRequest[3]}.${splitRequest[4]}" alt="User Avatar" class="user-avatar">
                        <p class="user-name">${splitRequest[1]} ${splitRequest[2]}</p>
                    </div>
                    <div class="action-buttons">
                        <form action="friendRequestServlet" method="post">
                            <input type="hidden" name="userRequest" value="${splitRequest[0]}">
                            <button class="accept-btn" onclick="ajaxInviteResponse(this)" data-user-id="${splitRequest[0]}" data-action="acceptFriend" type="button">Accept</button>
                            <button class="reject-btn" onclick="ajaxInviteResponse(this)" data-user-id="${splitRequest[0]}" data-action="rejectFriend" type="button">Reject</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="friend-requests-container">
            <h2>All Friends</h2>
            <c:forEach var="friend" items="${friends}">
                <div class="friend-card">
                    <div class="user-info">
                        <img src="assets/profile_avt/${friend.profilePic}" alt="User Avatar" class="user-avatar">
                        <p class="user-name">${friend.firstName} ${friend.lastName}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script> 
    <script src="assets/js/ajaxInviteFriend.js"></script> 
    <script src="assets/js/logonavbar.js"></script>   
</body>
</html>
