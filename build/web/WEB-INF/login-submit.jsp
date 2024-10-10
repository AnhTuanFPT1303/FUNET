<%-- 
    Document   : login-submit
    Created on : Sep 11, 2024, 1:37:38 PM
    Author     : HELLO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Login Submit</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/css/login-submit.css" rel="stylesheet">
    </head>
    <body>
        <div class="wrapper">
            <h2>Create Password</h2>
            <form action="/FUNET/login-submit" method="POST">
                <div class="input-box">
                    <input name="password" type="password" placeholder="Create password" required>
                </div>
                <div class="input-box">
                    <input type="password" placeholder="Confirm password" required>
                </div>
                <div class="input-box button">
                    <input type="Submit" value="Register Now">
                </div>
            </form>
        </div>
    </body>
</html>
