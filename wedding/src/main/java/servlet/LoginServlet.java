package servlet;

import dao.AdminDAO;
import model.AdminModel;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Ambil inputan dari form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // 2. Cek ke Database pake AdminDAO
        AdminDAO dao = new AdminDAO();
        AdminModel admin = dao.cekLogin(email, password);
        
        if (admin != null) {
            // === LOGIN SUKSES ===
            // Simpan data admin di "Session"
            HttpSession session = request.getSession();
            session.setAttribute("adminLog", admin); 
            
            // === BAGIAN INI YANG DIPERBAIKI ===
            // Karena file dashboard.jsp ada di dalam folder 'admin'
            response.sendRedirect("admin/dashboard.jsp"); 
            
        } else {
            // === LOGIN GAGAL ===
            // Balikin ke login lagi (file login.jsp ada di luar folder admin)
            response.sendRedirect("login.jsp?status=failed");
        }
    }
}