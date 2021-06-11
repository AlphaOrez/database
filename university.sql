-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 25, 2018 at 06:49 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1



--
-- Database: `university`
--

-- --------------------------------------------------------

--
-- Table structure for table `student`
--


DROP DATABASE IF EXISTS university;
CREATE DATABASE IF NOT EXISTS university;
USE university;

CREATE TABLE `student` (
  `roll_no` varchar(10) NOT NULL,
  `st_name` varchar(30) NOT NULL,
  `f_name` varchar(30) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `contact` varchar(16) NOT NULL,
  `address` varchar(250) NOT NULL,
 ADD PRIMARY KEY (`roll_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`roll_no`, `st_name`, `f_name`, `gender`, `contact`, `address`) VALUES
('P19-6015', 'Ali Abbas Khan', 'Niaz Khan', 'Male', '03349174958', 'asdjflasdjfl'),
('P20-6005', 'abc', 'def', 'Male', '75675', 'hello');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `student`
--



CREATE TABLE courses( 
    `course_code` varchar(30) not null,
    `course_name` varchar(30) not null,
    `course_credits` varchar(30) not null);  


create table register(
`roll_no` varchar(10) NOT NULL,
`course_code` varchar(10) NOT NULL,
FOREIGN KEY (`roll_no`) REFERENCES student(`roll_no`),
FOREIGN KEY (`course_code`) REFERENCES avail_courses(`course_code`));

