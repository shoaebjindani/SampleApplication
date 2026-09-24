<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />
<br>


<c:set var="message" value='${requestScope["outputObject"].get("CustomerInvoiceHistory")}' />



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
		<td><input type="text" id="txttodate" onchange="checkforvalidfromtodate();ReloadFilters();" name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/></td>						
        </div>
	</div>
	
	<div class="col-sm-2" align="center">
		<div class="card-tools">
			<div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
				<div class="icon-bar" style="font-size:22px;color:firebrick">
				<a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
				<a title="Download PDF" onclick="exportCustomerItemHistory()"><i class="fa fa-file-pdf-o"></i></a>
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
                     <th><b>Invoice Id</b></th><th><b>Invoice Date</b></th><th><b>Updated Date</b>
                     </th><th><b>Customer Name</b></th>
                     <th><b>Item Name</b></th>
                     <th><b>Qty</b></th>
                     <th><b>Custom Rate</b></th>
                     <th><b>Item Amount</b></th>
                     
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
						<td><a href="?a=showGenerateInvoice&invoice_id=${item.invoice_id}">${item.invoice_no}</a></td>
						<td>${item.formattedInvoiceDate}</td>  <td>${item.formattedUpdatedDate}</td>  <td>${item.customer_name}</td>
						<td>${item.item_name}</td>
						<td>${item.qty}</td>
						<td>${item.custom_rate}</td>
						<td>${item.ItemAmount.setScale(2,4)}</td>
						
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

document.getElementById("divTitle").innerHTML="Customer Item Report";
document.title +=" Customer Item Report ";

$( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });


txtfromdate.value='${txtfromdate}';
txttodate.value='${txttodate}';



function exportCustomerItemHistory()
{
	
	  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		    	window.location="BufferedImagesFolder/"+xhttp.responseText;		  
			}
		  };
		  xhttp.open("GET","?a=exportCustomerItemHistory&fromDate1="+txtfromdate.value+"&toDate1="+txttodate.value, true);    
		  xhttp.send();
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
  	  window.location="?a=showCustomerItemHistory&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value;  	  
  }
  
</script>