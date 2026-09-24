<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/js/bootstrap-datetimepicker.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">


  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="itemList" value='${requestScope["outputObject"].get("itemList")}' />
<c:set var="customerMaster" value='${requestScope["outputObject"].get("customerMaster")}' />
<c:set var="EmployeeList" value='${requestScope["outputObject"].get("EmployeeList")}' />

<c:set var="modelList" value='${requestScope["outputObject"].get("modelList")}' />
<c:set var="todaysdate" value='${requestScope["outputObject"].get("todaysdate")}' />
<c:set var="mobileBookingDetails" value='${requestScope["outputObject"].get("mobileBookingDetails")}' />




   





</head>


<script type="javascript">

function removethisitem(btn1)
{
	btn1.parentElement.parentElement.remove();	 
}

function checkforMatchItem()
{
	var searchString= document.getElementById("txtitem").value;	
	var options1=document.getElementById("itemList").options;
	
	
	var itemId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
				itemId=options1[x].id;
				
					break;
				}
		}
	if(itemId!=0)
		{			
				
				
				var total=0;
				var rows=tblitems.rows;
				for(var x=1;x<rows.length;x++)
					{							
						if(itemId==rows[x].childNodes[0].innerHTML)
							{
								alert('item already exist in selection');
								document.getElementById("txtitem").value="";
								return;
							}
					}
				
				// code to check if item already exist inselection				
			getItemDetailsAndAddToTable(itemId,searchString);
				document.getElementById("txtitem").value="";
		}
	
}


function getItemDetailsAndAddToTable(itemId,itemName)
{
	document.getElementById("closebutton").style.display='none';
	document.getElementById("loader").style.display='block';	    	
	    	
	    	var table = document.getElementById("tblitems");	    	
	    	var row = table.insertRow(-1);
	    	var cell0 = row.insertCell(0);
	    	var cell1 = row.insertCell(1);
	    	var cell2 = row.insertCell(2);
	    	var cell3 = row.insertCell(3);
	    	var cell4 = row.insertCell(4);
	    	
	    	
	    	var arritemName=itemName.split('~');
	    	
	    	
	    	cell0.innerHTML = itemId;
	    	cell1.innerHTML = arritemName[1];
	    	cell2.innerHTML = arritemName[0];
	    	cell3.innerHTML = " <input type='text' class='form-control input-sm' id='txtqty' onkeyup='calculateAmount(this);checkIfEnterisPressed(event)' onkeypress='digitsOnlyWithDot(event)' value='1'>";   	
	    		    	
	    	
	    	cell4.innerHTML = '<button type="button" class="btn btn-danger"  onclick=removethisitem(this) id="btn11" style="cursor:pointer">Delete</button>';
	    	
	    	
	    
		
	  
			
}


function saveBooking()
{
	
	var rows=tblitems.rows;
	
	var requiredDetails=[];
	 
	var arr = [];
	var itemString="";
	var confirmMessage="";
	var proceedFlag=true;
	for (var x= 1; x < rows.length; x++) 
	{   
	    // ID, Product Code, Item Name,No Of Labels,isPrintPrice
	    itemString+=
	    	rows[x].childNodes[0].innerHTML+	    
	    "~"+rows[x].childNodes[3].childNodes[1].value+	    
	    "|";
	}
	
	 var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) 
	    {
	    	toastr["success"](xhttp.responseText);
	    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
	    	  "showMethod": "fadeIn","hideMethod": "fadeOut"}
	    	
	    	if(xhttp.responseText!="Booking Already Exists for another Customer")
	    		{
	    			window.location="?a=showBookingsRegister"		
	    		}
	    	
	        
	      
	    }
	  };
	  xhttp.open("POST", "?a=addBooking", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  var dataToSend="itemDetails="+itemString+"&app_id=${userdetails.app_id}&store_id=${userdetails.store_id}&customerId="
	  +hdnSelectedCustomer.value+"&fromDateTime="+txtfromdatetextbox.value+"&toDateTime="
	  +txttodatetextbox.value+"&prefferedEmployee="+drpuserid.value+"&remarks="
	  +remarks.value+"&modelname="+modelname.value
	  +"&uniqueno="+uniqueno.value
	  +"&mobile_booking_id=${param.mobile_booking_id}";
	  
	  xhttp.send(dataToSend);
	
	
	
}



</script>



<br>

<div class="container" style="padding:20px;background-color:white">



<form id="frm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="row">





<div class="col-sm-3">
  	<div class="form-group">
  	
  		 <div class="form-group">
        
          <input type="text" class="form-control form-control-sm" id="customerName"
                   placeholder="New Customer Name" name="customerName">
                        </div>
  
   			
   			
   			      
    </div>
  </div>
  
  <div class="col-sm-3">
  	<div class="form-group">
  	
  		 <div class="form-group">
        
       <input type="text" class="form-control form-control-sm" id="mobileNumber"
                   placeholder="Mobile Number" name="mobileNumber" maxlength="10" onkeypress="digitsOnly(event)">
                        </div>
  
   			
   			
   			      
    </div>
  </div>
  
  
  <div class="col-sm-3">
  	<div class="form-group">
  	
  		<div class="input-group input-group-sm">  		
  				<select id="customerType" name="customerType" class="form-control" style="height:100%" >
  				<option value="LoyalCustomer1">Loyal Customer 1</option>
  				<option value="LoyalCustomer2">Loyal Customer 2</option>
  				<option value="LoyalCustomer3">Loyal Customer 3</option>
  				<option value="Franchise">Franchise</option>
  				<option value="WholeSeller">WholeSeller</option>
  				<option value="Distributor">Distributor</option>
  				<option value="Business2Business">Business2Business</option>
  				<option value="shrikhand">Shrikhand Buyers</option>
  				<option value="New Customer" selected>New Customer</option>
  				</select>                                             
    </div>
  
   			
   			
   			      
    </div>
  </div>
  
   
  
<div class="col-sm-3">
  	<div class="form-group">
  	
  		 <div class="form-group">
        
       
       <button type="button" class="btn btn-primary btn-flat" onclick="quickAddCustomer()">Quick Add Customer</button>
       
       
                        </div>
  
   			
   			
   			      
    </div>
  </div>

 
  
  
  
  
  
   <div class="col-sm-4">
  	<div class="form-group">
  	<label for="email">Customer Name</label>
  		 <div class="form-group">
        
          <input type="text" class="form-control" id="txtsearchcustomer"    placeholder="Search For Customer" name="txtsearchcustomer"  onkeyup="oninputCustomerName()" oninput="checkforMatchCustomer()">
          
          <span class="input-group-append">
                    <button type="button" class="btn btn-danger btn-flat" onclick="resetCustomer()">Reset</button>
                    <button type="button" class="btn btn-primary btn-flat" onclick="addCustomer()">Add</button>
                  </span>
                  
                  
        <input  type="hidden" name="hdnSelectedCustomer" id="hdnSelectedCustomer" value="">
   			<input  type="hidden" name="hdnSelectedCustomerType" id="hdnSelectedCustomerType" value="">
   			<input  type="hidden" name="hdnPreviousInvoiceId" id="hdnPreviousInvoiceId" value="">
   			
   			<datalist id="customerList">

<c:forEach items="${customerMaster}" var="customer">
			    <option id="${customer.customerId}">${customer.customerName}~${customer.mobileNumber}~${customer.customerType}</option>			    
	   </c:forEach>	   	 

  	
</datalist>

   			<datalist id="modelList">

<c:forEach items="${modelList}" var="model">
			    <option >${model.modelName}</option>			    
	   </c:forEach>	   	 

  	
</datalist>


      </div>
  
   			
   			
   			      
    </div>
  </div>
  
  <div class="col-sm-4">
  	<div class="form-group">
  	<label for="email">From Date</label>
  		 <div class="form-group">
        <div class='input-group date' id='txtfromdate' >
          <input type='text' class="form-control" id='txtfromdatetextbox' />
          <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
          </span>
        </div>
      </div>
     </div>
  </div>
  
  <div class="col-sm-4">
  	<div class="form-group">
  	<label for="email">To Date</label>
  		 <div class="form-group">
        <div class='input-group date' id='txttodate' >
          <input type='text' class="form-control form-control-sm" id='txttodatetextbox'  />
          <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
          </span>
        </div>
      </div>
     </div>
  </div>
  
   <div class="col-sm-3">
  	<div class="form-group">
  	<label for="email">Preffered Employee</label>
  		 <div class="form-group">
  		 
  		 <select class="form-control" name="drpuserid" id="drpuserid">
      <c:forEach items="${EmployeeList}" var="employee">
			    <option value="${employee.user_id}">${employee.name}</option>			    
	   </c:forEach></select>
       
      </div>
     </div>
  </div>
  
   <div class="col-sm-3">
  	<div class="form-group">
  	<label for="email">Remarks</label>
  		 <div class="form-group">
  		 
  		 <textarea rows="4" id="remarks" name="remarks" class="form-control"></textarea>
      
       
      </div>
     </div>
  </div>
  
   <div class="col-sm-3">
  	<div class="form-group">
  	<label for="email">Model</label>
  		 <div class="form-group">
  		 
  		 <input type="text" class="form-control" id="modelname"    placeholder="Search For Model" name="modelname"  list='modelList' >
      
       
      </div>
     </div>
  </div>
  
  <div class="col-sm-3">
  	<div class="form-group">
  	<label for="email">Unique No</label>
  		 <div class="form-group">
  		 
  		 <input type="text" class="form-control" id="uniqueno"    placeholder="Unique No" name="uniqueno" >
      
       
      </div>
     </div>
  </div>


<div class="col-sm-12">
  	<div class="form-group">      
  		<input type="text" class="form-control"    placeholder="Search for Items" list="itemList" id="txtitem" name="txtitem" oninput="checkforMatchItem()">          
    </div>
  </div>
  
  <datalist id="itemList">
<c:forEach items="${itemList}" var="item">
			    <option id="${item.item_id}">${item.item_name}~${item.product_code}</option>			    
	   </c:forEach></select>	   	   	
</datalist>


<div class="col-sm-12">  
	  <div class="card-body table-responsive p-0" style="height: 370px;">                
	                <table id="tblitems"  class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                  <thead>
	                    <tr align="center">
	                     <th style="z-index:0">Item Id</th>
	                     <th style="z-index:0">Product Code</th>
	  			<th style="z-index:0">Item Name</th>
	  			<th style="z-index:0">Qty</th>
	  				  				  			
	  			<th></th>
	                    </tr>
	                  </thead>
	                </table>
	   </div>	
  </div>
  
  
  
  <div class="col-sm-12" align="center">
  	<div class="form-group">      
  		<button class="btn btn-success" type="button" onclick='saveBooking()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>          
    </div>
  </div>
  
  
		
	 
</div>
</form>

<script type="javascript">
	
	

		document.getElementById("divTitle").innerHTML="Add New Booking";
		document.title +=" Add New Booking ";
		
		
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
					//fetchPendingAmountForThisCustomer(customerId);	
				}
			else
				{
					//searchForCustomer(searchString);
				}
			
			
			
		}
		
		function resetCustomer()
		{
			window.location.reload();
			txtsearchcustomer.disabled=false;
			txtsearchcustomer.value="";
			hdnSelectedCustomer.value=0;	
		}
		
		$(function() {
			
			  $('#txtfromdate').datetimepicker({			        
			         format: 'DD/MM/YYYY HH:mm',          
			    });
			  
			  $('#txttodate').datetimepicker({			        
			         format: 'DD/MM/YYYY HH:mm',          
			    });
			  
			});		
		
		
		$("#txtfromdate").keypress(function(event) {event.preventDefault();});
		$("#txttodate").keypress(function(event) {event.preventDefault();});
		
		
		function addCustomer()
		{
			window.open("?a=showAddCustomer&mobileNo="+txtsearchcustomer.value);	
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
		
		if(document.getElementById("txtfromdatetextbox").value=="")
			{
				document.getElementById("txtfromdatetextbox").value="${todaysdate}";
			}
		if(document.getElementById("txttodatetextbox").value=="")
			{
				document.getElementById("txttodatetextbox").value="${todaysdate}";
			}
		
		
		function oninputCustomerName()
		{
			if(document.getElementById("txtsearchcustomer").value.length>=4)
			{
				document.getElementById("txtsearchcustomer").setAttribute("list", "customerList"); 			
			}
			else
				{
					document.getElementById("txtsearchcustomer").setAttribute("list", "");
				}
		}
		
				
		if("${param.mobile_booking_id}"!="")
			{					
				try
				{	
					setTimeout(function () {
						 txtsearchcustomer.value="${mobileBookingDetails.customer_name}";
						 hdnSelectedCustomer.value="${mobileBookingDetails.customer_id}";
						 txtfromdatetextbox.value="${mobileBookingDetails.FormattedFromDate}";
						 txttodatetextbox.value="${mobileBookingDetails.FormattedFromDate}";
						 remarks.value-"${mobileBookingDetails.remarks}";
						 
							
							document.getElementById("txtsearchcustomer").disabled=true;
							txtfromdatetextbox.disabled=true;
							txttodatetextbox.disabled=true;
							remarks.disabled=true;
							
							var m=0;

							
							<c:forEach items="${mobileBookingDetails.listOfItems}" var="item">
							
							m++;
							tableNo='${item.table_no}';
							var table = document.getElementById("tblitems");	    	
					    	var row = table.insertRow(-1);	    	
					    	var cell0 = row.insertCell(0);
					    	var cell1 = row.insertCell(1);
					    	var cell2 = row.insertCell(2);
					    	var cell3 = row.insertCell(3);
					    	var cell4 = row.insertCell(4);
					    	
					    	
					    	
					    	
					    	cell0.innerHTML = "${item.item_id}";
					    	cell1.innerHTML = "${item.product_code}";
					    	cell2.innerHTML = "${item.item_name}";
					    	cell3.innerHTML = "<input type='text' class='form-control input-sm' id='txtqty' onkeyup='calculateAmount(this);checkIfEnterisPressed(event)' onkeypress='digitsOnlyWithDot(event)' value='${item.quantity}'/>";   	
					    		    	
					    	
					    	cell4.innerHTML = '<button type="button" class="btn btn-danger"  onclick="removethisitem(this)" id="btn11" style="cursor:pointer">Delete</button>';
					    	
					    	
					    	
					    						    	
					    	
					    	
					    	
					    	
							
						    		//alert('${item.item_id}'+'-${item.item_name}'+'-${item.qty}'+'-${item.rate}'+'-${item.custom_rate}');			    
							</c:forEach>

							
							
							
							
					    }, 500);
					
				}
				catch(ex)
				{
					alert(ex.message);
				}
				
				
				
				
			}
		
		
		
		

</script>



