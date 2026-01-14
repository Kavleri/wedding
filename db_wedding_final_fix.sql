-- ==========================================
-- DATABASE FINAL: WEDDING AMBA ORGANIZER
-- Tanggal: 2024
-- ==========================================

-- 1. BERSIH-BERSIH (DROP TABLE JIKA ADA)
DROP TABLE IF EXISTS team_members CASCADE;
DROP TABLE IF EXISTS kontak CASCADE;
DROP TABLE IF EXISTS pembayaran CASCADE;
DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS paket_wedding CASCADE;
DROP TABLE IF EXISTS kategori CASCADE;
DROP TABLE IF EXISTS admin CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ==========================================
-- 2. STRUKTUR TABEL (SCHEMA)
-- ==========================================

-- A. Tabel Admin & Staff (Login Dashboard)
CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'staff' -- 'admin' (Super) atau 'staff'
);

-- B. Tabel Users (Customer Login - Opsional)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user'
);

-- C. Tabel Kategori Paket
CREATE TABLE kategori (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(50) NOT NULL
);

-- D. Tabel Paket Wedding (Produk)
CREATE TABLE paket_wedding (
    id SERIAL PRIMARY KEY,
    nama_paket VARCHAR(100) NOT NULL,
    harga DOUBLE PRECISION NOT NULL,
    deskripsi TEXT,
    gambar VARCHAR(255), -- Path gambar (e.g., assets/uploads/foto.jpg)
    kategori_id INT REFERENCES kategori(id) ON DELETE SET NULL
);

-- E. Tabel Tim (About Us)
CREATE TABLE team_members (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jabatan VARCHAR(100) NOT NULL,
    foto VARCHAR(255) DEFAULT 'assets/img/team/default.jpg'
);

-- F. Tabel Booking (Pemesanan)
CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    nama_pemesan VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20),
    tanggal_acara DATE,
    alamat TEXT,
    paket_id INT REFERENCES paket_wedding(id) ON DELETE SET NULL,
    kode_booking VARCHAR(20) UNIQUE, -- Kode Unik (WED-XXXXX)
    status VARCHAR(20) DEFAULT 'Pending', -- Pending, Confirmed, Cancelled
    tanggal_booking TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- G. Tabel Kontak (Inbox Pesan)
CREATE TABLE kontak (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subjek VARCHAR(150),
    pesan TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 3. INSERT DATA DUMMY (SEEDING)
-- ==========================================

-- Data Admin & Staff
INSERT INTO admin (nama, email, password, role) VALUES 
('Super Admin', 'admin@test.com', 'admin123', 'admin'),
('Sayed Staff', 'sayed@gmail.com', 'sayed123', 'staff'),
('Budi Keuangan', 'budi@gmail.com', 'budi123', 'staff');

-- Data Kategori
INSERT INTO kategori (nama) VALUES ('Indoor'), ('Outdoor'), ('Intimate'), ('Luxury');

-- Data Paket Wedding
INSERT INTO paket_wedding (nama_paket, harga, deskripsi, kategori_id, gambar) VALUES 
('Silver Intimate Package', 7500000, 'Paket hemat 50 pax. Dekorasi minimalis & catering.', 3, 'assets/img/wedding7.jpg'),
('Gold Rustic Package', 15000000, 'Paket 200 pax. Tema Rustic, MUA, Hiburan.', 2, 'assets/img/wedding4.jpg'),
('Platinum Royal Package', 35000000, 'Paket 500 pax. Gedung mewah, Full Service WO.', 4, 'assets/img/indor.jpg'),
('Garden Party Exclusive', 12500000, 'Konsep Outdoor segar dengan dekorasi bunga hidup. Max 100 pax.', 2, 'assets/img/wedding8.webp'),
('Javanese Heritage', 28000000, 'Paket Adat Jawa lengkap (Paes Ageng), Gamelan, dan Dekorasi Gebyok.', 4, 'assets/img/wedding6.webp'),
('Modern Minimalist', 9500000, 'Simpel & Elegan. Dekorasi putih bersih, Fotografer pro, dan MC.', 1, 'assets/img/wedding2.jpg');

-- Data Tim (About Us - 5 Orang Lengkap)
INSERT INTO team_members (nama, jabatan, foto) VALUES 
('Muhammad Ridwan Karim', 'Ketua Kelompok', 'assets/img/team/1.jpg'),
('Muhammad Hisyam Alfaris', 'Anggota', 'assets/img/team/2.jpg'),
('Sayed Muhammad Qadri', 'Anggota', 'assets/img/team/3.jpg'),
('Muhamad Aditia', 'Anggota', 'assets/img/team/4.jpg'),
('Muhammad Nur Alam', 'Anggota', 'assets/img/team/5.jpg');

-- Data Booking Contoh
INSERT INTO booking (nama_pemesan, no_hp, tanggal_acara, alamat, paket_id, kode_booking, status) VALUES
('Andi Pratama', '08123456789', '2024-12-12', 'Jl. Sudirman No. 1', 2, 'WED-SAMPLE1', 'Confirmed'),
('Siti Nurhaliza', '08567891234', '2025-01-01', 'Komp. Mawar Indah', 1, 'WED-SAMPLE2', 'Pending'),
('Rudi Hartono', '08998877665', '2025-02-14', 'Gedung Serbaguna Lt. 2', 3, 'WED-SAMPLE3', 'Pending');

-- Data Inbox
INSERT INTO kontak (nama, email, subjek, pesan) VALUES 
('Lina Marlina', 'lina@gmail.com', 'Tanya Harga', 'Apakah paket Gold bisa tambah porsi catering?'),
('Joko Susilo', 'joko@yahoo.com', 'Request Meeting', 'Saya ingin bertemu tim WO minggu depan.');
