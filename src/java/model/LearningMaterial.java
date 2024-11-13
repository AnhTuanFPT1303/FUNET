/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author gabri
 */


import java.util.Date;

public class LearningMaterial {
    
    // model của learning material
    
    private int learningMaterialId; 
    private int userId;    
    private String learningMaterialName; 
    private String learningMaterialDescription; 
    private String learningMaterialContext; 
    private String subjectCode; 
    private Date publishDate; 
    private String review; 
    private int departmentId;

    public LearningMaterial(int learningMaterialId, int userId, String learningMaterialName, String learningMaterialDescription, String learningMaterialContext, String subjectCode, Date publishDate, String review, int departmentId) {
        this.learningMaterialId = learningMaterialId;
        this.userId = userId;
        this.learningMaterialName = learningMaterialName;
        this.learningMaterialDescription = learningMaterialDescription;
        this.learningMaterialContext = learningMaterialContext;
        this.subjectCode = subjectCode;
        this.publishDate = publishDate;
        this.review = review;
        this.departmentId = departmentId;
    }

 

    // Getters and setters for all fields, including departmentId
    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
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

