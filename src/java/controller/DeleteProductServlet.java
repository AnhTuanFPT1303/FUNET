package controller;

import dao.productDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("product_id"));
        productDAO dao = new productDAO();
        try {
            boolean success = dao.deleteProduct(productId);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/SellingProductServlet");
            } else {
                request.setAttribute("error", "Error deleting product.");
                request.getRequestDispatcher("WEB-INF/selling.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/selling.jsp").forward(request, response);
        }
    }
}