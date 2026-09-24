  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           
           
           

<c:set var="pendingItems" value='${requestScope["outputObject"].get("pendingItems")}' />
<c:set var="tableList" value='${requestScope["outputObject"].get("tableList")}' />




   





</head>


<script type="javascript">







</script>


<br>

<div class="container" style="padding:20px;background-color:white">


<div class="row">




<div class="col-sm-12">
		<div class="card" >
              
              <div class="card-body table-responsive p-0">
                <table class="table table-striped table-valign-middle">
                  <thead>
                  <tr>
                  <th>
                  	<select id="drptableno" name="drptableno" class="form-control float-right" onchange='reloadFilters()' style="margin-right: 15px;" >
				  						
				  													
				  					</select>
                  </th>
                  
                     <th>
							 <button class="btn btn-primary" onclick="markAsServed()">Mark As Served</button>                  	
                  	 </th>
                        
                              
                  </tr>
                  </thead>
                  <tbody>
                  
                  
                  	
                  
                  
                  
                                    
                  </tbody>
                </table>
              </div>
            </div>
		</div>





<div class="col-sm-12">  
	  <div class="card-body table-responsive p-0" >                
	                <table id="tblordereditems"  class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
	                
	                
	                
	               
	                
	                
	                
	                  
	                  
	                  
	                  
	                </table>
	   </div>	
  </div>
   
</div>






<script type="javascript">
	document.getElementById("divTitle").innerHTML="Pending Orders";	
	document.title +=" Pending Orders ";
	function markAsServed()
	{
		
		
		  document.getElementById("closebutton").style.display='none';
		   document.getElementById("loader").style.display='block';
		//$('#myModal').modal({backdrop: 'static', keyboard: false});;
		
		
		var checkBoxes=document.getElementsByName("possiblecheckboxes");
		var requiredCheckBoxes=[];
		
		for(var x=0;x<checkBoxes.length;x++)
			{
					if(checkBoxes[x].checked==true)
						{
							requiredCheckBoxes.push(checkBoxes[x].value);
						}
			}
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() 
		  {
		    if (xhttp.readyState == 4 && xhttp.status == 200) 
		    { 		      
		      
		    	
		    	if(xhttp.responseText=="Served Succesfully")
		    		{
		    		
		    	 	toastr["success"](xhttp.responseText);
			    	toastr.options = {"closeButton": false,"debug": false,"newestOnTop": false,"progressBar": false,
			    	  "positionClass": "toast-top-right","preventDuplicates": false,"onclick": null,"showDuration": "1000",
			    	  "hideDuration": "500","timeOut": "500","extendedTimeOut": "500","showEasing": "swing","hideEasing": "linear",
			    	  "showMethod": "fadeIn","hideMethod": "fadeOut"}
		    			reloadFilters();
		    		}
		    }
		  };
		  xhttp.open("GET","?a=markAsServed&orderDetailsId="+requiredCheckBoxes, true);    
		  xhttp.send();
	}
	
	function searchChildCheckboxAndCheckUnchedk(element)
	{		
		if(element.childNodes[1].childNodes[1].childNodes[1].checked==true)
			{
				element.childNodes[1].childNodes[1].childNodes[1].checked=false;				
			}
		else
			{
				element.childNodes[1].childNodes[1].childNodes[1].checked=true;
			}
	}
	
	if("${param.table_id}"!="")
		{
			drptableno.value="${param.table_id}";	
		}
	
	
	function reloadFilters()
	{
		  //window.location="?a=showPendingOrders&table_id="+drptableno.value;
		  
		  
		  
		  
		  const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  
			  
		    var hm=JSON.parse(this.responseText);
		   var listOfTables=(hm.tableList);
		    var pendingItems=hm.pendingItems;
		    var table = document.getElementById("tblordereditems");
		    
		    $("#tblordereditems tr").remove(); 

		    
	    
	    	
	    	
	    	var row = table.insertRow(-1);	    	
	    	var cell1 = row.insertCell(0);
	    	var cell2 = row.insertCell(1);
	    	var cell3 = row.insertCell(2);
	    	var cell4 = row.insertCell(3);
	    	var cell5 = row.insertCell(4);
	    	var cell6 = row.insertCell(5);
	    	var cell7 = row.insertCell(6);
	    	var cell8 = row.insertCell(7);
	    	
	    	cell1.innerHTML = " ";
	    	cell2.innerHTML = "<b>Sr</b>";
	    	cell3.innerHTML = "<b>Table No</b>";
	    	cell4.innerHTML = "<b>Item Name</b>";
	    	cell5.innerHTML = "<b>Item Qty</b>";
	    	cell6.innerHTML = "<b>Status</b>";
	    	cell7.innerHTML = "<b>Remarks</b>";
	    	cell8.innerHTML = "<b>Running</b>";
	    	
	    	
	    	
	    	
		    
		    for(var m=0;m<pendingItems.length;m++)
		    	{
		    		
		    	var row = table.insertRow(-1);
		    	row.onclick = function()
		    	{	
		    		
		    		var checkBox=this.childNodes[0].childNodes[0].childNodes[0];
		    		if(checkBox.checked==true)
		    			{
		    				checkBox.checked=false;
		    				this.style="background-color:;color:black"
		    			}
		    		else
		    			{
		    				checkBox.checked=true;
		    				this.style="background-color:blue;color:white";
		    			}
		    		
		    		
		    	};

		    	var cell1 = row.insertCell(0);
		    	var cell2 = row.insertCell(1);
		    	var cell3 = row.insertCell(2);
		    	var cell4 = row.insertCell(3);
		    	var cell5 = row.insertCell(4);
		    	var cell6 = row.insertCell(5);
		    	var cell7 = row.insertCell(6);
		    	var cell8 = row.insertCell(7);
		    	
		    	cell1.innerHTML = '<div class="icheck-primary d-inline"><input style="width:30px;display:none" type="checkbox"  name="possiblecheckboxes" value='+pendingItems[m].order_details_id+' id="checkbox'+pendingItems[m].order_details_id+'"><label for="checkboxPrimary2"></label>		    	</div>';
		    	cell2.innerHTML = "<b>"+pendingItems[m].order_details_id+"</b>";
		    	cell3.innerHTML = "<b>"+pendingItems[m].table_no+"</b>";
		    	cell4.innerHTML = "<b>"+pendingItems[m].item_name+"</b>";
		    	cell5.innerHTML = "<b>"+pendingItems[m].qty+"</b>";
		    	cell6.innerHTML = "<b>"+pendingItems[m].status+"</b>";
		    	cell7.innerHTML = "<b>"+pendingItems[m].remarks+"</b>";
		    	cell8.innerHTML = "<b>"+pendingItems[m].running_flag+"</b>";
		    	
		    		
		    	}
		    var optionsString="<option value='-1'>----Select----</option>";;
		    for(var x=0;x<listOfTables.length;x++)
		    	{
		    		optionsString+="<option value="+listOfTables[x].table_id+">Table No "+listOfTables[x].table_no+"</option>";
		    	}
		    drptableno.innerHTML=optionsString;
		    drptableno.value=hm.table_id;
		    
		    
		    
		  }
		  xhttp.open("GET", "?a=showPendingOrdersAjax&table_id="+drptableno.value);
		  xhttp.send();
		  
		  
		  
		  
	}
	
	
	var intervalId = window.setInterval(function(){
		
	var checkBoxes=document.getElementsByName("possiblecheckboxes");
			
			var breakflag=false;
			for(var x=0;x<checkBoxes.length;x++)
				{
						if(checkBoxes[x].checked==true)
							{
								breakflag=true;
								break;
							}
				}
			if(breakflag==true)
				{
					return;
				}
			
			reloadFilters();
		
	}, 5000);
	
	
	
	
	
	
	reloadFilters();
</script>
