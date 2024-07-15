<%-- 
    Document   : signup
    Created on : Jun 5, 2024, 12:04:57 PM
    Author     : HELLO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign-up Page</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/signup.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <div class="left-section col-md-6">
            <div class="logo">
                <h1>BLAH</h1>
            </div>
            <div class="signup-text">
                <h2>Join The Journey</h2>
                <p>Register</p>
                <span style="color:red">${msg}</span>
            </div>
            <form class="input-form" method="post" action="/blahproject/signup">
                <div class="input-group">
                    <input type="text" id="firstname" name="firstName" placeholder="First Name"><br>
                </div>
                <div class="input-group">
                    <input type="text" id="lastname" name="lastName" placeholder="Last Name"><br>
                </div>
                <div class="input-group">
                    <input type="text" id="email" name="userEmail" onkeyup="emailCheck()" placeholder="Email"><br>
                </div>
                <div class="input-group">
                    <input type="password" id="pass" name="passWord" onkeyup="passwordCheck()" placeholder="Password"><br>
                </div>
                <div class="input-group">
                    <input type="password" id="confirmPass" name="confirm" onkeyup="passwordCheck()" placeholder="Re-enter Password"><br>
                    <span id="message"></span><br>
                </div>
                <div class="buttons">
                    <button type="submit" id="signupButton" class="signup-button" name="action">Sign Up</button>
                    <a href="signup?param=hadaccount" name="login-back" class="login-button">Already have an account?</a>
                </div>
                <div>
                    <span id="emailWarning"></span>
                </div>
            </form>
        </div>
        <div class="right-section col-md-6">
            <nav class="nav">
                <a href="#" class="active">Home</a>
                <a href="#">About us</a>
                <a href="#">Blog</a>
                <a href="#">Pricing</a>
            </nav>
            <div class="image">
                <img src="assets/images/cat-space.gif" alt="Rainbow cat">
            </div>
        </div>
    </body>
    <script src="assets/js/passwordValidation.js"></script>
    <script src="assets/js/emailValidation.js"></script>
</html>
