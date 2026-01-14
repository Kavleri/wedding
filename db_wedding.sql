-- Database: db_wedding

-- Table: users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20)
);

-- Table: admin
CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Table: paket_wedding
CREATE TABLE paket_wedding (
    id SERIAL PRIMARY KEY,
    nama_paket VARCHAR(100) NOT NULL,
    harga DOUBLE PRECISION NOT NULL,
    deskripsi TEXT
);

-- Table: booking
CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    nama_pemesan VARCHAR(100) NOT NULL,
    no_hp VARCHAR(20),
    tanggal_acara DATE,
    alamat TEXT,
    paket_id INT REFERENCES paket_wedding(id),
    kode_booking VARCHAR(20) UNIQUE
);

-- Insert Dummy Data for paket_wedding (Based on PackageDAO logic)
INSERT INTO paket_wedding (nama_paket, harga, deskripsi) VALUES 
('Silver Wedding Package', 5000000, 'Paket hemat untuk acara intim.'),
('Gold Wedding Package', 10000000, 'Paket menengah dengan dekorasi rustic.'),
('Platinum Royal Package', 25000000, 'Paket mewah dengan gedung dan katering lengkap.');

-- Insert Default Admin
INSERT INTO admin (nama, email, password) VALUES ('Admin', 'admin@test.com', 'admin123');

-- Insert Default User
INSERT INTO users (username, password, role) VALUES ('user', 'user123', 'user');
