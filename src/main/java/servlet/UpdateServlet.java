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
            int id = Integer.parseInt(request.getParameter("id"));
            String nama = request.getParameter("nama");
            String hp = request.getParameter("hp");
            String tanggal = request.getParameter("tanggal");
            String alamat = request.getParameter("alamat");
            int paket = Integer.parseInt(request.getParameter("paket"));

            BookingModel b = new BookingModel();
            b.setId(id);
            b.setNamaPemesan(nama);
            b.setNoHp(hp);
            b.setTanggalAcara(tanggal);
            b.setAlamat(alamat);
            b.setPaketId(paket);

            BookingDAO dao = new BookingDAO();
            dao.updateBooking(b);
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin/dashboard.jsp");
    }
}
