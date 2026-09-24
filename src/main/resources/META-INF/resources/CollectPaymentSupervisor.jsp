  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="SupervisorDetails" value='${requestScope["outputObject"].get("SupervisorDetails")}' />
<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />
<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="yesterdaysDate" value='${requestScope["outputObject"].get("yesterdaysDate")}' />

<c:set var="lstOfShifts" value='${requestScope["outputObject"].get("lstOfShiftsActual")}' />
<c:set var="suggestedShiftId" value='${requestScope["outputObject"].get("suggestedShiftId")}' />

   





</head>


<script type="javascript">


function saveCollectPaymentSupervisorNew()
{	
	

	var nameAmounts=document.getElementsByName('nameAmounts');
	var collectionData="";
	for(var m=0;m<nameAmounts.length;m++)
		{
		collectionData+=(nameAmounts[m].id+"~"+nameAmounts[m].value)+"|";
		}
	
	var shiftId=document.getElementById('drpshift').value
	

	var stringToSend="mode="+drpmode.value+"&shiftId="+shiftId+"&txtcollectiondate="+txtcollectiondate.value+"&collectionData="+collectionData;	
	

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
	    	
	    		
	    		
	    			window.location="?a=showCollectPaymentSupervisor"
	    		
	      
		  
		}
	  };
	
	xhttp.open("POST","?a=saveCollectPaymentSupervisorNew", true);
	
	

		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xhttp.send(stringToSend);
	
	
	
	
//document.getElementById("frm").submit(); 
}








function deleteAttachment(id)
{
		
		
		
		  document.getElementById("closebutton").style.display='none';
		   document.getElementById("loader").style.display='block';
		$("#myModal").modal();

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		      document.getElementById("responseText").innerHTML=xhttp.responseText;
			  document.getElementById("closebutton").style.display='block';
			  document.getElementById("loader").style.display='none';
			  $("#myModal").modal();
		      
			  
			}
		  };
		  xhttp.open("GET","?a=deleteAttachment&attachmentId="+id, true);    
		  xhttp.send();
		
		
		
}








</script>



<br>

<div class="container" style="padding:20px;background-color:white">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">



<div class="col-sm-4">
  	<div class="form-group">
      <label for="email">Collection Date</label>
      
     <input type="text" id="txtcollectiondate" onchange="getAttendantList()" name="txtcollectiondate" class="form-control form-control-sm" value="${todaysDate}" readonly/>
            
    </div>
  </div>
  
  <div class="col-sm-4">
  	<div class="form-group">
      <label for="email">Shift No</label>
    
    
        <select class="form-control" name="drpshift" id="drpshift" onchange="getAttendantList()">
      
      
      <c:forEach items="${lstOfShifts}" var="shift">
			    <option value="${shift.shift_id}">${shift.shift_name}</option>    
	   </c:forEach></select>
	            
    </div>
  </div>

    <div class="col-sm-4">
  	<div class="form-group">
      <label for="email">Collection Mode</label>
      
      <select class="form-control" name="drpmode" id="drpmode">
      
             <option selected value='Cash'>Cash</option>
              <option value='Paytm'>Paytm</option>
               
      </select>
            
    </div>
  </div>
  
 
  <div id="someidgoeshere">
  	
  </div>
  
  
<%--   <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Attendant Name</label>
      
      <select class="form-control" name="drpemployee" id="drpemployee">
      
            <option value='-1'>--Select--</option>
      
      <c:forEach items="${userList}" var="user">
			    <option value="${user.user_id}">${user.name}</option>    
	   </c:forEach></select>
            
    </div>
  </div> --%>
  
<%--   
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Amount</label>
      <input type="text" class="form-control" id="amount" value="${param.amount}"  placeholder="eg. 500" name="amount">
      <input type="hidden" name="hdnSupervisorId" value="${SupervisorDetails.supervisor_id}" id="hdnSupervisorId">
      <input type="hidden" name="paytm_order_id" value="${param.order_id}" id="paytm_order_id">
    </div>
  </div> --%>
  
  
  
  

  
  
  
  
	  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Total Amount</label>
      
		<input type="text" class="form-control" id="txttotalamount" readonly >
 
    </div>
  </div>
  
  
  

		
		<button class="btn btn-success" type="button" onclick='saveCollectPaymentSupervisorNew()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCollectPaymentSupervisor"'>Cancel</button>
		
		
		
		
		
		
		
</div>

<br>
<br>
<br>

 <div class="card-body table-responsive p-0" style="height: 480px;">                
                <table id="example1" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                
                 
                    
                  <tbody>
				<c:forEach items="${showPaymentCollectionReportFuel}" var="data1">
					<tr >
					  
					  
					  <td>${data1.collection_id}</td>
					  <td>${data1.attendantName}</td>
					  <td>${data1.amount}</td>
					  <td>${data1.updatedByuser}</td>
					  <td>${data1.updated_date}</td>
					  <td>${data1.shift_id}</td>
					  <td>${data1.collection_date}</td>
						
					</tr>
				</c:forEach>
				
				
                  </tbody>
                </table>
              </div>
</form>

<script type="javascript">
	


document.getElementById("divTitle").innerHTML="Collect Payment Supervisor";

document.title +=" Collect Payment Supervisor";



if('${param.order_id}'!='')
{
	amount.readOnly=true;	
}

function calculateTotal()
{
	var nameAmounts=document.getElementsByName('nameAmounts');
	var totalAmount=0;
	for(var m=0;m<nameAmounts.length;m++)
		{
		totalAmount+=Number(nameAmounts[m].value);
		}
	txttotalamount.value=totalAmount;
	
}
$( "#txtcollectiondate" ).datepicker({ dateFormat: 'dd/mm/yy' });

function getAttendantList()
{
	var collectiondate=txtcollectiondate.value;
	var shift=drpshift.options[drpshift.selectedIndex].value;
	
	const xhttp = new XMLHttpRequest();
    xhttp.onload = function() {
    	var lsitofattendants=JSON.parse(this.responseText)["listofAttendants"];
    	

      var rowString='<div class="row">';
  	var k=`<div class="col-sm-6">
  	  	<div class="form-group">
        <label for="email">attendantNameGoesHere</label>
        
        <input type="text" onkeyup="calculateTotal()" value="0" name="nameAmounts" class="form-control" id="idGoesHere">
        
             
  	   </select>
              
      </div>
    </div>`;
    var rowStringClose='</div>';
      var reqString="";
      for(var m=0;m<lsitofattendants.length;m++)
    	  {
    	  	//console.log(lsitofattendants[m].username);
    	  	
    	  	var tempString=k.toString().replace("attendantNameGoesHere",lsitofattendants[m].username);
    	  	tempString=tempString.replace("idGoesHere",lsitofattendants[m].user_id);
    	  	reqString+=tempString;
    	  }
      document.getElementById("someidgoeshere").innerHTML=rowString+reqString+rowStringClose;
      //document.getElementById("someidgoeshere").innerHTML=reqString;
      
      
      var collectionData=JSON.parse(this.responseText)["collectionData"];
      var table = document.getElementById("example1");	    	
  	var row = table.insertRow(-1);	    	
  	var cell1 = row.insertCell(0);
  	var cell2 = row.insertCell(1);
  	var cell3 = row.insertCell(2);
  	var cell4 = row.insertCell(3);
  	var cell5 = row.insertCell(4);
  	var cell6 = row.insertCell(5);
  	var cell7 = row.insertCell(6);
  	var cell8 = row.insertCell(7);

  	
  	cell1.innerHTML = '<b>Collection Id';    	
  	cell2.innerHTML = '<b>Attendant Id';
  	cell3.innerHTML = '<b>Amount';
  	cell4.innerHTML = '<b>Updated By';
  	cell5.innerHTML = '<b>Updated Date';
  	cell6.innerHTML = '<b>Shift Id';
  	cell7.innerHTML = '<b>Collection Date';
  	cell8.innerHTML = '<b>Collection Mode';
  	
  	
  	
    	for(var m=0;m<collectionData.length;m++)
    		{
    			console.log(collectionData);
    			var row = table.insertRow(-1);	    	
    		  	var cell1 = row.insertCell(0);
    		  	var cell2 = row.insertCell(1);
    		  	var cell3 = row.insertCell(2);
    		  	var cell4 = row.insertCell(3);
    		  	var cell5 = row.insertCell(4);
    		  	var cell6 = row.insertCell(5);
    		  	var cell7 = row.insertCell(6);
    		  	var cell8 = row.insertCell(7);
    		  	
    		  	cell1.innerHTML = collectionData[m].collection_id;    	
    		  	cell2.innerHTML = collectionData[m].AttendantName;    	
    		  	cell3.innerHTML = collectionData[m].amount;    	
    		  	cell4.innerHTML = collectionData[m].SupervisorName;    	
    		  	cell5.innerHTML = collectionData[m].updated_date;    	
    		  	cell6.innerHTML = collectionData[m].shift_name;    	
    		  	cell7.innerHTML =collectionData[m].collection_date;
    		  	cell8.innerHTML =collectionData[m].collection_mode;
    			
    		}
      
      
    }
    xhttp.open("GET", "?a=getAttendantsForDateAndShift&collection_date="+txtcollectiondate.value+"&shift_id="+shift);
    xhttp.send();
	
	
	
}
getAttendantList();
</script>



