<%@page import="java.util.List"%>
<%@page import="dao.AdminDAO"%>
<%@page import="model.AdminModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("adminLog") == null){
        response.sendRedirect("../login.jsp");
        return; 
    }
    AdminModel currentAdmin = (AdminModel) session.getAttribute("adminLog");
    String userRole = currentAdmin.getRole();
    if(userRole != null && !"admin".equals(userRole)) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Kelola Staff | Amba Organizer</title>
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
            <%= (currentAdmin.getRole() != null && "admin".equalsIgnoreCase(currentAdmin.getRole())) ? "Amba Admin" : "Amba Staff" %>
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
                <a href="staff.jsp" class="nav-link active">
                    <i class="fas fa-users-cog me-2"></i> Kelola Staff
                </a>
            </li>
            <li class="nav-item mt-5">
                <a href="../LogoutServlet" class="nav-link bg-danger text-white rounded">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>
    <div class="content w-100">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Manajemen Staff Internal</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addStaffModal">
                <i class="fas fa-plus me-2"></i> Tambah Pegawai
            </button>
        </div>
        <% 
            String msg = request.getParameter("msg");
            if("added".equals(msg)) { %> <div class="alert alert-success">Staff berhasil ditambahkan!</div> <% }
            else if("deleted".equals(msg)) { %> <div class="alert alert-success">Staff berhasil dihapus!</div> <% }
            else if("failed".equals(msg)) { %> <div class="alert alert-danger">Gagal memproses data!</div> <% }
        %>
        <div class="card card-stat p-4">
            <h5 class="mb-4">Daftar Akun Pegawai</h5>
            <div class="table-responsive">
                <table class="table table-hover table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>No</th>
                            <th>Nama Lengkap</th>
                            <th>Email Login</th>
                            <th>Role</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            AdminDAO dao = new AdminDAO();
                            List<AdminModel> listStaff = dao.getAllAdmins();
                            int no = 1;
                            if (listStaff != null && !listStaff.isEmpty()) {
                                for(AdminModel a : listStaff) {
                                    boolean isMe = (a.getId() == currentAdmin.getId());
                        %>
                        <tr>
                            <td><%= no++ %></td>
                            <td>
                                <%= a.getNama() %> 
                                <% if(isMe) { %> <span class="badge bg-info">Anda</span> <% } %>
                            </td>
                            <td><%= a.getEmail() %></td>
                            <td>
                                <% if("admin".equals(a.getRole())) { %>
                                    <span class="badge bg-primary">Administrator</span>
                                <% } else { %>
                                    <span class="badge bg-secondary">Staff</span>
                                <% } %>
                            </td>
                            <td>
                                <% if(!isMe) { %>
                                <a href="../StaffServlet?action=delete&id=<%= a.getId() %>" 
                                   class="btn btn-sm btn-danger" 
                                   onclick="return confirm('Yakin mau pecat pegawai ini?')">
                                    <i class="fas fa-trash"></i> Hapus
                                </a>
                                <% } else { %>
                                <button class="btn btn-sm btn-secondary" disabled>Hapus</button>
                                <% } %>
                            </td>
                        </tr>
                        <% 
                                } 
                            } else { 
                        %>
                        <tr><td colspan="5" class="text-center">Belum ada data staff.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addStaffModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Pegawai Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="../StaffServlet" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Nama Lengkap</label>
                        <input type="text" name="nama" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Email Login</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Password Awal</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Role / Jabatan</label>
                        <select name="role" class="form-select">
                            <option value="staff">Staff (Terbatas)</option>
                            <option value="admin">Admin (Akses Penuh)</option>
                        </select>
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