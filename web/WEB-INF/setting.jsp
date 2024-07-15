    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

    <!DOCTYPE html>
    <html>
    <head>
        <title>Settings</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/css/setting.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h3>Settings</h3>

            <c:if test="${not empty notification}">
                <div class="alert alert-success">${notification}</div>
            </c:if>

            <form action="settingServlet" method="post">
                <div class="card mb-3">
                    <h5 class="card-header">Change Name</h5>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" value="${user.first_name}">
                        </div>
                        <div class="mb-3">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="${user.last_name}">
                        </div>
                        <button type="submit" class="btn btn-primary" name="action" value="changeName">Change Name</button>
                    </div>
                </div>
            </form>

            <form action="settingServlet" method="post">
                <div class="card mb-3">
                    <h5 class="card-header">Change Password</h5>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="oldPassword" class="form-label">Old Password</label>
                            <input type="password" class="form-control" id="oldPassword" name="oldPassword">
                            <c:if test="${not empty oldPasswordError}">
                                <div class="text-danger">${oldPasswordError}</div>
                            </c:if>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                        </div>
                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Confirm New Password</label>
                            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword">
                            <c:if test="${not empty confirmPasswordError}">
                                <div class="text-danger">${confirmPasswordError}</div>
                            </c:if>
                        </div>
                        <button type="submit" class="btn btn-primary" name="action" value="changePassword">Change Password</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
    </html>