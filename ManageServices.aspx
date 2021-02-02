<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageServices.aspx.cs" Inherits="Project.ManageServices" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update</title>
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
    <script src="LoginHelper.js"></script>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        #containList {
            border: 1px solid #000;
            font-family: arial;
            height: 200px;
            width: 250px;
        }

        ol {
            list-style: none;
            max-height: 150px;
            margin: 0;
            overflow: auto;
            padding: 0;
            text-indent: 10px;
        }

        li {
            line-height: 25px;
        }

        input {
            width: 514.33px
        }
            /* Chrome, Safari, Edge, Opera */
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            /* Firefox */
            input[type=number] {
                -moz-appearance: textfield;
            }
    </style>
</head>
<body>
    <!--style="background:linear-gradient(to top, #141E30 0%, #243B55 75%);"-->
    <form id="form1" runat="server">
        <div>
            <div class="border-bottom card shadow rounded" style="text-align: center; margin: auto; width: 80%; margin-bottom: 40px">
                <h3 class="border-bottom">Adjust Following settings.</h3>
                <h4 class="alert-warning">Change or Update city list</h4>
                <div class="d-flex p-3 alert-info">
                    <div id="containList" class="p-2 flex-fill rounded">
                        <span>Current city list</span><br />
                        <ol class="border-bottom" style="list-style-type: decimal; margin: auto" id="curCityList">
                            <i class="spinner-border"></i>
                        </ol>
                    </div>
                    <div class="p-2 flex-fill">
                        <input id="city" class="form-control" style="margin-bottom: 10px" type="text" placeholder="Enter city to add it into list." />

                        <button type="button" onclick="updateCity()" class="btn btn-outline-primary">Update</button>
                    </div>
                </div>
                <p class="border-bottom bg-dark"></p>
                <h4 class="alert-warning">Adjust price amount</h4>
                <div class="alert-info">
                    <kbd class="alert-danger">Enter price according to following:-
                        <br />
                        weight+Amount per km=charges</kbd>
                    <div style="width: 50%; margin: auto; margin-top: 20px">
                        <input id="priceField" class="form-control" type="text" placeholder="Enter price per 1KM" /><br />


                        <input id="wght1" class="form-control" type="number" min="0" placeholder="Less than 6 kgs" /><br />
                        <input id="wght2" class="form-control" type="number" placeholder="6-20 kgs" /><br />
                        <input id="wght3" class="form-control" type="number" placeholder="21-50 kgs" /><br />
                        <input id="wght4" class="form-control" type="number" placeholder="51-100 kgs" /><br />
                        <input id="wght5" class="form-control" type="number" placeholder="More than 100 kgs" /><br />
                        <button type="button" class="btn btn-outline-primary" style="margin-bottom:10px" onclick="priceUpdate()">Update prices</button>
                    </div>
                </div>
                <div>
                </div>
            </div>
        </div>
    </form>
    <script>
        resetForm1();
        firebase.database().ref('cityNamePool/').on('value', (snapshot) => {
            window.curCityList = "";
            window.cityArray = [];
            snapshot.forEach((child) => {
                window.curCityList += `<li class="list-group-item">${child.val().cityName}
                                            <button id="${child.key}" type="button" class="badge" onclick="deleteCity(this.id)">Delete</span>
                                       </li>`;
                cityArray.push(child.val().cityName);
            });
            console.log(cityArray);
            console.log(window.curCityList);
            if (window.curCityList == "") {
                console.log("in if");
                document.getElementById("curCityList").innerHTML = `<div class="alert-warning"><B class="fa fa-info-circle">You don't have any city in list</B></div>`;
            }
            else {
                document.getElementById("curCityList").innerHTML = window.curCityList;//window.curCityList;
            }
        });

        function updateCity() {
            cityName = document.getElementById("city").value;//+ "," + window.curCityList;
            cityName = cityName.charAt(0).toUpperCase() + cityName.slice(1);
            if (cityName.trim() == "") {
                resetForm1();
                alert("Spaces not allowed here!!");
                return false;
            }
            if (cityArray.includes(cityName.trim())) {
                resetForm1();
                alert(`${cityName.trim()} is already present in list!!`);
                return false;
            }
            firebase.database().ref('cityNamePool/').push().set({
                cityName: cityName
            }).then(function (user) {
                alert("city added successfully.");
                resetForm1();
            });
        }
        function deleteCity(btnId) {
            firebase.database().ref('cityNamePool/' + btnId).remove();
            resetForm1();
        }
        function priceUpdate() {
            priceField = document.getElementById("priceField").value;
            if (isNaN(priceField.trim())) {
                alert("Please enter number!!.");
                return false;
            }
            else if (priceField.trim().length !== 0) {
                firebase.database().ref('price/').update({
                    priceField: priceField
                }).then(function () {
                    alert("Price Updated.");
                });
            } else if (priceField.trim().length !== 0) {
                alert("Spaces not allowed here!!");
                return false;
            }
            wght1 = document.getElementById("wght1").value.trim;
            wght2 = document.getElementById("wght2").value.trim;
            wght3 = document.getElementById("wght3").value.trim;
            wght4 = document.getElementById("wght4").value.trim;
            wght5 = document.getElementById("wght5").value.trim;
            //if (wght1.length == 0) {
            //    document.getElementById("wght1").focus;
            //    alert("Spaces not allowed");
            //    return false;
            //}
            if (wght1.length !== 0) {
                firebase.database().ref('price/').update({
                    wght1: wght1
                }).then(function () {
                    alert("weight price updated");
                });
            }
            if (wght2.length !== 0) {
                firebase.database().ref('price/').update({
                    wght2: wght2
                }).then(function () {
                    alert("weight price updated");
                });
            } if (wght3.length !== 0) {
                firebase.database().ref('price/').update({
                    wght3: wght3,
                }).then(function () {
                    alert("weight price updated");
                });
            } if (wght4.length !== 0) {
                firebase.database().ref('price/').update({
                    wght4: wght4
                }).then(function () {
                    alert("weight price updated");
                });
            }
            if (wght5.length !== 0) {
                firebase.database().ref('price/').update({
                    wght5: wght5
                }).then(function () {
                    alert("weight price updated");
                });
            }
            resetForm1();
        }

        function resetForm1() {
            document.getElementById('form1').reset();
        }
    </script>
</body>
</html>
