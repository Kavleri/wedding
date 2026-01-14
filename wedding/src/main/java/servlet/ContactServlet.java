package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ContactDAO;
import model.ContactModel;

@WebServlet(name = "ContactServlet", urlPatterns = {"/ContactServlet"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        ContactDAO dao = new ContactDAO();
        
        if ("send".equals(action)) {
            // KIRIM PESAN (Dari Halaman Contact Us)
            String nama = request.getParameter("name");
            String email = request.getParameter("email");
            String subjek = request.getParameter("subject");
            String pesan = request.getParameter("message");
            
            ContactModel c = new ContactModel();
            c.setNama(nama);
            c.setEmail(email);
            c.setSubjek(subjek);
            c.setPesan(pesan);
            
            boolean sukses = dao.saveMessage(c);
            if (sukses) {
                response.sendRedirect("contact.jsp?msg=sent");
            } else {
                response.sendRedirect("contact.jsp?msg=failed");
            }
        } 
        else if ("delete".equals(action)) {
            // HAPUS PESAN (Dari Admin Inbox)
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteMessage(id);
                response.sendRedirect("admin/inbox.jsp?msg=deleted");
            } catch(Exception e) {
                response.sendRedirect("admin/inbox.jsp?msg=error");
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
