/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserActivityDAO;
import dao.postDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.lang.System.Logger;
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
      private static final java.util.logging.Logger logger = java.util.logging.Logger.getLogger(UpdateDiaryServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserActivityDAO dao = new UserActivityDAO();
        Integer userId = Integer.valueOf(request.getParameter("userId"));
   

        List<UserActivityLog> activities = dao.getUserActivities(userId);
       
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        for (UserActivityLog activity : activities) {
            String typeValue;
            if (activity.getCommentId() == 0) {
                
              
                typeValue = "Post";
            } else {
           
                typeValue = "Comment";
                
            }

            int idTypeValue;
            if (activity.getCommentId() != 0) {
                idTypeValue = activity.getCommentId();
            } else {
                idTypeValue = activity.getPostId();
            }

            out.println("<tr>");
            out.println("<td>" + activity.getUserId() + "</td>");
            out.println("<td>" + activity.getRole() + "</td>");
            out.println("<td>" + activity.getFirstName() + " " + activity.getLastName() + "</td>");
            out.println("<td>" + activity.getActivityType() + "</td>");
            out.println("<td>" + activity.getPostId() + "</td>");
            out.println("<td>" + activity.getCommentId() + "</td>");
            out.println("<td style='word-wrap: break-word;'>" + activity.getActivityDetails() + "</td>");
            out.println("<td> " + activity.getTimestamp().format(formatter) + "</td>");
            out.print("<td>");
            out.println("<form action='adminDelete' method='post' style='display:inline;'>");
            out.println("<input type='hidden' name='idtype' value='" + idTypeValue + "' />");
            out.print("<input type='hidden' name='userId' value='" + userId + "'>");
            out.println("<input type='hidden' name='type' value='" + typeValue + "' />");
            out.println("<button type='submit' class='btn btn-danger btn-sm'>Delete</button>");
            out.println("</form>");
            out.print("</td>");
            out.println("</tr>");

            // Log activity details for debugging
            
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
