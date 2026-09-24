<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





    <c:set var="ListOfAccount" value='${requestScope["outputObject"].get("ListOfAccount")}' />






    </head>


    <script>
        function removethisitem(btn1) {
            btn1.parentElement.parentElement.remove();
        }

        function checkforMatchAccount() {
            var searchString = document.getElementById("txtaccountname").value;
            var options1 = document.getElementById("Accountlist").options;
            var itemId = 0;
            for (var x = 0; x <
                options1.length; x++) {
                if (searchString == options1[x].value) {
                    itemId = options1[x].id;
                    break;
                }
            }
            console.log(itemId)
            if (itemId != 0) {
                var total = 0;
                var rows = tblitems.rows;
                for (var x = 1; x < rows.length; x++) {
                    if (itemId == rows[x].childNodes[0].innerHTML) {
                        alert(
                            'Account already exist in selection');
                        document.getElementById("txtaccountname").value = "";
                        return;
                    }
                }
                // code to check if item already exist inselection 
                getItemDetailsAndAddToTable(itemId, searchString);
                document.getElementById("txtaccountname").value = "";
            }
        }

        function getItemDetailsAndAddToTable(itemId, itemName) {
            document.getElementById("closebutton").style.display = 'none';
            document.getElementById("loader").style.display = 'block';

            var table = document.getElementById("tblitems");
            var row = table.insertRow(-1);
            var cell0 = row.insertCell(0);
            var cell1 = row.insertCell(1);
            var cell2 = row.insertCell(2);
            var cell3 = row.insertCell(3);

            var arritemName = itemName.split('~');


            cell0.innerHTML = itemId;
            cell0.style.textAlign = "center";

            cell1.innerHTML = arritemName[0];
            cell1.style.textAlign = "center";

            cell2.innerHTML = arritemName[1];
            cell2.style.textAlign = "center";

            cell3.innerHTML = '<button  type="button" class="btn btn-danger"  onclick=removethisitem(this) id="btn11" style="cursor:pointer">Delete</button>';
            cell3.style.textAlign = "center";
        }




        function printLabels() {
            var rows = tblitems.rows;
            var requiredDetails = [];
            var arr = [];
            var itemString = "";
            var confirmMessage = "";
            var proceedFlag = true;
            for (var x = 1; x < rows.length; x++) { // ID, Customer Name,Mobile Number 
                itemString += rows[x].childNodes[0].innerHTML +
                    "~" + rows[x].childNodes[1].innerHTML + "~" + rows[x].childNodes[2].innerHTML + "|";
            }
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    window.open("BufferedImagesFolder/" +
                        xhttp.responseText);
                }
            };
            console.log(itemString)
            xhttp.open("POST", "?a=printLabelsAccount", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("accountDetails=" + itemString);
        }
    </script>



    <br>

    <div class="container" style="padding:20px;background-color:white">

        <form id="frm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
            <div class="row">


                <div class="col-sm-12">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search for Account" list=Accountlist s id="txtaccountname" name="txtaccountname" oninput="checkforMatchAccount()">
                    </div>
                </div>

                <datalist id="Accountlist">
<c:forEach items="${ListOfAccount}" var="account">
			    <option id="${account.accountId}">${account.accountName}~${account.accountNo}</option>			    
	   </c:forEach></select>	   	   	
</datalist>


                <div class="col-sm-12">
                    <div class="card-body table-responsive p-0" style="height: 370px;">
                        <table id="tblitems" class="table table-head-fixed  table-bordered table-striped dataTable dtr-inline" role="grid" aria-describedby="example1_info">
                            <thead>
                                <tr align="center">
                                    <th style="z-index:0">Account Id</th>
                                    <th style="z-index:0">Account Name</th>
                                    <th style="z-index:0">Account No</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>



                <div class="col-sm-12" align="center">
                    <div class="form-group">
                        <button class="btn btn-success" type="button" onclick='printLabels()'>Print</button>
                        <button class="btn btn-danger" type="reset" onclick='window.location="?a=showHomePage"'>Cancel</button>
                    </div>
                </div>




            </div>
        </form>
        <script type="javascript">



            document.getElementById("divTitle").innerHTML="Print Labels Account"; document.title +=" Print Labels Account ";

        </script>