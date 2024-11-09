/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.shoppingCartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author ADMIN
 */
public class AddCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int product_id = Integer.parseInt(request.getParameter("product_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            shoppingCartDAO sCartDAO = new shoppingCartDAO();
            User currentUser = (User) request.getSession(false).getAttribute("user");
            int userId = (int) currentUser.getUser_id();
            
            int cartId = sCartDAO.getCartIdByUserId(userId);
            try {
                boolean success = sCartDAO.addShoppingCartItem(cartId, product_id, quantity);
                if(success){
                    response.sendRedirect(request.getContextPath() + "/marketLink");
                } else {
                    request.setAttribute("error", "Error adding product to cart.");
                    request.getRequestDispatcher("WEB-INF/market.jsp").forward(request, response);
                }
            } catch (Exception ex) {
                Logger.getLogger(AddCartServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        } catch (Exception ex) {
            Logger.getLogger(AddCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}