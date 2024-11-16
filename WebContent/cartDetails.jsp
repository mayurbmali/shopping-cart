<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Cart Details</title>
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

<!-- Include the same CSS styling as the product page -->
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

.table-hover {
    background: rgba(255, 255, 255, 0.05); 
    border-radius: 15px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(10px);
    transition: transform 0.5s ease;
    width: 100%;
    margin: 20px 0;
    color: #fff;
}

/* Remove hover effect on tbody */
.container .table-hover tbody {
    background-color: transparent !important;
    color: #fff !important;
    pointer-events: none; /* Disable hover effects on tbody */
}

/* Keep tr hover effect disabled */
.container .table-hover tbody tr {
    background-color: rgba(255, 255, 255, 0.05) !important;
    color: #fff !important;
    pointer-events: auto; /* Allow interaction with rows only */
}


.container .table-hover tbody tr:hover {
    background-color: rgba(255, 255, 255, 0.05) !important; /* No change on hover */
    color: #fff !important; 
}
.table-hover thead {
    background-color:  #34495E;
    color: white;
    font-size: 16px;
    font-weight: bold;
}

.table-hover tbody {
    font-size: 15px;
    font-weight: bold;
}

.but1 {
    background: linear-gradient(135deg, #ffcc00, #ff9900); /* Bright gradient */
    color: #fff;
    border: none;
    border-radius: 30px;
    padding: 10px 25px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: transform 0.3s ease, background 0.3s ease, box-shadow 0.3s ease; /* Add transition for all properties */
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15); /* Soft shadow */
    letter-spacing: 1px;
    outline: none;
    position: relative;
    min-width: 120px; /* Ensure the button has a minimum width */
    vertical-align: middle; /* Align buttons properly inside table cells */
}

.but1:hover {
    background: linear-gradient(135deg, #ffdb4d, #ffa64d);
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    transform: scale(1.05); /* Slightly scale up the button */
}

.but1:active {
    background: linear-gradient(135deg, #ff9900, #ff6600);
    box-shadow: 0 3px 7px rgba(0, 0, 0, 0.1);
    transform: scale(0.98); /* Slightly reduce scale when clicked */
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

	String addS = request.getParameter("add");
	if (addS != null) {

		int add = Integer.parseInt(addS);
		String uid = request.getParameter("uid");
		String pid = request.getParameter("pid");
		int avail = Integer.parseInt(request.getParameter("avail"));
		int cartQty = Integer.parseInt(request.getParameter("qty"));
		CartServiceImpl cart = new CartServiceImpl();

		if (add == 1) {
			cartQty += 1;
			if (cartQty <= avail) {
				cart.addProductToCart(uid, pid, 1);
			} else {
				response.sendRedirect("./AddtoCart?pid=" + pid + "&pqty=" + cartQty);
			}
		} else if (add == 0) {
			cart.removeProductFromCart(uid, pid);
		}
	}
	%>
	

	<jsp:include page="header.jsp" />

	 <%
        String message = (String) session.getAttribute("message");
        if (message == null) {
            message = request.getParameter("message");
        }
        if (message != null && !message.isEmpty()) {
    %>
        <div class="alert alert-info text-center" style="margin-right: 500px;margin-left: 500px; font-weight: bold; color: #fa3628;">
            <%= message %>
        </div>
    <%
            session.removeAttribute("message");
        }
    %>
	<div class="text-center" style="color: white; font-size: 24px; font-weight: bold;">Cart Items</div>

	<!-- Start of Product Items List -->
	<div class="container">

		<table class="table table-hover">
			<thead>
				<tr>
					<th>Picture</th>
					<th>Products</th>
					<th>Price</th>
					<th>Quantity</th>
					<th>Add</th>
					<th>Remove</th>
					<th>Amount</th>
				</tr>
			</thead>
			<tbody>

				<%
				CartServiceImpl cart = new CartServiceImpl();
				List<CartBean> cartItems = cart.getAllCartItems(userName);
				double totAmount = 0;
				for (CartBean item : cartItems) {

					String prodId = item.getProdId();
					int prodQuantity = item.getQuantity();
					ProductBean product = new ProductServiceImpl().getProductDetails(prodId);
					double currAmount = product.getProdPrice() * prodQuantity;
					totAmount += currAmount;

					if (prodQuantity > 0) {
				%>

				<tr>
					<td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 50px; height: 50px;"></td>
					<td><%=product.getProdName()%></td>
					<td><%=product.getProdPrice()%></td>
					<td>
						<form method="post" action="./UpdateToCart">
							<input type="number" name="pqty" value="<%=prodQuantity%>" style="max-width: 70px;color: #0f0f0f; min="0">
							<input type="hidden" name="pid" value="<%=product.getProdId()%>">
							<input type="submit" name="Update" value="Update" style="max-width: 80px; color: #0f0f0f;">
						</form>
					</td>
					<td><a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>">
							<i class="fa fa-plus"></i></a>
					</td>
					<td><a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>">
							<i class="fa fa-minus"></i></a>
					</td>
					<td><%=currAmount%></td>
				</tr>

				<%
					}
				}
				%>

				<tr style="background-color: grey; color: white;">
					<td colspan="6" style="text-align: center;">Total Amount to Pay (in Rupees)</td>
					<td><%=totAmount%></td>
				</tr>

				<%
				if (totAmount != 0) {
				%>
				<tr style="background-color: grey; color: white;">
					<td colspan="4" style="text-align: center;"></td>
					<td>
						<form method="post">
							<button class='but1' formaction="userHome.jsp" >Cancel</button>
						</form>
					</td>
					<td colspan="2" align="center">
						<form method="post">
							<button class='but1' formaction="payment.jsp?amount=<%=totAmount%>">Pay Now</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<!-- End of Product Items List -->

	<%@ include file="footer.html" %>

</body>
</html>
