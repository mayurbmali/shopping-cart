import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/createOrder")
public class PaymentServlet extends HttpServlet {

    private static final String RAZORPAY_KEY = "YOUR_API_KEY";
    private static final String RAZORPAY_SECRET = "YOUR_API_SECRET";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            double amount = Double.parseDouble(request.getParameter("amount"));
            RazorpayClient razorpay = new RazorpayClient(RAZORPAY_KEY, RAZORPAY_SECRET);

            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", (int)(amount * 100)); // Convert amount to paise
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "txn_123456");
            orderRequest.put("payment_capture", 1); // Auto capture payment

            Order order = razorpay.orders.create(orderRequest);
            String orderId = order.get("id").toString();

            // Forward to payment page with order ID
            request.setAttribute("orderId", orderId);
            request.setAttribute("amount", amount);
            request.getRequestDispatcher("payment.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error creating payment order", e);
        }
    }
}
