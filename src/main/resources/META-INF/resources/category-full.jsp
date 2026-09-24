
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="categoriesWithItem" value='${requestScope["outputObject"].get("categoriesWithItem")}'  />
<c:set var="itemsByCategoryId" value='${requestScope["outputObject"].get("itemsByCategoryId")}'  />\
<c:set var="categoryDetails" value='${requestScope["outputObject"].get("categoryDetails")}'  />



    <div id="all">

        <div id="content">
            <div class="container">

                <div class="col-md-12">

                    <ul class="breadcrumb">
                        
                        <li ><a href="?a=H&appId=${param.appId }">Home</a>
                        </li>
                        <li>${categoryDetails.category_name}</li>
                    </ul>

                    <div class="box">
                        <h1>${categoryDetails.category_name }</h1>
                        <p>${categoryDetails.description}</p>
                    </div>

                    
                    <div class="row products">
						
						<c:forEach var="item" items="${itemsByCategoryId}">
						
						
                        <div class="col-md-3 col-sm-4">
                            <div class="product">
                                <div class="flip-container">
                                    <div class="flipper">
                                        <div class="front">
                                            <a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">
                                                <img  height="100px" width="450px"  src="BufferedImagesFolder/${item.path }" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                        <div class="back">
                                            <a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">
                                                <img height="100px" width="450px" src="BufferedImagesFolder/${item.path }" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                
                                <a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}" class="invisible">
                                    <img src="img/product1.jpg" alt="" class="img-responsive">
                                </a>
                                <div class="text">
                                    <h3>                                    	
                                    	<a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}" >${item.item_name}</a>
                                    	
                                    </h3>
                                    <p class="price">${item.price }</p>
                                    <p class="buttons">
                                        <a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id }" class="btn btn-default">View detail</a>
                                        <a href="basket.html" class="btn btn-primary"><i class="fa fa-shopping-cart"></i>Add to cart</a>
                                    </p>
                                </div>
                                <!-- /.text -->
                            </div>
                            <!-- /.product -->
                        </div>
                        </c:forEach>

                        
                        
                            <!-- /.product -->
                        </div>

                    </div>
                    <!-- /.products -->

                    

                </div>
                <!-- /.col-md-9 -->

            </div>
            <!-- /.container -->
        </div>
        <!-- /#content -->


        