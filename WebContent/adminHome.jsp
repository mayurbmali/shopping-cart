<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
    import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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

.container1 {
    background: rgba(0, 0, 0, 0); 
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    position: relative;
    z-index: 1;
    padding: 20px 0px;
    border: 0.5px solid #ddd;
}

.card {
    position: relative;
    background: rgba(255, 255, 255, 0.05);
    margin: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
    border-radius: 15px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    backdrop-filter: blur(10px);
    transition: transform 0.5s ease;
    padding: 20px;
    color: #fff;

    height: 150px;
    text-align: center;
}

.card:hover {
    transform: translateY(-20px);
}

button {
    background-color: rgba(255, 255, 255, 0.05);
    color: #ffcc00;
    border: none;
    padding: 10px 20px;
    font-size: 18px;
    border-radius: 5px;
    transition: background-color 0.3s;
}

button:hover {
    background-color: rgba(255, 255, 255, 0.15);
    color: #ff9900;
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

    }

    else if (userName == null || password == null) {

        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");

    }
    %>

    <jsp:include page="header.jsp" />

    <div class="container1">
        <div class="row">
            <div class="col text-center" style="color: White;">
                <h2>Admin Panel</h2>
            </div>
        </div>

        <div class="row">
            <!-- Card 1 -->
            <div class="col-xs-6 col-md-6">
                <div class="card">
                    <h3>
                        <form action="adminViewProduct.jsp" method="get">
                            <button type="submit">View Products</button>
                        </form>
                    </h3>
                </div>
            </div>
            <!-- Card 2 -->
            <div class="col-xs-6 col-md-6">
                <div class="card">
                    <h3>
                        <form action="addProduct.jsp" method="get">
                            <button type="submit">Add Products</button>
                        </form>
                    </h3>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Card 3 -->
            <div class="col-xs-6 col-md-6">
                <div class="card">
                    <h3>
                        <form action="removeProduct.jsp" method="get">
                            <button type="submit">Remove Products</button>
                        </form>
                    </h3>
                </div>
            </div>
            <!-- Card 4 -->
            <div class="col-xs-6 col-md-6">
                <div class="card">
                    <h3>
                        <form action="updateProductById.jsp" method="get">
                            <button type="submit">Update Products</button>
                        </form>
                    </h3>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
