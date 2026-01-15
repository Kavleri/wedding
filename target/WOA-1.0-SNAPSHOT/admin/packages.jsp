<%@page import="java.util.List"%>
<%@page import="model.PackageModel"%>
<%@page import="dao.PackageDAO"%>
<%@page import="model.CategoryModel"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="model.AdminModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("adminLog") == null){
        response.sendRedirect("../login.jsp");
        return; 
    }
    AdminModel admin = (AdminModel) session.getAttribute("adminLog");
    PackageDAO packageDAO = new PackageDAO();
    CategoryDAO categoryDAO = new CategoryDAO();
    List<PackageModel> listPaket = packageDAO.getAllPackages();
    List<CategoryModel> listKategori = categoryDAO.getAllCategories();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Kelola Paket | Amba Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https:
    <link rel="stylesheet" href="https:
    <style>
        body { background-color: #f8f9fa; }
        .sidebar {
            min-height: 100vh;
            background: #b76e79;
            color: white;
            width: 250px;
        }
        .sidebar a { color: rgba(255,255,255,0.8); text-decoration: none; padding: 15px; display: block; }
        .sidebar a:hover { background: rgba(255,255,255,0.2); color: white; }
        .nav-link.active { background: white !important; color: #b76e79 !important; font-weight: bold; }
        .content { 
            padding: 30px; 
            flex-grow: 1;
            width: 100%;
        }
        .card-stat { border: none; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
<div class="d-flex">
    <div class="sidebar d-flex flex-column flex-shrink-0 p-3">
        <h4 class="text-center mb-4">
            <i class="fas fa-heart me-2"></i>
            <%= (admin.getRole() != null && "admin".equalsIgnoreCase(admin.getRole())) ? "Amba Admin" : "Amba Staff" %>
        </h4>
        <hr>
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item">
                <a href="dashboard.jsp" class="nav-link text-white">
                    <i class="fas fa-chart-line me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="orders.jsp" class="nav-link text-white">
                    <i class="fas fa-calendar-check me-2"></i> Kelola Pesanan
                </a>
            </li>
            <li class="nav-item">
                <a href="inbox.jsp" class="nav-link text-white">
                    <i class="fas fa-envelope me-2"></i> Kotak Masuk
                </a>
            </li>
            <li class="nav-item">
                <a href="packages.jsp" class="nav-link active">
                    <i class="fas fa-box-open me-2"></i> Kelola Paket
                </a>
            </li>
            <% 
            String role = admin.getRole();
            if(role == null || "admin".equalsIgnoreCase(role)) { 
            %>
            <li class="nav-item">
                <a href="staff.jsp" class="nav-link text-white">
                    <i class="fas fa-users-cog me-2"></i> Kelola Staff
                </a>
            </li>
            <li class="nav-item">
                <a href="team.jsp" class="nav-link text-white">
                    <i class="fas fa-id-badge me-2"></i> Kelola Tim (About)
                </a>
            </li>
            <% } %>
            <li class="nav-item mt-5">
                <a href="../LogoutServlet" class="nav-link bg-danger text-white rounded">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>
    <div class="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Manajemen Paket Wedding</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPackageModal">
                <i class="fas fa-plus me-2"></i> Tambah Paket
            </button>
        </div>
        <% 
            String msg = request.getParameter("msg");
            if("added".equals(msg)) { %> <div class="alert alert-success">Paket berhasil ditambahkan!</div> <% }
            else if("updated".equals(msg)) { %> <div class="alert alert-success">Paket berhasil diperbarui!</div> <% }
            else if("deleted".equals(msg)) { %> <div class="alert alert-success">Paket berhasil dihapus!</div> <% }
            else if("failed".equals(msg)) { %> <div class="alert alert-danger">Gagal memproses data!</div> <% }
        %>
        <div class="card card-stat p-4">
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>No</th>
                            <th>Gambar</th>
                            <th>Nama Paket</th>
                            <th>Kategori</th>
                            <th>Harga (Rp)</th>
                            <th style="width: 30%;">Deskripsi</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int no = 1;
                            if (listPaket != null && !listPaket.isEmpty()) {
                                for(PackageModel p : listPaket) {
                        %>
                        <tr>
                            <td><%= no++ %></td>
                            <td>
                                <img src="../<%= p.getGambar() %>" class="rounded" style="width: 60px; height: 40px; object-fit: cover;">
                            </td>
                            <td><%= p.getNamaPaket() %></td>
                            <td><span class="badge bg-info text-dark"><%= p.getNamaKategori() != null ? p.getNamaKategori() : "-" %></span></td>
                            <td><%= String.format("%,.0f", p.getHarga()) %></td>
                            <td class="small text-muted"><%= p.getDeskripsi() %></td>
                            <td>
                                <button class="btn btn-sm btn-warning me-1" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#editPackageModal<%= p.getId() %>">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <a href="../PackageServlet?action=delete&id=<%= p.getId() %>" 
                                   class="btn btn-sm btn-danger" 
                                   onclick="return confirm('Hapus paket ini?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <div class="modal fade" id="editPackageModal<%= p.getId() %>" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Paket</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="../PackageServlet" method="POST" enctype="multipart/form-data">
                                        <input type="hidden" name="action" value="edit">
                                        <input type="hidden" name="id" value="<%= p.getId() %>">
                                        <div class="modal-body">
                                            <div class="mb-3 text-center">
                                                <img src="../<%= p.getGambar() %>" class="img-thumbnail" style="max-height: 150px;">
                                                <p class="small text-muted mt-1">Gambar Saat Ini</p>
                                            </div>
                                            <div class="mb-3">
                                                <label>Ganti Gambar (Opsional)</label>
                                                <input type="file" name="file_gambar" class="form-control" accept="image/*">
                                            </div>
                                            <div class="mb-3">
                                                <label>Nama Paket</label>
                                                <input type="text" name="nama" class="form-control" value="<%= p.getNamaPaket() %>" required>
                                            </div>
                                            <div class="mb-3">
                                                <label>Kategori</label>
                                                <select name="kategori_id" class="form-select" required>
                                                    <% for(CategoryModel k : listKategori) { %>
                                                    <option value="<%= k.getId() %>" <%= (k.getId() == p.getKategoriId()) ? "selected" : "" %>>
                                                        <%= k.getNama() %>
                                                    </option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label>Harga (Rp)</label>
                                                <input type="number" name="harga" class="form-control" value="<%= (long)p.getHarga() %>" required>
                                            </div>
                                            <div class="mb-3">
                                                <label>Deskripsi</label>
                                                <textarea name="deskripsi" class="form-control" rows="3" required><%= p.getDeskripsi() %></textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                                            <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% 
                                } 
                            } else { 
                        %>
                        <tr><td colspan="6" class="text-center">Belum ada data paket.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addPackageModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Paket Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="../PackageServlet" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Nama Paket</label>
                        <input type="text" name="nama" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Kategori</label>
                        <select name="kategori_id" class="form-select" required>
                            <% for(CategoryModel k : listKategori) { %>
                            <option value="<%= k.getId() %>"><%= k.getNama() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label>Harga (Rp)</label>
                        <input type="number" name="harga" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Gambar Paket</label>
                        <input type="file" name="file_gambar" class="form-control" accept="image/*" required>
                        <small class="text-muted">Format: JPG, PNG, WEBP (Max 10MB)</small>
                    </div>
                    <div class="mb-3">
                        <label>Deskripsi</label>
                        <textarea name="deskripsi" class="form-control" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https:
</body>
</html>