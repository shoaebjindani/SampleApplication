<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           

<c:set var="activeNozzles" value='${requestScope["outputObject"].get("activeNozzles")}' />
<c:set var="lstOfShifts" value='${requestScope["outputObject"].get("lstOfShifts")}' />
<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />

<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />




</head>


<script type="javascript">


function addConfigureLR()
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
		  xhttp.open("GET","?a=addConfigureLR&printer="+printer.value+"&copies="+copies.value, true); 
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
      <label for="email">Select Printer</label>
 <select class="form-control" name="printer" id="printer">
 
 <option value="Epson">Epson</option>
 <option value="TVS">TVS</option>
 
      </select> 
      
    </div>
  </div>
  
      <div class="col-6">
  	<div class="form-group">
      <label for="email">No. of Copies</label>
 <select class="form-control" name="copies" id="copies">
      
			    <option value="1">1 </option>
			    <option value="2">2 </option>
			    <option value="3">3 </option>
			    <option value="4">4 </option>
			    <option value="5">5 </option>    
	    </select>
      
    </div>
  </div>
  
  
  
  <div class="col-sm-12" align="center">
  	<div class="form-group">
   <button class="btn btn-success" type="button" onclick='addConfigureLR()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showConfigureLR"'>Cancel</button>

 
      
    </div>
  </div>
  
   
      
    </div>
  </div>
 
  
  
 		
		
		
		
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${SwipeDetails.SwipeMachineId eq null}">
		document.getElementById("divTitle").innerHTML="Configure LR";
		document.title +=" Configure LR ";
	</c:if>
	
	$( "#txttestdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
</script>






