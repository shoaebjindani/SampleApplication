<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="javascript">
function deleteTermsAndCondition(termsId)
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
 	xhttp.open("GET","?a=deleteTermsAndCondition&termsId="+termsId, true);    
  	xhttp.send();
}

</script>


<c:set var="message" value='${requestScope["outputObject"].get("ListOfTermsAndCondition")}' />

<br>
<div class="card">
          
          <div class="card-header">           
               <div class="card-tools">
                 <div class="input-group input-group-sm" style="width: 200px;">                    
                 	<input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddTermsAndCondition'" value="Add New Terms And Condition" class="form-control float-right" >                      
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
                   	<th><b>Terms And Condition Id</b></th><th><b>Terms And Condition Content</b></th><th><b>Order</b></th><th></th><th></th>
                   </tr>
                 </thead>
                 <tbody>
				 <c:forEach items="${message}" var="item">
					<tr >
						<td>${item.termsId}</td><td>${item.termscondition}</td><td>${item.order}</td>
						<td><a href="?a=showAddTermsAndCondition&termsId=${item.termsId}">Edit</a></td><td><button class="btn btn-danger" onclick="deleteTermsAndCondition('${item.termsId}')">Delete</button></td>
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
  
  document.getElementById("divTitle").innerHTML="Terms And Condition";
  document.title +=" Terms And Condition ";
  function searchprod(elementInput,evnt)
	{
		if(evnt.which==13)
			{
				// do some search stuff
				window.location="?a=showTermsAndCondition&colNames="+document.getElementById("colNames").value+"&searchInput="+elementInput.value;
			}
			
	}

  
</script>