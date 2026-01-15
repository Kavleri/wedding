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
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        AdminDAO dao = new AdminDAO();
        AdminModel admin = dao.cekLogin(email, password);
        
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminLog", admin); 
            response.sendRedirect("admin/dashboard.jsp"); 
        } else {
            response.sendRedirect("login.jsp?status=failed");
        }
    }
}
