/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function passwordCheck() {
    var confirm = document.getElementById("confirmPass").value;
    var password = document.getElementById("pass").value;
    var message = document.getElementById("message");
    var signupButton = document.getElementById("signupButton");
    if (confirm !== password) {
        message.textContent = "Password mismatch";
        message.style.color = "red";
        signupButton.disabled = true;
        signupButton.style.opacity = 0.5;
    } else {
        message.textContent = "";
        signupButton.disabled = false;
        signupButton.style.opacity = 1;
    }
}
