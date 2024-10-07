/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function checkOtp() {
    var continueBtn = document.getElementById("continue");
    var otp = document.getElementById("code").value;
    if(otp.trim() === "") {
        continueBtn.disabled = true;
        continueBtn.style.opacity = 0.5;
    }
    else {
        continueBtn.disabled = false;
        continueBtn.style.opacity = 1;
    }
};

window.onload = function() {
    checkOtp();
};

