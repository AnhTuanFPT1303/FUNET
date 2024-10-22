/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Quocb
 */
import java.time.LocalDateTime;
import java.util.Date;

public class UserActivityLog {
    private int logId;
    private int userId;
    private String role;
    private String activityType;
    private String FirstName;
    private String LastName;
    private String activityDetails;
    private LocalDateTime timestamp;

    public UserActivityLog(int logId, int userId, String role, String activityType, String FirstName, String LastName, String activityDetails, LocalDateTime timestamp) {
        this.logId = logId;
        this.userId = userId;
        this.role = role;
        this.activityType = activityType;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.activityDetails = activityDetails;
        this.timestamp = timestamp;
    }

  

    public UserActivityLog(int logId, int userId, String activityType, String activityDetails, LocalDateTime timestamp) {
        this.logId = logId;
        this.userId = userId;
        this.activityType = activityType;
        this.activityDetails = activityDetails;
        this.timestamp = timestamp;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    

    public UserActivityLog() {
    }

    
    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getActivityDetails() {
        return activityDetails;
    }

    public void setActivityDetails(String activityDetails) {
        this.activityDetails = activityDetails;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "UserActivityLog{" + "logId=" + logId + ", userId=" + userId + ", role=" + role + ", activityType=" + activityType + ", FirstName=" + FirstName + ", LastName=" + LastName + ", activityDetails=" + activityDetails + ", timestamp=" + timestamp + '}';
    }

}
