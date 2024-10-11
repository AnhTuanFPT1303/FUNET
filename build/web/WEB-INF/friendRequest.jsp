<%-- 
    Document   : friendRequest
    Created on : Jul 7, 2024, 1:13:02 AM
    Author     : HELLO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <header id="header">
            <nav class="navbar custom-navbar">
                <div class="container-fluid d-flex align-items-center">
                    <a class="navbar-brand text-primary" href="/FUNET/home" style="font-weight: bold">FUNET</a>
                    <form class="d-flex ms-2 flex-grow-1" method="get" action="/FUNET/searchServlet">
                        <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search">
                        <button type="submit" class="search-button">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    <div class="nav-icons d-flex align-items-center">
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
                        <form style="margin-left: auto;" action="friendRequestServlet" method="post" style="display:inline;">
                            <input type="hidden" name="userRequest" value="${splitRequest[0]}">
                            <button class="btn btn-primary btn-sm response-request" onclick="ajaxInviteResponse(this)" data-user-id="${splitRequest[0]}" data-action="acceptFriend" type="button">Accept</button>
                            <button class="btn btn-secondary btn-sm response-request" onclick="ajaxInviteResponse(this)" data-user-id="${splitRequest[0]}" data-action="rejectFriend" type="button">Reject</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
        <script src="assets/js/ajaxInviteFriend.js"></script>   
    </body>
</html>
