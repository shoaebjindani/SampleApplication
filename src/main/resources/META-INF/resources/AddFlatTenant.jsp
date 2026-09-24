<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





<c:set var="flattenantDetails" value='${requestScope["outputObject"].get("flattenantDetails")}' />


<c:set var="listOfFlats" value='${requestScope["outputObject"].get("FlatList")}' />

<c:set var="listOfPersons" value='${requestScope["outputObject"].get("PersonList")}' />






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

<form id="frm" action="?a=addFlatTenant" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">


<datalist id="listOfFlat">
<c:forEach items="${listOfFlats}" var="cat">
 <option id="${cat.flat_id}">${cat.block_name} ${cat.flat_name}</option>	
 </c:forEach>
</datalist>

<datalist id="listOfPerson">
<c:forEach items="${listOfPersons}" var="cat">
 	<option id="${cat.personId}">${cat.personName}</option>	
	 </c:forEach>
</datalist>


		<div class="row">
  <div class="col-sm-6">
	<div class="form-group">
	<label for="email">Flat Name </label>     
	<input type="textbox" name="txtflatname" id="txtflatname" class="form-control" list="listOfFlat" onchange="checkforMatchFlat()"/> 
	<input type="hidden" name="hdnselectedflat" id="hdnselectedflat" value="">
	</div>
	</div>
		</div>
		


		

		<div class="row">
  <div class="col-sm-6">
	<div class="form-group">
	<label for="email">Person Name </label>     
	<input type="textbox" class="form-control" list="listOfPerson" name="txtpersonname" id="txtpersonname" onchange="checkforMatchPerson()"/>
	<input type="hidden" name="hdnselectedperson" id="hdnselectedperson" value="">
	 	</div>
	</div>
	</div>


 
		 <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Rented Date</label>
      <input type="text" class="form-control" id="txtrenteddate" readonly value="${flattenantDetails.FormattedRenteddate}"  name="txtrenteddate">     
    </div>
  </div>
  
	 <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Vacated Date</label>
      <input type="text" class="form-control" id="txtvacateddate" readonly value="${flattenantDetails.FormattedVacateddate}"  name="txtvacateddate">     
    </div>
  </div>







		<button class="btn btn-success" type="button" onclick='addCategory()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>


	



	
</div>
</form>




	<c:if test="${flatDetails.flat_id eq null}">
		<script>document.getElementById("divTitle").innerHTML="Add Flat Tenant";</script>
	
</c:if>

<script>
$( "#txtrenteddate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txtvacateddate" ).datepicker({ dateFormat: 'dd/mm/yy' });

function checkforMatchFlat()
{
	var searchString= document.getElementById("txtflatname").value;
	
	var options1=document.getElementById("listOfFlat").options;
	var flatId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
					flatId=options1[x].id;
					break;
				}
		}
	if(flatId!=0)
		{
			document.getElementById("hdnselectedflat").value=flatId;			
			document.getElementById("txtflatname").disabled=true;						
		}
	else
		{
			//searchForCustomer(searchString);
		}
	
	
}


function checkforMatchPerson()
{
	var searchString= document.getElementById("txtpersonname").value;
	
	var options1=document.getElementById("listOfPerson").options;
	var personId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
					personId=options1[x].id;
					break;
				}
		}
	if(personId!=0)
		{
			document.getElementById("hdnselectedperson").value=personId;			
			document.getElementById("txtpersonname").disabled=true;						
		}
	else
		{
			//searchForCustomer(searchString);
		}
	
	
}

txtflatname.focus();
</script>