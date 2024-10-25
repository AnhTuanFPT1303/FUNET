///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package Security;
//
//import java.nio.charset.StandardCharsets;
//import java.security.MessageDigest;
//import java.security.NoSuchAlgorithmException;
//import java.security.SecureRandom;
//import java.util.Base64;
//
///**
// *
// * @author ADMIN
// */
//public class SHA512WithSalt {
//    
//    //Tạo salt ngẫu nhiên ( nân cao bảo mật để chống lại các cuộc tấn công từ rainbow table - bảng tra cứu mật khẩu )
//    
//    public static byte[] createSalt(){
//        SecureRandom random = new SecureRandom();
//        byte[] salt = new byte[16]; // mặc định salt có 16 byte
//        random.nextBytes(salt); // điền giá trị salt
//        return salt;
//    }
//    
//    public static String hashPassWordWithSHA512(String password, byte[] salt){
//        try{
//            
//            MessageDigest md = MessageDigest.getInstance("SHA-512");
//            md.update(salt);//thêm salt vào trc khi hash
//            
//            //hashing mật khẩu
//            byte[] hashBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));//xử lý theo phương thức UTF_8
//            
//            // Kết hợp salt vào sau đó mã hóa thành base64 để lưu trữ
//            byte[] hashPassword = new byte[salt.length + hashBytes.length];
//            System.arraycopy(salt, 0, hashPassword, 0, salt.length);
//            System.arraycopy(hashBytes, 0, hashPassword, salt.length, hashBytes.length);
//            
//            return Base64.getEncoder().encodeToString(hashPassword);
//            
//        } catch (NoSuchAlgorithmException exception){
//            throw new RuntimeException(exception);
//        }
//    }
//    
//    public static void main(String[] args) {
//        //test case thử
//        String password = "123";
//        
//        byte[] salt = createSalt();
//        String hashedPassword = hashPassWordWithSHA512(password, salt);
//        
//        System.out.println("Mật khẩu sau khi hash là: " + hashedPassword);
//    }
//}