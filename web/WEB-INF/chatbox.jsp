<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Message, dao.MessageDao, model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <meta charset="UTF-8">
        <title>Messenger</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/test.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <p id="first_name" style="display: none">${sessionScope.user['first_name']}</p>
        <p id="last_name" style="display: none">${sessionScope.user['last_name']}</p>
        <p id="user_id" style="display: none">${sessionScope.user['user_id']}</p>
        <p id="userAvatar" style="display: none">assets/profile_avt/${sessionScope.user['profile_pic']}</p>
        <div class="container">
            <div class="conversation-container">
                <div class="modal-box border" id="settings">
                    <div class="modal-box-head">
                        <div class="modal-box-title">
                            Group Settings
                        </div>
                        <div class="modal-box-close toggle-btn" data-id="add-user" onclick="toggleModal(this, false)">
                            <i class="fa fa-times"></i>
                        </div>
                    </div>
                    <div class="modal-box-body">
                        <div data-id="manage-user" onclick="toggleModal(this, true)">
                            <h2>Groups Member</h2>
                        </div>
                        <div data-id="change-name" onclick="toggleModal(this, true)">
                            <h2>Change Group Name</h2>
                        </div>
                        <label style="cursor: pointer; display: inline-block;">
                            <input type="file" style="display: none;" accept="image/*" onchange="uploadGroupAvatar(this)" />
                            <h2>Change Group Avatar</h2>
                        </label>
                    </div>
                </div>
                <div class="modal-box border" id="change-name">
                    <div class="modal-box-head">
                        <div class="modal-box-title">
                            Change Group Name
                        </div>
                        <div class="modal-box-close toggle-btn" data-id="add-group" onclick="toggleModal(this, false)">
                            <i class="fa fa-times"></i>
                        </div>
                    </div>
                    <hr>
                    <form action="" onsubmit="changeGroupName(event)">
                        <div class="modal-box-body">
                            <input type="text" class="txt-input txt-new-group-name" placeholder="Group Name...">
                        </div>		
                        <button type="submit" class="btn">Save</button>		
                    </form>
                </div>
                <div class="modal-box border" id="add-group">
                    <div class="modal-box-head">
                        <div class="modal-box-title">
                            Add Group
                        </div>
                        <div class="modal-box-close toggle-btn" data-id="add-group" onclick="toggleModal(this, false)">
                            <i class="fa fa-times"></i>
                        </div>
                    </div>
                    <hr>
                    <form action="" onsubmit="createGroup(event)">
                        <div class="modal-box-body">
                            <input type="text" class="txt-input txt-group-name" placeholder="Group Name...">
                        </div>		
                        <button type="submit" class="btn">Create Group</button>		
                    </form>
                </div>

                <div class="modal-box border" id="add-user">
                    <div class="modal-box-head">
                        <div class="modal-box-title">
                            Add Member
                        </div>
                        <div class="modal-box-close toggle-btn" data-id="add-user" onclick="toggleModal(this, false)">
                            <i class="fa fa-times"></i>
                        </div>
                    </div>
                    <hr>
                    <form action="" onsubmit="return addMember(event);">
                        <div class="modal-box-body add-member-body">
                            <input type="text" class="txt-input txt-group-name" placeholder="Name of member..." onkeyup="searchMemberByKeyword(this)">

                            <div class="list-user">
                                <ul>
                                </ul>
                            </div>
                        </div>		
                        <button type="submit" class="btn">Add Members</button>		
                    </form>
                </div>

                <div class="modal-box border" id="manage-user">
                    <div class="modal-box-head">
                        <div class="modal-box-title">
                            All Member Of Group
                        </div>
                        <div class="modal-box-close toggle-btn" data-id="manage-user" onclick="toggleModal(this, false)">
                            <i class="fa fa-times"></i>
                        </div>
                    </div>
                    <hr>
                    <div class="modal-box-body manage-member-body">
                        <div class="list-user">
                            <ul>
                            </ul>
                        </div>
                    </div>	
                </div>

                <div class="left-side active">
                    <div class="add-group border toggle-btn" data-id="add-group" onclick="toggleModal(this, true)"><i class="fa fa-plus-circle"></i></div>
                    <h2>
                        Chats
                    </h2>
                    <div class="tab-control">
                        <i class="fa fa-comment active" onclick="chatOne(this)"></i>
                        <i class="fa fa-comments" onclick="chatGroup(this)"></i>
                    </div>
                    <div class="list-user-search">
                        <input type="text" class="txt-input" data-type="user" placeholder="Search..." onkeyup="searchUser(this)">
                    </div>
                    <div class="list-user">
                        <ul style="padding-left:0px;">
                            <c:forEach var="friend" items="${friends}">
                                <li id="${friend.user_id}" onclick="setReceiver(this)" data-name="${friend.first_name} ${friend.last_name}">
                                    <div class="user-contain">
                                        <div class="user-img">
                                            <img id="img-${friend.user_id}" src="assets/profile_avt/${friend.profile_pic}" alt="Image of user">
                                            <div id="status-${friend.user_id}" class="user-img-dot"></div>
                                        </div>
                                        <div class="user-info"> 
                                            <span class="user-name">${friend.first_name} ${friend.last_name}</span>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="right-side" id="receiver"></div>
            </div>
        </div>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery-3.7.1.min.js"></script>
        <script src="assets/js/chatbox.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>   
    </body>
</html>
