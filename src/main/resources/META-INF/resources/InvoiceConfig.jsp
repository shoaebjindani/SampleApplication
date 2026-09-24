  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
           
           



<c:set var="listOfInvoiceFormats" value='${requestScope["outputObject"].get("listOfInvoiceFormats")}' />
<c:set var="listOfInvoiceTypes" value='${requestScope["outputObject"].get("listOfInvoiceTypes")}' />




</head>

<br>

<div class="container" style="padding:20px;background-color:white">


<div class="row">

	<div class="col-sm-12">
	  	<div class="form-group">
	      <label for="email">Invoice Format</label>     
	      <select class="form-control" name="drpinvoiceid" id="drpinvoiceid" >
	      <c:forEach items="${listOfInvoiceFormats}" var="invoiceformat">
				    <option value="${invoiceformat.format_id}">${invoiceformat.format_name}</option>			    
		   </c:forEach></select>   
	    </div>
	</div>

	<div class="col-sm-12">
	  	<div class="form-group">
	      <label for="email">Invoice Type</label>     
	      <select class="form-control" name="drpinvoicetype" id="drpinvoicetype" >
	      <c:forEach items="${listOfInvoiceTypes}" var="invoicetype">
				    <option value="${invoicetype.invoice_type_id}">${invoicetype.invoice_type_name}</option>			    
		   </c:forEach></select>   
	    </div>
	</div>
	
	
	
		<div class="col-sm-12">
	
	<div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">Generate Invoice Defaults</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <form>
                  <div class="row">
                    <div class="col-sm-6">
                      <!-- checkbox -->
                      <div class="form-group">
                        <div class="custom-control custom-checkbox">
                        
                        
						<div class="custom-control custom-checkbox">
                          <input class="custom-control-input" type="checkbox" id="invchkprint" >                          
                          <label for="invchkprint" class="custom-control-label">Invoice Default Checked Print</label>
                         </div>

						<div class="custom-control custom-checkbox">                          
                          <input class="custom-control-input" type="checkbox" id="invchkpdf" >                          
                          <label for="invchkpdf" class="custom-control-label">Invoice Default Checked Generate PDF</label>
                        </div>

						<div class="custom-control custom-checkbox">                          
                          <input class="custom-control-input" type="checkbox" id="reschkpdf" >                          
                          <label for="reschkpdf" class="custom-control-label">Restaurant Default Checked Generate PDF</label>
                         </div>
                          
                        
                          
                      </div>
                    </div>
                    
                  </div>

                  

                  

                  
                  
                  
                  
                  
                  
                  
                  
                </form>
              </div>
              <!-- /.card-body -->
            </div>
</div>


<div class="col-sm-12">
	
	<div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">Dashboard Defaults</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <form>
                  <div class="row">
                    <div class="col-sm-6">
                      <!-- checkbox -->
                      <div class="form-group">
                        <div class="custom-control custom-checkbox">
                        
                        
						<div class="custom-control custom-checkbox">
                         <input type="checkbox"  class="custom-control-input" id="totalpayment">
						 <label class="custom-control-label" for="totalpayment">Total Payments</label>
                         </div>
                         
                 						<div class="custom-control custom-checkbox">                         
			<input type="checkbox"  class="custom-control-input" id="paymentcollection">
     		<label class="custom-control-label" for="paymentcollection">Payments Against Collections</label>
     		</div>
     								<div class="custom-control custom-checkbox">
     		
			<input type="checkbox"  class="custom-control-input" id="counter">
			<label class="custom-control-label" for="counter">Counter Sales</label>
			</div>
									<div class="custom-control custom-checkbox">
			
			<input type="checkbox" class="custom-control-input" id="paymentsales">
			<label class="custom-control-label" for="paymentsales">Payments Against Sales</label>
			</div>
			
									<div class="custom-control custom-checkbox">
			
			<input type="checkbox"  class="custom-control-input" id="storesales">
			<label class="custom-control-label" for="storesales">Store Wise - Employee Wise Sales</label>
			</div>
			
									<div class="custom-control custom-checkbox">
			
			<input type="checkbox"  class="custom-control-input" id="storebooking">
			<label class="custom-control-label" for="storebooking">Store Wise - Bookings</label>
			</div>
			
			
									<div class="custom-control custom-checkbox">
			
			<input type="checkbox"  class="custom-control-input" id="storeexpense">
			<label class="custom-control-label" for="storeexpense">Store Wise Expenses</label>
			</div>
						
                          
                        
                          
                      </div>
                    </div>
                    
                  </div>

                  

                  

                  
                  
                  
                  
                  
                  
                  
                  
                </form>
              </div>
              <!-- /.card-body -->
            </div>
</div>
	
	
	

  	
	<div class="col-sm-4">
		<div class="form-check">
		
	
		</div>
	</div>
  	
	
  
  
	<div class="col-sm-12">
		<button class="btn btn-success" type="button" onclick='changeFormat()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showHomePage"'>Cancel</button>
	</div>
 
   
</div>






<script type="javascript">

console.log("${userdetails}");
	document.getElementById("divTitle").innerHTML="User Configurations";
	document.title +=" User Configurations ";
	drpinvoiceid.value="${userdetails.invoice_format}";
	drpinvoicetype.value="${userdetails.invoice_type}";
	
	
	<c:if test="${userdetails.invoice_default_checked_print eq 'Y'}">
		invchkprint.checked=true;
	</c:if>
	
	<c:if test="${userdetails.invoice_default_checked_generatepdf eq 'Y'}">
		invchkpdf.checked=true;
	</c:if>

	<c:if test="${userdetails.restaurant_default_checked_generatepdf eq 'Y'}">
		reschkpdf.checked=true;
	</c:if>
	
	<c:if test="${userdetails.user_total_payments eq 'Y'}">
		totalpayment.checked=true;
	</c:if>
	
	<c:if test="${userdetails.user_payment_collections eq 'Y'}">
		paymentcollection.checked=true;
	</c:if>
	
	<c:if test="${userdetails.user_counter_sales eq 'Y'}">
		counter.checked=true;
	</c:if>
	
	<c:if test="${userdetails.user_payment_sales eq 'Y'}">
		paymentsales.checked=true;
	</c:if>
	
	<c:if test="${userdetails.user_store_sales eq 'Y'}">
		storesales.checked=true;
	</c:if>

	<c:if test="${userdetails.user_store_bookings eq 'Y'}">
		storebooking.checked=true;
	</c:if>

	<c:if test="${userdetails.user_store_expenses eq 'Y'}">
		storeexpense.checked=true;
	</c:if>
	
	
	
	
	
	
	function changeFormat()
	{
		
		

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		  	  toastr["success"](xhttp.responseText);
		    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
		    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "2000",
		    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
		    	  "showMethod": "fadeIn","hideMethod": "fadeOut"}
  				window.location='?a=showHomePage';
			  
			  
			}
		  };
		  xhttp.open("GET","?a=changeInvoiceFormat&formatId="+drpinvoiceid.value+"&invoice_type="+drpinvoicetype.value+"&invoice_default_checked_print="+invchkprint.checked
				  +"&invoice_default_checked_generatepdf="+invchkpdf.checked
				  +"&restaurant_default_checked_generatepdf="+reschkpdf.checked
				  +"&user_total_payments="+totalpayment.checked
				  +"&user_payment_collections="+paymentcollection.checked
				  +"&user_counter_sales="+counter.checked
				  +"&user_payment_sales="+paymentsales.checked
				  +"&user_store_sales="+storesales.checked
				  +"&user_store_bookings="+storebooking.checked
				  +"&user_store_expenses="+storeexpense.checked, true);    
		  xhttp.send();
		
	}
</script>
