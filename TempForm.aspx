<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TempForm.aspx.cs" Inherits="Project.TempForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!--<script src="jQvalidation/node_modules/jquery/dist/"></script> -->
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>

    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-database.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-storage.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-functions.js"></script>

    <script>
        // Your web app's Firebase configuration
        var firebaseConfig = {
            //firebase app configuration here.
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
    </script>

    <style type="text/css">
        #Button2 {
            width: 210px;
            height: 34px;
        }
    </style>
</head>
<body>


  <h2>Modal Example</h2>
  <!-- Button to Open the Modal -->


  <!-- The Modal -->

    <div id="alert1" class="modal-dialog">

      <div class="modal-content">
      
        <!-- Modal Header -->
        <div id="b1" class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          Confirm logout
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" onclick="getOut()">Logout</button>
          <button type="button" class="btn btn-warning" onclick="getAlert()">Close</button>
        </div>
        
      </div>
    </div>

  

    <script>
              $(function () {
                $("#b1").dialog();
            });
        function getOut() {
            alert("logout");
        }
        function getAlert() {
            document.getElementById("alert1").style.display = "none";
        }

        var modal = document.getElementById('TempDiv');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function ElementRefresh() {
            document.getElementById('form1').reset();
        }
    </script>


    <script>
        function pressed(id) {
            if (id === 'First') {
                console.log("This is first id")
            } else if (id === 'Second') {
                console.log("This is second id")
            } else if (id === 'Third') {
                console.log("This is Third id")
            }
        }

              /*  function display(input) {
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
        var imgName = Date.now();
        var storageRef = firebase.storage().ref('images/' + imgName);
        fileButton.addEventListener('change', function (e) {
            var file = e.target.files[0];
            var task = storageRef.put(file);
            task.then(function (snapshot) {
                imgurl = snapshot.ref.getDownloadURL();

                console.log('Uploaded a  blob or file!');
                console.log(imgurl);
                console.log(Object.entries(imgurl));
                // firebase.database().ref('users/').push().set({
                //    url11:imgurl
                //   });

            }).on('state-changed', function progress(snapshot) {
                var percentage = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                uploader.value = percentage;
            }).catch(function (error) {
                var errorMessage = error.message;
                console.log(errorMessage);
            });

        });*/
    </script>
</body>
</html>
