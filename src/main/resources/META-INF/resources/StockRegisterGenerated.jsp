<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="message" value='${requestScope["outputObject"].get("stockRegisterList")}' />



<br>
<div class="card">

           <div class="card-header">    
                
                
                
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
                     	<th><b>Store Name</b></th><th><b>Item name</b></th> <th><b>Qty</b></th><th><b>Invoice No</b></th><th><b>Updated date</b></th><th><b>Type</b></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
						<td>${item.store_name}</td><td>${item.item_name}</td><td>${item.qty}</td><td>${item.invoice_no}</td><td>${item.FormattedUpdatedDate}</td><td>${item.type}</td>
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
      "order": [[ 4, "desc" ]]
    });
  });
  
  document.getElementById("divTitle").innerHTML="Stock Register Report";
  document.title +=" Stock Register Report ";
  
</script>