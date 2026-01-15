<%@page import="java.util.List"%>
<%@page import="dao.BookingDAO"%>
<%@page import="model.BookingModel"%>
<%@page import="model.AdminModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("adminLog") == null){
        response.sendRedirect("../login.jsp"); 
        return; 
    }
    AdminModel admin = (AdminModel) session.getAttribute("adminLog");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin | Amba Organizer</title>
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
                <a href="orders.jsp" class="nav-link active">
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
    <div class="content w-100">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Dashboard Overview</h2>
            <div class="d-flex align-items-center">
                <div class="text-end me-3">
                    <div class="fw-bold"><%= admin.getNama() %></div>
                    <small class="text-muted"><%= (admin.getRole() != null) ? admin.getRole() : "Super Admin" %></small>
                </div>
                <div class="bg-secondary rounded-circle" style="width: 40px; height: 40px; background-image: url('https:
            </div>
        </div>
        <div class="card card-stat p-4">
            <h5 class="mb-4">Data Pesanan Masuk (CRUD Read)</h5>
            <div class="table-responsive">
                <table class="table table-hover table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Kode Booking</th>
                            <th>Nama Pemesan</th>
                            <th>No HP</th>
                            <th>Paket ID</th>
                            <th>Tanggal Acara</th>
                            <th>Status</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            BookingDAO dao = new BookingDAO();
                            List<BookingModel> listBooking = dao.getAllBookings();
                            int no = 1;
                            if (listBooking != null && !listBooking.isEmpty()) {
                                for(BookingModel b : listBooking) {
                        %>
                        <tr>
                            <td><span class="badge bg-primary"><%= b.getKodeBooking() %></span></td>
                            <td><%= b.getNamaPemesan() %></td>
                            <td><%= b.getNoHp() %></td>
                            <td><%= b.getPaketId() %></td>
                            <td><%= b.getTanggalAcara() %></td>
                            <td>
                                <% 
                                    String st = b.getStatus();
                                    String badgeClass = "bg-secondary";
                                    if("Confirmed".equals(st)) badgeClass = "bg-success";
                                    else if("Cancelled".equals(st)) badgeClass = "bg-danger";
                                    else if("Pending".equals(st)) badgeClass = "bg-warning text-dark";
                                %>
                                <span class="badge <%= badgeClass %>"><%= (st != null) ? st : "Pending" %></span>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <% if(!"Confirmed".equals(st)) { %>
                                    <a href="../UpdateStatusServlet?id=<%= b.getId() %>&status=Confirmed" class="btn btn-sm btn-success" title="Terima">
                                        <i class="fas fa-check"></i>
                                    </a>
                                    <% } %>
                                    <% if(!"Cancelled".equals(st)) { %>
                                    <a href="../UpdateStatusServlet?id=<%= b.getId() %>&status=Cancelled" class="btn btn-sm btn-danger" title="Tolak" onclick="return confirm('Yakin mau tolak pesanan ini?')">
                                        <i class="fas fa-times"></i>
                                    </a>
                                    <% } %>
                                    <% 
                                    if(role != null && "admin".equalsIgnoreCase(role)) { 
                                    %>
                                    <a href="../DeleteServlet?id=<%= b.getId() %>" class="btn btn-sm btn-outline-danger" title="Hapus Permanen" onclick="return confirm('Hapus data selamanya?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% 
                                } 
                            } else { 
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-muted p-4">
                                <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                                Belum ada pesanan masuk.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>