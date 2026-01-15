package servlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.BookingDAO;
@WebServlet(name = "UpdateStatusServlet", urlPatterns = {"/UpdateStatusServlet"})
public class UpdateStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            String status = request.getParameter("status");
            if (idStr != null && status != null) {
                int id = Integer.parseInt(idStr);
                BookingDAO dao = new BookingDAO();
                boolean sukses = dao.updateStatus(id, status);
                if (sukses) {
                    response.sendRedirect("admin/dashboard.jsp?msg=updated");
                } else {
                    response.sendRedirect("admin/dashboard.jsp?msg=failed");
                }
            } else {
                response.sendRedirect("admin/dashboard.jsp?msg=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/dashboard.jsp?msg=error");
        }
    }
}