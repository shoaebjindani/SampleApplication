

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ListStock" value='${requestScope["outputObject"].get("ListStock")}' />
<c:set var="ListOfCategories" value='${requestScope["outputObject"].get("ListOfCategories")}' />
<c:set var="listOfStore" value='${requestScope["outputObject"].get("listOfStore")}' />

<c:set var="totalDetails" value='${requestScope["outputObject"].get("totalDetails")}' />




<script type="javascript">
function deleteStock(stockId)
{
	
	var answer = window.confirm("Are you sure you want to delete ?");
	if (!answer) 
	{
		return;    
	}
	
	  document.getElementById("closebutton").style.display='none';
	   document.getElementById("loader").style.display='block';
	$('#myModal').modal({backdrop: 'static', keyboard: false});;

	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	      document.getElementById("responseText").innerHTML=xhttp.responseText;
		  document.getElementById("closebutton").style.display='block';
		  document.getElementById("loader").style.display='none';
		  $('#myModal').modal({backdrop: 'static', keyboard: false});;
	      
		  
		}
	  };
	  xhttp.open("GET","?a=deleteStock&stockid="+stockId, true);    
	  xhttp.send();
}

function configureLowStock(stockId)
{
		window.location='?a=showConfigureLowStock&stockId='+stockId;
}

</script>	







<br>
<div class="card">









           <div class="card-header">    
                
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" >                    
                   	<input type="button"  class="btn btn-primary btn-sm" style="margin-right:11px;" onclick="window.location='?a=showInventoryCounting'" value="Inventory Couting" class="form-control float-right" >                                         
                  </div>
                </div>
                
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" >                    
                    <input type="button"  class="btn btn-primary btn-sm" style="margin-right:11px;" onclick="window.location='?a=showStockTransfer'" value="Stock Transfer" class="form-control float-right" >                                         
                  </div>
                </div>
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" >                    
                    <input type="button"  class="btn btn-primary btn-sm" style="margin-right:11px;" onclick="window.location='?a=showAddStock&type=Add'" value="Add New Stock" class="form-control float-right" >                                         
                  </div>
                </div>
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" >                    
                    <input type="button"  class="btn btn-primary btn-sm" style="margin-right:11px;" onclick="window.location='?a=showAddStock&type=Remove'" value="Damaged Stock" class="form-control float-right" >                                         
                  </div>
                </div>
                
                <div class="card-tools">
                  <div class="input-group input-group-sm" align="center"  style="width: 200px;display:inherit">
                    <div class="icon-bar" style="font-size:22px;color:firebrick">
  <a title="Download Excel" onclick="downloadExcel()"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a> 
  <a title="Download PDF" onclick="downloadPDF()"><i class="fa fa-file-pdf-o"></i></a>
  <a title="Download Text"  onclick="downloadText()"><i class="fa fa-file-text-o"></i></a>  
</div>           
                  </div>
                </div>
                
                 <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 200px;">
  					<select id="drpcategoryId" name="drpcategoryId" class="form-control float-right" onchange='ReloadFilters()' style="margin-right: 15px;" >
  						
  						<option value='-1'>--Select--</option>
  						
  						<c:forEach items="${ListOfCategories}" var="item">
							<option value='${item.category_id}'> ${item.category_name}</option>
						</c:forEach>  							
  					</select>
                  </div>
              </div>
              
			              <c:if test="${adminFlag eq true}">
							 <div class="card-tools">
				                  <div class="input-group input-group-sm" style="width: 200px;">
				  					<select id="drpstoreId" name="drpstoreId" class="form-control float-right" onchange='ReloadFilters()' style="margin-right: 15px;" >
				  						
				  						<option value='-1'>--Select--</option>  						
				  						<c:forEach items="${listOfStore}" var="store">
											<option value='${store.storeId}'> ${store.storeName}</option>
										</c:forEach>  							
				  					</select>
				                  </div>
				              </div>
            			  </c:if>
              
              
                
                
                
                
                

                
              </div>
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th>Category Name</th>
                     <th>Item Name</th>
                     <th>Available Quantity</th>
                     <th>Purchase Price</th>                      
                 
                      
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${ListStock}" var="item">		
				
						<td>${item.category_name}</td>						
						<td>${item.item_name}</td>
						<td>${item.availableQty}</td>
						<td>${item.purchasePrice}</td>
						
					
						
							 																				 
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            
            
            
       <%--      <div class="d-flex justify-content-end">
            	<div class="p-2">Total Evaluation At Average Cost : <b>${totalDetails.TotalEvaluationAtAverageCost}</b></div>
            </div>
            
            <div class="d-flex justify-content-end">
            	<div class="p-2">Total Evaluation At Price : <b>${totalDetails.TotalEvaluationAtPrice}</b></div>
            </div> --%>

            
            
            
            



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
  
  document.getElementById("divTitle").innerHTML="Stock Status";
  document.title +=" Stock Status ";
  
  function ReloadFilters()
  {
	  window.location="?a=showStockStatus&categoryId="+drpcategoryId.value+"&storeId="+drpstoreId.value;
	  
  }
  
  drpcategoryId.value="${param.categoryId}";
  drpstoreId.value="${param.storeId}";
  
</script>