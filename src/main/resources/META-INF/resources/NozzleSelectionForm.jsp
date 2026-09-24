
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>





<c:set var="fuelDetails"
	value='${requestScope["outputObject"].get("fuelDetails")}' />
<c:set var="dateTimeRightNow"
	value='${requestScope["outputObject"].get("dateTimeRightNow")}' />
<c:set var="lstOfShifts"
	value='${requestScope["outputObject"].get("lstOfShifts")}' />
<c:set var="itemPrice"
	value='${requestScope["outputObject"].get("itemPrice")}' />
<c:set var="userList"
	value='${requestScope["outputObject"].get("userList")}' />
<c:set var="suggestedShiftId"
	value='${requestScope["outputObject"].get("suggestedShiftId")}' />
<c:set var="todaysDate"
	value='${requestScope["outputObject"].get("todaysDate")}' />

<c:set var="nzDetails"
	value='${requestScope["outputObject"].get("nzDetails")}' />










</head>


<script type="javascript">
	function addNozzleCheckIn() {

		document.getElementById("frm").submit();
	}

	function deleteAttachment(id) {

		document.getElementById("closebutton").style.display = 'none';
		document.getElementById("loader").style.display = 'block';
		$("#myModal").modal();

		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				document.getElementById("responseText").innerHTML = xhttp.responseText;
				document.getElementById("closebutton").style.display = 'block';
				document.getElementById("loader").style.display = 'none';
				$("#myModal").modal();

			}
		};
		xhttp.open("GET", "?a=deleteAttachment&attachmentId=" + id, true);
		xhttp.send();

	}
</script>



<br>

<div class="container" style="padding: 20px; background-color: white">

	<form id="frm" action="?a=checkInNozzle" method="post"
		enctype="multipart/form-data" accept-charset="UTF-8">
		<input type="hidden" name="app_id" value="${userdetails.app_id}">
		<input type="hidden" name="user_id" value="${userdetails.user_id}">
		<input type="hidden" name="callerUrl" id="callerUrl" value="">

		<div class="row">
			<div class="col-3">
				<div class="form-group">
					<label for="email">Nozzle Name</label> <input type="text"
						class="form-control" readonly
						value="${nzDetails.nozzle_name} ${nzDetails.item_name}"> <input
						type="hidden" name="nozzle_id" value="${nzDetails.nozzle_id}"
						id="nozzle_id">

				</div>
			</div>

			<div class="col-3">
				<div class="form-group">
					<label for="email">Previous Closing Reading</label> <input
						type="text" class="form-control" id="txtclosingreading" readonly
						value="${nzDetails.closing_reading}" name="txtclosingreading">
				</div>


			</div>
			
			<div class="col-3">
				<div class="form-group">
					<label for="email">Previous Totalizer Reading</label> <input
						type="text" class="form-control" id="txttotalizerclosingreading"  readonly
						value="${nzDetails.totalizer_closing_reading}" name="txttotalizerclosingreading">
				</div>


			</div>
			
			
			<div class="col-3">
				<div class="form-group">
					<label for="email">Opening Reading</label> <input type="text"
						class="form-control" id="opening_reading"
						value="${nzDetails.closing_reading}" name="opening_reading">

				</div>


			</div>
			
			

<div class="col-3">
				<div class="form-group">
					<label for="email">Totalizer Opening Amount</label> <input type="text"
						class="form-control" id="totalizer_opening_reading" 
						value="${nzDetails.totalizer_closing_reading}" name="totalizer_opening_reading">

				</div>


			</div>

			

			<div class="col-3">
				<div class="form-group">
					<label for="accountingDate">Date</label> <input type="text"
						readonly class="form-control" id="accountingDate" placeholder=""
						name="accountingDate" value="${todaysDate}">

				</div>
			</div>



			

			<div class="col-3">
				<div class="form-group">
					<label for="email">Fuel Price</label> <input type="text"
						class="form-control" id="itemPrice" readonly value="${itemPrice}"
						name="itemPrice">
				</div>
			</div>


			
			
			


<div class="col-3">
				<div class="form-group">
					<label for="email">Choose Shift</label> <select
						class="form-control" name="drpshift" id="drpshift">
						<c:forEach items="${lstOfShifts}" var="shift">
							<option value="${shift.shift_id}">${shift.shift_name}
								(${shift.from_time}-${shift.to_time})</option>
						</c:forEach>
					</select>


				</div>


			</div>


			<div class="col-3">
				<div class="form-group">
					<label for="email">Attendant Name</label> <select
						class="form-control" name="drpattendantid" id="drpattendantid">
						<c:forEach items="${userList}" var="emp">
							<option value="${emp.user_id}">${emp.name}</option>
						</c:forEach>
					</select>

				</div>
			</div>


			<div class="col-12"
				align="center>
  	<div class="form-group">
      <input align="center" type="button" type="button" class="btn btn-success" onclick='addNozzleCheckIn()' value="Check In">            
    </div>
  </div>
  
  
  

		
				
		
</div>
</form>




<script type="javascript">


$( "#accountingDate" ).datepicker({ dateFormat: 'dd/mm/yy' });


if(document.getElementById('opening_reading').value!='')
	{
		document.getElementById('opening_reading').readOnly=true;
	}
	
drpshift.value='${suggestedShiftId}';
document.getElementById("divTitle").innerHTML="Nozzle Check In";

</script>