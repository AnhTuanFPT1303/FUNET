const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

signUpButton.addEventListener('click', () => {
    container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
    container.classList.remove("right-panel-active");
});


function onSignIn(googleUser) {
    var user = googleUser.getBasicProfile();
    console.log('Signed in as: ');
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'https://funet.azurewebsites.net/GoogleValidate');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {
        console.log('Signed in as: ' + xhr.responseText);
    };
    xhr.send('user=' + user);
}