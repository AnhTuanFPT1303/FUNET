/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author bim26
 */
import java.sql.Timestamp;
import java.util.List;

public class Post {
    private int post_id;
    private int user_id;
    private String body;
    private Timestamp post_time;
    private String first_name;
    private String last_name;
    private String image_path;
    private String profile_pic;
    private int like_count;
    private boolean likedByCurrentUser;
    private List<Comment> comments;
    private boolean isShared;
    private int originalPostId;
    private String originalPosterName;
    private int shareCount;
    private String originalPosterAvatar;
    private String privacy_mode;
    private boolean savedByCurrentUser;
    private String type;
    
    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path, String profile_pic, int like_count, boolean isShared, int originalPostId, String originalPosterName, int shareCount, String originalPosterAvatar, String privacy_mode) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
        this.profile_pic = profile_pic;
        this.like_count = like_count;
        this.isShared = isShared;
        this.originalPostId = originalPostId;
        this.originalPosterName = originalPosterName;
        this.shareCount = shareCount;
        this.originalPosterAvatar = originalPosterAvatar;
        this.privacy_mode = privacy_mode;
    }

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path, String profile_pic, int like_count, boolean isShared, int originalPostId, String originalPosterName, int shareCount, String originalPosterAvatar) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
        this.profile_pic = profile_pic;
        this.like_count = like_count;
        this.isShared = isShared;
        this.originalPostId = originalPostId;
        this.originalPosterName = originalPosterName;
        this.shareCount = shareCount;
        this.originalPosterAvatar = originalPosterAvatar;
    }
    
    
    

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path, String profile_pic, int like_count, boolean likedByCurrentUser, List<Comment> comments) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
        this.profile_pic = profile_pic;
        this.like_count = like_count;
        this.likedByCurrentUser = likedByCurrentUser;
        this.comments = comments;
    }
    

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path, int like_count, boolean likedByCurrentUser, List<Comment> comments) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
        this.like_count = like_count;
        this.likedByCurrentUser = likedByCurrentUser;
        this.comments = comments;
    }

    public boolean isSavedByCurrentUser() {
        return savedByCurrentUser;
    }

    public void setSavedByCurrentUser(boolean savedByCurrentUser) {
        this.savedByCurrentUser = savedByCurrentUser;
    }
   
    public String getPrivacy_mode() {
        return privacy_mode;
    }

    public void setPrivacy_mode(String privacy_mode) {
        this.privacy_mode = privacy_mode;
    }
    
    

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public boolean isIsShared() {
        return isShared;
    }

    public void setIsShared(boolean isShared) {
        this.isShared = isShared;
    }

    public int getOriginalPostId() {
        return originalPostId;
    }

    public void setOriginalPostId(int originalPostId) {
        this.originalPostId = originalPostId;
    }

    public String getOriginalPosterName() {
        return originalPosterName;
    }

    public void setOriginalPosterName(String originalPosterName) {
        this.originalPosterName = originalPosterName;
    }

    public int getShareCount() {
        return shareCount;
    }

    public void setShareCount(int shareCount) {
        this.shareCount = shareCount;
    }

    public String getOriginalPosterAvatar() {
        return originalPosterAvatar;
    }

    public void setOriginalPosterAvatar(String originalPosterAvatar) {
        this.originalPosterAvatar = originalPosterAvatar;
    }
    
    
    

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path, int like_count, boolean likedByCurrentUser) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
        this.like_count = like_count;
        this.likedByCurrentUser = likedByCurrentUser;
    }

    public boolean isLikedByCurrentUser() {
        return likedByCurrentUser;
    }

    public void setLikedByCurrentUser(boolean likedByCurrentUser) {
        this.likedByCurrentUser = likedByCurrentUser;
    }
    
    

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path, int like_count) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
        this.like_count = like_count;
    }

    public int getLike_count() {
        return like_count;
    }

    public void setLike_count(int like_count) {
        this.like_count = like_count;
    }

    
    
    
    
    public Post(int post_id, int user_id, String body, Timestamp post_time, String image_path) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.image_path = image_path;
    }

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
    }

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name, String image_path, String profile_pic, int like_count) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
        this.image_path = image_path;
        this.profile_pic = profile_pic;
        this.like_count = like_count;
    }
    
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    
    public String getProfile_pic() {
        return profile_pic;
    }

    public void setProfile_pic(String profile_pic) {
        this.profile_pic = profile_pic;
    }

    
    public String getImage_path() {
        return image_path;
    }

    public void setImage_path(String image_path) {
        this.image_path = image_path;
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

    public Post(int post_id, int user_id, String body, Timestamp post_time, String first_name, String last_name) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;
        this.first_name = first_name;
        this.last_name = last_name;
    }

    public Post(int post_id, int user_id, String body, Timestamp post_time) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.body = body;
        this.post_time = post_time;

    }
    
    

    public Post() {
    }

    public Post(int user_id, String body) {
        this.user_id = user_id;
        this.body = body;
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

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Timestamp getPost_time() {
        return post_time;
    }

    public void setPost_time(Timestamp post_time) {
        this.post_time = post_time;
    }

    @Override
    public String toString() {
        return "Post{" + "post_id=" + post_id + ", user_id=" + user_id + ", body=" + body + ", post_time=" + post_time + ", first_name=" + first_name + ", last_name=" + last_name + ", image_path=" + image_path + ", profile_pic=" + profile_pic + ", like_count=" + like_count + ", likedByCurrentUser=" + likedByCurrentUser + ", comments=" + comments + ", isShared=" + isShared + ", originalPostId=" + originalPostId + ", originalPosterName=" + originalPosterName + ", shareCount=" + shareCount + ", originalPosterAvatar=" + originalPosterAvatar + ", type=" + type + '}';
    }

    }

    
 
