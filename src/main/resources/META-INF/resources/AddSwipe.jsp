<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="SwipeDetails" value='${requestScope["outputObject"].get("SwipeDetails")}' />


   





</head>


<script type="javascript">


function addSwipe()
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

<form id="frm" action="?a=addSwipe" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">


  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Swipe Machine Name</label>
      <input type="text" class="form-control" id="swipe_machine_name" value="${SwipeDetails.swipe_machine_name}"  placeholder="eg. Swipe Name" name="swipe_machine_name">
      <input type="hidden" name="hdnSwipeMachineId" value="${SwipeDetails.swipe_machine_id}" id="hdnSwipeMachineId">
    </div>
  </div>
  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Swipe Machine Bank</label>
      <input type="text" class="form-control" id="swipe_machine_bank" value="${SwipeDetails.swipe_machine_bank}"  placeholder="eg. Swipe Bank" name="swipe_machine_bank">
      
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Swipe Machine Account No</label>
      <input type="text" class="form-control" id="swipe_machine_account_no" value="${SwipeDetails.swipe_machine_account_no}"  placeholder="eg. Swipe Account No" name="swipe_machine_account_no">
      
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Swipe Machine Short Name</label>
      <input type="text" class="form-control" id="swipe_machine_short_name" value="${SwipeDetails.swipe_machine_short_name}"  placeholder="eg. Swipe Short Name" name="swipe_machine_short_name">
      
    </div>
  </div>
 
  
  
 		
		<button class="btn btn-success" type="button" onclick='addSwipe()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showSwipeMaster"'>Cancel</button>
		
		
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${SwipeDetails.SwipeMachineId eq null}">
		document.getElementById("divTitle").innerHTML="Add Swipe";
		document.title +=" Add Swipe ";
	</c:if>
	<c:if test="${SwipeDetails.SwipeMachineId ne null}">
		document.getElementById("divTitle").innerHTML="Update Swipe";
		document.title +=" Update Swipe ";
	</c:if>
</script>



