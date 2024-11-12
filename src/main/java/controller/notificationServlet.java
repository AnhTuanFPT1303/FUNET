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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
             // Lấy đơn hàng cho sản phẩm của user (khi họ là người bán)
            List<Orders> sellerOrders = oDAO.getOrdersBySellerProducts(currentUser.getUser_id());
        
            request.setAttribute("ordersList", buyerOrders);
            request.setAttribute("sellerOrders", sellerOrders);
            request.setAttribute("userId", userId);
            request.getRequestDispatcher("WEB-INF/marketNotification.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(notificationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}