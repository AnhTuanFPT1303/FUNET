/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.postDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.UserActivityLog;

/**
 *
 * @author Quocb
 */
@WebServlet("/updateDiary")
public class UpdateDiaryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        postDAO dao = new postDAO();
        Integer userId = Integer.valueOf(request.getParameter("userId"));
        List<UserActivityLog> activities = dao.getUserActivities(userId);

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        for (UserActivityLog activity : activities) {
            out.println("<tr>");
            out.println("<td>" + activity.getUserId() + "</td>");
            out.println("<td>" + activity.getRole() + "</td>");
            out.println("<td>" + activity.getFirstName() + " " + activity.getLastName() + "</td>");
            out.println("<td>" + activity.getActivityType() + "</td>");
            out.println("<td style='word-wrap: break-word;'>" + activity.getActivityDetails() + "</td>");
            out.println("<td> " + activity.getTimestamp().format(formatter) + "</td>");
            out.println("<td>");
            out.println("<a href='/deleteServlet?id=" + activity.getUserId() + "&  ' class='btn btn-danger btn-sm'>Delete</a>");
            out.println("</td>");

            out.println("</tr>");
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
