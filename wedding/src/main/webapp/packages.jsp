<%@page import="java.util.List"%>
<%@page import="model.PackageModel"%>
<%@page import="dao.PackageDAO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Wedding Packages | Amba Organizer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <style>
        /* Style Tambahan Khusus Halaman Ini */
        body {
            background-color: #fff5f7; /* Background Pink Soft */
            font-family: 'Poppins', sans-serif;
        }
        .card-package {
            transition: all 0.3s ease;
            border: none;
            overflow: hidden;
            background: #fff;
            border-radius: 15px;
        }
        .card-package:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(183, 110, 121, 0.2);
        }
        .text-pink-dark {
            color: #7a3f47;
        }
        .text-pink-main {
            color: #b76e79;
        }
        /* Biar gambar ukurannya konsisten */
        .card-img-top {
            height: 250px; 
            object-fit: cover;
        }
    </style>
</head>

<body>

   <jsp:include page="components/navbar.jsp" />

    <div class="container" style="margin-top: 100px; margin-bottom: 80px;">
        
        <div class="text-center mb-5">
            <h2 class="fw-bold text-pink-dark">Pilih Paket Pernikahanmu</h2>
            <p class="text-muted">Wujudkan pernikahan impian dengan harga terbaik dari Database</p>
        </div>

        <div class="row g-4">
            <%
                // 1. Panggil DAO buat ambil data dari PostgreSQL
                PackageDAO dao = new PackageDAO();
                List<PackageModel> listPaket = dao.getAllPackages();
                
                // 2. Cek data kosong atau ada
                if(listPaket.isEmpty()) {
            %>
                <div class="col-12 text-center">
                    <div class="alert alert-danger">
                        Database masih kosong, Boss! Isi dulu di pgAdmin.
                    </div>
                </div>
            <%
                } else {
                    // 3. LOOPING KARTU (Biar otomatis nambah kalau data nambah)
                    for(PackageModel p : listPaket) {
            %>

            <div class="col-md-4">
                <div class="card card-package h-100 shadow-sm">
                    
                    <img src="<%= p.getGambar() %>" class="card-img-top" alt="<%= p.getNamaPaket() %>" 
                         onerror="this.src='assets/img/wedding4.jpg'">
                    
                    <div class="card-body text-center p-4">
                        
                        <% if(p.getNamaPaket().toLowerCase().contains("gold")) { %>
                        <div class="mb-2">
                            <span class="badge bg-danger rounded-pill px-3">BEST SELLER</span>
                        </div>
                        <% } %>
                        
                        <h5 class="fw-bold text-pink-main"><%= p.getNamaPaket() %></h5>
                        
                        <p class="text-muted small"><%= p.getDeskripsi() %></p>
                        
                        <hr>
                        
                        <div class="text-start small mb-4 ms-2 text-muted">
                           <p>✨ Include fasilitas lengkap sesuai deskripsi paket.</p>
                           </div>

                        <h3 class="fw-bold text-dark mb-3">
                            Rp <%= String.format("%,.0f", p.getHarga()) %>
                        </h3>
                        
                        <a href="booking.jsp?id=<%= p.getId() %>" class="btn btn-outline-danger w-100 rounded-pill">
                            Pilih Paket
                        </a>
                        
                    </div>
                </div>
            </div>
            <% 
                    } // Tutup Kurung For Loop
                } // Tutup Else
            %>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>