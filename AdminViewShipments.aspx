<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminViewShipments.aspx.cs" Inherits="Project.AdminViewShipments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View All Shipment</title>
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


    <link href="placeholderTransform.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        html {
            scroll-behavior: smooth;
        }

        .btnWidth {
            width: 100%;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div id="listDiv" class="flex">
            <ul id="ul" type="none" class="list-group" style="padding-right: 20px; padding-left: 20px; padding-top: 10px;">
            </ul>
        </div>
        <!--Cancel Alert-->
        <div id="cancelAlert" class="modal" style="display: none">
            <div class="animate card" style="width: 400px; margin: auto; margin-top: 30px">

                <h3>Cancel shipment ?</h3>
                <div class="col-sm" style="margin-bottom: 10px">
                    <button type="button" onclick="cancelReq(window.cancelIdStr)" class="btn btn-danger btnWidth">Yes</button>
                </div>
                <div class="col-sm">
                    <button type="button" onclick="document.getElementById('cancelAlert').style.display='none'" class="btn btn-secondary btnWidth">Cancel</button>
                </div>
            </div>
        </div>

        <!--AcAlert-->
        <div id="AcAlert" class="modal" style="display: none">
            <div class="animate card" style="width: 400px; margin: auto; margin-top: 30px">
                <h3>Accept this shipment?</h3>
                <div class="col-sm" style="margin-bottom: 10px">
                    <button type="button" onclick="acceptRequest(window.ElIdStr,window.statusStr,window.orderIdStr)" class="btn btn-danger btnWidth">Yes</button>
                </div>
                <div class="col-sm">
                    <button type="button" onclick="document.getElementById('AcAlert').style.display='none'" class="btn btn-secondary btnWidth">Cancel</button>

                </div>
            </div>
        </div>

        <!--compAlert-->
        <div id="compAlert" class="modal" style="display: none">
            <div class="animate card" style="width: 400px; margin: auto; margin-top: 30px">
                <h3>Set status as Completed?</h3>
                <div class="col-sm" style="margin-bottom: 10px">
                    <button type="button" onclick="acceptRequest(window.ElIdStr,window.statusStr,window.orderIdStr)" class="btn btn-danger btnWidth">Yes</button>
                </div>
                <div class="col-sm">
                    <button type="button" onclick="document.getElementById('compAlert').style.display='none'" class="btn btn-secondary btnWidth">Cancel</button>

                </div>
            </div>
        </div>
    </form>
    <script>
        var viewList = [];

        // var storageRef = firebase.storage().refFromURL('gs://webapp-6078e.appspot.com/images/');

        firebase.database().ref('users/').on('value', (snapshot) => {
            if (snapshot.exists()) {
                window.ulTag = document.getElementById("ul");
                ulTag.innerHTML = "";
                snapshot.forEach((child) => {
                     var childKey = child.key;
                    var table1 = document.createElement("table");
                    if (child.val().status !== "Cancelled") {
                        table1.className = "table table-borderless card border-danger";
                    } else {
                        table1.className = "table table-borderless card alert-warning";
                    }
                        
                        var tRow = document.createElement("tr");
                        var tRow2 = document.createElement("tr");


                        var tdata1 = document.createElement("td");
                        tdata1.className = " align-content-center";


                        var tdata2 = document.createElement("td");
                        tdata2.setAttribute("width", "100%");

                        var tdata3 = document.createElement("td");
                        tdata3.style.whiteSpace = "nowrap";
                        tRow.append(tdata1);
                        tRow.append(tdata2);

                        window.ownerId = child.val().owner;
                        window.orderId = child.key;
                        console.log(`orderID:${window.orderId}`);

                        //Status Label.
                        console.log(child.val().status);
                        window.ordStatus = child.val().status;
                        tdata3.innerHTML = `<span><kbd class="alert-info">STATUS: ${window.ordStatus}<kbd></span>&emsp;`;
                        //Button for table.
                        if (child.val().status == "Requested") {
                            var btn1 = document.createElement("button");
                            var btnTnode = document.createTextNode("Set As Accepted");

                            btn1.appendChild(btnTnode);
                            btn1.setAttribute("type", "Button");
                            btn1.setAttribute("id", childKey);
                            btn1.setAttribute("value", orderId);
                            btn1.className = "btn btn-info"
                            var statusString = "Accepted";
                            btn1.onclick = function () { preAcceptRequest(this.id, statusString, this.value) };
                            tRow2.append(tdata3)
                            tdata3.appendChild(btn1)
                        } else if (child.val().status == "Accepted") {
                            var btn1 = document.createElement("button");
                            var btnTnode = document.createTextNode("Set As Completed");

                            btn1.appendChild(btnTnode);
                            btn1.setAttribute("type", "Button");
                            btn1.setAttribute("id", childKey);
                            btn1.setAttribute("value", orderId);
                            btn1.className = "btn btn-warning"
                            var statusString = "Completed";
                            btn1.onclick = function () { preCompRequest(this.id, statusString, this.value) };
                            tRow2.append(tdata3)
                            tdata3.appendChild(btn1)
                        } else if (ordStatus == "Completed") {
                            tdata3.innerHTML = `<span class="alert-success rounded">STATUS: Delivery ${child.val().status} Sccessfully</span>`
                        }


                        tRow2.append(tdata3);

                        table1.appendChild(tRow);
                        table1.appendChild(tRow2);

                        if (child.val().picUrl) {
                            var URL = child.val().picUrl;
                            console.log(URL)
                        } else {
                            var URL = "https://firebasestorage.googleapis.com/v0/b/webapp-6078e.appspot.com/o/noImage%2Fselect.jpg?alt=media&token=a8842e1e-4cec-4572-8365-627bcc5d941b";
                            console.log(URL)
                        }


                        var imgTag = document.createElement("img");
                        imgTag.setAttribute("alt", "Oops!! no image found");
                        imgTag.setAttribute("src", URL);
                        imgTag.setAttribute("height", "300");



                        var li = document.createElement("li");
                        li.appendChild(table1)//added to li
                        // li.className = "list-group-item ";
                        // li.setAttribute("padding","0px,50px,0px,50px")
                        //li.className="class"

                        var h2Span = document.createElement("h2");
                        var OrderDetailS = document.createTextNode("Order details");
                        h2Span.append(OrderDetailS);
                        h2Span.style.textAlign = "center"; //("Text-align", "center");
                        //h2Span.setAttribute("margin-bottum", "10px");
                        h2Span.className = "border-bottom border-danger";

                        var paraStart = document.createElement("p");
                        var paraDest = document.createElement("p");
                        var paraWeight = document.createElement("p");
                        var paraDim = document.createElement("p");

                        var StartS = document.createTextNode(child.val().startPt);
                        var DestS = document.createTextNode(child.val().destPt);
                        var WeightS = document.createTextNode(child.val().weight);





                        console.log("in function")

                        var SpanStart = document.createElement("B");
                        var startSpanText = document.createTextNode("Pickup point: ");
                        SpanStart.appendChild(startSpanText);
                        paraStart.append(SpanStart);
                        paraStart.appendChild(StartS);

                        var SpanDest = document.createElement("B");
                        var destSpanText = document.createTextNode("Destination: ");
                        SpanDest.appendChild(destSpanText);
                        paraDest.append(SpanDest);
                        paraDest.appendChild(DestS);

                        var SpanWeight = document.createElement("B");
                        var weightSpanText = document.createTextNode("Weight: ");
                        SpanWeight.appendChild(weightSpanText);
                        paraWeight.append(SpanWeight);
                        paraWeight.appendChild(WeightS);

                        if (child.val().dim) {
                            var DimS = document.createTextNode(child.val().dim);
                            var SpanDim = document.createElement("B");
                            var DimSpanText = document.createTextNode("Dimensions: ");
                            SpanDim.appendChild(DimSpanText);
                            paraDim.append(SpanDim);
                            paraDim.appendChild(DimS);
                        }

                        tdata1.append(imgTag);//added img in li.

                        tdata2.append(h2Span);
                        firebase.database().ref('infoPool/' + window.ownerId).on('value', (snapshot) => {
                            tdata2.innerHTML += `<p><B>Customer Name: </B>${snapshot.val().name}</p>`;

                            tdata2.innerHTML += `<p><B>Mail address: </B>${snapshot.val().mail}</p>`;

                            tdata2.innerHTML += `<p><B>Phone number: </B>${snapshot.val().num}</p>`;

                        });

                        tdata2.append(paraStart);

                        tdata2.innerHTML += `<p><B>Start Landmark: </B>${child.val().startMark}</p>`

                        tdata2.append(paraDest);

                        tdata2.innerHTML += `<p><B>End Landmark: </B>${child.val().endMark}</p>`

                        tdata2.append(paraWeight);

                        tdata2.append(paraDim);

                        tdata2.innerHTML += `<p><B>Shipment created on: </B>${child.val().ordDate}</p>`;
                        tdata2.innerHTML += `<p><B>Payment of rupees: </B>${child.val().charges}</p>`;

                        //Cancel Button.
                        //if (child.val().status == "Accepted" || child.val().status != "Completed") {
                        //    var btn2 = document.createElement("button");
                        //    btn2.className = "btn btn-danger";
                        //    btn2.setAttribute("id", childKey);
                        //    btn2.setAttribute("type", "Button");
                        //    btn2.style.marginLeft = "20px";
                        //    var btnNode2 = document.createTextNode("Cancel");
                        //    btn2.onclick = function () { customAlert(this.id) };
                        //    btn2.appendChild(btnNode2);
                        //    tdata3.append(btn2);
                        //}


                        ulTag.appendChild(li);
                    
                });
            } else {
                var listDiv = document.getElementById("listDiv");
                listDiv.innerHTML = "NO data in db!!!!!!!!!!!!!!!!!!!!!!!!!!!";
            }

        });
        function preCompRequest(ElId, status, orderId) {
            window.ElIdStr = ElId;
            window.statusStr = status;
            window.orderIdStr = orderId;
            document.getElementById('compAlert').style.display = 'block';
        }

        function preAcceptRequest(ElId, status, orderId) {
            window.ElIdStr = ElId;
            window.statusStr = status;
            window.orderIdStr = orderId;
            document.getElementById('AcAlert').style.display = 'block';

        }
        function acceptRequest(ElId, statusStr, orderId) {

            console.log(`Eid: ${ElId}`)
            console.log(`Order Id: ${orderId}`)
            var user = firebase.auth().currentUser.uid;
            dt = new Date();
            y = dt.getFullYear();
            m = dt.getMonth() + 1;
            d = dt.getDate();
            var orderDate = d + "/" + m + "/" + y;
            console.log(`Userid: ${user}`);
            firebase.database().ref('notePool/' + window.ownerId + '/' + orderId).set({
                date: orderDate
            }).then(function () {
                firebase.database().ref('users/' + orderId).update({
                    status: statusStr//if i press accpeted -> Accpeted / if COmpleted ->Completed
                })
                console.log("Success!!!!!!!!!!!!!!!!!!!!!!!");
            });
            document.getElementById('AcAlert').style.display = 'none';
            document.getElementById('compAlert').style.display = 'none';
        }



        function cancelReq(reqId) {
            console.log(`Eid: ${reqId}`);

            firebase.database().ref('users/' + orderId).update({
                status: "Cancelled"
            });
            firebase.database().ref('Admin/adminSide/' + orderId).update({
                status: "Cancelled"
            });
        }

        function customAlert(cancelId) {
            console.log("cancel pressed")
            window.cancelIdStr = cancelId;
            document.getElementById("cancelAlert").style.display = "block";
        }
    </script>
</body>
</html>


