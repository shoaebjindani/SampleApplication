<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





<c:set var="personDetails" value='${requestScope["outputObject"].get("personDetails")}' />







</head>



<script>
function addCategory()
{	
	
	
	document.getElementById("frm").submit(); 
}

window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		 addCategory();
	} 
	});


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

<form id="frm" action="?a=addPerson" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">




	<div class="col-sm-12">
		<div class="form-group">
		<label for="email">Person Name</label>
		<input type="text" class="form-control" id="txtpersonname" value="${personDetails.person_name}"  placeholder="eg. NAME" name="txtpersonname">
		<input type="hidden" name="hdnPersonId" value="${personDetails.person_id}" id="hdnPersonId">
	  </div>
	</div>


<div class="col-sm-12">
  	<div class="form-group">
      <label for="MobileNo">Person Mobile No</label>
      <input type="text" class="form-control" id="txtmobileno" value="${personDetails.person_mobile_no}" name="txtmobileno" placeholder="Mobile No" onkeypress="digitsOnly(event)" maxlength="10" required>
    </div>
  </div>


  <c:if test="${action ne 'Update'}">

		<button class="btn btn-success" type="button" onclick='addCategory()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>


		</c:if>



		<c:if test="${action eq 'Update'}">	

				<input type="button" type="button" class="btn btn-success" onclick='addCategory()' value="update">		
		</c:if> 
</div>
</form>




	<c:if test="${personDetails.person_id eq null}">
		<script>document.getElementById("divTitle").innerHTML="Add Person";</script>
	</c:if>
	<c:if test="${personDetails.person_id ne null}">
		<script>
			document.getElementById("divTitle").innerHTML="Update Person";
			
		</script>
	</c:if>
