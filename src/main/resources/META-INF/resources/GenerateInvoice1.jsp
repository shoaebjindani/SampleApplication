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
           
           
           




<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="invoiceDetails" value='${requestScope["outputObject"].get("invoiceDetails")}' />
<c:set var="tentativeSerialNo" value='${requestScope["outputObject"].get("tentativeSerialNo")}' />
<c:set var="customerMaster" value='${requestScope["outputObject"].get("customerMaster")}' />
<c:set var="categoriesWithItem" value='${requestScope["outputObject"].get("categoriesWithItem")}' />
<c:set var="todaysDateMinusOneMonth" value='${requestScope["outputObject"].get("todaysDateMinusOneMonth")}' />
<c:set var="returnData" value='${requestScope["outputObject"]}' />




 


<script src="js/searchinvoice.js"></script>
<script src="Test_files/app.js"></script>
<script src="Test_files/iconv-lite.bundle.js.download" charset="utf-8"></script>



</head>


<script type="javascript">


function saveInvoice()
{
	
	if((txtpaymenttype.value=="Pending" || txtpaymenttype.value =="Partial") && hdnSelectedCustomer.value =="") 
		{
			alert("This Payment type is not supported for Unknown customers");
			return;
		}
	btnsave.disabled=true;

	var rows=tblitems.rows;
	
	var requiredDetails=[];
	 
	var arr = [];
	var itemString="";
	var confirmMessage="";
	var proceedFlag=true;
	var messageToShow="";
	for (var x= 1; x < rows.length; x++) 
	{   
		calculateCustomRateFromAmount(rows[x]);
		
	    itemString+=
	    	rows[x].childNodes[0].childNodes[1].value+ // ID
	    "~"+Number(rows[x].childNodes[2].childNodes[0].childNodes[1].value)+ // QTY
	    "~"+Number(rows[x].childNodes[3].childNodes[0].childNodes[0].value)+ // RATE
	    "~"+Number(rows[x].childNodes[3].childNodes[0].childNodes[2].value)+ // CustomRate
	    "~"+rows[x].childNodes[1].childNodes[0].innerHTML+ // Item Name
	    
	    "~"+rows[x].childNodes[5].childNodes[0].childNodes[1].value+ // SGST Percentage
	    "~"+rows[x].childNodes[5].childNodes[0].childNodes[3].value+ // SGST Amount
	    "~"+rows[x].childNodes[5].childNodes[0].childNodes[5].value+ // CGST Percentage
	    "~"+rows[x].childNodes[5].childNodes[0].childNodes[7].value+ // CGST Amount
	    "~"+rows[x].childNodes[5].childNodes[0].childNodes[9].value+ // GST Amount	  
	    
	    
	    "~"+rows[x].childNodes[3].childNodes[0].childNodes[4].value+ // weight
	    "~"+rows[x].childNodes[3].childNodes[0].childNodes[6].value+ // size
	    "~0"+
	    "|";
	    
	    
	       
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
	"&total_cgst="+cgst.innerHTML+
	"&total_sgst="+sgst.innerHTML+
	"&itemDetails="+itemString; 
	
	/* var reqString="customer_id=2017"+
	"&gross_amount=1880.00"+
	"&item_discount=0.00"+
	"&invoice_discount=0"+
	"&total_amount=1880.00"+
	"&payment_type=Pending"+
	"&payment_mode="+
	"&paid_amount="+
	"&invoice_date=19/05/2022"+
	"&remarks="+
	"&hdnPreviousInvoiceId="+
	"&table_id="+'${param.table_id}'+
	"&booking_id="+'${param.booking_id}'+
	"&appId=${userdetails.app_id}"+
	"&store_id=${userdetails.store_id}"+
	"&user_id=${userdetails.user_id}"+
	"&total_gst=0.00"+
	"&total_cgst=0.00"+
	"&total_sgst=0.00"+
	"&itemDetails=501479~10~210~21~G-Kanser Gilet ~0~0.00~0~0.00~0~20.090~~0|501335~2~60~60~G-Butti Laser   Gilet ~0~0.00~0~0.00~0~3.680~~0|501543~4~70~70~G-Chain Gilet ~0~0.00~0~0.00~0~39.820~~0|501343~2~20~20~G-Butti Gilet ~0~0.00~0~0.00~0~5.990~~0|501341~6~18.333333333333332~18.333333333333332~G-Butti Gilet   Colour ~0~0.00~0~0.00~0~7.300~~0|501735~4~20~20~G-Zummar Gilet ~0~0.00~0~0.00~0~10.880~~0|501367~5~30~30~G-Pendant Gilet ~0~0.00~0~0.00~0~3.460~~0|501648~2~15~15~G-Bali Gilet ~0~0.00~0~0.00~0~0.770~~0|501648~1~15~15~G-Bali Gilet ~0~0.00~0~0.00~~0.290~~0|501339~2~35~35~G-Butti Gilet   Rodium ~0~0.00~0~0.00~0~0.880~~0|501320~1~80~80~G-Ring Buff Polish   Gilet   Rodium ~0~0.00~0~0.00~0~4.750~~0|501319~4~40~40~G-Ring Gilet ~0~0.00~0~0.00~0~11.340~~0|501319~2~30~30~G-Ring Gilet ~0~0.00~0~0.00~~1.100~~0|501325~1~170~170~G-Ring Buff Polish   Rose Gold   Rodium ~0~0.00~0~0.00~0~3.100~~0|501320~1~80~80~G-Ring Buff Polish   Gilet   Rodium ~0~0.00~0~0.00~~3.260~~0|501339~2~45~45~G-Butti Gilet   Rodium ~0~0.00~0~0.00~~4.120~~0|501460~9~15~15~G-Kanti Gilet ~0~0.00~0~0.00~0~1.420~~0|";
	
	 */
	
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) 
	    {
	    	var invoiceId=this.responseText.split("~");
	      	//alert("Invoice Saved Succesfully"+invoiceId[0]);
	      	
	      	toastr["success"]("Invoice Saved Succesfully "+invoiceId[0]);
	    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
	    	  "showMethod": "fadeIn","hideMethod": "fadeOut"
	    	}
	      	
	      	
	      	if(typeof chkprintinvoice !='undefined' && chkprintinvoice.checked==true)
      		{      		
	      		
      			generateInvoicePdfPrint(invoiceId[0],txtcustomerpendingamount.value);
      			btnsave.disabled=false;
    	      	document.getElementById("divTitle").innerHTML="Generate Invoice New : "+(Number(invoiceId[0])+1);
    	      	document.title +=" Generate Invoice New : " +(Number(invoiceId[0])+1);
      			return;      			
      		}
	      	
	      	
	      	if(typeof chkgeneratePDF !='undefined' && chkgeneratePDF.checked==true)
	      		{
	      			generateInvoice(invoiceId[1]);	      			
	      		}	  
	      	
	      	resetField();
	      	paymentTypeChanged(txtpaymenttype.value);
	      	
	      	 if(invoiceId.length==3)
	      	    {
	      	    	window.location=invoiceId[2];	
	      	    }
	      	btnsave.disabled=false;
	      	document.getElementById("divTitle").innerHTML="Generate Invoice New : "+(Number(invoiceId[0])+1);
	      	document.title +=" Generate Invoice New : " +(Number(invoiceId[0])+1);
	    	  
	      
	    }
	  };
	  xhttp.open("POST", "?a=saveInvoice", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");	  
	  xhttp.send(encodeURI(reqString));
	
	
	
}

function resetField()
{
	txtcustomerpendingamount.value="0";
	hdnSelectedCustomer.value="";
	grossAmount.innerHTML="0";
	txtitemdiscount.innerHTML="0";
	txtinvoicediscount.value="0";
	txtinvoicediscount.disabled=false;
	totalAmount.innerHTML="0";
	
	txtpaymenttype.value="Pending";
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
	
	
	txtremarks.value="";
	
	totalQty.innerHTML="0";
	gst.innerHTML="0";
	cgst.innerHTML="0";
	sgst.innerHTML="0";
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
	customerName.value="";
	mobileNumber.value="";
	customerType.value="New Customer";
	
	
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






<c:if test="${param.invoice_id eq null}">
<div class="col-sm-2">
  	<div class="form-group">
  	<div class="input-group input-group-sm">
                  <input type="text" class="form-control form-control-sm" id="customerName"
                   placeholder="New Customer Name" name="customerName">                           
    </div>
    </div>
  </div>
  
  <div class="col-sm-3">
  	<div class="form-group">
  	<div class="input-group input-group-sm">
                  <input type="text" class="form-control form-control-sm" id="mobileNumber"
                   placeholder="Mobile Number" name="mobileNumber" maxlength="10" onkeypress="digitsOnly(event)">                           
    </div>
    </div>
  </div>
  
  <div class="col-sm-2">
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

<div class="col-sm-4">
  	<div class="form-group">
  	
  	<div class="input-group input-group-sm">
                  <input type="text" class="form-control form-control-sm" id="txtsearchcustomer"    placeholder="Search For Customer" onkeyup="copyThisToNewCustomer()" name="txtsearchcustomer"  autocomplete="off"  oninput="checkforLengthAndEnableDisable();checkforMatchCustomer()">
                  
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
  
  <div class="col-sm-2">
  	
    
    <div class="input-group">
    
    
    
  </div>
  </div>
  
   <div class="col-sm-2">
  	<div class="form-group" align="center"> 	
  		<select id="itemGroup" name="itemGroup" class="form-control" onchange="hideOthers()">
  				
  				
  				
  				<option value="G">Gold</option>
  				<option value="S">Silver</option>
  				<option value="M">Metal</option>  				
  				
  			
  				</select>    		
  	</div>
  </div>
  
  
  <div class="col-sm-12">

<div class="card card-primary" >
              <div class="card-header" data-card-widget="collapse">
                <h3 class="card-title" >Menu</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" id="btnhidder" data-card-widget="collapse"  >
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    
                  </button>
                </div>
              </div>
              <div class="card-body table-responsive p-0">
                <div class="card card-primary card-tabs">
	<div class="card-header p-0 pt-1">
		<ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
			

							<c:if test="${param.editInvoice ne 'Y'}">
							
							<c:forEach items="${categoriesWithItem}" var="entry">
									<li class="nav-item" onclick="getItemsForThisCategoryNameByAjax('${entry.key}')"><a class="nav-link"
										id="custom-tabs-one-${entry.key}-tab" data-toggle="pill"
										href="#custom-tabs-one-${entry.key}" role="tab"
										aria-controls="custom-tabs-one-${entry.key}" aria-selected="false">${entry.key}</a></li>
							</c:forEach>
							
							</c:if>
						</ul>
	</div>
	<div class="card-body" >
		<div class="tab-content" >
		<div class="row" id="someIdGoesHere">
		</div>
		</div>			
	</div>
	
</div>
              </div>
              <!-- /.card-body -->
            </div>
		
		
		</div> 
  
  
  
  
  <div class="col-sm-12">  
	  <div class="card-body table-responsive p-0" style="height: 370px;">                
	                <table id="tblitems"  class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                  <thead>
	                    <tr align="center">
	                     <th style="z-index:0">Sr</th>
	  			<th style="z-index:0">Item Name</th>
	  			<th style="z-index:0">Item Piece</th>	  			
	  			<th style="z-index:0">Weight / Size</th>
	  			<th style="z-index:0">Item Amount</th>
	  			<th style="z-index:0">SGST / CGST</th>
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
	  			<th ><input type="tel" class='form-control form-control-sm' id="txtinvoicediscount" value="0" onkeypress="digitsOnlyWithDot(event)" onkeyup="calculateTotal()"></th>		
	  			
	  			
	  			<th >Total Weight</th>
	  			<th ><input type="tel" class='form-control form-control-sm' readonly id="txttotalweight" value="0" onkeypress="digitsOnlyWithDot(event)" onkeyup="calculateTotal()"></th>	  			
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
					  				<c:if test="${userdetails.app_id eq '1' }">							  				
						  				<option value="Zomato">Zomato</option>
		  								<option value="Swiggy">Swiggy</option>					  
	  								</c:if>				
			  					</select>
	                        </th>
	                
	                 
	  			
	  				<th name="partialPaymentElements" style="display:none">Paid Amount</th>
	  				<th name="partialPaymentElements" style="display:none"><input type='text' id="txtpaidamount" onkeypress="digitsOnly(event)" onkeyup="calculateTotal()" class='form-control form-control-sm'></th>		
	  				<th name="partialPaymentElements" style="display:none">Pending Amount :-<span id="txtpendingamount">0</span></th>	
	  			<th  class="text-right">Total Amount : <span id="totalAmount">0</span></th>
	  			<th colspan="4" class="text-right" >SGST : <span id="sgst">0</span><br> CGST : <span id="cgst">0</span>  <br>Total GST : <span id="gst">0</span>  <br><input type="checkbox" readonly id="chkgstEnabled" checked="true" onclick="calculateTotal();"></th>
	  			<td colspan="2"><input type="text" id="txtremarks" name="txtremarks" class="form-control form-control-sm" placeholder="Remarks"></td>	
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
	    	<input type="tel" class="form-control" id="givenByCustomer" onkeypress='digitsOnlyWithDot(event)' onkeyup='calculateReturnAmount()'>    	
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
	   <button class="btn btn-primary" id="btnRegister" type="reset" onclick='window.open("?a=generateDailyInvoiceReport&type=${userdetails.invoice_type}&txtfromdate=${todaysDate}&txttodate=${todaysDate}&txtstore=${userdetails.store_id}")'>Register</button>
	   
	  	   
	   <button class="btn btn-primary" style="display:none" id="generatePDF" type="button" onclick='generateInvoice("${invoiceDetails.invoice_id}");'>Generate PDF</button>
	   <button class="btn btn-primary" style="display:none" id="generateDirectPrint" type="button" onclick='printDirectAsFonts("${invoiceDetails.invoice_no}");'>Direct Print</button>
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


function generateInvoicePdfPrint(invoiceNo,pendAmount)
{
	try
	{
		
				printDirectAsFonts(invoiceNo,pendAmount);
  				resetField();
		
	}
	catch(ex)
	{
		alert(ex.message);
	}
	//will Print to printer Directly
	return;
	//;
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
	    			pendingamount=details.pendingAmountDetails.PendingAmount;
	    		}
	    	else
	    		{
	    			pendingamount=0;
					//alert("no pending amount for this customer");
	    			//window.location.reload();
	    		}
		}
	  };
	  xhttp.open("GET","?a=getPendingAmountForCustomer&customerId="+customerId, true);    
	  xhttp.send();
}



function getItemDetailsAndAddToTable(itemId)
{
		      
	
	

		var itemDetails=document.getElementById("hdn"+itemId).value.split("~");
		
	
	    	
	    	//console.log(itemDetails);
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
	    	
	    	
	    	
	    	
	    	//
	    	
	    	cell1.innerHTML = "<div>"+Number(table.rows.length-1)+"</div>" +"<input type='hidden' value='"+itemId+"'>";
	    	cell2.innerHTML = "<a onclick=window.open('?a=showItemHistory&itemId="+itemId+"') href='#'>"+ itemDetails[5] + " "+itemDetails[0]+" </a>";
	    	cell3.innerHTML = '<div class="input-group"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,0)"><i class="fa fa-minus"></i></button></span><input type="tel" style="text-align:center" class="form-control form-control-sm"  id="txtqty'+itemId+'" onkeyup="calculateAmount(this.parentNode.parentNode.parentNode);checkIfEnterisPressed(event,this);"  onkeypress="digitsOnlyWithDot(event);" value="1"> <input type="hidden" class="form-control form-control-sm"  readonly id="hdnavailableqty'+itemId+'" value='+itemDetails[2]+'><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,1)"><i class="fa fa-plus"></i></button></span></div>';
	    	cell4.innerHTML='<div class="input-group"><input type="text" readonly style="display:none" class="form-control form-control-sm" value="'+itemDetails[1]+'" id="txtrate'+itemId+'">  <input type="tel" class="form-control form-control-sm" id="txtcustomrate'+itemId+'" onfocus="checkforZero(this)"   onkeyup="checkIfEnterisPressed(event,this)" onkeypress="digitsOnlyWithDot(event)" style="width:50%;display:none">      <input type="tel" class="form-control form-control-sm" id="txtweight'+itemId+'" onfocus="checkforZero(this)"   onblur="formatQty(this);" onkeyup="checkIfEnterisPressed(event,this);calculateTotal()" onkeypress="digitsOnlyWithDot(event);" style="width:50%"> <input type="tel" class="form-control form-control-sm" id="txtsize'+itemId+'" onfocus="checkforZero(this)"   onkeyup="checkIfEnterisPressed(event,this)"  value="0" style="width:50%">  </div>';
	    	
	    	cell5.innerHTML = "<input type='tel' class='form-control form-control-sm' value='0' id='txtamount"+itemId+"' onfocus='checkforZero(this)' onkeyup='calculateCustomRateFromAmount(this.parentNode.parentNode);calculateAmount(this.parentNode.parentNode)'>";
	    	
	    	
	    	 var sgstAmount=0;
		    var cgstAmount=0;
		    
		    var customRate=itemDetails[1];
		    
		    sgstAmount=(Number(customRate)*Number(itemDetails[3])/100) + Number(customRate);
		    cgstAmount=(Number(customRate)*Number(itemDetails[4])/100) + Number(customRate);
		    
		       
		    
		    
		    cell6.innerHTML = "<div class='input-group'>  <input type='text' readonly class='form-control form-control-sm' name='txtsgstamountgroup' id='txtsgstamount"+itemId+"' value='"+sgstAmount+"'   style='width:25%'>      <input type='text' style='width:25%' class='form-control form-control-sm' onkeyup='calculateAmount(this.parentNode.parentNode.parentNode)' id='txtsgstpercent"+itemId+"' value='"+itemDetails[3]+"'> <input type='text' readonly class='form-control form-control-sm' name='txtcgstamountgroup' id='txtcgstamount"+itemId+"' value='"+cgstAmount+"'   style='width:25%'>      <input type='text' style='width:25%' class='form-control form-control-sm' onkeyup='calculateAmount(this.parentNode.parentNode.parentNode)' id='txtcgstpercent"+itemId+"' value='"+itemDetails[4]+"'> <input type='hidden' id='txtgstamount"+itemId+"'  /></div>";
		   
	    	//cell6.innerHTML = "<input type='text' class='form-control form-control-sm' value='0' readonly id='gst"+itemId+"' onkeyup='calculateAmount("+itemId+")'> <input type='hidden' id='hdngst"+itemId+"' value=" +itemDetails[3]+ ">";
	    	
		    cell7.innerHTML = '<button type="button" class="btn btn-sm btn-danger"  onclick=removethisitem(this) id="btn11" style="cursor:pointer">Delete</button>';
	    	calculateCustomRateFromAmount(row);
	    	calculateAmount(row);
	    	calculateTotal();
	    	row.childNodes[2].childNodes[0].childNodes[1].select();
	    	row.childNodes[2].childNodes[0].childNodes[1].focus();	    
}



function calculateAmount(rowElement)
{
	
	
	
	var customrate=rowElement.childNodes[3].childNodes[0].childNodes[2].value;	
	var rate=rowElement.childNodes[3].childNodes[0].childNodes[0].value;
	var qty=rowElement.childNodes[2].childNodes[0].childNodes[1].value;
	
	var amount=(Number(customrate) *Number(qty) ).toFixed(2);
		 
	
	//document.getElementById('txtqty'+itemId).parentNode.parentNode.parentNode.childNodes[6].childNodes[0].value= (Number(customrate) *Number(qty) ).toFixed(2);
	
	var itemDiscount=(Number(rate) - Number(customrate)) *  Number(qty);
	
	var itemId=rowElement.childNodes[2].childNodes[0].childNodes[1].id.replace('txtqty','');
	
	
	var itemSGSTPercentage=document.getElementById('txtsgstpercent'+itemId).value;
	var itemCGSTPercentage=document.getElementById('txtcgstpercent'+itemId).value;
	
	var SGSTAmount=0;
	var CGSTAmount=0;

	
			SGSTAmount=(Number(customrate) *Number(qty) )*itemSGSTPercentage / 100;
			
			document.getElementById('txtsgstamount'+itemId).value=SGSTAmount;
			
			CGSTAmount=(Number(customrate) *Number(qty) )*itemCGSTPercentage / 100;
			document.getElementById('txtcgstamount'+itemId).value=CGSTAmount;
			
			document.getElementById('txtgstamount'+itemId).value= Number(SGSTAmount) + Number(CGSTAmount);
			
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
			txtbox.parentNode.parentNode.parentNode.childNodes[3].childNodes[0].childNodes[4].select();
		}	
	if((txtbox.id.toString().indexOf('txtweight')!=-1)) // means that enter is pressed on customrate 
	{
		txtbox.parentNode.parentNode.parentNode.childNodes[3].childNodes[0].childNodes[6].select();
	}
	
	if((txtbox.id.toString().indexOf('txtsize')!=-1)) // means that enter is pressed on customrate 
	{
		txtbox.parentNode.parentNode.parentNode.childNodes[4].childNodes[0].select();
		
	}
	
	
	
	if((txtbox.id.toString().indexOf('txtamount')!=-1)) // means that enter is pressed on weight 
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
		var totalSGSTCalculated=0;
		var totalCGSTCalculated=0;
		var totalWeightCalculated=0;
		
		var rows=tblitems.rows;
		for(var x=1;x<rows.length;x++)
			{
				var itemTotalAmount=Number(rows[x].childNodes[4].childNodes[0].value);
				total+=itemTotalAmount;
				
				var itemQty=Number(rows[x].childNodes[2].childNodes[0].childNodes[1].value);
				
				totalQtyCalculated+=itemQty;
				
				var rate=Number(rows[x].childNodes[3].childNodes[0].value);
				var grossItemAmount=itemTotalAmount;
				totalDiscountCalculated+=grossItemAmount  -itemTotalAmount;
				
				grossAmountCalculated+=grossItemAmount;
				
				totalSGSTCalculated+=Number(rows[x].childNodes[5].childNodes[0].childNodes[1].value);
				totalCGSTCalculated+=Number(rows[x].childNodes[5].childNodes[0].childNodes[5].value);			
				
				
				
				
				totalWeightCalculated+=Number(rows[x].childNodes[3].childNodes[0].childNodes[4].value);
			}
		
		
		total=total-txtinvoicediscount.value+Number(totalSGSTCalculated)+Number(totalCGSTCalculated);
		totalAmount.innerHTML=Number(total).toFixed(2);
		totalQty.innerHTML=Number(totalQtyCalculated).toFixed(2);
		txtitemdiscount.innerHTML=Number(totalDiscountCalculated).toFixed(2);
		grossAmount.innerHTML=Number(grossAmountCalculated).toFixed(2);
		
		txtpendingamount.innerHTML=Number(total-txtpaidamount.value).toFixed(2);
		// 
		if(chkgstEnabled.checked)
			{	
				sgst.innerHTML=Number(totalSGSTCalculated).toFixed(2);
				cgst.innerHTML=Number(totalCGSTCalculated).toFixed(2);
				gst.innerHTML=Number(Number(totalCGSTCalculated)+Number(totalSGSTCalculated)).toFixed(2);
			}
		else
			{
			sgst.innerHTML=0;
			cgst.innerHTML=0;
			gst.innerHTML=0;
			}
		
		txttotalweight.value=Number(totalWeightCalculated).toFixed(3);
		
		
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





document.getElementById("divTitle").innerHTML="Generate Invoice New:- "+"${tentativeSerialNo}";
document.title +=" Generate Invoice New:- " + " ${tentativeSerialNo} ";
$("#divBackButton").attr("href", "https://www.w3schools.com/jquery/");


txtpaymenttype.value="Pending";


$( "#txtinvoicedate" ).datepicker({ dateFormat: 'dd/mm/yy' });
if('${invoiceDetails.invoice_id}'!='')
	{
		
		
		

		document.getElementById("divTitle").innerHTML="Invoice No:-"+"${invoiceDetails.invoice_no}";
		document.title +=" Invoice No:- "+ " ${invoiceDetails.invoice_no} ";
		hdnSelectedCustomer.value="${invoiceDetails.customer_id}"
		
			
		if('${invoiceDetails.customer_name}'!='')
			{
				txtsearchcustomer.value="${invoiceDetails.customer_name}~${invoiceDetails.mobile_number}~${invoiceDetails.customer_type}";			
			}
		
		
		document.getElementById("hdnSelectedCustomerType").value='${invoiceDetails.customer_type}';
		txtinvoicedate.value="${invoiceDetails.theInvoiceDate}";
		totalQty.innerHTML="${invoiceDetails.totalQuantities}";
		grossAmount.innerHTML="${invoiceDetails.gross_amount}";		
		txtinvoicediscount.value="${invoiceDetails.invoice_discount}";
		txtpaymenttype.value="${invoiceDetails.payment_type}";
		
		totalAmount.innerHTML="${invoiceDetails.total_amount}";
		gst.innerHTML="${invoiceDetails.total_gst}";
		sgst.innerHTML="${invoiceDetails.total_sgst}";
		cgst.innerHTML="${invoiceDetails.total_cgst}";
		txtpaidamount.value="${invoiceDetails.paid_amount}";
		paymentTypeChanged(txtpaymenttype.value);
		txtpendingamount.innerHTML=Number(totalAmount.innerHTML)-Number(txtpaidamount.value);
		txtremarks.value='${invoiceDetails.remarks}';
		drppaymentmode.value="${invoiceDetails.payment_mode}";
		
		var m=0;
		var tableNo="";
		var totalWeightCalculated=0;
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
    	
    	
    	
    	
    	cell1.innerHTML = '<div>'+m+'</div><input type="hidden" value="${item.item_id}">';    	
    	cell2.innerHTML = '<a href="#">${item.category_name} ${item.item_name} ( )</a>';
    	//cell3.innerHTML = " <input type='text' class='form-control form-control-sm' id='txtqty"+${item.item_id}+"' onkeyup='calculateAmount(${item.item_id});checkIfEnterisPressed(event);' onblur='formatQty(this)' onkeypress='digitsOnlyWithDot(event);' value='${item.qty}'> <input type='hidden' readonly id='hdnavailableqty"+${item.item_id}+"'>";
    	var qty=Number('${item.qty}').toFixed(0);
    	
    	cell3.innerHTML = '<div class="input-group"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,0)"><i class="fa fa-minus"></i></button></span><input type="text" style="text-align:center" class="form-control form-control-sm"  id="txtqty${item.item_id}" onkeyup="calculateCustomRateFromAmount(this.parentNode.parentNode.parentNode);calculateAmount(this.parentNode.parentNode.parentNode);checkIfEnterisPressed(event,this);"  onkeypress="digitsOnlyWithDot(event);" value="'+qty+'"> <input type="hidden" class="form-control form-control-sm"  readonly id="hdnavailableqty${item.item_id}" value="${item.qty}"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,1)"><i class="fa fa-plus"></i></button></span></div>';
    																																																																													  //onkeyup="calculateAmount(this.parentNode.parentNode.parentNode);checkIfEnterisPressed(event,this);"  onkeypress="digitsOnlyWithDot(event);"
    	//cell4.innerHTML = '<input type="text" readonly class="form-control form-control-sm" value="${item.rate}" id="txtrate${item.item_id}">';
    	
    	//cell4.innerHTML = '<div class="input-group"> <input type="tel" class="form-control form-control-sm" id="txtweight${item.item_id}" value="${item.weight}" onfocus="checkforZero(this)"   onblur="formatQty(this)" onkeyup="calculateAmount(${item.item_id});checkIfEnterisPressed(event,this)" onkeypress="digitsOnlyWithDot(event)" style="width:50%"> <input type="tel" class="form-control form-control-sm" id="txtsize${item.item_id}" onfocus="checkforZero(this)"   value="${item.size}" onkeyup="calculateAmount(${item.item_id});checkIfEnterisPressed(event,this)"  value="0" style="width:50%">  </div>';
    	cell4.innerHTML='<div class="input-group"><input type="text" readonly style="display:none" class="form-control form-control-sm" value=0 id="txtrate${item.item_id}">  <input type="tel" class="form-control form-control-sm" id="txtcustomrate${item.item_id}" onfocus="checkforZero(this)"   onkeyup="checkIfEnterisPressed(event,this)" onkeypress="digitsOnlyWithDot(event)" value="0" style="width:50%;display:none">      <input type="tel" class="form-control form-control-sm" id="txtweight${item.item_id}" onfocus="checkforZero(this)"   value="${item.weight}" onblur="formatQty(this);" onkeyup="checkIfEnterisPressed(event,this);calculateTotal()" onkeypress="digitsOnlyWithDot(event);"  style="width:50%"> <input type="tel" class="form-control form-control-sm" id="txtsize${item.item_id}" value="${item.size}" onfocus="checkforZero(this)"   onkeyup="checkIfEnterisPressed(event,this)"  value="0" style="width:50%">  </div>';
    	
    	
    	var itemTotal=Number('${item.custom_rate}') * Number('${item.qty}');
    	itemTotal=Number(itemTotal).toFixed(0);
    	
    	cell5.innerHTML = "<input type='tel' class='form-control form-control-sm' value='"+itemTotal+"' id='txtamount${item.item_id}' onfocus='checkforZero(this)' onkeyup='calculateCustomRateFromAmount(this.parentNode.parentNode)'>";
    	
    	//
//    	cell6.innerHTML ="<input type='text' class='form-control form-control-sm' value='${item.gst_amount}' readonly id='gst${item.item_id}' onkeyup='calculateAmount(${item.item_id})'> <input type='hidden' id='hdngst${item.item_id}' value='${item.gst}'>";//
		    	
    	cell6.innerHTML = "<div class='input-group'>  <input type='text' readonly class='form-control form-control-sm' name='txtsgstamountgroup' id='txtsgstamount${item.item_id}' value='${item.sgst_amount}'   style='width:25%'>      <input type='text' style='width:25%' class='form-control form-control-sm' onkeyup='calculateAmount(this.parentNode.parentNode.parentNode)' id='txtsgstpercent${item.item_id}' value='${item.sgst_percentage}'> <input type='text' readonly class='form-control form-control-sm' name='txtcgstamountgroup' id='txtcgstamount${item.item_id}' value='${item.cgst_amount}'   style='width:25%'>      <input type='text' style='width:25%' class='form-control form-control-sm' onkeyup='calculateAmount(this.parentNode.parentNode.parentNode)' id='txtcgstpercent${item.item_id}' value='${item.cgst_percentage}'> <input type='hidden' id='txtgstamount${item.item_id}'  /></div>";
    	
		cell7.innerHTML = '<button type="button" class="btn btn-sm btn-danger"  onclick=removethisitem(this) id="btn11" name="deleteButtons" style="cursor:pointer">Delete</button> <button type="button" class="btn btn-primary"  onclick=returnThisItem("${item.details_id}") name="returnButtons" id="btn11" style="cursor:pointer">Return (${item.ReturnedQty})</button>';
    	
		totalWeightCalculated+=Number('${item.weight}');
	    		//alert('${item.item_id}'+'-${item.item_name}'+'-${item.qty}'+'-${item.rate}'+'-${item.custom_rate}');
	    		calculateCustomRateFromAmount(row);
		</c:forEach>
		
		
		
		txttotalweight.value=Number(totalWeightCalculated).toFixed(3);
 
		
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
				document.title +=" Invoice For Table No:- " +tableNo;
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
		document.getElementById("generateDirectPrint").style="display:";
		
		generateDirectPrint.disabled=false;
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


function calculateCustomRateFromAmount(row)
{
	
	var amount=row.childNodes[4].childNodes[0].value;	
	
	
	var qty=row.childNodes[2].childNodes[0].childNodes[1].value;	
	var customRate=Number(amount)/Number(qty);		
	row.childNodes[3].childNodes[0].childNodes[2].value=customRate;
	row.childNodes[3].childNodes[0].childNodes[0].value=customRate;	 
	calculateTotal();
}





function showThisItemIntoSelection(itemId)
{
	
		
				
				
				var categoryName=document.getElementById("hdn"+itemId).value.split("~");
				
				
				/* var rows=tblitems.rows;
				for(var x=1;x<rows.length;x++)
					{							
						if(itemId==rows[x].childNodes[0].childNodes[1].value)
							{
								alert('item already exist in selection');
								document.getElementById("txtitem").value="";
								return;
							}
					} */
				
				// code to check if item already exist inselection				
				getItemDetailsAndAddToTable(itemId);
				document.getElementById("someIdGoesHere").innerHTML="";
				//document.getElementById("txtitem").value="";
		
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

function addremoveQuantity(elementButton,addRemoveFlag) // 0 removes and 1 adds
{
	
	
	var qtyElement=elementButton.parentNode.parentNode.parentNode.childNodes[0].childNodes[1];	
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
	calculateCustomRateFromAmount(elementButton.parentNode.parentNode.parentNode.parentNode);
	calculateAmount(elementButton.parentNode.parentNode.parentNode.parentNode);
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
			calculateAmount(rows1[x]);			
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


<c:if test="${returnData.invoice_default_checked_print eq 'Y'}">
	chkprintinvoice.checked=true;
</c:if>

<c:if test="${returnData.invoice_default_checked_generatepdf eq 'Y'}">
	chkgeneratePDF.checked=true;
</c:if>





$( "#birthday" ).datepicker({ dateFormat: 'dd/mm/yy' });


function checkforZero(obj)
{
	
	if(obj.value=="0.00" || obj.value=="0" || obj.value=="0.000")		
		obj.value="";
}

function formatQty(qtyTextBox)
{
	qtyTextBox.value=Number(qtyTextBox.value).toFixed(3);		
}


txtitemdiscount.parentNode.style="display:none";


function hideOthers()
{
	
	var Elements=document.getElementById("custom-tabs-one-tab").childNodes;
	for(var m=0;m<Elements.length;m++)
		{
		
		
			if(m%2!=0)
				{
				Elements[m].childNodes[0].style="display:block";

					var itemGroup=document.getElementById("itemGroup").value;
					if(!Elements[m].childNodes[0].innerHTML.toString().startsWith(itemGroup))
					{
						Elements[m].childNodes[0].style="display:none";
					}
				}
		}
}

function setDefaultChecks()
{
	if("${returnData.invoice_default_checked_print}"=='Y')
		{
			chkprintinvoice.checked=true;		
		}
	
	if("${returnData.invoice_default_checked_generatepdf}"=='Y')
	{
		chkgeneratePDF.checked=true;		
	}
	itemGroup.value="G";
	hideOthers();

}

setDefaultChecks();




function copyThisToNewCustomer()
{
		mobileNumber.value=txtsearchcustomer.value;
}

paymentTypeChanged(txtpaymenttype.value);


function printDirectAsFonts(invoiceNo,pendAmount) 
{
	
	
	
	try
	{
		
		if(invoiceNo==null)
			{
				alert("invoice No found as null");
				return;
			}
	
	var xhttp = new XMLHttpRequest();
	var invoiceResponse;
	var invoiceDetails;
	var listOfItems;
	
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		    	console.log(xhttp.responseText);
		       invoiceResponse=JSON.parse(xhttp.responseText);
		       invoiceDetails=(invoiceResponse.invoiceDetails);
		       listOfItems=invoiceDetails.listOfItems;
		       console.log(listOfItems);
		   		
			}
		  };
		  xhttp.open("GET","?a=getInvoiceDetailsByNoAjax&invoiceNo="+invoiceNo, false);    
		  xhttp.send();
		
		  console.log(invoiceDetails.invoice_no);
		  var topay=Number(invoiceDetails.total_amount)-Number(invoiceDetails.paid_amount);
			
    var c = new PosPrinterJob(getCurrentDriver(), getCurrentTransport());
    c.initialize();
     c.printText("Invoice Estimate: "+invoiceDetails.invoice_no, c.ALIGNMENT_CENTER, c.FONT_SIZE_MEDIUM2); // Invoice no   
    c.printText(invoiceDetails.store_name, c.ALIGNMENT_CENTER, c.FONT_SIZE_BIG).bold(true); // store name
    
    c.printText(invoiceDetails.address_line_1 + invoiceDetails.address_line_2, c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // address line 1
    c.printText(invoiceDetails.address_line_3, c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // address line 2     
    
    //c.printText(invoiceDetails.city+" - "+invoiceDetails.pincode, c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // city pincode
    
    c.printText("Phone:- "+invoiceDetails.mobile_no, c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // mobile
    c.printText("Store Timings:- "+invoiceDetails.store_timing, c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // timings
    
    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // mobile
    
		    c.printText("Name : "+invoiceDetails.customer_name, c.ALIGNMENT_LEFT, c.FONT_SIZE_NORMAL); // Name
		    c.printText("Date & Time : "+invoiceDetails.theUpdatedDate, c.ALIGNMENT_LEFT, c.FONT_SIZE_NORMAL); // Date & Time
		    c.printText("Payment Type : "+invoiceDetails.payment_type, c.ALIGNMENT_LEFT, c.FONT_SIZE_NORMAL); // Payment Type
    if(invoiceDetails.payment_type!='Pending')
    	{
    		c.printText("Payment Mode : "+invoiceDetails.payment_mode, c.ALIGNMENT_LEFT, c.FONT_SIZE_NORMAL); // Payment Type
    	}
    
    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // mobile
    
    c.printText("SR       ITEM NAME      QTY       WT.     Amount", c.ALIGNMENT_LEFT, c.FONT_SIZE_NORMAL); // Payment Type
    
    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL); // mobile
    var template="$sr$itemName0123456789$QTY5678901$WT456789$Amount";
    var totalWeight=0;
    var totalQty=0;
    for(var m=0;m<listOfItems.length;m++)
    	{
    	var srnumber=m+1;
    	if(srnumber<=9)
    		{
    			srnumber="0"+srnumber;
    		}
    	
    	var oneLiner=template.replace("$sr",srnumber);
    	totalWeight+=Number(listOfItems[m].weight);
    	totalQty+=Number(listOfItems[m].qty);    	
    	
    	var custom_rate=listOfItems[m].custom_rate;
    	var qtyNum=listOfItems[m].qty;
    	var Amount=Number(custom_rate)*Number(qtyNum);    	
    	Amount=Amount.toFixed(0);
    	
    	var catName=listOfItems[m].category_name
    	for(k=0;k<18;k++)
    		{
	    		if(catName.length<18)
	    		{
	    			if(k%2==0){catName+=" ";}
	    			if(k%2!=0){catName=" "+catName;}
	    		}
    		}
    	
    	var qtyWithWhiteSpaces=listOfItems[m].qty;
    	for(k=0;k<12;k++)
    		{
	    		if(qtyWithWhiteSpaces.toString().length<12)
	    		{
	    			if(k%2==0){qtyWithWhiteSpaces+=" ";}
	    			if(k%2!=0){qtyWithWhiteSpaces=" "+qtyWithWhiteSpaces;}	    					
	    		}
    		}
    	
    	
    	var weightWithWhiteSpace=Number(listOfItems[m].weight).toFixed(3);
    	for(k=0;k<9;k++)
    		{
	    		if(weightWithWhiteSpace.toString().length<9)
	    		{
	    			if(k%2==0){weightWithWhiteSpace+=" ";}
	    			if(k%2!=0){weightWithWhiteSpace=" "+weightWithWhiteSpace;}	    					
	    		}
    		}
    	
    	var amountWithSpaces=Amount;
    	for(k=0;k<7;k++)
    		{
	    		if(amountWithSpaces.toString().length<7)
	    		{
	    			if(k%2==0){amountWithSpaces+=" ";}
	    			if(k%2!=0){amountWithSpaces=" "+amountWithSpaces;}	    					
	    		}
    		}
    	
    	oneLiner=oneLiner.replace("$itemName0123456789",catName);
    	oneLiner=oneLiner.replace("$QTY5678901",qtyWithWhiteSpaces);
    	oneLiner=oneLiner.replace("$WT456789",weightWithWhiteSpace);
    	oneLiner=oneLiner.replace("$Amount",amountWithSpaces);
    	
    	c.printText(oneLiner, c.ALIGNMENT_LEFT, c.FONT_SIZE_NORMAL); // Payment Type
    	var size1=listOfItems[m].size==""?"":" Size : ("+listOfItems[m].size+") ";
    	c.printText(listOfItems[m].item_name+size1, c.ALIGNMENT_LEFT, c.FONT_SIZE_SMALL); 
    	
    
    	}
    
        
    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
    
    c.printText("Total Weight : "+totalWeight.toFixed(3), c.ALIGNMENT_RIGHT, c.FONT_SIZE_NORMAL); // Payment Type
    c.printText("Total Qty : "+totalQty, c.ALIGNMENT_RIGHT, c.FONT_SIZE_NORMAL); // Payment Type
    
    if(invoiceDetails.invoice_discount!='' && invoiceDetails.invoice_discount!='0.00')
	{
	    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
	    c.printText("Invoice Discount :  "+invoiceDetails.invoice_discount, c.ALIGNMENT_RIGHT, c.FONT_SIZE_SMALL); // Remarks
	}
    
    if(invoiceDetails.remarks!='')
	{
	    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
	    c.printText("Remarks :  "+invoiceDetails.remarks, c.ALIGNMENT_LEFT, c.FONT_SIZE_SMALL); // Remarks
	}
    
    var topay=invoiceDetails.total_amount;
    
    if(invoiceDetails.payment_type=='Partial')
    	{    	
    	
    	// need to discuss and implement
    	c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
        c.printText("Total Amount :  "+Number(invoiceDetails.total_amount), c.ALIGNMENT_RIGHT, c.FONT_SIZE_MEDIUM1);         
        
    	c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
        c.printText("Partially Paid Amount :  "+invoiceDetails.paid_amount, c.ALIGNMENT_RIGHT, c.FONT_SIZE_MEDIUM1); // Payment Type
        topay=Number(invoiceDetails.total_amount)-Number(invoiceDetails.paid_amount);
    	}
    
    
    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
    c.printText("Previous Due Amount :  "+pendAmount, c.ALIGNMENT_LEFT, c.FONT_SIZE_SMALL); // Payment Type
    
    
    
    
    
    
    c.printText("----------------------------------------------------------------", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
    c.printText("Payable Amount :  "+topay, c.ALIGNMENT_RIGHT, c.FONT_SIZE_MEDIUM1); // Payment Type
    
  
    
    
   

    c.printText("****************************************************************", c.ALIGNMENT_CENTER, c.FONT_SIZE_SMALL);
    c.printText("*Thank You, Visit Again*", c.ALIGNMENT_CENTER, c.FONT_SIZE_NORMAL);
    


    
        
    c.feed(3);
    c.execute();
    

	}
	catch(ex)
	{
		alert(ex.message);
	}
    

}



function showLedger()
{
	window.open('?a=showCustomerLedger&txtfromdate=${todaysDateMinusOneMonth}&txttodate='+txtinvoicedate.value+'&customerId='+hdnSelectedCustomer.value);
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

function getItemsForThisCategoryNameByAjax(categoryName)
{
	
		  const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
		    //console.log(this.responseText);
		    var items=JSON.parse(this.responseText);
		    //console.log(items[0]);
		    //console.log(JSON.parse(items));
		    var reqString="";
		    for(m=0;m<items.length;m++)
		    	{
		    		//console.log(items[m].item_name);
		    		reqString+=`
		    			<div class="col-sm-2 col-md-4 col-lg-6" style="max-width:130px;font-size:13px" align="center">
						<img  height="50px" width="50px"  onclick="showThisItemIntoSelection(`+items[m].item_id+`)"   src="BufferedImagesFolder/dummyImage.jpg">
						<input type="hidden" id="hdn`+items[m].item_id+`" value="`+items[m].item_name+`~`+items[m].price+`~`+items[m].qty_available+`~`+items[m].sgst+`~`+items[m].cgst+`~`+items[m].category_name+`">
						
					<br>`+items[m].item_name+`				
					</div>`;
		    	}
		    //alert(reqString);
		    document.getElementById('someIdGoesHere').innerHTML=reqString; 
		  }
		  xhttp.open("GET", "?a=getItemsForThisCategoryNameByAjax&category_name="+categoryName);
		  xhttp.send();
			
	
}



</script>
