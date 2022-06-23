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
  
CREATE TABLE `shopify_orders_products` (
  `id` int(11) NOT NULL,
  `orderId` bigint(20) NOT NULL,
  `productId` bigint(20) NOT NULL,
  `variantId` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `quantity` smallint(6) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `price` decimal(13,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `shopify_orders_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`),
  ADD KEY `productId` (`productId`),
  ADD KEY `variantId` (`variantId`);

ALTER TABLE `shopify_orders_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `shopify_orders_products`
  ADD CONSTRAINT `shopify_orders_products_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `shopify_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;