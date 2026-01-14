-- ==========================================
-- SCRIPT MERGED DATABASE (LENGKAP + FITUR BARU)
-- ==========================================

-- 1. BERSIH-BERSIH (Hapus tabel lama dengan urutan aman)
DROP TABLE IF EXISTS pembayaran CASCADE;
DROP TABLE IF EXISTS pesanan CASCADE; -- Tabel lama tim kamu
DROP TABLE IF EXISTS booking CASCADE; -- Tabel baru aplikasi
DROP TABLE IF EXISTS paket_wedding CASCADE;
DROP TABLE IF EXISTS kategori CASCADE;
DROP TABLE IF EXISTS admin CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- 2. TABEL MASTER (Data Induk)

-- Tabel Admin (Untuk Login Dashboard)
CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Tabel Users (Untuk Customer Login - Sesuai request tim)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user'
);

-- Tabel Kategori (Request Tim: Kategorisasi Paket)
CREATE TABLE kategori (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(50) NOT NULL
);

-- Tabel Paket Wedding (Gabungan: Ada Kategori ID + Data Paket)
CREATE TABLE paket_wedding (
    id SERIAL PRIMARY KEY,
    nama_paket VARCHAR(100) NOT NULL,
    harga DOUBLE PRECISION NOT NULL,
    deskripsi TEXT,
    gambar VARCHAR(255),
    kategori_id INT REFERENCES kategori(id) ON DELETE SET NULL
);

-- 3. TABEL TRANSAKSI

-- Tabel Booking (UTAMA: Dipakai aplikasi saat ini)
-- Kita lengkapi kolomnya biar aman
CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    nama_pemesan VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20),
    tanggal_acara DATE,
    alamat TEXT,
    paket_id INT REFERENCES paket_wedding(id) ON DELETE SET NULL,
    
    -- Kolom Baru Wajib (Fitur Cek Pesanan)
    kode_booking VARCHAR(20) UNIQUE,
    
    -- Kolom Tambahan (Biar sinkron sama tabel lama tim)
    user_id INT REFERENCES users(id) ON DELETE SET NULL, -- Opsional kalo user login
    status VARCHAR(20) DEFAULT 'Pending', -- (Pending, Confirmed, Cancelled)
    tanggal_booking TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Pembayaran (Request Tim: Catat DP/Lunas)
CREATE TABLE pembayaran (
    id SERIAL PRIMARY KEY,
    booking_id INT REFERENCES booking(id) ON DELETE CASCADE,
    jumlah_bayar DOUBLE PRECISION,
    metode_bayar VARCHAR(50), -- Transfer BCA, Cash, dll
    tanggal_bayar TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- INSERT DATA DUMMY (SEEDING)
-- ==========================================

-- A. Data Kategori
INSERT INTO kategori (nama) VALUES ('Indoor'), ('Outdoor'), ('Intimate'), ('Luxury');

-- B. Data Paket Wedding (Lengkap dengan Kategori)
INSERT INTO paket_wedding (nama_paket, harga, deskripsi, kategori_id, gambar) VALUES 
('Silver Intimate Package', 7500000, 'Paket hemat 50 pax. Dekorasi minimalis & catering.', 3, 'assets/img/wedding7.jpg'),
('Gold Rustic Package', 15000000, 'Paket 200 pax. Tema Rustic, MUA, Hiburan.', 2, 'assets/img/wedding4.jpg'),
('Platinum Royal Package', 35000000, 'Paket 500 pax. Gedung mewah, Full Service WO.', 4, 'assets/img/indor.jpg'),
('Garden Party Exclusive', 12500000, 'Konsep Outdoor segar dengan dekorasi bunga hidup. Max 100 pax.', 2, 'assets/img/wedding8.webp'),
('Javanese Heritage', 28000000, 'Paket Adat Jawa lengkap (Paes Ageng), Gamelan, dan Dekorasi Gebyok.', 4, 'assets/img/wedding6.webp'),
('Modern Minimalist', 9500000, 'Simpel & Elegan. Dekorasi putih bersih, Fotografer pro, dan MC.', 1, 'assets/img/wedding2.jpg');

-- C. Data Admin
INSERT INTO admin (nama, email, password) VALUES ('Super Admin', 'admin@test.com', 'admin123');

-- D. Data User
INSERT INTO users (username, password, role) VALUES ('customer', 'user123', 'user');

-- E. Data Booking Contoh
INSERT INTO booking (nama_pemesan, no_hp, tanggal_acara, alamat, paket_id, kode_booking, status) VALUES
('Andi Pratama', '08123456789', '2024-12-12', 'Jl. Sudirman No. 1', 2, 'WED-SAMPLE1', 'Confirmed'),
('Siti Nurhaliza', '08567891234', '2025-01-01', 'Komp. Mawar Indah', 1, 'WED-SAMPLE2', 'Pending');
