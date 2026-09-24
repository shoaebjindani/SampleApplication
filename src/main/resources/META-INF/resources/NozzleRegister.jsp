<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<br>


<c:set var="message" value='${requestScope["outputObject"].get("CustomerInvoiceHistory")}' />
<c:set var="customerDetails" value='${requestScope["outputObject"].get("customerDetails")}' />
<c:set var="totalDetails" value='${requestScope["outputObject"].get("totalDetails")}' />
<c:set var="lstNozzleRegister" value='${requestScope["outputObject"].get("lstNozzleRegister")}' />
<c:set var="customerMaster" value='${requestScope["outputObject"].get("customerMaster")}' />
<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />
<c:set var="lstPayments" value='${requestScope["outputObject"].get("lstPayments")}' />
<c:set var="salesEmpWiseMap" value='${requestScope["outputObject"].get("salesEmpWiseMap")}' />
<c:set var="paymentEmpWiseMap" value='${requestScope["outputObject"].get("paymentEmpWiseMap")}' />




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
 						<a title="Download PDF" onclick="exportSalesRegister()"><i class="fa fa-file-pdf-o"></i></a>
  						<a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a> 
				</div>          
			</div>
		</div>
	</div>
				
</div>
</br>

         
              
              
               
                
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 480px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                
                 
                    <tr>                  
                      
                     <th><b>Nozzle Name</b></th><th><b>Shift</b></th><th><b>Attendant Name</b></th><th><b>Check In Time</b></th>
                     <th><b>Check Out Time</b></th>
                     <th><b>Opening Reading</b></th>                     
                     <th><b>Closing Reading</b></th>
                     
                     <th><b>Totalizer Opening Amount</b></th>
                     <th><b>Totalizer Closing Amount</b></th>                     
                     <th><b>Totalizer Closing Minus Opening Minus Test Fuel Amount</b> </th>
                     
                     <th><b>Test Fuel</b> </th><th><b>Sales Qty</b> </th>     <th><b>Rate</b> </th> 
                     <th><b>Total Amount</b> </th>
                     
                     
                     <th><b>Supervisor Name</b></th></th>
                     <th><b>Updated Date</b></th>
                     <th><b>Difference</b></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${lstNozzleRegister}" var="item">
					<tr >
						<td>${item.nozzle_name} ${item.item_name}</td>
						<td>${item.shift_name} ${item.from_time} ${item.to_time}</td>
						<td>${item.attendantName}</td>
						<td>${item.check_in_time}</td>
						<td>${item.check_out_time}</td>
												
						<td>${item.opening_reading}</td>
						<td>${item.closing_reading}</td>
						
						<td>${item.totalizer_opening_reading}</td>
						<td>${item.totalizer_closing_reading}</td>
						<td>${item.totalizer_closing_reading - item.totalizer_opening_reading - (item.testFuel*item.rate) }</td>
						
						<td>${item.testFuel}</td>
						<td>${item.diffReading}</td>
						<td>${item.rate}</td>
						<td>${item.totalAmount}</td>
						
						

						
						
						<td>${item.updated_by_supervisor}</td>
						<td>${item.FormattedUpdatedDate}</td>
						<td>${item.totalAmount - (item.totalizer_closing_reading - item.totalizer_opening_reading - (item.testFuel*item.rate))}</td>
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              
              
               
</div>
            
            
            
       
   <div class="card">
 <br>

<div class="row">

	
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 480px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                
                 
                    <tr>                    
                     <th><b>Attendant Name</b></th>
                     <th><b>Shift Id</b></th>
                     <th><b>Date</b></th>
                     
                     <th><b>Cash</b></th>
                     <th><b>Card Swipe</b></th>
                     <th><b>PhonePay</b></th>
                     <th><b>Pending</b></th>
                     
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${lstPayments}" var="paym">
					<tr >
						<td>${paym.name} </td>
						<td>${paym.shift_name} </td>
						<td>${paym.dt} </td>
						
						<td><a href="?a=showSupervisorCollection&txtfromdate=${txtfromdate}&txttodate=${txttodate}&attendant_id=${paym.attendant_id}"> ${paym.csh} </a></td>
						
						<td><a href="?a=generateDailyPaymentRegister&storeId=${userdetails.store_id }&paymentFor=Invoice&paymentMode=Card&txtfromdate=${txtfromdate}&txttodate=${txttodate}&attendant_id=${paym.attendant_id}"> ${paym.cswp} </a></td>
						
						<td><a href="?a=showPaytmTransctions&txtfromdate=${txtfromdate}&txttodate=${txttodate}&attendant_id=${paym.attendant_id}"> ${paym.pytm} </a></td>
						
						<td><a href="?a=generateDailyInvoiceReport&paymentType=Pending,Partial&drpstoreId=${userdetails.store_id }&txtfromdate=${txtfromdate}&txttodate=${txtfromdate}&attendant_id=${paym.attendant_id}"> ${paym.pnding} </a></td>
						

                     						
						
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              
              
               
</div>
                    
    <br>

<div class="row">

	
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 480px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                
                 
                  <th>Name</th>
                  <th>Sales</th>
                  <th>Payments</th>
                  <th>Difference</th>
                 <c:forEach var="entry" items="${salesEmpWiseMap}">
                 
                 <tr>
  					<td><c:out value="${entry.key}"/></td>
  					<td><c:out value="${entry.value}"/></td>
  					<td><c:out value="${paymentEmpWiseMap.get(entry.key)}"/></td>
  					
  					<td>
  						<c:out value="${paymentEmpWiseMap.get(entry.key) - entry.value  }"/>  						
  						<fmt:formatNumber type="number" maxFractionDigits="2" value="${paymentEmpWiseMap.get(entry.key) - entry.value}" />
  							  					
  					</td>
  					  					
  				 </tr>
  				   					
				 </c:forEach>  
				
				
				
                  
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
      "pageLength": 50,
      "order": [[ 2, 'desc' ]]

    });
  });
  
  document.getElementById("divTitle").innerHTML="Nozzle Register";

  document.title +=" Nozzle Register";

  

  $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });



  txtfromdate.value='${txtfromdate}';
  txttodate.value='${txttodate}';
  
  
  
  
  
  function exportSalesRegister()
  {
	
	  
	  window.open("?a=exportSalesRegister&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value+"&customerId="+hdnSelectedCustomer.value);
		return;
	  
	  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		    	//window.location="BufferedImagesFolder/"+xhttp.responseText;		    	
		    	window.open("BufferedImagesFolder/"+xhttp.responseText,'_blank','height=500,width=500,status=no, toolbar=no,menubar=no,location=no');
			}
		  };
		  xhttp.open("GET","?a=exportSalesRegister", true);    
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
	  //alert(hdnSelectedCustomer.value);
	  
  	  window.location="?a=showNozzleRegister&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value;  	  
  }
  
  
 
  
 
  
</script>