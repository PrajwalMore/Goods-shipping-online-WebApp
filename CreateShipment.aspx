<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateShipment.aspx.cs" Inherits="Project.CreateShipment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Shipment</title>

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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-database.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-storage.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-functions.js"></script>
    <script src="loginHelper.js"></script>
    <script src="SessionScript.js"></script>
    <script>
        // Your web app's Firebase configuration
        var firebaseConfig = {
            apiKey: "AIzaSyAOle3-1GQaiXOeIlOluxlXLwXkOqi5K5s",
            authDomain: "webapp-6078e.firebaseapp.com",
            databaseURL: "https://webapp-6078e.firebaseio.com",
            projectId: "webapp-6078e",
            storageBucket: "webapp-6078e.appspot.com",
            messagingSenderId: "31211393453",
            appId: "1:31211393453:web:5e69dcf766a56334a11124"
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
    </script>
    <style type="text/css">
        #Text1, #Text2, #Text3, #Text7, #startLoc, #destLoc, #weightOp, textarea {
            width: 250px;
            height: 60px;
        }

        #objectName {
            width: 525px;
            height: 60px;
        }

        #Text4, #Text5, #Text6, #objectName {
            height: 40px;
        }

        #img1 {
            width: 17px;
        }

        input[type=text], input[type=password] {
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: auto;
            border: none;
            cursor: pointer;
        }

            button:hover {
                opacity: 0.8;
            }
    </style>
</head><%--background-image: url(white-volvo.jpg);--%>
<body style="background-color: #f2f2f2;  background-repeat: no-repeat; background-size: cover;" onload="resetForm()">
    <form id="shipForm" runat="server" style="margin-top: 2px;">
        <!--<div class="shadow rounded-lg" style="background-color: antiquewhite; width: 70%; margin: auto">-->

        <script>
            sessionEnd();
            firebase.database().ref('cityNamePool/').on('value', (snapshot) => {
                document.getElementById("startLoc").innerHTML = `<option class="list-group-item" selected="selected" disabled="disabled"></option>`
                document.getElementById("destLoc").innerHTML = `<option class="list-group-item" selected="selected" disabled="disabled"></option>`
                snapshot.forEach((child) => {
                    document.getElementById("startLoc").innerHTML += `<option class="list-group-item">${child.val().cityName}</option>`
                    document.getElementById("destLoc").innerHTML += `<option class="list-group-item">${child.val().cityName}</option>`
                });
            });
        </script>
        <div class="shadow-lg" style="background-color: white; width: 60%; float: right; border-radius: 10px">
            <div>
                <h2 style="background-color:darkorange" class="text-center border-bottom rounded-top">Create New Shipment</h2>

                <div id="progressBar" class="progress" style="display: none">
                    <div id="uploader" class="progress-bar progress-bar-striped progress-bar-animated" style="width: 0%"></div>
                </div>

                <div class="border border-info rounded-sm" style="border-radius: 10px; font-size: 20px; margin-left: 10px; margin-right: 10px; margin-bottom: 20px">
                    <h3 class="center border-bottom alert-info">Please fill in following details.</h3>
                    <label style="margin-left: 10px">Upload image for your asset/delivery <kbd style="background-color: #808080;">optional</kbd></label><br />
                    <label for="fileButton" class="btn btn-primary" style="margin-left: 10px">Click to Select Image</label>
                    <input id="fileButton" type="file" value="Select" accept="image/*" onchange="display(this);"
                        style="width: 217px; visibility: hidden" /><br />
                    &nbsp;
                    <asp:Image ID="img1" class="rounded-lg border border-info" src="#" alt="No image selected!" runat="server" />
                    <br />
                    <div class="d-inline-flex border-bottom border-info">
                        <div class="p-2">
                            <input id="objectName" type="text" class="form-control" placeholder="short name Or description of an Object/Item which you want to ship." required="required" />
                        </div>
                    </div>

                    <br />

                    <div class="d-inline-flex">
                        <div class="p-2">
                            <p>Select pickup point address</p>
                            <select id="startLoc" class="list-group form-control" style="height: 40px;" required="required">
                            </select>
                        </div>
                    </div>
                    <div class="d-inline-flex">
                        <div class="p-2">
                            <p>Please mention any landmark for picking up order</p>
                            <textarea id="startLandmark" rows="1" style="width: 250px;" placeholder="Eg: Any landmark" class="form-control" required="required"></textarea>
                        </div>
                    </div>
                    <p class=" border-bottom border-info"></p>

                    <div class="d-inline-flex">
                        <div class="p-2">
                            <p>Select delivery point address</p>
                            <select id="destLoc" class="list-group form-control" style="height: 40px;" onchange="checkSelectedCity(this.selectedIndex);" required="required">
                            </select>
                        </div>
                        <p id="destReq" class="alert-danger" style="display: none" onchange="document.getElementById('destReq').display='Block'">please select list box</p>
                    </div>
                    <div class="d-inline-flex">
                        <div class="p-2">
                            <p>Please mention any landmark for delivering the order</p>
                            <textarea id="endLandmark" rows="1" cols="50" style="width: 250px;" placeholder="Eg: Any landmark" class="form-control" required="required"></textarea>
                        </div>
                    </div>
                    <p class=" border-bottom border-info"></p>
                    <div class="d-inline-flex">
                        <div class="p-2">
                            <p>Select weight of an item/delivery given bellow.</p>
                            <select id="weightOp" class="list-group form-control" style="height: 40px;" onchange="getWght()" required="required">
                                <option value="2" class="list-group-item" selected="selected">Less than 6 kgs</option>
                                <option value="3" class="list-group-item">6-20 kgs</option>
                                <option value="4" class="list-group-item">21-50 kgs</option>
                                <option value="5" class="list-group-item">51-100 kgs</option>
                                <option value="6" class="list-group-item">More than 100 kgs</option>
                            </select>
                        </div>
                    </div>
                    <p class=" border-bottom border-info"></p>
                    <p>
                        <input type="checkbox" id="cb1" onchange="boxChecked()" />
                        Select dimensions for item/delivery <kbd style="background-color: #808080">optional</kbd>
                    </p>
                    <div id="dimDiv" style="display: none">
                        <div class="d-inline-flex">
                            <div class="p-2">
                                <input id="Text4" class="form-control" type="text" placeholder="Length" required="required" />
                                <!--<asp:Label ID="Label2" runat="server" Height="50px" Text=" X "></asp:Label>-->
                            </div>
                            <div class="p-2">
                                <input id="Text5" class="form-control" type="text" placeholder="Breadth" required="required" />
                                <!--<asp:Label ID="Label3" runat="server" Height="50px" Text=" X "></asp:Label>-->
                            </div>
                            <div class="p-2">
                                <input id="Text6" class="form-control" type="text" placeholder="Height" required="required" />
                            </div>
                        </div>
                    </div>
                    <br />
                    <p id="chargeLabel"></p>
                    <p class=" border-bottom border-info"></p>
                    <div style="width: 20%; margin: auto;">
                        <button type="button" onclick="writeData()" class="btn btn-primary" style="margin-bottom: 10px">Create Shipment</button>
                    </div>
                </div>
            </div>
        </div>

    <script type="text/javascript">
        firebase.auth().onAuthStateChanged(function (user) {
            if (user) {

            } else {
                window.location = "HomeScreen.aspx";
            }
        });
        function boxChecked() {
            var checkBox = document.getElementById("cb1");
            var dimDiV = document.getElementById("dimDiv");

            if (checkBox.checked == true) {
                dimDiV.style.display = "block";
                window.boxIsChecked = true;
            } else {
                dimDiV.style.display = "none";
                window.boxIsChecked = false;
            }
        }

        fileButton.addEventListener('change', function (e) {
            window.file = e.target.files[0];
            //getting image here.
        });


        var uploader = document.getElementById("uploader");
        //weight from option tag..^

        //var Ldate = document.getElementById('Text7').value;

        var imgName = Date.now();

        dt = new Date();
        y = dt.getFullYear();
        m = dt.getMonth() + 1;
        d = dt.getDate();
        var orderDate = d + "/" + m + "/" + y;

        var storageRef = firebase.storage().ref('images/' + imgName);



        //|||||||||||||||||||||||||||||||||||||||FUNCTION||||||||||||||||||||||||||||||||||||||||//
        function writeData() {
            var objectName = document.getElementById('objectName').value;

            var l = document.getElementById('Text4').value;
            var b = document.getElementById('Text5').value;
            var h = document.getElementById('Text6').value;
            var dimensions = l + " X " + b + " X " + h;//unit for dimensions.

            var e = document.getElementById("weightOp");
            var weight = e.options[e.selectedIndex].text;


            var eStart = document.getElementById("startLoc");
            var start = eStart.options[eStart.selectedIndex].text;

            var eDest = document.getElementById("destLoc");
            var dest = eDest.options[eDest.selectedIndex].text;
            console.log(dest);
            // console.log(eStart.selectedIndex);

            var LandmarkStart = document.getElementById("startLandmark").value
            var LandmarkEnd = document.getElementById("endLandmark").value;
            if (LandmarkStart.trim().length == 0) {
                alert("Please enter starting landmark!!")
                document.getElementById("shipForm").className = "was-validated";
                // document.getElementById("objectName").className = "form-control";
                return false;
            }
            if (objectName.trim().length == 0) {
                alert("Please enter title!!")
                document.getElementById("shipForm").className = "was-validated";
                document.getElementById("objectName").className = "form-control";
                return false;
            }

            if (eStart.selectedIndex == 0) {
                window.alert("Please select starting location");
                document.getElementById("shipForm").className = "was-validated";
                document.getElementById("startLoc").className = "list-group form-control";
                document.getElementById("startLoc").focus();
                return false;
            }

            if (eDest.selectedIndex == 0) {
                window.alert("Please select destination");
                document.getElementById("shipForm").className = "was-validated";
                document.getElementById("destLoc").className = "list-group form-control";
                return false;
            }
            if (window.boxIsChecked == true) {
                if (l.length == 0) {
                    window.alert("length is empty");
                    document.getElementById("shipForm").className = "was-validated";
                    document.getElementById("Text4").className = "form-control";
                    return false;
                }
                if (b.length == 0) {
                    window.alert("width is empty");
                    document.getElementById("shipForm").className = "was-validated";
                    document.getElementById("Text5").className = "form-control";
                    return false;
                }
                if (h.length == 0) {
                    window.alert("height is empty");
                    document.getElementById("shipForm").className = "was-validated";
                    document.getElementById("Text6").className = "form-control";
                    return false;
                }
            }



            if (typeof (file) === 'undefined') {
                console.log("file is undefined");
                var userId = firebase.auth().currentUser.uid;
                console.log(window.boxIsChecked);
                if (window.boxIsChecked == false) {
                    console.log("dim undefined!");
                    firebase.database().ref('users/').push().set({

                        startPt: start,
                        destPt: dest,
                        weight: weight,

                        owner: userId,
                        ordDate: orderDate,
                        startMark: LandmarkStart,
                        endMark: LandmarkEnd,
                        charges: window.charges,
                        objectName: objectName,
                        status: "Requested"
                    }).then(function () {
                        window.alert("Shipment successfully created");
                    }).catch(function (error) {
                        var errorCode = error.code;
                        var errorMessage = error.message;
                        window.alert("Error: " + errorMessage);
                    });
                } else if (window.boxIsChecked == true) {
                    firebase.database().ref('users/').push().set({

                        startPt: start,
                        destPt: dest,
                        weight: weight,
                        dim: dimensions,

                        owner: userId,
                        ordDate: orderDate,
                        startMark: LandmarkStart,
                        endMark: LandmarkEnd,
                        charges: window.charges,
                        objectName: objectName,
                        status: "Requested"
                    }).then(function () {
                        window.alert("Shipment successfully created");
                    }).catch(function (error) {
                        var errorCode = error.code;
                        var errorMessage = error.message;
                        window.alert("Error: " + errorMessage);
                    });
                }

            }
            else {
                /* if (typeof (dimensions) === 'undefined') {
                     console.log("undefined dimensions");
                 }*/
                document.getElementById("progressBar").style.display = "block";
                $('html, body').animate({ scrollTop: 0 }, 'fast');
                var userId = firebase.auth().currentUser.uid;
                var task = storageRef.put(file);
                task.on('state_changed',
                    function progress(snapshot) {
                        var percentage = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                        uploader.style.width = percentage + "%";
                        uploader.innerHTML = Math.round(percentage) + "%";

                    },
                    function error(err) {
                        console.log("Error while calulating image percent")
                    });

                task.then(function () {

                    storageRef.getDownloadURL().then(function (url) {
                        window.imgURL = url;
                        console.log(imgURL);

                        //document.getElementById("shipForm").
                        console.log("file[image] is defined");
                        if (window.boxIsChecked == false) {
                            console.log("dim undefined!");
                            firebase.database().ref('users/').push().set({

                                startPt: start,
                                destPt: dest,
                                weight: weight,
                                picUrl: window.imgURL,
                                owner: userId,
                                ordDate: orderDate,
                                startMark: LandmarkStart,
                                endMark: LandmarkEnd,
                                charges: window.charges,
                                objectName: objectName,
                                status: "Requested"
                            }).then(function () {
                                document.getElementById("progressBar").style.display = "none";
                                window.alert("Shipment successfully created");
                            }).catch(function (error) {
                                var errorCode = error.code;
                                var errorMessage = error.message;
                                window.alert("Error: " + errorMessage);
                            });
                        } else if (window.boxIsChecked == true)//VALIDATION IS REQUIRED IN DIMENSIONdIV
                        {
                            firebase.database().ref('users/').push().set({

                                startPt: start,
                                destPt: dest,
                                weight: weight,
                                dim: dimensions,
                                picUrl: window.imgURL,
                                owner: userId,
                                ordDate: orderDate,
                                startMark: LandmarkStart,
                                endMark: LandmarkEnd,
                                charges: window.charges,
                                objectName: objectName,
                                status: "Requested"
                            }).then(function () {
                                document.getElementById("progressBar").style.display = "none";
                                window.alert("Shipment successfully created");

                            }).catch(function (error) {
                                var errorCode = error.code;
                                var errorMessage = error.message;
                                window.alert("Error: " + errorMessage);
                            });
                        }

                    });

                    console.log('Uploaded a  blob or file!');
                    console.log(dest, start, weight, dimensions);
                }).catch(function (error) {
                    var errorCode = error.code;
                    var errorMessage = error.message;
                    window.alert("Error: " + errorMessage);
                });

            }
            //|||||||||||||||||||||AdminSide Copying|||||||||||||||||||||||||\\
            //firebase.database().ref('users/').on('value', (snapshot) => {
            //    if (snapshot.exists()) {
            //        //firebase.database().ref('adminside/').remove().then(function () {
            //        //    console.log("remove succeeded.");
            //        //}).catch(function (error) {
            //        //    console.log("remove failed: " + error.message)
            //        //});
            //        console.log(snapshot.val());
            //        //snapshot.forEach((child) => {
            //            //keyName = child.key;
            //            //valueData = child.val();
            //            firebase.database().ref("Admin/").set({
            //                  adminSide: snapshot.val()
            //            });
            //        //});
            //    }
            //    else {
            //        console.g("data isn't exists in Users/")
            //    }
            //});
            document.getElementById("img1").src = "";
            resetForm();
        }


        function display(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#img1')
                        .attr('src', e.target.result)
                        .width(500)
                        .height(400);
                };

                reader.readAsDataURL(input.files[0]);
            }

        }



        function resetForm() {
            document.getElementById('shipForm').reset();
            boxChecked();
        }
        function checkSelectedCity(cityIndex) {
            var firstSelect = document.getElementById("startLoc");
            var firstSelectS = firstSelect.selectedIndex;
            console.log(firstSelectS);
            console.log(cityIndex);

            var secondSelect = document.getElementById("destLoc");
            //console.log(secondSelect.options[secondSelect.selectedIndex].text);
            if (cityIndex == firstSelectS) {
                secondSelect.selectedIndex = 0;
                alert("You can't select same city as destination!");
            }
            getWght();
        }
        function getWght() {
            var eStart = document.getElementById("weightOp");

            console.log(`Selected index:${eStart.selectedIndex}`);
            firebase.database().ref('price/').on('value', (snapshot) => {
                wght2S = snapshot.val().wght2;
                wght3S = snapshot.val().wght3;
                wght4S = snapshot.val().wght4;
                wght5S = snapshot.val().wght5;
                if (eStart.selectedIndex == 0) {
                    window.weightPrice = snapshot.val().wght1;
                    console.log(weightPrice)
                } else
                    if (eStart.selectedIndex == 1) {
                        window.weightPrice = snapshot.val().wght2;
                    } else
                        if (eStart.selectedIndex == 2) {
                            window.weightPrice = snapshot.val().wght3;
                        } else
                            if (eStart.selectedIndex == 3) {
                                window.weightPrice = snapshot.val().wght4;
                            } else
                                if (eStart.selectedIndex == 4) {
                                    window.weightPrice = snapshot.val().wght5;
                                }
                var kmPrice = snapshot.val().priceField;
                window.charges = parseInt(kmPrice) + parseInt(window.weightPrice);
                //console.log(charges);
                document.getElementById("chargeLabel").innerHTML = `shipping charges:<i class="fa fa-inr">${charges}</i>`;
            });
        }

    </script>
                <p>
                <asp:Image ID="truckDelivery" runat="server" src="deliveryTruck.gif" style="margin-top:100px" Height="461px" Width="542px"/>
                </p>
        <h3 style="color:darkorange;font-family:'Droid Serif',-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,'Helvetica Neue',Arial,sans-serif,'Apple Color Emoji','Segoe UI Emoji','Segoe UI Symbol','Noto Color Emoji', Arial, sans-serif;" class="center">We are <br/>Ready to go</h3>
    </form>

    </body>
</html>
