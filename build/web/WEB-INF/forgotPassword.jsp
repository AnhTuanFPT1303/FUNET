<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/verify.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Email</title>
    </head>
    <body>
        <div class="container">
            <h2>Enter the email you used to sign-up</h2>
            <form method="post" action="/FUNET/forgotPassword">
                <input type="text" id="email" name="email" placeholder="Your email here" required>
                <div class="button-group">                
                    <button type="submit" name="action" value="forgot">Send OTP</button> 
                </div>
            </form>
        </div>
    </body>
</html>
