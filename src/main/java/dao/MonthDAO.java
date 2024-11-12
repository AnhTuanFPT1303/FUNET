package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Month;
import util.sqlConnect;

public class MonthDAO {
   public List<Month> Get7Month() {
    List<Month> results = new ArrayList<>();
    String sql = "WITH Numbers AS ("
            + "    SELECT 0 AS number"
            + "    UNION ALL"
            + "    SELECT number + 1"
            + "    FROM Numbers"
            + "    WHERE number < 6"
            + "), "
            + "LastSevenMonths AS ("
            + "    SELECT "
            + "        DATEADD(MONTH, number, DATEADD(MONTH, -6, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0))) AS MonthStart "
            + "    FROM Numbers"
            + "), "
            + "MonthlyRegistrations AS ("
            + "    SELECT "
            + "        DATEADD(MONTH, DATEDIFF(MONTH, 0, created_at), 0) AS MonthStart,"
            + "        COUNT(*) AS RegistrationCount "
            + "    FROM "
            + "        userAccount "
            + "    WHERE "
            + "        created_at >= DATEADD(MONTH, -6, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) "
            + "        AND created_at < DATEADD(MONTH, 1, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) "
            + "    GROUP BY "
            + "        DATEADD(MONTH, DATEDIFF(MONTH, 0, created_at), 0) "
            + ") "
            + "SELECT "
            + "    DATENAME(MONTH, m.MonthStart) AS MonthName, "
            + "    ISNULL(r.RegistrationCount, 0) AS RegistrationCount "
            + "FROM "
            + "    LastSevenMonths m "
            + "    LEFT JOIN MonthlyRegistrations r ON m.MonthStart = r.MonthStart "
            + "ORDER BY "
            + "    m.MonthStart ASC";

    try (Connection conn = sqlConnect.getInstance().getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        String sql = "SELECT ISNULL(COUNT(*), 0) AS registration_count, "
                + "DATENAME(MONTH, DATEADD(MONTH, -1, GETDATE())) AS month_name "
                + "FROM userAccount WHERE "
                + "created_at >= DATEADD(MONTH, -1, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) "
                + "AND created_at < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)";

        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        return null;
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
