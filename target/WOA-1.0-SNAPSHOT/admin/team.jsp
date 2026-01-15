<%@page import="java.util.List"%>
<%@page import="model.TeamModel"%>
<%@page import="dao.TeamDAO"%>
<%@page import="model.AdminModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("adminLog") == null){
        response.sendRedirect("../login.jsp");
        return; 
    }
    AdminModel admin = (AdminModel) session.getAttribute("adminLog");
    if(admin.getRole() != null && !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    TeamDAO teamDAO = new TeamDAO();
    List<TeamModel> listTeam = teamDAO.getAllTeamMembers();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Kelola Tim | Amba Admin</title>
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
        .team-preview {
            width: 80px; height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
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
                <a href="packages.jsp" class="nav-link text-white">
                    <i class="fas fa-box-open me-2"></i> Kelola Paket
                </a>
            </li>
            <li class="nav-item">
                <a href="staff.jsp" class="nav-link text-white">
                    <i class="fas fa-users-cog me-2"></i> Kelola Staff
                </a>
            </li>
            <li class="nav-item">
                <a href="team.jsp" class="nav-link active">
                    <i class="fas fa-id-badge me-2"></i> Kelola Tim (About)
                </a>
            </li>
            <li class="nav-item mt-5">
                <a href="../LogoutServlet" class="nav-link bg-danger text-white rounded">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>
    <div class="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="mb-0">Kelola Tim (Halaman About Us)</h2>
                <p class="text-muted">Edit data anggota tim yang tampil di halaman publik.</p>
            </div>
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addTeamModal">
                <i class="fas fa-plus me-2"></i> Tambah Anggota
            </button>
        </div>
        <% 
            String msg = request.getParameter("msg");
            if("updated".equals(msg)) { %> <div class="alert alert-success">Data tim berhasil diperbarui!</div> <% }
            else if("added".equals(msg)) { %> <div class="alert alert-success">Anggota baru berhasil ditambahkan!</div> <% }
            else if("deleted".equals(msg)) { %> <div class="alert alert-success">Anggota berhasil dihapus!</div> <% }
            else if("failed".equals(msg)) { %> <div class="alert alert-danger">Gagal memproses data!</div> <% }
        %>
        <div class="card border-0 shadow-sm rounded-4 p-4">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Foto</th>
                            <th>Nama Anggota</th>
                            <th>Jabatan / Peran</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listTeam != null) {
                                for(TeamModel t : listTeam) {
                        %>
                        <tr>
                            <td>
                                <img src="../<%= t.getFoto() %>" class="team-preview" 
                                     onerror="this.src='https:
                            </td>
                            <td class="fw-bold"><%= t.getNama() %></td>
                            <td><span class="badge bg-info text-dark"><%= t.getJabatan() %></span></td>
                            <td>
                                <button class="btn btn-sm btn-primary" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#editTeamModal<%= t.getId() %>">
                                    <i class="fas fa-edit me-1"></i> Edit
                                </button>
                                <a href="../TeamServlet?action=delete&id=<%= t.getId() %>" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Hapus anggota ini?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <div class="modal fade" id="editTeamModal<%= t.getId() %>" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Anggota Tim</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="../TeamServlet" method="POST" enctype="multipart/form-data">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%= t.getId() %>">
                                        <div class="modal-body text-center">
                                            <img src="../<%= t.getFoto() %>" class="img-thumbnail rounded-circle mb-3" 
                                                 style="width: 120px; height: 120px; object-fit: cover;"
                                                 onerror="this.src='https:
                                            <div class="form-floating mb-3 text-start">
                                                <input type="text" name="nama" class="form-control" id="nama<%= t.getId() %>" value="<%= t.getNama() %>" required>
                                                <label for="nama<%= t.getId() %>">Nama Lengkap</label>
                                            </div>
                                            <div class="form-floating mb-3 text-start">
                                                <input type="text" name="jabatan" class="form-control" id="jabatan<%= t.getId() %>" value="<%= t.getJabatan() %>" required>
                                                <label for="jabatan<%= t.getId() %>">Jabatan (Misal: Ketua, Designer)</label>
                                            </div>
                                            <div class="mb-3 text-start">
                                                <label class="form-label small text-muted">Ganti Foto (Opsional)</label>
                                                <input type="file" name="foto" class="form-control" accept="image/*">
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
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addTeamModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Anggota Tim</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="../TeamServlet" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="form-floating mb-3">
                        <input type="text" name="nama" class="form-control" id="namaBaru" required>
                        <label for="namaBaru">Nama Lengkap</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="jabatan" class="form-control" id="jabatanBaru" required>
                        <label for="jabatanBaru">Jabatan</label>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small text-muted">Foto Profil</label>
                        <input type="file" name="foto" class="form-control" accept="image/*" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-success">Simpan</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https:
</body>
</html>