  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="employeeDetails" value='${requestScope["outputObject"].get("employeeDetails")}' />
<c:set var="listStoreData" value='${requestScope["outputObject"].get("listStoreData")}' />
   





</head>




<script type="javascript">


function addEmployee()
{	
	 if(EmployeeName.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Employee Name");
  	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
  	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
  	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
  	  "showMethod": "fadeIn","hideMethod": "fadeOut"
  	   };
	  	
	  	 
      	
  	  EmployeeName.focus();
	  	return;
	  }
	
	 if(username.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter User Name");
 	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
 	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
 	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
 	  "showMethod": "fadeIn","hideMethod": "fadeOut"
 	   };
	  	
	  	 
     	
 	 username.focus();
	  	return;
	  }
	 
	 if(document.getElementById("MobileNumber").value=="" || document.getElementById("MobileNumber").value.length!=10)
	  {
	  	
	  
	  toastr["error"]("Please enter Mobile Number");
	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
	  "showMethod": "fadeIn","hideMethod": "fadeOut"
	   };
	  	
	  	 
    	
	  MobileNumber.focus();
	  	return;
	  }
	 
	 if(txtstore.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Store");
	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
	  "showMethod": "fadeIn","hideMethod": "fadeOut"
	   };
	  	
	  	 
    	
	  txtstore.focus();
	  	return;
	  }
	 
	 
	document.getElementById("frm").submit(); 
}






</script>


<br>

<div class="container" style="padding:20px;background-color:white">


<form id="frm" action="?a=addEmployee" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="row">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

  <div class="col-sm-12">
  	<div class="form-group">
      <label for="EmployeeName">Employee Name*</label>
      <input type="text" class="form-control" id="EmployeeName" value="${employeeDetails.name}" name="EmployeeName" placeholder="Employee Name">
      <input type="hidden" name="hdnEmployeeId" value="${employeeDetails.user_id}" id="hdnEmployeeId">
    </div>
  </div> 
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="EmployeeName">User Name*</label>
      <input type="text" class="form-control" id="username" value="${employeeDetails.username}" name="username" placeholder="Username">
      
    </div>
  </div>
 
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="MobileNumber">Mobile Number*</label>
      <input type="text" class="form-control" id="MobileNumber" value="${employeeDetails.mobile}" name="MobileNumber" placeholder="Mobile Number" onkeypress="digitsOnly(event)" maxlength="10" required>
    </div>
  </div>
  
  
  
   <div class="col-sm-12">
  	<div class="form-group">
      <label for="MobileNumber">Email</label>
      <input type="text" class="form-control" id="email" value="${employeeDetails.email}" name="email" placeholder="Email"  required>
    </div>
  </div>
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="MobileNumber">Store*</label>
      
      <select class='form-control' id="txtstore" name = "txtstore" class="form-control" >
				<option value="-1">-------------------------Select --------------------</option>
				<c:forEach items="${listStoreData}" var="item">
				    <option value="${item.storeId}">${item.storeName}</option>			    
		   		</c:forEach>
	  		
			
			</select>
      
    </div>
  </div>    
  
  <div class="col-sm-12" align="center">
  	<div class="form-group">
      <button class="btn btn-success" type="button" onclick='addEmployee()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showEmployeeMaster"'>Cancel</button>
	</div>
  </div>    
    
  
  </div>
  
 
		
	
</div>
</form>








<script type="javascript">

<c:if test="${employeeDetails.user_id eq null}">
	document.getElementById("divTitle").innerHTML="Add Employee";
	document.title +=" Add Employee ";
</c:if>
<c:if test="${employeeDetails.user_id ne null}">
	txtstore.value="${employeeDetails.store_id}";
	document.getElementById("divTitle").innerHTML="Update Employee";
	document.title +=" Update Employee ";
</c:if>
	
var arr=window.location.toString().split("/");
callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");	
</script>
