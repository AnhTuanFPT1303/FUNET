<%-- 
    Document   : recover
    Created on : Sep 17, 2024, 1:50:52 PM
    Author     : HELLO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/verify.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recover Account</title>
    </head>
    <body>
        <script>
        var dataToLog = '${sessionScope.pendingEmail}';
        console.log(dataToLog);
        </script>
        <div class="container">
            <h2>Enter the code from your email</h2>
            <form method="post" action="/FUNET/verify">
                <input type="text" id="code" name="otp-code" placeholder="FUNET-">
                <div class="button-group">
                    <button id="send-email-again" name="action" value="resend">Send Email Again</button>                
                    <button id="continue" name="action" value="newPass">Continue</button>
                </div>
            </form>
        </div>
    </body>
</html>