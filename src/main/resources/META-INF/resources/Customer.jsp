<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="javascript">
function deleteCustomer(customerId)
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
	  xhttp.open("GET","?a=deleteCustomer&customerid="+customerId, true);    
	  xhttp.send();
}

</script>	



<c:set var="message" value='${requestScope["outputObject"].get("ListOfCustomers")}' />
<c:set var="groupList" value='${requestScope["outputObject"].get("groupList")}' />




<br>
<div class="card">









           <div class="card-header">    
                
                
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 200px;">                    
                    <input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddCustomer'" value="Add New Customer" class="form-control float-right" >                      
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
                      <button type="button" onclick='reloadFilter()' class="btn btn-default"><i class="fas fa-search"></i></button>
                    </div>
                  </div>
                </div>
                
                
                  <div class="card-tools">
                  <div class="input-group input-group-sm">
  					<select id="drpgroupId" name="drpgroupId" class="form-control float-right" onchange='reloadFilter()' style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>
  						
  						<c:forEach items="${groupList}" var="item">
							<option value='${item.group_id}'> ${item.group_name}</option>
						</c:forEach>  							
  					</select>
                  </div> 
                  </div>
                  
                  <div class="card-tools">
                  <div class="input-group input-group-sm">
  					<select id="drpcustomertype" name="drpcustomertype" class="form-control float-right" onchange='reloadFilter()' style="margin-right: 15px;" >
  						
  						<option value="-1">----select----</option>
  						<option value="LoyalCustomer1">Loyal Customer 1</option>
  				<option value="LoyalCustomer2">Loyal Customer 2</option>
  				<option value="LoyalCustomer3">Loyal Customer 3</option>
  				<option value="Franchise">Franchise</option>
  				<option value="WholeSeller">WholeSeller</option>
  				<option value="Distributor">Distributor</option>
  				<option value="Business2Business">Business2Business</option>  							
  					</select>
                  </div> 
                  </div>  
                  
                  
                  
                  
                  
                  
                  
              
              
              
                
            
                
              </div>
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Customer Id</b></th><th><b>Customer Name</b></th><th><b>Mobile Number</b></th><th><b>City</b></th><th><b>Address</b></th><th><b>Customer Type</b></th><th></th><th></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
						<td>${item.customerId}</td><td>${item.customerName}</td><td>${item.mobileNumber}</td><td>${item.customerCity}</td><td>${item.customerAddress}</td><td>${item.customerType}</td>
						<td><a href="?a=showAddCustomer&customerId=${item.customerId}">Edit</a></td><td><button class="btn btn-danger" onclick="deleteCustomer('${item.customerId}')">Delete</button></td>
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
  
  document.getElementById("divTitle").innerHTML="Customer Master";
  document.title +=" Customer Master ";
  
  function searchprod(evnt)
	{
		if(evnt.which==13)
			{
				window.location="?a=showCustomerMaster&searchInput="+txtsearch.value+"&groupId="+drpgroupId.value+"&customerType="+drpcustomertype.value;
			}
			
	}
  
  function reloadFilter()
	{
	  window.location="?a=showCustomerMaster&searchInput="+txtsearch.value+"&groupId="+drpgroupId.value+"&customerType="+drpcustomertype.value;	
	}
  
  
  drpgroupId.value='${param.groupId}';
  drpcustomertype.value='${param.customerType}';
  txtsearch.value='${param.searchInput}';
  

  
</script>