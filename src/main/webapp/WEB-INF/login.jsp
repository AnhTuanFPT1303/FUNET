<%-- 
    Document   : test
    Created on : Sep 30, 2024, 2:33:31 PM
    Author     : HELLO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="google-signin-client_id" content="141463377028-7grc9ri1n2peprn9fhuucjamiudeopcs.apps.googleusercontent.com">
        <title>Welcome</title>
        <link rel="stylesheet" href="assets/css/welcome.css">
    </head>
    <body>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form method="post" action="/signup">
                    <h1>Create Account</h1>
                    <div class="g-signin2" data-onsuccess="onSignIn();">
                        <i class="fab fa-google-plus-g"></i></a>
                    </div>
                    <input type="text" id="firstname" name="firstName" placeholder="First Name">
                    <input type="text" id="lastname" name="lastName" placeholder="Last Name" />
                    <input type="text" id="email" name="userEmail" onkeyup="emailCheck()" placeholder="Email" />
                    <input type="password" id="pass" name="passWord" onkeyup="passwordCheck()" placeholder="Password" />
                    <input type="password" id="confirmPass" name="confirm" onkeyup="passwordCheck()" placeholder="Re-enter Password">
                    <button id="signupButton">Sign Up</button>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <form action="/login" method="post">
                    <h1>Sign in</h1>
                    <div class="g-signin2" data-onsuccess="onSignIn();">
                        <i class="fab fa-google-plus-g"></i></a>
                    </div>
                    <span>or use your account</span>
                    <input type="email" name="userEmail" placeholder="Email" onkeyup="emailCheck()"/>
                    <input type="password" name="passWord" placeholder="Password" />
                    <a href="forgotPassword">Forgot your password?</a>
                    <button>Sign In</button>
                </form>
            </div> 
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Welcome Back!</h1>
                        <p>To keep connected with us please login with your personal info</p>
                        <button class="ghost" id="signIn">Sign In</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Hello, Friend!</h1>
                        <p>Enter your personal details and start journey with us</p>
                        <button class="ghost" id="signUp">Sign Up</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="assets/js/Validation.js"></script>
    <script src="assets/js/login-register.js"></script>
    <script src="assets/css/welcome.css"></script>

</html>
