package servlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingModel;
import dao.BookingDAO;
import model.PackageModel;
import dao.PackageDAO;
@WebServlet(name = "CheckBookingServlet", urlPatterns = {"/CheckBookingServlet"})
public class CheckBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String kode = request.getParameter("kode_booking");
        if (kode == null || kode.trim().isEmpty()) {
            response.sendRedirect("check_booking.jsp?error=empty");
            return;
        }
        BookingDAO dao = new BookingDAO();
        BookingModel booking = dao.getBookingByKode(kode);
        if (booking != null) {
            PackageDAO pDao = new PackageDAO();
            PackageModel paket = pDao.getPackageById(booking.getPaketId());
            request.setAttribute("booking", booking);
            request.setAttribute("paket", paket);
            request.getRequestDispatcher("booking_detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("check_booking.jsp?error=notfound");
        }
    }
}