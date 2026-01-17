<%@ page pageEncoding="UTF-8" %>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; } 
    .navbar-brand { font-family: 'Poppins', sans-serif !important; font-weight: 700 !important; font-size: 1.25rem !important; }
</style>
<nav class="navbar navbar-expand-lg navbar-wedding fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp" style="font-family: 'Poppins', sans-serif; font-weight: 700; font-size: 1.25rem;">
            AMBxORG
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navAmba">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navAmba">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="packages.jsp">Packages</a></li>
                <li class="nav-item"><a class="nav-link" href="check_booking.jsp">Cek Pesanan</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                <li class="nav-item ms-lg-3">
                    <a href="login.jsp" class="btn btn-light-wedding btn-sm">
                        Login
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>