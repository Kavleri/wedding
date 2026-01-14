/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Ini alamat URL-nya nanti
@WebServlet(name = "DeleteServlet", urlPatterns = {"/DeleteServlet"})
public class DeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Tangkap ID dari Link (misal: .../DeleteServlet?id=5)
        String idStr = request.getParameter("id");
        
        // Cek biar gak error kalau id-nya kosong
        if(idStr != null && !idStr.isEmpty()) {
            try {
                // Ubah ID dari String ("5") jadi Angka (5)
                int id = Integer.parseInt(idStr);
                
                // 2. Panggil DAO buat hapus data di database
                BookingDAO dao = new BookingDAO();
                dao.hapusBooking(id);
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // 3. Kalau udah dihapus, balik lagi ke Dashboard Admin
        // Pakai "admin/dashboard.jsp" karena kita diproses di root, mau masuk ke folder admin
        response.sendRedirect("admin/dashboard.jsp");
    }
}
