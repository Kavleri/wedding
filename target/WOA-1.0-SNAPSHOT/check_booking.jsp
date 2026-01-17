<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Cek Pesanan | Amba Organizer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #fff0f3 0%, #fff 100%);
            min-height: 100vh;
        }
        .card-check {
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(183, 110, 121, 0.15);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            transition: transform 0.3s ease;
        }
        .card-check:hover {
            transform: translateY(-5px);
        }
        .form-control-lg {
            border: 2px solid #eee;
            border-radius: 12px;
            padding: 1rem;
            font-size: 1.2rem;
            letter-spacing: 2px;
            font-weight: 600;
            color: #b76e79;
        }
        .form-control-lg:focus {
            border-color: #b76e79;
            box-shadow: 0 0 0 0.25rem rgba(183, 110, 121, 0.1);
        }
        .btn-lacak {
            background-color: #b76e79 !important;
            color: #ffffff !important;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: block;
            width: 100%;
        }
        .btn-lacak:hover {
            background: #a05a65 !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(183, 110, 121, 0.3);
        }
        .icon-header {
            width: 80px;
            height: 80px;
            background: #fff0f3;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: #b76e79;
            font-size: 2rem;
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="components/navbar.jsp" />
    <div class="container mt-5 pt-5">
        <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
            <div class="col-md-6 col-lg-5">
                <div class="card card-check border-0">
                    <div class="card-body p-5 text-center">
                        <div class="icon-header mb-4">
                            <i class="bi bi-search-heart"></i>
                        </div>
                        <h2 class="fw-bold mb-2" style="color: #4a4a4a;">Lacak Pesanan</h2>
                        <p class="text-muted mb-4">Masukkan kode unik booking Anda untuk melihat status terkini.</p>
                        <% 
                            String error = request.getParameter("error");
                            if ("notfound".equals(error)) {
                        %>
                            <div class="alert alert-danger rounded-3 shadow-sm border-0 d-flex align-items-center justify-content-center">
                                <i class="bi bi-exclamation-circle-fill me-2"></i> Kode tidak ditemukan
                            </div>
                        <% } else if ("empty".equals(error)) { %>
                            <div class="alert alert-warning rounded-3 shadow-sm border-0 d-flex align-items-center justify-content-center">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i> Harap masukkan kode
                            </div>
                        <% } %>
                        <form action="CheckBookingServlet" method="POST" class="mt-4">
                            <div class="mb-4">
                                <input type="text" name="kode_booking" 
                                       class="form-control form-control-lg text-center text-uppercase" 
                                       placeholder="WED-XXXXX" 
                                       required autocomplete="off">
                            </div>
                            <button type="submit" class="btn btn-lacak py-3 mb-3">
                                <i class="bi bi-search me-2"></i> Cek Status Sekarang
                            </button>
                        </form>
                        <div class="mt-4 pt-3 border-top">
                            <a href="index.jsp" class="text-decoration-none fw-bold" style="color: #b76e79; transition: 0.3s;">
                                <i class="bi bi-arrow-left me-1"></i> Kembali ke Beranda
                            </a>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-4 text-muted small">
                    <p>Butuh bantuan? <a href="contact.jsp" style="color: #b76e79;">Hubungi Customer Service</a></p>
                </div>
            </div>
        </div>
    </div>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>