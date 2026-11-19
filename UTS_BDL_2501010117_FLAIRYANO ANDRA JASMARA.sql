-- 1. DDL: Pembuatan Database dan Tabel --
-- 1a. Buat Database
CREATE DATABASE uts_bdl_2501010117;
USE uts_bdl_2501010117

-- 1b. Buat 4 Tabel
CREATE TABLE destinasi(
id_destinasi CHAR(4) PRIMARY KEY,
nama_destinasi VARCHAR(50) NOT NULL,
kabupaten VARCHAR(50) NOT NULL,
harga_tiket INT NOT NULL
);

CREATE TABLE paket_tur(
id_paket CHAR(4) PRIMARY KEY,
nama_paket VARCHAR(50) NOT NULL UNIQUE,
id_destinasi CHAR(4) NOT NULL,
harga INT NOT NULL,
durasi_jam INT, 
FOREIGN KEY(id_destinasi) REFERENCES destinasi(id_destinasi)
);

CREATE TABLE wisatawan(
id_wisatawan CHAR(5) PRIMARY KEY,
nama VARCHAR(50) NOT NULL,
asal_negara VARCHAR(30) NOT NULL,
email VARCHAR(50)UNIQUE
);

CREATE TABLE pemesanan(
id_pesan INT PRIMARY KEY,
id_wisatawan CHAR(5) NOT NULL,
id_paket CHAR(4) NOT NULL,
tgl_tur DATE NOT NULL,
jumlah_orang INT NOT NULL,
STATUS VARCHAR(10) NOT NULL DEFAULT 'pending',
FOREIGN KEY (id_wisatawan) REFERENCES wisatawan(id_wisatawan),
FOREIGN KEY (id_paket) REFERENCES paket_tur(id_paket)
);

-- 1c. Alter Table
ALTER TABLE destinasi ADD COLUMN rating DECIMAL(2,1);

-- 2. DML: Mengisi dan Mengubah Data --
-- 2a. Insert data ke 4 tabel
INSERT INTO destinasi (id_destinasi, nama_destinasi, kabupaten, harga_tiket) VALUES
('D001', 'Tanah Lot', 'Tabanan', 30000),
('D002', 'Ulun Danu Beratan', 'Tabanan', 50000),
('D003', 'Tirta Empul', 'Gianyar', 50000),
('D004', 'Goa Gajah', 'Gianyar', 50000),
('D005', 'Desa Penglipuran', 'Bangli', 25000),
('D006', 'Pura Besakih', 'Karangasem', 60000),
('D007', 'Jatiluwih', 'Tabanan', 50000);

INSERT INTO paket_tur (id_paket, nama_paket, id_destinasi, harga, durasi_jam) VALUES
('P001', 'Sunset Tanah Lot', 'D001', 350000, 5),
('P002', 'Bedugul Lake Tour', 'D002', 450000, 8),
('P003', 'Ubud Water Temple', 'D003', 400000, 6),
('P004', 'Ubud Heritage Walk', 'D004', 300000, 4),
('P005', 'Penglipuran Culture Trip', 'D005', 375000, 6),
('P006', 'Besakih Spiritual Journey', 'D006', 500000, 8),
('P007', 'Tanah Lot Photo Tour', 'D001', 250000, 3);

INSERT INTO wisatawan (id_wisatawan, nama, asal_negara, email) VALUES
('W0001', 'Made Ayu', 'Indonesia', 'made.ayu@mail.com'),
('W0002', 'John Smith', 'Australia', 'john.s@mail.com'),
('W0003', 'Sarah Lee', 'Singapura', 'sarah.lee@mail.com'),
('W0004', 'Kenji Tanaka', 'Jepang', 'kenji.t@mail.com'),
('W0005', 'Putu Arya', 'Indonesia', 'putu.arya@mail.com'),
('W0006', 'Emma Brown', 'Australia', 'emma.b@mail.com'),
('W0007', 'Li Wei', 'Tiongkok', 'li.wei@mail.com'),
('W0008', 'Komang Sari', 'Indonesia', 'komang.s@mail.com');

INSERT INTO pemesanan (id_pesan, id_wisatawan, id_paket, tgl_tur, jumlah_orang, STATUS) VALUES
(1, 'W0001', 'P001', '2026-09-05', 2, 'Lunas'),
(2, 'W0002', 'P003', '2026-09-12', 4, 'Lunas'),
(3, 'W0003', 'P002', '2026-09-20', 2, 'Batal'),
(4, 'W0004', 'P004', '2026-10-02', 3, 'Lunas'),
(5, 'W0002', 'P001', '2026-10-03', 4, 'Lunas'),
(6, 'W0005', 'P005', '2026-10-10', 5, 'Lunas'),
(7, 'W0006', 'P003', '2026-10-15', 2, 'Pending'),
(8, 'W0004', 'P002', '2026-10-18', 1, 'Lunas'),
(9, 'W0007', 'P007', '2026-10-25', 3, 'Lunas'),
(10, 'W0001', 'P004', '2026-11-01', 2, 'Lunas'),
(11, 'W0006', 'P001', '2026-11-07', 6, 'Lunas'),
(12, 'W0003', 'P005', '2026-11-09', 2, 'Pending');

-- 2b. Update harga
UPDATE destinasi SET harga_tiket = 30000 WHERE id_destinasi = 'D005';

-- 2c. update status
UPDATE pemesanan SET STATUS = 'Lunas' WHERE id_pesan = 12;

-- 2d. hapus pemesanan berstatus batal
DELETE FROM pemesanan WHERE STATUS = 'Batal';

-- 2e. tambahkan wisatawan baru
INSERT INTO wisatawan (id_wisatawan, nama, asal_negara, email) VALUES
('W0009', 'Anna Schmidt', 'Jerman', 'anna.s@mail.com');

-- 2f. perintah error
INSERT INTO wisatawan VALUES
('W0010','Budi Santoso','Indonesia','made.ayu@mail.com');
-- Penjelasan: Perintah ini ditolak karena melanggar constraint UNIQUE pada kolom email.
-- Email 'made.ayu@mail.com' sudah digunakan oleh wisatawan W0001 (Made Ayu).
-- Constraint UNIQUE memastikan tidak ada dua baris yang memiliki nilai email yang sama.

-- 3. query satu tabel --
-- 3a. urut harga dan nama paket
SELECT nama_paket, harga 
FROM paket_tur 
WHERE harga BETWEEN 300000 AND 450000 
ORDER BY harga ASC;

-- 3b. urut nama A-Z
SELECT id_wisatawan, nama 
FROM wisatawan 
WHERE nama LIKE '%an%' 
ORDER BY nama ASC;

-- 3c. 3 pemesanan dengan jumlah orang terbanyak
SELECT id_pesan, id_wisatawan, jumlah_orang 
FROM pemesanan 
ORDER BY jumlah_orang DESC, id_pesan ASC 
LIMIT 3;

-- 3d. Pemesanan Lunas di bulan Oktober 2026
SELECT id_pesan, tgl_tur, STATUS 
FROM pemesanan 
WHERE STATUS = 'Lunas' AND tgl_tur >= '2026-10-01' AND tgl_tur <= '2026-10-31' 
ORDER BY tgl_tur ASC;

-- 4. JOIN --
-- 4a. Nama wisatawan, nama_paket, tgl_tur untuk pemesanan Lunas (3 tabel)
SELECT w.nama, p.nama_paket, pm.tgl_tur 
FROM pemesanan pm 
JOIN wisatawan w ON pm.id_wisatawan = w.id_wisatawan 
JOIN paket_tur p ON pm.id_paket = p.id_paket 
WHERE pm.status = 'Lunas' 
ORDER BY pm.tgl_tur ASC;

-- 4b. INNER JOIN paket_tur & destinasi di Kabupaten Gianyar, urut nama_paket
SELECT p.nama_paket, d.nama_destinasi, d.kabupaten 
FROM paket_tur p 
INNER JOIN destinasi d ON p.id_destinasi = d.id_destinasi 
WHERE d.kabupaten = 'Gianyar' 
ORDER BY p.nama_paket ASC;

-- 4c. LEFT JOIN wisatawan yang belum pernah memesan, urut id_wisatawan
SELECT w.id_wisatawan, w.nama 
FROM wisatawan w 
LEFT JOIN pemesanan pm ON w.id_wisatawan = pm.id_wisatawan 
WHERE pm.id_pesan IS NULL 
ORDER BY w.id_wisatawan ASC;

-- 4d. RIGHT JOIN (pemesanan di kiri) paket yang belum pernah dipesan
SELECT p.id_paket, p.nama_paket 
FROM pemesanan pm 
RIGHT JOIN paket_tur p ON pm.id_paket = p.id_paket 
WHERE pm.id_pesan IS NULL;

-- 5. Fungsi Agregasi dan GROUP BY --
-- 5a. Status, jumlah pemesanan, total peserta, urut status A-Z
SELECT STATUS, COUNT(*) AS jumlah_pesanan, SUM(jumlah_orang) AS total_peserta 
FROM pemesanan 
GROUP BY STATUS 
ORDER BY STATUS ASC;

-- 5b. Pendapatan setiap paket dari pemesanan Lunas, urut terbesar
SELECT p.nama_paket, SUM(p.harga * pm.jumlah_orang) AS pendapatan 
FROM pemesanan pm 
JOIN paket_tur p ON pm.id_paket = p.id_paket 
WHERE pm.status = 'Lunas' 
GROUP BY p.nama_paket 
ORDER BY pendapatan DESC;

-- 5c. Asal negara dan jumlah wisatawan, urut terbanyak lalu A-Z
SELECT asal_negara, COUNT(*) AS jumlah_wisatawan 
FROM wisatawan 
GROUP BY asal_negara 
ORDER BY jumlah_wisatawan DESC, asal_negara ASC;

-- 5d. Per kabupaten: rata-rata (2 desimal), tertinggi, terendah, urut rata-rata terbesar
SELECT kabupaten, 
       ROUND(AVG(harga_tiket), 2) AS rata_rata, 
       MAX(harga_tiket) AS tertinggi, 
       MIN(harga_tiket) AS terendah 
FROM destinasi 
GROUP BY kabupaten 
ORDER BY rata_rata DESC;

-- 5e. Total peserta Lunas per wisatawan, 3 terbesar
SELECT w.nama, SUM(pm.jumlah_orang) AS total_peserta 
FROM pemesanan pm 
JOIN wisatawan w ON pm.id_wisatawan = w.id_wisatawan 
WHERE pm.status = 'Lunas' 
GROUP BY w.nama 
ORDER BY total_peserta DESC 
LIMIT 3;