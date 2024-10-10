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
import jakarta.servlet.http.HttpSession;
import dao.FriendDAO;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import org.json.JSONObject;

/**
 *
 * @author HELLO
 */
public class friendRequestServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet friendRequestServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet friendRequestServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FriendDAO friendDAO = new FriendDAO();
        ArrayList<String> pendingList = new ArrayList<>();
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("user_id");
        try {
            pendingList = friendDAO.getAllFriendRequest(userId);
        } catch (Exception ex) {
            Logger.getLogger(friendRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("pendingList", pendingList);
        request.getRequestDispatcher("WEB-INF/friendRequest.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userRequest = Integer.parseInt(request.getParameter("userRequest"));
        int userAccept = (int) session.getAttribute("user_id");
        FriendDAO friendDAO = new FriendDAO();
        JSONObject jsonResponse = new JSONObject();
        try {
            switch (request.getParameter("action")) {
                case "acceptFriend":
                    friendDAO.acceptFriendRequest(userRequest, userAccept);
                    jsonResponse.put("feedback", "accept");
                    jsonResponse.put("success", true); // Indicate success
                    break;
                case "rejectFriend":
                    friendDAO.rejectFriendRequest(userRequest, userAccept);
                    jsonResponse.put("feedback", "reject");
                    jsonResponse.put("success", true); // Indicate success
                    break;
                default:
                    jsonResponse.put("feedback", "failed");
                    jsonResponse.put("success", false); // Indicate failure
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false); // Indicate failure
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
