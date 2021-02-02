<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewShipment.aspx.cs" Inherits="Project.NewShipment" %>

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

    <link href="placeholderTransform.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        p {
            border-bottom: solid;
            text-align: start;
            border-bottom-width: 1px;
            background-color: white;
            border-radius: 5px;
        }

        span {
            border-bottom-width: 1px;
            border-radius: 5px;
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
                <li class="">
                        <i class="container d-flex justify-content-center spinner-border" style="margin-top:100px"></i>
                </li>
            </ul>
        </div>
        <!--ALERT BOX -->
        <div id="alert1" class="modal">
            <div class="animate card" style="width: 400px; margin: auto; margin-top: 30px">
                <h3>Deleting shipment</h3>
                <h5>Delete and cancel this shipment?</h5>
                <div class="col-sm" style="margin-bottom: 10px">
                    <button id="yesButton" type="button" onclick="deleteRequest(window.latestIdForDeleteButton)" class="btn btn-danger btnWidth">Yes</button>
                </div>
                <div class="col-sm">
                    <button id="noButton" type="button" onclick="document.getElementById('alert1').style.display = 'none'" class="btn btn-secondary btnWidth">No</button>
                </div>
            </div>
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
    </form>
    <script>
        firebase.auth().onAuthStateChanged(function (user) {
            if (user) {
                var userId = firebase.auth().currentUser.uid;
                console.log(`${userId}`);
                firebase.database().ref('notePool/' + userId).on('value', (snapshot) => {
                    //console.log("child is present in notepool");
                    snapshot.forEach((child) => {
                        window.orderInNotePool = child.key;
                        console.log(window.orderInNotePool);
                        child.forEach((secondchild) => {
                            window.orderKey = secondchild.val();
                        });

                    });

                });

                // User is signed in.
            } else {
                console.log("User not present");
                // No user is signed in.
            }
            viewShipment();
        });

        function viewShipment() {
            firebase.database().ref('users/').on('value', (snapshot) => {
                if (snapshot.exists()) {
                    window.cntForUser = 0;//user presence counter.
                    window.ulTag = document.getElementById("ul");
                    ulTag.innerHTML = "";
                    snapshot.forEach((child) => {
                        var userId = firebase.auth().currentUser.uid;
                        currentOrderChild = child.key;
                        var table1 = document.createElement("table");
                        var tRow = document.createElement("tr");
                        var tRow2 = document.createElement("tr");


                        var tdata1 = document.createElement("td");
                        tdata1.className = " align-content-center";

                        var tdata2 = document.createElement("td");
                        tdata2.setAttribute("width", "100%");
                        window.orderId = child.key;

                        //}

                        window.cntForUser = window.cntForUser + 1;
                        //console.log(window.cntForUser);
                        console.log("user's ID in order pool is present");
                        var childKey = child.key;
                        //console.log(`KEY : ${window.childKey}`)

                        //  viewList.push(child.val().info);//child.val().picture
                        //console.log(child.key, child.val());
                        // console.log(viewList);
                        //console.log(viewList[0]);


                        var tdata3 = document.createElement("td");
                        tdata3.style.whiteSpace = "nowrap";
                        tRow.append(tdata1);
                        tRow.append(tdata2);
                        tdata3.innerHTML = `<span>STATUS: ${child.val().status}</span>`;
                        if (child.val().status !== "Cancelled" && child.val().status === "Completed") {
                            table1.className = "table table-borderless card alert-success";

                        } else if (child.val().status === "Cancelled") {
                            tdata3.innerHTML = `<h5 class="alert-danger" style="margin-left:500px;border-bottom:double">You have cancelled this shipment.</h5>`;
                            table1.className = "table table-borderless card alert-danger";
                        } else if (child.val().status === "Requested") {
                            table1.className = "table table-borderless card alert-info";
                        }

                        ////Accept Button.
                        //var btn1 = document.createElement("button");
                        //var btnTnode = document.createTextNode("Accept Shipping");
                        //btn1.appendChild(btnTnode);
                        //btn1.setAttribute("type", "Button");
                        //btn1.setAttribute("id", childKey);
                        //btn1.onclick = function () { acceptRequest(this.id) };
                        //tdata3.appendChild(btn1)

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
                        //li.setAttribute("padding","0px,50px,0px,50px")
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
                        var paraDim = document.createElement("span");

                        var StartS = document.createTextNode(child.val().startPt);
                        var DestS = document.createTextNode(child.val().destPt);
                        var WeightS = document.createTextNode(child.val().weight);

                        window.ownerId = child.val().owner;

                        console.log("in function")

                        var SpanStart = document.createElement("B");
                        var startSpanText = document.createTextNode("Pickup point:");
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
                        paraWeight.innerHTML += "&emsp;";


                        if (child.val().dim) {
                            var DimS = document.createTextNode(child.val().dim);
                            var SpanDim = document.createElement("B");
                            var DimSpanText = document.createTextNode("Dimensions: ");
                            SpanDim.appendChild(DimSpanText);
                            paraDim.append(SpanDim);
                            paraDim.appendChild(DimS);
                            paraDim.innerHTML += ("<br/>");
                        }

                        tdata1.append(imgTag);//added img in li.

                        tdata2.append(h2Span);

                        console.log(`currentOrderChild:${currentOrderChild}`);
                        if (window.orderInNotePool === currentOrderChild) {
                            tdata3.innerHTML = `<h5 class="alert-primary" style="margin-left:500px;border-bottom:double">Your Request is accepted on: ${window.orderKey}.</h5>`;
                        }
                        firebase.database().ref('infoPool/' + window.ownerId).on('value', (snapshot) => {
                            tdata2.innerHTML += `<p><B>Name: ${snapshot.val().name}</B>
                                                      &emsp;<span><B>Mail address: </B>${snapshot.val().mail}</span>
                                                      &emsp;<span><B>Phone number: </B>${snapshot.val().num}</span>
                                                    </p>`;
                        });

                        tdata2.innerHTML += `<p><B>What to be shipped: </B>${child.val().objectName}</p>`

                        tdata2.append(paraStart);

                        paraStart.innerHTML += `&emsp;<span><B>Pickup Landmark: </B>${child.val().startMark}</span><br/>`

                        tdata2.append(paraDest);

                        paraDest.innerHTML += `&emsp;<span><B>Destination Landmark: </B>${child.val().endMark}</span><br/>`

                        tdata2.append(paraWeight);

                        paraWeight.appendChild(paraDim);

                        tdata2.innerHTML += `<p><B>Shipment created on: </B>${child.val().ordDate}&emsp;<span><B>Payment of rupees: </B>${child.val().charges}</span><br/></p>`;


                        //Delete Button.
                        //var btn2 = document.createElement("button");
                        //btn2.className = "btn btn-danger";
                        //btn2.setAttribute("type", "Button");
                        //btn2.setAttribute("id", childKey);
                        //btn2.onclick = function () { showAlert(this.id) };
                        //var btnnode2 = document.createTextNode("Delete");
                        //btn2.appendChild(btnnode2);
                        //tdata3.append(btn2);
                        if (child.val().status !== "Accepted" && child.val().status !== "Completed" && child.val().status !== "Cancelled") {
                            console.log(child.val().status !== "Cancelled");
                            var btn2 = document.createElement("button");
                            btn2.className = "btn btn-danger";
                            btn2.setAttribute("id", childKey);
                            btn2.setAttribute("type", "Button");
                            btn2.style.marginLeft = "20px";
                            var btnNode2 = document.createTextNode("Cancel");
                            btn2.onclick = function () { customAlert(this.id) };
                            btn2.appendChild(btnNode2);
                            tdata3.append(btn2);
                        }

                        ulTag.appendChild(li);
                        /* else {
                             var usrNotDiv = document.createElement("div");
                             usrNotDiv.className = "";
                             var boldTag1 = document.createElement("b");
                             var boldTAg1Span = document.createTextNode("");
                             SpanStart.appendChild(startSpanText);
                             console.log("user's ID in order pool is NOT present");
                         }*/


                    });
                    if (window.cntForUser === 0) {
                        var userNotDiv = document.createElement("div");
                        userNotDiv.setAttribute("height", "50px")

                        userNotDiv.className = "alert-info card";
                        var boldTag1 = document.createElement("b");
                        var boldTAg1Text = document.createTextNode("You haven't done any shipments Yet!!!");
                        boldTag1.appendChild(boldTAg1Text);
                        userNotDiv.append(boldTag1);
                        ulTag.append(userNotDiv);
                        console.log("user's ID in order pool is NOT present");
                    }
                } else {
                    var listDiv = document.getElementById("listDiv");
                    listDiv.innerHTML = "NO data in db!!!!!!!!!!!!!!!!!!!!!!!!!!!";
                }

            });
        }
        /* function acceptRequest(ElId) {
             console.log(`Eid: ${ElId}`)
             var user = firebase.auth().currentUser.uid;
 
 
             console.log(`Userid: ${user}`);
             firebase.database().ref('notePool/' + window.ownerId).push().set({
                 isAccepted: True
                 //by: user,
                 //shipId: ElId
 
             }).then(function () {
                 //request is accepted by shipper's UID.Add div in li.
                 console.log("Success!!!!!!!!!!!!!!!!!!!!!!!")
             });
         }*/
        function showAlert(reqId) {
            window.latestIdForDeleteButton = reqId;
            //alert(window.latestIdForDeleteButton);
            document.getElementById('alert1').style.display = 'block';
        }
        function deleteRequest(reqId) {


            reqRef = firebase.database().ref('users/' + reqId);
            reqRef.on('value', (snapshot) => {
                imgRef = snapshot.val().picUrl;
                console.log(`image ref: ${imgRef}`)
            });


            reqRef.remove()
                .then(function () {
                    console.log("Remove succeeded.")

                    reqRef = firebase.storage().refFromURL(imgRef).delete()
                        .then(function () {
                            console.log("Imge Remove succeeded.");
                        }).catch(function (error) {
                            console.log("Image Remove failed: " + error.message)
                        });
                })
                .catch(function (error) {
                    console.log("Remove failed: " + error.message)
                });
            document.getElementById('alert1').style.display = 'none';
        }
        function customAlert(cancelId) {
            console.log("cancel pressed")
            window.cancelIdStr = cancelId;
            document.getElementById("cancelAlert").style.display = "block";
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
    </script>
</body>
</html>
