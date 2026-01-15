<%@page import="model.PackageModel"%>
<%@page import="model.BookingModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Detail Pesanan #<%= ((BookingModel)request.getAttribute("booking")).getKodeBooking() %> | Amba Organizer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https:
    <link rel="stylesheet" href="https:
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .invoice-header { background: #f8f9fa; border-bottom: 2px solid #eee; }
        .status-badge { font-size: 0.9rem; padding: 0.5em 1em; }
        @media print {
            @page { size: A4; margin: 15mm; }
            .navbar, .d-print-none, .btn, footer, .card-footer, .alert {
                display: none !important;
            }
            body, .container, .row, .col-lg-9 {
                width: 100% !important;
                max-width: 100% !important;
                margin: 0 !important;
                padding: 0 !important;
                background-color: white !important;
                font-size: 14px; 
                font-family: 'Times New Roman', serif; 
            }
            .card {
                border: 2px solid #000 !important;
                box-shadow: none !important;
                break-inside: avoid;
                margin-top: 20px;
            }
            .invoice-header {
                background-color: white !important;
                color: black !important;
                border-bottom: 2px solid black !important;
                padding: 20px !important;
            }
            h2 { font-size: 28px !important; margin-bottom: 5px; }
            h4 { font-size: 20px !important; }
            h5 { font-size: 18px !important; font-weight: bold; }
            .img-fluid { 
                display: block !important; 
                max-width: 120px !important;
                border: 1px solid #ccc;
            }
            .bg-light { background-color: white !important; border: 1px solid #000; padding: 15px !important; }
            .print-kop {
                display: block !important;
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 4px double black;
                padding-bottom: 15px;
            }
            .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 11px;
                color: #000;
                display: block !important;
                border-top: 1px solid #000;
                padding-top: 5px;
            }
            .col-md-6 { width: 50% !important; float: left; }
            .col-md-3 { width: 25% !important; float: left; }
        }
        .print-kop, .print-footer { display: none; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="components/navbar.jsp" />
    <div class="container mt-5 pt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="print-kop">
                    <h2 class="fw-bold text-uppercase">Wedding Amba Organizer</h2>
                    <p class="mb-0">Jl. Cinta Sejati No. 1, Jakarta Selatan | Telp: 0812-3456-7890</p>
                    <small>www.amba-organizer.com | info@amba.com</small>
                </div>
                <%
                    BookingModel b = (BookingModel) request.getAttribute("booking");
                    PackageModel p = (PackageModel) request.getAttribute("paket");
                    if (b != null) {
                %>
                <div class="mb-3 d-print-none">
                    <a href="check_booking.jsp" class="text-decoration-none text-muted">
                        <i class="fas fa-arrow-left me-1"></i> Kembali ke Pencarian
                    </a>
                </div>
                <div class="card shadow-lg border-0 overflow-hidden">
                    <div class="card-header invoice-header p-4">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h5 class="text-muted mb-0">Kode Booking:</h5>
                                <h2 class="fw-bold text-primary mb-0"><%= b.getKodeBooking() %></h2>
                            </div>
                            <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                <% 
                                    String st = b.getStatus();
                                    String badgeClass = "bg-warning text-dark";
                                    String icon = "fa-clock";
                                    String text = "Menunggu Konfirmasi";
                                    if("Confirmed".equals(st)) {
                                        badgeClass = "bg-success";
                                        icon = "fa-check-circle";
                                        text = "Pesanan Diterima";
                                    } else if("Cancelled".equals(st)) {
                                        badgeClass = "bg-danger";
                                        icon = "fa-times-circle";
                                        text = "Pesanan Dibatalkan";
                                    }
                                %>
                                <span class="badge <%= badgeClass %> status-badge border">
                                    <i class="fas <%= icon %> me-1"></i> <%= text %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3">
                                <h6 class="text-uppercase text-muted fw-bold small">Data Pemesan</h6>
                                <h5 class="mb-1"><%= b.getNamaPemesan() %></h5>
                                <p class="mb-1"><i class="fas fa-phone-alt text-muted me-2"></i><%= b.getNoHp() %></p>
                                <p class="mb-0"><i class="fas fa-map-marker-alt text-muted me-2"></i><%= b.getAlamat() %></p>
                            </div>
                            <div class="col-md-6 text-md-end mb-3">
                                <h6 class="text-uppercase text-muted fw-bold small">Jadwal Acara</h6>
                                <h5 class="mb-1"><%= b.getTanggalAcara() %></h5>
                                <p class="small text-muted">Pastikan tanggal sudah benar</p>
                            </div>
                        </div>
                        <div class="card bg-light border-0 mb-4">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-md-3 mb-3 mb-md-0">
                                        <img src="<%= p.getGambar() %>" class="img-fluid rounded shadow-sm" alt="Paket Wedding">
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted mb-1">Paket Pilihan</h6>
                                        <h4 class="mb-2"><%= p.getNamaPaket() %></h4>
                                        <p class="text-muted small mb-0"><%= p.getDeskripsi() %></p>
                                    </div>
                                    <div class="col-md-3 text-md-end mt-3 mt-md-0">
                                        <small class="text-muted">Total Estimasi</small>
                                        <h4 class="text-primary fw-bold">Rp <%= String.format("%,.0f", p.getHarga()) %></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="border rounded p-3 bg-white">
                                    <h6 class="fw-bold"><i class="fas fa-wallet me-2 text-success"></i>Instruksi Pembayaran DP</h6>
                                    <hr class="my-2">
                                    <p class="mb-2 small text-muted">Silakan transfer DP sebesar <strong>30%</strong> ke rekening berikut untuk mengunci tanggal:</p>
                                    <div class="d-flex align-items-center bg-light p-2 rounded">
                                        <img src="https:
                                        <div>
                                            <p class="mb-0 fw-bold">8830-1234-5678</p>
                                            <p class="mb-0 small text-muted">a.n. Amba Organizer Official</p>
                                        </div>
                                    </div>
                                    <p class="mt-2 mb-0 small text-danger fst-italic">*Harap konfirmasi ke Admin via WhatsApp setelah transfer.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-white p-4 border-top">
                        <div class="row align-items-center">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <small class="text-muted">Butuh bantuan? <a href="contact.jsp">Hubungi Kami</a></small>
                            </div>
                            <div class="col-md-6 text-md-end d-print-none">
                                <button onclick="window.print()" class="btn btn-outline-secondary me-2">
                                    <i class="fas fa-print me-1"></i> Cetak Invoice
                                </button>
                                <a href="https:
                                    <i class="fab fa-whatsapp me-1"></i> Konfirmasi WA
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                    <div class="alert alert-danger text-center shadow-sm">
                        <h4>Data Tidak Ditemukan</h4>
                        <p>Maaf, kode booking tersebut tidak terdaftar di sistem kami.</p>
                        <a href="check_booking.jsp" class="btn btn-primary mt-2">Cari Lagi</a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    <script src="https:
    <div class="print-footer">
        Dicetak pada: <span id="printDate"></span> | Amba Organizer System
    </div>
    <script>document.getElementById('printDate').innerText = new Date().toLocaleString();</script>
</body>
</html>