package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import connection.DBConnection;
import model.TeamModel;
public class TeamDAO {
    public List<TeamModel> getAllTeamMembers() {
        List<TeamModel> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM team_members ORDER BY id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                TeamModel t = new TeamModel();
                t.setId(rs.getInt("id"));
                t.setNama(rs.getString("nama"));
                t.setJabatan(rs.getString("jabatan"));
                t.setFoto(rs.getString("foto"));
                list.add(t);
            }
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }
    public boolean updateTeamMember(TeamModel t) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql;
            if (t.getFoto() != null && !t.getFoto().isEmpty()) {
                sql = "UPDATE team_members SET nama=?, jabatan=?, foto=? WHERE id=?";
            } else {
                sql = "UPDATE team_members SET nama=?, jabatan=? WHERE id=?";
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, t.getNama());
            ps.setString(2, t.getJabatan());
            if (t.getFoto() != null && !t.getFoto().isEmpty()) {
                ps.setString(3, t.getFoto());
                ps.setInt(4, t.getId());
            } else {
                ps.setInt(3, t.getId());
            }
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return berhasil;
    }
    public boolean insertTeamMember(TeamModel t) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO team_members (nama, jabatan, foto) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, t.getNama());
            ps.setString(2, t.getJabatan());
            ps.setString(3, t.getFoto());
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return berhasil;
    }
    public boolean deleteTeamMember(int id) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM team_members WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch(Exception e) { e.printStackTrace(); }
        return berhasil;
    }
}