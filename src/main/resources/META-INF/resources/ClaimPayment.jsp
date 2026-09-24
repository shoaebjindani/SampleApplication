  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="paymentDetails" value='${requestScope["outputObject"].get("paymentDetails")}' />
<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />
   





</head>


<script type="javascript">


function claimPayment()
{	
	
	
	document.getElementById("frm").submit(); 
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



<br>

<div class="container" style="padding:20px;background-color:white">

<form id="frm" action="?a=claimPayment" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Payment Amount</label>
      <input type="text" class="form-control" readonly value="${paymentDetails.amount}"  readonly>
      <input type="hidden" name="order_id" value="${paymentDetails.order_id}" id="order_id">
      
    </div>
    
    
    <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">BHIM UPI</label>
      <input type="text" class="form-control" id="bhim_upi_id" readonly value="${paymentDetails.bhim_upi_id}"   name="bhim_upi_id">      
    </div>
    
    
  </div>
  
  
   <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Mobile No</label>
      <input type="text" class="form-control" readonly id="txtmbobileno" value="${paymentDetails.mobile_no}"   name="txtmbobileno">      
    </div>
    
    
  </div>
  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Choose Attendant</label>
      
      <select class="form-control" name="drpemployee" id="drpemployee">
      <c:forEach items="${userList}" var="user">
			    <option value="${user.user_id}">${user.name}</option>    
	   </c:forEach></select>
            
    </div>
  </div>
  
  
  

		
		<input type="button" type="button" class="btn btn-success" onclick='claimPayment()' value="Claim Payment">		
		
</div>
</form>

<script type="javascript">
	
	
	
	
</script>



