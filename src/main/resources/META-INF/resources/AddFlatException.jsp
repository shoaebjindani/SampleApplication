<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





<c:set var="flatexceptionDetails" value='${requestScope["outputObject"].get("flatexceptionDetails")}' />
<c:set var="listOfBlocks" value='${requestScope["outputObject"].get("BlockList")}' />
<c:set var="listOfFlats" value='${requestScope["outputObject"].get("FlatList")}' />





</head>



<script>

function resetFlat()
{	
	txtflatname.disabled=false;
	txtflatname.value="";
	hdnselectedflat.value=0;	
}


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

<form id="frm" action="?a=addFlatException" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">



<datalist id="listOfFlat">
<c:forEach items="${listOfFlats}" var="cat">
 <option id="${cat.flat_id}">${cat.block_name} ${cat.flat_name} (${cat.person_name}) ~ (${cat.type})</option>	
 </c:forEach>
</datalist>





		<div class="row">
  <div class="col-sm-12">
	<div class="form-group">
		
	<label for="email">Flat Name </label>     
	<div class="input-group input-group-sm">

	<input type="textbox" name="txtflatname" id="txtflatname" class="form-control form-control-sm" list="listOfFlat" onchange="checkforMatchFlat()"/> 
	<input type="hidden" name="hdnselectedflat" id="hdnselectedflat" value="">  <span class="input-group-append">
		<button type="button" class="btn btn-danger btn-flat" onclick="resetFlat()">Reset</button>
		</span>
	</div>
	</div>
		</div>
</div>
		

		
		 <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">From Date</label>
      <input type="text" class="form-control form-control-sm" id="txtfromdate" readonly value="${flatDetails.FormattedFromDate}"  name="txtfromdate">     
    </div>
  </div>
  


		 <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">To Date</label>
      <input type="text" class="form-control form-control-sm" id="txttodate" readonly value="${flatDetails.FormattedToDate}"  name="txttodate">     
    </div>
  </div>
  

 <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Remarks</label>
      <input type="text" class="form-control form-control-sm" id="txtremarks" value="${flatDetails.remarks}"  name="txtremarks">     
    </div>
  </div>



		<button class="btn btn-success" type="button" onclick='addCategory()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>


	



	
</div>
</form>




	<c:if test="${flatDetails.flat_id eq null}">
		<script>document.getElementById("divTitle").innerHTML="Add Flat Exception";</script>
	
</c:if>

<script>
$( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });

$( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });


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



txtflatname.focus();
</script>