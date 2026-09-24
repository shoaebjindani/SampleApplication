<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


           
           


<c:set var="DispenserDetails" value='${requestScope["outputObject"].get("DispenserDetails")}' />


   





</head>


<script type="javascript">


function addDispenser()
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

<form id="frm" action="?a=addDispenser" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Dispenser Name</label>
      <input type="text" class="form-control" id="dispenser_name" value="${DispenserDetails.dispenser_name}"  placeholder="eg. Dispenser Unit 01" name="dispenser_name">
      <input type="hidden" name="hdnDispenserId" value="${DispenserDetails.dispenser_id}" id="hdnDispenserId">
    </div>
  </div>
  
  
  
 
  
  
 		
		<button class="btn btn-success" type="button" onclick='addDispenser()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showDispenserMaster"'>Cancel</button>
		
		
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${DispenserDetails.DispenserId eq null}">
		document.getElementById("divTitle").innerHTML="Add Dispenser";
		document.title +=" Add Dispenser ";
	</c:if>
	<c:if test="${DispenserDetails.DispenserId ne null}">
		document.getElementById("divTitle").innerHTML="Update Dispenser";
		document.title +=" Update Dispenser ";
	</c:if>
</script>



