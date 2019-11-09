-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2019 at 04:29 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `car_rental`
--
CREATE DATABASE IF NOT EXISTS `car_rental` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `car_rental`;

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

CREATE TABLE `car` (
  `VIN` int(20) NOT NULL,
  `GPS_location` int(50) DEFAULT NULL,
  `plate` int(8) DEFAULT NULL,
  `model` varchar(30) DEFAULT NULL,
  `year_of_prod` int(4) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `seats` int(2) DEFAULT NULL,
  `price` int(10) DEFAULT NULL,
  `fk_res_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`VIN`, `GPS_location`, `plate`, `model`, `year_of_prod`, `available`, `seats`, `price`, `fk_res_id`) VALUES
(111111111, 222221, 12345, 'Volkswagen Arteon', 2018, 1, 4, 200, 1),
(111111112, 222222, 12346, 'BMW X6', 2018, 1, 4, 200, 2),
(111111113, 222223, 12347, 'Bugatti Veyron', 2018, 1, 4, 200, 3);

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `company_id` int(30) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `zip_code` int(30) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `fk_VIN` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`company_id`, `name`, `address`, `city`, `zip_code`, `state`, `fk_VIN`) VALUES
(1, 'RAC LA', 'Main Street 30', 'Los Angeles', 1010, 'California', 111111111),
(2, 'RAC San Francisco', 'Main Street 10', 'San Francisco', 1020, 'California', 111111112);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `driver_license` int(10) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `zip_code` int(5) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `phone` int(10) DEFAULT NULL,
  `customer_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`driver_license`, `first_name`, `last_name`, `address`, `city`, `zip_code`, `state`, `phone`, `customer_id`) VALUES
(111111, 'Jack', 'Daniels', 'Main Street 55', 'Los Angeles', 1010, 'California', 12345678, 1),
(111112, 'Johnny', 'Walker', 'Main Street 56', 'San Francisco', 1020, 'California', 12345677, 2),
(111113, 'Jim', 'Beam', 'Main Street 57', 'Santa Monica', 1030, 'California', 12345676, 3);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `inv_num` int(20) NOT NULL,
  `inv_date` date DEFAULT NULL,
  `netto_amount` int(10) DEFAULT NULL,
  `tax_amount` int(10) DEFAULT NULL,
  `total_amount` int(10) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `fk_payment_id` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`inv_num`, `inv_date`, `netto_amount`, `tax_amount`, `total_amount`, `issue_date`, `fk_payment_id`) VALUES
(123456789, '2019-11-01', 200, 100, 300, '2019-11-01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(10) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `pay_amount` int(5) DEFAULT NULL,
  `credit_card` int(20) DEFAULT NULL,
  `credit_card_exp` date DEFAULT NULL,
  `credit_card_owner` varchar(50) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `fk_res_id` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `payment_date`, `pay_amount`, `credit_card`, `credit_card_exp`, `credit_card_owner`, `bank`, `fk_res_id`) VALUES
(1, '2019-11-01', 300, 2147483647, '2023-12-31', 'Jack Daniels', 'Bank of America', 1);

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `res_id` int(10) NOT NULL,
  `res_date` date DEFAULT NULL,
  `fk_customer_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`res_id`, `res_date`, `fk_customer_id`) VALUES
(1, '2019-11-01', 1),
(2, '2019-11-02', 2),
(3, '2019-11-03', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`VIN`),
  ADD KEY `fk_res_id` (`fk_res_id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_id`),
  ADD KEY `fk_VIN` (`fk_VIN`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`inv_num`),
  ADD KEY `fk_payment_id` (`fk_payment_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_res_id` (`fk_res_id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`res_id`),
  ADD KEY `fk_customer_id` (`fk_customer_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`fk_res_id`) REFERENCES `reservation` (`res_id`);

--
-- Constraints for table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`fk_VIN`) REFERENCES `car` (`VIN`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`fk_payment_id`) REFERENCES `payment` (`payment_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`fk_res_id`) REFERENCES `reservation` (`res_id`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`fk_customer_id`) REFERENCES `customer` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
