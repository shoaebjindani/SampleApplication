  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="CategoriesList" value='${requestScope["outputObject"].get("CategoriesList")}' />
<c:set var="itemDetails" value='${requestScope["outputObject"].get("itemDetails")}' />
<c:set var="itemImageFileNames" value='${requestScope["outputObject"].get("itemImageFileNames")}' />
<c:set var="storeList" value='${requestScope["outputObject"].get("storeList")}' />
<c:set var="availableStoreIds" value='${requestScope["outputObject"].get("availableStoreIds")}' />
<c:set var="tentativeProductCode" value='${requestScope["outputObject"].get("tentativeProductCode")}' />




   





</head>


<script type="javascript">


function addItem()
{	
	localStorage.setItem("catId",drpcategoryId.value);
	localStorage.setItem("debitin",drpdebitin.value);
	
	btnsave.disabled=true;
	 if(drpcategoryId.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Category Name");
 	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
 	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
 	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
 	  "showMethod": "fadeIn","hideMethod": "fadeOut"
 	   };
	  	
	  	 
 	 btnsave.disabled=false;
 	 drpcategoryId.focus();
	  	return;
	  }
	 
	 if(itemname.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Item Name");
  	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
  	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
  	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
  	  "showMethod": "fadeIn","hideMethod": "fadeOut"
  	   };
	  	
	  	 
  	btnsave.disabled=false;
  	itemname.focus();
	  	return;
	  }
	 
	 if(drpdebitin.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Debit In");
 	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
 	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "2000",
 	  "hideDuration": "500","timeOut": "2000","extendedTimeOut": "2000","showEasing": "swing","hideEasing": "linear",
 	  "showMethod": "fadeIn","hideMethod": "fadeOut"
 	   };
	  	
	  	 
 	 btnsave.disabled=false;
 	drpdebitin.focus();
	  	return;
	  }
	 
	 if(itemsaleprice.value=="")
	  {
	  	
	  
	  toastr["error"]("Please enter Sales Price");
	  toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
	  "hideDuration": "500","timeOut": "1000","extendedTimeOut": "1000","showEasing": "swing","hideEasing": "linear",
	  "showMethod": "fadeIn","hideMethod": "fadeOut"
	   };
	  	
	  	 
	  btnsave.disabled=false;
	  itemsaleprice.focus();
	  	return;
	  }
	
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
    

<form id="frm" action="?a=addItem" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">

<div class="row">
<div class="col-sm-3">

  	<div class="form-group">
      <label for="email">Category Name * <a href="?a=showAddCategory">(Add Category)</a></label>     
      <select class="form-control" name="drpcategoryId" id="drpcategoryId">
      <c:forEach items="${CategoriesList}" var="cat">
			    <option value="${cat.category_id}">${cat.category_name}</option>			    
	   </c:forEach></select>     
    </div>
  </div>

  <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Item Name *</label>
      <input type="text" class="form-control" id="itemname" value="${itemDetails.item_name}"  placeholder="Item Name" name="itemname">
      <input type="hidden" name="hdnItemId" value="${itemDetails.item_id}" id="hdnItemId">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Debit In *</label>
      <select id="drpdebitin" name="drpdebitin" class="form-control">
      	<option value="W">Weight</option>
      	<option value="Q">Quantity</option>
      	<option value="S">Service</option>
      </select>
    </div>
  </div>
  
  
  <div class="col-sm-2" id="divAverageCost" style="display:block">
  	<div class="form-group">
      <label for="email">Average Cost</label>
      <input type="text" class="form-control" id="txtaveragecost" value="${itemDetails.average_cost}" onkeyup="digitsOnly(event)"  placeholder="180" name="txtaveragecost">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Sale Price *</label>
      <input type="text" class="form-control" id="itemsaleprice" value="${itemDetails.price}"  onkeyup="digitsOnly(event)" placeholder="180" name="itemsaleprice">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Wholesale Price</label>
      <input type="text" class="form-control" id="wholesaleprice" value="${itemDetails.wholesale_price}" onkeyup="digitsOnly(event)"  placeholder="180" name="wholesaleprice">
    </div>
  </div>
  
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Franchise Price</label>
      <input type="text" class="form-control" id="franchise_price" value="${itemDetails.franchise_rate}"  onkeyup="digitsOnly(event)" placeholder="180" name="franchise_price">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Loyal Customer 1 Price</label>
      <input type="text" class="form-control" id="loyalcustomer1price" value="${itemDetails.loyalcustomerrate1}" onkeyup="digitsOnly(event)"  placeholder="180" name="loyalcustomer1price">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Loyal Customer 2 Price</label>
      <input type="text" class="form-control" id="loyalcustomer2price" value="${itemDetails.loyalcustomerrate2}" onkeyup="digitsOnly(event)"  placeholder="180" name="loyalcustomer2price">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Loyal Customer 3 Price</label>
      <input type="text" class="form-control" id="loyalcustomer3price" value="${itemDetails.loyalcustomerrate3}" onkeyup="digitsOnly(event)"  placeholder="180" name="loyalcustomer3price">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Distributor Price</label>
      <input type="text" class="form-control" id="distributor_rate" value="${itemDetails.distributor_rate}" onkeyup="digitsOnly(event)"  placeholder="180" name="distributor_rate">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">B2B Price</label>
      <input type="text" class="form-control" id="b2b_rate" value="${itemDetails.b2b_rate}" onkeyup="digitsOnly(event)"  placeholder="180" name="b2b_rate">
    </div>
  </div>
  
  
	  <div class="col-sm-2" id="appspecific">
	  	<div class="form-group">
	      <label for="email">Shrikhand Buyers</label>
	      <input type="text" class="form-control" id="shrikhand" value="${itemDetails.shrikhand}"  onkeyup="digitsOnly(event)" placeholder="180" name="shrikhand">
	    </div>
	  </div>
  
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Product Code</label>
      <input type="text" class="form-control" id="product_code" value="${itemDetails.product_code}"  placeholder="${tentativeProductCode}" name="product_code">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">SGST %</label>
      <input type="text" class="form-control" id="sgst" value="${itemDetails.sgst}" onkeyup="digitsOnlyWithDot(event)"  name="sgst">
    </div>
  </div>
  
   <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">CGST %</label>
      <input type="text" class="form-control" id="cgst" value="${itemDetails.cgst}" onkeyup="digitsOnlyWithDot(event)"  name="cgst">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">HSN Code</label>
      <input type="text" class="form-control" id="hsn_code" value="${itemDetails.hsn_code}"   name="hsn_code">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Catalog No</label>
      <input type="text" class="form-control" id="catalog_no" value="${itemDetails.catalog_no}"   name="catalog_no">
    </div>
  </div>
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Order No</label>
      <input type="text" class="form-control" id="order_no" value="${itemDetails.order_no}"   name="order_no">
    </div>
  </div>
  
  
  
  <div class="col-sm-2">
  	<div class="form-group">
      <label for="email">Composite Items</label>
      <input type="button" type="button" class="btn btn-primary" onclick='window.location="?a=showCompositeMapping&itemId=${itemDetails.item_id}"' value="Configure">
    </div>
  </div>
  
  
  
  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Available At Stores</label>
      <c:forEach items="${storeList}" var="store">     
      		 <label style="margin:10px"><input type="checkbox" name="chk1"  value="${store.storeId}">${store.storeName}</label>
      </c:forEach>
    </div>
  </div>
  
  <c:if test="${itemDetails.qrCodeImageName ne null}">
    <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">QR Code </label>
            
      	<img src="BufferedImagesFolder/${itemDetails.qrCodeImageName}"  height="200px" width="200px"/>
      
      
    </div>
  </div>
  
  </c:if>
  
  <c:if test="${itemDetails.barcodeCodeImageName ne null}">
    <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Barcode </label>
            
      	<img src="BufferedImagesFolder/${itemDetails.barcodeCodeImageName}"  height="200" width="400px"/>
      
      
    </div>
  </div>
  
  </c:if>
  
  
  
  
  
  <div class="col-sm-12">
  	 <div class="form-group">
      <label for="email">Upload the Images (800px X 800px)</label>
      <input type="file" name="file" multiple/>
      </div>
      </div>
      
      
      	  	  
	<div class="col-sm-12">
  	 <div class="form-group">
  	 	<table>
  	 	<tr>  
	   <c:forEach items="${itemImageFileNames}" var="filenamesvar">
	    	
	    		<td align="center" style="padding:10px">  	
	  		<img src="D:/BufferedImagesFolder/${filenamesvar.fileName}"  height="100px" width="100px"/>
	  		<br>
	  		<button type="button" class="btn btn-danger" onclick='deleteAttachment("${filenamesvar.attachment_id}")'>Delete</button>
	  		</td>		   		
	   	</c:forEach>
	   	</tr>
	   	</table> 
	  
	  
	  
	  
    </div>
  </div>
  
  
    <div class="col-sm-12">
  	 <div class="form-group">
      <label for="email">Product Details</label>
	      <textarea class="form-control" id="productdetails" placeholder="Item Name" name="productdetails">
	      ${itemDetails.product_details}
	      </textarea>
      </div>
      </div>
  
  <div class="col-sm-12">
  	 <div class="form-group" align="center">
  	 
	   	<button class="btn btn-success" type="button" id="btnsave" onclick='addItem()'>Save</button>	
	   
	   <button class="btn btn-danger" type="reset" onclick='window.location="?a=showItemMaster"'>Cancel</button>
   </div>
   </div>
  
		
		 
</div>

</form>




<script type="javascript">
	<c:if test="${itemDetails.item_id ne null}">
		document.getElementById('drpcategoryId').value='${itemDetails.parent_category_id}';
		document.getElementById('drpdebitin').value='${itemDetails.debit_in}';
		
	</c:if>
	<c:if test="${itemDetails.item_id eq null}">
		document.getElementById('drpcategoryId').value=localStorage.getItem("catId");
		document.getElementById('drpdebitin').value=localStorage.getItem("debitin");
		document.getElementById('order_no').value='1';
		var names1=document.getElementsByName('chk1');
		for(var m=0;m<names1.length;m++)
			{
				names1[m].checked=true;		
			}
		document.getElementById("divTitle").innerHTML="Add Item";
		document.title +=" Add Item ";
	</c:if>
	<c:if test="${itemDetails.item_id ne null}">
		document.getElementById("divTitle").innerHTML="Update Item";
		document.title +=" Update Item ";
	</c:if>
	
	if(itemsaleprice.value=="")	{itemsaleprice.value="0";}
	if(wholesaleprice.value=="")	{wholesaleprice.value="0";}
	if(franchise_price.value=="")	{franchise_price.value="0";}
	if(loyalcustomer1price.value=="")	{loyalcustomer1price.value="0";}
	if(loyalcustomer2price.value=="")	{loyalcustomer2price.value="0";}
	if(loyalcustomer3price.value=="")	{loyalcustomer3price.value="0";}
	if(txtaveragecost.value=="")	{txtaveragecost.value="0";}
	if(distributor_rate.value=="")	{distributor_rate.value="0";}
	if(b2b_rate.value=="")	{b2b_rate.value="0";}
	if(shrikhand.value=="")	{shrikhand.value="0";}
	if(sgst.value=="")	{sgst.value="0";}
	if(cgst.value=="")	{cgst.value="0";}
	
	
	
		
	
	
	
	
	var storeNames=document.getElementsByName('chk1');
	<c:forEach items="${availableStoreIds}" var="storeid">
    	for(var x=0;x<storeNames.length;x++)
    		{				
    		if(storeNames[x].value=='${storeid}')
    			{
    				storeNames[x].checked=true;			    			
    			}
    		}			    
	</c:forEach>
		
	if('${userdetails.app_id}'!='1')
		{
			appspecific.style='display:none';
			divAverageCost.style='display:none';
		}
	
	var arr=window.location.toString().split("/");
	callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");
	
	$(document).ready(function() {
        $('#productdetails').richText();
    });
	
	
	window.addEventListener('keydown', function (e) {
		if(event.which==113)
		{
			addItem()
		} 
		});
	
	itemname.focus();
	
	
		
	
</script>

<script src="js/jquery.richtext.js"></script>


