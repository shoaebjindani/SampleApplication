<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script>


 
function reloadFilters()
  {
      	  window.location="?actionName=showMaintenenceMonthlyReport&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value+"&blockId="+drpblockname.value;  	  

	  
  }
  function checkforvalidfromtodate()
  {        	
  	var fromDate=document.getElementById("txtfromdate").value;
  	var toDate=document.getElementById("txttodate").value;
  	
  	var fromDateArr=fromDate.split("/");
  	var toDateArr=toDate.split("/");
  	
  	
  	var fromDateArrDDMMYYYY=fromDate.split("/");
  	var toDateArrDDMMYYYY=toDate.split("/");
  	
  	var fromDateAsDate=new Date(fromDateArrDDMMYYYY[2],fromDateArrDDMMYYYY[1]-1,fromDateArrDDMMYYYY[0]);
  	var toDateAsDate=new Date(toDateArrDDMMYYYY[2],toDateArrDDMMYYYY[1]-1,toDateArrDDMMYYYY[0]);
  	
  	if(fromDateAsDate>toDateAsDate)
  		{
  			alert("From Date should be less than or equal to To Date");
  			window.location.reload();        			
  		}
  }
  
 


function changePropertyType()
{
	if(drppropertytype.value=="Shop")
	{
		shopview.style.display="block";
		flatview.style.display="none";
	}
	else
	{
		shopview.style.display="none";
		flatview.style.display="block";
	}
}
  
  </script>
  
    
  



    <c:set var="listofmaintenence" value='${requestScope["outputObject"].get("listofmaintenence")}' />
    <c:set var="fromDate" value='${requestScope["outputObject"].get("fromDate")}' />
    <c:set var="toDate" value='${requestScope["outputObject"].get("toDate")}' />
    <c:set var="listOfBlocks" value='${requestScope["outputObject"].get("listOfBlocks")}' />

     <div class="card">
<br>


	<div class="row">
	            
		<div class="col-sm-1" align="center">
			<label for="txtfromdate">From Date</label>
		</div>
	
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<input type="text" id="txtfromdate" onchange="checkforvalidfromtodate();reloadFilters();"  name="txtfromdate" readonly class="form-control date_field" placeholder="From Date"/>
			</div>
		</div>
			
		<div class="col-sm-1" align="center">
			<label for="txttodate">To Date</label>
		</div>
	
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				<input type="text" id="txttodate"  onchange="checkforvalidfromtodate();reloadFilters();"    name="txttodate" readonly class="form-control date_field"  placeholder="To Date"/>
			</div>
		</div>

    		<div class="col-sm-1" align="center">
			<label for="txttodate">Block Name</label>
		</div>
	
		<div class="col-sm-2" align="center">
			<div class="input-group input-group-sm" style="width: 200px;">
				
        <select class="form-control" name="drpblockname" id="drpblockname" onchange="reloadFilters()">
        <option value="-1">--------------Select---------------</option>	
<c:forEach items="${listOfBlocks}" var="cat">
 <option value="${cat.blockId}">${cat.blockName}</option>	
 </c:forEach>
</select>     

			</div>
		</div>
		
		<div class="col-sm-2" align="center">
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
  	<br>


        <!-- /.card-header -->
        <div class="card-body table-responsive p-0" style="height: 800px;">
            <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                <thead>
                    <tr>
                        <th><b>Flat Name</b></th>
                        <th><b>Receipt No</b></th>
                        <th><b>Type</b></th>
                         <th><b>Collection Date</b></th>
                          <th><b>Maintenence From Date</b></th>
                           <th><b>Maintenence To Date</b></th>
                            <th><b>Amount</b></th>
                              <th><b>Payment Mode</b></th>
                                <th><b>Reference No</b></th>
                                  <th><b>Updated By</b></th>
                     
                      </tr> 
                </thead>
                <tbody>
                    <c:forEach items="${listofmaintenence}" var="item">
                        <tr>

                           <td>${item.block_name} ${item.flatnameint}</td>
                            <td>${item.receipt_no}</td>
                              <td>${item.type}</td>
                                <td>${item.collection_date}</td>
                                <td>${item.MaintenanceFromDate}</td>
                                 <td>${item.MaintenanceToDate}</td>
                                  <td>${item.amount}</td>
                                   <td>${item.payment_mode}</td>
                                    <td>${item.reference_no}</td>
                                     <td>${item.updatedBy}</td>

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
  
  

  document.getElementById("divTitle").innerHTML="Maintenence Monthly Report";
   document.getElementById('txtfromdate').value='${fromDate}';
 document.getElementById('txttodate').value='${toDate}';
	 
	 
	  $( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
	  $( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });
    
    drpblockname.value="${param.blockId}";


</script>