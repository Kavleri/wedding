# LAPORAN FINAL PROJECT
# WEDDING AMBA ORGANIZER

**Mata Kuliah:** Pemrograman Berorientasi Objek (PBO) / Pemrograman Web  
**Dosen Pengampu:** (Silakan Isi)

---

## DAFTAR ANGGOTA KELOMPOK
| No | Nama | Jabatan |
|----|------|---------|
| 1. | **Muhammad Ridwan Karim** | Ketua Kelompok |
| 2. | **Muhammad Hisyam Alfaris** | Anggota |
| 3. | **Sayed Muhammad Qadri** | Anggota |
| 4. | **Muhamad Aditia** | Anggota |
| 5. | **Muhammad Nur Alam** | Anggota |

---

## BAB I: PENDAHULUAN

### 1.1 Latar Belakang
Pernikahan adalah momen sakral yang membutuhkan persiapan matang. Banyak calon pengantin mengalami kesulitan dalam mengelola vendor, paket pernikahan, dan anggaran. **Wedding Amba Organizer** hadir sebagai solusi berbasis web untuk memudahkan calon pengantin dalam memilih paket pernikahan, melakukan pemesanan, dan berkonsultasi dengan tim organizer secara efisien.

### 1.2 Tujuan
1.  Memudahkan pelanggan melihat dan memesan paket pernikahan secara online.
2.  Membantu admin mengelola data pesanan, paket, dan laporan keuangan.
3.  Menyediakan media promosi yang efektif bagi penyedia jasa Wedding Organizer.

---

## BAB II: IMPLEMENTASI PROJECT

### 2.1 Teknologi yang Digunakan
Aplikasi ini dibangun menggunakan teknologi Java Web dengan arsitektur **MVC (Model-View-Controller)**:
-   **Bahasa Pemrograman:** Java (JDK 17+)
-   **Framework/Teknologi:** Jakarta EE (Servlet, JSP)
-   **Database:** PostgreSQL
-   **Frontend:** HTML5, CSS3, Bootstrap 5
-   **Server:** Apache Tomcat

### 2.2 Fitur Utama
1.  **Halaman Publik (User):**
    -   **Beranda:** Menampilkan slider, keunggulan, dan galeri.
    -   **Paket Wedding:** Katalog paket dengan filter kategori.
    -   **Booking Online:** Form pemesanan paket.
    -   **Cek Pesanan:** Melacak status pesanan menggunakan Kode Booking.
    -   **Tentang Kami:** Profil tim pengembang.
    -   **Kontak:** Form kirim pesan ke admin.

2.  **Halaman Admin (Dashboard):**
    -   **Statistik:** Ringkasan total pesanan, pendapatan, dan staf.
    -   **Manajemen Pesanan:** Konfirmasi atau batalkan pesanan masuk.
    -   **Manajemen Paket:** Tambah, edit, hapus produk paket pernikahan (termasuk upload gambar).
    -   **Manajemen Tim:** Kelola profil anggota tim di halaman About.
    -   **Inbox:** Membaca pesan masuk dari pelanggan.

---

## BAB III: SKEMA DATABASE

Aplikasi ini menggunakan database **PostgreSQL** dengan nama `db_wedding`. Berikut adalah struktur tabel utamanya:

### 3.1 Entity Relationship Diagram (ERD) Deskriptif
-   **admin**: Menyimpan data login admin dan staf.
-   **users**: Menyimpan data pengguna (opsional).
-   **kategori**: Mengelompokkan paket (Indoor, Outdoor, Luxury, dll).
-   **paket_wedding**: Menyimpan data produk paket (Harga, Deskripsi, Gambar).
-   **booking**: Menyimpan transaksi pemesanan (Relasi ke `paket_wedding`).
-   **team_members**: Menyimpan data profil tim.
-   **kontak**: Menyimpan pesan dari pengunjung web.

### 3.2 Struktur Tabel (SQL)
```sql
CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    nama_pemesan VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20),
    tanggal_acara DATE,
    paket_id INT REFERENCES paket_wedding(id),
    kode_booking VARCHAR(20) UNIQUE,
    status VARCHAR(20) DEFAULT 'Pending'
);
```
*(Selengkapnya lihat file `database.sql`)*

---

## BAB IV: LAMPIRAN KODE PROGRAM

Berikut adalah contoh implementasi kode program utama menggunakan pola MVC.

### 4.1 Koneksi Database (DBConnection.java)
```java
public class DBConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/db_wedding";
    private static final String USER = "postgres";
    private static final String PASSWORD = "admin";

    public static Connection getConnection() {
        // Logic koneksi JDBC
    }
}
```

### 4.2 Controller Login (LoginServlet.java)
```java
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        AdminDAO dao = new AdminDAO();
        AdminModel admin = dao.cekLogin(email, password);
        
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminLog", admin);
            response.sendRedirect("admin/dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?status=failed");
        }
    }
}
```

---

## SOURCE CODE & INSTALASI

### Cara Menjalankan Aplikasi di Apache NetBeans:

#### 1. Persiapan Database
1.  Buka pgAdmin 4 atau DBeaver.
2.  Buat database baru dengan nama `db_wedding`.
3.  Klik kanan pada database `db_wedding` -> **Query Tool**.
4.  Buka file `database.sql` (ada di dalam folder project), copy semua isinya, paste ke Query Tool, dan jalankan (Execute/F5).

#### 2. Membuka Project di NetBeans
1.  Buka aplikasi **Apache NetBeans**.
2.  Pilih menu **File** -> **Open Project**.
3.  Cari dan pilih folder `wedding` (pastikan ada icon kopi/cup di folder tersebut).
4.  Klik **Open Project**.

#### 3. Konfigurasi Library (JDBC Driver)
Agar aplikasi bisa terkoneksi ke PostgreSQL, Anda wajib menambahkan driver JDBC:
1.  Klik kanan pada nama project `wedding` di panel kiri (Projects).
2.  Pilih **Properties**.
3.  Pilih kategori **Libraries**.
4.  Klik tombol **+ (Plus)** atau **Add JAR/Folder** di bagian Classpath.
5.  Cari dan pilih file `postgresql-42.x.x.jar` (Anda harus mendownloadnya jika belum punya).
6.  Klik **OK**.

#### 4. Konfigurasi Koneksi (Jika Perlu)
Jika password PostgreSQL Anda bukan `admin`, sesuaikan di file:
`src/main/java/connection/DBConnection.java`
```java
private static final String PASSWORD = "password_anda";
```

#### 5. Menjalankan Aplikasi
1.  Klik kanan pada project `wedding`.
2.  Pilih **Clean and Build** (untuk memastikan tidak ada error).
3.  Klik tombol **Run** (Segitiga Hijau) atau tekan **F6**.
4.  Pilih server **Apache Tomcat** jika diminta.
5.  Aplikasi akan terbuka otomatis di browser.

### Akses Login Admin:
-   **Email:** admin@amba.com
-   **Password:** admin123
