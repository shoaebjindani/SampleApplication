  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="SupervisorDetails" value='${requestScope["outputObject"].get("SupervisorDetails")}' />
<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />
<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="lstOfShifts" value='${requestScope["outputObject"].get("lstOfShifts")}' />
<c:set var="suggestedShiftId" value='${requestScope["outputObject"].get("suggestedShiftId")}' />
<c:set var="collectionData" value='${requestScope["outputObject"].get("collectionData")}' />

   





</head>


<script type="javascript">




function saveSubmitCash()
{	
	var notes=document.getElementById('notes').value
	var coins=document.getElementById('coins').value
	var collectionDate=document.getElementById('txtcollectiondate').value
	var shiftId=document.getElementById('drpshiftid').value
	


	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	      
		  toastr["success"](xhttp.responseText);
	    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
	    	  "showMethod": "fadeIn","hideMethod": "fadeOut"}
	    	
	    	window.location.reload();
		  
		}
	  };
	
	xhttp.open("GET","?a=submitCashtoVault&notes="+notes+"&coins="+coins+"&collectionDate="+collectionDate+"&shiftId="+shiftId, true);    
	xhttp.send();
	
	
	
	
//document.getElementById("frm").submit(); 
}















</script>



<br>

<div class="container" style="padding:20px;background-color:white">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">
  
  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Collection Date</label>
      <input type="text" class="form-control" readonly id="txtcollectiondate"  placeholder="Collection Date" name="txtcollectiondate">
    </div>
  </div>
  
  
    <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Shift Name</label>
      
      <select class="form-control" name="drpshiftid" id="drpshiftid">
      <c:forEach items="${lstOfShifts}" var="shift">
			    <option value="${shift.shift_id}">${shift.shift_name} (${shift.from_time} ${shift.to_time})</option>    
	   </c:forEach></select>
            
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Notes</label>
      <input type="text" class="form-control" onkeyup=calculateTotal() id="notes" value="${collectionData}"  placeholder="eg. 500" name="notes">
      <input type="hidden" name="hdnSupervisorId" value="${SupervisorDetails.supervisor_id}" id="hdnSupervisorId">
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Coins</label>
      <input type="tel" class="form-control" onkeyup=calculateTotal()  onkeypress='digitsOnly(event)' id="coins" value="0"  placeholder="eg. 500" name="coins">
    </div>
  </div>  
  
    <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Total Amount</label>
      <input type="tel" class="form-control" readonly id="total" value="${param.total}" onkeypress='digitsOnly(event)'  placeholder="eg. 500" name="total">
    </div>
  </div>  
  
  

		
		<button class="btn btn-success" type="button" onclick='saveSubmitCash()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showSubmitCashtoVault"'>Cancel</button>
		
		
		
		
		
		
		
</div>
</form>

<script type="javascript">

function calculateTotal(){
	
	var notes=document.getElementById('notes').value
	var coins=document.getElementById('coins').value

	
	total.value = Number(notes) + Number(coins)
	
}

	
txtcollectiondate.value='${todaysDate}';
$( "#txtcollectiondate" ).datepicker({ dateFormat: 'dd/mm/yy' });
document.getElementById("divTitle").innerHTML="Submit Cash To Vault";
document.title +=" Submit Cash To Vault ";
drpshiftid.value='${suggestedShiftId}';
calculateTotal();
</script>



