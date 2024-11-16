<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
    import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>View Products</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
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
    background: rgba(0, 0, 0, 0);
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    position: relative;
    z-index: 1;
    padding: 50px;
}

.card {
    position: relative;
    background: rgba(255, 255, 255, 0.05);
    margin: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
    border-radius: 15px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    backdrop-filter: blur(10px);
    transition: transform 0.5s ease;
    height: 350px;
    padding: 20px;
}

.card:hover {
    transform: translateY(-20px);
}

.card .content {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

.card .imgBx {
    width: 200px;
    height: 200px;
    overflow: hidden;
    margin-bottom: 5px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card .imgBx img {
   width: 100%;
    height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease; 
}

.card:hover .imgBx {
    transform: translateY(-10px);
    box-shadow: 0 20px 30px rgba(0, 0, 0, 0.5);
}

.card .imgBx:hover img {
    transform: scale(1.1);
}

.card .contentBx h3 {
    color: #ffcc00;
    font-size: 18px;
}

.card .contentBx h3 span {
    font-size: 16px;
    color: #ff9900;
}

.card .sci {
    position: absolute;
    bottom: -50px; /* Positioned below the card */
    display: flex;
    justify-content: center;
    opacity: 0;
    transition: all 0.4s ease;
    flex-direction: row; /* Align buttons vertically */
    align-items: center;
}

.card:hover .sci {
    opacity: 1;
    bottom: 10px; /* Slide the buttons up */
}

.card .sci button {
    background-color: #ffcc00;
    color: #000;
    border: none;
    border-radius: 5px;
    padding: 6px 3px;
    margin: 5px;
    font-size: 12px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
    width: 100px;
    margin-right:30px;
}

.card .sci button:hover {
    background-color: #ff9900;
}


.row {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
}

</style>

</head>
<body>

    <%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");
    String userType = (String) session.getAttribute("usertype");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
    } else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }
    ProductServiceImpl prodDao = new ProductServiceImpl();
    List<ProductBean> products = new ArrayList<ProductBean>();

    String search = request.getParameter("search");
    String type = request.getParameter("type");
    String message = "All Products";
    if (search != null) {
        products = prodDao.searchAllProducts(search);
        message = "Showing Results for '" + search + "'";
    } else if (type != null) {
        products = prodDao.getAllProductsByType(type);
        message = "Showing Results for '" + type + "'";
    } else {
        products = prodDao.getAllProducts();
    }
    if (products.isEmpty()) {
        message = "No items found for the search '" + (search != null ? search : type) + "'";
        products = prodDao.getAllProducts();
    }
    %>

    <jsp:include page="header.jsp" />

    <div class="text-center" style="color: black; font-size: 14px; font-weight: bold;">
        <%=message%>
    </div>

    <!-- Start of Product Items List -->
    <div class="container">
        <div class="row">
            <%
            for (ProductBean product : products) {
            %>
            <div class="col-sm-4">
                <div class="card">
                    <div class="content">
                        <div class="imgBx">
                            <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product Image">
                        </div>
                        <div class="contentBx">
                            <h3><%=product.getProdName()%><br><span>Rs <%=product.getProdPrice()%></span></h3>
                        </div>
                    </div>
                    <ul class="sci">
                        <form method="post">
                            <button type="submit"
                                formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>"
                                class="btn btn-danger">Remove Product</button>
                            <button type="submit"
                                formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>"
                                class="btn btn-primary">Update Product</button>
                        </form>
                    </ul>
                </div>
            </div>
            <%
            }
            %>
        </div>
    </div>
    <!-- End of Product Items List -->

	<%@ include  file="footer.html"%>

</body>
</html>
