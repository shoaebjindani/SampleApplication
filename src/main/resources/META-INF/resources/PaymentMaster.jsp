<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script>
        function deleteAccountDetails(accountId) {
            var answer = window.confirm("Are you sure you want to delete ?");
            if (!answer) {
                return;
            }
            document.getElementById("closebutton").style.display = 'none';
            document.getElementById("loader").style.display = 'block';
            $('#myModal').modal({
                backdrop: 'static',
                keyboard: false
            });;
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    document.getElementById("responseText").innerHTML = xhttp.responseText;
                    document.getElementById("closebutton").style.display = 'block';
                    document.getElementById("loader").style.display = 'none';
                    $('#myModal').modal({
                        backdrop: 'static',
                        keyboard: false
                    });;
                }
            };
            xhttp.open("GET", "?a=deleteAccount&accountId=" + accountId,
                true);
            xhttp.send();
        }
    </script>



    <c:set var="message" value='${requestScope["outputObject"].get("ListOfAccounts")}' />


    <br>
    <div class="card">









        <div class="card-header">


            <div class="card-tools">
                <div class="input-group input-group-sm" style="width: 200px;">
                    <input type="button" class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddAccount'" value="Add New Account" class="form-control float-right">
                </div>
            </div>

            <div class="card-tools">
                <div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
                    <div class="icon-bar" style="font-size:22px;color:firebrick">
                        <a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a>
                        <a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>
                        <a title="Download Text" onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>
                    </div>
                </div>
            </div>







        </div>






        <!-- /.card-header -->
        <div class="card-body table-responsive p-0" style="height: 800px;">
            <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                <thead>
                    <tr>
                        <th><b>Account Id</b></th>
                        <th><b>Account Name</b></th>
                        <th><b>Account No</b></th>
                        <th><b>IFSC Code</b></th>
                        <th><b>QR Code</b></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${message}" var="item">
                        <tr>
                            <td>${item.account_id}</td>
                            <td>${item.account_name}</td>
                            <td>${item.account_no}</td>
                            <td>${item.ifsc_code}</td>
                            <td>${item.qr_code}</td>
                            <td><a href="?a=showAddAccount&accountId=${item.account_id}">Edit</a></td>
                            <td><button class="btn btn-danger" onclick="deleteAccountDetails('${item.account_id}')">Delete</button></td>
                        </tr>
                    </c:forEach>


                </tbody>
            </table>
        </div>
        <!-- /.card-body -->
    </div>







    <script>
        $(function() {
            $('#example1').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": false,
                "ordering": true,
                "info": true,
                "autoWidth": false,
                "responsive": true,
                "pageLength": 100
            });
        });
        document.getElementById("divTitle").innerHTML = "Account Master ";
    </script>