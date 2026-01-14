package dao;

import java.sql.*;
import connection.DBConnection;
import model.UserModel;

public class UserDAO {
    
    // Method khusus buat Cek Login
    public UserModel cekLogin(String user, String pass) {
        UserModel u = null;
        try {
            Connection conn = DBConnection.getConnection();
            
            // Query buat nyari user yang cocok
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            
            ResultSet rs = ps.executeQuery();
            
            // Kalau ketemu datanya...
            if (rs.next()) {
                u = new UserModel();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                // Password gak kita ambil biar aman
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u; // Kembalikan data user (atau null kalau ga ketemu)
    }
}