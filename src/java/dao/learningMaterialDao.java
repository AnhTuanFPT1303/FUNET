package dao;

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
            // ket noi sql va lay thong tin learningmaterial ra khoi sql
            while (resultSet.next()) {
                int learningMaterialId = resultSet.getInt("learningmaterial_id");
                int userId = resultSet.getInt("user_id");
                String learningmaterialName = resultSet.getString("learningmaterial_name");
                String learningmaterialDescription = resultSet.getString("learningmaterial_description");
                String learningmaterialImg = resultSet.getString("learningmaterial_img");
                String learningmaterialContext = resultSet.getString("learningmaterial_context");
                String subjectCode = resultSet.getString("subject_code");
                
                java.util.Date publishDate = resultSet.getDate("publish_date");
                
                // luu learningmaterial vao list learning material
                LearningMaterial learningMaterial = new LearningMaterial(learningMaterialId, userId, learningmaterialName, learningmaterialDescription, learningmaterialImg, learningmaterialContext, subjectCode, publishDate, "");
                learningMaterialsList.add(learningMaterial);
                }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return learningMaterialsList;
    }
    
    public static void main(String[] args) throws Exception {
        learningMaterialDao leMaterialDao = new learningMaterialDao();
        System.out.println(leMaterialDao.getAll());
    }
}
