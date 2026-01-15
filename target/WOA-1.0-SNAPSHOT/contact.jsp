<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Contact Us | Wedding Amba Organizer</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https:
        <link href="https:
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=5">
        <style>
            .btn-wedding {
                background-color: #b76e79 !important;
                border-color: #b76e79 !important;
                color: white !important;
                transition: 0.3s;
            }
            .btn-wedding:hover {
                background-color: #a05a65 !important;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body> 
        <jsp:include page="components/navbar.jsp" />
        <div class="container" style="margin-top: 120px; margin-bottom: 80px;">
            <div class="row justify-content-center">
                <div class="col-lg-10"> 
                    <div class="card overflow-hidden">
                        <div class="row g-0"> 
                            <div class="col-md-5 text-white p-5 d-flex flex-column justify-content-center" 
                                 style="background: linear-gradient(rgba(122, 63, 71, 0.9), rgba(122, 63, 71, 0.9)), url('assets/img/wedding2.jpg'); background-size: cover; background-position: center;">
                                <h3 class="fw-bold mb-4">Contact Info</h3>
                                <p class="mb-5 text-white-50">Hubungi kami untuk konsultasi pernikahan impianmu. Kami siap membantu 24/7.</p>
                                <div class="d-flex align-items-start mb-4">
                                    <div class="me-3 fs-4">📍</div> 
                                    <div>
                                        <h6 class="fw-bold mb-1">Alamat</h6>
                                        <span class="small opacity-75">Jl. Margonda Raya No. 12, Depok</span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-start mb-4">
                                    <div class="me-3 fs-4">📞</div> 
                                    <div>
                                        <h6 class="fw-bold mb-1">Telepon / WA</h6>
                                        <span class="small opacity-75">+62 812-3456-7890</span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-start">
                                    <div class="me-3 fs-4">✉️</div> 
                                    <div>
                                        <h6 class="fw-bold mb-1">Email</h6>
                                        <span class="small opacity-75">halo@ambaorganizer.com</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7 p-5 bg-white">
                                <h3 class="fw-bold mb-4" style="color: #7a3f47;">Kirim Pesan</h3>
                                <% 
                                    String msg = request.getParameter("msg");
                                    if("sent".equals(msg)) {
                                %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="bi bi-check-circle me-2"></i> Pesan Anda berhasil dikirim! Tim kami akan segera menghubungi Anda.
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <% } else if("failed".equals(msg)) { %>
                                <div class="alert alert-danger">Gagal mengirim pesan. Silakan coba lagi.</div>
                                <% } %>
                                <form action="ContactServlet" method="POST">
                                    <input type="hidden" name="action" value="send">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <input type="text" class="form-control" id="name" name="name" placeholder="Nama Anda" required>
                                                <label for="name">Nama Lengkap</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <input type="email" class="form-control" id="email" name="email" placeholder="Email Anda" required>
                                                <label for="email">Alamat Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating">
                                                <input type="text" class="form-control" id="subject" name="subject" placeholder="Subjek" required>
                                                <label for="subject">Subjek</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating">
                                                <textarea class="form-control" placeholder="Tulis pesan Anda disini" id="message" name="message" style="height: 150px" required></textarea>
                                                <label for="message">Pesan</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <button class="btn btn-wedding w-100 py-3 fw-bold" type="submit">
                                                <i class="bi bi-send me-2"></i> Kirim Pesan
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https:
    </body>
</html>