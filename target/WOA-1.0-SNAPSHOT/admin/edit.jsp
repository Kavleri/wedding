<%@page import="model.BookingModel"%>
<%@page import="dao.BookingDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("adminLog") == null){
        response.sendRedirect("../login.jsp");
        return;
    }
    String idStr = request.getParameter("id");
    BookingModel data = null;
    if(idStr != null) {
        BookingDAO dao = new BookingDAO();
        int id = Integer.parseInt(idStr);
        data = dao.getBookingById(id);
    }
    if(data == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Pesanan</title>
    <link href="https:
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0">Edit Data Pesanan</h4>
                </div>
                <div class="card-body">
                    <form action="../UpdateServlet" method="post">
                        <input type="hidden" name="id" value="<%= data.getId() %>">
                        <div class="mb-3">
                            <label>Nama Pemesan</label>
                            <input type="text" name="nama" class="form-control" value="<%= data.getNamaPemesan() %>" required>
                        </div>
                        <div class="mb-3">
                            <label>No HP</label>
                            <input type="text" name="hp" class="form-control" value="<%= data.getNoHp() %>" required>
                        </div>
                        <div class="mb-3">
                            <label>Pilih Paket</label>
                            <select name="paket" class="form-select">
                                <option value="1" <%= (data.getPaketId() == 1) ? "selected" : "" %>>Silver Packgae</option>
                                <option value="2" <%= (data.getPaketId() == 2) ? "selected" : "" %>>Gold Package</option>
                                <option value="3" <%= (data.getPaketId() == 3) ? "selected" : "" %>>Platinum Package</option>
                                <option value="4" <%= (data.getPaketId() == 4) ? "selected" : "" %>>Garden Party</option>
                                <option value="5" <%= (data.getPaketId() == 5) ? "selected" : "" %>>Intimate Rustic</option>
                                <option value="6" <%= (data.getPaketId() == 6) ? "selected" : "" %>>Royal Heritage</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Tanggal Acara</label>
                            <input type="date" name="tanggal" class="form-control" value="<%= data.getTanggalAcara() %>" required>
                        </div>
                        <div class="mb-3">
                            <label>Alamat</label>
                            <textarea name="alamat" class="form-control" required><%= data.getAlamat() %></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Simpan Perubahan</button>
                        <a href="dashboard.jsp" class="btn btn-secondary w-100 mt-2">Batal</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>