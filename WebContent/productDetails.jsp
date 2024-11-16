<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*, com.shashi.beans.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>TechBazaar - Product Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            position: relative;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            color: #fff;
            background: url('images/bgg6.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            z-index: -1;
        }

        .container {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 50px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            margin-top: 50px;
        }

        .row {
            display: flex;
            align-items: center;
        }

        .card {
            background: rgba(255, 255, 255, 0.05);
            margin: 20px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.5s ease;
            height: 100%;
        }

        .card:hover {
            transform: translateY(-20px);
        }

        .imgBx {
            width: 100%;
            max-width: 400px;
            height: auto;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .imgBx img {
            width: 100%;
            height: auto;
            object-fit: contain;
        }

        .contentBx {
            text-align: center;
        }

        .contentBx h3 {
            color: #FFFFFF;
            font-size: 30px;
            font-weight: bolder;
        }

        .contentBx p {
            color: #00FFFF;
            font-size: 18px;
        }

        .btn {
            margin: 5px;
        }

        .breadcrumb {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }

        /* Flexbox layout for image and description */
        .product-layout {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .product-layout .image-container, .product-layout .description-container {
            flex: 1 1 45%;
            padding: 20px;
        }

        @media (max-width: 768px) {
            .product-layout {
                flex-direction: column;
            }

            .product-layout .image-container, .product-layout .description-container {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>
    <%
        // Checking user credentials
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        if (userName == null || password == null) {
            response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        }

        // Fetch product list and find the specific product by ID
        String prodId = request.getParameter("pid");
        ProductServiceImpl prodDao = new ProductServiceImpl();
        List<ProductBean> products = prodDao.getAllProducts();
        ProductBean product = null;

        // Search for the product by ID
        for (ProductBean p : products) {
            if (p.getProdId().equals(prodId)) {
                product = p;
                break;
            }
        }

        if (product != null) {
            // Fetch cart quantity
            int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
    %>
    <div class="container">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page"><%= product.getProdName() %></li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row product-layout">
            <div class="image-container">
                <div class="card imgBx">
                    <img src="./ShowImage?pid=<%= product.getProdId() %>" alt="Product Image" class="img-responsive">
                </div>
            </div>
            <div class="description-container">
                <div class="card">
                    <div class="contentBx">
                        <!-- Display product name and price -->
                        <h3><%= product.getProdName() %></h3>
                        <p>Price: Rs <%= product.getProdPrice() %></p>

                        <!-- Display full product description -->
                        <h3>Description</h3>
                        <p><%= product.getProdInfo() %></p>

                        <!-- Add to Cart and Buy Now buttons -->
                        <form method="post">
                            <%
                            if (cartQty == 0) {
                            %>
                            <!-- Add to Cart Button -->
                            <button type="submit" formaction="./AddtoCart?pid=<%= product.getProdId() %>&pqty=1&action=add" class="btn btn-success">Add to Cart</button>
                            
                            <!-- Buy Now Button - Redirect to Checkout -->
                            <button type="submit" formaction="./AddtoCart?pid=<%= product.getProdId() %>&pqty=1&action=buy" class="btn btn-primary">Buy Now</button>
                            <%
                            } else {
                            %>
                            <!-- Remove from Cart and Checkout Buttons -->
                            <button type="submit" formaction="./AddtoCart?pid=<%= product.getProdId() %>&pqty=0&action=remove" class="btn btn-danger">Remove From Cart</button>
                            <button type="submit" formaction="cartDetails.jsp" class="btn btn-success">Checkout</button>
                            <%
                            }
                            %>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        } else {
            out.println("<div class='container'><p>Product not found.</p></div>");
        }
    %>

    <%@ include file="footer.html" %>
</body>
</html>
