/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
// Perhatikan: Sekarang pake 'jakarta', bukan 'javax'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Import Model & DAO
import model.BookingModel;
import dao.BookingDAO;

@WebServlet(name = "ProcessBooking", urlPatterns = {"/ProcessBookingServlet"})
public class ProcessBooking extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Ambil data dari Form
            String nama = request.getParameter("nama_pemesan");
            String hp = request.getParameter("no_hp");
            String tgl = request.getParameter("tanggal_acara");
            String alamat = request.getParameter("alamat");
            
            // Ambil ID Paket
            int paketId = 0;
            String idStr = request.getParameter("paket_id");
            if(idStr != null && !idStr.isEmpty()) {
                paketId = Integer.parseInt(idStr);
            }
            
            // 2. Masukin ke Model
            BookingModel booking = new BookingModel();
            booking.setNamaPemesan(nama);
            booking.setNoHp(hp);
            booking.setTanggalAcara(tgl);
            booking.setAlamat(alamat);
            booking.setPaketId(paketId);
            
            // 3. Simpan ke Database
            BookingDAO dao = new BookingDAO();
            String kodeBooking = dao.simpanBooking(booking);
            
            // 4. Cek Hasil
            if (kodeBooking != null) {
                // Redirect bawa kode booking biar bisa ditampilin
                response.sendRedirect("success.jsp?kode=" + kodeBooking);
            } else {
                response.sendRedirect("packages.jsp?status=gagal");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("packages.jsp?error=system");
        }
    }
}