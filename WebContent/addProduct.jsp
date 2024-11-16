<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
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
        /* Checking the user credentials */
        String userType = (String) session.getAttribute("usertype");
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        if (userType == null || !userType.equals("admin")) {
            response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
        } else if (userName == null || password == null) {
            response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        }
    %>

    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="row">
            <form action="./AddProductSrv" method="post" enctype="multipart/form-data" class="form-container col-md-6 col-md-offset-3">
                <div class="text-center">
                    <h2>Product Addition Form</h2>
                    <%
                        String message = request.getParameter("message");
                        if (message != null) {
                    %>
                    <p style="color: blue;"><%=message%></p>
                    <%
                        }
                    %>
                </div>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="product_name">Product Name</label>
                        <input type="text" placeholder="Enter Product Name" name="name" class="form-control" id="product_name" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="producttype">Product Type</label>
                        <select name="type" id="producttype" class="form-control" required>
                            <option value="mobile">MOBILE</option>
                            <option value="tv">TV</option>
                            <option value="camera">CAMERA</option>
                            <option value="laptop">LAPTOP</option>
                            <option value="tablet">TABLET</option>
                            <option value="speaker">SPEAKER</option>
                            <option value="other">Other Appliances</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="product_desc">Product Description</label>
                    <textarea name="info" class="form-control" id="product_desc" required></textarea>
                </div>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="price">Unit Price</label>
                        <input type="number" placeholder="Enter Unit Price" name="price" class="form-control" id="price" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="quantity">Stock Quantity</label>
                        <input type="number" placeholder="Enter Stock Quantity" name="quantity" class="form-control" id="quantity" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="image">Product Image</label>
                    <input type="file" placeholder="Select Image" name="image" class="form-control" id="image" required>
                </div>

                <div class="row">
                    <div class="col-md-6 text-center" style="margin-bottom: 2px;">
                        <button type="reset" class="btn btn-danger">Reset</button>
                    </div>
                    <div class="col-md-6 text-center">
                        <button type="submit" class="btn btn-success">Add Product</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="footer.html" />

</body>
</html>
