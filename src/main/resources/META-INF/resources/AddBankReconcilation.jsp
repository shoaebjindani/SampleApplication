  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
`           
           
           
<c:set var="BankDetails" 
   value='${requestScope["outputObject"].get("BankDetails")}' />
<c:set var="ListOfBanks"
	value='${requestScope["outputObject"].get("ListOfBanks")}' />

<c:set var="reconcilationDate"
	value='${requestScope["outputObject"].get("reconcilationDate")}' />



</head>


<script type="javascript">


function addBank()
{	
	
	
	document.getElementById("frm").submit(); 
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



<br>

<div class="container" style="padding:20px;background-color:white">

<form id="frm" action="?a=addBankReconcilation" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
<div class="row">
  
  
   <div class="col-sm-3">
  	<div class="form-group">
      <label for="email" id="lblBankId">Bank Id</label> 
      
      <input type="hidden" name="hdnReconcilationId" value="${BankDetails.bank_id}" id="hdnReconcilationId">
      <select id="drpBankId" name="drpBankId" class="form-control">
      
      <c:forEach items="${ListOfBanks}" var="BankDetails">
						<option id="${BankDetails.bank_id}" value="${BankDetails.bank_id}">${BankDetails.bank_name} ${BankDetails.account_no}
							</option>
					</c:forEach>
     
			</select>
      
    </div>
  </div>
  <div class="col-sm-3">
					<div class="form-group" >
						<label>Reconcilation Date</label>
						<input type="text" id="txtreconcilationdate" name="txtreconcilationdate"
							class="form-control form-control-sm" value="${reconcilationDate}"
							placeholder="Reconcilation Date" readonly />
					</div>
				</div>
 
  
 
  <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Expected Amount</label>
      <input type="text" class="form-control" id="amount" value="${BankDetails.amount}"  placeholder="Amount" name="expectedamount" readonly >
      
    </div>
  </div>
  <div class="col-sm-3">
  	<div class="form-group">
      <label for="email">Amount</label>
      <input type="text" class="form-control" id="amount" value="${BankDetails.amount}"  placeholder="Amount" name="amount">
      
    </div>
  </div>
  
  
 
  
  
  
  <div class="col-sm-12">
  <c:if test="${action ne 'Update'}">
		
		<button class="btn btn-success" type="button" onclick='addBank()'>Save</button>
		<button class="btn btn-danger" type="reset" onclick='window.location="?a=showBankMasterNew"'>Cancel</button>
		
		
		</c:if>
		
		
		
		<c:if test="${action eq 'Update'}">	
				
				<input type="button" type="button" class="btn btn-success" onclick='addBankReconcilation()' value="update">		
		</c:if> 
		</div>
</div>
</form>

<script type="javascript">
	
	
	<c:if test="${BankDetails.Bank_id eq null}">
		document.getElementById("divTitle").innerHTML="Add Bank Reconcilation";
		
		$( "#txtreconcilationdate" ).datepicker({ dateFormat: 'dd/mm/yy' });
	</c:if>
	<c:if test="${BankDetails.Bank_id ne null}">
		document.getElementById("divTitle").innerHTML="Update Bank Reconcilation";		
		drpheadid.value='${BankDetails.user_id}';
		drpBankId.value="${BankDetails.bank_name}";
	</c:if>
</script>



