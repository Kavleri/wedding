/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.BookingDAO;
import model.BookingModel;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Tangkap semua data dari Form Edit
            int id = Integer.parseInt(request.getParameter("id")); // ID disembunyikan di form tadi
            String nama = request.getParameter("nama");
            String hp = request.getParameter("hp");
            String tanggal = request.getParameter("tanggal");
            String alamat = request.getParameter("alamat");
            int paket = Integer.parseInt(request.getParameter("paket"));

            // 2. Bungkus jadi satu paket Model
            BookingModel b = new BookingModel();
            b.setId(id);
            b.setNamaPemesan(nama);
            b.setNoHp(hp);
            b.setTanggalAcara(tanggal);
            b.setAlamat(alamat);
            b.setPaketId(paket);

            // 3. Panggil DAO buat Update ke Database
            BookingDAO dao = new BookingDAO();
            dao.updateBooking(b);
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4. Sukses? Balik ke Dashboard
        response.sendRedirect("admin/dashboard.jsp");
    }
}
