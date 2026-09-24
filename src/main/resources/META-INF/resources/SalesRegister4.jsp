<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="dailyInvoiceData" value='${requestScope["outputObject"].get("dailyInvoiceData")}' />
<c:set var="listStoreData" value='${requestScope["outputObject"].get("listStoreData")}' />

<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />
<c:set var="drpStoreId" value='${requestScope["outputObject"].get("drpStoreId")}' />
<c:set var="type" value='${requestScope["outputObject"].get("type")}' />
<c:set var="customerMaster" value='${requestScope["outputObject"].get("customerMaster")}' />
<c:set var="customerDetails" value='${requestScope["outputObject"].get("customerDetails")}' />
<c:set var="reqData" value='${requestScope["outputObject"]}'/>





<br>
<div class="card">




		<br>

    
              
              
              
              <div class="row">
              
              
              
              
              <datalist id="customerList">

<c:forEach items="${customerMaster}" var="customer">
			    <option id="${customer.customerId}">${customer.customerName}~${customer.mobileNumber}~${customer.customerType}</option>			    
	   </c:forEach>	   	 

  	
</datalist>
              
              
               
              
              
				<div class="col-sm-2" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
  						<input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();ReloadFilters();"  name="txtfromdate" readonly class="form-control date_field" placeholder="From Date"/>
                  </div>
				</div>
				
				<div class="col-sm-2" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
					<input type="text" id="txttodate"  onchange="checkforvalidfromtodate();ReloadFilters();"    name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/>
  						
                    </div>
				</div>
				
				<div class="col-sm-2" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
	  					<select id="drpstoreId" name="drpstoreId"  class="form-control float-right" onchange='ReloadFilters()' style="margin-right: 15px;" >
	  						
	  						<option value='-1'>--Select--</option>  						
	  						<c:forEach items="${listStoreData}" var="store">
								<option value='${store.storeId}'> ${store.storeName}</option>
							</c:forEach>  							
	  					</select>
                  	</div>
				</div>


		

		
				
				<div class="col-sm-2" align="center">
							<div class="card-tools">
		                  <div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
		                    <div class="icon-bar" style="font-size:22px;color:firebrick">
		  						<a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
		 						<a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>
		  						<a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>  
							</div>           
		                  </div>
		                </div>
				</div>
				
			  </div>
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                    
                    
                    
                                        
                     
                     
                     <th><b>Item Name</b></th>
                     <th><b>Amount</b></th> 
                     
                     
                     
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${dailyInvoiceData}" var="item">
				
				
			
						<td>${item.item_name}</td>
						<td>${item.amt}</td>
						
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
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true,
      "pageLength": 50,
      "order": [[ 2, "desc" ]]
    });
  });
  
  document.getElementById("divTitle").innerHTML="Sales Report 4 (Item Wise Sales)";
  document.title +=" Sales Report 4 (Item Wise Sales) ";
  
  
</script>


<script type="javascript">
function ReloadFilters()
{
	  window.location="?a=showSalesReport4&type=${type}&drpstoreId="
			  +drpstoreId.value+"&txtfromdate="+txtfromdate.value+"&txttodate="
			  +txttodate.value+"&drpstoreId="+drpstoreId.value;
	  //
	  
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

$( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });



txtfromdate.value='${txtfromdate}';
txttodate.value='${txttodate}';
drpstoreId.value='${drpStoreId}';

if('${param.customerId}'!='')
	{
		txtsearchcustomer.value='${customerDetails.customer_name}';//
		txtsearchcustomer.disabled=true;
	}



function editInvoice(invoiceId)
{
		window.location="?a=showGenerateInvoice&editInvoice=Y&invoice_id="+invoiceId;
		//alert(invoiceId);
}
function deleteInvoice(invoiceId)
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
		    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
		    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
		    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
		    	  "showMethod": "fadeIn","hideMethod": "fadeOut"}
		    	
		    	window.location.reload();
	      
		  
		}
	  };
	  xhttp.open("GET","?a=deleteInvoice&user_id=${userdetails.user_id}&app_id=${userdetails.app_id}&store_id=${userdetails.store_id}&invoiceId="+invoiceId, true);    
	  xhttp.send();
}


if("${param.deleteFlag}"=="true")
	{
		chkdeletedinvoice.checked=true;
	}
	
function checkforMatchCustomer()
{
	
	var searchString= document.getElementById("txtsearchcustomer").value;	
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
	else
		{
			//searchForCustomer(searchString);
		}
	
	
	
}


function checkforLengthAndEnableDisable()
{
		if(txtsearchcustomer.value.length>=3)
			{
				txtsearchcustomer.setAttribute("list", "customerList");
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
