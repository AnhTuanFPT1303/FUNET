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

public class SellingProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
