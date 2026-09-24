<style>
	.date_field {position: relative; z-index:1000;}
	.ui-datepicker{position: relative; z-index:1000!important;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="dailyQuoteData" value='${requestScope["outputObject"].get("dailyQuoteData")}' />
<c:set var="listStoreData" value='${requestScope["outputObject"].get("listStoreData")}' />

<c:set var="txtfromdate" value='${requestScope["outputObject"].get("txtfromdate")}' />
<c:set var="txttodate" value='${requestScope["outputObject"].get("txttodate")}' />
<c:set var="drpStoreId" value='${requestScope["outputObject"].get("drpStoreId")}' />


<br>
<div class="card">




		<br>

    
              
              
              
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
				
				
				<c:if test="${adminFlag eq true}">
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
				</c:if>
				
				
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
              
              
              
              
              
              
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 580px;">                
                <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                  <thead>
                    <tr>
                     <th><b>Customer Name</b></th><th><b>Total Amount</b></th> <th><b>Quote No</b></th>
                     <th><b>Quote Date</b></th>
                     <th><b>Updated Date</b></th>
                     <th><b>Payment Type</b></th><th><b>Payment Mode</b></th></th><th><b>Created By</b></th><th><b>Store Name</b></th>
                     <th></th>
                     <th></th>
                    </tr>
                  </thead>
                  <tbody>
				<c:forEach items="${dailyQuoteData}" var="item">
					<tr >
						<td>${item.customer_name}</td><td>${item.total_amount}</td>
						<td><a href="?a=showGenerateQuote&quote_id=${item.quote_id}">${item.quote_no}</a></td>
						<td>${item.FormattedQuoteDate}</td>
						<td>${item.updatedDate}</td>
						<td>${item.payment_type}</td>
						<td>${item.payment_mode}</td>
						<td>${item.name}</td>
						<td>${item.store_name}</td>
						<td><button class="btn btn-danger" onclick="deleteQuote('${item.quote_id}')">Delete</button></td>
						<td><button class="btn btn-primary" onclick="editQuote('${item.quote_id}')">Edit</button></td>
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
      "order": [[ 2, "desc" ]]
    });
  });
  
  document.getElementById("divTitle").innerHTML="Daily Quote Report";
  document.title +=" Daily Quote Report ";
  
  
  
</script>


<script type="javascript">
function ReloadFilters()
{
	  window.location="?a=generateDailyQuoteReport&drpstoreId="+drpstoreId.value+"&txtfromdate="+txtfromdate.value+"&txttodate="+txttodate.value+"";;
	  
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

$( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });



txtfromdate.value='${txtfromdate}';
txttodate.value='${txttodate}';
drpstoreId.value='${drpStoreId}';

function editQuote(quoteId)
{
		window.location="?a=showGenerateQuote&editQuote=Y&quote_id="+quoteId;
		//alert(quoteId);
}
function deleteQuote(quoteId)
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
	  xhttp.open("GET","?a=deleteQuote&user_id=${userdetails.user_id}&app_id=${userdetails.app_id}&store_id=${userdetails.store_id}&quoteId="+quoteId, true);    
	  xhttp.send();
}

</script>
