/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.UserActivityLogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import dao.userDAO;
import java.util.List;
import model.UserActivityLog;
/**
 *
 * @author gabri
 */
public class userActivity extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet userActivity</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet userActivity at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("id");
        if (userIdStr != null) {
            int userId = Integer.parseInt(userIdStr);
            UserActivityLogDAO dao = new UserActivityLogDAO();
            List<UserActivityLog> activities = dao.getUserActivities(userId);
            request.setAttribute("userActivities", activities);
      request.getRequestDispatcher("/WEB-INF/log.jsp?id="+userIdStr).forward(request, response);
        } else {
            response.sendRedirect("dashboard");
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject jsonRequest = new JSONObject(request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual));
        int userId = jsonRequest.getInt("userId");
        boolean isBanned = jsonRequest.getBoolean("isBanned");

        userDAO userDAO = new userDAO();
        boolean success = userDAO.updateUserBanStatus(userId, isBanned);

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", success);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
