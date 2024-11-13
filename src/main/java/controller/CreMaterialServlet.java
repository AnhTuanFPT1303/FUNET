/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.dropbox.core.DbxRequestConfig;
import com.dropbox.core.v2.DbxClientV2;
import com.dropbox.core.v2.files.WriteMode;
import dao.learningMaterialDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.util.Date;
import model.LearningMaterial;
import model.User;

/**
 *
 * @author Quocb
 */
@MultipartConfig
public class CreMaterialServlet extends HttpServlet {

    private static final java.util.logging.Logger logger = java.util.logging.Logger.getLogger(CreMaterialServlet.class.getName());

    private static final String ACCESS_TOKEN = "sl.CAkqr-f2YOnsvqL9yVzWuEqW6YNizLsViMsXQbWMnwMcRk8YjJVUMSd0QLNWlU2EeZr-GKUe2eq1Q-J98-6V_dMujV7PTmeNqFEZNWV8dBY7Ttw_FpxAenSuE64v0F2akTOz07L6iHt0vaydFlANCn0";
    private DbxClientV2 client;

    @Override
    public void init() throws ServletException {
        logger.info("Initializing Dropbox client...");
        DbxRequestConfig config = DbxRequestConfig.newBuilder("dropbox/java-tutorial").build();
        client = new DbxClientV2(config, ACCESS_TOKEN);
        logger.info("Dropbox client initialized.");
    }

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
            out.println("<title>Servlet CreMaterialServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreMaterialServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");

        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            logger.info("User session found. Proceeding with file upload.");
            User user = (User) session.getAttribute("user");
            int userId = user.getUser_id(); 

            String name = request.getParameter("name");
            String description = request.getParameter("description");
  if(description==null){
      response.sendRedirect("ngu");
return;
  }
            Part filePart = request.getPart("context");
            String context = getFileName(filePart);
            String subjectCode = request.getParameter("subjectCode");
            String departmentIdStr = request.getParameter("departmentId");
            String review = request.getParameter("review");

            try {
                InputStream inputStream = filePart.getInputStream();
                logger.info("Uploading file to Dropbox: " + context);
                client.files().uploadBuilder("/" + context)
                        .withMode(WriteMode.OVERWRITE)
                        .uploadAndFinish(inputStream);
                logger.info("File uploaded successfully.");

            } catch (Exception e) {
                logger.info("Error uploading file to Dropbox");
                response.sendRedirect("lmaterialLink");
return;
            }

            int departmentId;
            try {
                departmentId = Integer.parseInt(departmentIdStr);
                logger.info("Parsed department ID: " + departmentId);
            } catch (NumberFormatException e) {
                response.sendRedirect("lmaterialLink");
                return;
            }

            Date publishDate = new Date();

            LearningMaterial learningMaterial = new LearningMaterial(0, userId, name, description, context, subjectCode, publishDate, review, departmentId);

            learningMaterialDao dao = new learningMaterialDao();
            try {
                dao.createLearningMaterial(learningMaterial);
                logger.info("Learning material created successfully.");
                request.setAttribute("successMessage", "Learning Material created successfully");
                response.sendRedirect("lmaterialLink");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error creating learning material");
                response.sendRedirect("lmaterialLink");
            }
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
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
