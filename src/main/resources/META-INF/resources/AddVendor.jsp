  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="vendorDetails" value='${requestScope["outputObject"].get("vendorDetails")}' />
<c:set var="groupList" value='${requestScope["outputObject"].get("groupList")}' />
<c:set var="DistinctCityNames" value='${requestScope["outputObject"].get("DistinctCityNames")}' />

   





</head>


<script type="javascript">


function addVendor()
{	
	btnsave.disabled=true;
	 if(vendorname.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Vendor Name");
  	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
  	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
  	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
  	  "showMethod": "fadeIn","hideMethod": "fadeOut"
  	   };
	  	
	  	 
      			btnsave.disabled=false;
   	  vendorname.focus();
	  	return;
	  }
	
	 if(document.getElementById("mobileNumber").value=="" || document.getElementById("mobileNumber").value.length!=10)
	  {
	  	
	  
	  toastr["error"]("Please enter Valid Mobile number");
 	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
 	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
 	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
 	  "showMethod": "fadeIn","hideMethod": "fadeOut"
 	   };
	  	
	  	 
     	btnsave.disabled=false;
 	 mobileNumber.focus();
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

<form id="frm" action="?a=addVendor" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="VendorName">Vendor Name *</label>
      <input type="text" class="form-control" id="vendorname" value="${vendorDetails.vendor_name}" name="vendorName" placeholder="Vendor Name">
      <input type="hidden" name="hdnVendorId" value="${vendorDetails.vendor_id}" id="hdnVendorId">
    </div>
  </div>
  
   <div class="col-sm-12">
  	<div class="form-group">
      <label for="Address">Business Name</label>
      <input type="text" class="form-control" id="business_name" value="${vendorDetails.business_name}" name="business_name" placeholder="Business Name">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="VendorName">Vendor Reference</label>
      <input type="text" class="form-control" id="vendor_reference" value="${vendorDetails.vendor_reference}" name="vendor_reference" placeholder="Vendor Reference">
      
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="MobileNumber">Mobile Number *</label>
      <input type="text" class="form-control" id="mobileNumber" value="${vendorDetails.mobile_number}" name="mobileNumber" placeholder="Mobile Number" onkeypress="digitsOnly(event)" maxlength="10" required>
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="MobileNumber">Alternate Mobile No*</label>
      <input type="text" class="form-control" id="alternate_mobile_no" value="${vendorDetails.alternate_mobile_no}" name="alternate_mobile_no" placeholder="Alternate Mobile No" onkeypress="digitsOnly(event)" maxlength="10" required>
    </div>
  </div>
  
  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="City">City</label>
      <input type="text" list="cityList" class="form-control" id="city" value="${vendorDetails.city}" name="city" placeholder="City">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="Address">Address</label>
      <input type="text" class="form-control" id="address" value="${vendorDetails.address}" name="address" placeholder="Address">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="Address">GST No</label>
      <input type="text" class="form-control" id="gstno" value="${vendorDetails.gst_no}" name="gstno" placeholder="GST No">
    </div>
  </div>
  
  
  
  
  
  
  <div class="col-sm-12" align="center">
  	<div class="form-group">
      
   <button class="btn btn-success" type="button" id="btnsave" onclick='addVendor()'>Save</button>
  <button class="btn btn-danger" type="reset" onclick='window.location="?a=showVendorMaster"'>Cancel</button>
     
    </div>
  </div>
  
  
  
  
  
  
  </div>
  
  
</div>
</form>








<script type="javascript">
	<c:if test="${vendorDetails.vendor_id ne null}">	
		document.getElementById('vendorType').value='${vendorDetails.vendor_type}';
		document.getElementById('vendorGroup').value='${vendorDetails.group_id}';
	</c:if>
	
	<c:if test="${vendorDetails.vendor_id eq null}">
		document.getElementById("divTitle").innerHTML="Add Vendor";
		document.title +=" Add Vendor ";
	</c:if>
	<c:if test="${vendorDetails.vendor_id ne null}">
		document.getElementById("divTitle").innerHTML="Update Vendor";
		document.title +=" Update Vendor ";
	</c:if>
	
	var arr=window.location.toString().split("/");
	callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");
</script>
