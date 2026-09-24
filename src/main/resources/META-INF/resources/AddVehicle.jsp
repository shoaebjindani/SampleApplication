<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





    <c:set var="listOfFlats" value='${requestScope["outputObject"].get("listOfFlats")}' />
    <c:set var="vehicleDetails" value='${requestScope["outputObject"].get("vehicleDetails")}' />










    </head>


    <script>
        function addVehicle() {
            if (txtflatname.value == "") {
                toastr["error"]("Please enter flat Name");
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "1000",
                    "hideDuration": "500",
                    "timeOut": "1000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                // btnsave.disabled = false;
                txtflatname.focus();
                return;
            }
            if (vehicleName.value == "") {
                toastr["error"]("Please enter Vehicle Name");
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "2000",
                    "hideDuration": "500",
                    "timeOut": "2000",
                    "extendedTimeOut": "2000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                btnsave.disabled = false;
                vehicleName.focus();
                return;
            }
            if (vehicleNumber.value == "") {
                toastr["error"]("Please enter Vehicle Number");
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "1000",
                    "hideDuration": "500",
                    "timeOut": "1000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                btnsave.disabled = false;
                vehicleNumber.focus();
                return;
            }
            document.getElementById("frm").submit();
        }
 document.getElementById("divTitle").innerHTML="Add Vehicle";
 window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		 addVehicle();
	} 
	});

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
function resetFlat()
{	
	txtflatname.disabled=false;
	txtflatname.value="";
	hdnselectedflat.value=0;	
}
    </script>



    <br>

    <div class="container" style="padding:20px;background-color:white">


        <form id="frm" action="?a=addVehicle" method="post" accept-charset="UTF-8">
            <input type="hidden" name="app_id" value="${userdetails.app_id}">
            <input type="hidden" name="user_id" value="${userdetails.user_id}">
            <input type="hidden" name="callerUrl" id="callerUrl" value="">

<datalist id="listOfFlat">
<c:forEach items="${listOfFlats}" var="flat">
<option id="${flat.flat_id}">${flat.block_name} ${flat.flat_name} (${flat.person_name}) ~ (${flat.type})</option>
 </c:forEach>
</datalist>


          

		<div class="row">
  <div class="col-sm-12">
	<div class="form-group">
		
	<label for="email">Flat Name </label>     
	<div class="input-group input-group-sm">
    
	<input type="textbox" name="txtflatname" id="txtflatname" class="form-control form-control-sm" list="listOfFlat" onchange="checkforMatchFlat()"/> 
	<input type="hidden" name="hdnselectedflat"  value="" id="hdnselectedflat">  <span class="input-group-append">
		<button type="button" class="btn btn-danger btn-flat" onclick="resetFlat()">Reset</button>
		</span>
	</div>
	</div>
		</div>
</div>
            <div class="col-sm-12">
                <div class="form-group">
                    <label for="email">Vehicle Name *</label>
                    <input type="text" class="form-control" id="vehicleName" value="${vehicleDetails.vehicle_name}" placeholder="Vehicle Name" name="vehicleName">
                    <input type="hidden" name="hdnVehicleId" value="${vehicleDetails.vehicle_id}" id="hdnVehicleId">
                </div>
            </div>

            <div class="col-sm-12">
                <div class="form-group">
                    <label for="email">Vehicle Number *</label>
                    <input type="text" class="form-control" id="vehicleNumber" value="${vehicleDetails.vehicle_number}" placeholder="Vehicle Number" name="vehicleNumber">
                </div>
            </div>
<div class="col-sm-12">
	<div class="form-group">
	<label for="email">Type</label>
	<select class="form-control" id="drptype" name="drptype" >
		<option value="Two Wheeler">Two Wheeler</option>
		<option value="Four Wheeler">Four Wheeler</option>
        <option value="Three Wheeler">Three Wheeler</option>
		
	</select>     
  </div>
</div>
            <div class="col-sm-12">
                <div class="form-group" align="center">

                    <button class="btn btn-success" type="button" id="btnsave" onclick='addVehicle()'>Save</button>

                    <button class="btn btn-danger" type="reset" onclick='window.location="?a=showVehicleMaster"'>Cancel</button>
                </div>
            </div>



            <script >


                if('${vehicleDetails.vehicle_id}'!='') { flatName.value='${vehicleDetails.flat_id}'; }


txtflatname.focus();
            </script>