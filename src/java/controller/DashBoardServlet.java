/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.MonthDAO;
import dao.postDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Month;
import model.UserActivityLog;

/**
 *
 * @author Quocb
 */
@WebServlet("/dashBoard")
public class DashBoardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {

            MonthDAO dao = new MonthDAO();
            List<Month> results = dao.Get7Month();
            request.setAttribute("label0", results.get(0).getName());
            request.setAttribute("label1", results.get(1).getName());
            request.setAttribute("label2", results.get(2).getName());
            request.setAttribute("label3", results.get(3).getName());
            request.setAttribute("label4", results.get(4).getName());
            request.setAttribute("label5", results.get(5).getName());
            request.setAttribute("label6", results.get(6).getName());
            request.setAttribute("data0",results.get(0).getCount());
            request.setAttribute("data1",results.get(1).getCount());
            request.setAttribute("data2",results.get(2).getCount());
            request.setAttribute("data3",results.get(3).getCount());
            request.setAttribute("data4",results.get(4).getCount());
            request.setAttribute("data5",results.get(5).getCount());
            request.setAttribute("data6",results.get(6).getCount());
            // request.setAttribute("",);
            //request.setAttribute("activities",activities);
            request.getRequestDispatcher("/WEB-INF/DashBoard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
