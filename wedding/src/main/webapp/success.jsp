<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Booking Berhasil! | Amba Organizer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="assets/css/style.css"> 
</head>

<body class="success-page">

    <div class="card card-success bg-white">
        <div class="icon-box-success">
            <span>✓</span>
        </div>
        
        <h2>Yeay! Booking Berhasil</h2>
        
        <% 
            String kode = request.getParameter("kode");
            if (kode != null) {
        %>
        <div class="alert alert-success mt-3">
            <p class="mb-0">Kode Booking Kamu:</p>
            <h1 class="display-4 fw-bold"><%= kode %></h1>
            <small class="text-danger">*Simpan kode ini untuk cek status pesanan!</small>
        </div>
        <% } %>

        <p class="text-muted mt-3">
            Terima kasih sudah mempercayakan momen bahagiamu kepada kami.
            Tim kami akan segera menghubungi nomor WhatsApp kamu untuk konfirmasi selanjutnya.
        </p>
        
        <div class="mt-4">
            <a href="index.jsp" class="btn btn-home text-decoration-none">Kembali ke Beranda</a>
        </div>
    </div>

</body>
</html>