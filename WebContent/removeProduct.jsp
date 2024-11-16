<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Remove Product</title>
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
}

.card:hover {
    transform: translateY(-20px);
}

.text-center p {
    font-size: 18px;
}

.breadcrumb {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
}

.form-group label {
    color: #fff;
}

.form-group input {
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
	}

	else if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}
	%>

	<jsp:include page="header.jsp" />

	<%
	String message = request.getParameter("message");
	%>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body text-center">
						<h3 style="color: green;">Product Deletion Form</h3>
						<%
						if (message != null) {
						%>
						<p style="color: blue;">
							<%=message%>
						</p>
						<%
						}
						%>
					</div>
					<form action="./RemoveProductSrv" method="post" class="col-md-8 col-md-offset-2">
						<div class="form-group">
							<label for="prodid">Product Id</label>
							<input type="text" placeholder="Enter Product Id" name="prodid" class="form-control" id="prodid" required>
						</div>
						<div class="row">
							<div class="col-md-6 text-center">
								<a href="adminViewProduct.jsp" class="btn btn-info">Cancel</a>
							</div>
							<div class="col-md-6 text-center">
								<button type="submit" class="btn btn-danger">Remove Product</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>

</body>
</html>
