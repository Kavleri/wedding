<%-- 
    Document   : home
    Created on : 5 Jan 2026, 10.19.40
    Author     : Sayyid
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Wedding Amba Organizer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero {
            background: linear-gradient(rgba(0,0,0,.4), rgba(0,0,0,.4)),
            url('https://images.unsplash.com/photo-1523438885200-e635ba2c371e');
            background-size: cover;
            background-position: center;
            height: 90vh;
            color: white;
        }
    </style>
</head>
<body>

<jsp:include page="components/navbar.jsp" />

<section class="hero d-flex align-items-center">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Your Dream Wedding</h1>
        <p class="lead">Elegant wedding packages for your special day</p>
        <a href="packages.jsp" class="btn btn-light btn-lg mt-3">View Packages</a>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

