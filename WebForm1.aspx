<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Project.WebForm1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Web forum</title>

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
   
    <link href="placeholderTransform.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>


    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
        html {
            scroll-behavior: smooth;
        }

    </style>
</head>
<body onload="checkIfLoggedIn()">
    <form id="form1" runat="server">

        <!-- Navbar -->


        <div class="w3-top">
            <div class="w3-bar w3-red w3-card w3-left-align w3-large">
                <a href="#" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Home</a>
                <a href="#about"  class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">About</a>
                <!--<i id="nameSpanInnerHtml" class="fa fa-2x fa-user-circle-o"></i>-->
                <span id="nameSpan" class="w3-bar-item w3-hide-small w3-padding-large" style="font-weight:bold;margin-left: 940px;height: 49px; padding: 10px;padding-right:100px"></span>
                <a id="lg" style="display: none; margin-left: 600px; height: 49px; padding: 10px;" class="fa fa-sign-out fa-2x align-content-center w3-hover-white w3-display-topmiddle w3-hide-small" onclick="logout()" title="logout">Logout</a>
            </div>

            <!-- Navbar on small screens -->
            <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium w3-large">
                <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 1</a>
                <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 2</a>
                <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 3</a>
                <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 4</a>
            </div>
        </div>
        
        <!--LoginForm-->
        <div id="login" class="modal ">

            <!--<div class="">modal-content-->
            <div class="animate card" style="width: 528px; margin: auto">
                <div class="imgcontainer">
                    <img src="img_avatar.png" alt="Avatar" class="avatar">
                </div>


                <div class="input-container">
                    <i class="fa fa-user-circle fa-4x"></i>
                    <input id="mail_field" type="email" class="form-control" placeholder="Enter mail_ID" name="psw" style="margin-left: 6px; height: 60px" required>
                </div>


                <div class="input-container">
                    <i class="fa fa-key fa-4x"></i>
                    <input id="pass_field" type="password" class="form-control" placeholder="Enter Password" name="psw" style="margin-left: 6px; height: 60px" required>
                </div>

                <div>
                    <button type="button" onclick="login()">Login</button>
                </div>

                <div class="container" style="background-color: #f1f1f1">
                    <button type="reset" onclick="document.getElementById('login').style.display='none'" class="cancelbtn">Cancel</button>
                    <!--<span class="psw">Forgot <a href="#">password?</a></span>-->
                </div>

            </div>


        </div>
        <!-- Welcome INFO -->



        <!-- Header -->
        <header class="w3-container w3-red w3-center" style="padding: 128px 16px">
            <h1 class="w3-margin w3-jumbo">Welcome to ShipperDive</h1>

            <button id="loginButton" type="button" class=" " style="width: auto; display: none"
                onclick="document.getElementById('login').style.display='block'">
                Login</button>

            <p id="havAc" style="display: none">Don't have an account ?</p>
            <a id="newAc" href="createAccount.aspx" style="font-size: medium; transition-delay: 5s; display: none">Create Account</a>

            <script type="text/javascript">

                var user = firebase.auth().currentUser;
                console.log(user);
                function checkIfLoggedIn() {
                  
                    firebase.auth().onAuthStateChanged(function (user) {
                        if (user) {
                            // User is signed in.
                            console.log(`Logged In`);
                            //window.alert(`logged-in.`);

                            document.getElementById("lg").style.display = "block";

                            document.getElementById("LinkButton2").style.display = "block";
                            document.getElementById("LinkButton3").style.display = "block";
                        } else {
                            // No user is signed in.
                            console.log(`not logged-in`);
                            document.getElementById("newAc").style.display = "block";
                            document.getElementById("havAc").style.display = "block";
                            document.getElementById("loginButton").style.display = "block";
                            document.getElementById("loginButton").style.margin = "auto";
                            document.getElementById("LinkButton2").style.display = "none";
                            document.getElementById("LinkButton3").style.display = "none";
                            resetForm();

                        }
                    });


                }
            </script>


        </header>

        <asp:LinkButton ID="LinkButton2" runat="server" Style="margin: auto; width: 400px; margin-bottom: 20px; display: none" class="card text-dark fa  fa-truck fa-2x" OnClick="LinkButton2_Click">
            Create New Shipment</asp:LinkButton>

        <asp:LinkButton ID="LinkButton3" runat="server" Style="margin: auto; display: none; width: 400px; margin-bottom: 20px" class="card text-dark fa  fa-search fa-book fa-2x" OnClick="LinkButton3_Click">
            View and Manage Your Shipments</asp:LinkButton>

        <!-- First Grid -->

        <div id="about" class="w3-row-padding w3-padding-64 w3-container">
            <div class="w3-content">
                <div class="w3-twothird">

                    <h2>About:-</h2>
                    <br />
                    <p style="font-size: x-large" class="w3-text-grey">
                        Our platform allows you shipping through road in all over *ABC* by road <i class="fa fa-road"></i>.
                    </p>
                </div>

                <div class="w3-third w3-center">
                    <!--<i class="fa fa-book fa-4x w3-padding-64 w3-text-red"></i>-->
                </div>
            </div>
        </div>


        <!-- Footer -->
        <footer class="w3-container w3-padding-64 w3-center w3-opacity">
            <div class="w3-xlarge w3-padding-32">
                FOOTER
            </div>
        </footer>

        <script>


            // Used to toggle the menu on small screens when clicking on the menu button
            function myFunction() {
                var x = document.getElementById("navDemo");
                if (x.className.indexOf("w3-show") == -1) {
                    x.className += " w3-show";
                } else {
                    x.className = x.className.replace(" w3-show", "");
                }
            }
            
            $(document).ready(function () {
                $(this).scrollTop(0);
            });
            
            function resetForm() {
                document.getElementById('form1').reset();
            }

           /* function forwardDisabled(){
                window.history.forward();
            }*/
           
        </script>

        <script src="loginHelper.js"></script>
    </form>
</body>
</html>
