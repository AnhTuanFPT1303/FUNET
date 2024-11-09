/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.MonthDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Month;
import org.json.JSONObject;

/**
 *
 * @author Quocb
 */
@WebServlet("/userChartData")
public class UserChartData extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
             response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject jsonResponse = new JSONObject();
        
        MonthDAO dao=new MonthDAO();
        Month mon=dao.getLastMonthRegistrationCountAndName();
        String month = mon.getName();
        int userCount = mon.getCount();

        jsonResponse.put("month", month);
        jsonResponse.put("userCount", userCount);

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
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
