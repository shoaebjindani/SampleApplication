<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="javascript">
function deleteVendor(customerId)
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
	  xhttp.open("GET","?a=deleteVendor&vendorid="+customerId, true);    
	  xhttp.send();
}

</script>	



<c:set var="ListOfVendors" value='${requestScope["outputObject"].get("ListOfVendors")}' />
<c:set var="groupList" value='${requestScope["outputObject"].get("groupList")}' />




<br>
<div class="card">









           <div class="card-header">    
                
                
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 200px;">                    
                    <input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddVendor'" value="Add New Vendor" class="form-control float-right" >                      
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
                
                
                
                
                
                

                <div class="card-tools">
                  <div class="input-group input-group-sm" >
                    <input type="text" name="table_search" class="form-control float-right" id="txtsearch" placeholder="Search" onkeypress="searchprod(event)">                    

                    <div class="input-group-append">
                      <button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>
                    </div>
                  </div>
                </div>
                
                
              
                  
            
                  
                  
                  
                  
                  
                  
              
              
              
                
            
                
              </div>
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Vendor Id</b></th><th><b>Vendor Name</b></th><th><b>Mobile Number</b></th><th><b>City</b></th><th><b>Address</b></th><th></th><th></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${ListOfVendors}" var="item">
					<tr >
						<td>${item.vendor_id}</td><td>${item.vendor_name}</td><td>${item.mobile_number}</td><td>${item.city}</td><td>${item.address}</td>
						<td><a href="?a=showAddVendor&vendorId=${item.vendor_id}">Edit</a></td><td><button class="btn btn-danger" onclick="deleteVendor('${item.vendor_id}')">Delete</button></td>
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
      "pageLength": 50,
      "order": [[ 1, "asc" ]]

    });
  });
  
  document.getElementById("divTitle").innerHTML="Vendor Master";
  document.title +=" Vendor Master ";
  
  function searchprod(evnt)
	{
		if(evnt.which==13)
			{
				window.location="?a=showVendorMaster&searchInput="+txtsearch.value+"&groupId="+drpgroupId.value+"&customerType="+drpcustomertype.value;
			}
			
	}
  
  function reloadFilter()
	{
	  window.location="?a=showVendorMaster&searchInput="+txtsearch.value+"&groupId="+drpgroupId.value+"&customerType="+drpcustomertype.value;	
	}
  
  
  drpgroupId.value='${param.groupId}';
  drpcustomertype.value='${param.customerType}';
  txtsearch.value='${param.searchInput}';
  

  
</script>