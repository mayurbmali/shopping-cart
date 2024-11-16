<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="com.shashi.service.impl.*, com.shashi.service.*" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Logout Header</title>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
            <link rel="stylesheet" href="css/changes.css">
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
            <!-- jQuery -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

            <!-- Bootstrap JavaScript -->
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

            <style>
                body {
                    background-color: #F4F4F4;
                }

                /* Header styling */
                .header {
                    background-color: ##3b8a58;
                    color: white;
                    padding: 20px;
                    text-align: center;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                }

                .header h2 {
                margin-top:90px;
                    font-family: 'Roboto', sans-serif;
                    font-weight: bold;
                }

                .header h6 {
                    font-family: 'Lato', sans-serif;
                    font-weight: normal;
                }

                /* Navbar styling */
                .navbar-default {
                    background-color:  #2d2d30;
                    border: none;
                    font-size: 16px;
                    padding: 15px 0;
                }

                .navbar-default .navbar-nav>li>a {
                    color: #2d2d30;
                    font-family: 'Lato', sans-serif;
                    font-weight: bold;
                }

                .navbar-default .navbar-nav>li>a:hover {
                    color: #2d2d30;
                    transition: color 0.3s ease;
                }

                .navbar-default .navbar-brand {
                    color: #2ECC71;
                    font-weight: bold;
                }

                .navbar-default .navbar-brand:hover {
                    color: #fff;
                }

                /* Cart icon styling */
                #mycart i {
                    position: relative;
                    color: white;
                }

                #mycart i:after {
                    content: attr(data-count);
                    position: absolute;
                    top: -8px;
                    right: -10px;
                    background-color: #f00;
                    color: #fff;
                    padding: 5px;
                    border-radius: 50%;
                    font-size: 12px;
                }

                /* Dropdown Menu */
                .dropdown-menu {
                    background-color: #2ECC71;
                }

                .dropdown-menu>li>a {
                    color: white;
                    padding: 10px 20px;
                }

                .dropdown-menu>li>a:hover {
                    background-color: #27ae60;
                }

                /* Search bar styling */
                .input-group .form-control {
                    border-radius: 0;
                }

                .input-group-btn .btn {
                    background-color: #e74c3c;
                    border: none;
                }

                .input-group-btn .btn:hover {
                    background-color: #c0392b;
                }

                /* Hover effect for buttons */
                .btn {
                    transition: background-color 0.3s ease;
                }
            </style>
        </head>

        <body>
            <!-- Company Header -->
            <div class="header">
                <h2>TechBazaar</h2>
                <h6>We specialize in Electronics</h6>
                <form class="form-inline" action="index.jsp" method="get">
                    <div class="input-group">
                        <input type="text" class="form-control" size="50" name="search" placeholder="Search Items"
                            required>
                        <div class="input-group-btn">
                            <input type="submit" class="btn btn-danger" value="Search">
                        </div>
                    </div>
                </form>
            </div>
            <!-- End of Company Header -->

            <% String userType=(String) session.getAttribute("usertype"); if (userType==null) { %>

                <!-- Guest Navigation Bar -->
                <nav class="navbar navbar-default navbar-fixed-top" style="background-color:  #2d2d30;">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="index.jsp">
                                <span class="glyphicon glyphicon-home"></span>&nbsp;TechBazaar
                            </a>
                        </div>
                        <div class="collapse navbar-collapse" id="myNavbar">
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="login.jsp">Login</a></li>
                                <li><a href="register.jsp">Register</a></li>
                                <li><a href="index.jsp">Products</a></li>
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span
                                            class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="index.jsp?type=mobile">Mobiles</a></li>
                                        <li><a href="index.jsp?type=tv">TVs</a></li>
                                        <li><a href="index.jsp?type=laptop">Laptops</a></li>
                                        <li><a href="index.jsp?type=camera">Cameras</a></li>
                                        <li><a href="index.jsp?type=speaker">Speakers</a></li>
                                        <li><a href="index.jsp?type=tablet">Tablets</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <% } else if ("customer".equalsIgnoreCase(userType)) { int notf=new
                    CartServiceImpl().getCartCount((String) session.getAttribute("username")); %>

                    <!-- Customer Navigation Bar -->
                                   <nav class="navbar navbar-default navbar-fixed-top" style="background-color:  transparent;">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse"
                                    data-target="#myNavbar">
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand" href="userHome.jsp">
                                    <span class="glyphicon glyphicon-home"></span>&nbsp;Shopping Center
                                </a>
                            </div>
                            <div class="collapse navbar-collapse" id="myNavbar">
                                <ul class="nav navbar-nav navbar-right">
                                    <li><a href="userHome.jsp"><span
                                                class="glyphicon glyphicon-home">Products</span></a></li>
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span
                                                class="caret"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a href="userHome.jsp?type=mobile">Mobiles</a></li>
                                            <li><a href="userHome.jsp?type=tv">TVs</a></li>
                                            <li><a href="userHome.jsp?type=laptop">Laptops</a></li>
                                            <li><a href="userHome.jsp?type=camera">Cameras</a></li>
                                            <li><a href="userHome.jsp?type=speaker">Speakers</a></li>
                                            <li><a href="userHome.jsp?type=tablet">Tablets</a></li>
                                        </ul>
                                    </li>
                                    <% if (notf==0) { %>
                                        <li><a href="cartDetails.jsp"><span
                                                    class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Cart</a></li>
                                        <% } else { %>
                                            <li><a href="cartDetails.jsp" id="mycart">
                                                    <i data-count="<%=notf%>" class="fa fa-shopping-cart fa-3x"></i>
                                                </a></li>
                                            <% } %>
                                                <li><a href="orderDetails.jsp">Orders</a></li>
                                                <li><a href="userProfile.jsp">Profile</a></li>
                                                <li><a href="./LogoutSrv">Logout</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>

                    <% } else { %>

                        <!-- Admin Navigation Bar -->
                                   <nav class="navbar navbar-default navbar-fixed-top" style="background-color:  #2d2d30;">
                            <div class="container-fluid">
                                <div class="navbar-header">
                                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                                        data-target="#myNavbar">
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </button>
                                    <a class="navbar-brand" href="adminViewProduct.jsp">
                                        <span class="glyphicon glyphicon-home"></span>&nbsp;TechBazaar
                                    </a>
                                </div>
                                <div class="collapse navbar-collapse" id="myNavbar">
                                    <ul class="nav navbar-nav navbar-right">
                                        <li><a href="adminViewProduct.jsp">Products</a></li>
                                        <li class="dropdown">
                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span
                                                    class="caret"></span></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="adminViewProduct.jsp?type=mobile">Mobiles</a></li>
                                                <li><a href="adminViewProduct.jsp?type=tv">TVs</a></li>
                                                <li><a href="adminViewProduct.jsp?type=laptop">Laptops</a></li>
                                                <li><a href="adminViewProduct.jsp?type=camera">Cameras</a></li>
                                                <li><a href="adminViewProduct.jsp?type=speaker">Speakers</a></li>
                                                <li><a href="adminViewProduct.jsp?type=tablet">Tablets</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="adminStock.jsp">Stock</a></li>
                                        <li><a href="shippedItems.jsp">Shipped</a></li>
                                        <li><a href="unshippedItems.jsp">Orders</a></li>
                                        <li class="dropdown">
                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Update Items
                                                <span class="caret"></span></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="addProduct.jsp">Add Product</a></li>
                                                <li><a href="removeProduct.jsp">Remove Product</a></li>
                                                <li><a href="updateProductById.jsp">Update Product</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="./LogoutSrv">Logout</a></li>
                                    </ul>
                                </div>
                            </div>
                        </nav>

                        <% } %>
        </body>

        </html>