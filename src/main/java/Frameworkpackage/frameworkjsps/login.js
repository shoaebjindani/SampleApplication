// ============================================================
//  login.js  –  extracted from Login.jsp
// ============================================================

window.addEventListener('keydown', function (e) {
    if (e.keyCode === 13) login();
});

function login() {
    if (document.getElementById("closebutton")) {
        document.getElementById("closebutton").style.display = 'none';
    }

    var username     = document.getElementById("txtusername");
    var password     = document.getElementById("txtpassword");
    var termsCheckbox = document.getElementById("termsCheckbox");
    var appCode      = localStorage.getItem("app_code");

    if (!appCode) {
        $('#appCodeModal').modal('show');
        return;
    }

    if (username.value === "")    { toastr.error("Please enter Valid username");              username.focus(); return; }
    if (password.value === "")    { toastr.error("Please enter Valid password");              password.focus(); return; }
    if (!termsCheckbox.checked)   { toastr.error("Please agree to the Terms and Conditions");               return; }

    var controller = new AbortController();
    var timeoutId = setTimeout(function() { controller.abort(); }, 3000);

    fetch('http://127.0.0.1:8765/getDeviceId', { signal: controller.signal })
        .then(function(res) {
            clearTimeout(timeoutId);
            return res.json();
        })
        .then(function(data) {
            var deviceId = data && data.deviceId ? data.deviceId : "";
            sendLoginRequest(username.value, password.value, appCode, deviceId);
        })
        .catch(function(err) {
            clearTimeout(timeoutId);
            // Local agent offline -> send empty deviceId (server will deny login with instructions)
            sendLoginRequest(username.value, password.value, appCode, "");
        });
}

function sendLoginRequest(usernameVal, passwordVal, appCode, deviceId) {
    var usernameField = document.getElementById("txtusername");
    var passwordField = document.getElementById("txtpassword");

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            if (this.responseText === "Succesfully Logged In") {
                window.location = window.location.toString().replace('Login.jsp', '../?a=showHomePage');
            } else if (this.responseText === "DEVICE_NAME_REQUIRED") {
                openCustomDeviceNameModal();
            } else {
                toastr.error(this.responseText);
                usernameField.value = "";
                passwordField.value = "";
                usernameField.focus();
            }
        }
    };
    xhttp.open("POST", "../?actionName=validateLogin", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var postData = "txtusername=" + encodeURIComponent(usernameVal) +
                   "&txtpassword=" + encodeURIComponent(passwordVal) +
                   "&app_code=" + encodeURIComponent(appCode) +
                   "&txtDeviceId=" + encodeURIComponent(deviceId);
    if (window.customDeviceNameVal) {
        postData += "&txtCustomDeviceName=" + encodeURIComponent(window.customDeviceNameVal);
    }
    xhttp.send(postData);
}

function openCustomDeviceNameModal() {
    document.getElementById("inputCustomDeviceName").value = "";
    $('#customDeviceNameModal').modal('show');
    setTimeout(function() {
        document.getElementById("inputCustomDeviceName").focus();
    }, 400);
}

function submitCustomDeviceNameModal() {
    var devName = document.getElementById("inputCustomDeviceName").value.trim();
    if (!devName) {
        toastr.error("Please enter a custom device name.");
        document.getElementById("inputCustomDeviceName").focus();
        return;
    }
    window.customDeviceNameVal = devName;
    $('#customDeviceNameModal').modal('hide');
    login();
}

function cancelCustomDeviceModal() {
    $('#customDeviceNameModal').modal('hide');
    window.customDeviceNameVal = "";
    toastr.warning("Device registration cancelled.");
}

// ── App Code modal helpers ───────────────────────────────────

function saveAppCode() {
    var codeInput = document.getElementById("inputAppCode").value.trim();
    if (codeInput === "") { toastr.error("Please enter App Code"); return; }
    localStorage.setItem("app_code", codeInput);
    $('#appCodeModal').modal('hide');
    toastr.success("App Code saved. Please login now.");
    loadAppDetails();          // fetch & display app name after saving
}

function resetAppCode() {
    localStorage.removeItem("app_code");
    localStorage.removeItem("app_name");
    toastr.info("App Code has been reset. Please enter a new App Code.");
    updateAppNameDisplay("");
    $('#appCodeModal').modal('show');
}

function showForgotPasswordScreen() {
    alert('Please contact your admin of your organization to reset your password');
}

// ── App Details (AJAX) ───────────────────────────────────────

/**
 * Calls ?a=getAppDetails with the app_code stored in localStorage.
 * On success, updates the page title / heading with the returned app_name.
 */
function loadAppDetails() {
    var appCode = localStorage.getItem("app_code");
    if (!appCode) return;

    $.ajax({
        url: "../?a=getAppDetails",
        type: "GET",
        data: { app_code: appCode },
        dataType: "text",                          // response is plain String, not JSON
        success: function (response) {
            var appName = $.trim(response);

            console.log("getAppDetails response:", appName);

            // Server-side error – CustomResultObject writes error_id as plain text
            if (!appName || appName === "Invalid App Code") {
                toastr.warning("Invalid App Code. Please re-enter.");
                console.warn("getAppDetails: no app found for code →", appCode);
                resetAppCode();
                return;
            }

            // Success
            updateAppNameDisplay(appName);
            localStorage.setItem("app_name", appName);
        },

        // Network error or non-200 HTTP status
        error: function (jqXHR, textStatus, errorThrown) {
            toastr.error("Could not fetch app details. Please try again.");
            console.error("getAppDetails AJAX error:", {
                status     : jqXHR.status,         // e.g. 404, 500
                textStatus : textStatus,            // "error", "timeout"
                errorThrown: errorThrown,           // e.g. "Internal Server Error"
                response   : jqXHR.responseText     // raw response body
            });
        }
    });
}

/** Pushes app_name into every element that carries [data-app-name]. */
function updateAppNameDisplay(name) {
    $("[data-app-name]").text(name || "");
}

// ── DOM Ready ────────────────────────────────────────────────

$(document).ready(function () {

    /* Password show/hide toggle */
    $("#show_hide_password a").on('click', function (event) {
        event.preventDefault();
        var input = $('#show_hide_password input');
        var icon  = $('#show_hide_password i');
        if (input.attr("type") === "text") {
            input.attr('type', 'password');
            icon.addClass("fa-eye-slash").removeClass("fa-eye");
        } else {
            input.attr('type', 'text');
            icon.removeClass("fa-eye-slash").addClass("fa-eye");
        }
    });

    /* Persist "remember terms" checkbox */
    if (localStorage.getItem("termsAccepted") === "true") {
        $("#termsCheckbox").prop("checked", true);
    }
    $("#termsCheckbox").on("change", function () {
        if ($(this).is(":checked")) {
            localStorage.setItem("termsAccepted", "true");
        } else {
            localStorage.removeItem("termsAccepted");
        }
    });

    /* App-code display – double-click logo to reveal */
    var appCode = localStorage.getItem("app_code");

    if (appCode) {
        $("#displayAppCode").text(appCode);
        loadAppDetails();          // ← fetch app name on page load if code exists
    } else {
        $('#appCodeModal').modal('show');
    }

    $("#profile-img").off("dblclick").on("dblclick", function () {
        $("#currentAppCode").toggle();
    });

    $("#changeAppCode").on("click", function (e) {
        e.preventDefault();
        $('#appCodeModal').modal('show');
    });

    $("#resetAppCode").on("click", function (e) {
        e.preventDefault();
        resetAppCode();
    });

    /* When the modal closes, refresh displayed code and hide the strip */
    $("#appCodeModal").on("hide.bs.modal", function () {
        var code = localStorage.getItem("app_code");
        $("#displayAppCode").text(code ? code : "");
        $("#currentAppCode").hide();
    });
});


