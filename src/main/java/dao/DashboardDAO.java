package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import connection.DBConnection;

public class DashboardDAO {
    
    // 1. Hitung Total Pesanan Masuk
    public int getTotalPesanan() {
        int total = 0;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM booking";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) total = rs.getInt(1);
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return total;
    }
    
    // 2. Hitung Pesanan Pending (Butuh Tindakan)
    public int getPesananPending() {
        int total = 0;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM booking WHERE status = 'Pending'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) total = rs.getInt(1);
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return total;
    }
    
    // 3. Hitung Estimasi Pendapatan (Dari Pesanan Confirmed)
    // Asumsi: Harga paket ada di tabel paket_wedding
    public double getTotalPendapatan() {
        double total = 0;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT SUM(p.harga) FROM booking b JOIN paket_wedding p ON b.paket_id = p.id WHERE b.status = 'Confirmed'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) total = rs.getDouble(1);
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return total;
    }
    
    // 4. Hitung Total Staff Aktif
    public int getTotalStaff() {
        int total = 0;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM admin";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) total = rs.getInt(1);
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return total;
    }
}
