
<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="CategoryAndStoreLedger" value='${requestScope["outputObject"].get("CategoryAndStoreLedger")}' />
<c:set var="storeMaster" value='${requestScope["outputObject"].get("storeMaster")}' />
<c:set var="ListOfStores" value='${requestScope["outputObject"].get("ListOfStores")}' />
<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />
<c:set var="storeId" value='${requestScope["outputObject"].get("storeId")}' />


<br>


<div class="card">

	<br>

	<div class="row">
	
		<div class="col-sm-1" align="center">
			<label for="txtfromdate">From Date</label>
		</div>
	
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();ReloadFilters();"  name="txtfromdate" readonly class="form-control date_field" placeholder="From Date"/>
			</div>
		</div>
		
		<div class="col-sm-1" align="center">
			<label for="txttodate">To Date</label>
		</div>
					
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<input type="text" id="txttodate"  onchange="checkforvalidfromtodate();ReloadFilters();"    name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/>					
		    </div>
		</div>
		
		
		
		<div class="col-sm-3" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
	  					<select id="drpstoreId" name="drpstoreId"  class="form-control float-right" onchange='ReloadFilters()' style="margin-right: 15px;" >
	  						
	  						<option value='-1'>--Select--</option>  						
	  						<c:forEach items="${ListOfStores}" var="store">
								<option value='${store.storeId}'> ${store.storeName}</option>
							</c:forEach>  							
	  					</select>
                  	</div>
				</div>
					
		<div class="col-sm-3" align="right">
			<div class="card-tools">
				<div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
					<div class="icon-bar" style="font-size:22px;color:firebrick">
					<a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
					<a title="Download PDF" onclick="exportPDFForLedger()"><i class="fa fa-file-pdf-o"></i></a>
					<a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>  
					</div>           
				</div>
			</div>
		</div>
			
	</div>
	   
	             
              
	<!-- /.card-header -->
	<div class="card-body table-responsive p-0" style="height: 580px;">                
		<table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">             
			<thead>
				<tr>
					<th><b>Category Name</b></th>
					<th><b>Store Name</b></th>
					<th><b>Amount</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${CategoryAndStoreLedger}" var="item">
					<tr >
						<td>${item.category_name}</td>
						<td>${item.store_name}</td>
						<td>${item.amt1}</td> 
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- /.card-body -->
              
              
	   
</div>

<script type="javascript">
  $(function () {
    
    $('#example1').DataTable({
      "paging": true,      
      "lengthChange": false,
      "searching": false,      
      "info": true,
      "autoWidth": false,
      "responsive": true,
      "pageLength": 50

    });
  });
  
  document.getElementById("divTitle").innerHTML="Category Wise Store Wise Report";
  document.title +=" Category Wise Store Wise Report ";
  

  $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });



  txtfromdate.value='${txtfromdate}';
  txttodate.value='${txttodate}';
  drpstoreId.value="${param.storeId}";
  

  
  function exportPDFForLedger()
  {
	  
	  window.open("?a=exportCustomerLedgerAsPDF&fromDate="+txtfromdate.value+"&toDate="+txttodate.value+"&storeId="+drpstoreId.value);
		return;

  }
  
  function checkforvalidfromtodate()
  {        	
  	var fromDate=document.getElementById("txtfromdate").value;
  	var toDate=document.getElementById("txttodate").value;
  	
  	var fromDateArr=fromDate.split("/");
  	var toDateArr=toDate.split("/");
  	
  	
  	var fromDateArrDDMMYYYY=fromDate.split("/");
  	var toDateArrDDMMYYYY=toDate.split("/");
  	
  	var fromDateAsDate=new Date(fromDateArrDDMMYYYY[2],fromDateArrDDMMYYYY[1]-1,fromDateArrDDMMYYYY[0]);
  	var toDateAsDate=new Date(toDateArrDDMMYYYY[2],toDateArrDDMMYYYY[1]-1,toDateArrDDMMYYYY[0]);
  	
  	if(fromDateAsDate>toDateAsDate)
  		{
  			alert("From Date should be less than or equal to To Date");
  			window.location.reload();        			
  		}
  }
  
  function ReloadFilters()
  {	  
  	  window.location="?a=showCategoryWiseStoreWiseSales&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value+"&storeId="+drpstoreId.value;  	  
  }
  

 
  
  
</script>