package servlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingModel;
import dao.BookingDAO;
@WebServlet(name = "ProcessBooking", urlPatterns = {"/ProcessBookingServlet"})
public class ProcessBooking extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nama = request.getParameter("nama_pemesan");
            String hp = request.getParameter("no_hp");
            String tgl = request.getParameter("tanggal_acara");
            String alamat = request.getParameter("alamat");
            int paketId = 0;
            String idStr = request.getParameter("paket_id");
            if(idStr != null && !idStr.isEmpty()) {
                paketId = Integer.parseInt(idStr);
            }
            BookingModel booking = new BookingModel();
            booking.setNamaPemesan(nama);
            booking.setNoHp(hp);
            booking.setTanggalAcara(tgl);
            booking.setAlamat(alamat);
            booking.setPaketId(paketId);
            BookingDAO dao = new BookingDAO();
            String kodeBooking = dao.simpanBooking(booking);
            if (kodeBooking != null) {
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