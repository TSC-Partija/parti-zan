-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gostitelj: 127.0.0.1
-- Čas nastanka: 02. dec 2023 ob 15.52
-- Različica strežnika: 10.4.28-MariaDB
-- Različica PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Zbirka podatkov: `todolist`
--

-- --------------------------------------------------------

--
-- Struktura tabele `pripada`
--

CREATE TABLE `pripada` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Odloži podatke za tabelo `pripada`
--

INSERT INTO `pripada` (`user_id`, `group_id`) VALUES
(1, 1),
(1, 24870),
(1, 136968),
(2, 1),
(2, 1898),
(2, 24870),
(2, 69346),
(3, 24871),
(4, 24871),
(11699, 24871),
(22303, 1),
(22303, 24871),
(22303, 69346),
(100410, 24871),
(100410, 136968);

-- --------------------------------------------------------

--
-- Struktura tabele `shopping`
--

CREATE TABLE `shopping` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `finished` tinyint(11) NOT NULL,
  `deadline` varchar(64) NOT NULL,
  `seznam` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktura tabele `spil`
--

CREATE TABLE `spil` (
  `id` int(11) NOT NULL,
  `id_pijanca` int(11) NOT NULL,
  `datum` varchar(64) NOT NULL,
  `seznam` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Odloži podatke za tabelo `spil`
--

INSERT INTO `spil` (`id`, `id_pijanca`, `datum`, `seznam`) VALUES
(1, 1, '2023-11-20', 'slemer, marsal, skif');

-- --------------------------------------------------------

--
-- Struktura tabele `todo`
--

CREATE TABLE `todo` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `todo` varchar(64) NOT NULL,
  `finished` tinyint(1) NOT NULL,
  `deadline` varchar(64) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Odloži podatke za tabelo `todo`
--

INSERT INTO `todo` (`id`, `owner`, `todo`, `finished`, `deadline`, `group_id`) VALUES
(30, 2, 'TESTIS', 0, '2023-12-02T17:15', 1),
(31, 100410, 'Naberi jagode', 0, '2024-01-18T04:45', 24871),
(32, 2, 'buraz', 0, '2023-12-10T18:20', 1898),
(33, 2, 'Zdravje Martionm', 0, '2023-02-02T17:30', 1),
(34, 2, 'Danes je dan', 0, '2023-12-02T20:35', 1898),
(36, 2, 'Janezove norcije', 0, '2023-12-02T08:40', 1),
(37, 2, 'e', 0, '2023-12-02T15:14', 1);

-- --------------------------------------------------------

--
-- Struktura tabele `todo_group`
--

CREATE TABLE `todo_group` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Odloži podatke za tabelo `todo_group`
--

INSERT INTO `todo_group` (`id`, `owner`, `name`) VALUES
(1, 1, 'jabadabadu'),
(1898, 2, 'dupe'),
(24870, 1, 'testna skupina'),
(24871, 3, 'guest'),
(69346, 2, 'FRI VSŠ 2. letnik'),
(136968, 100410, 'st');

-- --------------------------------------------------------

--
-- Struktura tabele `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Odloži podatke za tabelo `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`) VALUES
(1, 'bruih', 'bruih@example.com', 'Geslo2023'),
(2, 'supak', 'supak@example.com', 'geslo'),
(3, 'šefe', 'šefe@example.com', 'g'),
(4, 'guest', 'none@mail.domain', 'guest'),
(11699, 'janez_selski', 'selski_janez@example.com', 'g'),
(22303, 'hejhoj', 'test@test.com', 'geslo'),
(100410, 'aghaha', 'matijakeber437@gmail.com', 'geslo');

--
-- Indeksi zavrženih tabel
--

--
-- Indeksi tabele `pripada`
--
ALTER TABLE `pripada`
  ADD KEY `user_id` (`user_id`,`group_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indeksi tabele `shopping`
--
ALTER TABLE `shopping`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`,`group_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indeksi tabele `spil`
--
ALTER TABLE `spil`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pijanca` (`id_pijanca`);

--
-- Indeksi tabele `todo`
--
ALTER TABLE `todo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `group_id` (`group_id`);

--
-- Indeksi tabele `todo_group`
--
ALTER TABLE `todo_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`);

--
-- Indeksi tabele `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT zavrženih tabel
--

--
-- AUTO_INCREMENT tabele `shopping`
--
ALTER TABLE `shopping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabele `spil`
--
ALTER TABLE `spil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT tabele `todo`
--
ALTER TABLE `todo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT tabele `todo_group`
--
ALTER TABLE `todo_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136969;

--
-- AUTO_INCREMENT tabele `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100411;

--
-- Omejitve tabel za povzetek stanja
--

--
-- Omejitve za tabelo `pripada`
--
ALTER TABLE `pripada`
  ADD CONSTRAINT `pripada_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `pripada_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `todo_group` (`id`);

--
-- Omejitve za tabelo `shopping`
--
ALTER TABLE `shopping`
  ADD CONSTRAINT `shopping_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `todo_group` (`id`),
  ADD CONSTRAINT `shopping_ibfk_2` FOREIGN KEY (`owner`) REFERENCES `user` (`id`);

--
-- Omejitve za tabelo `spil`
--
ALTER TABLE `spil`
  ADD CONSTRAINT `spil_ibfk_1` FOREIGN KEY (`id_pijanca`) REFERENCES `user` (`id`);

--
-- Omejitve za tabelo `todo`
--
ALTER TABLE `todo`
  ADD CONSTRAINT `todo_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `todo_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `todo_group` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
