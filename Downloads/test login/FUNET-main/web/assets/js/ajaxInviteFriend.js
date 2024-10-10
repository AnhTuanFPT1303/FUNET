function ajaxInviteSend(btn) {
    var button = $(btn);
    var userId = button.data('user-id');
    $.ajax({
        type: 'POST',
        url: 'inviteFriendServlet',
        data: {userAccept: userId},
        success: function (response) {
            if (response.success) {
                button.text('Invited');
                button.prop('disabled', true);
            } else {
                alert('Failed to send friend request');
            }
        },
        error: function () {
            alert('Error sending request');
        }
    });
}
;


function ajaxInviteResponse(btn) {
    var button = $(btn);
    var userId = button.data('user-id');
    var action = button.data('action');
    var form = button.closest('form');

    $.ajax({
        type: 'POST',
        url: 'friendRequestServlet',
        data: {
            action: action,
            userRequest: userId
        },
        dataType: 'json',
        success: function (response) {
            if (response.feedback === 'accept') {
                button.text('Friend').prop('disabled', true);
                form.find('button[data-action="rejectFriend"]').remove();
            } else if (response.feedback === 'reject') {
                var postDiv = button.closest('.post');
                postDiv.find('.response-request').remove();
                postDiv.append('<button class="btn btn-primary btn-sm invite-friend" onclick="ajaxInviteSend(this)" data-user-id="' + userId + '">Add Friend</button>');
            } else {
                alert('Failed to take action');
            }
        },
        error: function () {
            alert('Error taking action');
        }
    });
}


