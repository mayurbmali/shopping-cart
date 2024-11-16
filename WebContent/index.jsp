<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title> TechBazaar</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<!-- Copying the same style from userhome.jsp -->
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
     transform: translateZ(0);
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
    bottom: -50px;
    display: flex;
    justify-content: center;
    opacity: 0;
    transition: all 0.4s ease;
}

.card:hover .sci {
    opacity: 1;
    bottom: 10px;
}

.card .sci button {
    background-color: #ffcc00;
    color: #000;
    border: none;
    border-radius: 5px;
    padding: 6px 5px;
    margin: 5px;
    font-size: 12px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
    width: 100px;
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

    boolean isValidUser = true;

    if (userType == null || userName == null || password == null || !userType.equals("customer")) {
        isValidUser = false;
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

    <div class="text-center" style="color: black; font-size: 14px; font-weight: bold;"><%=message%></div>

    <!-- Start of Product Items List -->
    <div class="container">
        <div class="row">
            <%
            for (ProductBean product : products) {
                int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
            %>
            <div class="col-sm-4">
                <div class="card">
                    <div class="content">
                        <div class="imgBx">
                            <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product Image" class="img-responsive">
                        </div>
                        <div class="contentBx">
                            <h3><%=product.getProdName()%><br><span>Rs <%=product.getProdPrice()%></span></h3>
                        </div>
                    </div>
                    <ul class="sci">
                        <button onclick="location.href='./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1'">Add to Cart</button>
                        <button onclick="location.href='./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1'">Buy Now</button>
                    </ul>
                </div>
            </div>
            <%
            }
            %>
        </div>
    </div>

    <!-- End of Product Items List -->

    <jsp:include page="footer.html" />

</body>
</html>
