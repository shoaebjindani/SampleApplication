



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="itemDetails" value='${requestScope["outputObject"].get("itemDetails")}'  />
<c:set var="relatedItems" value='${requestScope["outputObject"].get("relatedItems")}'  />



    <div id="all">

        <div id="content">
            <div class="container">

                <div class="col-md-12">
                    <ul class="breadcrumb">
                        <li><a href="#">Home</a>
                        </li>
                        <li><a href="?a=showCategoryForGuests&appId=${param.appId }&categoryId=${itemDetails.parent_category_id}">${itemDetails.category_name }</a>                        </li>
                        
                        <li>${itemDetails.item_name }</li>
                    </ul>

                </div>

                <div class="col-md-3">
                    <!-- *** MENUS AND FILTERS ***
 _________________________________________________________ -->
                    <div class="panel panel-default sidebar-menu">

                        <div class="panel-heading">
                            <h3 class="panel-title">Categories</h3>
                        </div>

                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked category-menu">
                            
                            
                            
                            <c:forEach var="entry" items="${categoriesWithItem}">
  										
  										
  										<li>
                                    <a href="?a=showCategoryForGuests&appId=${param.appId }&categoryId=${entry.key.get('parent_category_id')}">${entry.key.get('category_name')}</a>
                                   
                                </li>
  										
  								</c:forEach>		
  										
                                
                                
                             

                            </ul>

                        </div>
                    </div>

                    

                    

                    <!-- *** MENUS AND FILTERS END *** -->

                   
                </div>

                <div class="col-md-9">

                    <div class="row" id="productMain">
                        <div class="col-sm-6">
                            <div id="mainImage">
                                <img src="BufferedImagesFolder/${itemDetails.ImagePath}" alt="" class="img-responsive">
                            </div>

                            <div class="ribbon sale">
                                <div class="theribbon">SALE</div>
                                <div class="ribbon-background"></div>
                            </div>
                            <!-- /.ribbon -->

                            <div class="ribbon new">
                                <div class="theribbon">NEW</div>
                                <div class="ribbon-background"></div>
                            </div>
                            <!-- /.ribbon -->

                        </div>
                        <div class="col-sm-6">
                            <div class="box">
                                <h1 class="text-center">${itemDetails.item_name }</h1>
                                <p class="goToDescription"><a href="#details" class="scroll-to">Scroll to product details, material & care and sizing</a>
                                </p>
                                <p class="price">${itemDetails.price }/-</p>

                                <p class="text-center buttons">
                                    <a href="basket.html" class="btn btn-primary"><i class="fa fa-shopping-cart"></i> Add to cart</a> 
                                    <a href="basket.html" class="btn btn-default"><i class="fa fa-heart"></i> Add to wishlist</a>
                                </p>


                            </div>

                            <div class="row" id="thumbs">
                            <c:forEach var="itemImage" items="${itemDetails.listOfItemImages}">
                                <div class="col-xs-4">
                                    <a href="BufferedImagesFolder/${ itemImage.fileName}" class="thumb">
                                        <img src="BufferedImagesFolder/${ itemImage.fileName}" alt="" class="img-responsive">
                                    </a>
                                </div>
                            </c:forEach>
                               
                            </div>
                        </div>

                    </div>



                    <div class="box" id="details">
                        
                        ${itemDetails.product_details }
                           
                    </div>

                    <div class="row same-height-row">
                        <div class="col-md-3 col-sm-6">
                            <div class="box same-height">
                                <h3>You may also like these products</h3>
                            </div>
                        </div>
						<c:forEach var="item" items="${relatedItems}">
						
                        <div class="col-md-3 col-sm-6">
                            <div class="product same-height">
                                <div class="flip-container">
                                    <div class="flipper">
                                        <div class="front">
                                            <a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">
                                                <img src="BufferedImagesFolder/${item.path}" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                        <div class="back">
                                            <a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">
                                                <img src="BufferedImagesFolder/${item.path}" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}" class="invisible">                                 
                                    <img src="BufferedImagesFolder/${item.path}" alt="" class="img-responsive">
                                </a>
                                <div class="text">
                                    <h3>${item.item_name}</h3>
                                    <p class="price">${item.price}</p>
                                </div>
                            </div>
                            <!-- /.product -->
                        </div>
                        </c:forEach>

                        


                        

                    </div>

                    

                </div>
                <!-- /.col-md-9 -->
            </div>
            <!-- /.container -->
        </div>
        <!-- /#content -->


        