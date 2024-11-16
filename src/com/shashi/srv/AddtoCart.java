package com.shashi.srv;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shashi.beans.DemandBean;
import com.shashi.beans.ProductBean;
import com.shashi.service.impl.CartServiceImpl;
import com.shashi.service.impl.DemandServiceImpl;
import com.shashi.service.impl.ProductServiceImpl;

/**
 * Servlet implementation class AddtoCart
 */
@WebServlet("/AddtoCart")
public class AddtoCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddtoCart() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");
        String usertype = (String) session.getAttribute("usertype");
        if (userName == null || password == null || usertype == null || !usertype.equalsIgnoreCase("customer")) {
            response.sendRedirect("login.jsp?message=Session Expired, Login Again to Continue!");
            return;
        }

        // Login check successful
        String userId = userName;
        String prodId = request.getParameter("pid");
        int pQty = Integer.parseInt(request.getParameter("pqty")); // Quantity to add
        String action = request.getParameter("action"); // Get the action (either add or buy)

        CartServiceImpl cart = new CartServiceImpl();
        ProductServiceImpl productDao = new ProductServiceImpl();
        ProductBean product = productDao.getProductDetails(prodId);
        int availableQty = product.getProdQuantity();
        int cartQty = cart.getProductCount(userId, prodId);
        pQty += cartQty; // Update the quantity to include existing in the cart

        PrintWriter pw = response.getWriter();
        response.setContentType("text/html");

        // If quantity in cart and selected are the same, remove product from the cart
        if (pQty == cartQty) {
            String status = cart.removeProductFromCart(userId, prodId);
            RequestDispatcher rd = request.getRequestDispatcher("userHome.jsp");
            rd.include(request, response);
            pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
        } 
        // Check if available stock is less than requested
        else if (availableQty < pQty) {
            String status = null;

            if (availableQty == 0) {
                status = "Product is Out of Stock!";
            } else {
                cart.updateProductToCart(userId, prodId, availableQty);
                status = "Only " + availableQty + " of " + product.getProdName() +
                        " are available in the shop! Adding only " + availableQty + " products to your cart.";
            }
            // Add product to demand list if not enough stock
            DemandBean demandBean = new DemandBean(userName, product.getProdId(), pQty - availableQty);
            DemandServiceImpl demand = new DemandServiceImpl();
            boolean flag = demand.addProduct(demandBean);

            if (flag) {
                status += "<br/>We will notify you when " + product.getProdName() + " is back in stock!";
            }

            // Redirect to the cart details page with a message
            response.sendRedirect("cartDetails.jsp?message=" + status);
        } 
        // If sufficient stock is available
        else {
            String status = cart.updateProductToCart(userId, prodId, pQty);

            // Check if the action is 'buy', redirect to cartDetails.jsp for immediate purchase
            if ("buy".equalsIgnoreCase(action)) {
                response.sendRedirect("cartDetails.jsp?pid=" + prodId + "&message=Proceed to checkout");
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("userHome.jsp");
                rd.include(request, response);
                pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
