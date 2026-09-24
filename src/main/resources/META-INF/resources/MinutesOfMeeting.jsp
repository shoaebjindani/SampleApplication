<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .page-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        .form-label {
            font-weight: 500;
            color: #34495e;
        }
        .table thead {
            background-color: #f8f9fa;
        }
        .table td, .table th {
            vertical-align: middle;
            font-size: 0.9rem;
        }
        .card {
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

<c:set var="lstCategory" value='${requestScope["outputObject"].get("lstCategory")}' />
<c:set var="ListOfMOM" value='${requestScope["outputObject"].get("ListOfMOM")}' />
<c:set var="from_date" value='${requestScope["outputObject"].get("from_date")}' />
<c:set var="to_date" value='${requestScope["outputObject"].get("to_date")}' />



<div class="content">
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-12">

                <!-- Toggle Button -->
                <div class="mb-2 d-flex justify-content-end">
                    <button id="toggleFilter" style="background:white" class="btn btn-outline-primary btn-sm">Show Filters</button>
                    <button id="btnaddmom" onclick="window.location='?a=showCaptureMom'" style="background:white" class="btn btn-outline-primary btn-sm">Add MOM</button>
                </div>                

                <!-- Filter Card -->
                <div id="filterBox" style="display: none;">
                    <div class="card mb-3">
                        <div class="card-body">
                            <form method="post" action="MOMService?action=showMOM">
                                <div class="row g-3 align-items-end">

                                    <div class="col-md-3">
                                        <label class="form-label">From</label>
                                        <input type="text" id="from_date"  name="from_date" class="form-control datepicker" value="${from_date}" autocomplete="off" />
                                    </div>

                                    <div class="col-md-3">
                                        <label class="form-label">To</label>
                                        <input type="text" id="to_date" name="to_date" class="form-control datepicker" value="${to_date}" autocomplete="off" />
                                    </div>

                                    <div class="col-md-3">
                                        <label class="form-label">Category</label>
                                        <select name="category" class="form-select" id="category">
                                            <option value="">-- All --</option>
                                            <c:forEach var="cat" items="${lstCategory}">
                                                <option value="${cat.id}" <c:if test="${param.category == cat.id}">selected</c:if>>${cat.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-md-3 d-grid">
                                        <button type="button" onclick="ReloadFilters()" class="btn btn-dark">Apply</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Table Card -->
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Unique MOM No</th>
                                        <th>Category</th>                                        
                                        <th>Meeting Date</th>
										<th>Initiated By</th>                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${ListOfMOM}">
                                        <tr>                                            
                                            <td><a style="color:black;text-decoration: underline" href="#" onclick="openMOM('${row.mom_no}')">${row.mom_no}.pdf</a></td>
                                            <td>${row.category}</td>
                                            <td>${row.mom_date}</td>
                                            <td>${row.initiated_by}</td>                                            
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty ListOfMOM}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted">No data available in table</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" />
<script>
    $(function () {
        $("#from_date, #to_date").datepicker({ dateFormat: 'dd/mm/yy' });

        $("#toggleFilter").click(function () {
            $("#filterBox").slideToggle();
            $(this).text(function (i, text) {
                return text === "Show Filters" ? "Hide Filters" : "Show Filters";
            });
        });
    });

function ReloadFilters()
  {
	window.location="?a=showMinutesOfMeeting&from_date="+from_date.value+"&to_date="+to_date.value+"&category="+category.value;		  
  }

  document.getElementById("divTitle").innerHTML="List Of Meetings";
  document.title +=" List Of Meetings ";


  function openMOM(momNo)
		{
			
			var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() 
			  {
			    if (xhttp.readyState == 4 && xhttp.status == 200) 
			    { 		      
			    	//alert(xhttp.responseText);
			    	window.open("BufferedImagesFolder/"+xhttp.responseText);		  
				}
			  };
			  xhttp.open("GET","?a=generateMOMPdfData&momNo="+momNo, false);    
			  xhttp.send();
			
			
			
			//window.open("BufferedImagesFolder/"+qtName);			
		}

  
</script>
</body>
</html>
