<style>
	th
	{
		vertical-align:middle!important;
	}
	td
	{
		vertical-align:middle!important;
	}
</style>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           



<c:set var="itemList" value='${requestScope["outputObject"].get("itemList")}' />
<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="invoiceDetails" value='${requestScope["outputObject"].get("invoiceDetails")}' />
<c:set var="tentativeSerialNo" value='${requestScope["outputObject"].get("tentativeSerialNo")}' />
<c:set var="vendorMaster" value='${requestScope["outputObject"].get("vendorMaster")}' />

<c:set var="challanDetails" value='${requestScope["outputObject"].get("challanDetails")}' />





   





</head>


<script type="javascript">


function saveInvoice()
{
	
	
	btnsave.disabled=true;
	
	var rows=tblitems.rows;
	
	var requiredDetails=[];
	 
	var arr = [];
	var itemString="";
	var confirmMessage="";
	var proceedFlag=true;
	var messageToShow="";
	
	
	
	if(hdnSelectedCustomer.value=="")
		{
			alert('please select Vendor');
			
			btnsave.disabled=false;	
			return;
		}
	
	for (var x= 1; x < rows.length; x++) 
	{   
	    // ID,QTY, RATE,SGSTAMOUNT,SGSTPERCENT,CGSTAMOUNT,CGSTPERCENT,ITEMAMOUNT
	    itemString+=
	    	rows[x].childNodes[0].childNodes[1].value+ //ID	    
	    "~"+Number(rows[x].childNodes[2].childNodes[1].value)+ //QTY
	    "~"+Number(rows[x].childNodes[3].childNodes[0].value)+ // RATE
	    
	    "~"+Number(rows[x].childNodes[4].childNodes[0].childNodes[1].value)+ // SGSTAMOUNT
	    "~"+Number(rows[x].childNodes[4].childNodes[0].childNodes[3].value)+ // SGSTPERCENT
	    
	    "~"+Number(rows[x].childNodes[4].childNodes[0].childNodes[5].value)+ // CGSTAMOUNT
	    "~"+Number(rows[x].childNodes[4].childNodes[0].childNodes[7].value)+ // CGSTPERCENT
	    
	    "~"+Number(rows[x].childNodes[5].childNodes[0].value)+
	    "|";       
	}
	
	var reqString="customer_id="+hdnSelectedCustomer.value+
	"&gross_amount="+grossAmount.innerHTML+		
	"&total_amount="+totalAmount.innerHTML+
	"&total_gst="+document.getElementById('totalGstAmount').innerHTML+
	"&invoice_date="+txtinvoicedate.value+		
	"&remarks="+txtremarks.value+
	"&hdnPreviousInvoiceId="+hdnPreviousInvoiceId.value+
	"&challanId=${param.challanId}"+
	"&txttallyrefno="+txttallyrefno.value+
	"&txtvendorinvoiceno="+txtvendorinvoiceno.value+
	"&itemDetails="+itemString;
	
	
	
	
	
		  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		      var arr=this.responseText.split("~");
		      alert(arr[0]+ " Invoice Saved Succesfully " + arr[1]);
		      
		    
		      if(typeof chkgeneratePDF !='undefined' && chkgeneratePDF.checked==true)
	    		{
		      		
		    	  	generatePdfPurchaseInvoice(arr[1]);
	    			
	    			
	    		}
		      
		      
		      
		      
		      window.location="?a=showInvoices&type=P";

		    }
		  };
		  xhttp.open("POST", "?a=savePurchaseInvoice", true);
		  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		  //alert(reqString);
		  xhttp.send(encodeURI(reqString));
		  
		

	
	
	
	
	
	
	
	
}
function savedInvoiceCallback(data1)
{
		console.log(data1);
}


function updateItem()
{
	
	document.getElementById("frm").action="?a=updateItem"; 
	document.getElementById("frm").submit();
	return;
	
	
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


<div class="container" style="padding:20px;background-color:white;margin-top:5px;max-width:100%"> 

<form id="frm" action="?a=addCategory" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="row">
<datalist id="customerList">

<c:forEach items="${vendorMaster}" var="vendor">
			    <option id="${vendor.vendor_id}">${vendor.vendor_name}~${vendor.mobile_number}~${vendor.address}</option>			    
	   </c:forEach>	   	 

  	
</datalist>

<datalist id="itemList">
<c:forEach items="${itemList}" var="item">
			    <option id="${item.item_id}">${item.item_name}-${item.product_code}-${item.size}-${item.color}</option>
			    <input type="hidden" id="hdn${item.item_id}" value="${item.item_name}~${item.price}~${item.gst}~${item.size}~${item.color}~${item.product_code}~${item.availableQty}">			    
	   </c:forEach>	   	   	
</datalist>


<div class="col-sm-3">
  	<div class="form-group">
  	
  	
  	
  	
  	<div class="input-group input-group-sm">
                  <input type="text" class="form-control form-control-sm" id="txtsearchcustomer"    placeholder="Search For Vendor" name="txtsearchtxtsearchcustomer"  list='customerList' oninput="checkforMatchCustomer()">
                  
                  <span class="input-group-append">
                    <button type="button" class="btn btn-danger btn-flat" onclick="resetCustomer()">Reset</button>
                  </span>
                  
                  <span class="input-group-append">
                    <button type="button" class="btn btn-primary btn-flat" onclick="addCustomer()">Add</button>
                  </span>
    </div>
  	
  	
        	      
      
            
      <input  type="hidden" name="hdnSelectedCustomer" id="hdnSelectedCustomer" value="">
   			<input  type="hidden" name="hdnSelectedCustomerType" id="hdnSelectedCustomerType" value="">
   			<input  type="hidden" name="hdnPreviousInvoiceId" id="hdnPreviousInvoiceId" value="">
   			      
    </div>
  </div>
  
  <div class="col-sm-1">
  	<div class="form-group" align="center"> 	
  		<label>Due </label>  		
  	</div>
  </div>
   <div class="col-sm-1">
  	<div class="form-group"> 	
  		<input type="text" id="txtcustomerpendingamount" name="txtcustomerpendingamount" class="form-control form-control-sm" value="0" readonly/>  		
  	</div>
  </div>

 <div class="col-sm-1">
  	<div class="form-group" align="center"> 	
  		<label>Sales Date</label>  		
  	</div>
  </div>
  <div class="col-sm-2">
  	<div class="form-group">	
  		<input type="text" id="txtinvoicedate" name="txtinvoicedate" class="form-control form-control-sm" value="${todaysDate}" placeholder="Invoice Date" readonly/>
  	</div>
  </div>
  
  
  
  
  <div class="col-sm-4">    
    <div class="input-group">
    <input type="text" class="form-control form-control-sm"    placeholder="Search for Items" list="itemList" id="txtitem" name="txtitem" oninput="checkforMatchItem()">
    <div class="input-group-append">
      <button class="btn btn-secondary btn-sm" type="button" >
        <i class="fa fa-search fa-sm" ></i>
      </button>
    </div>
  </div>
  </div>
  
  
  
  
  
  
  <div class="col-sm-3">
    <div class="form-group">
      <label for="email">Vendor Name</label>      
      <input type='text' readonly id="txtclientname" name="txtclientname" onkeypress="digitsOnly(event)" onkeyup="calculateTotal()" class='form-control form-control-sm'>
    </div>
  </div>
  
  <div class="col-sm-5">
    <div class="form-group">
      <label for="email">Address</label>      
      <input type='text' readonly id="txtaddress" name="txtaddress" onkeypress="digitsOnly(event)" onkeyup="calculateTotal()" class='form-control form-control-sm'>
    </div>
  </div>
  
  
  <div class="col-sm-2">
    <div class="form-group">
      <label for="email">Tally Reference No</label>      
      <input type='text' id="txttallyrefno" name="txttallyrefno" onkeypress="digitsOnly(event)" onkeyup="calculateTotal()" class='form-control form-control-sm'>
    </div>
  </div>
  
   <div class="col-sm-2">
    <div class="form-group">
      <label for="email">Vendor Invoice No</label>      
      <input type='text' id="txtvendorinvoiceno" name="txtvendorinvoiceno"  onkeyup="calculateTotal()" class='form-control form-control-sm'>
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
	  			<th style="z-index:0">Purchase Rate</th>
	  			<th style="z-index:0">SGST / CGST </th>	  			
	  			
	  			<th style="z-index:0">Item Amount</th>
	  			<th></th>
	                    </tr>
	                  </thead>
	                </table>
	   </div>	
  </div>
  
  <div class="col-sm-12">  
	  <div class="card-body table-responsive p-0">                
	                <table id="tblTotalItems"class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                  <thead>	                   
	                  
	                  	                  	                  
	                  
	                  
	                    <tr>
	                        <th colspan="2" class="text-right">Total Quantity : <span id="totalQty">0</span></th>
	                        
	                        <th colspan="2"class="text-right">Gross Amount : <span id="grossAmount">0</span></th>
	                        <th colspan="2"class="text-right">GST Amount : <span id="totalGstAmount">0</span></th>
	                        
	                        <th colspan="2"class="text-right">Total Amount : <span id="totalAmount">0</span></th>
	                        
	                        	  	
	                         
	  			
	  			
	  					
	  			
	  			
	  			<th ></th>
	  			<th ></th>	  			
	                    </tr>
	                    <tr>
	                        
	                        
	                                          
	                        
	      
	                        
	                        
	                        
                        
	                        
		                      
	                        </th>
	                
	                 
	  			
	  					
	  			
	  			<td colspan="12"><input type="text" id="txtremarks" name="txtremarks" class="form-control form-control-sm" placeholder="Remarks"></td>	
	                    </tr>
	                    
	                  </thead>
	                </table>
	   </div>	
  </div>
  
   
  
  <c:if test="${invoiceDetails.invoice_id eq null}">
	   	
   <div class="col-sm-12">
  	 <div class="form-group" align="center">	  
	   <input type="checkbox" class="form-check-input" id="chkgeneratePDF">
    	<label class="form-check-label" for="chkgeneratePDF">Generate PDF</label>
   </div>
   </div>
   	
	   </c:if>
	   
	   
	    <div class="col-sm-12">
  	 <div class="form-group" align="center">	  
	   <label for="email">Upload Attachment</label>
      	<input type="file" name="file" multiple/>    	
   </div>
   </div>
  
  
 <div class="col-sm-12">
  	 <div class="form-group" align="center">	  
	   	<button class="btn btn-success" id="btnsave" type="button" onclick='saveInvoice()'>Save</button>   
	   <button class="btn btn-danger" type="reset" onclick='window.location="?a=showHomePage"'>Cancel</button>
	   <button class="btn btn-primary" id="btnRegister" type="reset" onclick='window.open("?a=showInvoices&type=P&txtfromdate=${todaysDate}&txttodate=${todaysDate}&txtfirm=${userdetails.firm_id}")'>Register</button>
	   
	  	   
	   <button class="btn btn-primary" style="display:none" id="generatePDF" type="button" onclick='generateInvoice(${invoiceDetails.invoice_id});'>Generate PDF</button>
   </div>
   </div>
  
</div>
</form>





<script type="javascript">

function generateInvoice(invoiceId)
{
	
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	    	window.open("BufferedImagesFolder/"+xhttp.responseText);		  
		}
	  };
	  xhttp.open("GET","?a=generateInvoicePDF&invoiceId="+invoiceId, false);    
	  xhttp.send();
}
function searchForCustomer(searchString)
{	
	//if(searchString.length<3){return;}

	document.getElementById("closebutton").style.display='none';
	   document.getElementById("loader").style.display='block';
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	    	var cusomerList=JSON.parse(xhttp.responseText);
	    	var reqString="";
	    	for(var x=0;x<cusomerList.length;x++)
	    	{
	    		//console.log(cusomerList[x]);
	    		reqString+="<option id="+cusomerList[x].customer_id+">"+cusomerList[x].customer_name+"~"+cusomerList[x].mobile_number+"~"+cusomerList[x].customer_type+"</option>";
	    	}
	    	
	    	document.getElementById('customerList').innerHTML=reqString;
		}
	  };
	  xhttp.open("GET","?a=searchForCustomer&searchString="+searchString, true);    
	  xhttp.send();
	
	 
	
}

function checkforMatchCustomer()
{
	
	var searchString= document.getElementById("txtsearchcustomer").value;	
	var options1=document.getElementById("customerList").options;
	var customerId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
					customerId=options1[x].id;
					txtitem.focus();
					break;
				}
		}
	if(customerId!=0)
		{
			document.getElementById("hdnSelectedCustomer").value=customerId;			
			document.getElementById("txtsearchcustomer").disabled=true;			
			document.getElementById("hdnSelectedCustomerType").value=document.getElementById("txtsearchcustomer").value.split("~")[2];
			fetchPendingAmountForThisCustomer(customerId);
			
			var ClientDetails=document.getElementById("txtsearchcustomer").value.split("~");
			
			txtclientname.value=ClientDetails[0];
			txtaddress.value=ClientDetails[2];			
		}
	else
		{
			//searchForCustomer(searchString);
		}
	
	
	
}


function fetchPendingAmountForThisCustomer(customerId)
{
	document.getElementById("closebutton").style.display='none';
	   document.getElementById("loader").style.display='block';
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	    	var details=JSON.parse(xhttp.responseText);	    	
	    	if(details.pendingAmountDetails.PendingAmount!=undefined)
	    		{
	    			txtcustomerpendingamount.value=details.pendingAmountDetails.PendingAmount;
	    		}
	    	else
	    		{
					//alert("no pending amount for this customer");
	    			//window.location.reload();
	    		}
		}
	  };
	  xhttp.open("GET","?a=getPendingAmountForCustomer&customerId="+customerId, true);    
	  xhttp.send();
}


function checkforMatchItem()
{
	var searchString= document.getElementById("txtitem").value;	
	var options1=document.getElementById("itemList").options;
	
	var itemId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
				itemId=options1[x].id;
				
					break;
				}
		}
	if(itemId!=0)
		{			
				
				
				var total=0;
				var rows=tblitems.rows;
				for(var x=1;x<rows.length;x++)
					{							
						if(itemId==rows[x].childNodes[0].childNodes[1].value)
							{
								alert('item already exist in selection');
								document.getElementById("txtitem").value="";
								return;
							}
					}
				
				// code to check if item already exist inselection				
				getItemDetailsAndAddToTable(itemId);
				document.getElementById("txtitem").value="";
		}
	
}


function getItemDetailsAndAddToTable(itemId)
{
		      
	
	

		
		
		
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 	
			    	
		    	//alert(xhttp.responseText);
		    	var itemDetails=JSON.parse(xhttp.responseText);
		    	console.log(itemDetails);
		    	
		    	
		    	var table = document.getElementById("tblitems");	    	
		    	var row = table.insertRow(-1);	    	
		    	var cell1 = row.insertCell(0);
		    	var cell2 = row.insertCell(1);
		    	var cell3 = row.insertCell(2);
		    	
		    	var cell4 = row.insertCell(3);
		    	var cell5 = row.insertCell(4);
		    	var cell6 = row.insertCell(5);
		    	var cell7 = row.insertCell(6);
		    	var cell8 = row.insertCell(7);
		    	var cell9 = row.insertCell(8);
		    	
		    	
		    	
		    	
		    	
		    	
		    	cell1.innerHTML = "<div>"+Number(table.rows.length-1)+"</div>" +"<input name='itemidgroup' type='hidden' value='"+itemId+"'>";
		    	cell2.innerHTML = "<a onclick=window.open('?a=showItemHistory&itemId="+itemId+"') href='#'>"+ itemDetails.item_name + "-"+ itemDetails.product_code + "-"+ itemDetails.color + "-"+ itemDetails.size + "-"+ itemDetails.stockAvailable + "</a>";
		    	
		    	
		    	cell3.innerHTML = " <input type='text' class='form-control form-control-sm'  name='txtqtygroup' id='txtqty"+itemId+"' onkeyup='calculateAmount("+itemId+");' onkeypress='digitsOnlyWithDot(event);' value='1'> <input type='hidden' class='form-control form-control-sm'  readonly id='hdnavailableqty"+itemId+"' value="+itemDetails.stockAvailable+">";   	
					
		    	
		    	cell4.innerHTML = "<input type='text' class='form-control form-control-sm' name='txtpricesgroup' id='txtprice"+itemDetails.item_id+"'   onkeyup='calculateAmount("+itemId+");' onkeypress='digitsOnlyWithDot(event);calculateAmount("+itemId+");' value='"+itemDetails.price+"' >";
		    	
		    	var sgstAmount=Number(itemDetails.sgst) * Number(itemDetails.price) / 100 ;
		    	var cgstAmount=Number(itemDetails.cgst) * Number(itemDetails.price) / 100 ;
		    	
		    	cell5.innerHTML = "<div class='input-group'>  <input type='text' readonly class='form-control form-control-sm' name='txtsgstamountgroup' id='txtsgstamount"+itemId+"' value='"+sgstAmount+"'   style='width:25%'>      <input type='text' style='width:25%' class='form-control form-control-sm' onkeyup='calculateAmount("+itemId+")' id='txtsgstpercent"+itemId+"' value='"+itemDetails.sgst+"'> <input type='text' readonly class='form-control form-control-sm' name='txtcgstamountgroup' id='txtcgstamount"+itemId+"' value='"+sgstAmount+"'   style='width:25%'>      <input type='text' style='width:25%' class='form-control form-control-sm' onkeyup='calculateAmount("+itemId+")' id='txtcgstpercent"+itemId+"' value='"+itemDetails.cgst+"'></div>";
//		    	cell5.innerHTML += "<div class='input-group'>  <input type='text' readonly class='form-control form-control-sm' name='txtcgstamountgroup' id='txtcgstamount"+itemId+"' value='"+sgstAmount+"'   style='width:25%'>      <input type='text' style='width:25%' class='form-control form-control-sm' onkeyup='calculateAmount("+itemId+")' id='txtcgstpercent"+itemId+"' value='"+itemDetails.cgst+"'></div>";
		    	
		    	
		    	
		    	cell6.innerHTML = "<input type='text' readonly class='form-control form-control-sm' value='0' id='totalAmount"+itemId+"'  name='txttotalamountgroup' >";   	
		    	cell7.innerHTML = '<button type="button" class="btn btn-sm btn-danger"  onclick=removethisitem(this) id="btn11" style="cursor:pointer">Delete</button>';
		    	
		    	
		    	calculateAmount(itemId);
		    	document.getElementById("txtqty"+itemId).select();
		    	document.getElementById("txtqty"+itemId).focus();
		    	
		    	
		    	
			}
		  };
		  xhttp.open("GET","?a=getItemDetailsByAjax&itemId="+itemId, true);    
		  xhttp.send();	
		
		
		
	
	    	
	    	//console.log(itemDetails);
	    
	    	
			
}



function calculateAmount(itemId)
{
	var price=document.getElementById('txtprice'+itemId).value;	
	var qty=document.getElementById('txtqty'+itemId).value;
	
	var sgstpercent=document.getElementById('txtsgstpercent'+itemId).value;
	var sgstAmount=Number(price)*Number(qty)* Number(sgstpercent) /100;
	
	var cgstpercent=document.getElementById('txtcgstpercent'+itemId).value;
	var cgstAmount=Number(price)*Number(qty)* Number(cgstpercent) /100;
	
	gstAmount=cgstAmount+sgstAmount;
	
	document.getElementById('txtsgstamount'+itemId).value=sgstAmount;
	document.getElementById('txtcgstamount'+itemId).value=cgstAmount;
	
	document.getElementById('totalAmount'+itemId).value=(Number(price) *Number(qty) +gstAmount).toFixed(2);
	
	
	
	
	
	calculateTotal();
}



function calculateTotal()
{	
		var total=0;
		var totalQtyCalculated=0;
		var totalDiscountCalculated=0;
		var grossAmountCalculated=0;
		var sgstAmountCalculated=0;
		var cgstAmountCalculated=0;
		
		
		
		
		
		var quantityTextboxes=document.getElementsByName('txtqtygroup');
		var pricesTextboxes=document.getElementsByName('txtpricesgroup');
		
		 
		var sgstTextboxes=document.getElementsByName('txtsgstamountgroup');
		var cgstTextboxes=document.getElementsByName('txtcgstamountgroup');
		
		var totalAmountTextboxes=document.getElementsByName('txttotalamountgroup');
		
		
		var rows=tblitems.rows;
		for(var x=0;x<rows.length-1;x++)
			{
				var itemTotalAmount=totalAmountTextboxes[x].value;
				total+=Number(itemTotalAmount);
				
				var itemQty=quantityTextboxes[x].value;
				totalQtyCalculated+=Number(itemQty);
				
				var rate=pricesTextboxes[x].value;
				var grossItemAmount=itemQty*rate;
				
				var sgstAmountTemp=sgstTextboxes[x].value;
				sgstAmountCalculated+=Number(sgstAmountTemp);
				
				
				var cgstAmountTemp=cgstTextboxes[x].value;
				cgstAmountCalculated+=Number(cgstAmountTemp);
				
				
				grossAmountCalculated+=grossItemAmount;
			}
		
		//totalQty		
		total=Number(total);
		totalAmount.innerHTML=Number(total).toFixed(2);
		totalQty.innerHTML=Number(totalQtyCalculated).toFixed(2);		
		grossAmount.innerHTML=Number(grossAmountCalculated).toFixed(2);		
		totalGstAmount.innerHTML=Number(sgstAmountCalculated+cgstAmountCalculated).toFixed(2);
		
		
			
}

function removethisitem(btn1)
{
	btn1.parentElement.parentElement.remove();
	//reshuffle id's next to this
	
	reshuffleSrNos();
	
	calculateTotal(); 
}

function reshuffleSrNos()
{
	var rows1=tblitems.rows;
	for(var x=1;x<rows1.length;x++)
		{
			rows1[x].childNodes[0].childNodes[0].innerHTML=x;
		}
}

document.getElementById("divTitle").innerHTML="Generate Purchase Invoice:- "+"${tentativeSerialNo}";

document.title +=" Generate Purchase Invoice:- "+ " ${tentativeSerialNo} ";


$( "#txtinvoicedate" ).datepicker({ dateFormat: 'dd/mm/yy' });
if('${invoiceDetails.invoice_id}'!='')
	{
		
	var elems = document.getElementsByTagName('input');
	var len = elems.length;

	for (var i = 0; i < len; i++) 
	{
	    elems[i].disabled = true;
	}
		

		document.getElementById("divTitle").innerHTML="Invoice No:-"+"${invoiceDetails.invoice_no}";
		document.title +=" Invoice No:- "+ " ${invoiceDetails.invoice_no} "
		hdnSelectedCustomer.value="${invoiceDetails.customer_id}"
		
			
		if('${invoiceDetails.customer_name}'!='')
			{
				txtsearchcustomer.value="${invoiceDetails.customer_name}~${invoiceDetails.mobile_number}";
				txtclientname.value="${invoiceDetails.customer_name}";
				txtaddress.value="${invoiceDetails.customer_address}";
			}
		
		
		txttallyrefno.value="${invoiceDetails.tally_ref_no}";
		txtvendorinvoiceno.value="${invoiceDetails.vendor_invoice_no}";
		
		
		
		document.getElementById("hdnSelectedCustomerType").value='${invoiceDetails.customer_type}';
		txtinvoicedate.value="${invoiceDetails.invoice_date}";
		
		totalQty.innerHTML="${invoiceDetails.totalQuantities}";
		grossAmount.innerHTML="${invoiceDetails.gross_amount}";
		gstAmount.innerHTML="${invoiceDetails.total_gst}";

		
		
		
		totalAmount.innerHTML="${invoiceDetails.total_amount}";
		
		txtremarks.value='${invoiceDetails.remarks}';
		
		
		
		
		
		var m=0;
		var tableNo="";
		<c:forEach items="${invoiceDetails.listOfItems}" var="item">
		
		m++;
		tableNo='${item.table_no}';
		var table = document.getElementById("tblitems");	    	
    	var row = table.insertRow(-1);	    	
    	var cell1 = row.insertCell(0);
    	var cell2 = row.insertCell(1);
    	var cell3 = row.insertCell(2);
    	var cell4 = row.insertCell(3);
    	var cell5 = row.insertCell(4);
    	var cell6 = row.insertCell(5);
    	var cell7 = row.insertCell(6);
    	var cell8 = row.insertCell(7);
    	var cell9 = row.insertCell(8);
    	
    	
    	
    	cell1.innerHTML = '<div>'+m+'</div><input type="hidden" value="${item.item_id}">';    	
    	cell2.innerHTML = '${item.item_name}';    	
    	cell3.innerHTML = '${item.job_sheet_no}';
    	cell4.innerHTML = '${item.qty}';
    	cell5.innerHTML = '${item.rate}';
    	cell6.innerHTML = '<div class="input-group"><input type="text" readonly="" class="form-control form-control-sm" name="txtgstamountgroup" id="txtgstamount895" value="${item.gst_amount}" style="width:50%"><input type="text" style="width:50%" class="form-control form-control-sm" onkeyup="calculateAmount(895)" id="txtgstpercent895" value="${item.gst_percentage}"></div>';
    	
    	
    	
    	cell7.innerHTML = '${item.item_amount}';	
    	cell8.innerHTML = '<button type="button" class="btn btn-sm btn-danger"  onclick=removethisitem(this) id="btn11" name="deleteButtons" style="cursor:pointer">Delete</button> <button type="button" class="btn btn-primary"  onclick=returnThisItem("${item.details_id}") name="returnButtons" id="btn11" style="cursor:pointer">Return (${item.ReturnedQty})</button>';
    	
		
	    		//alert('${item.item_id}'+'-${item.item_name}'+'-${item.qty}'+'-${item.rate}'+'-${item.custom_rate}');			    
		</c:forEach>
 
		
		if('${param.editInvoice}'=='Y')
			{
				hdnPreviousInvoiceId.value="${invoiceDetails.invoice_id}";
				var returnButtons=document.getElementsByName('returnButtons');
				for(var m=0;m<returnButtons.length;m++)
					{
						returnButtons[m].style="display:none";
					}
				txtsearchcustomer.disabled=true;
				txtinvoicedate.disabled=true;
				document.getElementById("divTitle").innerHTML="Edit Invoice:-"+"${invoiceDetails.invoice_no}";
				document.title +=" Edit Invoice:- " + " ${invoiceDetails.invoice_no} ";
			}
		else
			{
				$("#frm :input").prop('disabled', true);
				$("[name=returnButtons]").prop('disabled', false);
				
				
				var deleteButtons=document.getElementsByName('deleteButtons');
				for(var m=0;m<deleteButtons.length;m++)
					{
						deleteButtons[m].style="display:none";
					}
			}
		
		if('${param.table_id}'!='')
			{
				calculateTotal();
				txtpaymenttype.value='Paid';
				drppaymentmode.value='Cash';
				txtsearchcustomer.disabled=false;
				txtinvoicedate.disabled=false;
				document.getElementById("divTitle").innerHTML="Invoice For Table No:-"+tableNo;
				document.title +=" Invoice For Table No:- " +tableNo ;
				txtinvoicediscount.value=0;
			}
		
		if('${param.booking_id}'!='')
		{
			calculateTotal();
			txtpaymenttype.value='Paid';
			drppaymentmode.value='Cash';
			txtsearchcustomer.disabled=true;
			txtinvoicedate.disabled=false;
			document.getElementById("divTitle").innerHTML="Invoice For Booking Id - ${param.booking_id}";
			document.title +=" Invoice For Booking Id - ${param.booking_id} ";
			txtinvoicediscount.value=0;
		}
		
		document.getElementById("generatePDF").style="display:";
		generatePDF.disabled=false;
		btnRegister.disabled=false;
		
	}
	
	
function returnThisItem(detailsId)
{
		window.location="?a=showReturnScreen&detailsId="+detailsId;
}
function resetCustomer()
{
	window.location.reload();
	txtsearchcustomer.disabled=false;
	txtsearchcustomer.value="";
	hdnSelectedCustomer.value=0;	
}

function addCustomer()
{
	window.open("?a=showAddVendor&mobileNo="+txtsearchcustomer.value);	
}







function showThisItemIntoSelection(itemId)
{
	
	getItemDetailsAndAddToTable(itemId);
	document.getElementById("responseText").innerHTML="";
	$("#myModal").modal('hide');
}
function freezeWareHouse()
{
	return;

		if(drpwarehouse.value!=-1)
			{
				drpwarehouse.disabled=true;
			}
}

function validateQtyAgainstWareHouse(itemId)
{
	if(Number(document.getElementById("txtqty"+itemId).value)>Number(document.getElementById("hdnavailableqty"+itemId).value))
		{
			alert('Entered Quantity Should be less than or equal to available Quantity');
			document.getElementById("txtqty"+itemId).value="0";
			return;
		}
}


if('${param.challanId}'!='')
{
	document.getElementById("hdnSelectedCustomer").value='${challanDetails.customer_id}';
	txtclientname.value='${challanDetails.customer_name}';
	txtaddress.value='${challanDetails.customer_address}';
	<c:forEach items="${challanDetails.listOfItems}" var="item">
	
	
	
	var table = document.getElementById("tblitems");	    	
	var row = table.insertRow(-1);	    	
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	var cell6 = row.insertCell(5);
	var cell7 = row.insertCell(6);
	var cell8 = row.insertCell(7);
	var cell9 = row.insertCell(8);
	
	
	
	
	
	
	cell1.innerHTML = "<div>S"+Number(table.rows.length-1)+"</div><input name='itemidgroup' type='hidden' value='${item.item_id}'/>";
	cell2.innerHTML = "<a onclick=window.open('?a=showItemHistory&itemId=${item.item_id}') href='#'>${item.item_name}-${item.product_code}-${item.color}-${item.size}-${item.stockAvailable}</a>";
	cell3.innerHTML = "${item.ware_house_name}<input type='hidden' name='warehousegroup' value='${item.ware_house_id}' id='hdnwarehouse${item.item_id}'>";
	cell4.innerHTML = '<input type="text" class="form-control form-control-sm" name="txtjobheetgroup" id="txtjobsheetno${item.item_id}">';
	cell5.innerHTML = " <input type='text' class='form-control form-control-sm'  name='txtqtygroup' id='txtqty${item.item_id}' value='${item.qty}'> ";   	
	
	cell6.innerHTML = "<input type='text' class='form-control form-control-sm' name='txtpricesgroup' id='txtprice${item.item_id}'   onkeyup='calculateAmount(${item.item_id});' onkeypress='digitsOnlyWithDot(event);calculateAmount(${item.item_id});' value='${item.price}' >";
	
	var gstAmount=Number('${item.gst}') * Number('${item.price}') / 100 ;
	
	cell7.innerHTML = "<div class='input-group'>  <input type='text' readonly class='form-control form-control-sm'  name='txtgstamountgroup' id='txtgstamount${item.item_id}' value='0'   style='width:50%'>      <input type='text' style='width:50%' class='form-control form-control-sm' onkeyup='calculateAmount(${item.item_id})' id='txtgstpercent${item.item_id}' value='${item.gst}'></div>";
	cell8.innerHTML = "<input type='text' readonly class='form-control form-control-sm' value='0' id='totalAmount${item.item_id}'  name='txttotalamountgroup' >";   	
	cell9.innerHTML = '<button type="button" class="btn btn-sm btn-danger"  onclick=removethisitem(this) id="btn11" style="cursor:pointer">Delete</button>';
	
	calculateAmount(${item.item_id});
			    
	</c:forEach>
	
	
}


function generatePdfPurchaseInvoice(invoiceId)
{
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() 
	  {
	    if (xhttp.readyState == 4 && xhttp.status == 200) 
	    { 		      
	    	window.open("BufferedImagesFolder/"+xhttp.responseText);		  
		}
	  };
	  xhttp.open("GET","?a=generateInvoicePDF&invoiceId="+invoiceId+"&type=P", false);    
	  xhttp.send();
}



</script>