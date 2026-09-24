


<!DOCTYPE html>
<html lang="en">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ListOfCategories" value='${requestScope["outputObject"].get("ListOfCategories")}' />
<c:set var="categoriesWithItem" value='${requestScope["outputObject"].get("categoriesWithItem")}' scope="request" />
<c:set var="jspNameGuest" value='${requestScope["outputObject"].get("jspNameGuest")}' />
<c:set var="appDetails" value='${requestScope["outputObject"].get("appDetails")}' />
<c:set var="logoDetails" value='${requestScope["outputObject"].get("logoDetails")}' />


<head>

    <meta charset="utf-8">
    <meta name="robots" content="all,follow">
    <meta name="googlebot" content="index,follow,snippet,archive">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Obaju e-commerce template">
    <meta name="author" content="Ondrej Svestka | ondrejsvestka.cz">
    <meta name="keywords" content="">

    <title>
        ${ appDetails.app_name}
    </title>

    <meta name="keywords" content="">

    <link href='http://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100' rel='stylesheet' type='text/css'>

    <!-- styles -->
    <link href="css/font-awesome.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/owl.carousel.css" rel="stylesheet">
    <link href="css/owl.theme.css" rel="stylesheet">

    <!-- theme stylesheet -->
    <link href="css/style.default.css" rel="stylesheet" id="theme-stylesheet">

    <!-- your stylesheet with modifications -->
    <link href="css/custom.css" rel="stylesheet">

    <script src="js/respond.min.js"></script>

    <link rel="shortcut icon" href="favicon.png">



</head>

<body>

    <!-- *** TOPBAR ***
 _________________________________________________________ -->
    <div id="top">
        <div class="container">
            <div class="col-md-6 offer" data-animate="fadeInDown">
                <!-- <a href="#" class="btn btn-success btn-sm" data-animate-hover="shake">Offer of the day</a>  <a href="#">Get flat 35% off on orders over $50!</a> -->
            </div>
            <div class="col-md-12" data-animate="fadeInDown">
                <ul class="menu">
                    <li><a href="#" data-toggle="modal" data-target="#login-modal">Login</a>
                    </li>
                    <li><a href="register.html">Register</a>
                    </li>
                    <li><a href="contact.html">Contact</a>
                    </li>
                    
                </ul>
            </div>
        </div>
        <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true">
            <div class="modal-dialog modal-sm">

                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="Login">Customer login</h4>
                    </div>
                    <div class="modal-body">
                        <form action="customer-orders.html" method="post">
                            <div class="form-group">
                                <input type="text" class="form-control" id="email-modal" placeholder="email">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" id="password-modal" placeholder="password">
                            </div>

                            <p class="text-center">
                                <button class="btn btn-primary"><i class="fa fa-sign-in"></i> Log in</button>
                            </p>

                        </form>

                        <p class="text-center text-muted">Not registered yet?</p>
                        <p class="text-center text-muted"><a href="register.html"><strong>Register now</strong></a>! It is easy and done in 1&nbsp;minute and gives you access to special discounts and much more!</p>

                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- *** TOP BAR END *** -->

    <!-- *** NAVBAR ***
 _________________________________________________________ -->

    <div class="navbar navbar-default yamm" role="navigation" id="navbar">
        <div class="container">
            <div class="navbar-header">

                <a class="navbar-brand home" href="?a=H&appId=${param.appId }" data-animate-hover="bounce">
                    <img src="BufferedImagesFolder/${logoDetails.fileName }" alt="logo" class="hidden-xs">
                    <img src="BufferedImagesFolder/${logoDetails.fileName }" alt="logo" class="visible-xs"><span class="sr-only">Homepage</span>
                </a>
                <div class="navbar-buttons">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-align-justify"></i>
                    </button>
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#search">
                        <span class="sr-only">Toggle search</span>
                        <i class="fa fa-search"></i>
                    </button>
                    <a class="btn btn-default navbar-toggle" href="basket.html">
                        <i class="fa fa-shopping-cart"></i>  <span class="hidden-xs">3 items in cart</span>
                    </a>
                </div>
            </div>
            <!--/.navbar-header -->

            <div class="navbar-collapse collapse" id="navigation">

                <ul class="nav navbar-nav navbar-left">
                    <li class="active"><a href="?a=H&appId=${param.appId }">Home</a>
                    </li>
                    
                    
                    
                    <li class="dropdown yamm-fw">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="200">Categories<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <div class="yamm-content">
                                    <div class="row">
                                    
                                    
                                 
                                    
                                    <c:forEach var="entry" items="${categoriesWithItem}">
  										
  										
  										
  										<div class="col-sm-3">
                                            <a href="?a=showCategoryForGuests&appId=${param.appId }&categoryId=${entry.key.get('parent_category_id')}"><h5>${entry.key.get('category_name')}</h5></a>
                                            <ul>
                                            
                                            <c:forEach items="${entry.value}" var="item" varStatus="loop">
        										<li><a href="?a=showItemDetailForGuest&appId=${param.appId }&itemId=${item.item_id}">${item.item_name}</a></li>
    										</c:forEach>
                                            
                                            </ul>
                                        </div>
  										
									</c:forEach>
                                    
                                    
                                    
                                        
                                        
                                        
                                      
                                    </div>
                                </div>
                                <!-- /.yamm-content -->
                            </li>
                        </ul>
                    </li>

                    
					<li><a href="?a=H&appId=${param.appId }">About Us</a></li>
                    
                </ul>

            </div>
            <!--/.nav-collapse -->

            <div class="navbar-buttons">

                <div class="navbar-collapse collapse right" id="basket-overview">
                    <a href="basket.html" class="btn btn-primary navbar-btn"><i class="fa fa-shopping-cart"></i><span class="hidden-sm">3 items in cart</span></a>
                </div>
                <!--/.nav-collapse -->

                <div class="navbar-collapse collapse right" id="search-not-mobile">
                    <button type="button" class="btn navbar-btn btn-primary" data-toggle="collapse" data-target="#search">
                        <span class="sr-only">Toggle search</span>
                        <i class="fa fa-search"></i>
                    </button>
                </div>

            </div>

            <div class="collapse clearfix" id="search">

                <div class="navbar-form" role="search" action="#">
                    <div class="input-group">
                        <input type="text" class="form-control" id="txtsearch" placeholder="Search">
                        <span class="input-group-btn">

			<button type="button" onclick="searchItems()" class="btn btn-primary"><i class="fa fa-search"></i></button>

		    </span>
                    </div>
                </div>

            </div>
            <!--/.nav-collapse -->

        </div>
        <!-- /.container -->
    </div>
    
    
<jsp:include page="${jspNameGuest}"/>
            
    <!-- /#navbar -->

    <!-- *** NAVBAR END *** -->


        <!-- *** FOOTER ***
 _________________________________________________________ -->
        <div id="footer" data-animate="fadeInUp">
            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <h4>Pages</h4>

                        <ul>
                            <li><a href="text.html">About us</a>
                            </li>
                            <li><a href="text.html">Terms and conditions</a>
                            </li>
                            <li><a href="faq.html">FAQ</a>
                            </li>
                            <li><a href="contact.html">Contact us</a>
                            </li>
                        </ul>

                        <hr>

                        <h4>User section</h4>

                        <ul>
                            <li><a href="#" data-toggle="modal" data-target="#login-modal">Login</a>
                            </li>
                            <li><a href="register.html">Regiter</a>
                            </li>
                        </ul>

                        <hr class="hidden-md hidden-lg hidden-sm">

                    </div>
                    

                    <div class="col-md-3 col-sm-6">

                        <h4>Where to find us</h4>
						
                        <p><strong>${appDetails.app_name }</strong>
                        	<br>${appDetails.address}
                            <br>${appDetails.contact_1 }
                            <br>${appDetails.contact_2}
                            <br>${appDetails.email}                            
                        </p>

                        <a href="contact.html">Go to contact page</a>

                        <hr class="hidden-md hidden-lg">

                    </div>
                    <!-- /.col-md-3 -->



                    
                    <!-- /.col-md-3 -->

                </div>
                <!-- /.row -->

            </div>
            <!-- /.container -->
        </div>
        <!-- /#footer -->

        <!-- *** FOOTER END *** -->




        <!-- *** COPYRIGHT ***
 _________________________________________________________ -->
        <div id="copyright">
            <div class="container">
                <div class="col-md-6">
                    <p class="pull-left">� 2015 ${appDetails.app_name }</p>

                </div>
                
            </div>
        </div>
        <!-- *** COPYRIGHT END *** -->



    </div>
    <!-- /#all -->


    

    <!-- *** SCRIPTS TO INCLUDE ***
 _________________________________________________________ -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script src="js/waypoints.min.js"></script>
    <script src="js/modernizr.js"></script>
    <script src="js/bootstrap-hover-dropdown.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/front.js"></script>


</body>

</html>


<script type="javascript">
function searchItems()
{
		window.location="?a=showCategoryForGuests&appId=${param.appId}&searchString="+txtsearch.value;
}
</script>