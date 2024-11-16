<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <style>
        body::-webkit-scrollbar {
            display: none;
        }
        body {
            position: relative;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            color: #fff;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('images/bgg6.jpg') no-repeat center center fixed;
            background-size: cover;
            filter: blur(5px); 
            z-index: -1;
        }

        .container {
            background: rgba(0, 0, 0, 0); 
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            position: relative;
            z-index: 1;
            padding: 50px;
            border: 1px solid #ddd;
        }

        .form-container {
            position: relative;
            background: rgba(255, 255, 255, 0.05);
            margin: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            transition: transform 0.5s ease;
            padding: 20px;
            color: #fff;
        }

        .form-container:hover {
            transform: translateY(-20px);
        }

        .form-container h2 {
            color: #ffcc00;
        }

        .form-group label {
            color: #ffcc00;
        }

        .btn-success, .btn-danger {
            background-color: #ff9900;
            border: none;
        }

        .btn-success:hover, .btn-danger:hover {
            background-color: #ffcc00;
        }
    </style>
</head>
<body>

    <%
        String utype = (String) session.getAttribute("usertype");
        String uname = (String) session.getAttribute("username");
        String pwd = (String) session.getAttribute("password");
        String prodid = request.getParameter("prodid");
        ProductBean product = new ProductServiceImpl().getProductDetails(prodid);
        if (prodid == null || product == null) {
            response.sendRedirect("updateProductById.jsp?message=Please Enter a valid product Id");
            return;
        } else if (utype == null || !utype.equals("admin")) {
            response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
            return;
        } else if (uname == null || pwd == null) {
            response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
            return;
        }
    %>

    <jsp:include page="header.jsp" />

    <div class="container">
        <form action="./UpdateProductSrv" method="post" class="form-container col-md-6 col-md-offset-3">
            <div class="text-center">
                <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product Image" height="100px" />
                <h2>Product Update Form</h2>
                <%
                    String message = request.getParameter("message");
                    if (message != null) {
                %>
                <p style="color: blue;"><%=message%></p>
                <%
                    }
                %>
            </div>

            <input type="hidden" name="pid" class="form-control" value="<%=product.getProdId()%>" required>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="product_name">Product Name</label>
                    <input type="text" placeholder="Enter Product Name" name="name" class="form-control"
                           value="<%=product.getProdName()%>" id="product_name" required>
                </div>
                <div class="col-md-6 form-group">
                    <label for="producttype">Product Type</label>
                    <select name="type" id="producttype" class="form-control" required>
                        <option value="mobile" <%="mobile".equalsIgnoreCase(product.getProdType()) ? "selected" : ""%>>MOBILE</option>
                        <option value="tv" <%="tv".equalsIgnoreCase(product.getProdType()) ? "selected" : ""%>>TV</option>
                        <option value="camera" <%="camera".equalsIgnoreCase(product.getProdType()) ? "selected" : ""%>>CAMERA</option>
                        <option value="laptop" <%="laptop".equalsIgnoreCase(product.getProdType()) ? "selected" : ""%>>LAPTOP</option>
                        <option value="tablet" <%="tablet".equalsIgnoreCase(product.getProdType()) ? "selected" : ""%>>TABLET</option>
                        <option value="speaker" <%="speaker".equalsIgnoreCase(product.getProdType()) ? "selected" : ""%>>SPEAKER</option>
                        <option value="other" <%="other".equalsIgnoreCase(product.getProdType()) ? "selected" : ""%>>Other Appliances</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="product_desc">Product Description</label>
                <textarea name="info" class="form-control" id="product_desc" required><%=product.getProdInfo()%></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="price">Unit Price</label>
                    <input type="number" placeholder="Enter Unit Price" name="price" class="form-control"
                           value="<%=product.getProdPrice()%>" id="price" required>
                </div>
                <div class="col-md-6 form-group">
                    <label for="quantity">Stock Quantity</label>
                    <input type="number" placeholder="Enter Stock Quantity" name="quantity" class="form-control"
                           value="<%=product.getProdQuantity()%>" id="quantity" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 text-center" style="margin-bottom: 2px;">
                    <button formaction="adminViewProduct.jsp" class="btn btn-danger">Cancel</button>
                </div>
                <div class="col-md-6 text-center">
                    <button type="submit" class="btn btn-success">Update Product</button>
                </div>
            </div>
        </form>
    </div>

    <jsp:include page="footer.html" />
</body>
</html>
