
package controller;

import com.cloudinary.utils.ObjectUtils;
import dao.gameDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import model.game;
import util.CloudinaryAPI;

/**
 *
 * @author Quocb
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, 
    maxFileSize = 1024 * 1024 * 10,  
    maxRequestSize = 1024 * 1024 * 15 
)
public class CreGameServlet extends HttpServlet {
           private static final Set<String> ALLOWED_IMAGE_TYPES = new HashSet<>(Arrays.asList(
        "image/jpeg", "image/png", "image/gif", "image/bmp", "image/webp"
    ));

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
            out.println("<title>Servlet CreGameServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreGameServlet at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          try {
            // Lấy thông tin từ form
            String gameName = request.getParameter("tengame");
            String gameLink = request.getParameter("link");
            Integer category = Integer.parseInt( request.getParameter("theloai"));
            
            // Xử lý file ảnh
            Part filePart = request.getPart("image");
            String imageUrl = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                String contentType = filePart.getContentType();
                
              
                if (!ALLOWED_IMAGE_TYPES.contains(contentType)) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }

                // Tạo file tạm thời
                File tempFile = File.createTempFile("upload_", filePart.getSubmittedFileName());
                
                // Copy dữ liệu từ file upload vào file tạm
                try (InputStream input = filePart.getInputStream();
                     FileOutputStream output = new FileOutputStream(tempFile)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }

             
                Map uploadResult = CloudinaryAPI.getInstance().uploader()
                    .upload(tempFile, ObjectUtils.asMap(
                        "folder", "game"
                            
                    ));
                
              
                imageUrl = (String) uploadResult.get("url");
                
                // Xóa file tạm
                Files.deleteIfExists(tempFile.toPath());
            }
            
            // Lưu vào database
            game G = new game();
            G.setTengame(gameName);
            G.setLink(gameLink);
            G.setLinkimg(imageUrl);
            G.setMagame(category);

            
            gameDAO gamedao = new gameDAO();
            gamedao.CreateGame(G);
            
            response.setStatus(HttpServletResponse.SC_OK);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
