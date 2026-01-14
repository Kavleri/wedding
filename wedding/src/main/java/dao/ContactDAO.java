package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import connection.DBConnection;
import model.ContactModel;

public class ContactDAO {
    
    // 1. Simpan Pesan Baru
    public boolean saveMessage(ContactModel c) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO kontak (nama, email, subjek, pesan) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getNama());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getSubjek());
            ps.setString(4, c.getPesan());
            
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return berhasil;
    }
    
    // 2. Ambil Semua Pesan (Untuk Admin Inbox)
    public List<ContactModel> getAllMessages() {
        List<ContactModel> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM kontak ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                ContactModel c = new ContactModel();
                c.setId(rs.getInt("id"));
                c.setNama(rs.getString("nama"));
                c.setEmail(rs.getString("email"));
                c.setSubjek(rs.getString("subjek"));
                c.setPesan(rs.getString("pesan"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(c);
            }
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }
    
    // 3. Hapus Pesan
    public boolean deleteMessage(int id) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM kontak WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return berhasil;
    }
}
