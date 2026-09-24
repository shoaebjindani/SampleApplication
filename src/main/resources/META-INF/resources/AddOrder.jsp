




  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
           
           
           


<c:set var="itemList" value='${requestScope["outputObject"].get("itemList")}' />
<c:set var="orderDetails" value='${requestScope["outputObject"].get("orderDetails")}' />
<c:set var="table_no" value='${requestScope["outputObject"].get("table_no")}' />
<c:set var="categoriesWithItem" value='${requestScope["outputObject"].get("categoriesWithItem")}' />
<c:set var="lsitOfCategories" value='${requestScope["outputObject"].get("lsitOfCategories")}' />



   





</head>




<script type="javascript">







</script>


<br>



<div class="container" style="padding:20px;background-color:white">




<div class="col-sm-12">

<div class="card card-primary" >
              <div class="card-header" data-card-widget="collapse">
                <h3 class="card-title" >Menu</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" id="btnhidder" data-card-widget="collapse"  >
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    
                  </button>
                </div>
              </div>
              <div class="card-body table-responsive p-0">
                <div class="card card-primary card-tabs">
	<div class="card-header p-0 pt-1">
		<ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
			


							<c:forEach items="${lsitOfCategories}" var="category">
								<li class="nav-item"><a class="nav-link"
									id="custom-tabs-one-${fn:replace(category.category_name,' ', '')}-tab" data-toggle="pill"
									href="#custom-tabs-one-${fn:replace(category.category_name,' ', '')}" role="tab"
									aria-controls="custom-tabs-one-${fn:replace(category.category_name,' ', '')}" aria-selected="false">${fn:replace(category.category_name,' ', '')}</a></li>
							</c:forEach>
						</ul>
	</div>
	<div class="card-body">
		<div class="tab-content" id="custom-tabs-one-tabContent">
			
			
			
		
				
				<c:forEach items="${categoriesWithItem}" var="entry">
					
        				
					
						<div class="tab-pane fade" id="custom-tabs-one-${fn:replace(entry.key,' ', '')}"
				role="tabpanel" aria-labelledby="custom-tabs-one-${fn:replace(entry.key,' ', '')}-tab">
			<div class="row">	
				<c:forEach items="${entry.value}" var="ouritem">
			
				
				<div class="col-sm-2 col-md-4 col-lg-6" style="max-width:130px;font-size:13px" align="center">
					<img  height="50px" width="50px"  onclick="showThisItemIntoSelection('${ouritem.item_id}')"   src="BufferedImagesFolder/${ouritem.ImagePath}">
				<br>${ouritem.item_name }				
				</div>
			
				
				
				</c:forEach>
				</div>
				
				</div>
				
				
					
				</c:forEach>
				
				
		</div>
	</div>
</div>
              </div>
              <!-- /.card-body -->
            </div>
		
		
		</div>

 <div class="col-sm-12">   
    <div class="input-group">
    <input type="text" class="form-control form-control-sm"    placeholder="Search for Items" list="itemList" id="txtitem" name="txtitem" oninput="checkforMatchItem()">
    <div class="input-group-append">      
    </div>
  </div>
  </div>
  
  
  <div class="col-sm-12">  
	  <div class="card-body table-responsive p-0" style="height: 370px;">                
	                <table id="tblitems"  class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                  <thead>
	                    <tr align="center">
	                     <th style="z-index:0">Sr</th>
	  					 <th style="z-index:0">Item Name</th>
	  					 <th style="z-index:0">Item Qty</th>
	  					 <th style="z-index:0">Remarks</th>	  					 	  			
	  					 
	                    </tr>
	                  </thead>
	                  
			    					    
	   				  
	                  
	                </table>
	   </div>	
  </div>
  
  
  <div class="col-sm-12">
  	 <div class="form-group" align="center">  	 	
  	 	
  	 	
  	 	<input type="checkbox" class="form-check-input" id="chkgeneratePDF">
  		<label class="form-check-label" for="chkgeneratePDF">Generate PDF</label>	    		  
	   	   
	   		   
     </div>
   </div>
   
  
  
 <div class="col-sm-12">
  	 <div class="form-group" align="center">  	 	
  	 	
	    		  
	   	<button class="btn btn-success" type="button" onclick='saveOrder()'>Save</button>   
	   	<button class="btn btn-danger" type="reset" onclick='window.location="?a=showHomePage"'>Cancel</button>
	   	
	   	<button class="btn btn-primary" type="reset" onclick='window.location="?a=showGenerateInvoice&editInvoice=Y&table_id=${param.table_id}"'>Generate Invoice</button>	   
     </div>
   </div>




 <div class="col-sm-12">  
	  <div class="card-body table-responsive p-0" style="height: 370px;">                
	                <table id="tblordereditems"  class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                  <thead>
	                    <tr align="center">
	                    
	                   
	                    <c:if test="${not empty  orderDetails}">
	                    		<th style="z-index:0">Sr <input type="hidden" value='${orderDetails.get(0).order_id}' id="hdnOrderId"</input></th>
	                    </c:if>
	                    
	                    <c:if test="${empty  orderDetails}">
	                    		<th style="z-index:0">Sr <input type="hidden" value='' id="hdnOrderId"</input></th>
	                    </c:if>
	                    
	                    	<%-- <th style="z-index:0">Sr <input type="hidden" value='${orderDetails.get(0).order_id}' id="hdnOrderId"</input></th> --%>
	                    	
	                    
	  					 <th style="z-index:0">Item Name</th>
	  					 <th style="z-index:0">Item Qty</th>
	  					 <th style="z-index:0">Status</th>
	  					 <th style="z-index:0">Remarks</th>	  			
	  					 <th></th>
	                    </tr>
	                  </thead>
	                  <c:forEach items="${orderDetails}" var="order">
			    		<tr align="center">
			    		
			    			<td>${order.SrNo}			    			
			    			</td>
	                  		<td>${order.item_name}</td>
	                  		<td>${order.qty}</td>
	                  		<td>${order.status}</td>
	                  		<td>${order.remarks}</td>
	                  		
	                  		<td>
	                  		<c:if test="${order.status eq 'O'}">
	                  			<button class="btn btn-danger" onclick="cancelOrderDetail('${order.order_details_id}')">Cancel</button>
	                  			<button class="btn btn-primary" onclick="markAsServed('${order.order_details_id}')">Mark As Served</button>
	                  		</c:if>
	                  		</td>
	                  		
	                  	</tr>			    
	   				  </c:forEach>
	                  
	                </table>
	   </div>	
  </div>
  
  
  
  
<datalist id="itemList">
		  <c:forEach items="${itemList}" var="item">
				    <option id="${item.item_id}">${item.item_name} (${item.product_code})</option>			    
		   </c:forEach>	   	   	
</datalist>
  
  <br>
  
  
  
  
  
  
 


</div>









<script type="javascript">
	document.getElementById("divTitle").innerHTML="Table No ${table_no}";	
	document.title +=" Table No ${table_no} ";
	
	
	function saveOrder()
	{
		var rows=tblitems.rows;		
		var requiredDetails=[];
		var arr = [];
		var itemString="";
		var confirmMessage="";
		var proceedFlag=true;
		var messageToShow="";
		
		for (var x= 1; x < rows.length; x++) 
		{   
		    // ID,QTY,REMARKS,Item Name
		    itemString+=
		    	rows[x].childNodes[1].childNodes[0].value+
		   	"~"+rows[x].childNodes[2].childNodes[0].childNodes[1].value+
		   	"~"+rows[x].childNodes[3].childNodes[1].value+
		   	"~"+rows[x].childNodes[1].childNodes[1].innerHTML.toString().split("(")[0]+
		    "|";
		 }	
		
		
		
		var reqString="";
		if(typeof hdnOrderId!='undefined')
		{
			reqString="table_id=${param.table_id}"+"&order_id="+hdnOrderId.value+"&itemDetails="+itemString;
		}
		else
		{
			reqString="table_id=${param.table_id}"+"&order_id=&itemDetails="+itemString;
		}
		
		reqString+="&app_id=${userdetails.app_id}&store_id=${userdetails.store_id}";
		reqString+="&generatePdf="+chkgeneratePDF.checked;
		reqString+="&table_no=${table_no}";
		//alert(reqString);
		//return;
	
		
		
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) 
		    {	
		    	
		    	
		    	
		    	//alert(xhttp.responseText);
		    	if(chkgeneratePDF.checked==true)
		    		{
		    			window.open("BufferedImagesFolder/"+xhttp.responseText.split("~")[1]);
		    		}
		    	window.location="?a=showTables"
		    	return;
				
		    	
		    	if(typeof chkgeneratePDF !='undefined' && chkgeneratePDF.checked==true)
	      		{
	      		
	      			generateInvoice(invoiceId[1]);
	      			
	      		}
		    	
		    	
		    	window.location.reload();
		    }
		  };
		  xhttp.open("POST", "?a=saveOrder", true);
		  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		  xhttp.send(reqString);
		
	}
	
	function showItems()
	{
		
		
		var reqString1='<div class="card card-primary card-tabs"><div class="card-header p-0 pt-1"><ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist"><li class="nav-item"><a class="nav-link active" id="custom-tabs-one-home-tab" data-toggle="pill" href="#custom-tabs-one-home" role="tab" aria-controls="custom-tabs-one-home" aria-selected="true">Home</a></li><li class="nav-item"><a class="nav-link" id="custom-tabs-one-school-tab" data-toggle="pill" href="#custom-tabs-one-school" role="tab" aria-controls="custom-tabs-one-school" aria-selected="false">School</a></li></ul></div><div class="card-body"><div class="tab-content" id="custom-tabs-one-tabContent"><div class="tab-pane fade active show" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">Bla Bla</div><div class="tab-pane fade" id="custom-tabs-one-school" role="tabpanel" aria-labelledby="custom-tabs-one-school-tab">Other Bla bla</div></div></div></div>';
		
   		  						
		var catNameModel='<li class="nav-item">'+
					 '<a class="nav-link active" id="custom-tabs-one-catName-tab" data-toggle="pill" href="#custom-tabs-one-catName" role="tab" aria-controls="custom-tabs-one-catName">catName</a>'+
					 '</li>';					 
					 
		var itemListModel='<div class="tab-pane fade" id="custom-tabs-one-catName" role="tabpanel" aria-labelledby="custom-tabs-one-catName-tab">'+
        			  'itemNamecrystal'+
        			  '</div>';
        
		var catNames='<li class="nav-item"><a class="nav-link active" id="custom-tabs-one-home-tab" data-toggle="pill" href="#custom-tabs-one-home" role="tab" aria-controls="custom-tabs-one-home" aria-selected="true">Home</a></li>';
		catNames+='<li class="nav-item"><a class="nav-link" id="custom-tabs-one-school-tab" data-toggle="pill" href="#custom-tabs-one-school" role="tab" aria-controls="custom-tabs-one-school" aria-selected="false">School</a></li>';
		var itemList='<div class="tab-pane fade active show" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">Bla Bla</div>';
		itemList+='<div class="tab-pane fade" id="custom-tabs-one-school" role="tabpanel" aria-labelledby="custom-tabs-one-school-tab">Other Bla bla</div>';
	
		
			
	
		
		 			  
        reqString1=reqString1.replaceAll("crystalLabels",catNames);
        reqString1=reqString1.replaceAll("crystalItems",itemList);
		
		console.log(reqString1);
		var reqString='<div class="container"><div class="row">';
		
		
		reqString+='</div></div>';
		
		
		
		 
		document.getElementById("responseText").innerHTML=reqString1;
		  document.getElementById("closebutton").style.display='block';
		  document.getElementById("loader").style.display='none';
		  $("#myModal").modal();
		  
		  document.getElementById("closebutton").onclick = function(){$("#myModal").modal('hide');};
		
	}

	function showThisItemIntoSelection(itemId)
	{
		
		getItemDetailsAndAddToTable(itemId);
		
		/* document.getElementById("responseText").innerHTML="";
		$("#myModal").modal('hide'); */
	}
	function checkforMatchItem()
	{
		var searchString= document.getElementById("txtitem").value;	
		var options1=document.getElementById("itemList").options;
		var itemName="";
		var itemId=0;
		for(var x=0;x<options1.length;x++)
			{
				if(searchString==options1[x].value)
					{
					itemId=options1[x].id;
					itemName=options1[x].value;		
						break;
					}
			}
		if(itemId!=0)
			{	
					
					
					var table = document.getElementById("tblitems");	    	
			    	var row = table.insertRow(-1);	    	
			    	var cell1 = row.insertCell(0);
			    	var cell2 = row.insertCell(1);
			    	var cell3 = row.insertCell(2);
			    	var cell4 = row.insertCell(3);
			    	
			    	
			    	
			    	
			    	
			    	cell1.innerHTML = tblitems.rows.length-1;			    	
			    	cell2.innerHTML = "<input type='hidden' value="+itemId+"><div>"+itemName+"</div>";
			    	cell3.innerHTML = '<div class="input-group"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,0)"><i class="fa fa-minus"></i></button></span><input type="text" style="text-align:center" class="form-control form-control-sm"  id="txtqty'+itemId+'" onkeyup="calculateAmount('+itemId+');checkIfEnterisPressed(event,this);" onblur="formatQty(this)" onkeypress="digitsOnlyWithDot(event);" value="1"> <span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,1)"><i class="fa fa-plus"></i></button></span></div>';
			    	cell4.innerHTML = " <input type='text' class='form-control form-control-sm'  >  ";
			    	
			    	
			    	
			    	
					
					
					document.getElementById("txtitem").value="";
			}
		
	}
	
	function removethisitem(btn1)
	{
		btn1.parentNode.parentNode.parentNode.parentNode.remove();
			
		reshuffleSrNos();		
		
	}
	
	function reshuffleSrNos()
	{
		var rows1=tblitems.rows;
		for(var x=1;x<rows1.length;x++)
			{
				rows1[x].childNodes[0].innerHTML=x;
			}
	}
	
	function cancelOrderDetail(cancelOrderDetailId)
	{

		
		
		  document.getElementById("closebutton").style.display='none';
		   document.getElementById("loader").style.display='block';
		$('#myModal').modal({backdrop: 'static', keyboard: false});;

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		      document.getElementById("responseText").innerHTML=xhttp.responseText;
			  document.getElementById("closebutton").style.display='block';
			  document.getElementById("loader").style.display='none';
			  $('#myModal').modal({backdrop: 'static', keyboard: false});;
		      
			  
			}
		  };
		  xhttp.open("GET","?a=cancelOrderDetail&cancelOrderDetailId="+cancelOrderDetailId, true);    
		  xhttp.send();
	}
	
	function markAsServed(orderDetailsId)
	{
		
		
		  document.getElementById("closebutton").style.display='none';
		   document.getElementById("loader").style.display='block';
		$('#myModal').modal({backdrop: 'static', keyboard: false});;

		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		      document.getElementById("responseText").innerHTML=xhttp.responseText;
			  //document.getElementById("closebutton").style.display='block';
			  document.getElementById("loader").style.display='none';
			  $('#myModal').modal({backdrop: 'static', keyboard: false});;
			  
			  
			  setTimeout(function(){ window.location.reload();}, 300);

			  
		      
			  
			}
		  };
		  xhttp.open("GET","?a=markAsServed&orderDetailsId="+orderDetailsId, true);    
		  xhttp.send();
	}
	
	
	function getItemDetailsAndAddToTable(itemId)
	{
			      
		
		
		var options1=document.getElementById("itemList").options;
		var itemName="";
		
		for(var x=0;x<options1.length;x++)
			{
				if(options1[x].id==itemId)
					{					
					itemName=options1[x].value;		
						break;
					}
			}
		
		
		
		var table = document.getElementById("tblitems");	    	
    	var row = table.insertRow(-1);	    	
    	var cell1 = row.insertCell(0);
    	var cell2 = row.insertCell(1);
    	var cell3 = row.insertCell(2);
    	var cell4 = row.insertCell(3);
    	
    	
    	
    	
    	
    	cell1.innerHTML = tblitems.rows.length-1;			    	
    	cell2.innerHTML = "<input type='hidden' value="+itemId+"><div>"+itemName+"</div>";
    	cell3.innerHTML = '<div class="input-group"><span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,0)"><i class="fa fa-minus"></i></button></span><input type="text" style="text-align:center" class="form-control form-control-sm"  id="txtqty'+itemId+'" onkeyup="calculateAmount('+itemId+');checkIfEnterisPressed(event,this);" onblur="formatQty(this)" onkeypress="digitsOnlyWithDot(event);" value="1"> <span class="input-group-btn"><button class="btn btn-info" type="button" onclick="addremoveQuantity(this,1)"><i class="fa fa-plus"></i></button></span></div>';
    	cell4.innerHTML = " <input type='text' class='form-control form-control-sm'  >  ";
    	
    	
    	
    	
		
		
		document.getElementById("txtitem").value="";
		
		
		    	
		    	
				
	}
	
	
	function addremoveQuantity(element,addRemoveFlag) // 0 removes and 1 adds
	{
		var qtyElement=element.parentNode.parentNode.childNodes[1];
		
		var quantity=Number(qtyElement.value);
		
		if(quantity==1 && addRemoveFlag==0)
			{
				// code to remove the row
				removethisitem(element);
				return;
			}
		
		if(addRemoveFlag==1)
			{
				quantity++;	
			}
		
		if(addRemoveFlag==0)
		{
			quantity--;	
		}
		
		qtyElement.value=quantity;
		
		
	}
	
	
	<c:if test="${userdetails.restaurant_default_checked_generatepdf eq 'Y'}">
		chkgeneratePDF.checked=true;
	</c:if>
	
	
	

</script>

