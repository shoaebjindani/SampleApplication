<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <c:set var="blockDetails" value='${requestScope["outputObject"].get("blockDetails")}' />

    </head>


    <script>
        function addBlock() {
            if (blockName.value == "") {
                toastr["error"]("Please enter block Name");
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "1000",
                    "hideDuration": "500",
                    "timeOut": "1000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                blockName.focus();
                return;
            }
            document.getElementById("frm").submit();
        }
    </script>


    <br>

    <div class="container" style="padding:20px;background-color:white">


        <form id="frm" action="?a=addBlock" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
            <input type="hidden" name="app_id" value="${userdetails.app_id}">
            <input type="hidden" name="user_id" value="${userdetails.user_id}">
            <input type="hidden" name="callerUrl" id="callerUrl" value="">

            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label for="BlockName">Block Name*</label>


                        <input type="text" class="form-control" id="blockName" value="${blockDetails.block_name}" name="blockName" placeholder="block Name">
                        <input type="hidden" name="hdnBlockId" value="${blockDetails.block_id}" id="hdnBlockId">
                    </div>
                </div>

            </div>

            <c:if test="${action ne 'Update'}">

                <button class="btn btn-success" type="button" onclick='addBlock()'>Save</button>
                <button class="btn btn-danger" type="reset" onclick='window.location="?a=showBlockMaster"'>Cancel</button>


            </c:if>



            <c:if test="${action eq 'Update'}">

                <input type="button" type="button" class="btn btn-success" onclick='addBlock()' value="update">Update</button>

            </c:if>
    </div>
    </form>








    <script type="javascript">

        <c:if test="${blockDetails.block_id eq null}">
            document.getElementById("divTitle").innerHTML="Add Block"; document.title +=" Add Block ";
        </c:if>
        <c:if test="${blockDetails.block_id ne null}">
            document.getElementById("divTitle").innerHTML="Update Block"; document.title +=" Update Block ";
        </c:if>


        var arr=window.location.toString().split("/"); callerUrl.value=(arr[0]+"//"+arr[1]+arr[2]+"/"+arr[3]+"/");

    </script>