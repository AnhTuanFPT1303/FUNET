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
import java.util.List;
import model.Product;

public class SearchProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        productDAO productDao = new productDAO();
        
        try {
            List<Product> productList = productDao.searchProducts(keyword);
            request.setAttribute("productList", productList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("WEB-INF/market.jsp").forward(request, response);
    }
}