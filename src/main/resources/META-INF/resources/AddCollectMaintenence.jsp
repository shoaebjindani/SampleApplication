<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





<c:set var="flatDetails" value='${requestScope["outputObject"].get("flatDetails")}' />
<c:set var="listOfFlats" value='${requestScope["outputObject"].get("listOfFlats")}' />
<c:set var="listOfShops" value='${requestScope["outputObject"].get("listOfShops")}' />

<c:set var="listOfPersons" value='${requestScope["outputObject"].get("PersonList")}' />
<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="ReceiptNo" value='${requestScope["outputObject"].get("ReceiptNo")}' />
<c:set var="PersonList" value='${requestScope["outputObject"].get("PersonList")}' />
<c:set var="firstAndLastDates" value='${requestScope["outputObject"].get("firstAndLastDates")}' />







</head>



<script>
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
	
	getAmountForThisProperty();
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
		//getAmountForThisProperty();
	
	
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


</script>



<br>


<div class="container" style="padding:20px;background-color:white">

<form id="frm" action="?a=addMaintenence" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<input type="hidden" name="app_id" value="${userdetails.app_id}">
<input type="hidden" name="user_id" value="${userdetails.user_id}">
<input type="hidden" name="callerUrl" id="callerUrl" value="">


<datalist id="personList">
<c:forEach items="${PersonList}" var="person">
			    <option id="${person.personId}" >${person.personName}~(${person.personMobileNo})</option>			    
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

<div class="row">


<div class="col-sm-6">
		<div class="form-group">
			<label for="email">Receipt No </label>     
			<input type="text" readonly class="form-control" value="${ReceiptNo}">
		</div>
	</div>

<div class="col-sm-6">
		<div class="form-group">
			<label for="email">Property Type</label>     
			<select class="form-control" name="drppropertytype" id="drppropertytype" onchange="changePropertyType()">
			<option>Shop</option>
			<option selected>Flat</option>
			</select>
		</div>
	</div>



		<div class="row">
  <div class="col-sm-6" id="flatview">
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


	

	
  <div class="col-sm-6" id="shopview">
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


		
		 
    

		 <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Collection Date</label>
      <input type="text" class="form-control" id="txtcollectiondate" readonly value="${todaysDate}"  name="txtcollectiondate">     
    </div>
  </div>

  

<div class="col-sm-6">
  	<div class="form-group">
      <label for="email">From Date</label>
      <input type="text" class="form-control" id="txtfromdate" readonly value="${firstAndLastDates.first_day}"  name="txtfromdate">     
    </div>
  </div>
  
	 <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">To Date</label>
      <input type="text" class="form-control" id="txttodate" readonly value="${firstAndLastDates.last_day}"  name="txttodate">     
    </div>
  </div>

  <div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Payment Mode</label>
	  <select name="drppaymentmode" class="form-control">
	  <option>Cash</option>
	  <option>Cheque</option>
	  <option selected>Bank Transfer</option>	  
	  </select>      
    </div>
  </div>


<div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Reference No</label>
	  <input class="form-control" type="text" name="txtreferenceno">
    </div>
  </div>




<div class="col-sm-6">
  	<div class="form-group">
      <label for="email">Owner Type</label>
	  <select name="txtownertype" class="form-control">
	  <option>Owner</option>
	  <option>Tenant</option>	  
	  </select>      
    </div>
  </div>
  <div class="col-sm-6">
		<div class="form-group">
		<label for="email">Amount</label>
		<input type="number" class="form-control" id="txtamount"  value="${collectionDetails.amount}"  placeholder="eg. " name="txtamount">
		
	  </div>
	</div>

	
	





 <div class="col-sm-12" align="center">
		<button class="btn btn-success" type="button" onclick='addCategory()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showCategoryMasterNew"'>Cancel</button>
	</div>
		


	



	
</div>
</form>




	<c:if test="${flatDetails.flat_id eq null}">
		<script>document.getElementById("divTitle").innerHTML="Collect Maintenance";</script>
	
</c:if>

<script>
$( "#txtcollectiondate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txtfromdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
$( "#txttodate" ).datepicker({ dateFormat: 'dd/mm/yy' });


function getAmountForThisProperty()
{
	var subtype="";
	if(drppropertytype.value=="Flat")
	{
		subtype=(txtflatname.value.toString().split("~")[1].replaceAll("(","").replaceAll(")",""));
	}	
	var stringToSend="&duration="+drpmaintenenceduration.value+"&propertyType="+drppropertytype.value+"&subType="+subtype+"&Year="+drpmaintenenceforyear.value+"&Month="+drpmaintanancemonth.value+"&hdnselectedflat="+hdnselectedflat.value+"&hdnselectedshop="+hdnselectedshop.value;
	//alert(stringToSend);
  $.get("?a=getAmountForThisFlatType"+stringToSend, function(data, status)
	{
		var details=JSON.parse(data);
		//console.log(details.maintenenceAmount);
		txtamount.value=details.maintenenceAmount;
		txtownertype.value=details.OwnerType;
		//alert("Data: " + data + "\nStatus: " + status);
	}
  );
	

	
}



function showHideMonths()
{
	var duration=document.getElementById("drpmaintenenceduration").value;

	if(duration=="Yearly")
	{
		maintenenceformonthdiv.style.display="none";
	}
	else
	{
		maintenenceformonthdiv.style.display="block";
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
changePropertyType();
txtflatname.focus();
</script>