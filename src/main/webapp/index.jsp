<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Wedding Amba Organizer</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        <style>
            .hero{
                height: 100vh;
                background: linear-gradient(rgba(0,0,0,.45),rgba(0,0,0,.45)),
                    url('assets/img/heading.jpg') center/cover no-repeat;
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                margin-top: -80px; 
                padding-top: 80px;
                margin-bottom: 0;
            }
            .navbar-wedding {
                background-color: var(--pink-main);
                padding-top: 15px;
                padding-bottom: 15px;
                transition: 0.3s;
            }
            .cta-wedding{
                min-height:55vh;
                background:linear-gradient(
                    rgba(232,180,184,.9),
                    rgba(214,164,148,.9)
                    ),url("assets/img/download3.jpg") center/cover no-repeat;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-wedding fixed-top">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#" style="font-family: 'Poppins', sans-serif; font-weight: 700; font-size: 1.25rem;">AMBxORG</a>
                <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="nav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="#hero">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="#packages">Packages</a></li>
                        <li class="nav-item"><a class="nav-link" href="#gallery">Gallery</a></li>
                        <li class="nav-item"><a class="nav-link" href="check_booking.jsp">Cek Pesanan</a></li>
                    </ul>
                    <a href="packages.jsp" class="btn btn-light ms-3">Book Now</a>
                </div>
            </div>
        </nav>
        <section id="hero" class="hero d-flex align-items-center text-center">
    <div class="container col-lg-8">
        <div class="mb-3">
            <span class="badge-wedding text-uppercase" style="letter-spacing: 2px; font-size: 0.9rem;">
                Wedding Amba Organizer
            </span>
        </div>
        <h1 class="display-3 fw-bold text-white mb-3">
            Your Dream Wedding <br> Starts Here
        </h1>
        <p class="lead text-white-50 fs-5 mb-0">
            Elegant and affordable wedding rental services. <br> 
            Wujudkan momen spesialmu bersama kami.
        </p>
    </div>
</section>
        <section id="about" class="py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h2>About Us</h2>
                        <p>Professional wedding organizer providing complete wedding solutions.</p>
                        <ul class="list-unstyled mt-3">
                            <li><i class="bi bi-check-circle-fill"></i> Elegant decoration</li>
                            <li><i class="bi bi-check-circle-fill"></i> Affordable packages</li>
                            <li><i class="bi bi-check-circle-fill"></i> Professional team</li>
                        </ul>
                    </div>
                    <div class="col-lg-6">
                        <img src="assets/img/about.jpg" class="img-fluid rounded shadow">
                    </div>
                </div>
            </div>
        </section>
      <section id="packages" class="py-5 bg-light"> <div class="container text-center">
        <div class="mb-5">
            <h2 class="fw-bold" style="color: var(--pink-dark);">Wedding Packages</h2>
        </div>
        <div class="row align-items-center"> <div class="col-md-4 mb-4">
                <div class="card p-4 border-0 shadow-sm">
                    <h4 class="fw-bold text-muted">Silver</h4>
                    <p class="text-muted small">Decoration + Catering</p>
                    <h3 class="my-3 fw-bold" style="color: var(--pink-main);">Rp 15.000.000</h3>
                    <a href="packages.jsp" class="btn btn-outline-wedding mt-2">View Detail</a>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card p-5 border-0 card-highlight bg-white">
                    <div class="mb-2">
                        <span class="badge bg-danger rounded-pill px-3">BEST SELLER</span>
                    </div>
                    <h3 class="fw-bold" style="color: var(--pink-dark);">Gold</h3>
                    <p class="text-muted">Decoration + Catering + Dress</p>
                    <h2 class="my-3 fw-bold" style="color: var(--pink-main);">Rp 25.000.000</h2>
                    <a href="packages.jsp" class="btn btn-wedding btn-lg mt-2 w-100">View Detail</a>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card p-4 border-0 shadow-sm">
                    <h4 class="fw-bold text-muted">Platinum</h4>
                    <p class="text-muted small">All-in Wedding Service</p>
                    <h3 class="my-3 fw-bold" style="color: var(--pink-main);">Rp 40.000.000</h3>
                    <a href="packages.jsp" class="btn btn-outline-wedding mt-2">View Detail</a>
                </div>
            </div>
        </div>
    </div>
</section>
        <section class="py-5">
            <div class="container">
                <h2 class="text-center mb-5 fw-bold" style="color: var(--pink-dark);">Why Choose Us</h2>
                <div class="row text-center">
                    <div class="col-md-4 icon-box">
                        <i class="bi bi-heart"></i>
                        <h5 class="mt-3">Elegant Design</h5>
                        <p>Modern and classy wedding themes.</p>
                    </div>
                    <div class="col-md-4 icon-box">
                        <i class="bi bi-wallet2"></i>
                        <h5 class="mt-3">Affordable Price</h5>
                        <p>Flexible packages for every budget.</p>
                    </div>
                    <div class="col-md-4 icon-box">
                        <i class="bi bi-stars"></i>
                        <h5 class="mt-3">Professional Team</h5>
                        <p>Experienced wedding specialists.</p>
                    </div>
                </div>
            </div>
        </section>
        <section id="gallery" class="py-5 wedding-bg">
            <div class="container text-center">
                <h2 class="mb-5 fw-bold" style="color: var(--pink-dark);">Gallery</h2>
                <div class="row g-4">
                    <div class="col-md-4"><img src="assets/img/wedding2.jpg" class="img-fluid rounded"></div>
                    <div class="col-md-4"><img src="assets/img/wedding8.webp" class="img-fluid rounded"></div>
                    <div class="col-md-4"><img src="assets/img/wedding6.webp" class="img-fluid rounded"></div>
                </div>
            </div>
        </section>
        <section class="cta-wedding d-flex align-items-center text-white">
            <div class="container text-center">
                <span class="badge-wedding mb-3 d-inline-block">Wedding Consultation</span>
                <h2 class="fw-bold mt-3">Ready to Plan Your Dream Wedding?</h2>
                <p class="lead">Let us handle every detail for your special day.</p>
                <a href="contact.jsp" class="btn btn-outline-light btn-lg px-5">Book Consultation</a>
            </div>
        </section>
        <footer class="footer-wedding text-center py-4">
            © 2026 Wedding Amba Organizer. All Rights Reserved.
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>