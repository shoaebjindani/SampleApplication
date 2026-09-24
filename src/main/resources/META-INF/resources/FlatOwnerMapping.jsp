<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="message" value='${requestScope["outputObject"].get("ListOfFlatOwnerMapping")}' />
<c:set var="purchaseDate" value='${requestScope["outputObject"].get("purchaseDate")}' />




<script>
function deleteFlatOwner(flatownerId)
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
	  xhttp.open("GET","?a=deleteFlatOwner&flatownerId=" + flatownerId, true);    
	  xhttp.send();
}










</script>	










<br>
<div class="card">









           <div class="card-header">    
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 200px;">                    
                    <input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddFlatOwner'" value="Add Flat Owner" class="form-control float-right" >                      
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
                      <th><b>Flat Owner ID</b></th>
                     <th><b>Flat Name</b></th>
                     <th><b>Person Name</b></th>
					  <th><b>Purchase Date</b></th>
                     
                     <th></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
					<td>${item.flat_owner_id}</td>
					<td>${item.block_name} ${item.flat_name}</td>
					<td>${item.person_name}</td>					
					<td>${item.purchaseDateFormatted}</td>

					
						<td><button class="btn btn-danger" onclick="deleteFlatOwner('${item.flat_owner_id}')">Delete</button></td>
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
  
  document.getElementById("divTitle").innerHTML="Flat Owner Mapping";
  

  window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		 window.location='?a=showAddFlatOwner';
	} 
	});
</script>