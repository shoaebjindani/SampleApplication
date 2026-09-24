  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="fuelDetails" value='${requestScope["outputObject"].get("fuelDetails")}' />
<c:set var="nozzleDetails" value='${requestScope["outputObject"].get("nozzleDetails")}' />

   





</head>


<script type="javascript">


function addNozzleCheckOut()
{	
	
	
	document.getElementById("frm").submit(); 
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

<form id="frm" action="?a=checkOutNozzle" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Nozzle Name</label>
      <input type="text" class="form-control" readonly value="${nozzleDetails.nozzle_name} ${nozzleDetails.item_name}"  >
      <input type="hidden" name="trn_nozzle_id" value="${nozzleDetails.trn_nozzle_id}" id="trn_nozzle_id">
      
    </div>
    </div>
    
    <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Opening Reading</label>
      <input type="text" class="form-control" id="txtopeningreading" readonly value="${nozzleDetails.opening_reading}"   name="fuelName">      
    </div>
    
    
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Totalizer Opening Amount</label>
      <input type="text" class="form-control" id="txttotalizeropeningamount" readonly value="${nozzleDetails.totalizer_opening_reading}"   name="fuelName">      
    </div>
    
    
  </div>
  
  
       

  
  
  <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Input Closing Reading</label>
      <input type="text" onkeyup="calculateExpectedTotalizer()" class="form-control" id="closing_reading" autocomplete="false"  name="closing_reading">      
    </div>
    
    
  </div>
  
  <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Price</label>
      <input type="text" class="form-control" id="txtprice" readonly autocomplete="false"  name="txtprice" value="${nozzleDetails.price }">      
    </div>
    
    
  </div>
  
  <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Sale</label>
      <input type="text" class="form-control" id="txtsale" readonly autocomplete="false"  name="txtsale" readonly>      
    </div>
    
    
  </div>
  
  <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Expected Totalizer Amount</label>
      <input type="text" class="form-control" readonly autocomplete="false"  name="txtexpectedtotalizeramount" id="txtexpectedtotalizeramount" value="0">      
    </div>
    
    
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Closing Totalizer Amount</label>
      <input type="text" class="form-control" id="closing_totalizer_amount" autocomplete="false"  name="closing_totalizer_amount">      
    </div>
    
    
  </div>
  
  
   <div class="col-sm-12">
  	<div class="form-group">
  		<input type="button" type="button" class="btn btn-danger" onclick='addNozzleCheckOut()' value="Check Out">		
    </div>
    
    
  </div>
  

		
		
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${fuelDetails.fuelId eq null}">
		document.getElementById("divTitle").innerHTML="Nozzle Check Out Form";
		document.title +=" Nozzle Check Out Form ";
	</c:if>
	
	function calculateExpectedTotalizer()
	{
		var inpClosingReading= Number(document.getElementById("closing_reading").value);
		var inpOpeningReading= Number(document.getElementById("txtopeningreading").value);
		var price= Number(document.getElementById("txtprice").value);
		var sales=Number(inpClosingReading-inpOpeningReading).toFixed(3);
		
		txtexpectedtotalizeramount.value= Number(txttotalizeropeningamount.value) + (sales * price) ;
		
		txtsale.value=sales;
	}	
</script>



