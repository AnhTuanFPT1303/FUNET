package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Month;
import util.sqlConnect;

public class MonthDAO {

    public List<Month> Get7Month() {
        List<Month> results = new ArrayList<>();
        String sql = "WITH MonthlyRegistrations AS ("
                + "    SELECT "
                + "        DATEADD(MONTH, DATEDIFF(MONTH, 0, created_at), 0) AS MonthStart,"
                + "        COUNT(*) AS RegistrationCount "
                + "    FROM "
                + "        userAccount "
                + "    WHERE "
                + "        created_at >= DATEADD(MONTH, -7, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) "
                + "        AND created_at < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) "
                + "    GROUP BY "
                + "        DATEADD(MONTH, DATEDIFF(MONTH, 0, created_at), 0) "
                + ") "
                + "SELECT "
                + "    DATENAME(MONTH, MonthStart) AS MonthName, "
                + "    RegistrationCount "
                + "FROM "
                + "    MonthlyRegistrations "
                + "ORDER BY "
                + "    MonthStart ASC";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String monthName = rs.getString("MonthName");
                    int count = rs.getInt("RegistrationCount");
                    results.add(new Month(monthName, count));
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return results;
    }

    public Month getLastMonthRegistrationCountAndName() {
        String sql = "SELECT COUNT(*) AS registration_count, "
                + "DATENAME(MONTH, DATEADD(MONTH, -1, GETDATE())) AS month_name "
                + "FROM userAccount WHERE "
                + "created_at >= DATEADD(MONTH, -1, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) "
                + "AND created_at < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("registration_count");
                    String monthName = rs.getString("month_name");
                    return new Month(monthName, count);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy dữ liệu
    }

    public static void main(String[] args) {
        MonthDAO dao = new MonthDAO();

        // Kiểm tra Get7Month
        System.out.println("Get7Month Results:");
        List<Month> list = dao.Get7Month();
        for (Month a : list) {
            System.out.println(a);
        }

        // Kiểm tra getLastMonthRegistrationCountAndName
        System.out.println("\nLast Month Registration Count and Name:");
        Month lastMonth = dao.getLastMonthRegistrationCountAndName();
        if (lastMonth != null) {
            System.out.println(lastMonth);
        } else {
            System.out.println("No data found for the last month.");
        }
    }
}
