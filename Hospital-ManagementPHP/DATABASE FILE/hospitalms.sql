create database hospital;
use hospital;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospitalms`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `your_procedure_name` (IN `p_email` VARCHAR(255), IN `p_spec` VARCHAR(255))   BEGIN
    DECLARE retrieved_password VARCHAR(50);

    -- Check if the provided information matches a doctor
    SELECT password INTO retrieved_password
    FROM doctb
    WHERE email = p_email
      AND spec = p_spec;

    IF retrieved_password IS NOT NULL THEN
        SELECT retrieved_password AS result; -- Or you can return the password directly
    ELSE
        SELECT 'Doctor not found or information is incorrect' AS result;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `RetrieveDoctorPasswordByEmailNameAndSpec` (`p_email` VARCHAR(50), `p_spec` VARCHAR(50)) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE retrieved_password VARCHAR(50);

    -- Check if the provided information matches a doctor
    SELECT password INTO retrieved_password
    FROM doctb
    WHERE email = p_email
      AND spec = p_spec;

    IF retrieved_password IS NOT NULL THEN
        RETURN retrieved_password;
    ELSE
        RETURN 'Doctor not found or information is incorrect';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `RetrieveForgottenPasswordByEmail` (`p_email` VARCHAR(50), `p_contact` VARCHAR(10)) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE retrieved_password VARCHAR(50);

    -- Check if the provided information matches a user
    SELECT password INTO retrieved_password
    FROM patreg
    WHERE email = p_email
      AND contact = p_contact;

    IF retrieved_password IS NOT NULL THEN
        RETURN retrieved_password;
    ELSE
        RETURN 'User not found or information is incorrect';
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admintb`
--

CREATE TABLE `admintb` (
  `username` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admintb`
--

INSERT INTO `admintb` (`username`, `password`) VALUES
('admin', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `appointmenttb`
--

CREATE TABLE `appointmenttb` (
  `pid` int(11) NOT NULL,
  `ID` int(11) NOT NULL,
  `fname` varchar(20) NOT NULL,
  `lname` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `doctor` varchar(30) NOT NULL,
  `docFees` int(5) NOT NULL,
  `appdate` date NOT NULL,
  `apptime` time NOT NULL,
  `userStatus` int(5) NOT NULL,
  `doctorStatus` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `appointmenttb`
--

INSERT INTO `appointmenttb` (`pid`, `ID`, `fname`, `lname`, `gender`, `email`, `contact`, `doctor`, `docFees`, `appdate`, `apptime`, `userStatus`, `doctorStatus`) VALUES
(12, 14, 'Liam', 'Moore', 'Male', 'liam@gmail.com', '7412225680', 'WillWilliams', 435, '2021-07-06', '10:00:00', 1, 1),
(1, 15, 'Curtis', 'Hicks', 'Male', 'curtis@gmail.com', '7410000010', 'ryan', 440, '2021-07-05', '14:00:00', 0, 1),
(1, 16, 'Curtis', 'Hicks', 'Male', 'curtis@gmail.com', '7410000010', 'ryan', 440, '2021-07-05', '10:00:00', 1, 1),
(11, 17, 'Kathryn', 'Anderson', 'Female', 'kathryn@gmail.com', '7850002580', 'lewis', 280, '2021-07-05', '10:00:00', 1, 1),
(13, 18, 'Brian', 'Rowe', 'Male', 'brian@gmail.com', '7012569999', 'Ralph', 450, '2021-07-06', '08:00:00', 1, 1),
(14, 19, 'chowdary', 'prajwal', 'Male', 'chowdary@gmail.com', '1234567890', 'WillWilliams', 435, '2023-11-21', '14:00:00', 0, 1),
(14, 20, 'chowdary', 'prajwal', 'Male', 'chowdary@gmail.com', '1234567890', 'yathu', 450, '2023-11-22', '12:00:00', 1, 1),
(14, 21, 'chowdary', 'prajwal', 'Male', 'chowdary@gmail.com', '1234567890', 'WillWilliams', 435, '2023-11-22', '08:00:00', 1, 1),
(15, 22, 'pranav', 'c', 'Male', 'pranav@gmail', '9999999999', 'WillWilliams', 435, '2023-11-21', '10:00:00', 1, 1),
(15, 23, 'pranav', 'c', 'Male', 'pranav@gmail', '9999999999', 'lewis', 280, '2023-11-21', '08:00:00', 1, 1),
(14, 24, 'chowdary', 'prajwal', 'Male', 'chowdary@gmail.com', '1234567890', 'WillWilliams', 435, '2023-11-22', '10:00:00', 1, 1),
(17, 25, 'chowdary', 'prajwal', 'Male', 'prajwal@gmail.com', '1234567890', 'praju', 250, '2023-11-24', '12:00:00', 1, 1),
(15, 26, 'pranav', 'c', 'Male', 'pranav@gmail', '9999999999', 'praju', 250, '2023-11-24', '10:00:00', 1, 1),
(17, 27, 'chowdary', 'prajwal', 'Male', 'prajwal@gmail.com', '1234567890', 'chris', 580, '2023-11-23', '12:00:00', 0, 1);

--
-- Triggers `appointmenttb`
--
DELIMITER $$
CREATE TRIGGER `prevent_duplicate_appointments` BEFORE INSERT ON `appointmenttb` FOR EACH ROW BEGIN
    DECLARE conflict_count INT;

    -- Check if there is an existing appointment for the same doctor at the same time and date
    SELECT COUNT(*) INTO conflict_count
    FROM appointmenttb
    WHERE doctor = NEW.doctor
    AND appdate = NEW.appdate
    AND apptime = NEW.apptime;

    -- If there is a conflict, prevent the new appointment from being inserted
    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment conflict: Another appointment already exists for the same doctor at the same time and date';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `name` varchar(30) NOT NULL,
  `email` text NOT NULL,
  `contact` varchar(10) NOT NULL,
  `message` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`name`, `email`, `contact`, `message`) VALUES
('Demo', 'demo@demail.com', '7014500000', 'this is a demo test'),
('pavan', 'endrulapavan@gmail.com', '9248304333', 'hi');

-- --------------------------------------------------------

--
-- Table structure for table `doctb`
--

CREATE TABLE `doctb` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `doctorname` varchar(255) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `spec` varchar(50) NOT NULL,
  `docFees` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `doctb`
--

INSERT INTO `doctb` (`username`, `password`, `doctorname`, `email`, `spec`, `docFees`) VALUES
('WillWilliams', 'password', 'Will Williams', 'williams@gmail.com', 'Cardiologist', 435),
('Ralph', 'password', 'Ralphn Bh', 'ralph@gmail.com', 'Neurologist', 450),
('ryan', 'password', 'Ryan Chandler', 'ryanc@gmail.com', 'Pediatrician', 440),
('lewis', 'password', 'Lou Lewis', 'lewis@gmail.com', 'Gynecologist', 280),
('chris', 'password', 'Chris Olivas', 'chris@gmail.com', 'Oncologist', 580),
('danial', 'password', 'Danial Rivera', 'danial@gmail.com', 'Neurologist', 210),
('yathu', 'yathu1234', 'yath', 'yathu@gmail.com', 'General', 450),
('praju', 'prajwal@123', 'prajwal', 'prajwal@gmail.com', 'Oncologist', 250);

-- --------------------------------------------------------

--
-- Table structure for table `patreg`
--

CREATE TABLE `patreg` (
  `pid` int(11) NOT NULL,
  `fname` varchar(20) NOT NULL,
  `lname` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `password` varchar(30) NOT NULL,
  `cpassword` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `patreg`
--

INSERT INTO `patreg` (`pid`, `fname`, `lname`, `gender`, `email`, `contact`, `password`, `cpassword`) VALUES
(1, 'Curtis', 'Hicks', 'Male', 'curtis@gmail.com', '7410000010', 'pass', 'pass'),
(2, 'Emily', 'Smith', 'Female', 'emily@gmail.com', '7896541222', 'pass', 'pass'),
(3, 'Robert', 'Ray', 'Male', 'robert@gmail.com', '7014744444', 'pass', 'pass'),
(4, 'Michael', 'Foster', 'Male', 'michael@gmail.com', '7023696969', 'pass', 'pass'),
(5, 'Victor', 'Owen', 'Male', 'victor@gmail.com', '7897895500', 'pass', 'pass'),
(6, 'Johnny', 'Collins', 'Male', 'johnny@gmail.com', '7530001250', 'pass', 'pass'),
(7, 'Elsie', 'Meads', 'Female', 'elsie@gmail.com', '7850001250', 'pass', 'pass'),
(8, 'David', 'Fburn', 'Male', 'david@gmail.com', '7301450000', 'pass', 'pass'),
(9, 'Brandon', 'Mckinnon', 'Male', 'brandon@gmail.com', '7026969500', 'pass', 'pass'),
(10, 'Tyler', 'Smith', 'Male', 'tyler@gmail.com', '7900145300', 'pass', 'pass'),
(11, 'Kathryn', 'Anderson', 'Female', 'kathryn@gmail.com', '7850002580', 'pass', 'pass'),
(12, 'Liam', 'Moore', 'Male', 'liam@gmail.com', '7412225680', 'password', 'password'),
(13, 'Brian', 'Rowe', 'Male', 'brian@gmail.com', '7012569999', 'password', 'password'),
(14, 'chowdary', 'prajwal', 'Male', 'chowdary@gmail.com', '1234567890', '123456', '123456'),
(15, 'pranav', 'c', 'Male', 'pranav@gmail', '9999999999', 'p@123456', 'p@123456'),
(16, 'prajwal ', 'chowdary', 'Male', 'chowdary@gmail.com', '1245968425', '123456', '123456'),
(17, 'chowdary', 'prajwal', 'Male', 'prajwal@gmail.com', '1234567890', '123456', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `prestb`
--

CREATE TABLE `prestb` (
  `doctor` varchar(50) NOT NULL,
  `pid` int(11) NOT NULL,
  `ID` int(11) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `appdate` date NOT NULL,
  `apptime` time NOT NULL,
  `disease` varchar(250) NOT NULL,
  `allergy` varchar(250) NOT NULL,
  `prescription` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `prestb`
--

INSERT INTO `prestb` (`doctor`, `pid`, `ID`, `fname`, `lname`, `appdate`, `apptime`, `disease`, `allergy`, `prescription`) VALUES
('WillWilliams', 12, 14, 'Liam', 'Moore', '2021-07-06', '10:00:00', 'Congenital heart disease', 'rhinoconjunctivitis', 'trandolapril (Mavik)'),
('ryan', 1, 16, 'Curtis', 'Hicks', '2021-07-05', '10:00:00', 'Tuberculosis', 'lumpy rash on the legs - or lupus vulgaris which gives lumps or ulcers', 'Isoniazid, Ethambutol (Myambutol), Linezolid (Zyvox)'),
('lewis', 11, 17, 'Kathryn', 'Anderson', '2021-07-05', '10:00:00', 'Ovarian cysts', '00000000', 'Narcotic analgesics and nonsteroidal anti-inflammatory drugs'),
('Ralph', 13, 18, 'Brian', 'Rowe', '2021-07-06', '08:00:00', 'Cerebral Aneurysm', '0000000', 'Nimodipine - empty stomach, at least 1 hour before a meal or 2 hours after a meal'),
('yathu', 14, 20, 'chowdary', 'prajwal', '2023-11-22', '12:00:00', 'fits', 'none', 'use keys'),
('praju', 17, 25, 'chowdary', 'prajwal', '2023-11-24', '12:00:00', 'viral fever', 'to dairy products', 'qwerty'),
('praju', 17, 25, 'chowdary', 'prajwal', '2023-11-24', '12:00:00', 'viral fever', 'dairy products', 'take dolo 650 \r\n\r\nand take rest for 2 weeks');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointmenttb`
--
ALTER TABLE `appointmenttb`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `patreg`
--
ALTER TABLE `patreg`
  ADD PRIMARY KEY (`pid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointmenttb`
--
ALTER TABLE `appointmenttb`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `patreg`
--
ALTER TABLE `patreg`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
