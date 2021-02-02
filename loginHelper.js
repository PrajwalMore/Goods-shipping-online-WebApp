
function login() {
    var userEmail = document.getElementById("mail_field").value;
    var userPass = document.getElementById("pass_field").value;

    if (userEmail.length == 0) {
        
        document.getElementById("form1").className = "was-validated";
        document.getElementById("mail_field").className = "form-control";
        window.alert("Please enter valid mail.");
        return false;
    }

    if (userPass.length == 0) {
       document.getElementById("form1").className = "was-validated";
        document.getElementById("pass_field").className = "form-control";
        console.log("Please enter password!!");
        window.alert("Please enter password.");
        return false;
    }

    var user = firebase.auth().currentUser;
    console.log(user);
    //if (user) {
        //alert("userLoggedInThere");
        //}
       // else {
            firebase.auth().signInWithEmailAndPassword(userEmail, userPass)
                .then(function (user) {
                
                document.getElementById("lg").style.display = "block";
                document.getElementById("login").style.display = "none";
                document.getElementById("newAc").style.display = "none";
                document.getElementById("havAc").style.display = "none";
                    document.getElementById("loginButton").style.display = "none";
                   console.log(`UID:${firebase.auth().currentUser.uid}`);
                resetForm();
                 nameId = firebase.auth().currentUser.uid
                    firebase.database().ref('infoPool/' + nameId).on('value', (snapshot) => {
                        nameS = snapshot.val().name;
                        document.getElementById("nameSpan").style.display = "block";
                       
                        document.getElementById("nameSpan").innerHTML="Hello "+nameS;
                    });
            }).catch(function (error) {
                // Handle Errors here.
                var errorCode = error.code;
                var errorMessage = error.message;
                // ...
                window.alert("Error: " + errorMessage);
                
        });
   // var elmnt = document.getElementById("lnkButtons");
    //elmnt.scrollIntoView();
}
function logout() {
    clearInterval(window.TimeInterval);
    firebase.auth().signOut().then(function () {
        console.log("sign-Out")
        // Sign-out successful.
        document.getElementById("lg").style.display = "none";
        document.getElementById("loginButton").style.display = "block";
        document.getElementById("loginButton").style.margin = "auto";
        document.getElementById("havAc").style.display = "block";
        document.getElementById("newAc").style.display = "block";
        document.getElementById("nameSpan").style.display = "none";
        document.getElementById("alert1").style.display = "none";
        window.scrollTo(0, 0);

        $(document).ready(function () {
            history.pushState(null, document.title, location.href);
        });

        resetForm();
        
    }).catch(function (error) {
        // An error happened.
        window.alert(error.code + " " + error.message);
    });
    //window.location = "HomeScreen.aspx";
}
