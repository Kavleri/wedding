<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="model.TeamModel"%>
<%@page import="dao.TeamDAO"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Wedding Amba Organizer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .team-card {
            border: none;
            transition: 0.3s;
            text-align: center;
        }
        .team-card:hover { transform: translateY(-10px); }
        .team-img {
            width: 150px; height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />
    <section class="py-5 bg-light">
        <div class="container py-5">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h6 class="text-uppercase fw-bold" style="color: var(--pink-main);">Tentang Kami</h6>
                    <h1 class="display-4 fw-bold mb-4">Mewujudkan Pernikahan <span style="color: var(--pink-main);">Impian Anda</span></h1>
                    <p class="lead text-muted mb-4">Wedding Amba Organizer hadir untuk membantu setiap pasangan merencanakan hari bahagia mereka dengan sempurna, tanpa stres, dan penuh kenangan indah.</p>
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill fs-4 me-3" style="color: var(--pink-main);"></i>
                                <span>Profesional & Berpengalaman</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill fs-4 me-3" style="color: var(--pink-main);"></i>
                                <span>Harga Transparan</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill fs-4 me-3" style="color: var(--pink-main);"></i>
                                <span>Mitra Vendor Terpercaya</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill fs-4 me-3" style="color: var(--pink-main);"></i>
                                <span>Layanan 24/7</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <img src="assets/img/amba.png" class="img-fluid rounded-4 shadow-lg" alt="About Us">
                </div>
            </div>
        </div>
    </section>
    <section class="py-5">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h6 class="text-uppercase fw-bold" style="color: var(--pink-main);">Tim AMBxORG</h6>
            </div>
            <div class="row justify-content-center g-4">
                <%
                    TeamDAO teamDAO = new TeamDAO();
                    List<TeamModel> teamList = teamDAO.getAllTeamMembers();
                    if (teamList != null) {
                        for(TeamModel t : teamList) {
                %>
                <div class="col-md-2 col-6">
                    <div class="team-card">
                        <img src="<%= t.getFoto() %>" class="team-img" alt="<%= t.getNama() %>" 
                             onerror="this.src='https://ui-avatars.com/api/?name=<%= t.getNama().replace(" ", "+") %>'">
                        <h5 class="fw-bold mb-1" style="font-size: 1rem;"><%= t.getNama() %></h5>
                        <p class="text-muted small mb-0"><%= t.getJabatan() %></p>
                    </div>
                </div>
                <% 
                        }
                    }
                %>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>