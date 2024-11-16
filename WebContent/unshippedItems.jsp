<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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

.btn-success {
    background-color: #28a745; /* Default green */
    border: none;
    color: white;
    padding: 10px 20px;
    font-size: 16px;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

/* Styling for hover */
.btn-success:hover {
    background-color: #218838; /* Darker green when hovered */
    transform: scale(1.05); /* Optional: Slight zoom on hover */
    color: white; /* Keep text white */
}

/* Ensure there are no conflicting styles overriding this */
a.btn-success:hover {
    background-color: #218838 !important;
    color: red !important;
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
		response.sendRedirect("loginFirst.jsp");
		return;
	}

	if (userName == null || password == null) {
		response.sendRedirect("loginFirst.jsp");
		return;
	}
	%>

	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="text-center">
			<h3 style="color: #ffffff; font-size: 24px; font-weight: bold;">UnShipped Orders</h3>
		</div>
		<div class="table-responsive">
			<table class="table table-hover table-sm">
				<thead>
					<tr>
						<th>TransactionId</th>
						<th>ProductId</th>
						<th>User Email Id</th>
						<th>Address</th>
						<th>Quantity</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>

					<%
					OrderServiceImpl orderdao = new OrderServiceImpl();

					List<OrderBean> orders = new ArrayList<OrderBean>();
					orders = orderdao.getAllOrders();
					int count = 0;
					for (OrderBean order : orders) {
						String transId = order.getTransactionId();
						String prodId = order.getProductId();
						int quantity = order.getQuantity();
						int shipped = order.getShipped();
						String userId = new TransServiceImpl().getUserId(transId);
						String userAddr = new UserServiceImpl().getUserAddr(userId);
						if (shipped == 0) {
							count++;
					%>

					<tr>
						<td><%=transId%></td>
						<td><a href="./updateProduct.jsp?prodid=<%=prodId%>"><%=prodId%></a></td>
						<td><%=userId%></td>
						<td><%=userAddr%></td>
						<td><%=quantity%></td>
						<td>READY_TO_SHIP</td>
						<td><a
							href="ShipmentServlet?orderid=<%=order.getTransactionId()%>&amount=<%=order.getAmount()%>&userid=<%=userId%>&prodid=<%=order.getProductId()%>"
							class="btn btn-success">SHIP NOW</a></td>
					</tr>

					<%
					}
					}
					%>
					<%
					if (count == 0) {
					%>
					<tr style="background-color: grey; color: white;">
						<td colspan="7" style="text-align: center;">No Items Available</td>

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
