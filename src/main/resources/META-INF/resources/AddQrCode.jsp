<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="QrCodeDetails" value='${requestScope["outputObject"].get("QrCodeDetails")}' />
<c:set var="lstEmployees" value='${requestScope["outputObject"].get("lstEmployees")}' />

   





</head>


<script type="javascript">


function addQrCode()
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

<form id="frm" action="?a=addQrCode" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">


  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Qr Code Number</label>
      <input type="text" class="form-control" name="qr_code_number"  placeholder="Qr Code Number" value="${QrCodeDetails.qr_code_number}">
      <input type="hidden" class="form-control" name="hdnQrId"  placeholder="Qr Code Number" value="${QrCodeDetails.qr_id}">
      
    </div>
  </div>
  
 <div class="col-sm-12">
  	<div class="form-group">
      <label for="CurrentlyAssignedTo">Currently Assigned To</label>
      <select class="form-control" name="CurrentlyAssignedTo" id="CurrentlyAssignedTo">
      	
      	
      	<c:forEach items="${lstEmployees}" var="employee">
			    			    <option value="${employee.user_id}">${employee.name}</option>
	   </c:forEach>
      	
      	
      	
      </select> 
      
    </div>
  </div>
  
  
  
 		
		<button class="btn btn-success" type="button" onclick='addQrCode()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showQrCodeMaster"'>Cancel</button>
		
		
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${QrCodeDetails.qr_id eq null}">
		document.getElementById("divTitle").innerHTML="Add QrCode";
		document.title +=" Add QrCode ";
	</c:if>
	<c:if test="${QrCodeDetails.qr_id ne null}">
		document.getElementById("divTitle").innerHTML="Update QrCode";
		document.title +=" Update QrCode ";
		
		CurrentlyAssignedTo.value='${QrCodeDetails.currently_assigned_to}'
		
	</c:if>
</script>



