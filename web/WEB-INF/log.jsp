<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Log</title>
        <!-- Bootstrap CSS for styling -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div id="users-page" class="container mt-5">
            <h1 class="mt-4">Users Management</h1>
            <% User us = (User) request.getAttribute("user"); %>
            <h2 class="mt-5"><%= us.getFirst_name() %> <%= us.getLast_name() %> </h2>

            <% String userId = request.getParameter("id");%>
            <input type="hidden" id="userId" value="<%= userId%>">

            <!-- Add Ban and Unban buttons -->
            <div class="d-flex justify-content-end mb-4">
                <a id="ban-user" class="btn btn-danger me-2" href="dashBoard ">DashBoard</a>
                                       <a id="ban-user" class="btn btn-danger me-2" href="ban?id=<%= userId%>&action=ban ">Ban User</a>
                        
                            <a id="unban-user" class="btn btn-success" href="ban?id=<%= userId%>&action=unban">Unban User</a>
                      
            </div>

            <!-- User Activities Table -->
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Role</th>
                        <th>Activity Type</th>
                        <th>Details</th>
                        <th>Time</th>
                        <th>Delete button</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Placeholder for dynamically inserting activity data -->
                </tbody>
            </table>
        </div>

        <!-- JavaScript logic for handling ban and unban -->
        <script src="assets/js/log.js"></script>
        <!-- Bootstrap JS (optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
