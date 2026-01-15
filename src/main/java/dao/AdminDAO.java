package dao;

import connection.DBConnection;
import model.AdminModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    
    public boolean registerAdmin(AdminModel admin) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO admin (nama, email, password, role) VALUES (?, ?, ?, ?)";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, admin.getNama());
            ps.setString(2, admin.getEmail());
            ps.setString(3, admin.getPassword()); 
            ps.setString(4, admin.getRole());
            
            int baris = ps.executeUpdate();
            if (baris > 0) {
                berhasil = true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return berhasil;
    }

    public AdminModel cekLogin(String email, String password) {
        AdminModel admin = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                admin = new AdminModel();
                admin.setId(rs.getInt("id"));
                admin.setNama(rs.getString("nama"));
                admin.setEmail(rs.getString("email"));
                admin.setRole(rs.getString("role"));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }

    public List<AdminModel> getAllAdmins() {
        List<AdminModel> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM admin ORDER BY id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                AdminModel a = new AdminModel();
                a.setId(rs.getInt("id"));
                a.setNama(rs.getString("nama"));
                a.setEmail(rs.getString("email"));
                a.setRole(rs.getString("role"));
                list.add(a);
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean deleteAdmin(int id) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM admin WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            
            if (ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return berhasil;
    }
}
