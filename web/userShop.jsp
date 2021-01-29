
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="JavaServlet.ConnectionManager"%>
<%@ page language="java" 
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="JavaServlet.UserBean"
         import="JavaServlet.ProductBean"
         import="java.sql.*"
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <title>Handloom Silk Sarees</title>
    <!-- Meta tag Keywords -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="UTF-8" />
    <script>
        addEventListener("load", function() {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <!-- //Meta tag Keywords -->
    <!-- Custom-Files -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <!-- Bootstrap-Core-CSS -->
    <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    <!-- Style-CSS -->
    <!-- font-awesome-icons -->
    <link href="css/font-awesome.css" rel="stylesheet">
    <!-- //font-awesome-icons -->
    <!-- /Fonts -->
    <link href="//fonts.googleapis.com/css?family=Hind:300,400,500,600,700" rel="stylesheet">
    <!-- //Fonts -->
    <style>
        .dropbtn {
            background-color: #74d2e7;
            color: 33302F;
            padding: 12px;
            font: menu;
            font-size: 16px;
            font-weight: normal;
            border: thin;
            border-color: grey;
        }

        .dropdown {
          position: relative;
          display: inline-block;
        }

        .dropdown-content {
          display: none;
          position: absolute;
          background: #fff;
          padding: 10px;
          min-width: 160px;
          -moz-box-shadow: 1px 3px 8px 0 rgba(0, 0, 0, 0.15);
          -webkit-box-shadow: 1px 3px 8px 0 rgba(0, 0, 0, 0.15);
          box-shadow: 1px 3px 8px 0 rgba(0, 0, 0, 0.15);
          z-index: 1;
        }

        .dropdown-content a {
          color: black;
          padding: 12px 16px;
          text-align: center;
          text-decoration: none;
          display: block;
        }
        
        .dropdown-content a:hover {background-color: #F0441A;}
        .dropdown:hover .dropdown-content {display: block;}
        .dropdown:hover .dropbtn {background-color: #74d2e7;}
    </style>

</head>

<body>
    <% ProductBean pb = (ProductBean)(session.getAttribute("currentProduct")); %>
    <div class="main-sec inner-page">
        <!-- //header -->
        <header class="py-sm-3 pt-3 pb-2" id="home">
            <div class="container">
                <!-- nav -->
                <div class="top-w3pvt d-flex">
                    <div id="logo">
                        <h1> <a href="userLogged.jsp"><span class="log-w3pvt">H</span>andloom</a> <label class="sub-des">Silk Sarees</label></h1>
                    </div>
                    <!--USER AND LOGOUT--> 
                    <div class="forms ml-auto">
                         <form action="Logout" align="right">
                               <%  UserBean currentUser = (UserBean)(session.getAttribute("currentSessionUser")); %>
                               <div class="dropdown">
                                         <span class="fa fa-user-circle-o"></span><button class="dropbtn"><%=currentUser.getName()%> <span class="fa fa-angle-down" aria-hidden="true"></span></button>
                                         <div class="dropdown-content">
                                             <a href="userCart.jsp">My Cart</a>
                                             <a href="#">Account Information</a>
                                         </div>
                                     </div>
                               
                               <input type="submit" name="lgout" value="Logout" class="btn" align="right">
                           </form>
                    </div>
                </div>
                <div class="nav-top-wthree">
                    <nav>
                        <label for="drop" class="toggle"><span class="fa fa-bars"></span></label>
                        <input type="checkbox" id="drop" />
                        <ul class="menu">
                            <li><a href="userLogged.jsp">Home</a></li>
                            <li><a href="userAbout.jsp">About Us</a></li>
                            <li>
                                <!-- First Tier Drop Down -->
                                <label for="drop-2" class="toggle">Dropdown <span class="fa fa-angle-down" aria-hidden="true"></span>
                                </label>
                                <a href="#">Dropdown <span class="fa fa-angle-down" aria-hidden="true"></span></a>
                                <input type="checkbox" id="drop-2" />
                                <ul>
                                    <li><a href="userComing.jsp" class="drop-text">Services</a></li>
                                    <li><a href="userAbout.jsp" class="drop-text">Features</a></li>

                                </ul>
                            </li>

                            <li class="active"><a href="userShop.jsp">Collections</a></li>
                            <li><a href="userContact.jsp">Contact</a></li>
                        </ul>
                    </nav>
                    <!-- //nav -->
                    <div class="search-form ml-auto">
                        <div class="form-w3layouts-grid">
                            <form action="ProductSearch" method="get" class="newsletter">
                                <input class="search" type="text" name="tosearch" placeholder="Search here..." required="">
                                <button type="submit" class="form-control btn" name="prosearch"><span class="fa fa-search"></span></button>

                            </form>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </header>
        <!-- //header -->
    </div>
    <!-- //banner-->
    <!--/banner-bottom -->
    <section class="banner-bottom py-5">
        <div class="container py-5">
            <h3 class="title-wthree mb-lg-5 mb-4 text-center">Shop Now</h3>
            <!--/row-->
              
            <div class="row shop-wthree-info text-center">
                <%     // Creating ArrayList instances to store the mysql table data that is being stored in ProductBean class as ArrayList objects
                       ArrayList<String> name = pb.getNameData();
                       ArrayList<String> image = pb.getThumbData();
                       ArrayList<String> id = pb.getIdData();
                       List<Integer> price = pb.getPriceData();
                       
                       for(int i=0; i<pb.getProductCount(); i++) {                  // LOOP STARTS HERE, Condition: will run till the total product stored in the ArrayList i.e., in mysql table
                        out.print("<div class='col-lg-3 shop-info-grid text-center mt-4'>");
                    
                        out.print("<div class='product-shoe-info shoe'>");
                        out.print("<div class='men-thumb-item'>");
                               out.print("<img src='"+image.get(i)+"' class='img-fluid' alt='' id='imageUsed'>");

                          out.print("</div>");
                            out.print("<div class='item-info-product'>");
                                out.print("<h4>");
                                    out.print("<p id='proName'>"+name.get(i)+"</p>");
                                    out.print("<p id='proID'><strong>"+id.get(i)+"</strong></p>");
                                out.print("</h4>");

                                out.print("<div class='product_price'>");
                                  out.print("<div class='grid-price'>");
                                    out.print("<span class='money'>₹</span><span class='money' id='proPrice'>"+price.get(i)+"</span>");
                                    out.print("<form action='Description' method='get'>");
                                        out.print("<button type='submit' class='btn show-product' name='product"+i+"'>CLICK</button>");         //IMPORTANT STEP: Here, to make sure that the button of each product will also vary through loop 
                                    out.print("</form>");                                                                                       // we've created a successful iteration in the HTML button element's name attribute using JSP. 

                                    out.print("</div>");
                               out.print("</div>");

                            out.print("</div>");
                        out.print("</div>"); 
                    out.print("</div>"); 
                
                } %>

                <!--//row-->
            </div>
            <nav aria-label="Page navigation example mt-5">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#">Previous</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </section>
    <!-- /banner-bottom -->
    <!--/newsletter -->
    <section class="newsletter-w3pvt py-5">
        <div class="container py-md-5">
            <form method="post" action="#">
                <p class="text-center">Subscribe to the Handbags Store mailing list to receive updates on new arrivals, special offers and other discount information.</p>
               <div class="row subscribe-sec">
                    <div class="col-md-9">
                        <input type="email" class="form-control" id="email" placeholder="Enter Your Email.." name="email" required="">

                    </div>
                    <div class="col-md-3">

                        <button type="submit" class="btn submit">Subscribe</button>
                    </div>

                </div>

            </form>
        </div>
    </section>
    <!--//newsletter -->
    <!--/shipping-->
    <section class="shipping-wthree">
        <div class="shiopping-grids d-lg-flex">
            <div class="col-lg-4 shiopping-w3pvt-gd text-center">
                <div class="icon-gd"><span class="fa fa-truck" aria-hidden="true"></span>
                </div>
                <div class="icon-gd-info">
                    <h3>FREE SHIPPING</h3>
                    <p>On all order over $2000</p>
                </div>
            </div>
            <div class="col-lg-4 shiopping-w3pvt-gd sec text-center">
                <div class="icon-gd"><span class="fa fa-bullhorn" aria-hidden="true"></span></div>
                <div class="icon-gd-info">
                    <h3>FREE RETURN</h3>
                    <p>On 1st exchange in 30 days</p>
                </div>
            </div>
            <div class="col-lg-4 shiopping-w3pvt-gd text-center">
                <div class="icon-gd"> <span class="fa fa-gift" aria-hidden="true"></span></div>
                <div class="icon-gd-info">
                    <h3>MEMBER DISCOUNT</h3>
                    <p>Register &amp; save up to $29%</p>
                </div>

            </div>
        </div>

    </section>
    <!--//shipping-->
    <!-- footer -->
    <div class="footer_agileinfo_topf py-5">
        <div class="container py-md-5">
            <div class="row">
                <div class="col-lg-3 footer_wthree_gridf mt-lg-5">
                    <h2><a href="userLogged.jsp"><span>H</span>andloom
                        </a> </h2>
                    <label class="sub-des2">Silk Sarees</label>
                </div>
                <div class="col-lg-3 footer_wthree_gridf mt-md-0 mt-4">
                    <ul class="footer_wthree_gridf_list">
                        <li>
                            <a href="userLogged.jsp"><span class="fa fa-angle-right" aria-hidden="true"></span> Home</a>
                        </li>
                        <li>
                            <a href="userAbout.jsp"><span class="fa fa-angle-right" aria-hidden="true"></span> About</a>
                        </li>
                        <li>
                            <a href="userShop.jsp"><span class="fa fa-angle-right" aria-hidden="true"></span> Shop</a>
                        </li>
                        <li>
                            <a href="userShop.jsp"><span class="fa fa-angle-right" aria-hidden="true"></span>Collections</a>
                        </li>

                    </ul>
                </div>
                <div class="col-lg-3 footer_wthree_gridf mt-md-0 mt-sm-4 mt-3">
                    <ul class="footer_wthree_gridf_list">
                        
                        <li>
                            <a href="#"><span class="fa fa-angle-right" aria-hidden="true"></span> Terms & Conditions</a>
                        </li>
                        
                        <li>
                            <a href="userContact.jsp"><span class="fa fa-angle-right" aria-hidden="true"></span> Contact Us</a>
                        </li>
                    </ul>
                </div>

                <div class="col-lg-3 footer_wthree_gridf mt-md-0 mt-sm-4 mt-3">
                    <ul class="footer_wthree_gridf_list">
                        
                        <li>
                            <a href="#"><span class="fa fa-angle-right" aria-hidden="true"></span>Privacy & Policy</a>
                        </li>

                    </ul>
                </div>
            </div>

            <div class="w3ls-fsocial-grid">
                <h3 class="sub-w3ls-headf">Follow Us</h3>
                <div class="social-ficons">
                    <ul>
                        <li><a href="#"><span class="fa fa-facebook"></span> Facebook</a></li>
                        <li><a href="#"><span class="fa fa-twitter"></span> Twitter</a></li>
                        <li><a href="#"><span class="fa fa-google"></span>Google</a></li>
                    </ul>
                </div>
            </div>
            <div class="move-top text-center mt-lg-4 mt-3">
                <a href="#home"><span class="fa fa-angle-double-up" aria-hidden="true"></span></a>
            </div>
        </div>
    </div>
    <!-- //footer -->
    <!-- copyright -->
    <div class="cpy-right text-center py-3">
    </div>
    <!-- //copyright -->

</body>

</html>
