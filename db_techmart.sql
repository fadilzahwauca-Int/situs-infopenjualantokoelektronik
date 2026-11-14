-- SQLite SQL Dump (Konversi dari db_techmart MySQL)

SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION;

DROP TABLE IF EXISTS detail_transaksi;
DROP TABLE IF EXISTS transaksi;
DROP TABLE IF EXISTS produk;
DROP TABLE IF EXISTS pelanggan;
DROP TABLE IF EXISTS users;

-- --------------------------------------------------------

--
-- Struktur tabel untuk `detail_transaksi`
--
CREATE TABLE IF NOT EXISTS detail_transaksi (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    jml INT NOT NULL,
    subtotal BIGINT NOT NULL,
    id_transaksi INT,
    id_produk INT,
    FOREIGN KEY (id_transaksi) REFERENCES transaksi (id_transaksi) ON DELETE CASCADE,
    FOREIGN KEY (id_produk) REFERENCES produk (id_produk)
);

--
-- Dumping data untuk tabel `detail_transaksi`
--
INSERT INTO detail_transaksi (id_detail, jml, subtotal, id_transaksi, id_produk) VALUES
(1, 1, 15000000, 1, 1),
(2, 1, 250000, 1, 2),
(3, 1, 2500000, 2, 4),
(4, 1, 750000, 2, 6),
(5, 1, 8500000, 3, 10),
(6, 1, 1200000, 4, 5),
(7, 5, 750000, 4, 9),
(8, 1, 15000000, 5, 1),
(9, 1, 750000, 6, 3),
(10, 1, 2500000, 7, 4);

-- --------------------------------------------------------

--
-- Struktur tabel untuk `pelanggan`
--
CREATE TABLE IF NOT EXISTS pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan TEXT NOT NULL,
    alamat TEXT NOT NULL,
    telepon TEXT NOT NULL
);

--
-- Dumping data untuk tabel `pelanggan`
--
INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, alamat, telepon) VALUES
(1, 'Budi Santoso', 'Jl. Merdeka No. 10, Jakarta', '081234567890'),
(2, 'Siti Aminah', 'Jl. Sudirman No. 5, Bandung', '081234567891'),
(3, 'Andi Prasetyo', 'Jl. Diponegoro No. 22, Surabaya', '081234567892'),
(4, 'Tewy Lestari', 'Jl. Ahmad Yani No. 8, Yogyakarta', '081234567893'),
(5, 'Dimas Fauzan', 'Jl. Gatot Subroto No. 15, Semarang', '081234567894'),
(6, 'Rian Ardianto', 'Jl. Pahlawan No. 3, Medan', '081234567895'),
(7, 'Affan Faizan', 'Jl. Veteran No. 12, Malang', '081234567896'),
(8, 'Ari Wibowo', 'Jl. Kartini No. 7, Bogor', '081234567897'),
(9, 'Ahmad Junaidi', 'Jl. Kenanga No. 9, Denpasar', '081234567898'),
(10, 'Maya Indah', 'Jl. Mawar No. 4, Makassar', '081234567899');

-- --------------------------------------------------------

--
-- Struktur tabel untuk `produk`
--
CREATE TABLE IF NOT EXISTS produk (
    id_produk INT PRIMARY KEY AUTO_INCREMENT,
    nama_produk TEXT NOT NULL,
    kategori TEXT NOT NULL,
    harga BIGINT NOT NULL,
    stok INT NOT NULL
);

--
-- Dumping data untuk tabel `produk`
--
INSERT INTO produk (id_produk, nama_produk, kategori, harga, stok) VALUES
(1, 'Laptop ASUS ROG', 'Laptop', 15000000, 20),
(2, 'Mouse Logitech', 'Aksesoris', 250000, 50),
(3, 'Keyboard Mechanical', 'Aksesoris', 750000, 30),
(4, 'Monitor LG 24 inch', 'Monitor', 2500000, 15),
(5, 'SSD Samsung 1TB', 'Storage', 1200000, 40),
(6, 'Headset Razer', 'Audio', 950000, 25),
(7, 'Webcam Logitech', 'Aksesoris', 600000, 35),
(8, 'Router Xiaomi', 'Jaringan', 450000, 20),
(9, 'Flashdisk SanDisk 64GB', 'Storage', 150000, 100),
(10, 'Laptop Lenovo IdeaPad', 'Laptop', 8500000, 18);

-- --------------------------------------------------------

--
-- Struktur tabel untuk `transaksi`
--
CREATE TABLE IF NOT EXISTS transaksi (
    id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
    tanggal_transaksi TEXT NOT NULL,
    total_bayar BIGINT NOT NULL,
    id_pelanggan INT,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan) ON DELETE CASCADE
);

--
-- Dumping data untuk tabel `transaksi`
--
INSERT INTO transaksi (id_transaksi, tanggal_transaksi, total_bayar, id_pelanggan) VALUES
(1, '2023-10-01', 15250000, 1),
(2, '2023-10-02', 3250000, 2),
(3, '2023-10-05', 8500000, 3),
(4, '2023-10-08', 1950000, 4),
(5, '2023-10-10', 15000000, 5),
(6, '2023-10-12', 750000, 6),
(7, '2023-10-15', 2750000, 7),
(8, '2023-10-18', 1200000, 8),
(9, '2023-10-20', 9450000, 9),
(10, '2023-10-25', 600000, 10);

-- --------------------------------------------------------

--
-- Struktur tabel untuk `users`
--
CREATE TABLE IF NOT EXISTS users (
    id_user INT PRIMARY KEY AUTO_INCREMENT,
    nama_lengkap VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

SET FOREIGN_KEY_CHECKS = 1; 
COMMIT;