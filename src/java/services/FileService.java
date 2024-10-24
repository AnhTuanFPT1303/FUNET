package services;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletResponse;

public class FileService {

    private static FileService instance = null;

    public static Path rootLocation = Paths.get("archive");

    public static String rootURL = "";

    private static final int DEFAULT_BUFFER_SIZE = 10240;

    private FileService() {
    }

    // Singleton instance
    public static FileService getInstance() {
        if (instance == null) {
            instance = new FileService();
        }
        return instance;
    }

    // Generate HTML tag based on file type
    public static String toTagHtml(String type, int user_id, String message) {
        String tag = "";
        if (type.startsWith("audio")) {
            tag = "<audio controls>\r\n" + 
                  "  <source src=\"" + message + "\" type=\"" + type + "\">\r\n" + 
                  "</audio>";
        } else if (type.startsWith("video")) {
            tag = "<video width=\"400\" controls>\r\n" + 
                  "  <source src=\"" + message + "\" type=\"" + type + "\">\r\n" + 
                  "</video>";
        } else if (type.startsWith("image")) {
            tag = "<img src=\"" + message + "\" alt=\"\">";
        } else {
            tag = "<a href=\"" + message + "\">" + message + "</a>";
        }
        return tag;
    }

    // Handle file streaming to client
    public void handleStreamFileToClient(File file, String contentType, HttpServletResponse response) {
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        response.reset();
        response.setBufferSize(DEFAULT_BUFFER_SIZE);
        response.setContentType(contentType);
        response.setHeader("Content-Length", String.valueOf(file.length()));
        response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

        try (BufferedInputStream input = new BufferedInputStream(new FileInputStream(file), DEFAULT_BUFFER_SIZE);
             BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream(), DEFAULT_BUFFER_SIZE)) {

            byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
            int length;
            while ((length = input.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
