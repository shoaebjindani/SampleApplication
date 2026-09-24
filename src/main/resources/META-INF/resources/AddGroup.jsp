  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="groupDetails" value='${requestScope["outputObject"].get("groupDetails")}' />
   





</head>


<script type="javascript">


function addGroup()
{	
	
	
	document.getElementById("frm").submit(); 
}










</script>



<br>

<div class="container" style="padding:20px;background-color:white">

<form id="frm" action="?a=addGroup" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Group Name</label>
      <input type="text" class="form-control" id="group_name" value="${groupDetails.group_name}"   name="group_name">
      <input type="hidden" name="hdnGroupId" value="${groupDetails.group_id}" id="hdnGroupId">
    </div>
  </div>
  
  
  <c:if test="${action ne 'Update'}">
		
		<button class="btn btn-success" type="button" onclick='addGroup()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCustomerGroup"'>Cancel</button>
		
		
		</c:if>
		
		
		
		<c:if test="${action eq 'Update'}">	
				
				<input type="button" type="button" class="btn btn-success" onclick='addCategory()' value="update">		
		</c:if> 
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${groupDetails.group_id eq null}">
		document.getElementById("divTitle").innerHTML="Add Group";
		document.title +=" Add Group ";
	</c:if>
	<c:if test="${groupDetails.group_id ne null}">
		document.getElementById("divTitle").innerHTML="Update Group";
		document.title +=" Update Group ";
	</c:if>
	
	var arr=window.location.toString().split("/");
	callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");
</script>



