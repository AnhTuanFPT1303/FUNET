package model;

import java.util.Date;

public class LearningMaterial {
    
    // model của learning material
    
    private int learningMaterialId; 
    private int userId;    
    private String learningMaterialName; 
    private String learningMaterialDescription; 
    private String learningMaterial_img;
    private String learningMaterialContext; 
    private String subjectCode; 
    private Date publishDate; 
    private String review; 

    public LearningMaterial(int learningMaterialId, int userId, String learningMaterialName, String learningMaterialDescription, String learningMaterial_img, String learningMaterialContext, String subjectCode, Date publishDate, String review) {
        this.learningMaterialId = learningMaterialId;
        this.userId = userId;
        this.learningMaterialName = learningMaterialName;
        this.learningMaterialDescription = learningMaterialDescription;
        this.learningMaterial_img = learningMaterial_img;
        this.learningMaterialContext = learningMaterialContext;
        this.subjectCode = subjectCode;
        this.publishDate = publishDate;
        this.review = review;
    }

    public String getLearningMaterial_img() {
        return learningMaterial_img;
    }

    public void setLearningMaterial_img(String learningMaterial_img) {
        this.learningMaterial_img = learningMaterial_img;
    }

    public int getLearningMaterialId() {
        return learningMaterialId;
    }

    public void setLearningMaterialId(int learningMaterialId) {
        this.learningMaterialId = learningMaterialId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getLearningMaterialName() {
        return learningMaterialName;
    }

    public void setLearningMaterialName(String learningMaterialName) {
        this.learningMaterialName = learningMaterialName;
    }

    public String getLearningMaterialDescription() {
        return learningMaterialDescription;
    }

    public void setLearningMaterialDescription(String learningMaterialDescription) {
        this.learningMaterialDescription = learningMaterialDescription;
    }

    public String getLearningMaterialContext() {
        return learningMaterialContext;
    }

    public void setLearningMaterialContext(String learningMaterialContext) {
        this.learningMaterialContext = learningMaterialContext;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    } 
}
