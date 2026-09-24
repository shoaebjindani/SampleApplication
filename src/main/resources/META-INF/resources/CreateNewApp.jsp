
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>















</head>





<br>

<div class="container" style="padding: 20px; background-color: white">


	<div class="row">

		<div class="col-sm-4">
			<div class="form-group">
				<label for="email">App Name</label> <input type="text"
					class="form-control" id="txtappname" name="txtappname">
			</div>
		</div>


		<div class="col-sm-4">
			<div class="form-group">
				<label for="email">Valid Till</label> <input type="text"
					id="txtvalidtill" name="txtvalidtill" class="form-control" readonly />
			</div>
		</div>


		<div class="col-sm-4">
			<div class="form-group">
				<label for="email">Store Name</label> <input type="text"
					id="txtstorename" name="txtstorename" class="form-control"  />
			</div>
		</div>
		
		<div class="col-sm-4">
			<div class="form-group">
				<label for="email">User Name</label> <input type="text"
					id="txtusername" name="txtusername" class="form-control"  />
			</div>
		</div>
		
		<div class="col-sm-12">
			<button class="btn btn-success" type="button" onclick='saveNewApp()'>Save</button>
			<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</butto
		</div>
		
		
		



	</div>






	<script type="javascript">

console.log("${userdetails}");
	document.getElementById("divTitle").innerHTML="Create New App";	
	document.title +=" Create New App ";
		
	
	
	
	
	
	function saveNewApp()
	{
		
		

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		  	  toastr["success"](xhttp.responseText);
		    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
		    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "2000",
		    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
		    	  "showMethod": "fadeIn","hideMethod": "fadeOut"}
  			window.location='?a=showHomePage';
		      
			  
			  
			  
			}
		  };
		  xhttp.open("GET","?a=saveNewApp&txtappname="+txtappname.value+"&txtvalidtill="
				  +txtvalidtill.value+"&txtstorename="+txtstorename.value+"&txtusername="+txtusername.value, true);    
		  xhttp.send();
		
	}
	
	
	$( "#txtvalidtill" ).datepicker({ dateFormat: 'dd/mm/yy' });
</script>