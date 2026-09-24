  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           

<c:set var="lstUnclaimedPayments" value='${requestScope["outputObject"].get("lstUnclaimedPayments")}' />



   





</head>


<script type="javascript">


function suspensePayment(orderId,suspensValue)
{
	var answer = window.confirm("Are you sure you want to Suspend ?");
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
	  xhttp.open("GET","?a=suspensePayment&orderId="+orderId+"&suspensValue="+suspensValue, true);    
	  xhttp.send();

}



</script>


<br>

		<div class="container" style="background-color: white">
		
		<div class="row" style="padding:3px">
	<c:forEach var="payment" items="${lstUnclaimedPayments}">
	
	
	
	<div class="col-lg-3 col-6" onclick="window.location='?a=showCollectPaymentSupervisor&order_id=${payment.order_id}&amount=${payment.amount}'">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
              
              


                <h3>Rs. ${payment.displayAmount }</h3>
                
                <div align="left" style="color: white">${payment.date_time_from_payment}</div>
						<div align="left" style="color: white">Order Id : ${payment.displayOrderId}</div>
						<div align="left" style="color: white">BHIM UPI : ${payment.bhim_upi_id}</div>
						<div align="left" style="color: white">Mobile No : ${payment.mobile_no}</div>
						
              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>
              <a style="background:red!important" href="" onclick="suspensePayment('${payment.order_id}',-1)" class="small-box-footer">Suspense Payment<i
						class="fas fa-arrow-circle-right"></i></a>
            </div>
          </div>
			
				
			
		
	</c:forEach>
	</div>

</div>






<script type="javascript">
	document.getElementById("divTitle").innerHTML=" Unclaimed Payments (${lstUnclaimedPayments.size()})";	

	document.title +=" Unclaimed Payments (${lstUnclaimedPayments.size()})";

	
	function sendToNozzleInputPage(nozzle_id,color,name,closing_reading,nozzle_name,item_name,opening_reading,trn_nozzle_id)
	{
		
		if(color=='Occupied')
			{
				alert("This nozzle is already Occupied By "+name);
				window.location="?a=showCheckOutScreen&nozzle_id="+nozzle_id+"&opening_reading="+opening_reading+"&nozzle_name="+nozzle_name+"&item_name="+item_name+"&trn_nozzle_id="+trn_nozzle_id;
				return;
			}
		
		
		  window.location="?a=showNozzleSelectionForm&nozzle_id="+nozzle_id+"&closing_reading="+closing_reading+"&nozzle_name="+nozzle_name+"&item_name="+item_name;
		
	}
</script>
