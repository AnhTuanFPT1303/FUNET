package controller;

import dao.productDAO;
import jakarta.servlet.ServletException;
import java.io.IOException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;
import model.Product;

public class marketLink extends HttpServlet {
    
     @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        productDAO productDAO = new productDAO();

        List<Product> productList = null;
        try {
            productList = productDAO.getAll();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        request.setAttribute("productList", productList);

        request.getRequestDispatcher("WEB-INF/market.jsp").forward(request, response);
    }

}