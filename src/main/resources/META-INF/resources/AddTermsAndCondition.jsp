  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="termsAndConditionDetails" value='${requestScope["outputObject"].get("termsAndConditionDetails")}' />

</head>


<script type="javascript">


function addTermsAndCondition()
{	
	if(termscondition.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Terms And Condition");
	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
	  "showMethod": "fadeIn","hideMethod": "fadeOut"
	   };
	  	
	  	 
    	
	  termscondition.focus();
	  	return;
	  }
	
	if(order.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Order");
	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
	  "showMethod": "fadeIn","hideMethod": "fadeOut"
	   };
	  	
	  	 
  	
	  order.focus();
	  	return;
	  }
	
	document.getElementById("frm").submit(); 
}


</script>


<br>

<div class="container" style="padding:20px;background-color:white">


	<form id="frm" action="?a=addTermsAndCondition" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
	<input type="hidden" name="app_id" value="${userdetails.app_id}">
	<input type="hidden" name="user_id" value="${userdetails.user_id}">
	<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="termscondition">Terms Condition Content*</label>
      <input type="text" class="form-control" id="termscondition" value="${termsAndConditionDetails.terms_condition_content}" name="termscondition" placeholder="Terms Condition Content">
      <input type="hidden" name="hdntermsId" value="${termsAndConditionDetails.terms_condition_id}" id="hdntermsId">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="order">Order*</label>
      <input type="text" class="form-control" id="order" value="${termsAndConditionDetails.order}" name="order" placeholder="Order">
    </div>
  </div>
  
 </div>
  
  <c:if test="${action ne 'Update'}">
		
		<button class="btn btn-success" type="button" onclick='addTermsAndCondition()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showTermsAndCondition"'>Cancel</button>
		
		
		</c:if>
		
		
		
		<c:if test="${action eq 'Update'}">	
				
				<input type="button" type="button" class="btn btn-success" onclick='addTermsAndCondition()' value="update">Update</button>	
					
		</c:if> 
</div>
</form>








<script type="javascript">

<c:if test="${termsAndConditionDetails.terms_condition_id eq null}">
	document.getElementById("divTitle").innerHTML="Add Terms And Condition";
	document.title +=" Add Terms And Condition ";
</c:if>
<c:if test="${termsAndConditionDetails.terms_condition_id ne null}">
	document.getElementById("divTitle").innerHTML="Update Terms And Condition";
	document.title +=" Update Terms And Condition ";
</c:if>


var arr=window.location.toString().split("/");
callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");	
	
</script>
