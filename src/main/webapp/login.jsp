<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Wedding Amba Organizer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https:
    <link href="https:
    <link rel="stylesheet" href="https:
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=8">
</head>
<body>
    <jsp:include page="components/navbar.jsp"/>
    <div class="container d-flex align-items-center justify-content-center" style="min-height:100vh; padding-top:90px;">
        <div class="row col-lg-9 login-card overflow-hidden">
            <div class="col-md-6 auth-bg-image d-none d-md-flex flex-column justify-content-center p-5">
                <h3 class="fw-bold">Welcome Back 💍</h3>
                <p class="mt-3">
                    Login to manage your wedding packages,
                    bookings, and special moments.
                </p>
            </div>
            <div class="col-md-6 bg-white p-5">
                <h3 class="login-title mb-4 text-center">Login Account</h3>
                <% 
                    String status = request.getParameter("status");
                    if("failed".equals(status)) {
                %>
                    <div class="alert alert-danger text-center p-2 mb-3" role="alert">
                        <small>Email atau Password Salah!</small>
                    </div>
                <% } %>
                <form action="LoginServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label text-muted small fw-bold">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="admin@amba.com" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label text-muted small fw-bold">Password</label>
                        <div class="input-group">
                            <input type="password" name="password" class="form-control" id="passwordInput" placeholder="********" required style="border-right: 0;">
                            <span class="input-group-text bg-white" style="cursor: pointer; border-left: 0;" onclick="togglePassword()">
                                <i class="bi bi-eye-slash" id="toggleIcon"></i>
                            </span>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-login w-100 py-2">
                        Login
                    </button>
                </form>
                <p class="text-center mt-4 text-muted small">
                    <i class="bi bi-lock-fill me-1"></i> Area Terbatas: Khusus Staff Internal<br>
                </p>
            </div>
        </div>
    </div>
    <script>
        function togglePassword() {
            const passwordInput = document.getElementById("passwordInput");
            const toggleIcon = document.getElementById("toggleIcon");
            if (passwordInput.type === "password") {
                passwordInput.type = "text"; 
                toggleIcon.classList.remove("bi-eye-slash"); 
                toggleIcon.classList.add("bi-eye"); 
            } else {
                passwordInput.type = "password"; 
                toggleIcon.classList.remove("bi-eye"); 
                toggleIcon.classList.add("bi-eye-slash"); 
            }
        }
    </script>
    <script src="https:
</body>
</html> 