package dao;
import java.sql.*;
import java.util.ArrayList; 
import java.util.List;
import java.util.Random;
import connection.DBConnection;
import model.BookingModel;
public class BookingDAO {
    public String simpanBooking(BookingModel b) {
        String kodeUnik = null;
        try {
            Connection conn = DBConnection.getConnection();
            kodeUnik = generateKodeBooking();
            b.setKodeBooking(kodeUnik);
            String sql = "INSERT INTO booking (nama_pemesan, no_hp, tanggal_acara, alamat, paket_id, kode_booking) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, b.getNamaPemesan());
            ps.setString(2, b.getNoHp());
            ps.setDate(3, java.sql.Date.valueOf(b.getTanggalAcara()));
            ps.setString(4, b.getAlamat());
            ps.setInt(5, b.getPaketId());
            ps.setString(6, kodeUnik);
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                kodeUnik = null;
            }
            conn.close();
        } catch (Exception e) { 
            e.printStackTrace(); 
            kodeUnik = null;
        }
        return kodeUnik; 
    }
    private String generateKodeBooking() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        sb.append("WED-"); 
        for (int i = 0; i < 5; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
    public List<BookingModel> getAllBookings() {
        List<BookingModel> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM booking ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(mapResultSetToModel(rs));
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    public boolean hapusBooking(int id) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM booking WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            if (ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return berhasil;
    }
    public BookingModel getBookingById(int id) {
        BookingModel b = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM booking WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                b = mapResultSetToModel(rs);
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return b;
    }
    public boolean updateBooking(BookingModel b) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE booking SET nama_pemesan=?, no_hp=?, tanggal_acara=?, alamat=?, paket_id=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, b.getNamaPemesan());
            ps.setString(2, b.getNoHp());
            ps.setDate(3, java.sql.Date.valueOf(b.getTanggalAcara()));
            ps.setString(4, b.getAlamat());
            ps.setInt(5, b.getPaketId());
            ps.setInt(6, b.getId());
            if (ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return berhasil;
    }
    public BookingModel getBookingByKode(String kode) {
        BookingModel b = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM booking WHERE kode_booking = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, kode);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                b = mapResultSetToModel(rs);
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return b;
    }
    public boolean updateStatus(int id, String status) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE booking SET status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, id);
            if (ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return berhasil;
    }
    private BookingModel mapResultSetToModel(ResultSet rs) throws SQLException {
        BookingModel b = new BookingModel();
        b.setId(rs.getInt("id"));
        b.setNamaPemesan(rs.getString("nama_pemesan")); 
        b.setNoHp(rs.getString("no_hp"));
        b.setTanggalAcara(rs.getString("tanggal_acara")); 
        b.setAlamat(rs.getString("alamat"));
        b.setPaketId(rs.getInt("paket_id"));
        b.setKodeBooking(rs.getString("kode_booking")); 
        b.setStatus(rs.getString("status")); 
        return b;
    }
}