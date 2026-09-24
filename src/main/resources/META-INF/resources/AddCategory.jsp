  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="categoryDetails" value='${requestScope["outputObject"].get("categoryDetails")}' />
   





</head>


<script type="javascript">


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

<form id="frm" action="?a=addCategory" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Category Name</label>
      <input type="text" class="form-control" id="categoryname" value="${categoryDetails.category_name}"  placeholder="eg. Sweets" name="categoryName">
      <input type="hidden" name="hdnCategoryId" value="${categoryDetails.category_id}" id="hdnCategoryId">
    </div>
  </div>
  
  <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Order No</label>
      <input type="text" class="form-control" id="txtorderno" value="${categoryDetails.order_no}"  placeholder="eg. Order No" name="order_no">     
    </div>
  </div>
  
  <div class="col-sm-12">
  	 <div class="form-group">
      <label for="email">Upload the Images (800px X 800px)</label>
      
      <c:if test="${categoryDetails.ImagePath eq null}">	        
			        	<input type="file" name="file" multiple/>
	  </c:if>
	  
	  
	  <c:if test="${categoryDetails.ImagePath ne null}">			        
								        
				        		
				        						        	
				        				       
				        				       <img src="BufferedImagesFolder/${categoryDetails.ImagePath}" height="200px" width="200px"/>
				        				       File Size ${attachment.file_size} KB
					        				       
					        				       		<button type="button" class="btn btn-danger" onclick='deleteAttachment("${categoryDetails.attachId}")'>Delete</button>
					        				       
				        				        <br>
				        				        	
				        				        	
				       
			        		
			        </c:if>
	  
	  
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

<script type="javascript">
	
	
	<c:if test="${categoryDetails.categoryId eq null}">
		document.getElementById("divTitle").innerHTML="Add Category";
		document.title +=" Add Category ";
	</c:if>
	<c:if test="${categoryDetails.categoryId ne null}">
		document.getElementById("divTitle").innerHTML="Update Category";
		document.title +=" Update Category ";
	</c:if>
</script>



