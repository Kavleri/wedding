-- UPDATE STRUKTUR TABEL ADMIN (Menambah Role)
ALTER TABLE admin ADD COLUMN role VARCHAR(20) DEFAULT 'staff';

-- Set user pertama sebagai 'admin' (Super User)
UPDATE admin SET role = 'admin' WHERE id = 1;
