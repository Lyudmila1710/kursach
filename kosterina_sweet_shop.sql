-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Дек 16 2024 г., 08:01
-- Версия сервера: 10.11.10-MariaDB-ubu2204
-- Версия PHP: 8.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `kosterina_sweet_shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cart`
--

CREATE TABLE `cart` (
  `id_cart` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `cart`
--

INSERT INTO `cart` (`id_cart`, `user_id`, `product_id`, `count`, `order_id`) VALUES
(1, 1, 2, 4, 1),
(3, 1, 3, 4, 7),
(5, 6, 2, 1, NULL),
(6, 1, 1, 6, 8),
(7, 1, 2, 5, 8),
(8, 1, 3, 1, 8),
(9, 1, 3, 1, 9),
(10, 1, 1, 3, 9),
(11, 1, 1, 3, 10),
(12, 1, 1, 4, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `date_delivery` date NOT NULL,
  `payment` enum('наличными','банковской картой') NOT NULL DEFAULT 'банковской картой',
  `comments` text NOT NULL,
  `date_create` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id_order`, `phone`, `address`, `date_delivery`, `payment`, `comments`, `date_create`) VALUES
(1, '+78654323', 'sfefe', '2024-12-10', 'банковской картой', 'efefefe', '2024-12-11'),
(2, '+784343523', 'Оптиков 28', '2024-12-24', 'наличными', '1', '2024-12-12'),
(3, '+784343523', 'Оптиков 28', '2024-12-20', 'наличными', '1', '2024-12-12'),
(4, '+784343523', 'Оптиков 28', '2024-12-20', 'наличными', '1', '2024-12-12'),
(5, '+784343523', 'Оптиков 28', '2024-12-20', 'наличными', '1', '2024-12-12'),
(6, '+784343523', 'Оптиков 28', '2024-12-20', 'наличными', '1', '2024-12-12'),
(7, '+784343523', 'Оптиков 28', '2024-12-20', 'наличными', '1', '2024-12-12'),
(8, '+784343523', 'Оптиков 28', '2024-12-31', 'банковской картой', '1', '2024-12-12'),
(9, '+784343523', 'Оптиков 28', '2024-12-31', 'банковской картой', '1', '2024-12-12'),
(10, '+784343523', 'Оптиков 28', '2024-12-20', 'банковской картой', '', '2024-12-12');

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `id_product` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `cost` int(11) NOT NULL,
  `weight` float NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id_product`, `name`, `type_id`, `description`, `photo`, `cost`, `weight`, `created_at`) VALUES
(1, 'тортии', 2, 'Угощение для любителей изыска. Кокосовый бисквит с кусочками шоколада. Пропитан сливочным кремом с вареным сгущенным молоком. Покрыт белым ганашем, украшен шоколадным цветком.', '/lvovrv/rvrevrf', 2950, 1.25, '2024-12-05'),
(2, 'Тарт \"Черничная жемчужина\"', 1, 'Безумно вкусный', '/амум/', 3100, 1.6, '2024-12-05'),
(3, 'торт ‘Бельгийский шоколад’', 2, 'Угощение для любителей изыска. Кокосовый бисквит с кусочками шоколада. Пропитан сливочным кремом с вареным сгущенным молоком. Покрыт белым ганашем, украшен шоколадным цветком.', '/lvovrv/rvrevrf', 2950, 1.25, '2024-12-05'),
(4, 'Торт \"Клубничная фантазия\"', 2, 'Оочень много клубники', '16ebd985ba79e84ec3dfff17e1fedb251a7401656b158486de7b748b4c505e2c.jpg', 2000, 1.25, '2024-12-11'),
(5, 'Торт \"Клубничная фантазия\"', 2, 'Оочень много клубники', 'bd144d4b9250b5395989271bf922dc5efcc4f66c8ee2e180e1a29c96db47f8b5.jpg', 2000, 1, '2024-12-12');

-- --------------------------------------------------------

--
-- Структура таблицы `type`
--

CREATE TABLE `type` (
  `id_type` int(11) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `type`
--

INSERT INTO `type` (`id_type`, `name`) VALUES
(1, 'Тарт'),
(2, 'Торт');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `username` varchar(80) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(100) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `admin` enum('admin','user') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id_user`, `name`, `last_name`, `username`, `phone`, `email`, `password`, `token`, `admin`) VALUES
(1, 'Иван', 'Иванов', 'Ivan', '+78343523232', 'mila@mail.ru', '$2y$13$RW5ir9OW/0v7.tfBa6J2GeYPp1UvI.IsrANnxnUghTR.7BkXRpzKe', 'VftW_vkv9HTRpQ3zI137pVhlCWcInc_i', 'user'),
(2, 'Иван', 'Иванов', 'Ivan1', '+784342434', 'user@mail.ru', '$2y$13$ZK60uYncCwoPvNbi4CIBuOfmzHiAQs8/4bBdomXVytf9NMBSdIqSO', NULL, 'user'),
(3, 'Иван', 'Иванов', 'fsas', '+79001234567', 'user@mail.ru', '$2y$13$9qyxGPYAluz/5xAx2D4Z.ONMfoo0Xe4..Xt2P/QeTUxSau29LEE0.', NULL, 'user'),
(4, 'Иван', 'Иванов', 'fsas454', '+79001234567', 'user@mail.ru', '$2y$13$3HrqsUuXyr.ZzioOGZnAVOsGF9BF9cPzEi9yeXJQkEjtT1Ecydh2y', NULL, 'user'),
(5, 'Иван', 'Иванов', 'fsas-_*', '+79001234567', 'user@mail.ru', '$2y$13$L4Fy3ETsoQbFwc.nETGX7uRCsj5Hco02FH3Dm7Ntq337./qPyH1dy', NULL, 'user'),
(6, 'Людмила', 'Костерина', 'Lusi', '+78343523', 'mila@mail.ru', '$2y$13$TKo7sDKv.VsgJFuczGPcpe5i0Hdku99iLqTByEwDPeJsb3zg.Tlwm', NULL, 'user'),
(8, 'Людмила', 'Костерина', 'Lusik', '+78343523', 'mila@mail.ru', '$2y$13$xQ18xzb5Y4g0QogFxmXcOe7CGfz.KhhEAtaUkKVKFJFIQ4DRJaOUm', NULL, 'user'),
(10, 'Людмила', 'Костерина', 'admin', '+78343523', 'admin@mail.ru', '$2y$13$H5iUXntoBd/Es.6XmluWPemcc1w5jHkzFkeuUTWX2gMW1xd0ZQyD.', 'q_5V8R61IB4lSHA1TVU4KEJsSEFPMH1k', 'admin'),
(11, 'Людмила', 'Костерина', 'Lusikk', '+78343523', 'mila@mail.ru', '$2y$13$oL1ifpBHG3R4y3TjUXqzo.tUa28baNp1WGNeDUtS4tzry3d9jbglK', NULL, 'user');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id_cart`),
  ADD KEY `product_id` (`product_id`,`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_product`),
  ADD KEY `type_id` (`type_id`);

--
-- Индексы таблицы `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`id_type`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `cart`
--
ALTER TABLE `cart`
  MODIFY `id_cart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `type`
--
ALTER TABLE `type`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`id_product`),
  ADD CONSTRAINT `cart_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `cart_ibfk_5` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id_order`);

--
-- Ограничения внешнего ключа таблицы `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id_type`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
