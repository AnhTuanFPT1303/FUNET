function validateForm() {
    var confirm = document.getElementById("confirmPass").value;
    var password = document.getElementById("pass").value;
    var email = document.getElementById("email").value;
    var signupButton = document.getElementById("signupButton");

    // Part 1: Email validation
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    var isEmailValid = emailPattern.test(email);

    // Part 2: Password confirmation and non-empty fields validation
    if (confirm !== password || password === "" || confirm === "" || email === "" || !isEmailValid) {
        signupButton.disabled = true;
        signupButton.style.opacity = 0.5;
    } else {
        signupButton.disabled = false;
        signupButton.style.opacity = 1;
    }
}

// Attach the validateForm function to keyup events for all input fields
document.getElementById("email").onkeyup = validateForm;
document.getElementById("pass").onkeyup = validateForm;
document.getElementById("confirmPass").onkeyup = validateForm;

// Trigger validation on page load
window.onload = function() {
    validateForm();
};
