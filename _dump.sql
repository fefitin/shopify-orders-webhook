CREATE TABLE `shopify_orders` (
  `id` bigint(20) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `number` int(11) NOT NULL,
  `total` decimal(13,2) NOT NULL,
  `subtotal` decimal(13,2) NOT NULL,
  `tax` decimal(13,2) NOT NULL,
  `discounts` decimal(13,2) NOT NULL,
  `shipping` decimal(13,2) NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dni` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `shopify_orders`
  ADD PRIMARY KEY (`id`);