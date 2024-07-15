<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search Result</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/search.css">
    </head>
    <body>
        <header id="header">
            <nav class="navbar custom-navbar">
                <div class="container-fluid d-flex align-items-center">
                    <a class="navbar-brand text-primary" href="/blahproject/home" style="font-weight: bold">BLAH</a>
                    <form class="d-flex ms-2 flex-grow-1" method="get" action="/blahproject/searchServlet">
                        <input class="form-control" name="search-name" type="search" placeholder="Finding in BLAH" aria-label="Search">
                        <input type="submit" value="Submit">
                    </form>
                    <form method="post" action="/blahproject/logout">
                        <button type="submit" class="navbar-brand text-primary log-out" style="font-weight: bold">Log out</button>
                    </form>
                </div>
            </nav>
        </header>
        <div class="container-fluid">
            <div class="row all-post">
                <nav class="col-2 py-3 bg-light">
                    <div class="profile-section mb-3 d-flex align-items-center">
                        <a href="userpageServlet" class="d-flex align-items-center text-decoration-none text-dark">
                            <img src="assets/profile_avt/${user.profile_pic}" class="img-fluid rounded-circle avatar">
                            <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                        </a>
                    </div>
                    <div class="chat-box mb-3">
                        <h5>Chat box</h5>   
                    </div>
                </nav>

                <main class="col-8">
                    <h1 class="mt-3 text-primary home-logo">Search Result</h1>
                    <hr>
                    <c:forEach var="userResult" items="${usersWithStatus}">
                        <c:set var="userSearched" value="${userResult.key}" />
                        <c:set var="userStatus" value="${userResult.value}" />
                        <div class="post mb-4 d-flex align-items-center" style="overflow-wrap: break-word">
                            <a href="userpageServlet?userId=${userSearched.user_id}">
                                <img src="assets/profile_avt/${userSearched.profile_pic}" class="img-fluid rounded-circle avatar me-2" style="width: 30px; height: 30px;">
                            </a>
                            <a href="userpageServlet?userId=${userSearched.user_id}" style="margin-left: 5px">${userSearched.first_name} ${userSearched.last_name}</a>
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

                <aside class="col-2 py-3 bg-light friend-list">
                    <h2>List Friends</h2>
                    <ul class="list-group">
                        <li class="list-group-item">Friend 1</li>
                        <li class="list-group-item">Friend 2</li>
                        <li class="list-group-item">Friend 3</li>
                    </ul>
                </aside>
            </div>
        </div>
        <script src="assets/js/jquery-3.7.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/ajaxInviteFriend.js"></script>
    </body>
</html>
