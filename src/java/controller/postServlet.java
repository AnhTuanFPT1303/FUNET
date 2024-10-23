package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dao.FriendDAO;
import dao.postDAO;
import model.Post;
import model.User;
import java.util.concurrent.TimeUnit;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10, // 10 MB
        maxFileSize = 1024 * 1024 * 50, // 50 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class postServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(postServlet.class.getName());

    private static final Set<String> ALLOWED_IMAGE_TYPES = new HashSet<>(Arrays.asList(
            "image/jpeg", "image/png", "image/gif", "image/bmp", "image/webp"
    ));

    private static final Set<String> ALLOWED_VIDEO_TYPES = new HashSet<>(Arrays.asList(
            "video/mp4", "video/mpeg", "video/quicktime", "video/x-msvideo", "video/webm"
    ));

    private static final long serialVersionUID = 1L;
    Cloudinary cloud;

    @Override
    public void init() throws ServletException {
        LOGGER.info("Initializing postServlet");
        Properties properties = new Properties();
        String propFileName = "/WEB-INF/cloudinary.properties.txt";

        try {
            InputStream inputStream = getServletContext().getResourceAsStream(propFileName);
            if (inputStream == null) {
                LOGGER.severe("Property file '" + propFileName + "' not found in classpath");
                throw new ServletException("Property file '" + propFileName + "' not found in classpath");
            }

            properties.load(inputStream);
            String cloudName = properties.getProperty("cloud_name");
            String apiKey = properties.getProperty("api_key");
            String apiSecret = properties.getProperty("api_secret");

            cloud = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", cloudName,
                    "api_key", apiKey,
                    "api_secret", apiSecret
            ));
            LOGGER.info("Cloudinary initialization successful");

        } catch (IOException ex) {
            LOGGER.log(Level.SEVERE, "Failed to load properties file", ex);
            throw new ServletException("Failed to load properties file", ex);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize Cloudinary", e);
            throw new ServletException("Failed to initialize Cloudinary", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Processing GET request");
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            User currentUser = (User) session.getAttribute("user");
            LOGGER.info("User " + currentUser.getUser_id() + " requesting posts");

            try {
                List<Post> posts = postDAO.getAllPosts(currentUser.getUser_id());
                postDAO dao = new postDAO();

                for (Post post : posts) {
                    post.setLikedByCurrentUser(dao.hasUserLikedPost(currentUser.getUser_id(), post.getPost_id()));
                }
                request.setAttribute("posts", posts);
                LOGGER.info("Successfully retrieved " + posts.size() + " posts for user " + currentUser.getUser_id());

                FriendDAO friendDAO = new FriendDAO();
                List<User> friends = friendDAO.findFriend(currentUser.getUser_id());
                request.setAttribute("friends", friends);
                LOGGER.info("Successfully retrieved friends list for user " + currentUser.getUser_id());

            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Database error while processing GET request", e);
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error while retrieving friends", e);
            }

            request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
        } else {
            LOGGER.warning("Unauthorized access attempt - redirecting to login");
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Processing POST request");
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            LOGGER.info("User " + user.getUser_id() + " attempting to create post");

            String body = request.getParameter("postContent");
            Part filePart = request.getPart("image");
            String sourceUrl = request.getParameter("sourceUrl");
            String imageUrl = null;
            String resourceType = null;

            if (filePart != null && filePart.getSize() > 0) {
                String contentType = filePart.getContentType();
                LOGGER.info("File upload detected with content type: " + contentType);

                if (!ALLOWED_IMAGE_TYPES.contains(contentType) && !ALLOWED_VIDEO_TYPES.contains(contentType)) {
                    LOGGER.warning("Unsupported file type attempted: " + contentType);
                    request.setAttribute("error", "Unsupported file type");
                    response.sendRedirect(sourceUrl != null && sourceUrl.contains("profile") ? "profile" : "home");
                    return;
                }

                resourceType = ALLOWED_IMAGE_TYPES.contains(contentType) ? "image" : "video";

                try {
                    File tempFile = File.createTempFile("upload_", filePart.getSubmittedFileName());
                    LOGGER.info("Created temporary file for upload: " + tempFile.getName());

                    try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(tempFile)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                    }

                    Map uploadResult = cloud.uploader().upload(tempFile, ObjectUtils.asMap(
                            "resource_type", resourceType
                    ));
                    imageUrl = (String) uploadResult.get("url");
                    LOGGER.info("Successfully uploaded file to Cloudinary: " + imageUrl);

                    Files.deleteIfExists(tempFile.toPath());
                    LOGGER.info("Deleted temporary file: " + tempFile.getName());

                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error during file upload", e);
                    request.setAttribute("errorMessage", "Error uploading image");
                    response.sendRedirect("home");
                    return;
                }
            }

            if (!body.trim().equals("") || imageUrl != null) {
                Post post = new Post();
                post.setUser_id(user.getUser_id());
                post.setBody(body);
                post.setImage_path(imageUrl);
                post.setType(resourceType);

                try {
                    postDAO PostDao = new postDAO();
                    PostDao.addPost(post);
                    LOGGER.info("Successfully created new post for user " + user.getUser_id());

                    TimeUnit.SECONDS.sleep(2);
                    response.sendRedirect(sourceUrl != null && sourceUrl.contains("profile") ? "profile" : "home");

                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error saving post to database", e);
                    request.setAttribute("errorMessage", "Error saving post");
                    response.sendRedirect("home");
                }
            } else {
                LOGGER.info("Empty post attempted - redirecting");
                response.sendRedirect("home");
            }
        } else {
            LOGGER.warning("Unauthorized post attempt - redirecting to home");
            response.sendRedirect("home");
        }
    }

    @Override
    public String getServletInfo() {
        return "Post management servlet handling creation and retrieval of posts";
    }
}
