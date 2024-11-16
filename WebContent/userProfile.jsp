<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile Details</title>
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
    background: url('images/bgg6.jpg') no-repeat center center fixed;
    background-size: cover;
    color: #fff;
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    min-height: 100vh;
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
    filter: blur(5px); /* Background blur effect */
    z-index: -1;
}

.container {
    background: rgba(0, 0, 0, 0); /* Fully transparent background */
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    position: relative;
    z-index: 1;
    padding: 10px;
    border: 1px solid #ddd;
    max-width: 1200px; /* Ensures container width is capped */
    margin: 0 auto; /* Centers the container */
}


.card {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
    padding: 20px;
    margin-top: 20px;
    margin-bottom: 20px;
    border-radius: 15px;
    backdrop-filter: blur(10px); /* Glass effect */
    transition: transform 0.5s ease;
    padding: 30px; /* Adds space inside the card */
    color: #fff;
    width: 100%;
}

.card:hover {
    transform: translateY(-10px); /* Smooth hover effect */
}

.card-body {
    padding: 20px;
}

.row {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.row p {
    margin: 0;
    font-size: 16px;
}

.col-sm-3 {
    text-align: left;
    font-weight: bold;
    color: #ffcc00;
}

.col-sm-9 {
    text-align: left;
    color: #fff;
}

hr {
    border: none;
    height: 1px;
    background: rgba(255, 255, 255, 0.2);
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

	UserService dao = new UserServiceImpl();
	UserBean user = dao.getUserDetails(userName, password);
	if (user == null)
		user = new UserBean("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");
	%>

	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row">
			<div class="col">
				<nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
					<ol class="breadcrumb mb-0">
						<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
						<li class="breadcrumb-item"><a href="profile.jsp">User Profile</a></li>
					</ol>
				</nav>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-4">
				<div class="card mb-4">
					<div class="card-body text-center">
						<img src="images/profile.jpg" class="rounded-circle img-fluid"
							style="width: 150px;">
						<h5 class="my-3">Hello <%=user.getName()%> here!!</h5>
					</div>
				</div>
				
			</div>
			<div class="col-lg-8 mx-auto">
    <div class="card">
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-sm-3">
                    <p class="mb-0">Full Name</p>
                </div>
                <div class="col-sm-9">
                    <p class="text-muted mb-0"><%= user.getName() %></p>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <p class="mb-0">Email</p>
                </div>
                <div class="col-sm-9">
                    <p class="text-muted mb-0"><%= user.getEmail() %></p>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <p class="mb-0">Phone</p>
                </div>
                <div class="col-sm-9">
                    <p class="text-muted mb-0"><%= user.getMobile() %></p>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <p class="mb-0">Address</p>
                </div>
                <div class="col-sm-9">
                    <p class="text-muted mb-0"><%= user.getAddress() %></p>
                </div>
            </div>
            <hr>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <p class="mb-0">PinCode</p>
                </div>
                <div class="col-sm-9">
                    <p class="text-muted mb-0"><%= user.getPinCode() %></p>
                </div>
            </div>
        </div>
    </div>
</div>

		</div>
	</div>

	<jsp:include page="footer.html" />

</body>
</html>
