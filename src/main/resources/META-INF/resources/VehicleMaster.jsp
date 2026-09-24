<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script>


 function deleteItem(vehicleId) {
            var answer = window.confirm("Are you sure you want to delete ?");
            if (!answer) {
                return;
            }
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    toastr["success"](xhttp.responseText);
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
                        "timeOut": "500",
                        "extendedTimeOut": "500",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }
                    window.location.reload();
                }
            };
            xhttp.open("GET", "?a=deleteVehicle&vehicleId=" + vehicleId, true);
            xhttp.send();
        }
function reloadFilters()
  {
	  window.location="?a=showVehicleMaster&blockId="+drpblockname.value+"&vehicleType="+drptype.value;	 
	  
  }
  
  </script>
  
    
  



    <c:set var="vehicleData" value='${requestScope["outputObject"].get("vehicleDetails")}' />
    <c:set var="listOfBlocks" value='${requestScope["outputObject"].get("listOfBlocks")}' />




    <br>

    <div class="card">


        <div class="card-header">


            <div class="card-tools">
                <div class="input-group input-group-sm" style="width: 200px;">
                    <input type="button" class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddVehicle'" value="Add Vehicle">
                </div>
            </div>

            <div class="card-tools">
                <div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
                    <div class="icon-bar" style="font-size:22px;color:firebrick">
                        <a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a>
                        <a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>
                        <a title="Download Text" onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>
                    </div>
                </div>
            </div>

    <div class="card-tools">
  <div class="input-group input-group-sm">
				  <div class="input-group input-group-sm" style="width: 200px;">
  			
  					<select id="drptype" name="drptype" class="form-control float-right" onchange='reloadFilters()' style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>
                        <option value="Two Wheeler">Two Wheeler</option>
		                <option value="Four Wheeler">Four Wheeler</option>
                        <option value="Three Wheeler">Three Wheeler</option>
		
  						
  													
  					</select>
				</div>
			</div>
		</div> 
                
 
 <div class="card-tools">
  <div class="input-group input-group-sm">
				  <div class="input-group input-group-sm" style="width: 200px;">
  			
  					<select id="drpblockname" name="drpblockname" class="form-control float-right" onchange='reloadFilters()' style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>
  						
  						<c:forEach items="${listOfBlocks}" var="cat">
							<option value='${cat.blockId}'> ${cat.blockName}</option>
						</c:forEach>  							
  					</select>
				</div>
			</div>
		</div> 

    
                     
   </div>



        <!-- /.card-header -->
        <div class="card-body table-responsive p-0" style="height: 800px;">
            <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                <thead>
                    <tr>
                        <th><b>Flat Name</b></th>
                         <th><b>Owner Name</b></th>
                        <th><b>Vehicle Name</b></th>
                        <th><b>Vehicle Number</b></th>
                        <th><b>Type</b></th>
                        <th><b>Person Mobile No</b></th>
                        <th></th>
                                              
                </thead>
                <tbody>
                    <c:forEach items="${vehicleData}" var="item">
                        <tr>

                           <td>${item.block_name} ${item.flat_name}</td>
                           <td>${item.person_name}</td>	
                            <td>${item.vehicle_name}</td>
                            <td>${item.vehicle_number}</td>
                             <td>${item.type}</td>
                             <td>${item.person_mobile_no}</td>
                             

                            <td><button class="btn btn-danger" onclick="deleteItem('${item.vehicle_id}')">Delete</button></td>
                        </tr>
                    </c:forEach>


                </tbody>
            </table>
        </div>
        <!-- /.card-body -->
    </div>
 



<script>

 
  $(function () {
    
    $('#example1').DataTable({
      "paging": true,      
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true,
      "pageLength": 100
    });
  });
  
  window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		 window.location='?a=showAddVehicle';
	} 
	});

  document.getElementById("divTitle").innerHTML="Vehicle Master";
  drpblockname.value="${param.blockId}";
drptype.value="${param.vehicleType}";

</script>