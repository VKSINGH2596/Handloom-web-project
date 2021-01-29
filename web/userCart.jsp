
<%@page import="java.util.*"%>
<%@page import="JavaServlet.ConnectionManager"%>
<%@ page language="java" 
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="JavaServlet.UserBean"
         import="java.sql.*"
         import="JavaServlet.ConnectionManager"
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
        
        thead,tfoot {
            background-color: #3f87a6;
            color: #fff;
        }

        tbody {
            background-color: #e4f0f5;
        }

        caption {
            padding: 10px;
            caption-side: bottom;
        }

        table {
            border-collapse: collapse;
            border: 2px solid rgb(200, 200, 200);
            letter-spacing: 1px;
            font-family: sans-serif;
            font-size: .8rem;
        }

        td,
        th {
            border: 1px solid rgb(190, 190, 190);
            padding: 5px 10px;
        }

        td {
            text-align: center;
        }
    </style>

</head>

<body>
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
                            <li class="active"><a href="userAbout.jsp">About Us</a></li>
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
                            <li><a href="userShop.jsp">Collections</a></li>
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
    <!-- /banner-bottom -->
    <!--/banner-bottom -->
    <section class="container">
        
        <% ArrayList<String> pName = new ArrayList<String>();               // Creating ArrayList elements to store the MyCart table (mysql) data
           ArrayList<String> pID = new ArrayList<String>();
           List<Integer> price = new ArrayList<>();
           List<Integer> quantity = new ArrayList<>();
           
           try{
               String cusID = currentUser.getCustomerID();                            // Getting customer ID from UserBean object for mysql quesry
               String query = "SELECT * FROM MyCart WHERE CustomerID='"+cusID+"'";    // Query to search the products for the current customer
               Connection con = ConnectionManager.getConnection();              // Making the connection instance and getting the object from ConnectionManager class
               PreparedStatement ps = con.prepareStatement(query);
               ResultSet rs = ps.executeQuery();                            // Executing the query and storing the result into ResultSet pointer
               
               while(rs.next()) {                                   // Loop to retrieve the respected product data for the particular customer
                   pName.add(rs.getString("ProductName"));
                   pID.add(rs.getString("ProductID"));
                   price.add(rs.getInt("Price"));
                   quantity.add(rs.getInt("Quantity"));
               }
               
               out.print("<div>");
                    out.print("<h2 style='margin-top:20px; position:relative; top:20px;'> YOUR FINAL CART: </h2>");
                    out.print("<br>");
                    out.print("<table>");                                   // Creating a HTML table to print the following product details
                        out.print("<thead>");
                            out.print("<tr>");
                                out.print("<th style=''> Product Name </th>");
                                out.print("<th> Product ID </th>");
                                out.print("<th> Quantity </th>");
                                out.print("<th> Price </th>");
                            out.print("</tr>");
                        out.print("</thead>");
                        out.print("<tbody>");

                    int sum=0;                                             // Initializing an integer to get the final sum from the table
                    for(int i=0;i<pName.size();i++) {                       // Running the loop upto the size of ArrayList i.e., totat products for customer in their cart 
                            out.print("<tr>"); 
                                out.print("<td> "+pName.get(i)+" </td>");
                                out.print("<td> "+pID.get(i)+" </td>");
                                out.print("<td> "+quantity.get(i)+" </td>");
                                out.print("<td> "+price.get(i)+" </td>");
                            out.print("</tr>");

                    sum = sum + (price.get(i)*quantity.get(i));             // SUM = SUM + (PRICE of particular product * QUANTITY of that product) after each iteration the sum gets updated
                    }

                        out.print("</tbody>");
                        out.print("<br>");
                        out.print("<tfoot>");
                            out.print("<tr>");
                                out.print("<td></td>");
                                out.print("<td></td>");
                                out.print("<td><strong> TOTALS: </strong></td>");
                                out.print("<th> "+sum+" </th>");            // Printing the final sum on the footer of table
                            out.print("</tr>");
                    out.print("</table>");


               out.print("</div>");
               
           }
           catch(SQLException e) {                                              // Using Exception handling to catch any runtime error while establishing Connection
               e.printStackTrace();
           } %>
           
    </section>

    <!--/Address entry for Product delivery -->
    <section class="newsletter-w3pvt py-5">
        <div class="container py-md-5">
                <p class="text-center" id="addstatus">Please provide below the Address for product delivery.</p>
                <div class="row subscribe-sec">
                    <div class="col-md-9">
                        <textarea placeholder="Enter Your Address.." name="address" required="" maxlength="250"></textarea>
                    </div>
                    <div class="col-md-3">
                        <button class="btn submit" id="pressed">Submit</button>
                    </div>
                </div>
        </div>
    </section>
    <!--//Address entry for Product delivery -->
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
                            <a href="userShop.html"><span class="fa fa-angle-right" aria-hidden="true"></span>Collections</a>
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
