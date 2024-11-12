/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.fasterxml.jackson.core.JsonFactory;
import dao.userDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.security.GeneralSecurityException;
import java.util.Collections;

/**
 *
 * @author HELLO
 */
public class GoogleValidate extends HttpServlet {

    private userDAO dao = userDAO.getInstance();

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
            out.println("<title>Servlet GoogleValidate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GoogleValidate at " + request.getContextPath() + "</h1>");
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
        User user = new User();
        try {
            String idTokenString = request.getParameter("id_token");
            if (idTokenString == null) {
                Logger.getLogger(GoogleValidate.class.getName()).info("id token is: " + idTokenString);
                return;
            }
            NetHttpTransport transport = new NetHttpTransport();
            JacksonFactory jsonFactory = new JacksonFactory();
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
                    // Specify the CLIENT_ID of the app that accesses the backend:
                    .setAudience(Collections.singletonList("141463377028-7grc9ri1n2peprn9fhuucjamiudeopcs.apps.googleusercontent.com"))
                    // Or, if multiple clients access the backend:
                    //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
                    .build();
            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                Payload payload = idToken.getPayload();

                // Print user identifier
                String userId = payload.getSubject();
                System.out.println("User ID: " + userId);

                // Get profile information from payload
                user.setEmail(payload.getEmail());
                user.setFirst_name((String) payload.get("family_name"));
                user.setLast_name((String) payload.get("given_name"));
                Logger.getLogger(GoogleValidate.class.getName()).info("user first name is: " + user.getFirst_name());
            }

            User existingUser = dao.getUserByEmail(user.getEmail()); // Check if user exists in the DB by email

            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(1800); // Set session timeout (30 minutes)
            if (existingUser != null) {
                // Existing user: use the existing user's details
                session.setAttribute("user", existingUser);
                session.setAttribute("user_id", existingUser.getUser_id());
                session.setAttribute("last_name", existingUser.getLast_name());
                session.setAttribute("first_name", existingUser.getFirst_name());
                session.setAttribute("profile_pic", existingUser.getProfile_pic());
            } else {
                try {
                    // New user: insert into the DB and set session attributes
                    user.setPassword(null); // No password for Google login
                    user.setProfile_pic("default_avt.jpg");
                    user.setRole("student");
                    user.setStatus(false);

                    int newUserId = dao.register(user);
                    user.setUser_id(newUserId); // Set the newly created ID
                    session.setAttribute("user", user);
                    session.setAttribute("user_id", newUserId);
                    session.setAttribute("last_name", user.getLast_name());
                    session.setAttribute("first_name", user.getFirst_name());
                } catch (Exception ex) {
                    Logger.getLogger(GoogleValidate.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            // Redirect to home after successful login
            request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
        } catch (GeneralSecurityException ex) {
            Logger.getLogger(GoogleValidate.class.getName()).log(Level.SEVERE, null, ex);
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
