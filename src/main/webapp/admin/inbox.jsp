<%@page import="java.util.List"%>
<%@page import="model.ContactModel"%>
<%@page import="dao.ContactDAO"%>
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
    <title>Inbox Pesan | Amba Admin</title>
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
        .message-card { transition: 0.3s; cursor: pointer; }
        .message-card:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
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
                <a href="inbox.jsp" class="nav-link active">
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
        <h2 class="mb-4">Kotak Masuk Pesan</h2>
        <% 
            String msg = request.getParameter("msg");
            if("deleted".equals(msg)) { %> <div class="alert alert-success">Pesan berhasil dihapus!</div> <% }
        %>
        <div class="row">
            <%
                ContactDAO dao = new ContactDAO();
                List<ContactModel> listPesan = dao.getAllMessages();
                if(listPesan != null && !listPesan.isEmpty()) {
                    for(ContactModel c : listPesan) {
            %>
            <div class="col-md-6 mb-3">
                <div class="card message-card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <h5 class="card-title fw-bold text-primary"><%= c.getSubjek() %></h5>
                            <small class="text-muted"><%= c.getCreatedAt() %></small>
                        </div>
                        <h6 class="card-subtitle mb-3 text-muted">
                            <i class="fas fa-user me-1"></i> <%= c.getNama() %> 
                            (<a href="mailto:<%= c.getEmail() %>"><%= c.getEmail() %></a>)
                        </h6>
                        <p class="card-text bg-light p-3 rounded"><%= c.getPesan() %></p>
                        <div class="text-end">
                            <a href="mailto:<%= c.getEmail() %>?subject=Re: <%= c.getSubjek() %>" class="btn btn-sm btn-primary">
                                <i class="fas fa-reply me-1"></i> Balas
                            </a>
                            <a href="../ContactServlet?action=delete&id=<%= c.getId() %>" 
                               class="btn btn-sm btn-outline-danger" 
                               onclick="return confirm('Hapus pesan ini?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                    }
                } else { 
            %>
            <div class="col-12 text-center py-5 text-muted">
                <i class="fas fa-inbox fa-3x mb-3"></i>
                <p>Belum ada pesan masuk.</p>
            </div>
            <% } %>
        </div>
    </div>
</div>
<script src="https:
</body>
</html>