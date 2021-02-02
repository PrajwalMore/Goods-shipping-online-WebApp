function sessionEnd() {
    var idleTime = 0;
    $(document).ready(function () {

        $(window).click(function () {
            console.log("click has occured");
            idleTime = 0;
        })
        $(window).keyup(function () {
            console.log("key up has occured")
            idleTime = 0;
        })

        //Increment the idle time counter every minute.
        window.TimeInterval = setInterval(timerIncrement, 1000); //found

    });

    function timerIncrement() {

        if (idleTime > 900000) {
            console.log("Whats goin on!!!!!!!!!!!!!!!!!!!!")
            clearInterval(TimeInterval);
            firebase.auth().signOut().then(function () {
                console.log("sign-Out");
                alert("Your session has expired due to no activity.");
                window.location.href = '/HomeScreen.aspx';
                // Sign-out successful.
            }).catch(function (error) {
                // An error happened.
                window.alert(error.code + " " + error.message);
            });

        } else {
            idleTime = idleTime + 1000;
            console.log(idleTime);

        }

    };
}
function resetForm() {
    document.getElementById('form1').reset();
}