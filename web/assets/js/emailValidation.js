// emailValidation.js
function emailCheck() {
    var email = document.getElementById("email").value;
    var message = document.getElementById("emailWarning");
    message.innerHTML = "Invalid username part.<br>";
    // Part 1: Username validation
    var usernamePattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!usernamePattern.test(email)) {
        message.innerHTML = "Email is invalid.<br>";
        return false;
    } 
    message.innerHTML = '';
    return true;
}
