var user_id = parseInt(document.getElementById("user_id").textContent);
var websocket = null;
var receiver = null;
var userAvatar = document.getElementById("userAvatar").textContent;
var receiverAvatar = null;
var first_name = document.getElementById("first_name").textContent;
var last_name = document.getElementById("last_name").textContent;

var typeChat = "user";
var groupName = null;
var groupId = null

var back = null;
var rightSide = null;
var leftSide = null;
var conversation = null;

var attachFile = null;
var imageFile = null;
var file = null;
var listFile = [];
var typeFile = "image";
var deleteAttach = null;
var listUserAdd = [];
var listUserDelete = [];
var numberMember = 0;

window.onload = function () {
    if ("WebSocket" in window) {
        websocket = new WebSocket('ws://' + window.location.host + '/FUNET/chat/' + user_id);
        websocket.onopen = function () {
        };

        websocket.onmessage = function (data) {
            setMessage(JSON.parse(data.data));
        };

        websocket.onerror = function () {
            console.log('An error occured, closing application');
            cleanUp();
        };

        websocket.onclose = function (data) {
            console.log(data.reason);
            cleanUp();
        };
    } else {
        console.log("Websockets not supported");
    }
};

function cleanUp() {
    user_id = null;
    websocket = null;
    receiver = null;
}

function displayFiles() {
    attachFile = document.getElementById("attach");
    imageFile = document.getElementById("image");
    file = document.querySelector(".list-file");
    deleteAttach = document.querySelectorAll(".delete-attach");

    attachFile.addEventListener("change", function (e) {
        let filesInput = e.target.files;

        for (const file of filesInput) {
            listFile.push(file);
        }

        typeFile = "file";
        renderFile("attach");

        this.value = null;
    });

    imageFile.addEventListener("change", function (e) {
        let filesImage = e.target.files;

        for (const file of filesImage) {
            listFile.push(file);
        }

        typeFile = "image";

        renderFile("image");

        this.value = null;
    });
}

function deleteFile(idx) {
    if (!isNaN(idx))
        listFile.splice(idx, 1);

    renderFile(typeFile);
}

function renderFile(typeFile) {
    let listFileHTML = "";
    let idx = 0;

    if (typeFile == "image") {
        for (const file of listFile) {
            listFileHTML += '<li><img src="' + URL.createObjectURL(file)
                    + '" alt="Image file"><span data-idx="'
                    + (idx) + '" onclick="deleteFile('
                    + idx + ')" class="delete-attach">X</span></li>';
            idx++;
        }
    } else {
        for (const file of listFile) {
            listFileHTML += '<li><div class="file-input">' + file.name
                    + '</div><span data-idx="'
                    + (idx) + '" onclick="deleteFile('
                    + idx + ')" class="delete-attach">X</span></li>';
            idx++;
        }
    }


    if (listFile.length == 0) {
        file.innerHTML = "";
        file.classList.remove("active");
    } else {
        file.innerHTML = listFileHTML;
        file.classList.add("active");
    }

    deleteAttach = document.querySelectorAll(".delete-attach");
}

function setReceiver(element) {
    groupId = null;
    receiver = element.id;
    receiverName = element.getAttribute('data-name');
    receiverAvatar = document.getElementById('img-' + receiver).src;
    var status = '';
    if (document.getElementById('status-' + receiver).classList.contains('online')) {
        status = 'online';
    }
    var rightSide = '<div class="user-contact">' + '<div class="back">'
            + '<i class="fa fa-arrow-left"></i>'
            + '</div>'
            + '<div class="user-contain">'
            + '<div class="user-img">'
            + '<img src="' + receiverAvatar + '" '
            + 'alt="Image of user">'
            + '<div class="user-img-dot ' + status + '"></div>'
            + '</div>'
            + '<div class="user-info">'
            + '<span class="user-name">' + receiverName + '</span>'
            + '</div>'
            + '</div>'
            + '<div class="setting">'
            + '<i class="fa fa-cog"></i>'
            + '</div>'
            + '</div>'
            + '<div class="list-messages-contain">'
            + '<ul id="chat" class="list-messages">'
            + '</ul>'
            + '</div>'
            + '<form class="form-send-message" onsubmit="sendMessage(event)">'
            + '<ul class="list-file"></ul> '
            + '<input type="text" id="message" class="txt-input" placeholder="Type message...">'
            + '<label class="btn btn-image" for="attach"><i class="fa fa-file"></i></label>'
            + '<input type="file" multiple id="attach">'
            + '<p id="receiver" style="display:none">' + receiver + '</p>'
            + '<label class="btn btn-image" for="image"><i class="fa fa-image"></i></label>'
            + '<input type="file" accept="image/*" multiple id="image">'
            + '<button type="submit" class="btn btn-send">'
            + '<i class="fa fa-paper-plane"></i>'
            + '</button>'
            + '</form>';

    document.getElementById("receiver").innerHTML = rightSide;

    loadMessages();

    displayFiles();

    handleResponsive();
}

function resetChat() {
    let chatBtn = document.querySelectorAll(".tab-control i");
    let searchTxt = document.querySelector(".list-user-search input");
    let addGroupBtn = document.querySelector(".add-group");

    searchTxt.value = "";

    chatBtn.forEach(function (ele) {
        ele.classList.remove("active");
    });

    if (typeChat == "group") {
        addGroupBtn.classList.add("active");
    } else {
        addGroupBtn.classList.remove("active");
    }
}

function sendMessage(e) {
    e.preventDefault();

    var inputText = document.getElementById("message").value;
    if (inputText != '') {
        sendText();
    } else {
        sendAttachments();
    }
    return false;
}

function sendText() {
    var messageContent = document.getElementById("message").value;

    var messageType = "text";
    document.getElementById("message").value = ''; // Clear input field

    if (messageContent.trim() === '') {
        console.log("Empty message. Not sending.");
        return; // Do not send empty messages
    }
    var message = buildMessageToJson(messageContent, messageType);
    if (websocket.readyState === WebSocket.OPEN) {
        console.log(message.message);
        websocket.send(JSON.stringify(message));
    } else {
        console.log("WebSocket is not open.");
    }
    setMessage(message);
}

function sendAttachments() {
    var messageType = "attachment";
    for (file of listFile) {
        var messageContent = file.name.trim();
        messageType = file.type;
        var message = buildMessageToJson(messageContent, messageType);
        const formData = new FormData();
        formData.append('file', file);
        fetch("http://" + window.location.host + "/FUNET/upload", {
            method: 'POST',
            cache: 'no-cache',
            body: formData // No Content-Type header set
        })
                .then(response => response.json())
                .then(data => {
                    // Check if the upload was successful
                    if (data.url) {
                        console.log(data.url);
                        // Set the message content based on file type and the uploaded URL
                        if (messageType.startsWith("audio")) {
                            message.message = '<audio controls>'
                                    + '<source src="' + data.url + '" type="' + messageType + '">'
                                    + '</audio>';
                        } else if (messageType.startsWith("video")) {
                            message.message = '<video width="400" controls>'
                                    + '<source src="' + data.url + '" type="' + messageType + '">'
                                    + '</video>';
                        } else if (messageType.startsWith("image")) {
                            message.message = '<img src="' + data.url + '" alt="">';
                        } else {
                            // Handle other file types (e.g., documents)
                            message.message = '<a href="' + data.url + '" target="_blank">' + messageContent + '</a>';
                        }
                        setMessage(message);
                        message.message = data.url;
                        // Send the message containing the Cloudinary URL through WebSocket
                        websocket.send(JSON.stringify(message)); // Send the message via WebSocket
                        console.log("Message sent via WebSocket:", message.message);
                        // Optionally, call setMessage(message) if you want to display the message locally as well

                    } else {
                        console.error('Upload failed:', data);
                    }
                })
                .catch(error => {
                    console.error('Error uploading to server:', error);
                });
    }

    // Clear the file input after processing
    var fileElement = document.querySelector(".list-file");
    fileElement.classList.remove("active");
    fileElement.innerHTML = "";
    listFile = [];
}


function buildMessageToJson(message, type) {
    return {
        sender: user_id, // Ensure user_id is globally defined
        receiver: receiver, // Ensure receiver is defined for private chat
        message: message,
        type: type,
        groupId: Number(groupId) // Ensure groupId is defined for group chat
    };
}

function setMessage(msg) {
    var currentChat = document.getElementById('chat');
    if (msg.receiver != 0) {
        var newChatMsg = customLoadMessage(msg.sender, msg.message);
    } else {
        var newChatMsg = customLoadMessageGroup(msg.sender, msg.groupId, msg.message);
    }
    currentChat.innerHTML += newChatMsg;
    goLastestMsg(); // Scroll to latest message
}

function setOnline(user_id, isOnline) {
    let ele = document.getElementById('status-' + user_id);

    if (isOnline === true) {
        ele.classList.add('online');
    } else {
        ele.classList.remove('online');
    }
}

function loadMessages() {
    var currentChatbox = document.getElementById("chat");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var messages = JSON.parse(this.responseText);
            var chatbox = "";
            var imageCount = 0; 
            var loadedImages = 0; 

            messages.forEach(msg => {
                try {
                    var messageHtml = customLoadMessage(msg.sender, msg.message);
                    chatbox += messageHtml;

                    var tempDiv = document.createElement("div");
                    tempDiv.innerHTML = messageHtml;

                    var imgs = tempDiv.getElementsByTagName("img");
                    imageCount += imgs.length;

                    for (let img of imgs) {
                        img.onload = () => {
                            loadedImages++;

                            if (loadedImages === imageCount) {
                                goLastestMsg();
                            }
                        };
                        img.onerror = () => {
                            loadedImages++; 
                            if (loadedImages === imageCount) {
                                goLastestMsg(); 
                            }
                        };
                    }
                } catch (ex) {
                    console.error(ex);
                }
            });

            currentChatbox.innerHTML = chatbox;

            if (imageCount === 0) {
                goLastestMsg();
            }
        }
    };

    xhttp.open("GET", "http://" + window.location.host + "/FUNET/chat-rest-controller?sender=" + user_id + "&receiver=" + receiver, true);
    xhttp.send();
}


function customLoadMessage(sender, message) {
    var imgSrc = receiverAvatar;
    var msgDisplay = '<li>'
            + '<div class="message';
    if (receiver != sender && user_id != sender) {
        return '';
    } else if (receiver == sender) {
        msgDisplay += '">';
    } else {
        imgSrc = userAvatar;
        msgDisplay += ' right">';
    }
    return msgDisplay + '<div class="message-img">'
            + '<img src="' + imgSrc + '" alt="">'
            + ' </div>'
            + '<div class="message-text">' + message + '</div>'
            + '</div>'
            + '</li>';
}

function goLastestMsg() {
    var msgLiTags = document.querySelectorAll(".message");
    var last = msgLiTags[msgLiTags.length - 1];
    try {
        last.scrollIntoView();
    } catch (ex) {
    }
}



//****************************************** GROUP FUNCTION GO HERE ******************************************************


function setGroup(element) {
    receiver = null;
    groupName = element.getAttribute("data-name");
    groupId = element.getAttribute("data-id");

    receiverAvatar = document.getElementById("img-group-" + groupId).src;

    listUserAdd = [];

    numberMember = parseInt(element.getAttribute("data-number"));


    fetch("http://" + window.location.host + "/FUNET/conversations-rest-controller?usersConversationId=" + groupId)
            .then(data => data.json())
            .then(data => {
                let findObject = data.find(element => element.user_id == user_id);
                let isAdmin = findObject.isAdmin;

                var rightSide = '<div class="user-contact">' + '<div class="back">'
                        + '<i class="fa fa-arrow-left"></i>'
                        + '</div>'
                        + '<div class="user-contain">'
                        + '<div class="user-img">'
                        + '<img id="img-group-' + groupId + '" src="' + receiverAvatar + '"'
                        + 'alt="Image of user">'
                        + '</div>'
                        + '<div class="user-info">'
                        + '<a href="http://' + window.location.host + '/FUNET/conversation?conversationId=' + groupId + '" class="user-name">' + groupName + '</a>'
                        + '</div>'
                        + '</div>'
                        + '<div class="invite-user">'
                        + '<span class="total-invite-user">' + numberMember + ' paticipants</span>'
                        + '<span data-id="add-user" onclick="toggleModal(this, true); searchMemberByKeyword(``);" class="invite toggle-btn">Invite</span>'
                        + '</div>'
                        + '<div class="setting toggle-btn" data-id="manage-user" onclick="toggleModal(this, true);  fetchUser();">'
                        + '<i class="fa fa-cog"></i>'
                        + '</div>'
                        + '</div>'
                        + '<div class="list-messages-contain">'
                        + '<ul id="chat" class="list-messages">'
                        + '</ul>'
                        + '</div>'
                        + '<form class="form-send-message" onsubmit="return sendMessage(event)">'
                        + '<ul class="list-file"></ul> '
                        + '<input type="text" id="message" class="txt-input" placeholder="Type message...">'
                        + '<label class="btn btn-image" for="attach"><i class="fa fa-file"></i></label>'
                        + '<input type="file" multiple id="attach">'
                        + '<label class="btn btn-image" for="image"><i class="fa fa-image"></i></label>'
                        + '<input type="file" accept="image/*" multiple id="image">'
                        + '<button type="submit" class="btn btn-send">'
                        + '<i class="fa fa-paper-plane"></i>'
                        + '</button>'
                        + '</form>';

                document.getElementById("receiver").innerHTML = rightSide;

                loadMessagesGroup();

                displayFiles();

                handleResponsive();
            })
            .catch(ex => console.log(ex));
}

function createGroup(e) {
    e.preventDefault();

    let groupName = document.querySelector(".txt-group-name").value;

    let object = new Object();
    let user = new Object();

    user.user_id = user_id;
    user.first_name = first_name;
    user.last_name = last_name;
    user.isAdmin = true;

    object.name = groupName;
    object.users = [];
    object.users.push(user);
    toggleAllModal();

    fetch("http://" + window.location.host + "/FUNET/conversations-rest-controller", {
        method: "post",
        cache: 'no-cache',
        headers: {
            'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify(object)
    })
            .then(function () {
                return fetchGroup();
            });

}

function addMember(e) {
    e.preventDefault();

    let object = new Object();
    object.name = groupName;
    object.id = groupId;
    object.users = [];


    listUserAdd.forEach(function (user_id) {
        let user = new Object();

        user.user_id = user_id;
        user.isAdmin = false;
        user.profile_pic = "1";

        object.users.push(user);
    });


    fetch("http://" + window.location.host + "/FUNET/conversations-rest-controller", {
        method: "post",
        cache: 'no-cache',
        headers: {
            'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify(object)
    })
            .then(function (data) {
                return data.json();
            })
            .then(function (data) {
                numberMember += parseInt(listUserAdd.length);
                listUserAdd = [];
                let inviteNumber = document.querySelector(".total-invite-user");
                if (inviteNumber)
                    inviteNumber.innerHTML = numberMember + " paticipants";

                document.getElementById("group-" + groupId).querySelector(".user-contain").setAttribute("data-number", numberMember);

                toggleAllModal();
            });
}

function fetchUser() {

    fetch("http://" + window.location.host + "/conversations-rest-controller?usersConversationId=" + groupId)
            .then(data => data.json())
            .then(users => {
                document.querySelector(".manage-member-body .list-user ul").innerHTML = "";

                if (users.length == 1) {
                    document.querySelector(".manage-member-body .list-user ul").innerHTML = "No members in group";
                    document.querySelector(".manage-member-body .list-user ul").style = "text-align: center; font-size: 1.8rem;";
                } else {
                    document.querySelector(".manage-member-body .list-user ul").style = "";
                }

                users.forEach(function (data) {
                    if (data.user_id == user_id)
                        return;

                    let appendUser = '<li>'
                            + '<div class="user-contain">'
                            + '<div class="user-img">'
                            + '<img '
                            + ' src="assets/profile_avt/default_avt.jpg"'
                            + 'alt="Image of user">'
                            + '</div>'
                            + '<div class="user-info" style="flex-grow: 1;">'
                            + '<span class="user-name">' + data.username + '</span>'
                            + '</div>';

                    if (!data.admin)
                        appendUser += '<div class="user-delete" style="font-weight: 700;" data-username="' + data.username + '" onclick="deleteMember(this)">Delete</div>'

                    appendUser += '</div></li>';

                    document.querySelector(".manage-member-body .list-user ul").innerHTML += appendUser;
                });

            })
            .catch(ex => console.log(ex));

}

function deleteGroup(ele) {
    let grpId = ele.getAttribute("data-id");

    if (grpId == groupId)
        document.querySelector(".right-side").innerHTML = "";

    let confirmationHTML = `
		<div id="confirmation-popup">
			<h3>Are you sure you want to delete this group?</h3>
			<button id="confirm-yes">Yes</button>
			<button id="confirm-no">No</button>
		</div>
	`;

    // Append the HTML structure to the body
    document.body.insertAdjacentHTML('beforeend', confirmationHTML);

    // Add event listener for the 'Yes' button
    document.getElementById('confirm-yes').addEventListener('click', function () {
        confirmDelete(grpId);
        document.getElementById('confirmation-popup').remove(); // Remove the confirmation popup
    });

    // Add event listener for the 'No' button
    document.getElementById('confirm-no').addEventListener('click', function () {
        document.getElementById('confirmation-popup').remove(); // Just remove the confirmation popup
    });
}

function confirmDelete(grpId) {
    fetch("http://" + window.location.host + "/FUNET/conversations-rest-controller?conversationId=" + grpId, {
        method: 'Delete'
    })
            .then(function (data) {
                return data.json();
            })
            .then(function (data) {

                let groupNumber = document.getElementById("group-" + grpId);
                if (groupNumber)
                    groupNumber.outerHTML = "";

            })
            .catch(ex => console.log(ex));
}

function deleteMember(ele) {
    let username = ele.getAttribute("data-username");

    fetch("http://" + window.location.host + "/conversations-rest-controller?conversationId=" + groupId + "&user_id=" + user_id, {
        method: 'delete'
    })
            .then(function (data) {
                return data.json();
            })
            .then(function (data) {

                numberMember -= 1;

                let inviteNumber = document.querySelector(".total-invite-user");
                if (inviteNumber)
                    inviteNumber.innerHTML = numberMember + " paticipants";

                toggleAllModal();
            })
            .catch(ex => console.log(ex));

}

function toggleAllModal() {
    let modalBox = document.querySelectorAll(".modal-box");

    modalBox.forEach(function (modal) {
        modal.classList.remove("active");
    });

}

function toggleModal(ele, mode) {
    let modalBox = document.querySelectorAll(".modal-box");
    let id = ele.getAttribute("data-id");

    modalBox.forEach(function (modal) {
        modal.classList.remove("active");
    });


    if (mode)
        document.getElementById(id).classList.add("active");
    else
        document.getElementById(id).classList.remove("active");
}

function chatOne(ele) {
    typeChat = "user";
    resetChat();
    ele.classList.add("active");
    searchFriendByKeyword("");
    listFiles = [];
}

function chatGroup(ele) {
    typeChat = "group";
    resetChat();
    ele.classList.add("active");
    fetchGroup();
    listFiles = [];
}

function addUserChange(e) {
    if (e.checked) {
        listUserAdd.push(e.value);
    } else {
        let index = listUserAdd.indexOf(e.value);
        listUserAdd.splice(index, 1);
    }

}

function fetchGroup() {
    console.log(user_id);
    fetch("http://" + window.location.host + "/FUNET/conversations-rest-controller?user_id=" + user_id)
            .then(function (data) {
                return data.json();
            })
            .then(data => {

                document.querySelector(".left-side .list-user").innerHTML = "";
                data.forEach(function (data) {
                    let numberMember = data.users ? data.users.length : 0;
                    let findObject = data.users.find(element => element.user_id == user_id);
                    let isAdmin = findObject.isAdmin;

                    let imgSrc = ' src="assets/group/group1/' + data.avatar + '"';
                    let appendUser = '<li id="group-' + data.id + '">'
                            + '<div class="user-contain" data-id="' + data.id + '" data-number="' + numberMember + '" data-name="' + data.name + '" onclick="setGroup(this);">'
                            + '<div class="user-img">'
                            + '<img id="img-group-' + data.id + '"'
                            + imgSrc
                            + 'alt="Image of user">'
                            + '</div>'
                            + '<div class="user-info" style="flex-grow:1 ;">'
                            + '<span class="user-name">' + data.name + '</span>'
                            + '</div>'
                            + '</div>';
                    if (isAdmin) {
                        appendUser += '<div class="group-delete fa fa-trash border" data-id="' + data.id + '" onclick="deleteGroup(this)"></div>';
                    }
                    appendUser += '</li>';
                    document.querySelector(".left-side .list-user").innerHTML += appendUser;
                });
            }).catch(ex => {
        console.log(ex);
    });
}


function handleResponsive() {
    back = document.querySelector(".back");
    rightSide = document.querySelector(".right-side");
    leftSide = document.querySelector(".left-side");

    if (back) {
        back.addEventListener("click", function () {
            rightSide.classList.remove("active");
            leftSide.classList.add("active");
            listFile = [];
            //renderFile();
        });
    }

    rightSide.classList.add("active");
    leftSide.classList.remove("active");

}

function searchFriendByKeyword(keyword) {
    if (keyword != null)
        fetch("http://" + window.location.host + "/FUNET/users-rest-controller?user_id=" + user_id + "&keyword=" + keyword)
                .then(function (data) {
                    return data.json();
                })
                .then(data => {

                    document.querySelector(".left-side .list-user").innerHTML = "";
                    data.forEach(function (data) {
                        let appendUser = '<li id="' + data.user_id + '" onclick="setReceiver(this)" data-name="' + data.first_name + ' ' + data.last_name + '">'
                                + '<div class="user-contain">'
                                + '<div class="user-img">'
                                + '<img id="img-' + data.user_id + '"'
                                + ' src="http://' + window.location.host + '/FUNET/assets/profile_avt/' + data.profile_pic + '"'
                                + 'alt="Image of user">'
                                + '<div id="status-' + data.user_id + '" class="user-img-dot ' + status + '"></div>'
                                + '</div>'
                                + '<div class="user-info">'
                                + '<span class="user-name">' + data.first_name + ' ' + data.last_name + '</span>'
                                + '</div>'
                                + '</div>'
                                + '</li>';
                        document.querySelector(".left-side .list-user").innerHTML += appendUser;
                    });
                });
}

function loadMessagesGroup() {
    var currentChatbox = document.getElementById("chat");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var messages = JSON.parse(this.responseText);
            var chatbox = "";
            messages.forEach(msg => {
                try {
                    chatbox += customLoadMessageGroup(msg.sender, groupId, msg.message);
                } catch (ex) {
                    console.log(ex.toString());
                }
            });
            currentChatbox.innerHTML = chatbox;
            goLastestMsg();
        }
    };
    xhttp.open("GET", "http://" + window.location.host + "/FUNET/conversations-rest-controller?messagesConversationId=" + groupId, true);
    xhttp.send();
}

function customLoadMessageGroup(sender, groupIdFromServer, message) {
    console.log("Load group msg: " + groupIdFromServer);
    //let imgSrc = 'http://' + window.location.host + '/files/' + sender + '/' + avatar;
    var msgDisplay = '<li>'
            + '<div class="message';
    if (groupIdFromServer != groupId) {
        return '';
    }
    if (user_id != sender) {
        msgDisplay += '">';
    } else {
        imgSrc = userAvatar;
        msgDisplay += ' right">';
    }
    return msgDisplay + '<div class="message-img">'
            + '<img src="' + imgSrc + '" alt="">'
            + '<div class="sender-name">' + sender + '</div>'
            + ' </div>'
            + '<div class="message-text">' + message + '</div>'
            + '</div>'
            + '</li>';
}

function searchMemberByKeyword(ele) {
    let keyword = ele.value;
    if (keyword != null)
        ;
    fetch("http://" + window.location.host + "/FUNET/users-rest-controller?user_id=" + user_id + "&keyword=" + keyword + "&conversationId=" + groupId)
            .then(function (data) {
                return data.json();
            })
            .then(data => {

                document.querySelector(".add-member-body .list-user ul").innerHTML = "";
                data.forEach(function (data) {
                    if (data.online)
                        status = "online";
                    else
                        status = "";

                    let check = "";
                    if (listUserAdd.indexOf(data.user_id) >= 0)
                        check = "checked";
                    console.log(data.first_name);
                    let appendUser = '<li>'
                            + '<input id="member-' + data.user_id + '" type="checkbox" ' + check + ' value="' + data.user_id + '" onchange="addUserChange(this)">'
                            + '<label for="member-' + data.user_id + '">'
                            + '<div class="user-contain">'
                            + '<div class="user-img">'
                            + '<img '
                            + ' src="assets/profile_avt' + '/' + data.profile_pic + '"'
                            + 'alt="Image of user">'
                            + '</div>'
                            + '<div class="user-info">'
                            + '<span class="user-name">' + data.first_name + ' ' + data.last_name + '</span>'
                            + '</div>'
                            + '</div>'
                            + '</label>'
                            + '<div class="user-select-dot"></div>'
                            + '</li>';
                    document.querySelector(".add-member-body .list-user ul").innerHTML += appendUser;
                });
            });
}