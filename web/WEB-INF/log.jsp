<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Log</title>
    </head>
    <body>
        <div id="users-page" class="page">
            <h1 class="mt-4">Users Management</h1>
           
            <% String userId = request.getParameter("id"); %>
            <input type="hidden" id="userId" value="<%= userId %>">
          thêm 2 nút ban và unban user
            
            <table class="table mt-4">
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
                    <!-- Activities will be inserted here -->
                </tbody>
            </table>
        </div>
    </body>
    <script src="assets/js/log.js"></script>
</html>