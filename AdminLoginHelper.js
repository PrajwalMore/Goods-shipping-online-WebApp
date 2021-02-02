
function login() {
    var userEmail = document.getElementById("mail_field").value;
    var userPass = document.getElementById("pass_field").value;



    var user = firebase.auth().currentUser;
    console.log(user);

    //if (user) {
    //alert("userLoggedInThere");
    //}
    // else {
    firebase.auth().signInWithEmailAndPassword(userEmail, userPass)
        .then(function (user) {
            document.getElementById("logoutSpan").style.display = "block";
            document.getElementById("login").style.display = "none";



        }).catch(function (error) {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            // ...
            window.alert("Error: " + errorMessage);

        });
    //  }
}
function logout() {
    firebase.auth().signOut().then(function () {
        // Sign-out successful.
        document.getElementById("logoutSpan").style.display = "none";

    }).catch(function (error) {
        // An error happened.
        window.alert(error.code + " " + error.message);
    });

}