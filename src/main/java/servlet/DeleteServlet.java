package servlet;
import dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet(name = "DeleteServlet", urlPatterns = {"/DeleteServlet"})
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if(idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                BookingDAO dao = new BookingDAO();
                dao.hapusBooking(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("admin/dashboard.jsp");
    }
}