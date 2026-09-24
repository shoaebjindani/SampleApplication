<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="message" value='${requestScope["outputObject"].get("CustomerInvoiceHistory")}' />
<c:set var="customerMaster" value='${requestScope["outputObject"].get("customerMaster")}' />
<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />
<c:set var="customerDetails" value='${requestScope["outputObject"].get("customerDetails")}' />



<br>
<div class="card">
<br>

	

	<div class="row">
	
		
		<datalist id="customerList">
			<c:forEach items="${customerMaster}" var="customer">
				<option id="${customer.customerId}">${customer.customerName}</option>			    
			</c:forEach>	   	   	
		</datalist>
		
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
		
		<div class="col-sm-3">
			<div class="form-group"> 
				<div class="input-group input-group-sm">
					<input type="text" class="form-control form-control-sm" id="txtsearchcustomer" placeholder="Search For Customer" name="txtsearchcustomer"  list='customerList' oninput="checkforMatchCustomer()">
					<span class="input-group-append">
						<button type="button" class="btn btn-danger btn-flat" onclick="resetCustomer()">Reset</button>
					</span>  
				</div> 
				
				<input  type="hidden" name="hdnSelectedCustomer" id="hdnSelectedCustomer"  value="">
			</div>
		</div>
		
		<input  type="hidden" name="customerId" id="customerId" value="">
		
		
		
		
		<div class="col-sm-2" align="center">
			<div class="card-tools">
				<div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
					<div class="icon-bar" style="font-size:22px;color:firebrick">
						<a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
						<a title="Download PDF" onclick="exportPDFForSalesSummary()"><i class="fa fa-file-pdf-o"></i></a>
						<a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>    
					</div>           
				</div>
			</div>
		</div>
		
		
	</div>
	<br>

          
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Category Name</b></th>
                     <th><b>Item Name</b></th>
                     <th><b>Product Code</b>
                     </th><th><b>Amount</b></th>
                     <th><b>Quantity Sold</b></th>
                          
                     
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >						
						<td>${item.category_name}</td>
						<td>${item.item_name}</td>
						<td>${item.product_code}</td>
						<td>${item.Amount}</td>
						<td>${item.quantity}</td>
						
						
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
</div>
            
            
            
            



<script type="javascript">


function exportPDFForSalesSummary()
{
	
	window.open("?a=exportPDFForSalesSummary&txtfromdate=${param.txtfromdate}&txttodate=${param.txttodate}&customerId=${param.customerId}");
	return;
	
}



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
   
  
  
  document.getElementById("divTitle").innerHTML="Sales Item Summary Report";
  document.title +=" Sales Item Summary Report ";
  
  $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });



  txtfromdate.value='${txtfromdate}';
  txttodate.value='${txttodate}';
  
  
  if('${param.customerId}'!='')
	{
		txtsearchcustomer.value='${customerDetails.customer_name}';
		hdnSelectedCustomer.value='${customerDetails.customer_id}';
		txtsearchcustomer.disabled=true;
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
	  window.location="?a=showSalesSummaryReport&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value+"&customerId="+hdnSelectedCustomer.value;  	  
  }
  
  function checkforMatchCustomer()
  {
  	var searchString= document.getElementById("txtsearchcustomer").value;
  	if(searchString.length<3){return;}
  	var options1=document.getElementById("customerList").options;
  	var customerId=0;
  	for(var x=0;x<options1.length;x++)
  		{
  			if(searchString==options1[x].value)
  				{
  					customerId=options1[x].id;
  					break;
  				}
  		}
  	if(customerId!=0)
  		{
  			document.getElementById("hdnSelectedCustomer").value=customerId;			
  			document.getElementById("txtsearchcustomer").disabled=true;
			ReloadFilters();      						
  		} 
  	
  	
  }
  
  function checkforLengthAndEnableDisable()
  {
  		if(txtsearchcustomer.value.length>=3)
  			{
  				txtsearchcustomer.setAttribute("list", "hdnSelectedCustomer");
  			}
  		else
  			{
  				txtsearchcustomer.setAttribute("list", "");
  			}
  }
  
  function resetCustomer()
  {	
  	txtsearchcustomer.disabled=false;
  	txtsearchcustomer.value="";
  	hdnSelectedCustomer.value="";
  	ReloadFilters();
  }
  
 
  
</script>