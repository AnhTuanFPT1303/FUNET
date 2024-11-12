/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Security;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 *
 * @author ADMIN
 */
public class SHA512WithSalt {

    //Tạo salt nân cao bảo mật để chống lại các cuộc tấn công từ rainbow table - bảng tra cứu mật khẩu )
    public static byte[] createSalt() {
        byte[] salt = new byte[16];
        SecureRandom secureRandom = new SecureRandom();
        secureRandom.nextBytes(salt);
        return salt;
    }

    public static String hashPassWordWithSHA512(String password, byte[] salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(salt);

            byte[] hashBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));

            // Mã hóa phần hash thành base64 string
            return Base64.getEncoder().encodeToString(hashBytes);

        } catch (NoSuchAlgorithmException exception) {
            throw new RuntimeException(exception);
        }
    }

    public static void main(String[] args) {
        // Test case thử
        String password = "123";

        byte[] salt = createSalt(); // Tạo salt
        String hashedPassword = hashPassWordWithSHA512(password, salt); // Băm mật khẩu với SHA-512

        // Kết hợp salt và hashedPassword theo định dạng "salt:hashedPassword"
        String combinedHash = Base64.getEncoder().encodeToString(salt) + ":" + hashedPassword;

        System.out.println("Mật khẩu sau khi hash là: " + combinedHash);
    }

}
