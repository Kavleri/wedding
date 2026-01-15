package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import connection.DBConnection;
import model.CategoryModel;
public class CategoryDAO {
    public List<CategoryModel> getAllCategories() {
        List<CategoryModel> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM kategori ORDER BY id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                CategoryModel c = new CategoryModel();
                c.setId(rs.getInt("id"));
                c.setNama(rs.getString("nama"));
                list.add(c);
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}