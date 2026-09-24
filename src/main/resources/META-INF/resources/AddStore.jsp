  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="storeDetails" value='${requestScope["outputObject"].get("storeDetails")}' />

</head>


<script type="javascript">


function addStore()
{	
	
	 if(storename.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Store Name");
   	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
   	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
   	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
   	  "showMethod": "fadeIn","hideMethod": "fadeOut"
   	   };
	  	
	  	 
       	
   		storename.focus();
	  	return;
	  }
	
	
	document.getElementById("frm").submit(); 
}






</script>


<br>

<div class="container" style="padding:20px;background-color:white">


<form id="frm" action="?a=addStore" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreName">Store Name*</label>
      <input type="text" class="form-control" id="storename" value="${storeDetails.store_name}" name="storeName" placeholder="Store Name">
      <input type="hidden" name="hdnStoreId" value="${storeDetails.store_id}" id="hdnStoreId">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreAddress">Address Line 1</label>
      <input type="text" class="form-control" id="address_line_1" value="${storeDetails.address_line_1}" name="address_line_1" placeholder="Address 1">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreAddress">Address Line 2</label>
      <input type="text" class="form-control" id="address_line_2" value="${storeDetails.address_line_2}" name="address_line_2" placeholder="Address 2">
    </div>
  </div>
  
   <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreAddress">Address Line 3</label>
      <input type="text" class="form-control" id="address_line_3" value="${storeDetails.address_line_3}" name="address_line_3" placeholder="Address 3">
    </div>
  </div>
  
  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreAddress">City(State)</label>
      <input type="text" class="form-control" id="city" value="${storeDetails.city}" name="city" placeholder="City">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreAddress">Pincode</label>
      <input type="text" class="form-control" id="pincode" value="${storeDetails.pincode}" name="pincode" placeholder="Pincode">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreEmail">Email</label>
      <input type="text" class="form-control" id="storeEmail" value="${storeDetails.store_email}" name="storeEmail" placeholder="Email">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="StoreEmail">Mobile No / Phone</label>
      <input type="text" class="form-control" id="mobile_no" value="${storeDetails.mobile_no}" name="mobile_no" placeholder="Mobile No">
    </div>
  </div>
  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="gstno">GST No</label>
      <input type="text" class="form-control" id="gstno" value="${storeDetails.gst_no}" name="gstno" placeholder="GST No">
    </div>
  </div>  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="storetiming">Store Timings</label>
      <input type="text" class="form-control" id="storetiming" value="${storeDetails.store_timing}" name="storetiming" placeholder="Store Timings">
    </div>
  </div>
  
  </div>
  
  <c:if test="${action ne 'Update'}">
		
		<button class="btn btn-success" type="button" onclick='addStore()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showStoreMaster"'>Cancel</button>
		
		
		</c:if>
		
		
		
		<c:if test="${action eq 'Update'}">	
				
				<input type="button" type="button"  class="btn btn-success" onclick='addStore()' value="update">Update</button>	
					
		</c:if> 
</div>
</form>








<script type="javascript">

<c:if test="${storeDetails.store_id eq null}">
	document.getElementById("divTitle").innerHTML="Add Store";
	document.title +=" Add Store ";
</c:if>
<c:if test="${storeDetails.store_id ne null}">
	document.getElementById("divTitle").innerHTML="Update Store";
	document.title +=" Update Store ";
</c:if>


var arr=window.location.toString().split("/");
callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");	
	
</script>
