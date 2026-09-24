<style>
    .date_field {
        position: relative;
        z-index: 100;
    }
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





    <c:set var="incomeDetails" value='${requestScope["outputObject"].get("incomeDetails")}' />
    <c:set var="totalAmount" value='${requestScope["outputObject"].get("totalAmount")}' />

    <c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
    <c:set var="distinctIncomeList" value='${requestScope["outputObject"].get("distinctIncomeList")}' />
    <c:set var="incomeList" value='${requestScope["outputObject"].get("incomeList")}' />








    </head>



    <script>
        function addIncome() {

            var income_name = document.getElementById('income_name').value
            var amount = document.getElementById('amount').value

            var date = document.getElementById('txtdate').value
            var hdnIncomeId = document.getElementById('hdnIncomeId').value



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
                    window.location.reload()

                }
            };

            xhttp.open("GET", "?a=addIncomeNew&income_name=" + income_name + "&amount=" + amount + "&hdnIncomeId=" + hdnIncomeId + "&date=" + date+"&drppaymentmode="+drppaymentmode.value, true);
            xhttp.send();




            // document.getElementById("frm").submit();
        }
    </script>



    <br>

    <div class="container" style="padding:20px;background-color:white">

        <form id="frm" action="?a=addIncome" method="post" enctype="multipart/form-data" accept-charset="UTF-8">

            <input type="hidden" name="user_id" value="${userdetails.user_id }">

            <input type="hidden" name="callerUrl" id="callerUrl" value="">

            <div class="row">
                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="email">Income Date </label>

                        <c:if test="${incomeDetails.income_id eq null}">
                            <input type="text" class="form-control form-control-sm date_field" id="txtdate" name="txtdate" readonly onchange="incomeDateChange()" value="${todaysDate}" name="txtdate">
                        </c:if>

                        <c:if test="${incomeDetails.income_id ne null}">
                            <input type="text" class="form-control form-control-sm date_field" id="txtdate" name="txtdate" readonly value="${incomeDetails.FormattedIncomeDate}" name="txtdate">
                        </c:if>



                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="email">Income Name</label>
                        <input type="text" class="form-control form-control-sm" id="income_name" name="income_name" placeholder="Eg. Tea" value="${incomeDetails.income_name}" list="distinctIncomeList" name="income_name">
                        <input type="hidden" name="hdnIncomeId" value="${incomeDetails.income_id}" id="hdnIncomeId">
                        <datalist id="distinctIncomeList">
      			   <c:forEach items="${distinctIncomeList}" var="income">
			    		<option id="${income.income_name}">${income.income_name}</option>			    
	   			   </c:forEach>	
	  </datalist>

                    </div>
                </div>



                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="email">Income Amount</label>
                        <input type="tel" class="form-control form-control-sm" name="amount" id="amount" placeholder="Eg. 300" value="${incomeDetails.amount}" name="amount">

                    </div>
                </div>
            </div>
<div class="col-sm-4">
  	<div class="form-group">
      <label for="email">Payment Mode</label>
      <select class="form-control" id="drppaymentmode" name="drppaymentmode" >
      	<option value="CASH">Cash</option>
      	<option value="CHEQUE">Cheque </option>
      	<option value="BANK TRANSFER">Bank Transfer</option>
         </select>     
    </div>
  </div>
            <div class="row">

            </div>

            <div class="row">

            </div>



            <button class="btn btn-success btn-sm " type="button" onclick='addIncome()'>Save</button>
            <button class="btn btn-danger btn-sm" type="reset" onclick='window.location="?a=showIncomeEntry"'>Cancel</button>



        </form>

        <br>
        <br>
        <br>
        <br>

        <div class="card-body table-responsive p-0" style="height: 550px;">
            <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                <thead>
                    <tr>
                        <th><b>Income Id</b></th>
                        <th><b>Income name</b></th>

                        <th><b>Amount</b></th>
                        
                        <th><b>Payment Mode</b></th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${incomeList}" var="item">
                        <tr>
                            <td>${item.income_id}</td>
                            <td>${item.income_name}</td>

                            <td>${item.amount}</td>
                             <td>${item.payment_mode}</td>
                            <td><a href="?a=showAddIncome&incomeId=${item.income_id}">Edit</a></td>
                            <td><button class="btn btn-danger" onclick="deleteIncome('${item.income_id}')">Delete</button></td>
                        </tr>
                    </c:forEach>


                </tbody>
            </table>
        </div>

        <br>
        <br>

        <div class="d-flex justify-content-end">

            <div class="p-2">Total income : <b>${totalAmount}</b></div>
        </div>





        <c:if test="${incomeDetails.income_id eq null}">
            <script>
                document.getElementById("divTitle").innerHTML = "Add Income";
            </script>

        </c:if>
        <c:if test="${incomeDetails.income_id ne null}">
            <script>
                document.getElementById("divTitle").innerHTML = "Update Income";
                document.title += " Update Income ";
            </script>
        </c:if>

        $( "#txtdate" ).datepicker({ dateFormat: 'dd/mm/yy' });


        <script>
            $(function() {

                $('#example1').DataTable({
                    "paging": true,
                    "lengthChange": false,
                    "searching": false,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false,
                    "responsive": false,
                    "pageLength": 50,
                    "order": [
                        [0, "desc"]
                    ]
                });
            });


            function incomeDateChange() {

                window.location = "?a=showAddIncome&incomeDate=" + txtdate.value;
            }
        </script>


        <script>
            function deleteIncome(incomeId) {

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
                xhttp.open("GET", "?a=deleteIncome&incomeId=" + incomeId, true);
                xhttp.send();
            }

            var arr = window.location.toString().split("/");
            callerUrl.value = (arr[0] + "//" + arr[1] + arr[2] + "/" + arr[3] + "/");
        </script>