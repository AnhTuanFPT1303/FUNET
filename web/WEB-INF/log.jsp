<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.UserActivityLog, dao.userDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Log</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="container mt-4">
            <h1 class="mb-4">User Activity Log</h1>
            <% String userId = request.getParameter("id"); %>
            <input type="hidden" id="userId" value="<%= userId %>">
            <div class="mb-3">
                <button class="btn btn-danger" onclick="updateUserStatus(<%= userId %>, true)">Ban User</button>
                <button class="btn btn-success" onclick="updateUserStatus(<%= userId %>, false)">Unban User</button>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>User Id</th>
                        <th>Role</th>
                        <th>Name</th>
                        <th>Activity Type</th>
                        <th>Details</th>
                        <th>Time</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="activity" items="${userActivities}">
                        <tr>
                            <td>${activity.userId}</td>
                            <td>${activity.role}</td>
                            <td>${activity.firstName} ${activity.lastName}</td>
                            <td>${activity.activityType}</td>
                            <td>${activity.activityDetails}</td>
                            <td>${activity.timestamp}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <script>
            function updateUserStatus(userId, isBanned) {
                fetch('updateUserStatus', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ userId: userId, isBanned: isBanned })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('User status updated successfully');
                    } else {
                        alert('Failed to update user status');
                    }
                })
                .catch(error => console.error('Error:', error));
            }
        </script>
    </body>
</html>