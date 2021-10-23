-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 23, 2021 at 05:06 AM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.1.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Products`
--

-- --------------------------------------------------------

--
-- Table structure for table `Items`
--

CREATE TABLE `Items` (
  `Item_ID` int(255) NOT NULL,
  `Item_type` varchar(255) NOT NULL,
  `Item_price` float NOT NULL,
  `Weight` float NOT NULL,
  `Discount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Items`
--

INSERT INTO `Items` (`Item_ID`, `Item_type`, `Item_price`, `Weight`, `Discount`) VALUES
(1, 'Blouse', 100, 10, NULL),
(2, 'Jacket', 250, 250, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Offers`
--

CREATE TABLE `Offers` (
  `ID` int(11) NOT NULL,
  `Discount` double NOT NULL,
  `Item_ID` int(11) NOT NULL,
  `Count` int(11) DEFAULT NULL,
  `AppliedDiscount_ItemID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Offers`
--

INSERT INTO `Offers` (`ID`, `Discount`, `Item_ID`, `Count`, `AppliedDiscount_ItemID`) VALUES
(1, 50, 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Shipping_From`
--

CREATE TABLE `Shipping_From` (
  `ID` int(11) NOT NULL,
  `Country` varchar(25) NOT NULL,
  `Rate` int(11) NOT NULL,
  `Item_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Items`
--
ALTER TABLE `Items`
  ADD PRIMARY KEY (`Item_ID`);

--
-- Indexes for table `Offers`
--
ALTER TABLE `Offers`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Item_ID` (`Item_ID`),
  ADD KEY `AppliedDiscount_ItemID` (`AppliedDiscount_ItemID`);

--
-- Indexes for table `Shipping_From`
--
ALTER TABLE `Shipping_From`
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `Item_ID` (`Item_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Items`
--
ALTER TABLE `Items`
  MODIFY `Item_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Offers`
--
ALTER TABLE `Offers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Shipping_From`
--
ALTER TABLE `Shipping_From`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Offers`
--
ALTER TABLE `Offers`
  ADD CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`Item_ID`) REFERENCES `Items` (`Item_ID`),
  ADD CONSTRAINT `offers_ibfk_2` FOREIGN KEY (`AppliedDiscount_ItemID`) REFERENCES `Items` (`Item_ID`);

--
-- Constraints for table `Shipping_From`
--
ALTER TABLE `Shipping_From`
  ADD CONSTRAINT `shipping_from_ibfk_1` FOREIGN KEY (`Item_ID`) REFERENCES `Items` (`Item_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
