/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.productDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author ADMIN
 */
public class UpdateProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get parameters
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));
            
            // Validate input
            if (quantity <= 0 || price <= 0) {
                request.setAttribute("error", "Quantity and price must be greater than 0");
                request.getRequestDispatcher("SellingProductServlet").forward(request, response);
                return;
            }
            
            // Update product
            productDAO pDAO = new productDAO();
            boolean success = pDAO.updateProductQuantityAndPrice(productId, quantity, price);
            
            if (success) {
                // Set success message
                request.getSession().setAttribute("message", "Product updated successfully");
            } else {
                request.getSession().setAttribute("error", "Failed to update product");
            }
            
            // Redirect to the product list page
            response.sendRedirect("SellingProductServlet");
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid input format");
            response.sendRedirect("SellingProductServlet");
        } catch (Exception ex) {
            Logger.getLogger(UpdateProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("error", "An error occurred while updating the product");
            response.sendRedirect("SellingProductServlet");
        }
    }
}
