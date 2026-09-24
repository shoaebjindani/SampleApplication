  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="NozzleDetails" value='${requestScope["outputObject"].get("NozzleDetails")}' />
<c:set var="listOfItems" value='${requestScope["outputObject"].get("listOfItems")}' />
<c:set var="listOfDispensers" value='${requestScope["outputObject"].get("listOfDispensers")}' />







</head>


<script type="javascript">


function addNozzle()
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

<form id="frm" action="?a=addNozzle" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Nozzle Name</label>
      <input type="text" class="form-control" id="Nozzlename" value="${NozzleDetails.nozzle_name}"  placeholder="eg. Nozzle 1" name="NozzleName">
      <input type="hidden" name="hdnNozzleId" value="${NozzleDetails.nozzle_id}" id="hdnNozzleId">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Item Type</label>
      
      <select class="form-control" name="drpfueltype" id="drpfueltype">
      <c:forEach items="${listOfItems}" var="item">
			    <option value="${item.item_id}">${item.item_name}</option>			    
	   </c:forEach></select>
            
    </div>
  </div>
  
   
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Dispenser Type</label>
      
      <select class="form-control" name="drpDispenserId" id="drpDispenserId">
      <c:forEach items="${listOfDispensers}" var="dispenser">
			    <option value="${dispenser.dispenser_id}">${dispenser.dispenser_name}</option>			    
	   </c:forEach></select>
            
    </div>
  </div>
  
  
  
  
  
  <c:if test="${action ne 'Update'}">
		
		<button class="btn btn-success" type="button" onclick='addNozzle()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showNozzleMaster"'>Cancel</button>
		
		
		</c:if>
		
		
		
		<c:if test="${action eq 'Update'}">	
				
				<input type="button" type="button" class="btn btn-success" onclick='addNozzle()' value="update">		
		</c:if> 
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${NozzleDetails.nozzle_id eq null}">
		document.getElementById("divTitle").innerHTML="Add Nozzle";
		document.title +=" Add Nozzle ";
	</c:if>
	<c:if test="${NozzleDetails.nozzle_id ne null}">
		document.getElementById("divTitle").innerHTML="Update Nozzle";
		document.title +=" Update Nozzle ";
		
		
		drpfueltype.value="${NozzleDetails.item_id}";
		drpDispenserId.value="${NozzleDetails.parent_dispenser_id}";
	</c:if>
</script>



