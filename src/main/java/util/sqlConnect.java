package util;

import dao.userDAO;
import java.io.IOException;
import java.sql.*;
import model.User;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author HELLO
 */
public class sqlConnect {

    private static sqlConnect instance = null;
    private Connection connection = null;
    private String userName = "thecucumber"; // Ideally from env variables
    private String passWord = "AnhTuan1332004"; // Ideally from env variables
    private String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private String sqlUrl = "jdbc:sqlserver://funet-server.database.windows.net:1433;"
            + "database=funet-database;"
            + "user=thecucumber@funet-server;"
            + "password=AnhTuan1332004;"
            + "encrypt=true;"
            + "trustServerCertificate=false;"
            + "hostNameInCertificate=*.database.windows.net;"
            + "loginTimeout=30;";

    private sqlConnect() throws SQLException, ClassNotFoundException {
        Class.forName(driverClass);
        this.connection = DriverManager.getConnection(sqlUrl, userName, passWord);
    }

    public static synchronized sqlConnect getInstance() throws SQLException, ClassNotFoundException {
        if (instance == null) {
            instance = new sqlConnect();
        } else {
            Connection conn = instance.getConnection();
            if (conn == null || conn.isClosed()) {
                instance = new sqlConnect();
            }
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}
