<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Product Stocks</title>
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

.container {
    background: rgba(0, 0, 0, 0); 
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    position: relative;
    z-index: 1;
    padding: 50px;
    border: 1px solid #ddd;
}

.table-responsive {
    background: rgba(0, 0, 0, 0);
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    padding: 20px;
}

.table {
    
    border-radius: 10px;
}

.table th {
    background-color: #2c6c4b;
    color: white;
    font-size: 18px;
    text-align: center;
}

.table td {
    text-align: center;
    font-size: 16px;
    color: #fff;
}

.table-hover tbody tr:hover {
    background-color: transparent !important; /* Ensure background color doesn't change */
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3); /* Add a shadow effect */
    transition: box-shadow 0.3s ease; /* Smooth transition for shadow effect */
    transform: scale(1.01); /* Optional: Slight zoom effect */
}


.card {
    position: relative;
    background: rgba(255, 255, 255, 0.05);
    margin: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
    border-radius: 15px;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
    backdrop-filter: blur(10px);
}

.card:hover {
    transform: translateY(-20px);
}

.breadcrumb {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
}

.form-group label, .text-center, h3 {
    color: #fff;
}

.form-group input, .btn {
    background-color: #fff;
    color: #000;
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
		return;
	} else if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
		return;
	}
	%>

	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="text-center">
			<h3 style="color: green; font-size: 24px; font-weight: bold;">Stock Products</h3>
		</div>
		<div class="table-responsive">
			<table class="table table-hover table-sm">
				<thead>
					<tr>
						<th>Image</th>
						<th>ProductId</th>
						<th>Name</th>
						<th>Type</th>
						<th>Price</th>
						<th>Sold Qty</th>
						<th>Stock Qty</th>
						<th colspan="2" style="text-align: center">Actions</th>
					</tr>
				</thead>
				<tbody>

					<%
					ProductServiceImpl productDao = new ProductServiceImpl();
					List<ProductBean> products = new ArrayList<ProductBean>();
					products = productDao.getAllProducts();
					for (ProductBean product : products) {
					%>

					<tr>
						<td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 50px; height: 50px;"></td>
						<td><a href="./updateProduct.jsp?prodid=<%=product.getProdId()%>" style="color: #fff;"><%=product.getProdId()%></a></td>
						<%
						String name = product.getProdName();
						name = name.substring(0, Math.min(name.length(), 25)) + "..";
						%>
						<td><%=name%></td>
						<td><%=product.getProdType().toUpperCase()%></td>
						<td><%=product.getProdPrice()%></td>
						<td><%=new OrderServiceImpl().countSoldItem(product.getProdId())%></td>
						<td><%=product.getProdQuantity()%></td>
						<td>
							<form method="post">
								<button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn btn-primary">Update</button>
							</form>
						</td>
						<td>
							<form method="post">
								<button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>" class="btn btn-danger">Remove</button>
							</form>
						</td>
					</tr>

					<%
					}
					if (products.size() == 0) {
					%>
					<tr style="background-color: grey; color: white;">
						<td colspan="9" style="text-align: center;">No Items Available</td>
					</tr>
					<%
					}
					%>

				</tbody>
			</table>
		</div>
	</div>

	<%@ include file="footer.html"%>

</body>
</html>
