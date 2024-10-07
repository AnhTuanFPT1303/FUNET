var user_id = parseInt(document.getElementById("user_id").textContent);
var websocket = null;
var receiver = null;
var userAvatar = document.getElementById("userAvatar").textContent;
var receiverAvatar = null;

var typeChat = "user";

window.onload = function () {
    if ("WebSocket" in window) {
        websocket = new WebSocket('ws://' + window.location.host + '/FUNET/chat/' + user_id);
        websocket.onopen = function () {
        };

        websocket.onmessage = function (data) {
            console.log("1");
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
            + '<p id="receiver" style="display:none">' + receiver +'</p>'
            + '<label class="btn btn-image" for="image"><i class="fa fa-file-image-o"></i></label>'
            + '<input type="file" accept="image/*" multiple id="image">'
            + '<button type="submit" class="btn btn-send">'
            + '<i class="fa fa-paper-plane"></i>'
            + '</button>'
            + '</form>';

    document.getElementById("receiver").innerHTML = rightSide;

    loadMessages();
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
        websocket.send(JSON.stringify(message));
    } else {
        console.log("WebSocket is not open.");
    }
    setMessage(message);
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
        if (receiver != null) {
            var newChatMsg = customLoadMessage(msg.sender, msg.message);
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
            messages.forEach(msg => {
                console.log(msg);
                try {
                    chatbox += customLoadMessage(msg.sender, msg.message);
                } catch (ex) {

                }
            });
            currentChatbox.innerHTML = chatbox;
            goLastestMsg();
        }
    };
    xhttp.open("GET", "http://" + window.location.host + "/FUNET/MessageServlet?sender=" + user_id
            + "&receiver=" + receiver, true);
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
