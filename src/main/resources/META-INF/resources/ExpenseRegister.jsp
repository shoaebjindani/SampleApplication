<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ListofExpense" value='${requestScope["outputObject"].get("ListofExpense")}' />
<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="totalAmount" value='${requestScope["outputObject"].get("totalAmount")}' />
<c:set var="listStoreData" value='${requestScope["outputObject"].get("listStoreData")}' />

<script>
function deleteExpense(expenseId)
{
    var answer = window.confirm("Are you sure you want to delete ?");
    if (!answer)
    {
        return;
    }

    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function()
    {
        if (xhttp.readyState == 4 && xhttp.status == 200)
        {
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
            };

            window.location.reload();
        }
    };

    xhttp.open("GET", "?a=deleteExpense&expenseId=" + expenseId, true);
    xhttp.send();
}
</script>

<br>

<div class="row">


<div class="col-12">

    <!-- Filter Card -->
    <div class="card">

        <div class="card-body">

            <div class="row">

                <div class="col-12 col-md-3 mb-2">

                    <label>From Date</label>

                    <input type="text"
                           id="txtfromdate"
                           name="txtfromdate"
                           readonly
                           onchange="reloadData()"
                           class="datepicker form-control form-control-sm"
                           placeholder="From Date">

                </div>

                <div class="col-12 col-md-3 mb-2">

                    <label>To Date</label>

                    <input type="text"
                           id="txttodate"
                           name="txttodate"
                           readonly
                           onchange="reloadData()"
                           class="datepicker form-control form-control-sm"
                           placeholder="To Date">

                </div>

            </div>

        </div>

    </div>

    <!-- Expense List -->
    <div class="card">

        <div class="card-body table-responsive p-0">

            <table id="example1"
                   class="table table-striped table-hover mb-0"
                   style="width:100%;">

                <thead>

                    <tr>
                        <th>Expense</th>
                        <th>Date</th>
                        <th class="text-center">Action</th>
                    </tr>

                </thead>

                <tbody>

                    <c:forEach items="${ListofExpense}" var="expense">

                        <tr>

                            <!-- Expense Details -->
                            <td>

                                <div>
                                    <strong>
                                        ${expense.expense_name}
                                    </strong>
                                </div>

                                <div>

    <span class="font-weight-bold"
          style="font-size: 1.2rem;">
        ${expense.amount}
    </span>

    <small class="text-muted ml-2">
        ${expense.payment_mode}
    </small>

</div>

                            </td>

                            <!-- Date -->
                            <td nowrap>

                                ${expense.FormattedExpenseDate}

                            </td>

                            <!-- Actions -->
                            <td class="text-center" nowrap>

                                <a href="?a=showAddExpense&expenseId=${expense.expense_id}"
                                   class="btn btn-link text-primary p-1"
                                   title="Edit">

                                    <i class="fa fa-pencil"></i>

                                </a>

                                <button type="button"
                                        class="btn btn-link text-danger p-1"
                                        title="Delete"
                                        onclick="deleteExpense('${expense.expense_id}')">

                                    <i class="fa fa-trash"></i>

                                </button>

                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>

    </div>

    <!-- Total -->
    <div class="d-flex justify-content-end mt-2">

        <div class="p-2">

            Total Expense :

            <b>₹${totalAmount}</b>

        </div>

    </div>

</div>


</div>

<script>

$(function()
{
    $("#txtfromdate").datepicker({
        dateFormat: 'dd/mm/yy'
    });

    $("#txttodate").datepicker({
        dateFormat: 'dd/mm/yy'
    });
});

$(function()
{
    $('#example1').DataTable({

        paging: true,

        lengthChange: false,

        searching: false,

        ordering: true,

        info: true,

        autoWidth: false,

        responsive: true,

        pageLength: 50,

        order: [[1, "desc"]],

        language: {
            emptyTable: "No expenses found"
        },

        columnDefs: [
            {
                orderable: false,
                targets: 2
            }
        ]

    });
});

document.getElementById("divTitle").innerHTML = "Expense Register";

document.title += " Expense Register ";

function reloadData()
{
    window.location =
        "?a=showExpenseEntry"
        + "&fromDate=" + txtfromdate.value
        + "&toDate=" + txttodate.value;
}

if ('${param.fromDate}' != '')
{
    txtfromdate.value = '${param.fromDate}';
    txttodate.value = '${param.toDate}';
}
else
{
    txtfromdate.value = '${todaysDate}';
    txttodate.value = '${todaysDate}';
}
</script>
