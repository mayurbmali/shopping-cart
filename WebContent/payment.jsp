<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Payments</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

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
    background: rgba(0, 0, 0, 0.5); /* Darkened background for contrast */
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    padding: 30px;
    color: white; /* Text color */
}

h2 {
    color: #ffcc00; /* Gold color for headings */
    font-weight: bold;
}

.form-control {
    background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent input background */
    border: none;
    color: #000; /* Dark text for input fields */
    padding: 10px;
}

button {
    background: linear-gradient(135deg, #ffcc00, #ff9900);
    color: #fff;
    border: none;
    border-radius: 25px;
    padding: 10px 20px;
    font-size: 14px;
    font-weight: bold;
    text-transform: uppercase;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
    letter-spacing: 1px;
}

button:hover {
    background: linear-gradient(135deg, #ff9900, #ff6600);
    transform: translateY(-3px); /* Lift on hover */
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

button:active {
    transform: translateY(0); /* Click effect */
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
}

img {
    border-radius: 50%; /* Circular profile image */
    border: 3px solid #fff;
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

	String sAmount = request.getParameter("amount");
	double amount = 0;

	if (sAmount != null) {
		amount = Double.parseDouble(sAmount);
	}
	%>

	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row">
			<form action="./OrderServlet" method="post"
				class="col-md-6 col-md-offset-3">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						<img src="images/profile.jpg" alt="Payment Proceed" height="100px" />
						<h2>Credit Card Payment</h2>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label for="cardholder">Name of Card Holder</label>
						<input type="text" placeholder="Enter Card Holder Name"
							name="cardholder" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label for="cardnumber">Enter Credit Card Number</label>
						<input type="number" placeholder="4242-4242-4242-4242" name="cardnumber"
							class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="expmonth">Expiry Month</label>
						<input type="number" placeholder="MM" name="expmonth"
							class="form-control" max="12" min="1" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="expyear">Expiry Year</label>
						<input type="number" placeholder="YYYY" class="form-control" name="expyear" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="cvv">Enter CVV</label>
						<input type="number" placeholder="123" class="form-control" name="cvv" required>
						<input type="hidden" name="amount" value="<%=amount%>">
					</div>
					<div class="col-md-6 form-group">
						<label>&nbsp;</label>
						<button type="submit" class="form-control">
							Pay : Rs <%=amount%>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<%@ include file="footer.html"%>

</body>
</html>

