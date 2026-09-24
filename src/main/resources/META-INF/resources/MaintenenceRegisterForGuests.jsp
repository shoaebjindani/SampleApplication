<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${projectName}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="https://img.icons8.com/emoji/48/000000/cloud-emoji.png" type="image/png">

  <!-- CSS -->
  <link rel="stylesheet" href="css/jquery-ui.css">
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <link rel="stylesheet" href="css/site.css">
  <link rel="stylesheet" href="css/richtext.min.css">
  <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

  <style>
    div.dataTables_wrapper {
      width: 100%;
      overflow-x: auto;
    }
  </style>

  <!-- JS -->
  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
  <script src="dist/js/adminlte.min.js"></script>
  <script src="dist/js/demo.js"></script>
  <script src="js/jquery-ui.js"></script>
  <script src="plugins/toastr/toastr.min.js"></script>
  <script src="plugins/datatables/jquery.dataTables.min.js"></script>
  <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
  <script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
  <script src="js/common.js"></script>
</head>

<script>
  function deleteMaintenence(collectionId) {
    if (!confirm("Are you sure you want to delete ?")) return;

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
      if (xhttp.readyState == 4 && xhttp.status == 200) {
        toastr.success(xhttp.responseText);
        window.location.reload();
      }
    };
    xhttp.open("GET", "?a=deleteMaintenence&collectionId=" + collectionId, true);
    xhttp.send();
  }

  function addCategorypopup() {
    $('#myModal').modal({ backdrop: 'static', keyboard: false });
    document.getElementById("closebutton").style.display = 'none';
    document.getElementById("loader").style.display = 'block';

    let html = `
      <table class="table table-bordered">
        <tr class="bg-warning text-center"><td colspan="2">Add Category</td></tr>
        <tr><td>Category Name</td>
        <td><input id="txtcategorynamepopup" placeholder="Category Name" class="form-control" type="text"></td></tr>
        <tr class="text-center"><td colspan="2"><button class="btn btn-primary" onclick="addCategory()">Add</button></td></tr>
      </table>
    `;

    document.getElementById("responseText").innerHTML = html;
    document.getElementById("closebutton").style.display = 'block';
    document.getElementById("loader").style.display = 'none';
  }

  function addCategory() {
    var catName = document.getElementById('txtcategorynamepopup').value;
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
      if (xhttp.readyState == 4 && xhttp.status == 200) {
        document.getElementById("responseText").innerHTML = xhttp.responseText;
        document.getElementById("closebutton").style.display = 'block';
        document.getElementById("loader").style.display = 'none';
      }
    };
    xhttp.open("GET", "?a=addCategory&categoryName=" + catName, true);
    xhttp.send();
  }

  function reloadFilters() {
    window.location = "?a=showMaintenanceReceiptsForMember&mobile_no=" + txtmobileno.value;
  }

  function openReceipt(receiptno) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
      if (xhttp.readyState == 4 && xhttp.status == 200) {
        window.open("BufferedImagesFolder/" + xhttp.responseText);
      }
    };
    xhttp.open("GET", "?a=generateReceiptPDF&receiptNo=" + receiptno, false);
    xhttp.send();
  }

  $(function () {
    $('#example1').DataTable({
      paging: true,
      lengthChange: false,
      searching: false,
      ordering: true,
      info: true,
      autoWidth: false,
      responsive: false, // Disable "+" button
      scrollX: true,     // Enable horizontal scroll
      pageLength: 100
    });
  });

  document.addEventListener('DOMContentLoaded', () => {
    document.getElementById("divTitle").innerHTML = "Maintenence Register";
  });

  window.addEventListener('keydown', function (e) {
    if (e.which == 113) {
      window.location = '?a=showAddMaintenence';
    }
  });
</script>

<!-- JSTL Variables -->
<c:set var="message" value='${requestScope["outputObject"].get("ListOfCollectMaintenence")}' />
<c:set var="collectionDate" value='${requestScope["outputObject"].get("collectionDate")}' />
<c:set var="listOfBlocks" value='${requestScope["outputObject"].get("listOfBlocks")}' />
<c:set var="listOfFlats" value='${requestScope["outputObject"].get("listOfFlats")}' />

<!-- UI Starts -->
<div class="container-fluid mt-3">
  <div class="card shadow-sm">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Search by Mobile No</h5>
    </div>
    <div class="card-body">
      <div class="row g-3 align-items-center">
        <div class="col-md-4">          
          <input type="number" class="form-control" id="txtmobileno" placeholder="Mobile No">
        </div>
        <div class="col-md-2 d-flex align-items-end">
          <button class="btn btn-success w-100" onclick="reloadFilters()">Submit</button>
        </div>
      </div>
    </div>
  </div>

  <div class="card mt-4">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table id="example1" class="table table-bordered table-striped table-hover nowrap" style="width: 100%;">
          <thead class="table-light text-nowrap">
            <tr>
              <th>Receipt No</th>
              <th>Flat Name</th>
              <th>Amount</th>
              <th>Collection Date</th>
              <th>From Date</th>
              <th>To Date</th>
              <th>Owner Info</th>
              <th>Reference No</th>
              <th>Updated By</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${message}" var="item">
              <tr>
                <td>${item.receipt_no}</td>
                <td>${item.block_name} ${item.flat_name}</td>
                <td>${item.amount}</td>
                <td>${item.collectionDateFormatted}</td>
                <td>${item.maintenenceFromDateFormatted}</td>
                <td>${item.maintenenceToDateFormatted}</td>
                <td>${item.owner_name} ${item.owner_mobile_no}</td>
                <td>${item.reference_no}</td>
                <td>${item.name}</td>
                <td><button class="btn btn-sm btn-outline-primary" onclick="openReceipt('${item.receipt_no}')">Generate PDF</button></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
