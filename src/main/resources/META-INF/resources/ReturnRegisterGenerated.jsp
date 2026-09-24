<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="message" value='${requestScope["outputObject"].get("ReturnRegister")}' />



<br>
<div class="card">

           <div class="card-header">    
                
                <div class="row">
              
              
              
              
              
              
              
               
              
              
				<div class="col-sm-3" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
  						<input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();ReloadFilters();"  name="txtfromdate" readonly class="form-control date_field" placeholder="From Date"/>
                  </div>
				</div>
				
				<div class="col-sm-3" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
					<input type="text" id="txttodate"  onchange="checkforvalidfromtodate();ReloadFilters();"    name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/>
  						
                    </div>
				</div>
				
				<div class="col-sm-3" align="center">
					<div class="input-group input-group-sm" style="width: 200px;">
	  					<select id="drpstoreId" name="drpstoreId"  class="form-control float-right" onchange='ReloadFilters()' style="margin-right: 15px;" >
	  						
	  						<option value='-1'>--Select--</option>  						
	  						<c:forEach items="${listStoreData}" var="store">
								<option value='${store.storeId}'> ${store.storeName}</option>
							</c:forEach>  							
	  					</select>
                  	</div>
				</div>
				
				
				<div class="col-sm-3" align="center">
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
				
			  </div>
              
                
               
                               
                               
              </div>
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Return Id</b></th><th><b>Invoice No</b></th> <th><b>Returned Qty</b></th> <th><b>Sold At</b></th><th><b>Updated By</b></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
						<td>${item.return_id}</td>						
						<td><a href="?a=showGenerateInvoice&invoice_id=${item.invoice_id}">${item.invoice_no}</a></td>
							<td>${item.qty_to_return}</td><td>${item.custom_rate}</td> <td>${item.username}</td>
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
  
  document.getElementById("divTitle").innerHTML="Return Register";
  document.title +=" Return Register ";
  
</script>