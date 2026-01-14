-- SQL Migration: Update Struktur Database
-- Jalankan perintah ini di Terminal / DBeaver untuk memperbarui database

-- 1. Tambah Kolom 'kode_booking' di tabel 'booking'
ALTER TABLE booking ADD COLUMN kode_booking VARCHAR(20) UNIQUE;

-- 2. Update data lama (jika ada) agar punya kode booking
-- Ini opsional, hanya kalau sudah ada data sebelumnya
UPDATE booking SET kode_booking = 'WED-' || id WHERE kode_booking IS NULL;

-- 3. Cek hasil struktur
-- \d booking;
