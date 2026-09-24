<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
function deleteGuestVehicle(guestvehicleId)
{
	
	var answer = window.confirm("Are you sure you want to delete ?");
	if (!answer) 
	{
		return;    
	}
	
	  

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
	  xhttp.open("GET","?a=deleteGuestVehicle&guestvehicleId=" + guestvehicleId,true);    
	  xhttp.send();
}





function addCategorypopup()
{
	
	document.getElementById("closebutton").style.display='none';
	document.getElementById("loader").style.display='block';		 
	$('#myModal').modal({backdrop: 'static', keyboard: false});;		
	var stringToPopulate='<table class="table table-bordered tablecss" border="3">';
	stringToPopulate+='<tr style="background-color:cornsilk;" align="center"><td colspan="2">Add Category</td></tr>';
	stringToPopulate+='<tr><td>Category Name </td> <td colspan="2"><input id="txtcategorynamepopup" placeholder="Category Name"  class="form-control input-sm" id="inputsm" type="text"></td></tr>';
	stringToPopulate+="<tr align=\"center\"><td colspan=\"2\"><button class=\"btn btn-primary\" onclick=\"addCategory()\">Add</button></td></tr>";
	stringToPopulate+='</table>';
	
	document.getElementById("responseText").innerHTML=stringToPopulate;
     document.getElementById("closebutton").style.display='block';
	   document.getElementById("loader").style.display='none';
	$('#myModal').modal({backdrop: 'static', keyboard: false});;
	
	
}

function addCategory()
{			
	
	var catName=document.getElementById('txtcategorynamepopup').value;
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
	  xhttp.open("GET","?a=addCategory&categoryName="+catName, true);    
	  xhttp.send();
	
}



</script>	



<c:set var="message" value='${requestScope["outputObject"].get("ListOfGuestVehicleEntry")}' />
<c:set var="inTime" value='${requestScope["outputObject"].get("inTime")}' />




<br>
<div class="card">









           <div class="card-header">    
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 200px;">                    
                    <input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddGuestVehicle'" value="Add Guest Vehicle" class="form-control float-right" >                      
                  </div>
                </div>
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" align="center" style="width: 200px;display:inherit">
                    <div class="icon-bar" style="font-size:22px;color:firebrick">
  <a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
  <a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>
  <a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>  
</div>           
                  </div>
                </div>
                
                
                
                
                

                
              </div>
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 800px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                       <th><b>Guest Vehicle ID</b></th>
                     <th><b>Flat ID</b></th>
					  <th><b>Guest Name</b></th>
                     <th><b>Guest Mobile No</b></th>
					 <th><b>Guest Vehicle Name</b></th>
					 <th><b>Guest Vehicle No</b></th>
                     <th><b>In Time</b></th>
					 <th><b>Remark</b></th>
                     <th></th>
					
					   

                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
					   <td>${item.guest_vehicle_id}</td>
						<td>${item.flat_name}</td>
						<td>${item.guest_name}</td>
						<td>${item.guest_mobile_no}</td>	
						<td>${item.guest_vehicle_name}</td>	
						<td>${item.guest_vehicle_no}</td>	
						<td>${item.FormattedIntime}</td>							
						<td>${item.remark}</td>
						<td><button class="btn btn-danger" onclick="deleteGuestVehicle('${item.guest_vehicle_id}')">Delete</button></td>
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
  
  document.getElementById("divTitle").innerHTML="Guest Vehicle Entry";
  
</script>