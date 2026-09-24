  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           




   





</head>


<script type="javascript">







</script>


<br>

<div class="container" style="padding:20px;background-color:white">

<form id="frm"  method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="row">

<div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Number Of Tables</label>     
      <select class="form-control" name="noOfTables" id="noOfTables">
      		<option value="1">1</option>
      		<option value="2">2</option>
      		<option value="3">3</option>
      		<option value="4">4</option>
      		<option value="5">5</option>
      		<option value="6">6</option>
      		<option value="7">7</option>
      		<option value="8">8</option>
      		<option value="9">9</option>
      		<option value="10">10</option>
      		<option value="11">11</option>
      		<option value="12">12</option>
      		<option value="13">13</option>
      		<option value="14">14</option>
      		<option value="15">15</option>
      		<option value="16">16</option>
      		<option value="17">17</option>
      		<option value="18">18</option>
      		<option value="19">19</option>
      		<option value="20">20</option>
      		<option value="21">21</option>
      		<option value="22">22</option>    			      
	  </select>
	  
	  <button class="btn btn-success" type="button" onclick='saveConfig()'>Save</button>
	   
    </div>
  </div>
   
</div>
</form>





<script type="javascript">
	document.getElementById("divTitle").innerHTML="Configure Tables";	
	document.title +=" Configure Tables ";
	function saveConfig()
	{
		
		
		  document.getElementById("closebutton").style.display='none';
		   document.getElementById("loader").style.display='block';
		

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
		      
			  
			}
		  };
		  xhttp.open("GET","?a=saveTableConfig&store_id=${userdetails.store_id}&noOfTables="+noOfTables.value, true);    
		  xhttp.send();
		
	}
</script>
