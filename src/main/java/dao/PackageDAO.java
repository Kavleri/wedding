package dao;

import java.sql.*;
import java.util.*;
import model.PackageModel;
import connection.DBConnection; 

public class PackageDAO {
    
    // ==========================================
    // 1. AMBIL SEMUA PAKET (JOIN KATEGORI)
    // ==========================================
    public List<PackageModel> getAllPackages() {
        List<PackageModel> listPaket = new ArrayList<>();
        
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT p.*, k.nama as nama_kategori FROM paket_wedding p LEFT JOIN kategori k ON p.kategori_id = k.id ORDER BY p.id ASC"; 
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                PackageModel p = new PackageModel();
                p.setId(rs.getInt("id"));
                p.setNamaPaket(rs.getString("nama_paket"));
                p.setHarga(rs.getDouble("harga"));
                p.setDeskripsi(rs.getString("deskripsi"));
                p.setKategoriId(rs.getInt("kategori_id"));
                p.setNamaKategori(rs.getString("nama_kategori"));
                
                // LOGIKA BARU: Cek Database dulu
                String dbGambar = rs.getString("gambar");
                if (dbGambar != null && !dbGambar.isEmpty()) {
                    p.setGambar(dbGambar); // Pakai gambar dari DB/Upload
                } else {
                    aturGambarOtomatis(p, rs.getString("nama_paket")); // Fallback ke otomatis
                }
                
                listPaket.add(p);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listPaket;
    }

    // ==========================================
    // 2. AMBIL 1 PAKET AJA (JOIN KATEGORI)
    // ==========================================
    public PackageModel getPackageById(int id) {
        PackageModel p = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT p.*, k.nama as nama_kategori FROM paket_wedding p LEFT JOIN kategori k ON p.kategori_id = k.id WHERE p.id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id); 
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new PackageModel();
                p.setId(rs.getInt("id"));
                p.setNamaPaket(rs.getString("nama_paket"));
                p.setHarga(rs.getDouble("harga"));
                p.setDeskripsi(rs.getString("deskripsi"));
                p.setKategoriId(rs.getInt("kategori_id"));
                p.setNamaKategori(rs.getString("nama_kategori"));

                // LOGIKA BARU: Cek Database dulu
                String dbGambar = rs.getString("gambar");
                if (dbGambar != null && !dbGambar.isEmpty()) {
                    p.setGambar(dbGambar);
                } else {
                    aturGambarOtomatis(p, rs.getString("nama_paket"));
                }
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    // ==========================================
    // 3. TAMBAH PAKET BARU (+ GAMBAR)
    // ==========================================
    public boolean insertPackage(PackageModel p) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            // Update SQL: Tambah kolom gambar
            String sql = "INSERT INTO paket_wedding (nama_paket, harga, deskripsi, kategori_id, gambar) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, p.getNamaPaket());
            ps.setDouble(2, p.getHarga());
            ps.setString(3, p.getDeskripsi());
            ps.setInt(4, p.getKategoriId());
            ps.setString(5, p.getGambar()); // Simpan Path Gambar
            
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return berhasil;
    }

    // ==========================================
    // 4. UPDATE PAKET (+ GAMBAR)
    // ==========================================
    public boolean updatePackage(PackageModel p) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            
            // Cek apakah user upload gambar baru atau tidak?
            String sql;
            if (p.getGambar() != null && !p.getGambar().isEmpty()) {
                // Update SEMUA termasuk gambar
                sql = "UPDATE paket_wedding SET nama_paket=?, harga=?, deskripsi=?, kategori_id=?, gambar=? WHERE id=?";
            } else {
                // Update DATA SAJA (Gambar lama tetap dipake)
                sql = "UPDATE paket_wedding SET nama_paket=?, harga=?, deskripsi=?, kategori_id=? WHERE id=?";
            }
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, p.getNamaPaket());
            ps.setDouble(2, p.getHarga());
            ps.setString(3, p.getDeskripsi());
            ps.setInt(4, p.getKategoriId());
            
            if (p.getGambar() != null && !p.getGambar().isEmpty()) {
                ps.setString(5, p.getGambar());
                ps.setInt(6, p.getId());
            } else {
                ps.setInt(5, p.getId());
            }
            
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return berhasil;
    }

    // ==========================================
    // 5. HAPUS PAKET
    // ==========================================
    public boolean deletePackage(int id) {
        boolean berhasil = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM paket_wedding WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            
            if(ps.executeUpdate() > 0) berhasil = true;
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return berhasil;
    }
    
    // ==========================================
    // HELPER: LOGIKA GAMBAR (Biar Gak Nulis Ulang)
    // ==========================================
    private void aturGambarOtomatis(PackageModel p, String namaDariDB) {
        if (namaDariDB == null) return;
        
        String namaLower = namaDariDB.toLowerCase(); 

        if (namaLower.contains("silver") || namaLower.contains("garden")) {
            // Kelompok 1: Paket Ekonomis atau Outdoor
            p.setGambar("assets/img/wedding7.jpg"); 
        } 
        else if (namaLower.contains("gold") || namaLower.contains("rustic") || namaLower.contains("intimate")) {
            // Kelompok 2: Paket Menengah atau Rustic
            p.setGambar("assets/img/wedding4.jpg");
        } 
        else if (namaLower.contains("platinum") || namaLower.contains("heritage") || namaLower.contains("royal")) {
            // Kelompok 3: Paket Mewah atau Adat (Gedung)
            p.setGambar("assets/img/indor.jpg"); 
        } 
        else {
            // Default
            p.setGambar("assets/img/indor.jpg"); 
        }
    }
}