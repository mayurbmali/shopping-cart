<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Order Details</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/changes.css">

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
    background: rgba(0, 0, 0, 0); /* Darkened background for contrast */
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    z-index: 1;
    padding: 50px;
    border: 1px solid #ddd;
}


h2, .text-center {
    color: #ffcc00; /* Gold color for headings */
    font-weight: bold;
    margin-bottom: 20px;
}

.table {
    background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent background for the table */
    border-radius: 10px;
    color: #000; /* Dark text for better readability */
}

.table th {
    background-color: black;
    color: white;
    font-weight: bold;
    font-size: 14px;
}

.table td {
    font-size: 14px;
    font-weight: bold;
    color: #333;
}

.table-hover tbody tr:hover {
    background-color: #f1f1f1; /* Light hover effect */
}

img {
    border-radius: 50%; /* Circular image style */
    border: 2px solid #fff;
}

.text-success {
    color: #28a745 !important; /* Bright green for success text */
}
</style>
</head>
<body>

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	OrderService dao = new OrderServiceImpl();
	List<OrderDetails> orders = dao.getAllOrderDetails(userName);
	%>

	<jsp:include page="header.jsp" />

	<div class="text-center" style="font-size: 24px;">Order Details</div>

	<!-- Start of Product Items List -->
	<div class="container">
		<div class="table-responsive">
			<table class="table table-hover table-sm">
				<thead>
					<tr>
						<th>Picture</th>
						<th>Product Name</th>
						<th>Order ID</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Time</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (OrderDetails order : orders) {
					%>

					<tr>
						<td><img src="./ShowImage?pid=<%=order.getProductId()%>"
							style="width: 50px; height: 50px;"></td>
						<td><%=order.getProdName()%></td>
						<td><%=order.getOrderId()%></td>
						<td><%=order.getQty()%></td>
						<td>Rs <%=order.getAmount()%></td>
						<td><%=order.getTime()%></td>
						<td class="text-success">
							<%=order.getShipped() == 0 ? "ORDER PLACED" : "ORDER SHIPPED"%>
						</td>
					</tr>

					<%
					}
					%>

				</tbody>
			</table>
		</div>
	</div>
	<!-- End of Product Items List -->

	<%@ include file="footer.html"%>

</body>
</html>
