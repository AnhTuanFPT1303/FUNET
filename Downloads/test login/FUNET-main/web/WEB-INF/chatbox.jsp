<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Message, dao.MessageDao, model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <meta charset="UTF-8">
        <title>Chatbox</title>
        <link rel="stylesheet" href="assets/css/chat.css">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/home.css">
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
        <div class="content-body">
            <div hidden id="user-info" data-session-id="<%= session.getAttribute("user_id") %>"></div>
            <div class="container-fluid chat-content">
                <div class="left-section col-3">
                    <main>
                        <h1 class="mt-3 text-primary home-logo">Friend</h1>
                        <hr>
                        <c:forEach var="friend" items="${friends}">
                            <div class="post mb-4 d-flex align-items-center" style="overflow-wrap: break-word">
                                <a href="#" class="user-link friend" data-user-id="${friend.user_id}" onclick="conversationInit.call(this)">
                                    <img src="assets/profile_avt/${friend.profile_pic}" alt="avatar picture" class="img-thumbnail mr-3" style="width: 50px; height: 50px; object-fit: cover;">
                                </a>
                                <a href="#" class="user-link friend-name" data-user-id="${friend.user_id}" style="margin-left: 5px" onclick="conversationInit.call(this)">${friend.first_name} ${friend.last_name}</a>
                            </div>
                        </c:forEach>
                        <div id="chat-container" style="display:none;">
                            <div id="message-container" style="max-height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
                            </div>
                            <form id="message-form" style="margin-top: 10px;">
                                <input type="text" id="message-input" placeholder="Type your message..." required style="width: 80%;">
                                <button type="submit">Send</button>
                            </form>
                        </div>
                    </main>
                </div>
            </div>
        </div>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery-3.7.1.min.js"></script>
        <script src="assets/js/websocketChat.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>   
    </body>
</html>
