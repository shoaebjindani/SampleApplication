<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
function deleteMaintenence(collectionId)
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
	  xhttp.open("GET","?a=deleteTransferId&transferId="+collectionId, true);    
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
function reloadFilters()
  {
	window.location="?a=showTransferFeesRegister&blockId="+drpblockname.value+"&flatName="+drpflatname.value;
  }
  


</script>	



<c:set var="message" value='${requestScope["outputObject"].get("ListOfCollectTransferFees")}' />
<c:set var="transferdate" value='${requestScope["outputObject"].get("transferdate")}' />
<c:set var="paymentdate" value='${requestScope["outputObject"].get("paymentdate")}' />

<c:set var="listOfBlocks" value='${requestScope["outputObject"].get("listOfBlocks")}' />
<c:set var="listOfFlats" value='${requestScope["outputObject"].get("listOfFlats")}' />



<br>
<div class="card">

           <div class="card-header">    
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 200px;">                    
                    <input type="button"  class="btn btn-block btn-primary btn-sm" onclick="window.location='?a=showAddCollectTransferFees'" value="Collect Transfer Fees" class="form-control float-right" >                      
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
  <div class="input-group input-group-sm">
				  <div class="input-group input-group-sm" style="width: 230px;">
  			
  					<select id="drpblockname" name="drpblockname" class="form-control float-right" onchange='reloadFilters()' style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>
  						
  						<c:forEach items="${listOfBlocks}" var="cat">
							<option value='${cat.blockId}'> ${cat.blockName}</option>
						</c:forEach>  							
  					</select>


					<select id="drpflatname" name="drpflatname" class="form-control float-right" onchange='reloadFilters()' style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>
  						
  						<c:forEach items="${listOfFlats}" var="cat">
							<option value='${cat.flat_name}'> ${cat.flat_name}</option>
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
                         <th><b>Transfer Id</b></th>
					   <th><b>Receipt No</b></th>
                     <th><b>Flat Name</b></th>
                     <th><b>Transfer Date</b></th>
					<th><b>Payment Date</b></th>
					  <th><b>From Owner</b></th>
					 <th><b>To Owner</b></th>
					   <th><b>Updated By </b></th>
					   	 <th><b>Amount </b></th>

                     <th></th>
					 <th></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
					<td>${item.transfer_id}</td>
					<td>${item.receipt_no}</td>
						<td>${item.block_name} ${item.flat_name}</td>
						<td>${item.TransferDate}</td>						
						<td>${item.PaymentDate}</td>
						<td>${item.FromOwner} </td>
						<td>${item.ToOwner} </td>

						<td>${item.updatedBy}</td>
						<td>${item.amount}</td>

						<td><button class="btn btn-primary" onclick="openReceipt('${item.receipt_no}')" >Generate PDF</button></td>
						<td><button class="btn btn-danger" onclick="deleteMaintenence('${item.transfer_id}')">Delete</button></td>
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
  
  document.getElementById("divTitle").innerHTML="Transfer Fees Register";
  
  window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		 window.location='?a=showAddCollectTransferFees';
	} 
	});


  function openReceipt(receiptno)
		{
			
			var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() 
			  {
			    if (xhttp.readyState == 4 && xhttp.status == 200) 
			    { 		      
			    	//alert(xhttp.responseText);
			    	window.open("BufferedImagesFolder/"+xhttp.responseText);		  
				}
			  };
			  xhttp.open("GET","?a=generateTransferReceipt&receiptNo="+receiptno, false);    
			  xhttp.send();
			
			
			
			//window.open("BufferedImagesFolder/"+qtName);			
		}
	function getFlatMasterByBlockId()
	{
		$.get("?a=getFlatMasterByBlockId&block_id="+drpblockname.value, function(data, status){
      		alert("Data: " + data + "\nStatus: " + status);
    	});
	}
  drpblockname.value="${param.blockId}";
  drpflatname.value="${param.flatName}";  
</script>