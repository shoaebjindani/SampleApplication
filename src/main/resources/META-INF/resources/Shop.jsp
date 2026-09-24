<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script>
        function deleteShop(shopId) {
            var answer = window.confirm("Are you sure you want to delete ?");
            if (!answer) {
                return;
            }
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    toastr["success"](xhttp.responseText);
                    toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "1000",
                        "hideDuration": "500",
                        "timeOut": "500",
                        "extendedTimeOut": "500",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }
                    window.location.reload();
                }
            };
            xhttp.open("GET", "?a=deleteShop&shopId=" + shopId, true);
            xhttp.send();
        }
    </script>



    <c:set var="message" value='${requestScope["outputObject"].get("ListOfShops")}' />



    <br>
    <div class="card">

        <div class="card-header">


            <div class="card-tools">
                <div class="input-group input-group-sm" style="width: 200px;">
                    <input type="button" class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddShop'" value="Add New Shop" class="form-control float-right">
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
        <div class="card-body table-responsive p-0" style="height: 580px;">
            <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                <thead>
                    <tr>
                        <th><b>Shop Id</b></th>
                        <th><b>Shop Name</b></th>

                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${message}" var="item">
                        <tr>
                            <td>${item.shopId}</td>
                            <td>${item.shopName}</td>
                            <td><a href="?a=showAddShop&shopId=${item.shopId}">Edit</a></td>
                            <td><button class="btn btn-danger" onclick="deleteShop('${item.shopId}')">Delete</button></td>
                        </tr>
                    </c:forEach>


                </tbody>
            </table>
        </div>
        <!-- /.card-body -->
    </div>







    <script type="javascript">
        $(function () { $('#example1').DataTable({ "paging": true, "lengthChange": false, "searching": false, "ordering": true, "info": true, "autoWidth": false, "responsive": true, "pageLength": 50 }); }); document.getElementById("divTitle").innerHTML="Shop
        Master"; document.title +=" Shop Master "; function searchprod(elementInput,evnt) { if(evnt.which==13) { // do some search stuff window.location="?a=showShopMaster&colNames="+document.getElementById("colNames").value+"&searchInput="+elementInput.value;
        } }


    </script>