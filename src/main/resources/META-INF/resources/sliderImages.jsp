  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="sliderImages" value='${requestScope["outputObject"].get("sliderImages")}' />
   





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

<form id="frm" action="?a=addSlider" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  
  
  
  <div class="col-sm-12">
  	 <div class="form-group">
      <label for="email">Upload the Images (800px X 800px)</label>
      	        
			        	<input type="file" name="file" multiple/>
	  
    </div>
  </div>
  
  <c:forEach items="${sliderImages}" var="image">
  <div class="col-sm-6">
  	 <div class="form-group">    		    	
	    	<td align="center" style="padding:10px">  	
	  		<img src="BufferedImagesFolder/${image.file_name}"  height="150px" width="300px"/>
	  		<br>
	  		<br>
	  		${image.file_name}<br> 
	  		<button type="button" class="btn btn-danger" onclick='deleteAttachment("${image.attachment_id}")'>Delete</button>
	  		
	  		</td>	  				   		
	   	
	  
	  
    </div>
  </div>
  </c:forEach>
  <div class="col-sm-12">
  
		<button class="btn btn-success" type="button" onclick='addCategory()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>		
   
		
		
	
		</div> 
</div>
</form>

<script type="javascript">
	
	
	
		document.getElementById("divTitle").innerHTML="Slider Images";
		document.title +=" Slider Images ";
		var arr=window.location.toString().split("/");
		callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");	
	
</script>



