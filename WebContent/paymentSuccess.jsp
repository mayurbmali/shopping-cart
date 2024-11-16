<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
</head>
<body>
    <h1>Payment Successful!</h1>
    <p>Payment ID: <%= request.getParameter("paymentId") %></p>
    <p>Thank you for your purchase.</p>
</body>
</html>
