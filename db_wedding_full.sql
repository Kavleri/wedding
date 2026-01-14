-- ==========================================
-- SCRIPT RESET DATABASE LENGKAP
-- ==========================================

-- 1. Hapus tabel lama biar bersih (urutan penting karena ada relasi foreign key)
DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS paket_wedding CASCADE;
DROP TABLE IF EXISTS admin CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- 2. Buat Tabel Users (Untuk Login Customer jika nanti diperlukan)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user'
);

-- 3. Buat Tabel Admin (Untuk Login Dashboard)
CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- 4. Buat Tabel Paket Wedding
CREATE TABLE paket_wedding (
    id SERIAL PRIMARY KEY,
    nama_paket VARCHAR(100) NOT NULL,
    harga DOUBLE PRECISION NOT NULL,
    deskripsi TEXT,
    gambar VARCHAR(255) -- Opsi tambahan jika nanti mau simpan path gambar di DB
);

-- 5. Buat Tabel Booking (Transaksi)
CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    nama_pemesan VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20),
    tanggal_acara DATE,
    alamat TEXT,
    paket_id INT REFERENCES paket_wedding(id) ON DELETE SET NULL,
    kode_booking VARCHAR(20) UNIQUE
);

-- ==========================================
-- INSERT DATA DUMMY (DATA AWAL)
-- ==========================================

-- A. Data Paket Wedding (Wajib ada biar halaman Packages muncul)
INSERT INTO paket_wedding (nama_paket, harga, deskripsi) VALUES 
('Silver Intimate Package', 7500000, 'Paket hemat untuk 50 tamu. Termasuk dekorasi minimalis, katering prasmanan sederhana, dan dokumentasi foto.'),
('Gold Rustic Package', 15000000, 'Paket favorit! Dekorasi tema Rustic kekinian, katering 200 porsi, MUA pengantin, dan hiburan akustik.'),
('Platinum Royal Package', 35000000, 'Paket Sultan. Gedung full dekorasi mewah, katering 500 porsi, videografi cinematic, mobil pengantin, dan tim WO full day.');

-- B. Data Admin Default
-- Email: admin@test.com | Pass: admin123
INSERT INTO admin (nama, email, password) VALUES 
('Super Admin', 'admin@test.com', 'admin123');

-- C. Data User Default (Opsional)
INSERT INTO users (username, password, role) VALUES 
('testuser', 'user123', 'user');

-- D. Data Booking Contoh (Biar Dashboard Admin gak kosong melompong)
INSERT INTO booking (nama_pemesan, no_hp, tanggal_acara, alamat, paket_id, kode_booking) VALUES
('Budi Santoso', '081234567890', '2024-12-25', 'Jl. Merpati No. 10, Jakarta', 2, 'WED-EXMPL1'),
('Siti Aminah', '089876543210', '2025-01-10', 'Jl. Kenanga Komp. Melati', 1, 'WED-EXMPL2');
