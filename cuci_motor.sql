-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 10, 2025 at 12:48 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cuci_motor`
--

-- --------------------------------------------------------

--
-- Table structure for table `kendaraan`
--

CREATE TABLE `kendaraan` (
  `id` int NOT NULL,
  `id_pelanggan` int DEFAULT NULL,
  `nama` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nomor_polisi` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kendaraan`
--

INSERT INTO `kendaraan` (`id`, `id_pelanggan`, `nama`, `nomor_polisi`) VALUES
(1, 1, 'Toyota Avanza', 'B1234XYZ'),
(2, 1, 'Honda Beat', 'B5678ABC'),
(3, 2, 'Daihatsu Xenia', 'B1122CCD'),
(4, 3, 'Yamaha NMAX', 'B7788EFD'),
(5, 4, 'Suzuki Ertiga', 'B4455ZZZ');

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id` int NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jabatan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id`, `nama`, `jabatan`) VALUES
(1, 'Andi', 'Kasir'),
(2, 'Budi', 'Pencuci'),
(3, 'Citra', 'Pencuci'),
(4, 'Dewi', 'Admin'),
(5, 'Eko', 'Pencuci');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telp` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `telp`) VALUES
(1, 'Rizky Pratama', '081234567890'),
(2, 'Siti Aisyah', '082233445566'),
(3, 'Agus Setiawan', '081122334455'),
(4, 'Dian Permata', '081398765432');

-- --------------------------------------------------------

--
-- Table structure for table `pencucian`
--

CREATE TABLE `pencucian` (
  `id` int NOT NULL,
  `jenis` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pencucian`
--

INSERT INTO `pencucian` (`id`, `jenis`, `harga`) VALUES
(1, 'Cuci Motor', 15000.00),
(2, 'Cuci Mobil Biasa', 30000.00),
(3, 'Cuci Mobil Lengkap', 45000.00),
(4, 'Cuci Mobil Cepat', 25000.00);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int NOT NULL,
  `tanggal_waktu` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_pelanggan` int DEFAULT NULL,
  `id_kendaraan` int DEFAULT NULL,
  `id_pencucian` int DEFAULT NULL,
  `id_pegawai` int DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `bayar` decimal(10,2) DEFAULT NULL,
  `kembali` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id`, `tanggal_waktu`, `id_pelanggan`, `id_kendaraan`, `id_pencucian`, `id_pegawai`, `total`, `bayar`, `kembali`) VALUES
(1, '2025-11-06 13:29:13', 1, 1, 2, 2, 30000.00, 50000.00, 20000.00),
(2, '2025-11-06 13:29:13', 1, 2, 1, 3, 15000.00, 20000.00, 5000.00),
(3, '2025-11-06 13:29:13', 2, 3, 3, 2, 45000.00, 50000.00, 5000.00),
(4, '2025-11-06 13:29:13', 3, 4, 1, 3, 15000.00, 20000.00, 5000.00),
(5, '2025-11-09 11:47:59', 4, 5, 4, 5, 25000.00, 30000.00, 5000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pencucian`
--
ALTER TABLE `pencucian`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kendaraan`
--
ALTER TABLE `kendaraan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pencucian`
--
ALTER TABLE `pencucian`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
