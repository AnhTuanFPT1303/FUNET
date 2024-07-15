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
    </head>
    <body>
        <div class="content-body">
            <div class="nav-bar">
                <header id="header">
                    <nav class="navbar custom-navbar">
                        <div class="container-fluid d-flex align-items-center">
                            <a class="navbar-brand text-primary" href="/blahproject/home" style="font-weight: bold">BLAH</a>
                            <form class="d-flex ms-2 flex-grow-1" method="get" action="/blahproject/searchServlet">
                                <input class="form-control" name="search-name" type="search" placeholder="Finding in BLAH" aria-label="Search">
                                <input type="submit" value="Submit">
                            </form>
                            <form method="post" action="/blahproject/logout">
                                <button type="submit" class="navbar-brand text-primary log-out" onclick="closeSocket()" style="font-weight: bold">Log out</button>
                            </form>
                        </div>
                    </nav>
                </header>
            </div>
            <div class="container-fluid chat-content">
                <div class="left-section col-3">
                    <main>
                        <h1 class="mt-3 text-primary home-logo">Friend</h1>
                        <hr>
                        <c:forEach var="friend" items="${friends}">
                            <div class="post mb-4 d-flex align-items-center" style="overflow-wrap: break-word">
                                <a href="#" class="user-link friend" data-user-id="${friend.user_id}">
                                    <img src="assets/profile_avt/${friend.profile_pic}" alt="avatar picture" class="img-thumbnail mr-3" style="width: 50px; height: 50px; object-fit: cover;">
                                </a>
                                <a href="#" class="user-link friend-name" data-user-id="${friend.user_id}" style="margin-left: 5px">${friend.first_name} ${friend.last_name}</a>
                            </div>
                        </c:forEach>
                    </main>
                </div>
                <div class="right-section col-9">
                    <div id="message-container">
                        <!-- Messages will be dynamically loaded here -->
                    </div>
                    <form id="message-form" class="d-flex mt-3">
                        <input type="text" id="message-input" class="form-control me-2" placeholder="Type your message...">
                        <button type="submit" class="btn btn-primary">Send</button>
                    </form>
                </div>
            </div>
        </div>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery-3.7.1.min.js"></script>
        <script>
            var socket;
            var currentChatUserId;

            window.onload = function () {
                connectSessionUserSocket();
            };

            function connectSessionUserSocket() {
                var sessionId = '<%= session.getAttribute("user_id") %>';
                socket = new WebSocket('ws://' + 'localhost:80/blahproject/chat/' + sessionId);

                socket.onopen = function () {
                    console.log('WebSocket connection opened for session user');
                };

                socket.onmessage = function (event) {
                    var content = JSON.parse(event.data);
                    displayMessage(content);
                    console.log('Message received: ', content);
                };

                socket.onclose = function (event) {
                    console.log('WebSocket connection closed unexpectedly. Reconnecting...');
                    setTimeout(connectSessionUserSocket, 2000); // Example: retry after 2 seconds
                };

                socket.onerror = function (error) {
                    console.error('WebSocket error:', error);
                };
            }

            $(document).on('click', '.user-link', function (e) {
                e.preventDefault();
                $('.user-link').removeClass('active');
                $(this).addClass('active');
                currentChatUserId = $(this).data('user-id');
                loadMessages(currentChatUserId);
            });

            function displayMessage(content) {
                var messageContainer = document.getElementById('message-container');
                var newMessage = document.createElement('div');
                newMessage.className = content.fromUser === '<%= session.getAttribute("user_id") %>' ? 'my-message' : 'received-message';
                newMessage.textContent = content.fromUser + ': ' + content.message;
                messageContainer.appendChild(newMessage);
            }

            function loadMessages(currentChatUserId) {
                $.ajax({
                    url: '/blahproject/MessageServlet',
                    type: 'GET',
                    data: {
                        userId: currentChatUserId
                    },
                    success: function (messages) {
                        var messageContainer = $('#message-container');
                        messageContainer.empty();
                        messages.forEach(function (message) {
                            var messageClass = message.fromUser === '<%= session.getAttribute("user_id") %>' ? 'my-message' : 'received-message';
                            messageContainer.append('<div class="' + messageClass + '">' + message.message + '</div>');
                        });
                    },
                    error: function () {
                        alert('Failed to load messages.');
                    }
                });
            }

            $('#message-form').on('submit', function (e) {
                e.preventDefault();
                var messageInput = $('#message-input').val();
                if (messageInput !== '') {
                    var message = {
                        fromUser: '<%= session.getAttribute("user_id") %>',
                        toUser: $('.user-link.active').data('user-id'),
                        content: messageInput
                    };

                    $('#message-container').append('<div class="my-message">' + messageInput + '</div>');
                    // Send message via WebSocket
                    socket.send(JSON.stringify(message));

                    // Save message to database via AJAX
                    $.ajax({
                        url: '/blahproject/MessageServlet',
                        type: 'POST',
                        data: {
                            fromUser: message.fromUser,
                            toUser: message.toUser,
                            message: message.content
                        },
                        success: function () {
                            console.log('Message saved successfully.');
                        },
                        error: function () {
                            alert('Failed to save message.');
                        }
                    });

                    // Clear the input field
                    $('#message-input').val('');
                } else if (socket.readyState !== WebSocket.OPEN) {
                    connectSessionUserSocket();
                }
            });
        </script>
    </body>
</html>
