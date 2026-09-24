  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="vehicleDetails" value='${requestScope["outputObject"].get("vehicleDetails")}' />
<c:set var="lstVehiclesiblingDetails" value='${requestScope["outputObject"].get("lstVehiclesiblingDetails")}' />

<script>
document.getElementById("divTitle").innerHTML="Vehicle Information";
</script>





</head>



<br>

<div class="container" style="padding:20px;background-color:white">

<form id="frm" action="?a=addStore" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="row">

<div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Vehicle Name</label>     
      <input class="form-control" readonly type="text" value="${vehicleDetails.vehicle_name} (${vehicleDetails.vehicle_number})">	   
	  <input type="hidden" name="hdnStockId" value="${stockDetails.stock_id}" id="hdnStockId">
    </div>
  </div>
   
</div>


<div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Flat Details</label>     
      <input class="form-control" readonly type="text" value="${vehicleDetails.block_name}  ${vehicleDetails.flat_name} ${vehicleDetails.person_name}  ">	   
	  <input type="hidden" name="hdnStockId" value="${stockDetails.stock_id}" id="hdnStockId">
    </div>
  </div>
   



<div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Mobile Number</label>     
      <input class="form-control" readonly type="text" value="${vehicleDetails.person_mobile_no}  ">	   
	  <input type="hidden" name="hdnStockId" value="${stockDetails.stock_id}" id="hdnStockId">
    </div>
  </div>
   






</form>


<br><br><br>

<div class="card-body table-responsive p-0" style="height: 550px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
				  <tr align="center">
				  <th colspan="10"> Other Vehicles From this Flat</th>
				  </tr>

                    <tr>
                     	<th><b>Vehicle Name</b></th><th><b>Vehicle number</b></th>
                     	 <th><b>type</b></th>
                     	
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${lstVehiclesiblingDetails}" var="item">
					<tr>
						<td>${item.vehicle_name}</td><td>${item.vehicle_number}</td>
						<td>${item.type}</td>
						  <td><b><input type="button" class="btn btn-primary" value="Distribute Sticker" onclick='showDistributeModal("${item.vehicle_id}","${item.vehicle_name}","${item.vehicle_number}")'></b></td>

					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
</div>
</div>
<br>
<br>


<script >


	function showDistributeModal(vehicleid,vehicleName,vehicleNumber)
{
	document.getElementById("closebutton").style.display='none';
	$('#myModal').modal({backdrop: 'static', keyboard: false});;

	var stringToPopulate='<table class="table table-bordered tablecss" border="3">';
		stringToPopulate+='<tr style="background-color:lightgrey;font-weight:800" align="center"><td colspan="2">Distribut Sticker</th></tr>';
		stringToPopulate+='<tr><input type="hidden" id="hdnvehicleid" value="'+vehicleid+'"> <th>Vehicle Name </th> <td colspan="2"><input id="txtgroupNamepopup" readonly value="'+vehicleName+'"  class="form-control input-sm" id="inputsm" type="text"></th></tr>';
		stringToPopulate+='<tr><th>Vehicle Number</th> <td colspan="2"><input id="txtgroupUniqueCode" readonly  value="'+vehicleNumber+'" class="form-control input-sm" id="inputsm" type="text"></th>';
		stringToPopulate+='<tr><th>Collected By</th> <td colspan="2"><input id="txtcollectedby" placeholder="Collected By"  class="form-control input-sm" id="inputsm" type="text"></th></tr>';
		stringToPopulate+="<tr align=\"center\"><td colspan=\"2\"><button class=\"btn btn-primary\" onclick=\"addDistribution()\">Save</button> <button class=\"btn btn-danger\" onclick=\"window.location.reload()\">Cancel</button> </th></tr>";
		stringToPopulate+='</table>';
		
		document.getElementById("responseText").innerHTML=stringToPopulate;
	    
	 
}

function addDistribution()
	{			
		
		var vehicleId=document.getElementById('hdnvehicleid').value;
		var collected_by=document.getElementById('txtcollectedby').value;
		
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		    	
		    	
		    	document.getElementById("responseText").innerHTML=xhttp.responseText;
			     document.getElementById("closebutton").style.display='block';
				   document.getElementById("loader").style.display='none';			  
			}
		  };
		  xhttp.open("GET","?a=addDistribution&vehicleId="+vehicleId+"&collected_by="+collected_by, true);    
		  xhttp.send();
		
	}

	
	
	function changeStore()
	{
		var answer = window.confirm("Are you sure you want to Switch Store ?");
		if (!answer) 
		{
			return;    
		}
		
		  document.getElementById("closebutton").style.display='none';
		   document.getElementById("loader").style.display='block';
		

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
		  xhttp.open("GET","?a=switchStore&storeId="+drpstoreId.value, true);    
		  xhttp.send();
		
	}
	
	$( "#txtdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
  $(function () {
    
    $('#example1').DataTable({
      "paging": true,      
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": false,
      "pageLength": 50,
      "order": [[ 0, "desc" ]]
    });
  });
</script>
