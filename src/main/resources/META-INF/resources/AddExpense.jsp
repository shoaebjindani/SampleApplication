<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>

.btn-register {
    background: linear-gradient(135deg, #4e73df, #224abe);
    color: #fff;
    border: none;
    border-radius: 12px;
    padding: 13px;
    font-size: 15px;
    font-weight: 700;
    width: 100%;
    margin-top: 12px;
    letter-spacing: 0.03em;
    box-shadow: 0 4px 12px rgba(78,115,223,0.25);
    transition: all 0.2s ease;
}

.btn-register:hover {
    color: #fff;
    transform: translateY(-1px);
}

.btn-register:active {
    transform: scale(0.98);
}
    .date_field { position: relative; z-index: 100; }

    .expense-card {
        background: #fff;
        border-radius: 14px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        padding: 16px;
        margin-bottom: 16px;
    }

    .expense-card .section-label {
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 0.08em;
        text-transform: uppercase;
        color: #888;
        margin-bottom: 10px;
    }

    .field-group {
        margin-bottom: 12px;
    }

    .field-group label {
        font-size: 13px;
        font-weight: 600;
        color: #444;
        margin-bottom: 4px;
        display: block;
    }

    .field-group .form-control,
    .field-group .form-select {
        font-size: 15px;
        border-radius: 10px;
        border: 1.5px solid #e0e0e0;
        padding: 10px 12px;
        background: #fafafa;
        transition: border-color 0.2s;
    }

    .field-group .form-control:focus,
    .field-group .form-select:focus {
        border-color: #4e73df;
        background: #fff;
        box-shadow: 0 0 0 3px rgba(78,115,223,0.1);
    }

    .field-row-2 {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px;
    }

    .field-row-3 {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        gap: 10px;
    }

    .btn-save {
        background: #1cc88a;
        color: #fff;
        border: none;
        border-radius: 12px;
        padding: 13px;
        font-size: 15px;
        font-weight: 700;
        width: 100%;
        margin-bottom: 8px;
        letter-spacing: 0.03em;
        transition: background 0.2s, transform 0.1s;
    }
    .btn-save:active { transform: scale(0.98); background: #17a673; }

    .btn-cancel {
        background: #f8f9fa;
        color: #e74a3b;
        border: 1.5px solid #e74a3b;
        border-radius: 12px;
        padding: 11px;
        font-size: 14px;
        font-weight: 600;
        width: 100%;
        transition: background 0.2s;
    }
    .btn-cancel:active { background: #fde8e6; }

    .expense-list-card {
        background: #fff;
        border-radius: 14px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        overflow: hidden;
        margin-top: 8px;
    }

    .expense-list-header {
        background: #4e73df;
        color: #fff;
        padding: 12px 16px;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 0.05em;
        text-transform: uppercase;
    }

    .expense-row {
        display: flex;
        align-items: center;
        padding: 12px 16px;
        border-bottom: 1px solid #f0f0f0;
        gap: 8px;
    }
    .expense-row:last-child { border-bottom: none; }

    .expense-row-info { flex: 1; min-width: 0; }
    .expense-row-name {
        font-size: 14px;
        font-weight: 600;
        color: #333;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .expense-row-meta {
        font-size: 12px;
        color: #888;
        margin-top: 2px;
    }
    .expense-row-amount {
        font-size: 15px;
        font-weight: 700;
        color: #1cc88a;
        white-space: nowrap;
        margin-right: 8px;
    }
    .btn-del {
        background: #fff0ef;
        color: #e74a3b;
        border: none;
        border-radius: 8px;
        padding: 6px 10px;
        font-size: 13px;
        font-weight: 600;
        flex-shrink: 0;
    }

    .total-bar {
        background: #f8f9fa;
        border-top: 2px solid #e9ecef;
        padding: 14px 16px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 15px;
        font-weight: 700;
        color: #333;
        border-radius: 0 0 14px 14px;
    }
    .total-bar .total-val { color: #e74a3b; font-size: 17px; }

    .empty-state {
        padding: 30px 16px;
        text-align: center;
        color: #aaa;
        font-size: 14px;
    }
</style>

<c:set var="expenseDetails"      value='${requestScope["outputObject"].get("expenseDetails")}' />
<c:set var="totalAmount"         value='${requestScope["outputObject"].get("totalAmount")}' />
<c:set var="todaysDate"          value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="distinctExpenseList" value='${requestScope["outputObject"].get("distinctExpenseList")}' />
<c:set var="expenseList"         value='${requestScope["outputObject"].get("expenseList")}' />
<c:set var="invoiceRegister"     value='${requestScope["outputObject"].get("invoiceRegister")}' />

<div class="container-fluid px-3 py-3 bg-light" style="max-width:640px;">

    <!-- ── Form Card ── -->
    <div class="expense-card">

        <input type="hidden" name="user_id"      value="${userdetails.user_id}">
        <input type="hidden" name="app_id"       value="${userdetails.app_id}">
        <input type="hidden" name="store_id"     value="${userdetails.store_id}">
        <input type="hidden" name="hdnExpenseId" value="${expenseDetails.expense_id}" id="hdnExpenseId">

        <!-- Invoice (Rental/PetrolPump only) -->
        <div id="chooseInvoicePlaceHolder" class="field-group">
            <label>Choose Invoice <span style="font-weight:400;color:#aaa">(optional)</span></label>
            <select id="drpinvoiceid" name="drpinvoiceid" class="form-control">
                <c:forEach items="${invoiceRegister}" var="inv">
                    <option value="${inv.invoice_id}">${inv.invoice_no} ~ ${inv.customer_name} ~ ${inv.total_amount}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Date -->
        <div class="field-group">
            <label>Expense Date</label>
            <input type="text" class="form-control date_field" id="txtdate" name="txtdate" readonly
                value="<c:out value='${expenseDetails.expense_id eq null ? todaysDate : expenseDetails.FormattedExpenseDate}'/>"
                onchange="expenseDateChange()">
        </div>

        <!-- Expense Name (full row) -->
        <div class="field-group">
            <label>Expense Name</label>
            <input type="text" class="form-control" id="expense_name" name="expense_name"
                placeholder="Eg. Tea" value="${expenseDetails.expense_name}" list="distinctExpenseList">
            <datalist id="distinctExpenseList">
                <c:forEach items="${distinctExpenseList}" var="expense">
                    <option value="${expense.expense_name}"></option>
                </c:forEach>
            </datalist>
        </div>

        <!-- Qty + Amount (shared row) -->
        <div class="field-row-2">
            <div class="field-group">
                <label>Qty</label>
                <input type="tel" class="form-control" id="qty" name="qty"
                    placeholder="Eg. 2" value="${expenseDetails.qty}">
            </div>
            <div class="field-group">
                <label>Expense Amount</label>
                <input type="tel" class="form-control" name="amount" id="amount"
                    placeholder="Eg. 300" value="${expenseDetails.amount}">
            </div>
        </div>

        <!-- Payment Mode (Rental/PetrolPump only) -->
        <div id="placeholderpaymentmode" class="field-group">
            <label>Payment Mode</label>
            <select id="drppaymentmode" name="drppaymentmode" class="form-control" onchange="toggleBankDropdown()">
                <option value="Cash">Cash</option>
                <option value="UPI">UPI</option>
                <option value="NetBanking">NetBanking</option>
                <option value="Cheque">Cheque</option>
            </select>
        </div>

        <div id="bankDropdownContainer" class="field-group" style="display:none;">
            <label>From Bank Account</label>
            <select id="drpbankaccount" name="drpbankaccount" class="form-control">
                <option value="">-- Select Bank Account --</option>
            </select>
        </div>

        <!-- Ref + Remarks (Rental/PetrolPump only) -->
        <div class="field-row-2">
            <div class="field-group" id="referenceplaceholder">
                <label>Reference No</label>
                <input type="text" class="form-control" name="paymentrefno" id="paymentrefno"
                    placeholder="Eg. 123456" value="${expenseDetails.payment_ref_no}">
            </div>
            <div class="field-group" id="remarksplaceholder">
                <label>Remarks</label>
                <input type="text" class="form-control" name="remarks" id="remarks"
                    placeholder="Eg. Tea for staff" value="${expenseDetails.remarks}">
            </div>
        </div>

        <!-- Buttons -->
        <button class="btn-save mt-1" type="button" onclick="addExpenseRental()">
            Save Expense
        </button>
        <button class="btn-cancel" type="button" onclick='window.location="?a=showHomePage"'>
            Cancel
        </button>

        <button class="btn-register"
        type="button"
        onclick='window.location="?a=showExpenseEntry"'>

    <i class="fa fa-list-alt mr-2"></i>

    Expense Register

</button>
    </div>

    <!-- ── Expense List Card ── -->
    <div class="expense-list-card">
        <div class="expense-list-header">
            Today's Expenses
        </div>

        <c:choose>
            <c:when test="${empty expenseList}">
                <div class="empty-state">
                    No expenses added yet
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${expenseList}" var="item">
                    <div class="expense-row">
                        <div class="expense-row-info">
                            <div class="expense-row-name">${item.expense_name}</div>
                            <div class="expense-row-meta">                                
                                <c:if test="${not empty item.qty}">  Qty: ${item.qty}</c:if>
                            </div>
                        </div>
                        <div class="expense-row-amount">&#8377;${item.amount}</div>
                        <button class="btn-del" onclick="deleteRentalExpense('${item.expense_id}')">
                            &times;
                        </button>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <div class="total-bar">
            <span>Total Expense</span>
            <span class="total-val">&#8377;${totalAmount}</span>
        </div>
    </div>

</div>

<script>
    $("#txtdate").datepicker({ dateFormat: 'dd/mm/yy' });

    document.getElementById("divTitle").innerHTML = "Add Expense";

    function expenseDateChange() {
        window.location = "?a=showAddExpense&expenseDate=" + txtdate.value;
    }

    function deleteRentalExpense(expenseId) {
        if (!confirm("Are you sure you want to delete?")) return;
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState == 4 && xhttp.status == 200) {
                toastr["success"](xhttp.responseText);
                toastr.options = { "timeOut": "500" };
                window.location.reload();
            }
        };
        xhttp.open("GET", "?a=deleteRentalExpense&expenseId=" + expenseId, true);
        xhttp.send();
    }

    if ("${userdetails.app_type}" != "Rental" && "${userdetails.app_type}" != "PetrolPump") {
        document.getElementById("chooseInvoicePlaceHolder").style.display = "none";
        document.getElementById("placeholderpaymentmode").style.display   = "none";
        document.getElementById("bankDropdownContainer").style.display    = "none";
        document.getElementById("referenceplaceholder").style.display     = "none";
        document.getElementById("remarksplaceholder").style.display       = "none";
    }

    document.addEventListener("DOMContentLoaded", function() {
        if ("${userdetails.app_type}" == "Rental" || "${userdetails.app_type}" == "PetrolPump") {
            fetchBankAccounts();
            toggleBankDropdown();
        }
    });

    function fetchBankAccounts() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                try {
                    var list = JSON.parse(xhttp.responseText);
                    var drp = document.getElementById("drpbankaccount");
                    drp.innerHTML = '<option value="">-- Select Bank Account --</option>';
                    list.forEach(function(b) {
                        var opt = document.createElement("option");
                        opt.value = b.bank_id;
                        opt.text  = b.bank_name + " - " + b.account_no;
                        drp.appendChild(opt);
                    });
                } catch (e) { console.error("Invalid bank JSON", e); }
            }
        };
        xhttp.open("GET", "?a=getBankAccountsByAppId", true);
        xhttp.send();
    }

    function toggleBankDropdown() {
        var mode      = document.getElementById("drppaymentmode").value;
        var container = document.getElementById("bankDropdownContainer");
        if (mode.toLowerCase() === "cash") {
            container.style.display = "none";
            document.getElementById("drpbankaccount").value = "";
        } else {
            container.style.display = "block";
        }
    }

    function addExpenseRental() {
        var payload = {
            expense_name:    document.getElementById('expense_name').value,
            qty:             document.getElementById('qty').value,
            amount:          document.getElementById('amount').value,
            date:            document.getElementById('txtdate').value,
            hdnExpenseId:    document.getElementById('hdnExpenseId').value,
            invoiceId:       document.getElementById('drpinvoiceid') ? document.getElementById('drpinvoiceid').value : '',
            payment_mode:    document.getElementById('drppaymentmode') ? document.getElementById('drppaymentmode').value : '',
            bank_account_id: document.getElementById('drpbankaccount') ? document.getElementById('drpbankaccount').value : '',
            payment_ref_no:  document.getElementById('paymentrefno') ? document.getElementById('paymentrefno').value : '',
            remarks:         document.getElementById('remarks') ? document.getElementById('remarks').value : ''
        };

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                toastr["success"](xhttp.responseText);
                toastr.options = { "timeOut": "500" };
                window.location.reload();
            }
        };
        xhttp.open("POST", "?a=addExpenseRental", true);
        xhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhttp.send(JSON.stringify(payload));
    }
</script>