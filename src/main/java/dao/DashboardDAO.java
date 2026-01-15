package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import connection.DBConnection;
public class DashboardDAO {
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