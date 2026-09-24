  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="customerDetails" value='${requestScope["outputObject"].get("customerDetails")}' />
<c:set var="groupList" value='${requestScope["outputObject"].get("groupList")}' />
<c:set var="DistinctCityNames" value='${requestScope["outputObject"].get("DistinctCityNames")}' />

   





</head>


<script type="javascript">


function addCustomer()
{	
	
	btnsave.disabled=true;
	if(document.getElementById("customername").value=="")
	{
		alert('Please enter Customer Name');
		mobileNumber.focus();
		btnsave.disabled=true;
		return; 
	}
	
	
	if(document.getElementById("mobileNumber").value=="" || document.getElementById("mobileNumber").value.length!=10)
		{
			alert('Please enter Valid Mobile number');
			mobileNumber.focus();
			btnsave.disabled=false;
			return; 
		}
	
	if(document.getElementById("alternate_mobile_no").value!="" && document.getElementById("alternate_mobile_no").value.length!=10)
	{
		alert('Please enter Valid Alternate Mobile number');
		alternate_mobile_no.focus();
		btnsave.disabled=false;
		return; 
	}
	
	document.getElementById("frm").submit(); 
}






</script>



<br>

<datalist id="cityList">
	<c:forEach items="${DistinctCityNames}" var="DistinctCityName">
			    <option id="${DistinctCityName}">${DistinctCityName}</option>			    
	   </c:forEach>	   	   	
</datalist>

<div class="container" style="padding:20px;background-color:white"> 

<form id="frm" action="?a=addCustomer" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="CustomerName">Customer Name *</label>
      <input type="text" class="form-control" id="customername" value="${customerDetails.customer_name}" name="customerName" placeholder="Customer Name">
      <input type="hidden" name="hdnCustomerId" value="${customerDetails.customer_id}" id="hdnCustomerId">
    </div>
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="MobileNumber">Birthday</label>
      <input type="text" class="form-control" name="birthday" id="birthday" value="${customerDetails.Formattedbirthday}" name="birthday" placeholder="Birthday" readonly>
    </div>
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="CustomerName">Customer Reference</label>
      <input type="text" class="form-control" id="customer_reference" value="${customerDetails.customer_reference}" name="customer_reference" placeholder="Customer Reference">
      
    </div>
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="MobileNumber">Mobile Number *</label>
      <input type="text" class="form-control" id="mobileNumber" value="${customerDetails.mobile_number}" name="mobileNumber" placeholder="Mobile Number" onkeypress="digitsOnly(event)" maxlength="10" required>
    </div>
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="MobileNumber">Alternate Mobile No</label>
      <input type="text" class="form-control" id="alternate_mobile_no" value="${customerDetails.alternate_mobile_no}" name="alternate_mobile_no" placeholder="Alternate Mobile No" onkeypress="digitsOnly(event)" maxlength="10" required>
    </div>
  </div>
  
  
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="City">City</label>
      <input type="text" list="cityList" class="form-control" id="city" value="${customerDetails.city}" name="city" placeholder="City">
    </div>
  </div>
  
  
    <div class="col-sm-6">
  	<div class="form-group">
      <label for="City">Anniversary</label>
      <input type="text" class="form-control" id="anniversary" readonly value="${customerDetails.formattedAnniversary}" name="anniversary" placeholder="Anniversary">
    </div>
  </div>
  
    <div class="col-sm-6">
  	<div class="form-group">
      <label for="City">Gender</label>
      <select class="form-control" id="drpgender" name="drpgender">
      	<option value="M">Male</option>
      	<option value="F">Female</option>
      </select>
      
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="Address">Address</label>
      <input type="text" class="form-control" id="address" value="${customerDetails.address}" name="address" placeholder="Address">
    </div>
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="CustomerType">Customer Type *</label>
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
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="CustomerType">Customer Group </label>      
  				<select id="customerGroup" name="customerGroup" class="form-control" >
  				<c:forEach items="${groupList}" var="group">
  						<option value="${group.group_id}">${group.group_name }</option>
  				</c:forEach>
  					
  				</select>
     
    </div>
  </div>
  
  
  <div class="col-sm-12" align="center">
  	<div class="form-group">
      
   <button class="btn btn-success" type="button" id="btnsave" onclick='addCustomer()'>Save</button>
  <button class="btn btn-danger" type="reset" onclick='window.location="?a=showCustomerMaster"'>Cancel</button>
     
    </div>
  </div>
  
  
  
  
  
  
  </div>
  
  
</div>
</form>








<script type="javascript">
	<c:if test="${customerDetails.customer_id ne null}">	
		document.getElementById('customerType').value='${customerDetails.customer_type}';
		document.getElementById('customerGroup').value='${customerDetails.group_id}';
	</c:if>
	
	<c:if test="${customerDetails.customer_id eq null}">
		document.getElementById("divTitle").innerHTML="Add Customer";
		document.title +=" Add Customer ";
	</c:if>
	<c:if test="${customerDetails.customer_id ne null}">
		document.getElementById("divTitle").innerHTML="Update Customer";
		document.title +=" Update Customer ";
	</c:if>
	
	var arr=window.location.toString().split("/");
	callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");
	
	$( "#birthday" ).datepicker({ dateFormat: 'dd/mm/yy' });
	$( "#anniversary" ).datepicker({ dateFormat: 'dd/mm/yy' });
</script>
