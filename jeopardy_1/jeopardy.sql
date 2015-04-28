-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 24, 2015 at 04:37 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `jeopardy`
--

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `users` varchar(30) NOT NULL,
  `passwords` varchar(30) NOT NULL,
  `login` int(10) NOT NULL,
  `intentos` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `clases` (
  `clase` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `categorias` (
  `categoria` varchar(30) NOT NULL,
  `clase` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `pistas` (
  `pista` varchar(100) NOT NULL,
  `respuesta` varchar(30) NOT NULL,
  `valor` int(10) NOT NULL,
  `categoria` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `juegos` (
  `juego` int(10) NOT NULL,
  `usuario` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `equipos` (
  `nombre` varchar(30) NOT NULL,
  `puntos` int(10) NOT NULL,
  `juego` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`users`, `passwords`, `login`, `intentos`) VALUES
('Pablo', 'pablo', '0', '0'),
('prueba1', '1111', '1', '0');

INSERT INTO `clases` (`clase`) VALUES
('Matematicas'),
('Fisica');

INSERT INTO `juegos` (`juego`,`usuario`) VALUES
(1, 'Pablo'),
(2, 'Pablo');

INSERT INTO `equipos` (`nombre`, `puntos`, `juego`) VALUES
('Los juanitos', 1000, 1),
('Los juanitos', 2000, 2),
('Los matadores', 500, 1),
('Los enanos', 3000, 1),
('Los hermanos', 4000, 1),
('Los matadores', 100000, 2);

INSERT INTO `categorias` (`categoria`, `clase`) VALUES
('Geometria', 'Matematicas'),
('Algebra', 'Matematicas'),
('Estatica', 'Fisica'),
('Fuerza', 'Fisica');

INSERT INTO `pistas` (`pista`, `respuesta`, `valor`, `categoria`) VALUES
('Esta suma de dos numeros iguales da 2', '¿Cuanto es 1+1?', '200', 'Algebra'),
('Esta suma de dos numeros iguales da 4', '¿Cuanto es 2+2?', '400', 'Algebra'),
('Esta suma de dos numeros iguales da 6', '¿Cuanto es 3+3?', '600', 'Algebra'),
('Esta suma de dos numeros iguales da 8', '¿Cuanto es 4+4?', '800', 'Algebra'),
('Esta suma de dos numeros iguales da 10', '¿Cuanto es 5+5?', '1000', 'Algebra');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
 ADD PRIMARY KEY (`users`);
 ALTER TABLE `clases`
 ADD PRIMARY KEY (`clase`);
 ALTER TABLE `categorias`
 ADD PRIMARY KEY (`categoria`);
 ALTER TABLE `pistas`
 ADD PRIMARY KEY (`pista`);
 ALTER TABLE `juegos`
 ADD PRIMARY KEY (`juego`);
ALTER TABLE `equipos`
 ADD PRIMARY KEY (`nombre`, `juego`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
