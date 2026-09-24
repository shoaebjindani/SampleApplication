<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta name="viewport" content="width=device-width, initial-scale=1">

<script>
function reloadFilters() {
    const from = document.getElementById("txtfromdate").value;
    const to = document.getElementById("txttodate").value;
    const mode = document.getElementById("drppaymentmode").value;
    window.location = "?actionName=showBankReconciliationReport&txtfromdate=" + from + "&txttodate=" + to + "&paymentMode=" + mode;
}

function checkforvalidfromtodate() {
    var fromDateArr = txtfromdate.value.split("/");
    var toDateArr = txttodate.value.split("/");
    var fromDate = new Date(fromDateArr[2], fromDateArr[1] - 1, fromDateArr[0]);
    var toDate = new Date(toDateArr[2], toDateArr[1] - 1, toDateArr[0]);
    if (fromDate > toDate) {
        alert("From Date should be less than or equal to To Date");
        window.location.reload();
    }
}
</script>

<c:set var="listofpayments" value='${requestScope["outputObject"].get("listofpayments")}' />
<c:set var="paymentSummary" value='${requestScope["outputObject"].get("paymentSummary")}' />
<c:set var="fromDate" value='${requestScope["outputObject"].get("fromDate")}' />
<c:set var="toDate" value='${requestScope["outputObject"].get("toDate")}' />

<div class="card mt-3">
    <div class="container-fluid mt-3">

        <!-- Filters -->
        <div class="row g-2">
            <div class="col-md-3 col-sm-6">
                <label for="txtfromdate">From Date</label>
                <input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();reloadFilters();"
                    name="txtfromdate" readonly class="form-control date_field" placeholder="From Date" />
            </div>

            <div class="col-md-3 col-sm-6">
                <label for="txttodate">To Date</label>
                <input type="text" id="txttodate" onchange="checkforvalidfromtodate();reloadFilters();"
                    name="txttodate" readonly class="form-control date_field" placeholder="To Date" />
            </div>

            <div class="col-md-3 col-sm-6">
                <label for="drppaymentmode">Payment Mode</label>
                <select class="form-control" name="drppaymentmode" id="drppaymentmode" onchange="reloadFilters()">
                    <option value="-1">-- Select --</option>
                    <option value="Cash">Cash</option>
                    <option value="Cheque">Cheque</option>
                    <option value="Bank Transfer">Bank Transfer</option>
                </select>
            </div>

            <div class="col-md-3 col-sm-6 d-flex align-items-end">
                <div class="icon-bar" style="font-size: 22px; color: firebrick;">
                    <a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o"></i></a>&nbsp;
                    <a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>&nbsp;
                    <a title="Download Text" onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>
                </div>
            </div>
        </div>

        <hr />

        <!-- Payment Summary -->
        <h5><b>Summary of Payment Modes</b></h5>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Payment Mode</th>
                        <th>Total Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entry" items="${paymentSummary}">
                        <tr>
                            <td>${entry.key}</td>
                            <td>${entry.value}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <hr />

        <!-- Payment Details Table -->
        <h5><b>Detailed Payments</b></h5>
        <div class="table-responsive" style="max-height: 600px; overflow-y: auto;">
            <table id="example1" class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Flat Name</th>
                        <th>Receipt No</th>
                        <th>Collection Date</th>
                        <th>Amount</th>
                        <th>Payment Mode</th>
                        <th>Reference No</th>
                        <th>Updated By</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listofpayments}" var="item">
                        <tr>
                            <td>${item.flatnames}</td>
                            <td>${item.receipt_nos}</td>
                            <td>${item.txn_date}</td>
                            <td>${item.total_amount}</td>
                            <td>${item.payment_mode}</td>
                            <td>${item.reference_nos}</td>
                            <td>${item.updatedbys}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>

<script>
$(function () {
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

    $("#txtfromdate").datepicker({ dateFormat: 'dd/mm/yy' });
    $("#txttodate").datepicker({ dateFormat: 'dd/mm/yy' });

    document.getElementById("divTitle").innerHTML = "Bank Reconciliation Report";
    document.getElementById("txtfromdate").value = "${fromDate}";
    document.getElementById("txttodate").value = "${toDate}";
    document.getElementById("drppaymentmode").value = "${param.paymentMode}";
});
</script>
