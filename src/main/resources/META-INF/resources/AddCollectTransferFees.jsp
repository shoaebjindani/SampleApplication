  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           


<c:set var="flatDetails" value='${requestScope["outputObject"].get("flatDetails")}' />
<c:set var="listOfFlats" value='${requestScope["outputObject"].get("listOfFlats")}' />
<c:set var="listOfShops" value='${requestScope["outputObject"].get("listOfShops")}' />

<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="ReceiptNo" value='${requestScope["outputObject"].get("ReceiptNo")}' />
<c:set var="PersonList" value='${requestScope["outputObject"].get("PersonList")}' />
<c:set var="firstAndLastDates" value='${requestScope["outputObject"].get("firstAndLastDates")}' />
<c:set var="listOfPersons" value='${requestScope["outputObject"].get("PersonList")}' />



</head>


<script >




function resetFlat()
{	
	txtflatname.disabled=false;
	txtflatname.value="";
	hdnselectedflat.value=0;	
}

function resetShop()
{	
	txtshopname.disabled=false;
	txtshopname.value="";
	hdnselectedshop.value=0;	
}
function addCategory()
{	
	
	
	document.getElementById("frm").submit(); 
}
window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		 addCategory();
	} 
	});
function checkforMatchFlat()
{
	var searchString= document.getElementById("txtflatname").value;
	
	var options1=document.getElementById("listOfFlat").options;
	var flatId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
					flatId=options1[x].id;
					break;
				}
		}
	if(flatId!=0)
		{
			document.getElementById("hdnselectedflat").value=flatId;			
			document.getElementById("txtflatname").disabled=true;						
		}
	else
		{
			//searchForCustomer(searchString);
		}
	
	
}
function checkforMatchShop()
{
	var searchString= document.getElementById("txtshopname").value;
	
	var options1=document.getElementById("listOfShop").options;
	var shopId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
					shopId=options1[x].id;
					break;
				}
		}
	if(shopId!=0)
		{
			document.getElementById("hdnselectedshop").value=shopId;			
			document.getElementById("txtshopname").disabled=true;						
		}
	else
		{
			//searchForCustomer(searchString);
		}
		
	
	
}

function searchForPerson(searchString)
{	
	console.log(5);
	if(searchString.length<3){return;}

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
	    		reqString+="<option id="+personList[x].person_id+">"+personList[x].person_name+"-"+personList[x].person_mobile_no+"</option>";
	    	}
	    	
	    	document.getElementById('personList').innerHTML=reqString;
		}
	  };
	  xhttp.open("GET","?a=searchForPerson&searchString="+searchString, true);    
	  xhttp.send();
	
	 
	
}
window.addEventListener('keydown', function (e) {
	if(event.which==113)
	{
		 addCategory();
	} 
	});

function resetPerson()
{
	txtsearchperson.disabled=false;
	txtsearchperson.value="";
	hdnSelectedPerson.value=0;
}

function checkforFromOwnerMatchPerson()
{
	var searchString= document.getElementById("txtfromperson").value;
	
	var options1=document.getElementById("listOfPerson").options;
	var personId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
					personId=options1[x].id;
					break;
				}
		}
	if(personId!=0)
		{
			document.getElementById("hdnselectedfromowner").value=personId;
			document.getElementById("txtfromperson").disabled=true;						
		}
	else
		{
			//searchForCustomer(searchString);
		}
	
	
}


function checkforToOwnerMatchPerson()
{
	var searchString= document.getElementById("txttoperson").value;
	
	var options1=document.getElementById("listOfPerson").options;
	var personId=0;
	for(var x=0;x<options1.length;x++)
		{
			if(searchString==options1[x].value)
				{
					personId=options1[x].id;
					break;
				}
		}
	if(personId!=0)
		{
			document.getElementById("hdnselectedtoowner").value=personId;
			document.getElementById("txttoperson").disabled=true;						
		}
	else
		{
			//searchForCustomer(searchString);
		}
	
	
}

function changePropertyType()
{
	if(drppropertytype.value=="Shop")
	{
		shopview.style.display="block";
		flatview.style.display="none";
	}
	else
	{
		shopview.style.display="none";
		flatview.style.display="block";
	}
}


$( "#txttransferdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txtpaymentdate" ).datepicker({ dateFormat: 'dd/mm/yy' });







</script>



<br>

<div class="container" style="padding:20px;background-color:white">
<form id="frm" action="?a=addTransferFees" method="post" enctype="multipart/form-data" accept-charset="UTF-8">

<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">
  
  
  


<datalist id="listOfPerson">
<c:forEach items="${listOfPersons}" var="cat">
 	<option id="${cat.personId}">${cat.personName}</option>	
	 </c:forEach>
</datalist>

<datalist id="listOfFlat">
<c:forEach items="${listOfFlats}" var="cat">
	<option id="${cat.flat_id}">${cat.block_name} ${cat.flat_name} (${cat.person_name})~(${cat.type})</option>	
 </c:forEach>
</datalist>
<datalist id="listOfShop">
<c:forEach items="${listOfShops}" var="cat">
				<option id="${cat.shop_id}">${cat.shop_name}</option>	
 </c:forEach>
</datalist>


<div class="col-sm-12">
		<div class="form-group">
			<label for="email">Receipt No </label>     
			<input type="text" readonly class="form-control" value="${ReceiptNo}">
		</div>
	</div>


<div class="col-sm-12">
		<div class="form-group">
			<label for="email">Property Type</label>     
			<select class="form-control" name="drppropertytype" id="drppropertytype" onchange="changePropertyType()">
			<option>Shop</option>
			<option selected>Flat</option>
			</select>
		</div>
	</div>



	
  <div class="col-sm-12" id="flatview">
	<div class="form-group">
		
	<label for="email">Flat Name </label>     
	<div class="input-group input-group-sm">
    
	<input type="textbox" name="txtflatname" id="txtflatname" class="form-control form-control-sm" list="listOfFlat" onchange="checkforMatchFlat()"/> 
	<input type="hidden" name="hdnselectedflat"  value="" id="hdnselectedflat">  <span class="input-group-append">
		<button type="button" class="btn btn-danger btn-flat" onclick="resetFlat()">Reset</button>
		</span>
	</div>
	</div>
		
</div>

	

	
  <div class="col-sm-12" id="shopview">
	<div class="form-group">
		
	<label for="email">Shop Name </label>     
	<div class="input-group input-group-sm">
    
	<input type="textbox" name="txtshopname" id="txtshopname" class="form-control form-control-sm" list="listOfShop" onchange="checkforMatchShop()"/> 
	<input type="hidden" name="hdnselectedshop"  value="" id="hdnselectedshop">  <span class="input-group-append">
		<button type="button" class="btn btn-danger btn-flat" onclick="resetShop()">Reset</button>
		</span>
	</div>
	</div>
		</div>


  <div class="col-sm-12">
	<div class="form-group">
	<label for="email">From Owner </label> 
	<div class="input-group input-group-sm">    
	<input type="textbox" class="form-control form-control-sm" list="listOfPerson" name="txtfromperson" id="txtfromperson" onchange="checkforFromOwnerMatchPerson()"/>
	<input type="hidden" name="hdnselectedfromowner" id="hdnselectedfromowner" value=""><span class="input-group-append">
		<button type="button" class="btn btn-danger btn-flat" onclick="resetPerson()">Reset</button>
		</span>
		
	 	</div>
	</div>
	</div>
		 
    
  <div class="col-sm-12">
	<div class="form-group">
	<label for="email">To Owner </label> 
	<div class="input-group input-group-sm">    
	<input type="textbox" class="form-control form-control-sm" list="listOfPerson" name="txttoperson" id="txttoperson" onchange="checkforToOwnerMatchPerson()"/>
	<input type="hidden" name="hdnselectedtoowner" id="hdnselectedtoowner" value=""><span class="input-group-append">
		<button type="button" class="btn btn-danger btn-flat" onclick="resetPerson()">Reset</button>
		</span>
		
	 	</div>
	</div>
	
</div>


  
  	 <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Transfer Date</label>
      <input type="text" class="form-control form-control-sm" id="txttransferdate" readonly value="${todaysDate}"   name="txttransferdate">     
    </div>
  </div>
  
   <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Payment Date</label>
            <input type="text" class="form-control" id="txtpaymentdate" readonly value="${todaysDate}"  name="txtpaymentdate">
    </div>
  </div>
  

  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Payment Mode</label>
	  <select name="drppaymentmode" class="form-control">
	  <option>Cash</option>
	  <option>Cheque</option>
	  <option selected>Bank Transfer</option>	  
	  </select>      
    </div>
  </div>

  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Amount</label>
      <input type="tel" class="form-control form-control-sm" id="txtamount"  placeholder="Amount" name="txtamount" onkeypress="digitsOnly(event)" >
      
    </div>
  </div>

  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Reference No</label>
      <input type="tel" class="form-control form-control-sm" id="txtreferenceno"  placeholder="Ref No" name="txtreferenceno" >      
    </div>
  </div>

  <div class="col-sm-12">
  	<div class="form-group">
      <label for="email">Remarks</label>
      <input type="tel" class="form-control form-control-sm" id="txtremarks"  placeholder="Remarks" name="txtremarks" >      
    </div>
  </div>
  
    

 <div class="col-sm-12" align="center">
		<button class="btn btn-success" type="button" onclick='addCategory()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>
	</div>
		


		
		
		
		
</div>
</form>

<script >


document.getElementById("divTitle").innerHTML="Collect Transfer Fees";

changePropertyType();
txtflatname.focus();


$( "#txttransferdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txtpaymentdate" ).datepicker({ dateFormat: 'dd/mm/yy' });


</script>



