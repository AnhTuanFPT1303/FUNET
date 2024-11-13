package controller;

import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;
import com.dropbox.core.v2.DbxClientV2;
import com.dropbox.core.v2.files.WriteMode;
import dao.learningMaterialDao;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.LearningMaterial;
import model.User;

@MultipartConfig
public class updateLearningMaterial extends HttpServlet {

    private static final java.util.logging.Logger logger = java.util.logging.Logger.getLogger(updateLearningMaterial.class.getName());

    private static final String ACCESS_TOKEN = "sl.CAkqr-f2YOnsvqL9yVzWuEqW6YNizLsViMsXQbWMnwMcRk8YjJVUMSd0QLNWlU2EeZr-GKUe2eq1Q-J98-6V_dMujV7PTmeNqFEZNWV8dBY7Ttw_FpxAenSuE64v0F2akTOz07L6iHt0vaydFlANCn0";
    private DbxClientV2 client;

    @Override
    public void init() throws ServletException {
        logger.info("Initializing Dropbox client...");
        DbxRequestConfig config = DbxRequestConfig.newBuilder("dropbox/java-tutorial").build();
        client = new DbxClientV2(config, ACCESS_TOKEN);
        logger.info("Dropbox client initialized.");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet updateLearningMaterial</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateLearningMaterial at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        learningMaterialDao dao = new learningMaterialDao();
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            logger.info("User session found. Proceeding with file upload.");
            User user = (User) session.getAttribute("user");
            int userId = user.getUser_id();

            int learningMaterialId = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            if (description == null) {
                response.sendRedirect("lmaterialLink");
                return;
            }
            Part filePart = request.getPart("context");
            String context = getFileName(filePart);
            String subjectCode = request.getParameter("subjectCode");
            String departmentIdStr = request.getParameter("departmentId");
            String review = request.getParameter("review");

            try {
                if (filePart != null && filePart.getSize() > 0) {
                    InputStream inputStream = filePart.getInputStream();
                    logger.log(Level.INFO, "Uploading file to Dropbox: {0}", context);
                    client.files().uploadBuilder("/" + context)
                            .withMode(WriteMode.OVERWRITE)
                            .uploadAndFinish(inputStream);
                    logger.info("File uploaded successfully.");
                }
                else {
                    LearningMaterial lm=dao.getLearningMaterialById(learningMaterialId);
                    context=lm.getLearningMaterialContext();
                }
                        
            } catch (DbxException | IOException e) {
                logger.info("Error uploading file to Dropbox");
                response.sendRedirect("lmaterialLink");
                return;
            } catch (Exception ex) {
                Logger.getLogger(updateLearningMaterial.class.getName()).log(Level.SEVERE, null, ex);
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

            LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, name, description, context, subjectCode, publishDate, review, departmentId);

            
            try {
                dao.updateLearningMaterial(learningMaterial);
                logger.info("Learning material updated successfully.");
                request.setAttribute("successMessage", "Learning Material updated successfully");
                response.sendRedirect("lmaterialLink");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error updating learning material");
                response.sendRedirect("lmaterialLink");
            }
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
        }
    }

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
    public String getServletInfo() {
        return "Short description";
    }
}
