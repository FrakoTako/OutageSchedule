-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Час створення: Трв 16 2023 р., 22:36
-- Версія сервера: 5.6.41
-- Версія PHP: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `outagescheduledb`
--

-- --------------------------------------------------------

--
-- Структура таблиці `dates`
--

CREATE TABLE `dates` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `dates`
--

INSERT INTO `dates` (`id`, `date`) VALUES
(1, '2023-02-01'),
(2, '2023-02-02'),
(3, '2023-02-03'),
(4, '2023-02-04'),
(5, '2023-02-05'),
(6, '2023-02-06'),
(7, '2023-02-07'),
(8, '2023-02-08'),
(9, '2023-02-09'),
(10, '2023-02-10'),
(11, '2023-02-11'),
(12, '2023-02-12'),
(13, '2023-02-13'),
(14, '2023-02-14'),
(15, '2023-02-15');

-- --------------------------------------------------------

--
-- Структура таблиці `power_outages`
--

CREATE TABLE `power_outages` (
  `id` int(11) NOT NULL,
  `id_queue` int(11) NOT NULL,
  `id_subqueue` int(11) NOT NULL,
  `id_date` int(11) NOT NULL,
  `on_time` varchar(255) NOT NULL,
  `off_time` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `power_outages`
--

INSERT INTO `power_outages` (`id`, `id_queue`, `id_subqueue`, `id_date`, `on_time`, `off_time`) VALUES
(1, 1, 1, 1, '0, 5, 12, 17', '2, 8, 14, 20'),
(2, 1, 2, 1, '0, 5, 12, 17', '2, 8, 14, 20'),
(3, 1, 3, 1, '0, 5, 11, 18, 23', '2, 8, 14, 20'),
(4, 1, 4, 1, '0, 5, 12, 17', '2, 8, 14, 20'),
(5, 2, 5, 1, '0, 5, 11, 17, 23', '2, 8, 13, 20'),
(6, 2, 6, 1, '0, 5, 11, 17, 23', '2, 8, 13, 20'),
(7, 2, 7, 1, '2, 8, 15, 20', '5, 11, 17, 22'),
(8, 2, 8, 1, '2, 8, 15, 20', '5, 11, 17, 22'),
(9, 3, 9, 1, '2, 5, 9, 14, 20', '0, 5, 11, 17, 23'),
(10, 3, 10, 1, '2, 5, 9, 14, 20', '0, 5, 11, 17, 23'),
(11, 3, 11, 1, '2, 8, 14, 21', '5, 10, 17, 22'),
(12, 3, 12, 1, '2, 8, 14, 21', '5, 10, 17, 22'),
(13, 4, 13, 1, '0, 12, 19', '9, 15'),
(14, 4, 14, 1, '0, 14, 21', '10, 17'),
(15, 4, 15, 1, '1, 13', '0, 9, 21');

-- --------------------------------------------------------

--
-- Структура таблиці `queues`
--

CREATE TABLE `queues` (
  `id` int(11) NOT NULL,
  `queue` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `queues`
--

INSERT INTO `queues` (`id`, `queue`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Структура таблиці `subqueues`
--

CREATE TABLE `subqueues` (
  `id` int(11) NOT NULL,
  `id_queue` int(11) NOT NULL,
  `subqueue` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `subqueues`
--

INSERT INTO `subqueues` (`id`, `id_queue`, `subqueue`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 2, 1),
(6, 2, 2),
(7, 2, 3),
(8, 2, 4),
(9, 3, 1),
(10, 3, 2),
(11, 3, 3),
(12, 3, 4),
(13, 4, 1),
(14, 4, 2),
(15, 4, 3);

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `dates`
--
ALTER TABLE `dates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `date` (`date`);

--
-- Індекси таблиці `power_outages`
--
ALTER TABLE `power_outages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_date_key` (`id_date`),
  ADD KEY `id_subqueue_key` (`id_subqueue`),
  ADD KEY `id_queue` (`id_queue`);

--
-- Індекси таблиці `queues`
--
ALTER TABLE `queues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `queue` (`queue`);

--
-- Індекси таблиці `subqueues`
--
ALTER TABLE `subqueues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_queue_key` (`id_queue`);

--
-- Обмеження зовнішнього ключа збережених таблиць
--

--
-- Обмеження зовнішнього ключа таблиці `power_outages`
--
ALTER TABLE `power_outages`
  ADD CONSTRAINT `id_date_key` FOREIGN KEY (`id_date`) REFERENCES `dates` (`id`),
  ADD CONSTRAINT `id_subqueue_key` FOREIGN KEY (`id_subqueue`) REFERENCES `subqueues` (`id`),
  ADD CONSTRAINT `power_outages_ibfk_1` FOREIGN KEY (`id_queue`) REFERENCES `queues` (`id`);

--
-- Обмеження зовнішнього ключа таблиці `subqueues`
--
ALTER TABLE `subqueues`
  ADD CONSTRAINT `id_queue_key` FOREIGN KEY (`id_queue`) REFERENCES `queues` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
