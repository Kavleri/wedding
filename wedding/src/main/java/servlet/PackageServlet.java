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
import dao.PackageDAO;
import model.PackageModel;

@WebServlet(name = "PackageServlet", urlPatterns = {"/PackageServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class PackageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        PackageDAO dao = new PackageDAO();
        
        if ("add".equals(action)) {
            // TAMBAH PAKET
            String nama = request.getParameter("nama");
            double harga = Double.parseDouble(request.getParameter("harga"));
            String deskripsi = request.getParameter("deskripsi");
            int kategoriId = Integer.parseInt(request.getParameter("kategori_id"));
            
            // HANDLE UPLOAD FILE
            String gambarPath = null;
            Part filePart = request.getPart("file_gambar");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Simpan ke folder assets/uploads di server
                String uploadDir = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "uploads";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
                
                String fullPath = uploadDir + File.separator + fileName;
                filePart.write(fullPath);
                
                // Simpan relative path ke database
                gambarPath = "assets/uploads/" + fileName;
            }
            
            PackageModel p = new PackageModel();
            p.setNamaPaket(nama);
            p.setHarga(harga);
            p.setDeskripsi(deskripsi);
            p.setKategoriId(kategoriId);
            p.setGambar(gambarPath); // Set Gambar
            
            boolean sukses = dao.insertPackage(p);
            if (sukses) response.sendRedirect("admin/packages.jsp?msg=added");
            else response.sendRedirect("admin/packages.jsp?msg=failed");
        }
        else if ("edit".equals(action)) {
            // EDIT PAKET
            int id = Integer.parseInt(request.getParameter("id"));
            String nama = request.getParameter("nama");
            double harga = Double.parseDouble(request.getParameter("harga"));
            String deskripsi = request.getParameter("deskripsi");
            int kategoriId = Integer.parseInt(request.getParameter("kategori_id"));
            
            // HANDLE UPLOAD FILE (Optional saat Edit)
            String gambarPath = null;
            Part filePart = request.getPart("file_gambar");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "uploads";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
                
                String fullPath = uploadDir + File.separator + fileName;
                filePart.write(fullPath);
                gambarPath = "assets/uploads/" + fileName;
            }
            
            PackageModel p = new PackageModel();
            p.setId(id);
            p.setNamaPaket(nama);
            p.setHarga(harga);
            p.setDeskripsi(deskripsi);
            p.setKategoriId(kategoriId);
            p.setGambar(gambarPath); // Kalau null, DAO tidak akan update kolom gambar
            
            boolean sukses = dao.updatePackage(p);
            if (sukses) response.sendRedirect("admin/packages.jsp?msg=updated");
            else response.sendRedirect("admin/packages.jsp?msg=failed");
        }
        else if ("delete".equals(action)) {
            // HAPUS PAKET
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean sukses = dao.deletePackage(id);
                if (sukses) response.sendRedirect("admin/packages.jsp?msg=deleted");
                else response.sendRedirect("admin/packages.jsp?msg=failed");
            } catch(Exception e) {
                response.sendRedirect("admin/packages.jsp?msg=error");
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
