package servlet;
import java.io.IOException;
import java.io.File;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import dao.TeamDAO;
import model.TeamModel;
@WebServlet(name = "TeamServlet", urlPatterns = {"/TeamServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, 
    maxFileSize = 1024 * 1024 * 10,      
    maxRequestSize = 1024 * 1024 * 100   
)
public class TeamServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        TeamDAO dao = new TeamDAO();
        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String nama = request.getParameter("nama");
            String jabatan = request.getParameter("jabatan");
            String fotoPath = null;
            Part filePart = request.getPart("foto");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = "team_" + id + "_" + System.currentTimeMillis() + ".jpg"; 
                String uploadDir = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "img" + File.separator + "team";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
                String fullPath = uploadDir + File.separator + fileName;
                filePart.write(fullPath);
                fotoPath = "assets/img/team/" + fileName;
            }
            TeamModel t = new TeamModel();
            t.setId(id);
            t.setNama(nama);
            t.setJabatan(jabatan);
            t.setFoto(fotoPath);
            boolean sukses = dao.updateTeamMember(t);
            if (sukses) response.sendRedirect("admin/team.jsp?msg=updated");
            else response.sendRedirect("admin/team.jsp?msg=failed");
        }
        else if ("add".equals(action)) {
            String nama = request.getParameter("nama");
            String jabatan = request.getParameter("jabatan");
            String fotoPath = "assets/img/team/default.jpg";
            Part filePart = request.getPart("foto");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = "team_" + System.currentTimeMillis() + ".jpg";
                String uploadDir = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "img" + File.separator + "team";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
                String fullPath = uploadDir + File.separator + fileName;
                filePart.write(fullPath);
                fotoPath = "assets/img/team/" + fileName;
            }
            TeamModel t = new TeamModel();
            t.setNama(nama);
            t.setJabatan(jabatan);
            t.setFoto(fotoPath);
            boolean sukses = dao.insertTeamMember(t);
            if (sukses) response.sendRedirect("admin/team.jsp?msg=added");
            else response.sendRedirect("admin/team.jsp?msg=failed");
        }
        else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean sukses = dao.deleteTeamMember(id);
                if (sukses) response.sendRedirect("admin/team.jsp?msg=deleted");
                else response.sendRedirect("admin/team.jsp?msg=failed");
            } catch(Exception e) {
                response.sendRedirect("admin/team.jsp?msg=error");
            }
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}