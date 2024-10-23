/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author gabri
 */





import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.LearningMaterial;
import util.sqlConnect;

public class learningMaterialDao {
    public List<LearningMaterial> getAll() throws Exception {
        List<LearningMaterial> learningMaterialsList = new ArrayList<>();
        String sql = "SELECT * FROM learningmaterial";  
        
        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                int learningMaterialId = resultSet.getInt("learningmaterial_id");
                int userId = resultSet.getInt("user_id");
                String learningmaterialName = resultSet.getString("learningmaterial_name");
                String learningmaterialDescription = resultSet.getString("learningmaterial_description");
                String learningmaterialImg = resultSet.getString("learningmaterial_img");
                String learningmaterialContext = resultSet.getString("learningmaterial_context");
                String subjectCode = resultSet.getString("subject_code");
                java.util.Date publishDate = resultSet.getDate("publish_date");
                String review = resultSet.getString("review");
                int departmentId = resultSet.getInt("department_id");

                LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, learningmaterialName, learningmaterialDescription, learningmaterialImg, learningmaterialContext, subjectCode, publishDate, review, departmentId);
                learningMaterialsList.add(learningMaterial);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return learningMaterialsList;
    }

    public List<LearningMaterial> searchLearningMaterials(String keyword) throws Exception {
        List<LearningMaterial> learningMaterialsList = new ArrayList<>();
        String sql = "SELECT * FROM learningmaterial WHERE learningmaterial_name LIKE ? OR learningmaterial_description LIKE ? OR subject_code LIKE ?";

        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, "%" + keyword + "%");
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, "%" + keyword + "%");
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int learningMaterialId = resultSet.getInt("learningmaterial_id");
                    int userId = resultSet.getInt("user_id");
                    String learningmaterialName = resultSet.getString("learningmaterial_name");
                    String learningmaterialDescription = resultSet.getString("learningmaterial_description");
                    String learningmaterialImg = resultSet.getString("learningmaterial_img");
                    String learningmaterialContext = resultSet.getString("learningmaterial_context");
                    String subjectCode = resultSet.getString("subject_code");
                    java.util.Date publishDate = resultSet.getDate("publish_date");
                    String review = resultSet.getString("review");
                    int departmentId = resultSet.getInt("department_id");

                    LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, learningmaterialName, learningmaterialDescription, learningmaterialImg, learningmaterialContext, subjectCode, publishDate, review, departmentId);
                    learningMaterialsList.add(learningMaterial);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return learningMaterialsList;
    }
     public List<LearningMaterial> getByDepartment(int departmentId) throws Exception {
        List<LearningMaterial> learningMaterialsList = new ArrayList<>();
        String sql = "SELECT * FROM learningmaterial WHERE department_id = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setInt(1, departmentId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int learningMaterialId = resultSet.getInt("learningmaterial_id");
                    int userId = resultSet.getInt("user_id");
                    String learningmaterialName = resultSet.getString("learningmaterial_name");
                    String learningmaterialDescription = resultSet.getString("learningmaterial_description");
                    String learningmaterialImg = resultSet.getString("learningmaterial_img");
                    String learningmaterialContext = resultSet.getString("learningmaterial_context");
                    String subjectCode = resultSet.getString("subject_code");
                    java.util.Date publishDate = resultSet.getDate("publish_date");
                    String review = resultSet.getString("review");
                    int departmentIdResult = resultSet.getInt("department_id");

                    LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, learningmaterialName, learningmaterialDescription, learningmaterialImg, learningmaterialContext, subjectCode, publishDate, review, departmentIdResult);
                    learningMaterialsList.add(learningMaterial);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return learningMaterialsList;
    }
      public void addLearningMaterial(LearningMaterial learningMaterial) throws SQLException, Exception {
    String sql = "INSERT INTO learningmaterial (user_id, learningmaterial_name, learningmaterial_description, learningmaterial_img, learningmaterial_context, subject_code, publish_date, review, department_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, learningMaterial.getUserId());
        stmt.setString(2, learningMaterial.getLearningMaterialName());
        stmt.setString(3, learningMaterial.getLearningMaterialDescription());
        stmt.setString(4, learningMaterial.getLearningMaterial_img());
        stmt.setString(5, learningMaterial.getLearningMaterialContext());
        stmt.setString(6, learningMaterial.getSubjectCode());
        stmt.setTimestamp(7, new java.sql.Timestamp(learningMaterial.getPublishDate().getTime())); // Ensure millisecond precision
        stmt.setString(8, learningMaterial.getReview());
        stmt.setInt(9, learningMaterial.getDepartmentId());
        stmt.executeUpdate();
    }
}
      public void updateLearningMaterial(LearningMaterial learningMaterial) throws SQLException, Exception {
    String sql = "UPDATE learningmaterial SET learningmaterial_name = ?, learningmaterial_description = ?, learningmaterial_img = ?, learningmaterial_context = ?, subject_code = ?, publish_date = ?, review = ?, department_id = ? WHERE learningmaterial_id = ?";
    try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, learningMaterial.getLearningMaterialName());
        stmt.setString(2, learningMaterial.getLearningMaterialDescription());
        stmt.setString(3, learningMaterial.getLearningMaterial_img());
        stmt.setString(4, learningMaterial.getLearningMaterialContext());
        stmt.setString(5, learningMaterial.getSubjectCode());
        stmt.setTimestamp(6, new java.sql.Timestamp(learningMaterial.getPublishDate().getTime())); // Ensure millisecond precision
        stmt.setString(7, learningMaterial.getReview());
        stmt.setInt(8, learningMaterial.getDepartmentId());
        stmt.setInt(9, learningMaterial.getLearningMaterialId());
        stmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
        throw new Exception("Error updating learning material", e);
    }
}
      public void deleteLearningMaterial(int learningMaterialId) throws SQLException, Exception {
    String sql = "DELETE FROM learningmaterial WHERE learningmaterial_id = ?";
    try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, learningMaterialId);
        stmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
        throw new Exception("Error deleting learning material", e);
    }
}

    public static void main(String[] args) throws Exception {
        learningMaterialDao leMaterialDao = new learningMaterialDao();
        System.out.println(leMaterialDao.getAll());
    }
}