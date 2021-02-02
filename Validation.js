$(function () {
    // Initialize form validation on the registration form.
    // It has the name attribute "registration"
    $("#formDiv").validate({
        // Specify validation rules
        rules: {
            firstname: "required",
            unum: "required",
            mail: {
                required: true,
                // Specify that email should be validated
                // by the built-in "email" rule
                email: true
            },
            pass: {
                required: true,
                
                minlength: 5
            }
        },
        // Specify validation error messages
        messages: {
            firstname: "Please enter your firstname",
            lastname: "Please enter your lastname",
            password: {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long"
            },
            email: {
                required: 'Please enter an email address.',
                email: "Please enter a valid email address"
            }
        },
        // Make sure the form is submitted to the destination defined
        // in the "action" attribute of the form when valid
        submitHandler: function (form) {
            form.submit();
        }
    });
});