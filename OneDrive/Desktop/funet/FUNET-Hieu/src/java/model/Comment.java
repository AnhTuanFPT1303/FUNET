/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author bim26
 */
public class Comment {
    private int comment_id;
    private int post_id;
    private int user_id;
    private String first_name;
    private String last_name;
    private String comment_text;
    private String profile_pic;

    public Comment(int comment_id, int post_id, int user_id, String first_name, String last_name, String comment_text, String profile_pic) {
        this.comment_id = comment_id;
        this.post_id = post_id;
        this.user_id = user_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.comment_text = comment_text;
        this.profile_pic = profile_pic;
    }
    
    

    public Comment(int comment_id, int post_id, int user_id, String first_name, String last_name, String comment_text) {
        this.comment_id = comment_id;
        this.post_id = post_id;
        this.user_id = user_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.comment_text = comment_text;
    }

    public Comment() {
    }

    public String getProfile_pic() {
        return profile_pic;
    }

    public void setProfile_pic(String profile_pic) {
        this.profile_pic = profile_pic;
    }
    
    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getPost_id() {
        return post_id;
    }

    public void setPost_id(int post_id) {
        this.post_id = post_id;
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

    public String getComment_text() {
        return comment_text;
    }

    public void setComment_text(String comment_text) {
        this.comment_text = comment_text;
    }
    
    
}
