
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <c:set var="shopDetails" value='${requestScope["outputObject"].get("shopDetails")}' />

    </head>


    <script>
        function addShop() {
            if (shopname.value == "") {
                toastr["error"]("Please enter Shop Name");
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "1000",
                    "hideDuration": "500",
                    "timeOut": "1000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                shopname.focus();
                return;
            }
            document.getElementById("frm").submit();
        }
    </script>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="shopDetails" value='${requestScope["outputObject"].get("shopDetails")}' />









</head>



<script>


function addCategory()
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

<form id="frm" action="?a=addShop" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">




	<div class="col-sm-12">
		<div class="form-group">
		<label for="email">Shop Name</label>
		<input type="text" class="form-control" id="txtshopname" value="${shopDetails.shop_name}"  placeholder="eg. NAME" name="txtshopname">
		<input type="hidden" name="hdnShopId" value="${shopDetails.shop_id}" id="hdnShopId">
	  </div>
	</div>


  <c:if test="${action ne 'Update'}">
		
		<button class="btn btn-success" type="button" onclick='addCategory()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>
		
		
		</c:if>
		
		
		
		<c:if test="${action eq 'Update'}">	
				
				<input type="button" type="button" class="btn btn-success" onclick='addCategory()' value="update">		
		</c:if> 
</div>
</form>


	
	
	<c:if test="${shopDetails.shop_id eq null}">
		<script>document.getElementById("divTitle").innerHTML="Add Shop";</script>
	</c:if>
	<c:if test="${shopDetails.shop_id ne null}">
		<script>
			document.getElementById("divTitle").innerHTML="Update Shop";
			document.getElementById("txtshopname").value='${shopDetails.shop_name}';
			
		</script>
	</c:if>
	
	




