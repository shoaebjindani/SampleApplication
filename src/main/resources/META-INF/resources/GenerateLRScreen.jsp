<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           

<c:set var="activeNozzles" value='${requestScope["outputObject"].get("activeNozzles")}' />
<c:set var="lstOfShifts" value='${requestScope["outputObject"].get("lstOfShifts")}' />
<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />

<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="lrno" value='${requestScope["outputObject"].get("lrno")}' />
<c:set var="lrData" value='${requestScope["outputObject"].get("lrData")}' />




</head>


<script type="javascript">


function addGenerateLR()
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
		  xhttp.open("GET","?a=addGenerateLR&stockistname="+stockistname.value+"&wadhwanto="+ wadhwanto.value +"&address="+address.value +"&txtdate="+txtdate.value +"&city="+city.value +"&lrnumber="+lrnumber.value +"&telno="+telno.value +"&truckno="+truckno.value +"&weight="+weight.value +"&cement="+cement.value +"&bags="+bags.value, true); 
		  xhttp.send();
		
		
}


function searchLR()
{	

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		      var reqLrData=JSON.parse(xhttp.responseText);
		      console.log(reqLrData);
		      
		      var form  = document.getElementById("frm");
		      var allElements = form.elements;
		      for (var i = 0, l = allElements.length; i < l; ++i) {
		           allElements[i].readOnly = true;
		             //allElements[i].disabled=true;
		      }
			  
		      txtdate.value=reqLrData.lrData.niceDate;
		      address.value=reqLrData.lrData.address;
		      weight.value=reqLrData.lrData.weight;
		      cement.value=reqLrData.lrData.cement;
		      bags.value=reqLrData.lrData.bags;
		      city.value=reqLrData.lrData.city;
		      telno.value=reqLrData.lrData.tel_no;
		      truckno.value=reqLrData.lrData.truck_no;
		      stockistname.value=reqLrData.lrData.stockist_name;
		      wadhwanto.value=reqLrData.lrData.wadhwan_to;
		      
		      
			  
			}
		  };
		  xhttp.open("GET","?a=searchLR&lrnumbersearch="+lrnumbersearch.value, true); 
		  xhttp.send();
		
}








</script>



<br>

<div class="container" style="padding:20px;background-color:white">

<form id="frm" action="?a=addSwipe" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  
  
  <div class="col-6">
  	<div class="form-group">
      <label for="email">LR No.</label>
 <input type="text" class="form-control" id="lrnumbersearch" placeholder="LR Number" name="lrnumbersearch">      
    </div>
  </div>
  
    <div class="col-sm-12" align="center">
  	<div class="form-group">
   <button class="btn btn-success" type="button" onclick='searchLR()'>Search</button>
    <button class="btn btn-success" type="button" onclick=''>Reprint</button>
     <button class="btn btn-success" type="button" onclick='window.location="?a=showGenerateLR"'>New</button>
      <button class="btn btn-success" type="button" onclick='window.location="?a=showConfigureLR"'>Change Printer</button>

 
      
    </div>
    
        <div class="col-6">
  	<div class="form-group">
      <label for="email">Stockist Name</label>
 <input type="text" class="form-control" id="stockistname" placeholder="Stockist Name" name="stockistname"> 
      
    </div>
  </div>
  
    <div class="col-6">
  	<div class="form-group">
      <label for="email">Wadhwan to</label>
 <input type="text" class="form-control" id="wadhwanto" placeholder="Wadhwan to" name="wadhwanto"> 
      
    </div>
  </div>
  
    <div class="col-6">
  	<div class="form-group">
      <label for="email">Address</label>
 <input type="text" class="form-control" id="address" placeholder="Address" name="address">      
    </div>
  </div>
  
  <div class="col-6">
  	<div class="form-group">
      <label for="email">Date</label>
 <input type="text" readonly class="form-control" id="txtdate" placeholder="" name="txtdate" value="${todaysDate }"> 
      
    </div>
  </div>
  
      <div class="col-6">
  	<div class="form-group">
      <label for="email">City</label>
 <input type="text" class="form-control" id="city" placeholder="City" name="city">      
    </div>
  </div>
  
    <div class="col-6">
  	<div class="form-group">
      <label for="email">LR No.</label>
 <input type="text" value="${lrno}" class="form-control" id="lrnumber" placeholder="LR Number" name="lrnumber">      
    </div>
  </div>
  
      <div class="col-6">
  	<div class="form-group">
      <label for="email">Telephone No.</label>
 <input type="text" class="form-control" id="telno" placeholder="Telephone no." name="telno">      
    </div>
  </div>
  
        <div class="col-6">
  	<div class="form-group">
      <label for="email">Truck No.</label>
 <input type="text" class="form-control" id="truckno" placeholder="Truck no." name="truckno">      
    </div>
  </div>
  
        <div class="col-6">
  	<div class="form-group">
      <label for="email">Weight</label>
 <input type="text" class="form-control" id="weight" placeholder="Weight" name="weight">      
    </div>
  </div>
  
        <div class="col-6">
  	<div class="form-group">
      <label for="email">Cement</label>
 <input type="text" class="form-control" id="cement" placeholder="Cement" name="cement">      
    </div>
  </div>
  
  
          <div class="col-6">
  	<div class="form-group">
      <label for="email">Bags</label>
 <input type="text" class="form-control" id="bags" placeholder="Bags" name="bags">      
    </div>
  </div>
   
  
  
  
  <div class="col-sm-12" align="center">
  	<div class="form-group">
   <button class="btn btn-success" type="button" onclick='addGenerateLR()'>Save and Print</button>
		<button class="btn btn-success" type="reset" onclick='window.location="?a=showGenerateLR"'>View All</button>

 
      
    </div>
  </div>
  
   
      
    </div>
  </div>
 
  
  
 		
		
		
		
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${SwipeDetails.SwipeMachineId eq null}">
		document.getElementById("divTitle").innerHTML="Generate LR";
		document.title +=" Generate LR ";
	</c:if>
	
	$( "#txttestdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
</script>






