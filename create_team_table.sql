-- TABEL TIM KAMI (Untuk Halaman About Us)
CREATE TABLE team_members (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jabatan VARCHAR(100) NOT NULL,
    foto VARCHAR(255) DEFAULT 'assets/img/team/default.jpg'
);

-- INSERT 5 DATA AWAL (Dummy)
INSERT INTO team_members (nama, jabatan, foto) VALUES 
('Nama Anggota 1', 'Ketua Kelompok', 'assets/img/team/1.jpg'),
('Nama Anggota 2', 'Backend Developer', 'assets/img/team/2.jpg'),
('Nama Anggota 3', 'Frontend Developer', 'assets/img/team/3.jpg'),
('Nama Anggota 4', 'UI/UX Designer', 'assets/img/team/4.jpg'),
('Nama Anggota 5', 'System Analyst', 'assets/img/team/5.jpg');
