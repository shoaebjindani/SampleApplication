<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ListOfCategories" value='${requestScope["outputObject"].get("ListOfCategories")}' />
<c:set var="categoriesWithItem" value='${requestScope["outputObject"].get("categoriesWithItem")}' scope="request" />
<c:set var="sliderImages" value='${requestScope["outputObject"].get("sliderImages")}' scope="request" />
<c:set var="popularProducts" value='${requestScope["outputObject"].get("popularProducts")}' scope="request" />





    <div id="all">

        <div id="content">

            <div class="container">
                <div class="col-md-12">
                    <div id="main-slider">
                    	
                    	
                    	<c:forEach items="${sliderImages}" var="image">                    	
	                        <div class="item">
	                            <img height="500px" width="1200px" src="BufferedImagesFolder/${image.file_name }" alt="" class="img-responsive">
	                        </div>
                        </c:forEach>
                        
                    </div>
                    <!-- /#main-slider -->
                </div>
            </div>

            <!-- *** ADVANTAGES HOMEPAGE ***
 _________________________________________________________ -->
            <div id="advantages">

                <div class="container">
                    <div class="same-height-row">
                        <div class="col-sm-4">
                            <div class="box same-height clickable">
                                <div class="icon"><i class="fa fa-heart"></i>
                                </div>

                                <h3><a href="#">We love our customers</a></h3>
                                <p>We are known to provide best possible service ever</p>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="box same-height clickable">
                                <div class="icon"><i class="fa fa-tags"></i>
                                </div>

                                <h3><a href="#">Best prices</a></h3>
                                <p>Our Prices are best compared to any of our competitors.</p>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="box same-height clickable">
                                <div class="icon"><i class="fa fa-thumbs-up"></i>
                                </div>

                                <h3><a href="#">100% satisfaction guaranteed</a></h3>
                                <p>Customer satisfaction is our motto</p>
                            </div>
                        </div>
                    </div>
                    <!-- /.row -->

                </div>
                <!-- /.container -->

            </div>
            <!-- /#advantages -->

            <!-- *** ADVANTAGES END *** -->

            <!-- *** HOT PRODUCT SLIDESHOW ***
 _________________________________________________________ -->
            <div id="hot">

                <div class="box">
                    <div class="container">
                        <div class="col-md-12">
                            <h2>Our Best Categories</h2>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <div class="product-slider">
                    
                    
                    
                    <c:forEach items="${ListOfCategories}" var="item">
                    
                     <div class="item">
                            <div class="product">
                                <div class="flip-container">
                                    <div class="flipper">
                                        <div class="front">
                                            
                                                <img height="100px" width="450px" src="BufferedImagesFolder/${ item.file_name}" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                        <div class="back">                                            
                                            <a  href="?a=showCategoryForGuests&appId=${param.appId }&categoryId=${item.category_id}">
                                                <img  height="100px" width="450px" src="BufferedImagesFolder/${ item.file_name}" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                
                                <a  href="?a=showCategoryForGuests&appId=${param.appId }&categoryId=${item.category_id}">
                                    <img  height="100px" width="450px"  src="BufferedImagesFolder/${ item.file_name}" alt="" class="img-responsive">
                                </a>
                                <div class="text">
                                    <h3>
                                    
                                    <a  href="?a=showCategoryForGuests&appId=${param.appId }&categoryId=${item.category_id}">
                                    ${item.category_name }</a></h3>                                    
                                </div>
                                <!-- /.text -->
                            </div>
                            <!-- /.product -->
                        </div>
                     </c:forEach>	
                    
                       

                        
                <!-- /.container -->

            </div>
            
            
            
            
            
             <div class="box">
                    <div class="container">
                        <div class="col-md-12">
                            <h2>Most Popular Products</h2>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <div class="product-slider">
                    
                    
                    
                    <c:forEach items="${popularProducts}" var="item">
                    
                     <div class="item">
                            <div class="product">
                                <div class="flip-container">
                                    <div class="flipper">
                                        <div class="front">
                                            
                                                <img height="100px" width="450px" src="BufferedImagesFolder/${ item.path}" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                        <div class="back">                                            
                                            <a  href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">
                                                <img  height="100px" width="450px" src="BufferedImagesFolder/${ item.path}" alt="" class="img-responsive">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                
                                <a  href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">
                                    <img  height="100px" width="450px"  src="BufferedImagesFolder/${ item.path}" alt="" class="img-responsive">
                                </a>
                                <div class="text">
                                    <h3>
                                    
                                    <a  href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">
                                    ${item.item_name }</a></h3>                                    
                                </div>
                                <!-- /.text -->
                            </div>
                            <!-- /.product -->
                        </div>
                     </c:forEach>	
                    
                       

                        
                <!-- /.container -->

            </div>
            
            
            
            <!-- /#hot -->

            <!-- *** HOT END *** -->

            

           


        </div>
        <!-- /#content -->
