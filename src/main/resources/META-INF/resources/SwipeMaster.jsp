<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="javascript">
function deleteSwipe(swipeMachineId)
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
	  xhttp.open("GET","?a=deleteSwipe&swipeId="+swipeMachineId, true);    
	  xhttp.send();
}





function addSwipe()
{			
	
	var catName=document.getElementById('txtSwipemachinenamepopup').value;
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
	  xhttp.open("GET","?a=addSwipe&SwipeMachineName="+catName, true);    
	  xhttp.send();
	
}



</script>	



<c:set var="ListOfSwipe" value='${requestScope["outputObject"].get("ListOfSwipe")}' />



<br>
<div class="card">









           <div class="card-header">    
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 200px;">                    
                    <input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddSwipe'" value="Add New Swipe" class="form-control float-right" >                      
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
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Swipe Machine Id</b></th><th><b>Swipe Machine Name</b></th>
                     <th><b>Swipe Machine Bank</b></th><th><b>Swipe Machine Account No</b></th>
                     <th><b>Swipe Machine Short Name</b></th>
                    
                     <th></th><th></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${ListOfSwipe}" var="item">
					<tr >
						<td>${item.swipe_machine_id}</td>
						<td>${item.swipe_machine_name}</td>
						<td>${item.swipe_machine_bank}</td>
						<td>${item.swipe_machine_account_no}</td>
					    <td>${item.swipe_machine_short_name}</td>
						
						
						<td><a href="?a=showAddSwipe&swipeMachineId=${item.swipe_machine_id}">Edit</a></td><td><button class="btn btn-danger" onclick="deleteSwipe('${item.swipe_machine_id}')">Delete</button></td>
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            
            
            
            



<script type="javascript">
  $(function () {
    
    $('#example1').DataTable({
      "paging": true,      
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true,
      "pageLength": 50
    });
  });
  
  document.getElementById("divTitle").innerHTML="Swipe Master";
  document.title +=" Swipe Master ";
  
</script>