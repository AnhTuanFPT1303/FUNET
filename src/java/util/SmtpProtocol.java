/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author HELLO
 */
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.util.Random;

public class SmtpProtocol {

    final String from = "tuannhade180647@fpt.edu.vn";
    final String password = "vxiziwxgfwrakdgx";

    public Session setupProtocol() {

        Properties props = new Properties();

        props.put(
                "mail.smtp.host", "smtp.gmail.com");
        props.put(
                "mail.smtp.port", "587");
        props.put(
                "mail.smtp.auth", "true");
        props.put(
                "mail.smtp.starttls.enable", "true");
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };
        Session session = Session.getInstance(props, auth);
        return session;
    }

    public int sendMail(String userEmail) {
        Random rand = new Random();
        int userOtp = rand.nextInt(100000);
        try {
            Message message = new MimeMessage(setupProtocol());
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
            message.setSubject("Confirm your account on Blah");
            message.setText("Welcome new blah-er, your verification code is " + userOtp);
            Transport.send(message);
        } catch (Exception e) {
            System.out.println("Verify failed");
        }
        return userOtp;
    }
}
