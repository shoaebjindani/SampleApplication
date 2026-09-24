<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="finalDispenserMap"
	value='${requestScope["outputObject"].get("finalDispenserMap")}' />

<c:forEach var="entry" items="${finalDispenserMap}">
	<div class="container" style="background-color: white">
	
		<div class="row">
			<div class="col-12">
				<h3 align="left" style="font-weight: 700">${entry.key}</h3>
			</div>
			<br>

			<c:forEach items="${entry.value }" var="nozzle">
			
			<div class="col-lg-3 col-6"
					onclick="sendToNozzleInputPage('${nozzle.nozzle_id}','${nozzle.status}','${nozzle.name }','${nozzle.closing_reading }','${nozzle.nozzle_name}','${nozzle.item_name }','${nozzle.opening_reading }','${nozzle.totalizer_opening_reading}','${nozzle.trn_nozzle_id }')">


					<c:if
						test="${nozzle.status eq 'Occupied' and nozzle.item_name eq 'Petrol'}">
						<div class="small-box bg-success">
					</c:if>

					<c:if
						test="${(nozzle.status eq 'Empty' or nozzle.status eq 'New') and nozzle.item_name eq 'Petrol'}">
						<div class="small-box bg-success" style="opacity: 0.5">
					</c:if>

					<c:if
						test="${(nozzle.status eq 'Empty' or nozzle.status eq 'New' ) and nozzle.item_name eq 'Diesel'}">
						<div class="small-box bg-info" style="opacity: 0.5">
					</c:if>

					<c:if
						test="${nozzle.status eq 'Occupied' and nozzle.item_name eq 'Diesel'}">
						<div class="small-box bg-info">
					</c:if>
					
				



					<div class="inner">
						<h5 align="center">${nozzle.nozzle_name} ${nozzle.item_name}</h5>
						
					

						<c:if test="${nozzle.status eq 'Occupied'}">
							<div align="center" style="color: bisque">Status :
								${nozzle.status}</div>
							<div align="center" style="color: bisque">Currently With :
								${nozzle.name}</div>
							<div align="center" style="color: bisque">Opening Reading :
								${nozzle.opening_reading}</div>
							<div align="center" style="color: bisque">Check In Time:
								${nozzle.check_in_time}</div>
						</c:if>

						<c:if test="${nozzle.status eq 'Empty'}">
							<div style="color: bisque">Status : ${nozzle.status}</div>
							<div style="color: bisque">Last Checked Out By:
								${nozzle.name}</div>
							<div style="color: bisque">Checked Out Time:
								${nozzle.check_out_time}</div>

							<div style="color: bisque">Opening Reading :
								${nozzle.opening_reading}</div>
							<div style="color: bisque">Closing Reading :
								${nozzle.closing_reading}</div>

						</c:if>

					</div>
					<div class="icon">
						<i class="ion ion-bag"></i>
					</div>
					<a href="#" class="small-box-footer">More info <i
						class="fas fa-arrow-circle-right"></i></a>
				</div>
		</div>

		<br>
</c:forEach>
</div>
</div>
<br>

</c:forEach>










<script type="javascript">
	document.getElementById("divTitle").innerHTML=" Nozzle Selection";	

	document.title +=" Nozzle Selection";
	
	function sendToNozzleInputPage(nozzle_id,color,name,closing_reading,nozzle_name,item_name,opening_reading,totalizer_opening_reading,trn_nozzle_id)
	{
		
		if(color=='Occupied')
			{				
				window.location="?a=showCheckOutScreen&nozzle_id="+nozzle_id;
				return;
			}
		else
		{
			window.location="?a=showNozzleSelectionForm&nozzle_id="+nozzle_id;
		}
		
	}
</script>
