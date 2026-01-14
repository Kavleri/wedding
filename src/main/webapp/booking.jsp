<%@page import="model.PackageModel"%>
<%@page import="dao.PackageDAO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Booking Paket | Amba Organizer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #fff5f7; font-family: 'Poppins', sans-serif; }
        .card-booking { border: none; border-radius: 15px; box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
        .bg-pink-main { background-color: #b76e79; color: white; }
        .text-pink-main { color: #b76e79; }
        .form-control:focus { border-color: #b76e79; box-shadow: 0 0 0 0.25rem rgba(183, 110, 121, 0.25); }
    </style>
</head>
<body>

    <jsp:include page="components/navbar.jsp" />

    <div class="container" style="margin-top: 100px; margin-bottom: 50px;">
        <%
            String idParam = request.getParameter("id");
            PackageModel paket = null;

            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    PackageDAO dao = new PackageDAO();
                    paket = dao.getPackageById(id); 
                } catch (Exception e) {
                }
            }

            if (paket == null) {
        %>
            <div class="alert alert-danger text-center shadow-sm">
                <h3>🚫 Waduh! Paket tidak ditemukan.</h3>
                <p>Mungkin kamu salah klik atau paket sudah dihapus.</p>
                <a href="packages.jsp" class="btn btn-secondary mt-2">Kembali ke Daftar Paket</a>
            </div>
        <% } else { %>

        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card card-booking overflow-hidden">
                    <div class="row g-0">
                        
                        <div class="col-md-5 bg-pink-main p-5 text-center d-flex flex-column justify-content-center">
                            
                            <img src="<%= paket.getGambar() %>" class="img-fluid rounded-circle mb-3 border border-4 border-white shadow" 
                                 style="width: 150px; height: 150px; object-fit: cover; margin: 0 auto;">
                            
                            <h3 class="fw-bold"><%= paket.getNamaPaket() %></h3>
                            <h2 class="fw-bold mt-2 text-warning">Rp <%= String.format("%,.0f", paket.getHarga()) %></h2>
                            
                            <p class="mt-3 small opacity-75 text-white">
                                <%= paket.getDeskripsi() %>
                            </p>
                            
                            <hr class="border-white opacity-50">
                            <small class="text-white-50">Silakan lengkapi data diri di samping untuk melanjutkan pemesanan.</small>
                        </div>

                        <div class="col-md-7 p-5 bg-white">
                            <h4 class="fw-bold text-pink-main mb-4">📝 Form Pemesanan</h4>
                            
                            <form action="ProcessBookingServlet" method="POST">
                                
                                <input type="hidden" name="paket_id" value="<%= paket.getId() %>">
                                
                                <div class="mb-3">
                                    <label class="form-label text-muted small">Nama Pemesan / Pasangan</label>
                                    <input type="text" name="nama_pemesan" class="form-control form-control-lg" placeholder="Contoh: Romeo & Juliet" required>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label text-muted small">No. WhatsApp</label>
                                        <input type="number" name="no_hp" class="form-control" placeholder="0812xxxx" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label text-muted small">Tanggal Rencana</label>
                                        <input type="date" name="tanggal_acara" class="form-control" required>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label text-muted small">Alamat / Lokasi Resepsi</label>
                                    <textarea name="alamat" class="form-control" rows="3" placeholder="Alamat gedung atau rumah..." required></textarea>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-danger btn-lg" style="background-color: #b76e79; border: none;">
                                        Konfirmasi Booking ✅
                                    </button>
                                    <a href="packages.jsp" class="btn btn-outline-secondary">Batal</a>
                                </div>
                            </form>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>

        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>