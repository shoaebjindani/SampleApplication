<style>
	th
	{
		vertical-align:middle!important;
	}
	td
	{
		vertical-align:middle!important;
	}
	

</style>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
           
           
           



<c:set var="itemList" value='${requestScope["outputObject"].get("itemList")}' />
<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="invoiceDetails" value='${requestScope["outputObject"].get("invoiceDetails")}' />
<c:set var="tentativeSerialNo" value='${requestScope["outputObject"].get("tentativeSerialNo")}' />
<c:set var="customerMaster" value='${requestScope["outputObject"].get("customerMaster")}' />
<c:set var="categoriesWithItem" value='${requestScope["outputObject"].get("categoriesWithItem")}' />
<c:set var="lsitOfCategories" value='${requestScope["outputObject"].get("lsitOfCategories")}' />
<c:set var="todaysDateMinusOneMonth" value='${requestScope["outputObject"].get("todaysDateMinusOneMonth")}' />




   

<script src="js/searchinvoice.js"></script>




</head>


<script type="javascript">


function saveInvoice()
{
	
	btnsave.disabled=true;
	if((txtpaymenttype.value=="Pending" || txtpaymenttype.value =="Partial") && hdnSelectedCustomer.value =="") 
		{
			alert("This Payment type is not supported for Unknown customers");
			return;
		}
	
	var rows=tblitems.rows;
	
	var requiredDetails=[];
	 
	var arr = [];
	var itemString="";
	var confirmMessage="";
	var proceedFlag=true;
	var messageToShow="";
	for (var x= 1; x < rows.length; x++) 
	{   
	    // ID, QTY, RATE,CustomRate,Item Name,gst amount
	    
	    var arrayReq=rows[x].childNodes[0].childNodes[1].value.split('~');
	    var itemId=arrayReq[0];
	    var productDetailsId=arrayReq[1];
	    
	    itemString+=
	    	itemId+ 
	    "~"+Number(rows[x].childNodes[2].childNodes[0].childNodes[1].value)+
	    "~"+Number(rows[x].childNodes[3].childNodes[0].value)+
	    "~"+Number(rows[x].childNodes[4].childNodes[0].value)+
	    "~"+rows[x].childNodes[1]	.childNodes[0].innerHTML+
	    "~"+rows[x].childNodes[7].childNodes[0].value+
	    "~"+"0"+ // hard coded weight
	    "~"+"0"+ // hard coded size
	    "~"+productDetailsId+
	    "|";
	    
	    var availableQty=Number(rows[x].childNodes[1].childNodes[0].innerHTML.split("(")[1].split(")")[0]);
	    var invoiceQty=Number(rows[x].childNodes[2].childNodes[0].childNodes[1].value);
	    if(invoiceQty>availableQty)
	    	{	    
	    		messageToShow+=rows[x].childNodes[1].childNodes[0].innerHTML+ " Available Stock Quantity ("+availableQty+") vs required quantity ("+invoiceQty+") \n";
	    		showAlert=true;
	    	}   
	}
	
	
	
	var reqString="customer_id="+hdnSelectedCustomer.value+
	"&gross_amount="+grossAmount.innerHTML+
	"&item_discount="+txtitemdiscount.innerHTML+
	"&invoice_discount="+txtinvoicediscount.value+
	"&total_amount="+totalAmount.innerHTML+
	"&payment_type="+txtpaymenttype.value+
	"&payment_mode="+drppaymentmode.value+
	"&paid_amount="+txtpaidamount.value+
	"&invoice_date="+txtinvoicedate.value+
	"&remarks="+txtremarks.value+
	"&hdnPreviousInvoiceId="+hdnPreviousInvoiceId.value+
	"&table_id="+'${param.table_id}'+
	"&booking_id="+'${param.booking_id}'+
	"&appId=${userdetails.app_id}"+
	"&store_id=${userdetails.store_id}"+
	"&user_id=${userdetails.user_id}"+
	"&total_gst="+gst.innerHTML+
	"&itemDetails="+itemString;
	
	
		
	
	

	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) 
	    {
	    	var invoiceId=this.responseText.split("~");
	      	//alert("Invoice Saved Succesfully"+invoiceId[0]);
	      	
	      	if(invoiceId.length==1)
	      		{
	      			alert('An Error Has Occured. Please Contact Support');
	      			resetField();
	      			return;
	      		}
	      	
	      	toastr["success"]("Invoice Saved Succesfully "+invoiceId[0]);
	    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
	    	  "showMethod": "fadeIn","hideMethod": "fadeOut"
	    	}
	      	
	      	
	      	
	      	
	      	
	      	
	      	
	      	
	      	if(typeof chkprintinvoice !='undefined' && chkprintinvoice.checked==true)
      		{
      		
      			// code to communicate with server
      			
      			generateInvoicePdfPrint(invoiceId[1]);
      			return;
      			
      		
      			
      		}
	      	
	      	
	      	if(typeof chkgeneratePDF !='undefined' && chkgeneratePDF.checked==true)
	      		{
	      		
	      			generateInvoice(invoiceId[1]);
	      			
	      		}
	      	
	      	resetField();
	      	 if(invoiceId.length==3)
	      	    {
	      	    	window.location=invoiceId[2];	
	      	    }
	      	btnsave.disabled=false;
	      	document.getElementById("divTitle").innerHTML="Generate Invoice : "+(Number(invoiceId[0])+1);
	      	document.title +=" Generate Invoice :  " +(Number(invoiceId[0])+1);
	    	  
	      
	    }
	  };
	  xhttp.open("POST", "?a=saveInvoice", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");	  
	  xhttp.send(encodeURI(reqString));
	
	
	
}

function resetField()
{
	
	txtcustomerpendingamount.value="0";
	
	document.getElementById("hdnSelectedCustomerType").value=
	grossAmount.innerHTML="0";
	txtitemdiscount.innerHTML="0";
	txtinvoicediscount.value="0";
	txtinvoicediscount.disabled=false;
	totalAmount.innerHTML="0";
	
	txtpaymenttype.value="Paid";
	txtpaymenttype.disabled=false;
	
	drppaymentmode.value="Cash";
	drppaymentmode.disabled=false;
	
	txtpaidamount.value="0";
	txtinvoicedate.value="";
	txtremarks.value="";
	hdnPreviousInvoiceId.value="";	
	
	$("#tblitems").find("tr:gt(0)").remove();

	txtsearchcustomer.value="";
	txtsearchcustomer.disabled=false;
	
	txtinvoicedate.value="${todaysDate}";
	txtinvoicedate.disabled=false;
	txtitem.disabled=false;
	
	txtremarks.value="";
	
	totalQty.innerHTML="0";
	gst.innerHTML="0";
	toReturn.value="0";
	givenByCustomer.value="0";
	
	chkgeneratePDF.checked=false;
	
	var partialPaymentElementsList=document.getElementsByName('partialPaymentElements');
	for(var x=0;x<partialPaymentElementsList.length;x++)
	{
		partialPaymentElementsList[x].style="display:none";
	}
	
	var paymentModeElements=document.getElementsByName('paymentModeElements');
	for(var x=0;x<paymentModeElements.length;x++)
	{
		paymentModeElements[x].style="display:";
	}
	drppaymentmode.value="Cash";
	btnsave.disabled=false;
	
	hdnSelectedCustomer.value='';
	setDefaultChecks();
		
}
function savedInvoiceCallback(data1)
{
		console.log(data1);
}


function updateItem()
{
	
	document.getElementById("frm").action="?a=updateItem"; 
	document.getElementById("frm").submit();
	return;
	
	
}





function deleteAttachment(id)
{
		
		
		
		  document.getElementById("closebutton").style.display='none';
		   document.getElementById("loader").style.display='block';
		$("#myModal").modal();

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		      document.getElementById("responseText").innerHTML=xhttp.responseText;
			  document.getElementById("closebutton").style.display='block';
			  document.getElementById("loader").style.display='none';
			  $("#myModal").modal();
		      
			  
			}
		  };
		  xhttp.open("GET","?a=deleteAttachment&attachmentId="+id, true);    
		  xhttp.send();
		
		
		
}








</script>


<div class="container" style="padding:20px;background-color:white;margin-top:5px;min-width:100%">


<div class="row">
	<div id="row7" class="col-sm-7">
		<form id="frm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="row">
<datalist id="customerList">

<c:forEach items="${customerMaster}" var="customer">
			    <option id="${customer.customerId}">${customer.customerName}~${customer.mobileNumber}~${customer.customerType}</option>			    
	   </c:forEach>	   	 

  	
</datalist>

<datalist id="itemList">
<c:forEach items="${itemList}" var="item">
			    <option id="${item.item_id}">${item.item_name} (${item.product_code}) ~ PR ${item.PurchaseInvoiceNo} ~${item.purchase_details_id} ~ ${item.QtyAvailable}</option>
			    <input type="hidden" id="hdn${item.item_id}" value="${item.item_name}~${item.price}~${item.wholesale_price}~${item.franchise_rate}~${item.loyalcustomerrate3}~${item.loyalcustomerrate2}~${item.loyalcustomerrate1}~${item.distributor_rate}~${item.b2b_rate}~${item.shrikhand}~${item.qty_available}~${item.gst}">			    
	   </c:forEach>	   	   	
</datalist>



<c:if test="${param.invoice_id eq null}">
<div class="col-sm-2">
  	<div class="form-group">
  	<div class="input-group input-group-sm">
                  <input type="text" class="form-control form-control-sm" id="customerName"
                   placeholder="New Customer Name" name="customerName">                           
    </div>
    </div>
  </div>
  
  <div class="col-sm-4">
  	<div class="form-group">
  	<div class="input-group input-group-sm">
                  <input type="text" class="form-control form-control-sm" id="mobileNumber"
                   placeholder="Mobile Number" name="mobileNumber" maxlength="10" onkeypress="digitsOnly(event)">                           
    </div>
    </div>
  </div>
  
  <div class="col-sm-3">
  	<div class="form-group">
  	<div class="input-group input-group-sm">  		
  				<select id="customerType" name="customerType" class="form-control" >
  				
  				
  					
	  				
  				
  				
  				
  				
  					
	  				<option value="LoyalCustomer1">Loyal Customer 1</option>
	  				<option value="LoyalCustomer2">Loyal Customer 2</option>
  				
  				
  				
  				<option value="LoyalCustomer3">Loyal Customer 3</option>
  				<option value="Franchise">Franchise</option>
  				<option value="WholeSeller">WholeSeller</option>
  				<option value="Distributor">Distributor</option>
  				<option value="Business2Business">Business2Business</option>
  				
  				<c:if test="${userdetails.app_id eq '1'}">
  					<option value="shrikhand">Shrikhand Buyers</option>
  				</c:if>
  				
  				<option value="New Customer" selected>New Customer</option>
  				</select>                                             
    </div>
    </div>
  </div>
  
   
  

  
  <div class="col-sm-2">
  	<div class="form-group">
  	<div class="input-group input-group-sm">
                 <span class="input-group-append">
                    <button type="button" class="btn btn-primary btn-flat" onclick="quickAddCustomer()">Quick Add Customer</button>
                  </span>                         
    </div>
    </div>
  </div>

</c:if>

<div class="col-sm-3">
  	<div class="form-group">
  	
  	
  	
  	
  	<div class="input-group input-group-sm">
                  <input type="text" class="form-control form-control-sm" id="txtsearchcustomer"    placeholder="Search For Customer" name="txtsearchcustomer"  autocomplete="off" list='customerList' oninput="checkforMatchCustomer()">
                  
                  <span class="input-group-append">
                    <button type="button" class="btn btn-danger btn-flat" onclick="resetCustomer()">Reset</button>
                  </span>
                  
                  <span class="input-group-append">
                    <button type="button" class="btn btn-primary btn-flat" onclick="addCustomer()">Add</button>
                  </span>
    </div>
  	
  	
        	      
      
            
      <input  type="hidden" name="hdnSelectedCustomer" id="hdnSelectedCustomer" value=""> 
   			<input  type="hidden" name="hdnSelectedCustomerType" id="hdnSelectedCustomerType" value="">
   			<input  type="hidden" name="hdnPreviousInvoiceId" id="hdnPreviousInvoiceId" value="">
   			      
    </div>
  </div>
  
  <div class="col-sm-1">
  	<div class="form-group" align="center"> 	
  		<label><a href="#" onclick="showLedger()">Due</a> </label>  		
  	</div>
  </div>
   <div class="col-sm-1">
  	<div class="form-group"> 	
  		<input type="text" id="txtcustomerpendingamount" name="txtcustomerpendingamount" class="form-control form-control-sm" value="0" readonly/>  		
  	</div>
  </div>

  <div class="col-sm-2">
  	<div class="form-group">	
  		<input type="text" id="txtinvoicedate" name="txtinvoicedate" class="form-control form-control-sm" value="${todaysDate}" placeholder="Invoice Date" readonly/>
  	</div>
  </div>
  
  <div class="col-sm-4">
  	
    
    <div class="input-group">
    <input type="text" class="form-control form-control-sm"    placeholder="Search for Items" list="itemList" id="txtitem" name="txtitem" oninput="checkforMatchItem()">
    
  </div>
  </div>
  
  
  
  
  
  
  
  
  
  <div class="col-sm-12">  
	  <div class="card-body table-sm table-responsive p-0" style="height: 370px;">                
	                <table id="tblitems"  class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                  <thead>
	                    <tr align="center">
	                     
	  			<th style="z-index:0">Name</th>
	  			<th style="z-index:0">Qty</th>	  			
	  			<th style="z-index:0">Rate</th>
	  			<th style="z-index:0">Amount</th>	  			
	  			
	  			<th></th>
	                    </tr>
	                  </thead>
	                </table>
	   </div>	
  </div>
  
  <div class="col-sm-12">  
	  <div class="card-body table-responsive p-0">                
	                <table id="tblTotalItems"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                  <thead>	                   
	                  
	                  	                  	                  
	                  
	                  
	                    <tr>
	                        <th colspan="2" class="text-right">Total Quantity : <span id="totalQty">0</span></th>
	                        
	                        <th colspan="2"class="text-right">Gross Amount : <span id="grossAmount">0</span></th>
	                        	  	
	                        <th colspan="2" class="text-right">Item Discount : <span id="txtitemdiscount">0</span></th> 
	  			
	  			
	  			<th colspan="2" >Invoice Discount</th>	  
	  			<th ><input type="text" class='form-control form-control-sm' id="txtinvoicediscount" value="0" onkeypress="digitsOnlyWithDot(event)" onkeyup="calculateTotal()"></th>		
	  			
	  			
	  			<th ></th>
	  			<th ></th>	  			
	                    </tr>
	                    <tr>
	                        <th colspan="2" class="text-center">Payment Type
	                        <select class='form-control form-control-sm' onchange="paymentTypeChanged(this.value)" id="txtpaymenttype">
	                				<option value="Paid">Paid</option>
	                				<option value="Partial">Partial</option>
	                				<option value="Pending">Pending</option>
	                			</select>   
	                        </th>
	                        
	                        
	                        <th colspan="2" class="text-center" name="paymentModeElements">Payment Mode
		                       <select class='form-control form-control-sm' id="drppaymentmode">		                       
					  				<option value="Cash">Cash</option>		  				
					  				<option value="Paytm">Paytm</option>
					  				<option value="Amazon">Amazon</option>
					  				<option value="Google Pay">Google Pay</option>
					  				<option value="Phone Pay">Phone Pay</option>
					  				<option value="Card">Card</option>
					  				<c:if test="${userdetails.app_id eq '1'}">							  				
						  				<option value="Zomato">Zomato</option>
		  								<option value="Swiggy">Swiggy</option>					  
	  								</c:if>				
			  					</select>
	                        </th>
	                
	                 
	  			
	  				<th name="partialPaymentElements" style="display:none">Paid Amount</th>
	  				<th name="partialPaymentElements" style="display:none"><input type='text' id="txtpaidamount" onkeypress="digitsOnly(event)" onkeyup="calculateTotal()" class='form-control form-control-sm'></th>		
	  				<th name="partialPaymentElements" style="display:none">Pending Amount :-<span id="txtpendingamount">0</span></th>	
	  			<th  class="text-right">Total Amount : <span id="totalAmount">0</span></th>
	  			<th colspan="2" class="text-right" onclick="simulateCheck()">GST : <span id="gst">0</span> <br><input type="checkbox" style="display:none" readonly id="chkgstEnabled" onclick="getGSTForAllItems();"></th>
	  			<td colspan="4"><input type="text" id="txtremarks" name="txtremarks" class="form-control form-control-sm" placeholder="Remarks"></td>	
	                    </tr>
	                    
	                  </thead>
	                </table>
	   </div>	
  </div>
  
   
  
  
	   	
   <div class="col-sm-6">
	  	 <div class="form-group" align="center">	  
		   <input type="checkbox" class="form-check-input" id="chkgeneratePDF">
	    	<label class="form-check-label" for="chkgeneratePDF">Generate PDF</label>
	    	<br>
	    	<label class="form-check-label" >Amount From Customer</label>	    	
	    	<input type="text" class="form-control" id="givenByCustomer" onkeypress='digitsOnlyWithDot(event)' onkeyup='calculateReturnAmount()'>    	
	   	 </div>
	   	 
	   	 	   	 
   </div>
   
   <div class="col-sm-6">
  	 <div class="form-group" align="center">	  
	   <input type="checkbox" class="form-check-input" id="chkprintinvoice">
	   
    	<label class="form-check-label" for="chkprintinvoice">Print Invoice</label>
    	<br>
	    	<label class="form-check-label" >Amount To Return</label>
    	<input type="text" readonly class="form-control" id="toReturn">    	
   </div>
   
   
   
   
   </div>
   
   	
  
  
 <div class="col-sm-12">
  	 <div class="form-group" align="center">	  
	   	<button class="btn btn-success" type="button" id="btnsave" onclick='saveInvoice()'>Save (F2)</button>   
	   <button class="btn btn-danger" type="reset" onclick='window.location="?a=showHomePage"'>Cancel</button>
	   <button class="btn btn-primary" id="btnRegister" type="reset" onclick='window.open("?a=generateDailyInvoiceReport&txtfromdate=${todaysDate}&txttodate=${todaysDate}&txtstore=${userdetails.store_id}")'>Register</button>
	   
	  	   
	   <button class="btn btn-primary" style="display:none" id="generatePDF" type="button" onclick='generateInvoice("${invoiceDetails.invoice_id}");'>Generate PDF</button>
   </div>
   </div>
  
</div>
</form>
	</div>
	
	
	<div class="col-sm-5" id="categoryPopulate">
		
	</div>
	
</div> 







<script type="javascript">

function generateInvoice(invoiceId)
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
	  xhttp.open("GET","?a=generateInvoicePDF&invoiceId="+invoiceId, false);    
	  xhttp.send();
}


function generateInvoicePdfPrint(invoiceId)
{
	
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 	
	    	//window.open("BufferedImagesFolder/"+xhttp.responseText);		  

	    	try
  			{
      		var xhttp2 = new XMLHttpRequest();
      		xhttp2.onreadystatechange = function() {
      	    if (xhttp2.readyState == 4 && xhttp2.status == 200) 
      	    {
      	      //alert(xhttp2.responseText);
      	      
      	      
      	   
      	      
      	      
      	    }
      	  };
      	xhttp2.open("POST", "http://localhost:786/invoiceId="+invoiceId, false);
      	xhttp2.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      	xhttp2.send();
  			}
  			catch(ex)
  			{
  				resetField();
  				console.log(ex.message);
  			}
	    	
	    	
	    	
	    	
	    	
	    	
	    			  
		}
	  };
	  xhttp.open("GET","?a=generateInvoicePDF&invoiceId="+invoiceId, false);    
	  xhttp.send();
}
function searchForCustomer(searchString)
{	
	//if(searchString.length<3){return;}

	document.getElementById("closebutton").style.display='none';
	   document.getElementById("loader").style.display='block';
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	    	var cusomerList=JSON.parse(xhttp.responseText);
	    	var reqString="";
	    	for(var x=0;x<cusomerList.length;x++)
	    	{
	    		//console.log(cusomerList[x]);
	    		reqString+="<option id="+cusomerList[x].customer_id+">"+cusomerList[x].customer_name+"~"+cusomerList[x].mobile_number+"~"+cusomerList[x].customer_type+"</option>";
	    	}
	    	
	    	document.getElementById('customerList').innerHTML=reqString;
		}
	  };
	  xhttp.open("GET","?a=searchForCustomer&searchString="+searchString, true);    
	  xhttp.send();
	
	 
	
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
					txtitem.focus();
					break;
				}
		}
	if(customerId!=0)
		{
			document.getElementById("hdnSelectedCustomer").value=customerId;			
			document.getElementById("txtsearchcustomer").disabled=true;			
			document.getElementById("hdnSelectedCustomerType").value=document.getElementById("txtsearchcustomer").value.split("~")[2];
			fetchPendingAmountForThisCustomer(customerId);	
		}
	else
		{
			//searchForCustomer(searchString);
		}
	
	
	
}


function fetchPendingAmountForThisCustomer(customerId)
{
	document.getElementById("closebutton").style.display='none';
	   document.getElementById("loader").style.display='block';
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	    	var details=JSON.parse(xhttp.responseText);	    	
	    	if(details.pendingAmountDetails.PendingAmount!=undefined)
	    		{
	    			txtcustomerpendingamount.value=details.pendingAmountDetails.PendingAmount;
	    		}
	    	else
	    		{
					//alert("no pending amount for this customer");
	    			//window.location.reload();
	    		}
		}
	  };
	  xhttp.open("GET","?a=getPendingAmountForCustomer&customerId="+customerId, true);    
	  xhttp.send();
}


function checkforMatchItem()
{
	
	
	
	var searchString= document.getElementById("txtitem").value;	
	var options1=document.getElementById("itemList").options;
	
	var itemId=0;
	var purchaseDetailsId=0; 
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
				itemId=options1[x].id;
				purchaseDetailsId=options1[x].innerHTML.split('~')[2];				
					break;
				}
		}
	if(itemId!=0)
		{
				// code to check if item already exist inselection				
				getItemDetailsAndAddToTable(itemId,purchaseDetailsId);
				document.getElementById("txtitem").value="";
		}
	else
		{	
			var count=0;
			var ReqString="";
			for(var x=0;x<options1.length;x++)
				{
				var prodCode = options1[x].value.substring(
						options1[x].value.indexOf("(") + 1, 
						options1[x].value.lastIndexOf(")")
					);
					if(prodCode==(searchString.toLowerCase()))
						{
							count++;
							ReqString=options1[x].value;
						}
				}
			
			if(count==1)
				{
					document.getElementById("txtitem").value=ReqString;
					checkforMatchItem();
				}
			
		}
	
}


function getItemDetailsAndAddToTable(itemId,purchaseDetailsId)
{
		      
	
	

		var itemDetails=document.getElementById("hdn"+itemId).value.split("~");
		
	
	    	
	    	console.log(itemDetails);
	    	var table = document.getElementById("tblitems");	    	
	    	var row = table.insertRow(-1);	    	
	    	var cell1 = row.insertCell(0);
	    	var cell2 = row.insertCell(1);
	    	var cell3 = row.insertCell(2);
	    	var cell4 = row.insertCell(3);
	    	var cell5 = row.insertCell(4);
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	cell1.innerHTML = "</div>" +"<input type='hidden' value='"+itemId+"~"+purchaseDetailsId+"'>"+"<a onclick=window.open('?a=showItemHistory&itemId="+itemId+"') href='#'>"+ itemDetails[0] + " "+ "(" + itemDetails[10]+ " ) </a>";
	    	//cell3.innerHTML = " <input type='text' class='form-control form-control-sm'  id='txtqty"+itemId+"' onkeyup='calculateAmount(this);checkIfEnterisPressed(event,this);' onblur='formatQty(this)' onkeypress='digitsOnlyWithDot(event);' value='1'> <input type='hidden' class='form-control form-control-sm'  readonly id='hdnavailableqty"+itemId+"' value="+itemDetails[10]+">";
	    	
	    	cell2.innerHTML = '<div class="input-group"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity('+itemId+',0)"><i class="fa fa-minus"></i></button></span><input type="text" style="text-align:center" class="form-control form-control-sm"  id="txtqty'+itemId+'" onkeyup="calculateAmount('+itemId+');checkIfEnterisPressed(event,this);" onblur="formatQty(this)" onkeypress="digitsOnlyWithDot(event);" value="1"> <input type="hidden" class="form-control form-control-sm"  readonly id="hdnavailableqty'+itemId+'" value='+itemDetails[10]+'><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity('+itemId+',1)"><i class="fa fa-plus"></i></button></span></div>';
	    	
	    	//cell4.innerHTML = '<input type="text" readonly class="form-control form-control-sm" value="'+itemDetails[1]+'" id="txtrate'+itemId+'">'; // Sana Rate
	    	cell3.innerHTML = "<input type='text' class='form-control form-control-sm' id='txtcustomrate"+itemId+"'   onkeyup='calculateAmount("+itemId+");checkIfEnterisPressed(event,this)' onkeypress='digitsOnlyWithDot(event)' value="+getPriceForThisCustomer(itemDetails)+">";
	    	
	    	//cell6.innerHTML = 0;
	    	cell4.innerHTML = "<input type='text' class='form-control form-control-sm' value='0' id='txtamount"+itemId+"' onkeyup='calculateQtyFromAmount("+itemId+")'>";
	    	
	    	
	    	
		    //cell6.innerHTML = "<input type='text' class='form-control form-control-sm' value='0' readonly id='gst"+itemId+"' onkeyup='calculateAmount("+itemId+")'> <input type='hidden' id='hdngst"+itemId+"' value=" +itemDetails[11]+ ">";
		    
	    	cell5.innerHTML = '<button type="button" style="color:red" class="btn btn-default btn-sm" onclick=removethisitem(this)><i class="far fa-trash-alt"></i></button>';
	    	
	    	
	    	
	    	calculateAmount(itemId);
	    	document.getElementById("txtqty"+itemId).select();
	    	document.getElementById("txtqty"+itemId).focus();
	    	
			
}



function calculateAmount(itemId)
{
	var customrate=document.getElementById('txtcustomrate'+itemId).value;
	var rate=document.getElementById('txtrate'+itemId).value;
	var qty=document.getElementById('txtqty'+itemId).value;
	var amount=(Number(customrate) *Number(qty) ).toFixed(2);
		 
	
	document.getElementById('txtqty'+itemId).parentNode.parentNode.parentNode.childNodes[6].childNodes[0].value= (Number(customrate) *Number(qty) ).toFixed(2);
	
	var itemDiscount=(Number(rate) - Number(customrate)) *  Number(qty);
	
	
	var itemGSTPercentage=document.getElementById('hdngst'+itemId).value;
	
	var GSTAmount=0;
	if(chkgstEnabled.checked)
		{
			GSTAmount=(Number(customrate) *Number(qty) )*itemGSTPercentage / 100;
		}
	
	document.getElementById('gst'+itemId).value=GSTAmount;
	
	document.getElementById('txtqty'+itemId).parentNode.parentNode.parentNode.childNodes[5].innerHTML=Number(itemDiscount).toFixed(2);
	
	
	calculateTotal();
}

function checkIfEnterisPressed(evt,txtbox)
{
	
	if(evt.which!=13)
	{
		return;
	}
	
	if((txtbox.id.toString().indexOf('txtqty')!=-1)) // means that enter is pressed on qty
		{
			var itemId=txtbox.id.replace('txtqty','');
			document.getElementById('txtcustomrate'+itemId).focus();
			document.getElementById('txtcustomrate'+itemId).select();			
		}
	
	if((txtbox.id.toString().indexOf('txtcustomrate')!=-1)) // means that enter is pressed on customrate 
	{
		txtitem.focus();
	}
	
		
}

function paymentTypeChanged(selection)
{
		if(selection=="Partial")
			{
				var partialPaymentElementsList=document.getElementsByName('partialPaymentElements');
				for(var x=0;x<partialPaymentElementsList.length;x++)
				{
					partialPaymentElementsList[x].style="display:";
				}
			}
		else
		{
			var partialPaymentElementsList=document.getElementsByName('partialPaymentElements');
			for(var x=0;x<partialPaymentElementsList.length;x++)
			{
				partialPaymentElementsList[x].style="display:none";
			}
		}
		
		
		
		
		if(selection=="Pending")
		{
			var paymentModeElements=document.getElementsByName('paymentModeElements');
			for(var x=0;x<paymentModeElements.length;x++)
			{
				paymentModeElements[x].style="display:none";
			}
			
			drppaymentmode.value="NA";
		}
		else
		{
			var paymentModeElements=document.getElementsByName('paymentModeElements');
			for(var x=0;x<paymentModeElements.length;x++)
			{
				paymentModeElements[x].style="display:";
			}
			drppaymentmode.value="Cash";
		}
		
}

function calculateTotal()
{	
		var total=0;
		var totalQtyCalculated=0;
		var totalDiscountCalculated=0;
		var grossAmountCalculated=0;
		var totalGSTCalculated=0;
		
		var rows=tblitems.rows;
		for(var x=1;x<rows.length;x++)
			{
				var itemTotalAmount=Number(rows[x].childNodes[6].childNodes[0].value);
				total+=itemTotalAmount;
				
				var itemQty=Number(rows[x].childNodes[2].childNodes[0].childNodes[1].value);
				
				totalQtyCalculated+=itemQty;
				
				var rate=Number(rows[x].childNodes[3].childNodes[0].value);
				var grossItemAmount=itemQty*rate;
				totalDiscountCalculated+=grossItemAmount  -itemTotalAmount;
				
				grossAmountCalculated+=grossItemAmount;
				
				
				totalGSTCalculated+=Number(rows[x].childNodes[7].childNodes[0].value)
			}
		
		
		total=total-txtinvoicediscount.value+totalGSTCalculated;
		totalAmount.innerHTML=Number(total).toFixed(2);
		totalQty.innerHTML=Number(totalQtyCalculated).toFixed(2);
		txtitemdiscount.innerHTML=Number(totalDiscountCalculated).toFixed(2);
		grossAmount.innerHTML=Number(grossAmountCalculated).toFixed(2);
		
		txtpendingamount.innerHTML=Number(total-txtpaidamount.value).toFixed(2);
		// 
		if(chkgstEnabled.checked)
			{
				gst.innerHTML=Number(totalGSTCalculated).toFixed(2);
			}
		else
			{
				gst.innerHTML=0;
			}
		
		
		calculateReturnAmount();
}

function removethisitem(btn1)
{
	btn1.parentElement.parentElement.remove();
	//reshuffle id's next to this
	
	reshuffleSrNos();
	
	calculateTotal(); 
}

function reshuffleSrNos()
{
	var rows1=tblitems.rows;
	for(var x=1;x<rows1.length;x++)
		{
			rows1[x].childNodes[0].childNodes[0].innerHTML=x;
		}
}

document.getElementById("divTitle").innerHTML="Generate Invoice:- "+"${tentativeSerialNo}";
document.title +=" Generate Invoice:- "+"${tentativeSerialNo} ";
$("#divBackButton").attr("href", "https://www.w3schools.com/jquery/");


$( "#txtinvoicedate" ).datepicker({ dateFormat: 'dd/mm/yy' });
if('${invoiceDetails.invoice_id}'!='')
	{
		
		
		

		document.getElementById("divTitle").innerHTML="Invoice No:-"+"${invoiceDetails.invoice_no}";
		document.title +=" Invoice No:-"+"${invoiceDetails.invoice_no} ";
		hdnSelectedCustomer.value="${invoiceDetails.customer_id}"
		
			
		if('${invoiceDetails.customer_name}'!='')
			{
				txtsearchcustomer.value="${invoiceDetails.customer_name}~${invoiceDetails.mobile_number}~${invoiceDetails.customer_type}";			
			}
		
		
		document.getElementById("hdnSelectedCustomerType").value='${invoiceDetails.customer_type}';
		txtinvoicedate.value="${invoiceDetails.theInvoiceDate}";
		totalQty.innerHTML="${invoiceDetails.totalQuantities}";
		grossAmount.innerHTML="${invoiceDetails.gross_amount}";
		txtitemdiscount.innerHTML="${invoiceDetails.item_discount}";
		txtinvoicediscount.value="${invoiceDetails.invoice_discount}";
		txtpaymenttype.value="${invoiceDetails.payment_type}";
		
		totalAmount.innerHTML="${invoiceDetails.total_amount}";
		gst.innerHTML="${invoiceDetails.total_gst}";
		txtpaidamount.value="${invoiceDetails.paid_amount}";
		paymentTypeChanged(txtpaymenttype.value);
		txtpendingamount.innerHTML=Number(totalAmount.innerHTML)-Number(txtpaidamount.value);
		txtremarks.value='${invoiceDetails.remarks}';
		drppaymentmode.value="${invoiceDetails.payment_mode}";
		
		var m=0;
		var tableNo="";
		<c:forEach items="${invoiceDetails.listOfItems}" var="item">
		
		m++;
		tableNo='${item.table_no}';
		var table = document.getElementById("tblitems");	    	
    	var row = table.insertRow(-1);	    	
    	var cell1 = row.insertCell(0);
    	var cell2 = row.insertCell(1);
    	var cell3 = row.insertCell(2);
    	var cell4 = row.insertCell(3);
    	var cell5 = row.insertCell(4);
    	var cell6 = row.insertCell(5);
    	var cell7 = row.insertCell(6);
    	var cell8 = row.insertCell(7);
    	var cell9 = row.insertCell(8);
    	
    	
    	
    	cell1.innerHTML = '<div>'+m+'</div><input type="hidden" value="${item.item_id}">';    	
    	cell2.innerHTML = '<a href="#">${item.item_name} ( )</a>';
    	//cell3.innerHTML = " <input type='text' class='form-control form-control-sm' id='txtqty"+${item.item_id}+"' onkeyup='calculateAmount(${item.item_id});checkIfEnterisPressed(event);' onblur='formatQty(this)' onkeypress='digitsOnlyWithDot(event);' value='${item.qty}'> <input type='hidden' readonly id='hdnavailableqty"+${item.item_id}+"'>";
    	cell3.innerHTML = '<div class="input-group"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(${item.item_id},0)"><i class="fa fa-minus"></i></button></span><input type="text" style="text-align:center" class="form-control form-control-sm"  id="txtqty${item.item_id}" onkeyup="calculateAmount(${item.item_id});checkIfEnterisPressed(event,this);" onblur="formatQty(this)" onkeypress="digitsOnlyWithDot(event);" value="${item.qty}"> <input type="hidden" class="form-control form-control-sm"  readonly id="hdnavailableqty${item.item_id}" value="${item.qty}"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(${item.item_id},1)"><i class="fa fa-plus"></i></button></span></div>';
    	cell4.innerHTML = '<input type="text" readonly class="form-control form-control-sm" value="${item.rate}" id="txtrate${item.item_id}">';
    	
    	cell5.innerHTML = '<input typ="text" id="txtcustomrate${item.item_id}"  class="form-control form-control-sm" value="${item.custom_rate}" onkeyup="calculateAmount(${item.item_id})" onkeypress="digitsOnlyWithDot(event)">';
    	cell6.innerHTML = Number((Number('${item.rate}') * Number('${item.qty}')) - (Number('${item.custom_rate}') * Number('${item.qty}'))).toFixed(2);
    	var itemTotal=Number('${item.custom_rate}') * Number('${item.qty}');
    	cell7.innerHTML ='<input typ="text" class="form-control form-control-sm" value="'+itemTotal+'">';
    	cell8.innerHTML ="<input type='text' class='form-control form-control-sm' value='${item.gst_amount}' readonly id='gst${item.item_id}' onkeyup='calculateAmount(${item.item_id})'> <input type='hidden' id='hdngst${item.item_id}' value='${item.gst}'>";//
    	
		cell9.innerHTML = '<button type="button" class="btn btn-sm btn-danger"  onclick=removethisitem(this) id="btn11" name="deleteButtons" style="cursor:pointer">Delete</button> <button type="button" class="btn btn-primary"  onclick=returnThisItem("${item.details_id}") name="returnButtons" id="btn11" style="cursor:pointer">Return (${item.ReturnedQty})</button>';
    	
		
	    		//alert('${item.item_id}'+'-${item.item_name}'+'-${item.qty}'+'-${item.rate}'+'-${item.custom_rate}');			    
		</c:forEach>
 
		
		if('${param.editInvoice}'=='Y')
			{
				hdnPreviousInvoiceId.value="${invoiceDetails.invoice_id}";
				var returnButtons=document.getElementsByName('returnButtons');
				for(var m=0;m<returnButtons.length;m++)
					{
						returnButtons[m].style="display:none";
					}
				txtsearchcustomer.disabled=true;
				//txtinvoicedate.disabled=true;
				document.getElementById("divTitle").innerHTML="Edit Invoice:-"+"${invoiceDetails.invoice_no}";
				document.title +=" Edit Invoice:- "+ " ${invoiceDetails.invoice_no} ";
			}
		else
			{
				$("#frm :input").prop('disabled', true);
				$("[name=returnButtons]").prop('disabled', false);
				
				
				var deleteButtons=document.getElementsByName('deleteButtons');
				for(var m=0;m<deleteButtons.length;m++)
					{
						deleteButtons[m].style="display:none";
					}
			}
		
		if('${param.table_id}'!='')
			{
				calculateTotal();
				txtpaymenttype.value='Paid';
				drppaymentmode.value='Cash';
				txtsearchcustomer.disabled=false;
				txtinvoicedate.disabled=false;
				document.getElementById("divTitle").innerHTML="Invoice For Table No:-"+tableNo;
				document.title +=" Invoice For Table No:- "+tableNo;
				txtinvoicediscount.value=0;
			}
		
		if('${param.booking_id}'!='' || '${param.mobile_booking_id}'!='')
		{
			calculateTotal();
			txtpaymenttype.value='Paid';
			drppaymentmode.value='Cash';
			txtsearchcustomer.disabled=true;
			txtinvoicedate.disabled=false;
			document.getElementById("divTitle").innerHTML="Invoice For Booking Id - ${param.booking_id}";
			document.title +=" Invoice For Booking Id - ${param.booking_id} ";
			txtinvoicediscount.value=0;
		}
		
		document.getElementById("generatePDF").style="display:";
		generatePDF.disabled=false;
		btnRegister.disabled=false;
		
	}
	
	
function returnThisItem(detailsId)
{
		window.location="?a=showReturnScreen&detailsId="+detailsId;
}
function resetCustomer()
{
	window.location.reload();
	txtsearchcustomer.disabled=false;
	txtsearchcustomer.value="";
	hdnSelectedCustomer.value=0;	
}

function addCustomer()
{
	window.open("?a=showAddCustomer&mobileNo="+txtsearchcustomer.value);	
}


function calculateQtyFromAmount(itemId)
{	
	var amount=document.getElementById('txtamount'+itemId).value;
	var customRate=document.getElementById('txtcustomrate'+itemId).value;
	var qty=Number(amount)/Number(customRate);
	document.getElementById('txtqty'+itemId).value=qty;
	calculateTotal();
}

function formatQty(qtyTextBox)
{
	qtyTextBox.value=Number(qtyTextBox.value).toFixed(3);
		
}
function showItems(categoryname)
{
	
	
	
	var reqString='<div class="container" style="height: 80vh;overflow-y: auto; 	min-width:100%" ><div class="row">';
	const array = [];
	
	<c:forEach items="${itemList}" var="item">	
	var itemName="${item.item_name}";
	
	var categoryName="${item.category_name}"
		if (!array.includes(categoryName))
			{
		    	array.push(categoryName);
			}	
		if(categoryname==undefined || "${item.category_name}"==categoryname)
			{
				reqString+='<div class="col-sm">'
					reqString+='<img style="padding:5px" onclick="showThisItemIntoSelection(${item.item_id})" height="80px" width="80px" src="BufferedImagesFolder/${item.ImagePath}">';
					reqString+="<div>${item.item_name}</div>";
				reqString+='</div>';
			}
			
	</c:forEach>
	reqString+='</div></div>';
	
	var categoryString='<div class="container" style="min-width:100%"  ><div class="row">';
	for(var m=0;m<array.length;m++)
		{
			if(array[m]==categoryname)
				{
				categoryString+='<div class="col-sm">'
					categoryString+='<img style="border:1px solid;padding:5px" onclick="showItems(\''+array[m]+'\')" height="60px" width="60px" src="BufferedImagesFolder/dummyImageCategory.svg">';
					categoryString+="<div>"+array[m]+"</div>";
				categoryString+='</div>';
				continue;
				}
			categoryString+='<div class="col-sm">'
				categoryString+='<img style="padding:5px" onclick="showItems(\''+array[m]+'\')" height="60px" width="60px" src="BufferedImagesFolder/dummyImageCategory.svg">';
				categoryString+="<div>"+array[m]+"</div>";
			categoryString+='</div>';
		}
	
	
	
	
	
	
	categoryString+='</div></div>';
	  document.getElementById("categoryPopulate").innerHTML=categoryString+reqString;
	  
	  
}


function showThisItemIntoSelection(itemId)
{
	
		
				
				
				var rows=tblitems.rows;
				for(var x=1;x<rows.length;x++)
					{							
						if(itemId==rows[x].childNodes[0].childNodes[1].value)
							{
								alert('item already exist in selection');
								document.getElementById("txtitem").value="";
								return;
							}
					}
				
				// code to check if item already exist inselection				
				getItemDetailsAndAddToTable(itemId);
				document.getElementById("txtitem").value="";
		
}


function getPriceForThisCustomer(itemDetails)
{
	
	var customerType=document.getElementById('hdnSelectedCustomerType').value;
	
	if(customerType=="WholeSeller"){return itemDetails[2];}
	if(customerType=="Franchise"){return itemDetails[3];}
	if(customerType=="LoyalCustomer3"){return itemDetails[4];}
	if(customerType=="LoyalCustomer2"){return itemDetails[5];}
	if(customerType=="LoyalCustomer1"){return itemDetails[6];}
	if(customerType=="Distributor"){return itemDetails[7];}
	if(customerType=="Business2Business"){return itemDetails[8];;}
	if(customerType=="shrikhand"){return itemDetails[9];}
	
	return itemDetails[1];	
}

function quickAddCustomer()
{
	document.getElementById("closebutton").style.display='none';
	   document.getElementById("loader").style.display='block';
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	    	
	    	
	    	if(xhttp.responseText.split("~")[1]==0)
	    		{
	    			alert(xhttp.responseText.split("~")[0]);
	    			return;
	    		}
	    		
	    	txtsearchcustomer.disabled=true;
	    	txtsearchcustomer.value=customerName.value+"~"+mobileNumber.value+"~"+customerType.value;
	    	customerName.value="";
	    	mobileNumber.value="";
	    	
	    	hdnSelectedCustomer.value=xhttp.responseText.split("~")[1];
	    	hdnSelectedCustomerType.value=customerType.value;
		}
	  };
	  xhttp.open("GET","?a=saveCustomerServiceAjax&appId=${userdetails.app_id}"+"&customerName="+customerName.value+"&mobileNumber="+mobileNumber.value+"&customerType="+customerType.value, true);    
	  xhttp.send();
}

function addremoveQuantity(itemId,addRemoveFlag) // 0 removes and 1 adds
{
	
	var	qtyElement=document.getElementById('txtqty'+itemId);
	var quantity=Number(qtyElement.value);
	
	if(quantity==1 && addRemoveFlag==0)
		{
			return;
		}
	
	if(addRemoveFlag==1)
		{
			quantity++;	
		}
	
	if(addRemoveFlag==0)
	{
		quantity--;	
	}
	
	qtyElement.value=quantity;
	formatQty(document.getElementById("txtqty"+itemId));
	calculateAmount(itemId);
}

function closeModalFast()
{
	$("#myModal").modal('hide');
}
	
	
document.addEventListener("keypress", function onPress(event) {
	
    
});

window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		saveInvoice();
	} 
	});
	
showItems();


$('[data-widget="pushmenu"]').PushMenu("collapse");


function calculateReturnAmount()
{
	try
	{
		toReturn.value=  (Number(givenByCustomer.value)-Number(totalAmount.innerHTML)).toFixed(2);
	}
	catch(ex)
	{
		console.log(ex.message);
	}
	
}

function getGSTForAllItems()
{
	if('${param.invoice_id}'!='' && '${param.editInvoice}'=='')		
	{
		return;
	}
	var rows1=tblitems.rows;
	for(var x=1;x<rows1.length;x++)
		{
			var itemId=rows1[x].childNodes[0].childNodes[1].value;
			
			calculateAmount(itemId);
			
		}
		
}
function simulateCheck()
{
	if(chkgstEnabled.checked)
		{
			chkgstEnabled.checked=false;	
		}
	else
		{
			chkgstEnabled.checked=true;
		}
	getGSTForAllItems();
	
}


// need to bring thhis flag from db saved for later
document.getElementById('row7').className='col-sm-12';
categoryPopulate.style="display:none";

function setDefaultChecks()
{
	if("${userdetails.invoice_default_checked_print}"=='Y')
		{
			chkprintinvoice.checked=true;		
		}
	
	if("${userdetails.invoice_default_checked_generatepdf}"=='Y')
	{
		chkgeneratePDF.checked=true;		
	}

}

setDefaultChecks();


function showLedger()
{
	window.open('?a=showCustomerLedger&txtfromdate=${todaysDateMinusOneMonth}&txttodate='+txtinvoicedate.value+'&customerId='+hdnSelectedCustomer.value);
}






</script>