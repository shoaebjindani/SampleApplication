<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    `


    <c:set var="AccountDetails" value='${requestScope["outputObject"].get("AccountDetails")}' />





    </head>


    <script>
        function addAccount() {
            document.getElementById("frm").submit();
        }

        function updateItem() {
            document.getElementById("frm").action = "?a=updateItem";
            document.getElementById("frm").submit();
            return;
        }

        function deleteAttachment(id) {
            document.getElementById("closebutton").style.display = 'none';
            document.getElementById("loader").style.display = 'block';
            $("#myModal").modal();
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    document.getElementById("responseText").innerHTML = xhttp.responseText;
                    document.getElementById("closebutton").style.display = 'block';
                    document.getElementById("loader").style.display = 'none';
                    $("#myModal").modal();
                }
            };
            xhttp.open("GET", "?a=deleteAttachment&attachmentId=" + id, true);
            xhttp.send();
        }
    </script>



    <br>

    <div class="container" style="padding:20px;background-color:white">

        <form id="frm" action="?a=addAccount" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
            <div class="row">

                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="email">Account Name</label>
                        <input type="text" class="form-control" id="account_name" value="${AccountDetails.account_name}" placeholder="eg.Savings" name="account_name">
                        <input type="hidden" name="hdnAccountId" value="${AccountDetails.account_id}" id="hdnAccountId">
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="email">Account No</label>
                        <input type="text" class="form-control" id="account_no" value="${AccountDetails.account_no}" placeholder="eg. Account No" name="account_no">

                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="email">IFSC Code</label>
                        <input type="text" class="form-control" id="ifsc_code" value="${AccountDetails.ifsc_code}" placeholder="eg. IFSC Code" name="ifsc_code">

                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="email">Qr Code</label>
                        <input type="text" class="form-control" id="qr_code" value="${AccountDetails.qr_code}" placeholder="eg. qr Code" name="qr_code">

                    </div>
                </div>






                <div class="col-sm-12">
                    <c:if test="${action ne 'Update'}">

                        <button class="btn btn-success" type="button" onclick='addAccount()'>Save</button>
                        <button class="btn btn-danger" type="reset" onclick='window.location="?a=showAccountMasterNew"'>Cancel</button>


                    </c:if>



                    <c:if test="${action eq 'Update'}">

                        <input type="button" type="button" class="btn btn-success" onclick='addAccount()' value="update">
                    </c:if>
                </div>
            </div>
        </form>

        <script type="javascript">


            <c:if test="${AccountDetails.account_id eq null}">
                document.getElementById("divTitle").innerHTML="Add Account";
            </c:if>
            <c:if test="${AccountDetails.account_id ne null}">
                document.getElementById("divTitle").innerHTML="Update Account";
            </c:if>
        </script>