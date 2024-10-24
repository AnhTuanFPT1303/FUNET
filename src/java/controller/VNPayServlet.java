package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.vnpay.common.Config;
import dao.ordersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Orders;

public class VNPayServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String totalAmountStr = req.getParameter("totalAmount");
            String orderId = Config.getRandomNumber(8);
            String cartId = req.getParameter("cartId");
            String userId = req.getParameter("userId");
            String orderNotes = req.getParameter("orderNotes");
            String shippingAddress = req.getParameter("shippingAddress");

            // Log để debug
            System.out.println("Generated orderId: " + orderId);
            System.out.println("Received parameters:");
            System.out.println("totalAmount=" + totalAmountStr);
            System.out.println("cartId=" + cartId);
            System.out.println("userId=" + userId);

            int totalAmount = 0;
            if (totalAmountStr != null && !totalAmountStr.isEmpty()) {
                try {
                    double roundedAmount = Math.round(Double.parseDouble(totalAmountStr));
                    totalAmount = (int) roundedAmount;
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid total amount format: " + totalAmountStr, e);
                }
            }

            // Kiểm tra các giá trị bắt buộc
            if (orderNotes == null || orderNotes.trim().isEmpty()) {
                orderNotes = "No notes"; // Giá trị mặc định nếu không có ghi chú
            }

            if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                throw new ServletException("Shipping address is required");
            }

            Orders order = new Orders(
                    Integer.parseInt(orderId),
                    Integer.parseInt(userId),
                    Integer.parseInt(cartId),
                    totalAmount,
                    "Pending",
                    null,
                    orderNotes,
                    shippingAddress
            );

            ordersDAO oDAO = new ordersDAO();
            boolean isSaved = oDAO.saveOrder(order);

            if (isSaved) {
                req.setAttribute("orderId", orderId);
                req.setAttribute("totalAmount", totalAmount);
                req.getRequestDispatcher("vnpay_pay.jsp").forward(req, resp);
            } else {
                req.setAttribute("errorMessage", "Failed to save order!");
            }

        } catch (Exception ex) {
            System.out.println("Error in VNPayServlet: " + ex.getMessage());
            ex.printStackTrace();
            req.setAttribute("errorMessage", "Error processing order: " + ex.getMessage());
        }
    }
}
