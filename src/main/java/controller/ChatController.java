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
import java.util.List;
import model.*;
import dao.FriendDAO;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;
import services.ConversationService;

/**
 *
 * @author HELLO
 */
public class ChatController extends HttpServlet {

    private ConversationService conversationService = ConversationService.getInstance();

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
            out.println("<title>Servlet ChatController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChatController at " + request.getContextPath() + "</h1>");
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
        try {
            User currentUser = (User) request.getSession(false).getAttribute("user");
            FriendDAO friendDAO = new FriendDAO();
            List<User> friends = friendDAO.findFriend(currentUser.getUser_id());

            request.setAttribute("friends", friends);
            request.getRequestDispatcher("WEB-INF/chatbox.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ChatController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        StringBuilder jsonBuffer = new StringBuilder();
        String line;

        // Read JSON input from request
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        // Parse JSON object
        String jsonString = jsonBuffer.toString();
        JSONObject jsonObject = new JSONObject(jsonString);

        int conversationId = jsonObject.getInt("groupId");
        String groupName = jsonObject.optString("groupName", null);
        String avatar = jsonObject.optString("avatar", null);

        try {
            conversationService.updateConversationById(conversationId, groupName, avatar);
            request.getRequestDispatcher("WEB-INF/chatbox.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ChatController.class.getName()).log(Level.SEVERE, null, ex);
            request.getRequestDispatcher("WEB-INF/chatbox.jsp").forward(request, response);
        }
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
