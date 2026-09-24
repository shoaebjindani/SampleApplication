<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title data-app-name></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="img/favicon.ico" type="image/png" sizes="16x16">

    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../plugins/toastr/toastr.min.css">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;800&family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">

    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../plugins/toastr/toastr.min.js"></script>

    <style>
        /* ======  Theme ====== */
        body, html {
            height: 100%;
            margin: 0;
            background: #f4f5f7;
            font-family: 'Segoe UI', sans-serif;
            color: #333;
        }

        .brand-wrap {
            text-align: center;
            margin: 60px auto 0;
        }

        .brand-logo {
            width: 84px;
            height: 84px;
            margin: 0 auto 18px;
            display: block;
            cursor: pointer;
        }

        .brand-name {
            font-family: 'Playfair Display', 'Segoe UI', serif;
            font-weight: 800;
            font-size: 34px;
            color: #1b2340;
            margin: 0;
        }

        .brand-subtitle {
            font-size: 12px;
            letter-spacing: 2.5px;
            color: #9a8f7a;
            font-weight: 600;
            margin-top: 6px;
            text-transform: uppercase;
        }

        .card-container.card { max-width: 380px; padding: 40px 40px; }

        .card {
            background-color: #ffffff;
            padding: 35px 35px 30px;
            margin: 30px auto 25px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(27,35,64,0.08);
            border: none;
        }

        label.field-label {
            font-size: 11px;
            letter-spacing: 1.5px;
            color: #9aa0ab;
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 6px;
            display: block;
        }

        .input-group {
            width: 100%;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            border: 1.5px solid #1a1a1a;
            border-radius: 30px;
            padding: 4px 6px;
            transition: all 0.2s ease;
        }

        .input-group:focus-within {
            border-color: #d9b76f;
            box-shadow: 0 0 8px rgba(217,183,111,0.6);
        }

        .input-icon {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #c8ad7f;
            font-size: 15px;
            flex-shrink: 0;
        }

        .form-control {
            border: none;
            background: transparent;
            padding: 8px 6px;
            font-size: 15px;
            box-shadow: none !important;
        }

        .form-control:focus { outline: none; box-shadow: none; }

        .form-check { margin-top: 6px; margin-bottom: 10px; }

        a { color: #a6864b; }
        a:hover { text-decoration: underline; color: #8c6e3e; }

        #currentAppCode {
            margin-bottom: 10px;
            text-align: center;
            font-weight: bold;
            color: #6e5b3b;
            display: none;
        }

        #currentAppCode a { margin-left: 10px; font-size: 12px; cursor: pointer; }

        .btn-signin {
            background: #1b2340;
            font-weight: 700;
            font-size: 14px;
            letter-spacing: 1px;
            border-radius: 30px;
            border: none;
            color: #d9b76f;
            padding: 14px;
            box-shadow: 0 4px 10px rgba(27,35,64,0.25);
            transition: all 0.25s ease;
            margin-top: 6px;
        }

        .btn-signin:hover {
            background: #2a3358;
            transform: translateY(-1px);
            color: #f0d9a3;
        }

        .default-creds {
            text-align: center;
            font-size: 12px;
            color: #b7bfca;
            margin-top: 18px;
        }

        .loader {
            border: 16px solid #f3f3f3;
            border-top: 16px solid #c8ad7f;
            border-radius: 50%;
            width: 100px;
            height: 100px;
            animation: spin 2s linear infinite;
        }

        @keyframes spin {
            0%   { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .modal-content  { border-radius: 10px; border: 1px solid #d4b483; }
        .modal-header   { background: #f3e7d1; border-bottom: 1px solid #d4b483; }
        .modal-title    { color: #6e5b3b; font-weight: 600; }
    </style>
</head>

<body>
    <div class="container">

        <!-- Brand header -->
        <div class="brand-wrap">
            <svg id="profile-img" class="brand-logo" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <circle cx="50" cy="50" r="48" fill="#1b2340"/>
                <circle cx="50" cy="50" r="48" fill="none" stroke="#d9b76f" stroke-width="1.5"/>
                <path d="M50 28c-12 0-22 10-22 22s10 22 22 22" fill="none" stroke="#d9b76f" stroke-width="3.5" stroke-linecap="round"/>
                <path d="M50 38c-6.5 0-12 5.5-12 12s5.5 12 12 12" fill="none" stroke="#d9b76f" stroke-width="3.5" stroke-linecap="round"/>
                <circle cx="50" cy="50" r="4.5" fill="#d9b76f"/>
            </svg>
            <h1 class="brand-name" data-app-name></h1>
            <div class="brand-subtitle"><%= Frameworkpackage.CommonFunctions.tagLine != null ? Frameworkpackage.CommonFunctions.tagLine : "" %></div>
        </div>

        <div class="card card-container">

            <div id="currentAppCode" style="display:none;">
                App Code: <span id="displayAppCode"></span>
                <a id="changeAppCode">(Change)</a>
            </div>

            <form method="POST">
                <label class="field-label" for="txtusername">Username</label>
                <div class="input-group">
                    <span class="input-icon"><i class="fa fa-user-circle-o" aria-hidden="true"></i></span>
                    <input type="text" id="txtusername" maxlength="30" name="txtusername"
                           class="form-control" placeholder="admin" required autofocus>
                </div>

                <label class="field-label" for="txtpassword">Password</label>
                <div class="input-group" id="show_hide_password">
                    <span class="input-icon"><i class="fa fa-shield" aria-hidden="true"></i></span>
                    <input class="form-control" type="password" id="txtpassword"
                           placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" name="txtpassword">
                    <span class="input-icon" style="cursor:pointer;">
                        <a href=""><i class="fa fa-eye-slash" aria-hidden="true"></i></a>
                    </span>
                </div>

                <div class="form-check">
                    <input type="checkbox" id="termsCheckbox" class="form-check-input">
                    <label class="form-check-label" for="termsCheckbox">
                        I agree to the <a href="${PRIVACY_POLICY}" target="_blank">Terms and Conditions</a>
                    </label>
                </div>

                <button class="btn btn-lg btn-block btn-signin"
                        type="button" onclick="login()">Sign In</button>
                <button class="btn btn-lg btn-block btn-signin"
                        style="background:transparent; color:#8c8f96; box-shadow:none; font-weight:600;"
                        type="button" onclick="showForgotPasswordScreen()">Forgot Password</button>

<%
    boolean isDeviceRestrictionActive = Boolean.TRUE.equals(Frameworkpackage.CommonFunctions.isDeviceRestrictionEnabled);
    if (isDeviceRestrictionActive) {
%>
                <div class="text-center mt-3 pt-2 border-top small text-muted">
                    <div>
                        <a href="../?a=downloadDeviceAgent" class="text-secondary font-weight-bold small" title="Download Device Agent for your device">
                            <i class="fa fa-download mr-1"></i> Download Device Agent
                        </a>
                    </div>
                </div>
<%
    }
%>
            </form>

            <%
                String patchVersion = "";
                String commitId = "";
                try {
                    java.io.InputStream is = getClass().getClassLoader().getResourceAsStream("git.properties");
                    if (is != null) {
                        java.util.Properties props = new java.util.Properties();
                        props.load(is);
                        String gitTime = props.getProperty("git.commit.time");
                        String abbrevId = props.getProperty("git.commit.id.abbrev");
                        if (gitTime != null && !gitTime.isEmpty()) {
                            patchVersion = gitTime;
                        }
                        if (abbrevId != null && !abbrevId.isEmpty()) {
                            commitId = abbrevId;
                        }
                    }
                } catch (Exception e) {
                    // Ignore
                }
                if (patchVersion != null && !patchVersion.isEmpty()) {
                    String displayVersion = patchVersion;
                    if (!commitId.isEmpty()) {
                        displayVersion += " (" + commitId + ")";
                    }
            %>
                <div class="text-center text-muted mt-3" style="font-size: 11px; margin-top: 15px; color: #888;">
                    Patch Version: <%= displayVersion %>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- App Code Modal -->
    <div class="modal fade" id="appCodeModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Enter App Code</h5>
                </div>
                <div class="modal-body">
                    <input type="text" id="inputAppCode" class="form-control" placeholder="App Code">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-signin" onclick="saveAppCode()">Save</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Custom Device Name Modal -->
    <div class="modal fade" id="customDeviceNameModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-dark text-white py-3">
                    <h5 class="modal-title font-weight-bold" style="font-size: 16px;">
                        <i class="fa fa-shield text-warning mr-2"></i> Register New Device
                    </h5>
                </div>
                <div class="modal-body p-4 text-left">
                    <p class="text-secondary small mb-3">
                        This device is not yet registered in the whitelist. Please enter a friendly device name to submit for Admin approval:
                    </p>
                    <div class="form-group mb-0">
                        <label class="small font-weight-bold text-dark mb-1">Custom Device Name <span class="text-danger">*</span></label>
                        <input type="text" id="inputCustomDeviceName" class="form-control" placeholder="e.g. xyz Phone / xyz Laptop" autofocus>
                    </div>
                </div>
                <div class="modal-footer bg-light border-top-0 py-2">
                    <button type="button" class="btn btn-secondary btn-sm font-weight-bold" onclick="cancelCustomDeviceModal()">Cancel</button>
                    <button type="button" class="btn btn-primary btn-sm font-weight-bold" onclick="submitCustomDeviceNameModal()">Submit Request</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Loader Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" align="center">
                    <div align="center" class="loader" id="loader"></div>
                </div>
                <div class="modal-footer">
                    <button id="closebutton" type="button" onclick='location.reload()'
                            class="btn btn-signin" data-dismiss="modal">Close Me</button>
                </div>
            </div>
        </div>
    </div>

    <!-- External JS (must come after Bootstrap/jQuery are loaded above) -->
    <script src="login.js"></script>
</body>
</html>

<script>
    txtusername.focus();
</script>
