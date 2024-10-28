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
import java.util.Date;
import java.util.List;
import model.LearningMaterial;
import util.sqlConnect;

public class learningMaterialDao {

    public List<LearningMaterial> getAll() throws Exception {
        List<LearningMaterial> learningMaterialsList = new ArrayList<>();
        String sql = "SELECT * FROM learningmaterial";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql); ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                int learningMaterialId = resultSet.getInt("learningmaterial_id");
                int userId = resultSet.getInt("user_id");
                String learningmaterialName = resultSet.getString("learningmaterial_name");
                String learningmaterialDescription = resultSet.getString("learningmaterial_description");
                String learningmaterialContext = resultSet.getString("learningmaterial_context");
                String subjectCode = resultSet.getString("subject_code");
                java.util.Date publishDate = resultSet.getDate("publish_date");
                String review = resultSet.getString("review");
                int departmentId = resultSet.getInt("department_id");

                LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, learningmaterialName, learningmaterialDescription, learningmaterialContext, subjectCode, publishDate, review, departmentId);
                learningMaterialsList.add(learningMaterial);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return learningMaterialsList;
    }

    public LearningMaterial getLearningMaterialById(int learningMaterialId) throws SQLException, Exception {
        String sql = "SELECT * FROM learningmaterial WHERE learningmaterial_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, learningMaterialId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String learningMaterialName = rs.getString("learningmaterial_name");
                    String learningMaterialDescription = rs.getString("learningmaterial_description");
                    String learningMaterialContext = rs.getString("learningmaterial_context");
                    String subjectCode = rs.getString("subject_code");
                    Date publishDate = rs.getDate("publish_date");
                    String review = rs.getString("review");
                    int departmentId = rs.getInt("department_id");

                    return new LearningMaterial(learningMaterialId, userId, learningMaterialName, learningMaterialDescription, learningMaterialContext, subjectCode, publishDate, review, departmentId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error retrieving learning material", e);
        }
        return null;
    }

    public List<LearningMaterial> searchLearningMaterials(String keyword) throws Exception {
        List<LearningMaterial> learningMaterialsList = new ArrayList<>();
        String sql = "SELECT * FROM learningmaterial WHERE learningmaterial_name LIKE ? OR learningmaterial_description LIKE ? OR subject_code LIKE ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, "%" + keyword + "%");
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, "%" + keyword + "%");
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int learningMaterialId = resultSet.getInt("learningmaterial_id");
                    int userId = resultSet.getInt("user_id");
                    String learningmaterialName = resultSet.getString("learningmaterial_name");
                    String learningmaterialDescription = resultSet.getString("learningmaterial_description");
                    String learningmaterialContext = resultSet.getString("learningmaterial_context");
                    String subjectCode = resultSet.getString("subject_code");
                    java.util.Date publishDate = resultSet.getDate("publish_date");
                    String review = resultSet.getString("review");
                    int departmentId = resultSet.getInt("department_id");

                    LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, learningmaterialName, learningmaterialDescription, learningmaterialContext, subjectCode, publishDate, review, departmentId);
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

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setInt(1, departmentId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int learningMaterialId = resultSet.getInt("learningmaterial_id");
                    int userId = resultSet.getInt("user_id");
                    String learningmaterialName = resultSet.getString("learningmaterial_name");
                    String learningmaterialDescription = resultSet.getString("learningmaterial_description");
                    String learningmaterialContext = resultSet.getString("learningmaterial_context");
                    String subjectCode = resultSet.getString("subject_code");
                    java.util.Date publishDate = resultSet.getDate("publish_date");
                    String review = resultSet.getString("review");
                    int departmentIdResult = resultSet.getInt("department_id");

                    LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, learningmaterialName, learningmaterialDescription, learningmaterialContext, subjectCode, publishDate, review, departmentIdResult);
                    learningMaterialsList.add(learningMaterial);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return learningMaterialsList;
    }

    public void createLearningMaterial(LearningMaterial learningMaterial) throws SQLException, Exception {
        String sql = "INSERT INTO learningmaterial (user_id, learningmaterial_name, learningmaterial_description, learningmaterial_context, subject_code, publish_date, review, department_id) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, learningMaterial.getUserId());
            stmt.setString(2, learningMaterial.getLearningMaterialName());
            stmt.setString(3, learningMaterial.getLearningMaterialDescription());
            stmt.setString(4, learningMaterial.getLearningMaterialContext());
            stmt.setString(5, learningMaterial.getSubjectCode());
            stmt.setTimestamp(6, new java.sql.Timestamp(learningMaterial.getPublishDate().getTime()));
            stmt.setString(7, learningMaterial.getReview());
            stmt.setInt(8, learningMaterial.getDepartmentId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error creating learning material", e);
        }
    }

   public void updateLearningMaterial(LearningMaterial learningMaterial) throws SQLException, Exception {
    String sql = "UPDATE learningmaterial SET learningmaterial_name = ?, learningmaterial_description = ?, learningmaterial_context = ?, subject_code = ?, publish_date = ?, review = ?, department_id = ? WHERE learningmaterial_id = ?";
    try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, learningMaterial.getLearningMaterialName());
        stmt.setString(2, learningMaterial.getLearningMaterialDescription());
        stmt.setString(3, learningMaterial.getLearningMaterialContext());
        stmt.setString(4, learningMaterial.getSubjectCode());
        stmt.setTimestamp(5, new java.sql.Timestamp(learningMaterial.getPublishDate().getTime()));
        stmt.setString(6, learningMaterial.getReview());
        stmt.setInt(7, learningMaterial.getDepartmentId());
        stmt.setInt(8, learningMaterial.getLearningMaterialId());
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

     public void saveLearningMaterial(int userId, int learningMaterialId) throws SQLException, Exception {
        String sql = "INSERT INTO saved_learning_materials (user_id, learning_material_id) VALUES (?, ?)";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, learningMaterialId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error saving learning material", e);
        }
    }

    public List<LearningMaterial> getSavedLearningMaterials(int userId) throws SQLException, Exception {
    List<LearningMaterial> savedMaterials = new ArrayList<>();
    String query = "SELECT lm.learningmaterial_id, lm.user_id, lm.learningmaterial_name, lm.learningmaterial_description, lm.learningmaterial_context, lm.subject_code, lm.publish_date, lm.review, lm.department_id " +
                   "FROM saved_learning_materials slm " +
                   "JOIN learningmaterial lm ON slm.learning_material_id = lm.learningmaterial_id " +
                   "WHERE slm.user_id = ?";
    try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setInt(1, userId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int learningMaterialId = rs.getInt("learningmaterial_id");
                int userIdDb = rs.getInt("user_id");
                String learningMaterialName = rs.getString("learningmaterial_name");
                String learningMaterialDescription = rs.getString("learningmaterial_description");
                String learningMaterialContext = rs.getString("learningmaterial_context");
                String subjectCode = rs.getString("subject_code");
                Date publishDate = rs.getDate("publish_date");
                String review = rs.getString("review");
                int departmentId = rs.getInt("department_id");

                LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userIdDb, learningMaterialName, learningMaterialDescription, learningMaterialContext, subjectCode, publishDate, review, departmentId);
                savedMaterials.add(learningMaterial);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw new Exception("Error retrieving saved learning materials", e);
    }
    return savedMaterials;
}
    public static void main(String[] args) {
        try {
            learningMaterialDao dao = new learningMaterialDao();
            List<LearningMaterial> materials = dao.getAll();
            dao.getSavedLearningMaterials(2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
