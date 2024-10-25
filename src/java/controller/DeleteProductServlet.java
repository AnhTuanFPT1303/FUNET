package controller;

import dao.productDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;
import model.User;

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
                productDAO productDAO = new productDAO();

                List<Product> productList = null;
                try {
                    User currentUser = (User) request.getSession(false).getAttribute("user");
                    productList = productDAO.getSellingList(currentUser.getUser_id());
                } catch (Exception ex) {
                    ex.printStackTrace();
                }

                request.setAttribute("productList", productList);
                request.getRequestDispatcher("WEB-INF/selling.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "You cannot delete product because the product is on transaction");
            productDAO productDAO = new productDAO();

            List<Product> productList = null;
            try {
                User currentUser = (User) request.getSession(false).getAttribute("user");
                productList = productDAO.getSellingList(currentUser.getUser_id());
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            request.setAttribute("productList", productList);
            request.getRequestDispatcher("WEB-INF/selling.jsp").forward(request, response);
        }
    }
}