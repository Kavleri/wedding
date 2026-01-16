<%@page import="java.util.List"%>
<%@page import="model.AdminModel"%>
<%@page import="dao.AdminDAO"%>
<%@page import="dao.DashboardDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Cek Login
    if(session.getAttribute("adminLog") == null){
        response.sendRedirect("../login.jsp");
        return; 
    }
    AdminModel admin = (AdminModel) session.getAttribute("adminLog");
    DashboardDAO dashDAO = new DashboardDAO();
    int totalPesanan = dashDAO.getTotalPesanan();
    int pesananPending = dashDAO.getPesananPending();
    double totalPendapatan = dashDAO.getTotalPendapatan();
    int totalStaff = dashDAO.getTotalStaff();
    AdminDAO adminDAO = new AdminDAO();
    List<AdminModel> listStaff = adminDAO.getAllAdmins();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Statistik | Amba Admin</title>
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
        .card-stat { 
            border: none; 
            border-radius: 15px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: 0.3s;
        }
        .card-stat:hover { transform: translateY(-5px); }
        .icon-box {
            width: 50px; height: 50px;
            display: flex; align-items: center; justify-content: center;
            border-radius: 12px; font-size: 24px;
        }
        .staff-avatar {
            width: 40px; height: 40px;
            border-radius: 50%;
            object-fit: cover;
            background-color: #ddd;
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
                <a href="dashboard.jsp" class="nav-link active">
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
            <div>
                <h2 class="fw-bold mb-0">Overview Statistik</h2>
                <p class="text-muted">Selamat datang kembali, <%= admin.getNama() %>!</p>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-end me-3">
                    <div class="fw-bold"><%= admin.getNama() %></div>
                    <small class="text-muted"><%= (admin.getRole() != null) ? admin.getRole() : "Super Admin" %></small>
                </div>
                <div class="bg-secondary rounded-circle" style="width: 40px; height: 40px; background-image: url('https:
            </div>
        </div>
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="card card-stat p-3 h-100">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1 small text-uppercase fw-bold">Estimasi Pendapatan</p>
                            <h4 class="fw-bold text-success mb-0">Rp <%= String.format("%,.0f", totalPendapatan) %></h4>
                        </div>
                        <div class="icon-box bg-success bg-opacity-10 text-success">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat p-3 h-100">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1 small text-uppercase fw-bold">Total Pesanan</p>
                            <h4 class="fw-bold text-primary mb-0"><%= totalPesanan %></h4>
                        </div>
                        <div class="icon-box bg-primary bg-opacity-10 text-primary">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat p-3 h-100 border-start border-4 border-warning">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1 small text-uppercase fw-bold">Perlu Konfirmasi</p>
                            <h4 class="fw-bold text-warning mb-0"><%= pesananPending %></h4>
                        </div>
                        <div class="icon-box bg-warning bg-opacity-10 text-warning">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat p-3 h-100">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1 small text-uppercase fw-bold">Tim Aktif</p>
                            <h4 class="fw-bold text-info mb-0"><%= totalStaff %></h4>
                        </div>
                        <div class="icon-box bg-info bg-opacity-10 text-info">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card card-stat p-4">
            <h5 class="fw-bold mb-4"><i class="fas fa-id-card-alt me-2 text-secondary"></i> Tim Amba Organizer</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Pegawai</th>
                            <th>Email</th>
                            <th>Role / Jabatan</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if(listStaff != null) {
                                for(AdminModel a : listStaff) {
                                    boolean isMe = (a.getId() == admin.getId());
                        %>
                        <tr class="<%= isMe ? "table-active" : "" %>">
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="https:
                                    <div>
                                        <div class="fw-bold"><%= a.getNama() %> <%= isMe ? "(Anda)" : "" %></div>
                                        <small class="text-muted">ID: #<%= a.getId() %></small>
                                    </div>
                                </div>
                            </td>
                            <td><%= a.getEmail() %></td>
                            <td>
                                <% if(a.getRole() == null || "admin".equalsIgnoreCase(a.getRole())) { %>
                                    <span class="badge bg-primary">Administrator</span>
                                <% } else { %>
                                    <span class="badge bg-secondary">Staff</span>
                                <% } %>
                            </td>
                            <td>
                                <span class="badge bg-success bg-opacity-10 text-success">
                                    <i class="fas fa-circle fa-xs me-1"></i> Aktif
                                </span>
                            </td>
                        </tr>
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
<script src="https:
</body>
</html>