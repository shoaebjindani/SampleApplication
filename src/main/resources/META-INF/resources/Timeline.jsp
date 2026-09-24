<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="javascript">

</script>

<c:set var="message" value='${requestScope["outputObject"].get("ListOfEmployee")}' />

<br>
<div class="card">

           <div class="card-header">
           </div>		
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Timeline Id</b></th><th><b>New Category</b></th><th><b> New Item</b></th><th><b>New Stock</b><th><b>Sales  Invoice</b>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${message}" var="item">
					<tr >
						<td>${item.user_id}</td><td>${item.testVariable}</td><td>${item.address_line_1}</td><td>${item.storeEmail}</td><td>${item.storeEmail}</td>
						
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
  
  document.getElementById("divTitle").innerHTML="Timeline";
  document.title +=" Timeline ";
  
  function searchprod(elementInput,evnt)
	{
		if(evnt.which==13)
			{
				// do some search stuff
				window.location="?a=showStoreMaster&colNames="+document.getElementById("colNames").value+"&searchInput="+elementInput.value;
			}
			
	}

  
</script>