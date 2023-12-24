-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gostitelj: 127.0.0.1
-- Čas nastanka: 24. dec 2023 ob 16.32
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
(3, 1),
(3, 24871),
(4, 24871),
(11699, 24871),
(22303, 1),
(22303, 24871),
(22303, 69346),
(100410, 24871),
(100410, 136968),
(142833, 24871);

-- --------------------------------------------------------

--
-- Struktura tabele `shopping`
--

CREATE TABLE `shopping` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `todo_id` int(11) NOT NULL,
  `finished` tinyint(11) NOT NULL,
  `seznam` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_slovenian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Odloži podatke za tabelo `shopping`
--

INSERT INTO `shopping` (`id`, `owner`, `todo_id`, `finished`, `seznam`) VALUES
(1, 1, 30, 0, '242'),
(2, 1, 30, 0, 'ŠNOPC'),
(3, 1, 30, 0, 'VODKA'),
(4, 1, 30, 0, 'RUM'),
(5, 1, 30, 0, 'GIN'),
(6, 1, 33, 0, 'ŠPRIC'),
(7, 3, 31, 0, 'JABADABADU'),
(8, 3, 31, 0, 'jajca'),
(9, 3, 31, 0, 'bla'),
(10, 3, 31, 0, 'jeba'),
(11, 3, 38, 0, 'jaja'),
(12, 3, 33, 0, 'vinu'),
(13, 1, 33, 0, 'jajca'),
(14, 3, 33, 0, 'jajca sefe'),
(15, 1, 33, 0, 'snopc'),
(16, 1, 33, 0, 'supakÅ¾'),
(17, 142833, 31, 0, 'usa alko'),
(18, 142833, 41, 0, 'okno'),
(19, 142833, 41, 0, 'polica'),
(20, 142833, 41, 0, 'dez');

-- --------------------------------------------------------

--
-- Struktura tabele `spil`
--

CREATE TABLE `spil` (
  `id` int(11) NOT NULL,
  `id_pijanca` int(11) NOT NULL,
  `datum` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `seznam` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `zur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Odloži podatke za tabelo `spil`
--

INSERT INTO `spil` (`id`, `id_pijanca`, `datum`, `seznam`, `zur_id`) VALUES
(1, 1, '2023-11-20', 'slemer, marsal, skif', 31),
(2, 3, '0', 'pir', 31),
(3, 3, '0', 'scanje', 31),
(4, 3, '0', 'scanje3', 31),
(5, 3, '0', 'tset', 31),
(6, 3, '0', 'test', 31),
(7, 3, '0', 'test1', 31),
(8, 3, '0', 'test3', 31),
(9, 3, '0', 'koncno', 38),
(10, 1, '0', 'vinu', 33),
(11, 3, '0', 'kuhancek', 33),
(12, 142833, '0', 'pir', 31),
(13, 142833, '0', 'snopc', 31),
(14, 142833, '0', 'vinu', 31),
(15, 142833, '0', 'hruska 45', 41);

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
(31, 100410, 'Naberi jagode', 1, '2024-01-18T04:45', 24871),
(32, 2, 'buraz', 0, '2023-12-10T18:20', 1898),
(33, 2, 'Zdravje Martionm', 1, '2023-02-02T17:30', 1),
(34, 2, 'Danes je dan', 0, '2023-12-02T20:35', 1898),
(36, 2, 'Janezove norcije', 0, '2023-12-02T08:40', 1),
(38, 3, 'jaja', 1, '0', 24871),
(39, 3, 'jajca', 1, '2023-12-06T15:03', 24871),
(40, 3, 'jajcana kvadrat', 0, '2023-12-06T16:04', 24871),
(41, 142833, 'majstr na oknu', 0, '2023-12-14T16:41', 24871);

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
  `password` varchar(64) DEFAULT NULL,
  `gender` varchar(1) NOT NULL,
  `weight` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Odloži podatke za tabelo `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `gender`, `weight`) VALUES
(1, 'bruih', 'bruih@example.com', 'Geslo2023', 'M', 80),
(2, 'supak', 'supak@example.com', 'geslo', 'M', 60),
(3, 'šefe', 'šefe@example.com', 'g', 'M', 85),
(4, 'guest', 'none@mail.domain', 'guest', 'M', 90),
(11699, 'janez_selski', 'selski_janez@example.com', 'g', 'M', 55),
(22303, 'hejhoj', 'test@test.com', 'geslo', 'M', 82),
(100410, 'aghaha', 'matijakeber437@gmail.com', 'geslo', 'Z', 89),
(142833, 'majstr', 'majstr@gmail.com', 'g', 'M', 93);

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
  ADD KEY `owner` (`owner`,`todo_id`),
  ADD KEY `group_id` (`todo_id`);

--
-- Indeksi tabele `spil`
--
ALTER TABLE `spil`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pijanca` (`id_pijanca`),
  ADD KEY `todo_id` (`zur_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT tabele `spil`
--
ALTER TABLE `spil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT tabele `todo`
--
ALTER TABLE `todo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT tabele `todo_group`
--
ALTER TABLE `todo_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136969;

--
-- AUTO_INCREMENT tabele `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142834;

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
  ADD CONSTRAINT `shopping_ibfk_2` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `shopping_ibfk_3` FOREIGN KEY (`todo_id`) REFERENCES `todo` (`id`);

--
-- Omejitve za tabelo `spil`
--
ALTER TABLE `spil`
  ADD CONSTRAINT `spil_ibfk_1` FOREIGN KEY (`id_pijanca`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `spil_ibfk_2` FOREIGN KEY (`zur_id`) REFERENCES `todo` (`id`);

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
