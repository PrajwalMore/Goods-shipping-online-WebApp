<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeScreen.aspx.cs" Inherits="Project.HomeScreen" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Shipping Platform</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
    <script src="loginHelper.js"></script>
<script src="SessionScript.js"></script>
    <link href="placeholderTransform.css" rel="stylesheet" />
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <!-- Custom styles for this template -->
    <link href="css/agency.min.css" rel="stylesheet">
    <script src="Scripts/jquery-3.0.0.js"></script>
</head>
<body id="page-top" onload="checkIfLoggedIn()">
    <form id="form1" runat="server">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a id="nameSpan" class="navbar-brand js-scroll-trigger" style="display: none" href="#page-top" onload="addUserAtNav();"></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">

                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ml-auto">
                        <li class="nav-item">
                            <a class="nav-link js-scroll-trigger" href="#page-top">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link js-scroll-trigger" href="#about">About</a>
                        </li>
                        <li id="lg" class="nav-item" style="display: none;">
                            <a
                                class="nav-link js-scroll-trigger"
                                onclick="document.getElementById('alert1').style.display='block'" title="logout">Logout</a>
                        </li>

                    </ul>
                </div>  
            </div>
        </nav>

        <!-- Header -->
        <header class="masthead">
            <div class="container">
                <div class="intro-text">
                    <div class="intro-lead-in">Welcome To Our Shipping Platform!</div>
                    <div class="intro-heading text-uppercase">It's Nice To Meet You</div>
                    <button id="loginButton" class="btn btn-primary btn-xl text-uppercase js-scroll-trigger" style="width: auto;display: none"
                        onclick="document.getElementById('login').style.display='block'">
                        Sign In
                    </button>
                    <p id="havAc" style="margin-top:10px;font-size:20px;display: none">Don't have an account ?<a id="newAc" href="createAccount.aspx" style="margin-top:0px;font-size: medium; display: none">Create Account</a></p>
                    

                </div>
            </div>
        </header>
        
        <section class="page-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2 id="doLogin" style="border-bottom:solid;border-bottom-color:#ffc300">Do Login For Enjoying Our Services..<i class="fa fa-flag-checkered" style="color:black"></i></h2>
                        <asp:LinkButton ID="LinkButton1" runat="server" Style="margin: auto; width: 400px; margin-bottom: 20px; display: none" class="card text-dark fa fa-truck fa-2x btn-outline-warning" OnClick="LinkButton1_Click">
                        Create New Shipment
                        </asp:LinkButton>
                        <asp:LinkButton ID="LinkButton2" runat="server" Style="margin: auto; display: none; width: 400px; margin-bottom: 20px" class="card text-dark fa  fa-search fa-book fa-2x btn-outline-warning" OnClick="LinkButton2_Click">
                        View and Manage Your Shipments
                        </asp:LinkButton>
                    </div>
                </div>

            </div>
        </section>
        <!-- Alert-->
        <div id="alert1" class="modal">
            <div class="animate card" style="width: 400px; margin: auto; margin-top: 30px">
                <h3>You really want to logout?</h3>
                <div class="col-sm" style="margin-bottom:10px">
                    <button type="button" onclick="logout()" class="btn btn-danger">Yes</button>
                </div>
                <div class="col-sm">
                    <button type="reset" onclick="document.getElementById('alert1').style.display='none'" class="btn btn-secondary rounded">Cancel</button>

                </div>
            </div>
        </div>
        <!-- About -->
        <section class="page-section" id="about">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2 class="section-heading text-uppercase">About</h2>
                        <div class="d-inline-flex">
                        <div class="p-2">
                            <p>
                                <asp:Image ID="truckDelivery" class="card" runat="server" src="BigDeliveryTruck.gif" Height="461px" Width="542px" />
                            </p>
                        </div>
                            <div class="p-2">
                            
                            <h2 class="section-subheading text-muted"><br/>This is an online goods transport agency offering On-demand 
                            Transportation solutions to cater to all your goods movement in both full load and part load capacity.
                            We aim to deliver quality service at competitive price and back up every shipment with latest 
                            technology & outstanding customer service.
                            </h2>
                        </div>
                        </div>
                        
                    </div>
                </div>

            </div>
        </section>

        <!--LoginForm-->
        <div id="login" class="modal">
            <div class="animate card" style="width: 528px; margin: auto">
                <div class="imgcontainer">
                    <img src="man.png" alt="Avatar" class="avatar">
                </div>
                <div class="input-container">
                    <i class="fa fa-user-circle fa-4x"></i>
                    <input id="mail_field" type="email" class="form-control" placeholder="Enter mail_ID" name="psw" style="margin-left: 6px; height: 60px;width:100%;" required>
                </div>
                <div class="input-container">
                    <i class="fa fa-key fa-4x"></i>
                    <input id="pass_field" type="password" class="form-control" placeholder="Enter Password" name="psw" style="margin-left: 6px; height: 60px;width:100%;" required>
                </div>
                <div>
                    <button type="button" onclick="login()" class="btn btn-primary btn-xl text-uppercase js-scroll-trigger">Login</button>
                </div>
                <div class="container" style="background-color: #f1f1f1;">
                    <button type="reset" onclick="document.getElementById('login').style.display='none'" class="btn btn-danger cancelbtn">Cancel</button>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container section-heading text-uppercase fa fa-road" style="font-size:24px;color:orange">
                Happy Shipping!!!
            </div>
            <h4 class="p-2 text-muted">Contact Us On:SippersAndMovers@mail.com</h4>
        </footer>
    </form>
<%--    <script>
        const auth = firebase.auth();
        auth.onAuthStateChanged((user) => {
            let sessionTimeout = null;
            if (user === null) {
                // User is logged out.
                // Clear the session timeout.
                sessionTimeout && clearTimeout(sessionTimeout);
                sessionTimeout = null;
                logout();
            } else {
                // User is logged in.
                // Fetch the decoded ID token and create a session timeout which signs the user out.
                user.getIdTokenResult().then((idTokenResult) => {
                    // Make sure all the times are in milliseconds!
                    const authTime = idTokenResult.claims.auth_time * 1000;
                    const sessionDuration = 10000;//1000 * 60 * 60 * 24 * 30;
                    const millisecondsUntilExpiration = sessionDuration - (Date.now() - authTime);
                    sessionTimeout = setTimeout(() => auth.signOut(), millisecondsUntilExpiration);

                });

            }
            
        });
    </script>--%>
    
    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Plugin JavaScript -->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Contact form JavaScript -->
    <script src="js/jqBootstrapValidation.js"></script>
    <script src="js/contact_me.js"></script>
    <!-- Custom scripts for this template -->
    <script src="js/agency.min.js"></script>
    <script type="text/javascript">

        var user = firebase.auth().currentUser;
        console.log(user);
        function checkIfLoggedIn() {

            firebase.auth().onAuthStateChanged(function (user) {
                if (user) {
                    // User is signed in.
                    console.log(`Logged In`);
                    document.getElementById("lg").style.display = "block";
                    document.getElementById("LinkButton2").style.display = "block";
                    document.getElementById("LinkButton1").style.display = "block";
                    document.getElementById("nameSpan").style.display = "block";
                    document.getElementById("doLogin").style.display = "none";
                    sessionEnd();
                    nameId = firebase.auth().currentUser.uid
                    firebase.database().ref('infoPool/' + nameId).on('value', (snapshot) => {
                        nameS = snapshot.val().name;
                        document.getElementById("nameSpan").style.display = "block";
                        document.getElementById("nameSpan").innerHTML = "Hello " + nameS;

                    });
                } else {
                    // No user is signed in.
                    console.log(`not logged-in`);
                    document.getElementById("newAc").style.display = "block";
                    document.getElementById("havAc").style.display = "block";
                    document.getElementById("loginButton").style.display = "block";
                    document.getElementById("loginButton").style.margin = "auto";
                    document.getElementById("LinkButton2").style.display = "none";
                    document.getElementById("LinkButton1").style.display = "none";
                    document.getElementById("nameSpan").style.display = "none";

                }
            });
            resetForm();
        }

        $(document).ready(function () {
            $(this).scrollTop(0);
        });

        function resetForm() {
            document.getElementById('form1').reset();
        }

        $(document).on('click', "#ResetForm", function () {
            // Reset the form
            document.getElementById('form1').reset();
        });
    </script>
    

</body>
</html>
