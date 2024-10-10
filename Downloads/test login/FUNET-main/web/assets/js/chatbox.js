
var currentUserId = null;
var websocket = null;
var receiver = null;
var userAvatar = null;
var receiverAvatar = null;

var typeChat = "user";

window.onload = function() {
	if ("WebSocket" in window) {
		currentUserId = '';
		websocket = new WebSocket('ws://' + window.location.host + '/chat/' + currentUserId);

		websocket.onopen = function() {
		};

		websocket.onmessage = function(data) {
			setMessage(JSON.parse(data.data));
		};

		websocket.onerror = function() {
			console.log('An error occured, closing application');
			cleanUp();
		};

		websocket.onclose = function(data) {
			console.log(data.reason);
			cleanUp();
		};
	} else {
		console.log("Websockets not supported");
	}
}

function cleanUp() {
	username = null;
	websocket = null;
	receiver = null;
}

function resetChat() {
	let chatBtn = document.querySelectorAll(".tab-control i");
	let searchTxt = document.querySelector(".list-user-search input");
	let addGroupBtn = document.querySelector(".add-group");

	searchTxt.value = "";

	chatBtn.forEach(function(ele) {
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
	document.getElementById("message").value = '';
	var message = buildMessageToJson(messageContent, messageType);
	setMessage(message);
	websocket.send(JSON.stringify(message));
}


function buildMessageToJson(message, type) {
	return {
		username: username,
		message: message,
		type: type,
		receiver: receiver,
		groupId: Number(groupId)
	};
}

function setMessage(msg) {
	console.log("online users: " + msg.onlineList);
	if (msg.message != '[P]open' && msg.message != '[P]close') {
		var currentChat = document.getElementById('chat').innerHTML;
		var newChatMsg = '';
		if (msg.receiver != null) {
			newChatMsg = customLoadMessage(msg.username, msg.message);
		} else {
			newChatMsg = customLoadMessageGroup(msg.username, msg.groupId, msg.message, msg.avatar);
		}
		document.getElementById('chat').innerHTML = currentChat
			+ newChatMsg;
		goLastestMsg();
	} else {
		if (msg.message === '[P]open') {
			msg.onlineList.forEach(username => {
				try {
					setOnline(username, true);
				} catch (ex) { }
			});
		} else {
			setOnline(msg.username, false);
		}

	}
}

function setOnline(username, isOnline) {
	let ele = document.getElementById('status-' + username);

	if (isOnline === true) {
		ele.classList.add('online');
	} else {
		ele.classList.remove('online');
	}
}

function loadMessages() {
	var currentChatbox = document.getElementById("chat");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var messages = JSON.parse(this.responseText);
			var chatbox = "";
			messages.forEach(msg => {
				try {
					chatbox += customLoadMessage(msg.username, msg.message);
				} catch (ex) {

				}
			});
			currentChatbox.innerHTML = chatbox;
			goLastestMsg();
		}
	};
	xhttp.open("GET", "http://" + window.location.host + "/chat-rest-controller?sender=" + username
		+ "&receiver=" + receiver, true);
	xhttp.send();
}

function customLoadMessage(sender, message) {
	var imgSrc = receiverAvatar;
	var msgDisplay = '<li>'
		+ '<div class="message';
	if (receiver != sender && username != sender) {
		return '';
	}
	else if (receiver == sender) {
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
	} catch (ex) { }
}