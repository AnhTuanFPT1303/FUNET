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

/**
 *
 * @author ADMIN
 */
public class UpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String action = request.getParameter("action");
        String newStatus = "";
        
        ordersDAO oDAO = new ordersDAO();
        
        switch(action) {
            case "submit":
                newStatus = "ongoing";
                break;
            case "confirm":
                newStatus = "received";
                break;
            case "getMoney":
                newStatus = "completed";
                break;
        }
        
        oDAO.updateOrderStatus(orderId, newStatus);
        response.sendRedirect("/notificationServlet");
    }
}