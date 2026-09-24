  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="stockDetails" value='${requestScope["outputObject"].get("stockDetails")}' />
   
 <c:set var="storeList" value='${requestScope["outputObject"].get("storeList")}' />





</head>


<script type="javascript">






</script>



<br>

<div class="container" style="padding:20px;background-color:white">

<form id="frm" action="?a=updateLowStock" method="post"  accept-charset="UTF-8">
<div class="row">

<input type="hidden" value="${stockDetails.stock_id}" name="stock_id" id="stock_id">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Store Name</label>
      
      
      <select class='form-control' disabled id="drpstoreid" name="drpstoreid">
        <c:forEach items="${storeList}" var="store">
					<option value='${ store.storeId}'>${ store.storeName}</option>						
		</c:forEach>
		</select>
      
    </div>
  </div>

  <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Item Name</label>
      <input type="text" class="form-control" id="categoryname" readonly value="${stockDetails.item_name}"  placeholder="eg. Sweets" name="categoryName">      
    </div>
  </div>
  
   <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Available Quantity</label>
      <input type="text" class="form-control" id="categoryname" readonly value="${stockDetails.qty_available}"  placeholder="eg. Sweets" name="categoryName">      
    </div>
  </div>
  
   <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Low Stock Quantity</label>
      <input type="text" class="form-control" id="lowqty" value="${stockDetails.low_stock_limit}"  name="lowqty">      
    </div>
  </div>
  
  
  
  
  
		<button class="btn btn-success" type="submit" >Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>
		

</form>

<script type="javascript">
	document.getElementById("divTitle").innerHTML="Configure Low Stock";
	document.title +=" Configure Low Stock ";
	drpstoreid.value='${stockDetails.store_id}';
	
	
	var arr=window.location.toString().split("/");
	callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");
</script>



