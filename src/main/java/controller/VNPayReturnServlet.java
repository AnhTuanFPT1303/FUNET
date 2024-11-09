/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
        if (vnp_ResponseCode.equals("00")) {
            // Giao dịch thành công
            response.getWriter().println("Giao dịch thành công. Mã giao dịch: " + vnp_TransactionNo);
        } else {
            // Giao dịch thất bại
            response.getWriter().println("Giao dịch thất bại. Mã giao dịch: " + vnp_TransactionNo);
        }
    }

}
