package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static final String URL = "jdbc:postgresql://localhost:5432/db_wedding";
    private static final String USER = "postgres"; 
    private static final String PASS = "shy123"; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Koneksi BERHASIL!");
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Koneksi GAGAL: " + e.getMessage());
        }
        return conn;
    }
    
    public static void main(String[] args) {
        getConnection();
    }
}