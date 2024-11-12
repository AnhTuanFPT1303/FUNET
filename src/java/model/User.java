/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HELLO
 */
public class User {

    private int user_id;
    private String first_name;
    private String last_name;
    private String password;
    private String email;
    private String profile_pic;
    private String role;
    private boolean is_banned;
    private boolean isAdmin;
    private String user_introduce;
    
    public User() {
    }

    public User(int user_id, String first_name, String last_name, String password, String email, String profile_pic, String role, boolean is_banned, boolean isAdmin, String user_introduce) {
        this.user_id = user_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.password = password;
        this.email = email;
        this.profile_pic = profile_pic;
        this.role = role;
        this.is_banned = is_banned;
        this.isAdmin = isAdmin;
        this.user_introduce = user_introduce;
    }

    public User(String user_introduce) {
        this.user_introduce = user_introduce;
    }
    
    

    public User(int user_id, String first_name, String last_name, String profile_pic) {
        this.user_id = user_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.profile_pic = profile_pic;
    }

    public User(String first_name, String last_name, String password, String email, String profile_pic, String role, boolean is_banned) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.password = password;
        this.email = email;
        this.profile_pic = profile_pic;
        this.role = role;
        this.is_banned = is_banned;
    }
    
    

    public User(int user_id, String first_name, String last_name, String password, String email, String profile_pic, String role, boolean is_banned, boolean isAdmin) {
        this.user_id = user_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.password = password;
        this.email = email;
        this.profile_pic = profile_pic;
        this.role = role;
        this.is_banned = is_banned;
        this.isAdmin = isAdmin;
    }

    public User(int user_id, String user_introduce) {
        this.user_id = user_id;
        this.user_introduce = user_introduce;
    }
    

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfile_pic() {
        return profile_pic;
    }

    public void setProfile_pic(String profile_pic) {
        this.profile_pic = profile_pic;
    }
   
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean getStatus() {
        return is_banned;
    }

    public void setStatus(boolean is_banned) {
        this.is_banned = is_banned;
    }

    public boolean isIs_banned() {
        return is_banned;
    }

    public void setIs_banned(boolean is_banned) {
        this.is_banned = is_banned;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getUser_introduce() {
        return user_introduce;
    }

    public void setUser_introduce(String user_introduce) {
        this.user_introduce = user_introduce;
    }
    
}
