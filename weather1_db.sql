-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 17, 2024 at 02:52 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `weather1_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `error`
--

CREATE TABLE `error` (
  `id` int(11) NOT NULL,
  `error_message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `error`
--

INSERT INTO `error` (`id`, `error_message`, `timestamp`) VALUES
(6, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:50:25'),
(7, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:50:26'),
(8, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:50:27'),
(9, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:50:27'),
(10, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:50:28'),
(11, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:50:29'),
(12, '\'city\'', '2024-06-13 20:55:13'),
(13, '\'city\'', '2024-06-13 20:55:14'),
(14, '\'city\'', '2024-06-13 20:55:16'),
(15, '\'city\'', '2024-06-13 20:55:16'),
(16, '\'city\'', '2024-06-13 20:55:17'),
(17, '\'city\'', '2024-06-13 20:55:18'),
(18, '\'city\'', '2024-06-13 20:55:22'),
(19, '\'city\'', '2024-06-13 20:55:22'),
(20, '\'city\'', '2024-06-13 20:55:23'),
(21, '\'city\'', '2024-06-13 20:55:25'),
(22, '\'city\'', '2024-06-13 20:55:26'),
(23, '\'city\'', '2024-06-13 20:55:27'),
(24, '\'city\'', '2024-06-13 20:55:28'),
(25, '\'city\'', '2024-06-13 20:55:29'),
(26, '\'city\'', '2024-06-13 20:55:30'),
(27, '\'city\'', '2024-06-13 20:55:35'),
(28, '\'city\'', '2024-06-13 20:55:36'),
(29, '\'city\'', '2024-06-13 20:55:38'),
(30, '\'city\'', '2024-06-13 20:55:39'),
(31, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:57:05'),
(32, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:57:06'),
(33, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:57:09'),
(34, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:57:10'),
(35, '(1054, \"Unknown column \'feels_like\' in \'field list\'\")', '2024-06-13 20:57:11'),
(36, '502 Server Error: Bad Gateway for url: https://api.openweathermap.org/data/2.5/weather?lat=-6.2352&lon=106.8178&appid=22b45438c064c52dee7e17bd34c64c0f&units=metric', '2024-06-14 01:30:25');

-- --------------------------------------------------------

--
-- Table structure for table `weather_data`
--

CREATE TABLE `weather_data` (
  `id` int(11) NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `wind_speed` float NOT NULL,
  `dew_point` float NOT NULL,
  `icon` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `weather_data`
--

INSERT INTO `weather_data` (`id`, `temperature`, `humidity`, `wind_speed`, `dew_point`, `icon`, `timestamp`) VALUES
(1003, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 00:59:18'),
(1004, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 00:59:19'),
(1005, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 00:59:33'),
(1006, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 00:59:34'),
(1007, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 01:02:04'),
(1008, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 01:02:05'),
(1009, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 01:02:26'),
(1010, 28.74, 78, 1.79, 24.34, '50d', '2024-06-14 01:02:27'),
(1011, 28.94, 77, 1.54, 24.34, '50d', '2024-06-14 01:08:23'),
(1012, 28.94, 77, 1.54, 24.34, '50d', '2024-06-14 01:08:24'),
(1013, 28.94, 77, 1.54, 24.34, '50d', '2024-06-14 01:08:29'),
(1014, 28.94, 77, 1.54, 24.34, '50d', '2024-06-14 01:08:31'),
(1015, 29.34, 76, 1.54, 24.54, '50d', '2024-06-14 01:19:34'),
(1016, 29.34, 76, 1.54, 24.54, '50d', '2024-06-14 01:19:35'),
(1017, 29.34, 76, 1.54, 24.54, '50d', '2024-06-14 01:19:40'),
(1018, 29.34, 76, 1.54, 24.54, '50d', '2024-06-14 01:19:41'),
(1019, 31.14, 66, 2.24, 24.34, '03d', '2024-06-14 01:30:32'),
(1020, 31.14, 66, 2.24, 24.34, '03d', '2024-06-14 01:30:37'),
(1021, 31.14, 66, 2.24, 24.34, '03d', '2024-06-14 01:30:38'),
(1022, 24.97, 100, 1.03, 24.97, '50d', '2024-06-17 00:22:20'),
(1023, 24.97, 100, 1.03, 24.97, '50d', '2024-06-17 00:22:22'),
(1024, 24.97, 100, 1.03, 24.97, '50d', '2024-06-17 00:22:32'),
(1025, 24.97, 100, 1.03, 24.97, '50d', '2024-06-17 00:22:34'),
(1026, 24.97, 100, 1.03, 24.97, '50d', '2024-06-17 00:23:32'),
(1027, 24.97, 100, 1.03, 24.97, '50d', '2024-06-17 00:23:34'),
(1028, 26.97, 94, 0.51, 25.77, '50d', '2024-06-17 00:36:03'),
(1029, 26.97, 94, 0.51, 25.77, '50d', '2024-06-17 00:36:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `error`
--
ALTER TABLE `error`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weather_data`
--
ALTER TABLE `weather_data`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `error`
--
ALTER TABLE `error`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `weather_data`
--
ALTER TABLE `weather_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1030;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
