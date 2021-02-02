<!DOCTYPE html>
<html>

<head>

    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-database.js"></script>


    <script>
        // Your web app's Firebase configuration
        var firebaseConfig = {
            //firebase app configuration here.
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
    </script>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="placeholderTransform.css" rel="stylesheet" />

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        form {
            border: 3px solid #f1f1f1;
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            text-align: center;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

            button:hover {
                opacity: 0.8;
            }

        .cancelbtn {
            width: auto;
            padding: 10px 18px;
            background-color: #f44336;
        }

        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
        }

        img.avatar {
            width: 16%;
            border-radius: 50%;
        }

        .container {
            padding: 16px;
            width: 543px;
            height: 283px;
        }

        span.psw {
            float: right;
            padding-top: 16px;
        }

        /* Change styles for span and cancel button on extra small screens */
        @media screen and (max-width: 300px) {
            span.psw {
                display: block;
                float: none;
            }

            .cancelbtn {
                width: 100%;
            }
        }
    </style>
</head>
<body onload="resetForm()">
    <form id="form1">
        <h2 class="center" style="color: #2e5fa4">Create new account</h2>


        <div class="imgcontainer">
            <img src="img_avatar.png" alt="Avatar" class="avatar">
        </div>

        <div id="formDiv" class="card" style="margin: auto; width: 528px;margin-bottom:64px">

            <div class="input-container">
                <i class="fa fa-user-circle fa-4x"></i>
                <input id="uname" type="text" class="form-control" placeholder="Enter Username" name="psw" style="margin-left: 6px; height: 60px" required="required">
            </div>

            <div class="input-container">
                <i class="fa fa-phone-square fa-4x"></i>
                <input id="unum" type="tel" pattern="[0-9]{10}" class="form-control" placeholder="Enter Number" name="psw" style="margin-left: 15px; height: 60px; text-align: center" data-toggle="tooltip" required="required">
            </div>

            <div class="input-container">
                <i class="fa fa-envelope-square fa-4x"></i>
                <input id="mail" type="email" class="form-control" placeholder="Enter mail-ID" name="psw" style="margin-left: 15px; height: 60px; text-align: center" required="required">
            </div>


            <div class="input-container">
                <i class="fa fa-key fa-4x"></i>
                <input id="pass" type="password" class="form-control" placeholder="Enter Password" name="psw" style="margin-left: 6px; height: 60px" required="required">
            </div>


            <div >
                <button type="button" style="width:100px;margin:auto;font-size:large" onclick="register()" class="btn btn-warning">Submit</button>
            </div>


        </div>

    </form>

    <script>
        function register() {
            var mailS = document.getElementById('mail').value;
            var nameS = document.getElementById("uname").value;
            var numS = document.getElementById("unum").value;
            var passS = document.getElementById("pass").value;

            if (nameS === "") {
                alert("Please enter username!");
                document.getElementById('form1').className = "was-validated";
                document.getElementById('uname').className = "form-control";
                return false;
            } else if (nameS.trim() === "") {
                alert("Spaces not allowed here!");
                document.getElementById('form1').className = "was-validated";
                document.getElementById('uname').className = "form-control";
                document.getElementById("uname").value = "";
                return false;
            }

            if (numS === "") {
                document.getElementById('form1').className = "was-validated";
                document.getElementById('unum').className = "form-control";
                alert("Please enter number")
                $(document).ready(function () {
                    $('.toast').toast('show');
                });
                return false;
            } else if (isNaN(numS)) {
                document.getElementById('form1').className = "was-validated";
                document.getElementById('unum').className = "form-control";
                alert("Please enter number in digits.");
                document.getElementById("unum").value = "";
                return false;
            } else if (numS.length < 10 || numS.length > 10) {
                alert("Number must be 10 digits long.");
                document.getElementById('form1').className = "was-validated";
                document.getElementById('unum').className = "form-control";
                return false;
            }
            if (mailS.trim() === "") {
                alert("Please enter your phone number!");
                document.getElementById('form1').className = "was-validated";
                document.getElementById('mail').className = "form-control";
                return false;
            }
            if (passS.trim() === "") {
                alert("Please enter password!");
                document.getElementById('form1').className = "was-validated";
                document.getElementById('pass').className = "form-control";
                return false;
            } else if (passS.trim().length < 6) {
                alert("Please enter password greater than 6 digits/characters!");
                document.getElementById("pass").value = "";
                document.getElementById('form1').className = "was-validated";
                document.getElementById('pass').className = "form-control";
                return false;
            }


            firebase.auth().createUserWithEmailAndPassword(mailS, passS).then(function (user) {
                var userId = firebase.auth().currentUser.uid;
                firebase.database().ref('infoPool/' + userId).set({
                    name: nameS,
                    num: numS,
                    mail: mailS
                }).then(function () {
                    resetForm();
                    console.log("Profile created in database ")
                });
            }).catch(function (error) {

                // Handle Errors here.
                var errorCode = error.code;
                var errorMessage = error.message;
                // ...
                window.alert("Error: " + errorMessage);
                //window.alert("Error: " + errorCode);

                console.log(":" + errorMessage);


            });


        }

        function resetForm() {
            document.getElementById("form1").reset();
        }
    </script>

</body>
</html>
