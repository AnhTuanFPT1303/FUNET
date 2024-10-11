<%-- 
    Document   : newPassword
    Created on : Sep 17, 2024, 12:35:08 PM
    Author     : HELLO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Enter your new password</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/login-submit.css" rel="stylesheet">
</head>
<body>
    <script>
    var dataToLog = '${sessionScope.pendingEmail}';
    console.log(dataToLog);
    </script>
    <div class="wrapper">
        <h2>Create Password</h2>
        <form action="/FUNET/forgotPassword" method="POST">
            <div class="input-box">
                <input name="newPassword" type="password" placeholder="Create password" required>
            </div>
            <div class="input-box">
                <input name="confirmPassword" type="password" placeholder="Confirm password" required>
            </div>
            <div class="input-box button">
                <input type="submit" name="action" value="recoverPass">
            </div>
        </form>
    </div>
</body>
</html>