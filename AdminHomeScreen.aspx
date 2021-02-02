<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminHomeScreen.aspx.cs" Inherits="Project.AdminHomeScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Your Shipment</title>
    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-database.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-storage.js"></script>

    <script>
        // Your web app's Firebase configuration
        var firebaseConfig = {
            //firebase app configuration here.
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
    </script>
    <script src="AdminLoginHelper.js"></script>
    <link href="placeholderTransform.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
</head>
<body onload="checkIfLoggedIn()">
    <form id="form1" runat="server">
       <nav class="navbar navbar-expand-sm bg-light navbar-light card-header navbar-right" style="margin:auto">
            <ul class="navbar-nav nav navbar-right">
                <li class="nav-item active">
                    <a class="nav-link rounded alert-warning disabled" href="#"><h3 id="date"><i class="fa fa-calendar"></i></h3></a>
                </li><li class="nav-item active">
                    <a class="nav-link rounded btn btn-outline-danger" style="margin-left:20px;display:none;" href="#" onclick="logout()" id="logoutSpan"><h3>Logout</h3></a>
                </li>
            </ul>
        </nav>
        
        <div style="width:10%;margin:auto">
            <button id="loginButton" type="button" onclick="document.getElementById('login').style.display='block'" class="btn btn-primary">Login</button>
        </div>
        <div id="btnDiv"  class="col-lg-12 text-center" style="width:500px;margin:auto;display: none;margin-top:40px">
            <h2 class="alert-info rounded">Please choose any option to proceed...</h2>
            <asp:LinkButton ID="LinkButton1" runat="server" Style="margin-top:40px;margin: auto;  width: 400px; margin-bottom: 20px" class="card btn btn-outline-warning text-dark fa  fa-search fa-2x" OnClick="LinkButton3_Click">
            View Shipment</asp:LinkButton>
            <asp:LinkButton ID="LinkButton2" runat="server" Style="margin: auto; width: 400px; margin-bottom: 20px" class="card btn btn-outline-warning text-dark fa fa-gear fa-2x" OnClick="LinkButton2_Click">
            Manage services</asp:LinkButton>
        </div>

        <div id="login" style="display:none" class="modal">

            
            <div class="animate card" style="width: 528px; margin: auto">
                <div class="imgcontainer">
                    <img src="Admin_img_avatar.png" alt="Avatar" class="avatar"/>
                </div>


                <div class="input-container">
                    <i class="fa fa-user-circle fa-4x"></i>
                    <input id="mail_field" type="text" class="form-control" placeholder="Enter mail_ID" name="psw" style="margin-left: 6px;height: 60px" required="required"/>
                </div>


                <div class="input-container">
                    <i class="fa fa-key fa-4x"></i>
                    <input id="pass_field" type="password" class="form-control" placeholder="Enter Password" name="psw" style="margin-left: 6px;height: 60px" required="required"/>
                </div>

                <div>
                    <button type="button" class="btn btn-primary" onclick="login()">Login</button>
                </div>

                <div class="container" style="background-color: #f1f1f1">
                    <button type="button" onclick="document.getElementById('login').style.display='none'" class="btn btn-danger cancelbtn">Cancel</button>
                    <!--<span class="psw">Forgot <a href="#">password?</a></span>-->
                </div>

            </div>
            <!--  </div>-->

        </div>
        <!--<table class="border">
             <tr>
                <td style=" white-space: nowrap;">
                    <asp:Button ID="Button1" runat="server" Text="Button1" />
        <asp:Button ID="Button2" runat="server" Text="Button2!!" />
                    <button>BTN1</button>
                    <button >BTN2</button>

                </td>
            </tr>
        </table> -->
    </form>
    <script>
        dt = new Date();
        y = dt.getFullYear();
        m = dt.getMonth() + 1;
        d = dt.getDate();
        document.getElementById("date").innerHTML += " Today's Date: " + d + "/" + m + "/" + y;
        
        function checkIfLoggedIn() {
            firebase.auth().onAuthStateChanged(function (user) {
                if (user) {
                    // User is signed in.
                    console.log(`Logged In`);
                    document.getElementById("loginButton").style.display = "none";
                    document.getElementById("btnDiv").style.display = "block";
                    document.getElementById("logoutSpan").style.display = "block";
                } else {
                    // No user is signed in.
                    console.log(`not logged-in`);
                    document.getElementById("btnDiv").style.display = "none";
                    document.getElementById("loginButton").style.display = "block";
                    document.getElementById("logoutSpan").style.display = "none";   

                }
            });


        }
       

    </script>
</body>
</html>

