<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           

<c:set var="activeNozzles" value='${requestScope["outputObject"].get("activeNozzles")}' />
<c:set var="lstOfShifts" value='${requestScope["outputObject"].get("lstOfShifts")}' />
<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />

<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />




</head>


<script type="javascript">


function addSwipe()
{	
	
	
	document.getElementById("frm").submit(); 
}








function addTestFuel()
{
		
		//get values from textboxes and pass on in ajax
		// before sending you can alert to see if expected values are getting fetched from input controls..
		//but how will I receive the data
		var qty=txtquantity.value;
		
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
		  xhttp.open("GET","?a=addPumpTest&testqty="+txtquantity.value+"&testdate="+ txttestdate.value +"&testnozzle="+nozzle_id.value, true); 
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
  
  
  <div class="col-6">
  	<div class="form-group">
      <label for="email">Test Quantity</label>
 <input type="text" class="form-control" id="txtquantity" placeholder="Test Quantity" name="txtquantity">      
    </div>
  </div>
  
  <div class="col-6">
  	<div class="form-group">
      <label for="email">Date</label>
 <input type="text" readonly class="form-control" id="txttestdate" placeholder="" name="txttestdate" value="${todaysDate }"> 
      
    </div>
  </div>
  
  <div class="col-6">
  	<div class="form-group">
      <label for="email">Nozzle</label>
 <select class="form-control" name="nozzle_id" id="nozzle_id">
      <c:forEach items="${activeNozzles}" var="nozzle">
			    <option value="${nozzle.nozzle_id}">(${nozzle.nozzle_name}) (${nozzle.shift_name}) (${nozzle.name}) </option>    
	   </c:forEach></select> 
      
    </div>
  </div>
  
   
  
  
  
  <div class="col-sm-12" align="center">
  	<div class="form-group">
   <button class="btn btn-success" type="button" onclick='addTestFuel()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showAddPumpTest"'>Cancel</button>

 
      
    </div>
  </div>
  
   
      
    </div>
  </div>
 
  
  
 		
		
		
		
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${SwipeDetails.SwipeMachineId eq null}">
		document.getElementById("divTitle").innerHTML="Add Pump Test";
		document.title +=" Add Pump Test";
	</c:if>
	
	$( "#txttestdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
</script>






