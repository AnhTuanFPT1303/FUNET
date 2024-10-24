/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import controller.postServlet;
import jakarta.servlet.ServletException;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HELLO
 */
public class CloudinaryAPI {

    private static Cloudinary cloud;
    private static final Object lock = new Object();  // To ensure thread-safety

    private CloudinaryAPI() {
        // Private constructor to prevent instantiation
    }

    public static Cloudinary getInstance() {
        if (cloud == null) {
            synchronized (lock) {
                if (cloud == null) {
                    // Load Cloudinary config from properties file
                    String cloudName = "dxx8u5qnr";
                    String apiKey = "694793228885481";
                    String apiSecret = "ydUuGLOQjJ2UTdMaiJes0zggIpw";

                    cloud = new Cloudinary(ObjectUtils.asMap(
                            "cloud_name", cloudName,
                            "api_key", apiKey,
                            "api_secret", apiSecret
                    ));

                }
            }
        }
        return cloud;
    }
}
