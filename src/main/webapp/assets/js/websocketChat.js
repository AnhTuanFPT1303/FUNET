var socket;
var currentUser;

function connectSessionUserSocket() {
    // sessionId is now accessible here because it's set in the JSP file.
    var sessionId = document.getElementById('user-info').getAttribute('data-session-id');
    socket = new WebSocket('wss://' + window.location.host + '/chat/' + sessionId);

    socket.onopen = function () {
        console.log('WebSocket connection opened for session user');
    };

    socket.onmessage = function (event) {
        var content = JSON.parse(event.data);
        displayMessage(content, currentUser);
        console.log('Message received: ', content);
    };

    socket.onclose = function (event) {
        console.log('WebSocket connection closed unexpectedly. Reconnecting...');
        setTimeout(connectSessionUserSocket, 2000);
    };

    socket.onerror = function (error) {
        console.error('WebSocket error:', error);
    };
}


function conversationInit() {
    $('.user-link').removeClass('active');
    $(this).addClass('active');
    currentUser = $(this).data('user-id');
    loadMessages(currentUser);
    $('#chat-container').show(); // Show chat container
}

function displayMessage(content, currentUser) {
    var currentChatUser = currentUser;
    var messageContainer = document.getElementById('message-container');
    var newMessage = document.createElement('div');
    if (currentChatUser !== null) {
        newMessage.className = content.fromUser === '<%= session.getAttribute("user_id") %>' ? 'my-message' : 'received-message';
        newMessage.textContent = content.message;
        messageContainer.appendChild(newMessage);
        messageContainer.scrollTop = messageContainer.scrollHeight; // Auto-scroll to latest message
    }
}

function loadMessages(currentUser) {
    $.ajax({
        url: '/MessageServlet',
        type: 'GET',
        data: {
            userId: currentUser
        },
        success: function (messages) {
            var messageContainer = $('#message-container');
            messageContainer.empty();
            messages.forEach(function (message) {
                var messageClass = message.fromUser == '<%= session.getAttribute("user_id") %>' ? 'my-message' : 'received-message';
                messageContainer.append('<div class="' + messageClass + '">' + message.message + '</div>');
            });
            messageContainer.scrollTop = messageContainer[0].scrollHeight; // Scroll to latest message
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
            sender: '<%= session.getAttribute("user_id") %>',
            receiver: $('.user-link.active').data('user-id'),
            content: messageInput
        };

        $('#message-container').append('<div class="my-message">' + messageInput + '</div>');
        socket.send(JSON.stringify(message));

        $.ajax({
            url: '/MessageServlet',
            type: 'POST',
            data: {
                sender: message.sender,
                receiver: message.receiver,
                message: message.content
            },
            success: function () {
                console.log('Message saved successfully.');
            },
            error: function () {
                alert('Failed to save message.');
            }
        });

        $('#message-input').val('');
    } else if (socket.readyState !== WebSocket.OPEN) {
        connectSessionUserSocket();
    }
});

// Initialize WebSocket connection
connectSessionUserSocket();