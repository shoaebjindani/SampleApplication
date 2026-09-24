<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<c:set var="message" value='${requestScope["outputObject"].get("ListOfItems")}' />
<c:set var="ListOfCategories" value='${requestScope["outputObject"].get("ListOfCategories")}' />

<c:set var="itemHistory" value='${requestScope["outputObject"].get("itemHistory")}' />





<br>

<div class="card">

<br>




<div class="row">
<div class="col-sm-3" align="center">
	<div class="input-group input-group-sm" style="width: 200px;">
  
                  </div>
</div>

<div class="col-sm-3" align="center">
	<div class="input-group input-group-sm" style="width: 200px;">                    
                  </div>
</div>

<div class="col-sm-3" align="center">
	<div class="icon-bar" style="font-size:22px;color:firebrick">
	  
	</div>
</div>



</div>


                    
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Item Name</b></th>
                     <th><b>Price</b></th>
                     <th><b>Category Name</b></th>
                     <th><b>Updated By</b></th>
                     <th><b>Updated Date</b></th>
                     
                     
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${itemHistory}" var="item">
					<tr >
					
						<td>${item.item_name}</td>
						<td>${item.price}</td>
						<td>${item.parent_category_id}</td>
						<td>${item.updated_by}</td>					
						<td>${item.updated_date}</td>
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
  
  document.getElementById("divTitle").innerHTML="Item Master History";
  document.title +=" Item Master History ";
  
 
</script>