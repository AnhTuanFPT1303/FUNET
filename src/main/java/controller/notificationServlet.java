/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ordersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.OrderDetailDTO;
import model.Orders;
import model.User;

public class notificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User currentUser = (User) request.getSession(false).getAttribute("user");
            int userId = (int) currentUser.getUser_id();
            ordersDAO oDAO = new ordersDAO();

            // Lấy tất cả đơn hàng
            List<Orders> buyerOrders = oDAO.getOrdersByUserId(currentUser.getUser_id());
            List<List<OrderDetailDTO>> buyerOrderDetails = new ArrayList<>();

            for (Orders order : buyerOrders) {
                List<OrderDetailDTO> orderDetails = oDAO.getDetail(order.getOrder_id());
                if (!orderDetails.isEmpty()) { 
                    buyerOrderDetails.add(orderDetails);
                }
            }

            List<Orders> sellerOrders = oDAO.getOrdersBySellerProducts(currentUser.getUser_id());
            List<List<OrderDetailDTO>> sellerOrderDetails = new ArrayList<>();

            for (Orders order : sellerOrders) {
                List<OrderDetailDTO> orderDetails = oDAO.getDetail(order.getOrder_id());
                if (!orderDetails.isEmpty()) { 
                    sellerOrderDetails.add(orderDetails);
                }
            }

            request.setAttribute("buyerOrdersList", buyerOrders);
            request.setAttribute("buyerOrderDetails", buyerOrderDetails);
            request.setAttribute("sellerOrders", sellerOrders);
            request.setAttribute("sellerOrderDetails", sellerOrderDetails);
            request.setAttribute("userId", userId);
            request.getRequestDispatcher("WEB-INF/marketNotification.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(notificationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
