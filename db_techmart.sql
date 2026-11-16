-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 01, 2026 at 07:12 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_techmart`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id_detail` int(10) NOT NULL,
  `jml` int(11) NOT NULL,
  `subtotal` bigint(20) NOT NULL,
  `id_transaksi` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`id_detail`, `jml`, `subtotal`, `id_transaksi`, `id_produk`) VALUES
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
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(10) NOT NULL,
  `nama_pelanggan` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `telepon` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`, `alamat`, `telepon`) VALUES
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
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(10) NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `harga` bigint(20) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `nama_produk`, `kategori`, `harga`, `stok`) VALUES
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
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(10) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `total_bayar` bigint(20) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `tanggal_transaksi`, `total_bayar`, `id_pelanggan`) VALUES
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
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT,
  `nama_lengkap` VARCHAR(255) NOT NULL,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; 


--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_pelanggan` (`id_pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id_detail` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE CASCADE,
  ADD CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
