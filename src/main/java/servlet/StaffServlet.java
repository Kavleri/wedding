package servlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.AdminDAO;
import model.AdminModel;
@WebServlet(name = "StaffServlet", urlPatterns = {"/StaffServlet"})
public class StaffServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        AdminDAO dao = new AdminDAO();
        if ("add".equals(action)) {
            String nama = request.getParameter("nama");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role"); 
            AdminModel admin = new AdminModel();
            admin.setNama(nama);
            admin.setEmail(email);
            admin.setPassword(password);
            admin.setRole(role); 
            boolean sukses = dao.registerAdmin(admin);
            if (sukses) {
                response.sendRedirect("admin/staff.jsp?msg=added");
            } else {
                response.sendRedirect("admin/staff.jsp?msg=failed");
            }
        } 
        else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean sukses = dao.deleteAdmin(id);
                if (sukses) {
                    response.sendRedirect("admin/staff.jsp?msg=deleted");
                } else {
                    response.sendRedirect("admin/staff.jsp?msg=failed");
                }
            } catch (Exception e) {
                response.sendRedirect("admin/staff.jsp?msg=error");
            }
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}