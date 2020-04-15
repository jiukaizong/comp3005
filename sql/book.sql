/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : rm-2ze70i9otha1pl7j8wo.mysql.rds.aliyuncs.com:3306
 Source Schema         : book

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 14/04/2020 11:29:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `id` int(50) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '书籍id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `photo` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '封面图片',
  `theme` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '体裁',
  `publisher_id` int(50) UNSIGNED NOT NULL COMMENT '出版商id',
  `pages` int(10) NOT NULL COMMENT '页数',
  `volume` int(5) NOT NULL COMMENT '销量',
  `price` double(10, 2) NOT NULL COMMENT '成本价格',
  `proportion` double(10, 2) NOT NULL COMMENT '提成比例',
  `display` int(1) NOT NULL COMMENT '显示标志',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `author_key`(`author`) USING BTREE,
  INDEX `publisher_key`(`publisher_id`) USING BTREE,
  CONSTRAINT `publisher_key` FOREIGN KEY (`publisher_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Book information table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_content
-- ----------------------------
DROP TABLE IF EXISTS `order_content`;
CREATE TABLE `order_content`  (
  `order_id` int(8) UNSIGNED NOT NULL COMMENT '所属订单号',
  `book_id` int(50) UNSIGNED NOT NULL COMMENT '书籍id',
  `store_id` int(50) UNSIGNED NOT NULL COMMENT '所属商家id',
  `book_number` int(5) UNSIGNED NOT NULL COMMENT '书籍数量',
  INDEX `order_key`(`order_id`) USING BTREE,
  INDEX `book_key`(`book_id`) USING BTREE,
  INDEX `store_key`(`store_id`) USING BTREE,
  CONSTRAINT `book_key` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `order_key` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `store_key` FOREIGN KEY (`store_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Order content table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(8) UNSIGNED NOT NULL COMMENT '订单号',
  `user_id` int(50) UNSIGNED NOT NULL COMMENT '所属用户id',
  `total_price` double(10, 2) NOT NULL COMMENT '总价',
  `receiving_address_id` int(50) UNSIGNED NULL DEFAULT NULL COMMENT '收货地址id',
  `shipping_address` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发货地址',
  `display` int(1) NOT NULL COMMENT '显示标志',
  `pay` int(1) NOT NULL COMMENT '付款标志',
  `courier_number` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '快递单号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `receiving_address_key`(`receiving_address_id`) USING BTREE,
  INDEX `user_key`(`user_id`) USING BTREE,
  CONSTRAINT `receiving_address_key` FOREIGN KEY (`receiving_address_id`) REFERENCES `receiving_address` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_key` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Order table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for receiving_address
-- ----------------------------
DROP TABLE IF EXISTS `receiving_address`;
CREATE TABLE `receiving_address`  (
  `id` int(50) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '收货地址id',
  `user_id` int(50) UNSIGNED NOT NULL COMMENT '所属用户id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人姓名',
  `phone` int(11) NOT NULL COMMENT '收货人电话',
  `address` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货地址',
  `display` int(1) NOT NULL COMMENT '显示标志',
  `_default` int(1) NOT NULL COMMENT '默认地址标志',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_key1`(`user_id`) USING BTREE,
  CONSTRAINT `user_key1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Receiving address table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `user_id` int(50) UNSIGNED NOT NULL COMMENT '用户id',
  `book_id` int(50) UNSIGNED NOT NULL COMMENT '书籍id',
  `store_id` int(50) UNSIGNED NOT NULL COMMENT '所属商家id',
  `book_number` int(5) NOT NULL COMMENT '书籍数量',
  `checked` int(1) NOT NULL COMMENT '选中标志',
  INDEX `book_key1`(`book_id`) USING BTREE,
  INDEX `user_key2`(`user_id`) USING BTREE,
  INDEX `store_key2`(`store_id`) USING BTREE,
  CONSTRAINT `book_key1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `store_key2` FOREIGN KEY (`store_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_key2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Shopping cart table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stack_room
-- ----------------------------
DROP TABLE IF EXISTS `stack_room`;
CREATE TABLE `stack_room`  (
  `book_id` int(50) NOT NULL COMMENT '书籍id',
  `store_id` int(50) UNSIGNED NOT NULL COMMENT '商家id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商家名字',
  `stock` int(5) NOT NULL COMMENT '库存',
  `price` double(10, 2) NOT NULL COMMENT '售价',
  `volume` int(5) NOT NULL COMMENT '销量',
  `remaining` int(5) NOT NULL COMMENT '余量',
  `revenue` double(10, 2) NOT NULL COMMENT '销售额',
  `display` int(1) NOT NULL COMMENT '显示标志',
  PRIMARY KEY (`book_id`, `store_id`) USING BTREE,
  INDEX `store_key4`(`store_id`) USING BTREE,
  CONSTRAINT `store_key4` FOREIGN KEY (`store_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Shop library table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(50) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `address` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '地址',
  `email` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '邮件地址',
  `phone` int(11) NULL DEFAULT NULL COMMENT '电话',
  `bank_account` bigint(19) NULL DEFAULT NULL COMMENT '银行账户',
  `expenditure` double(10, 2) NOT NULL COMMENT '支出额',
  `volume` double(10, 2) NOT NULL COMMENT '销售额',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `password` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号密码',
  `type` int(1) NOT NULL COMMENT '用户类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Table of users, merchants and publishers' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Procedure structure for addBook
-- ----------------------------
DROP PROCEDURE IF EXISTS `addBook`;
delimiter ;;
CREATE PROCEDURE `addBook`(IN `name` VARCHAR ( 255 ),
	IN author VARCHAR ( 255 ),
	IN theme VARCHAR ( 255 ),
	IN publisher_id INT ( 50 ),
	IN pages INT ( 10 ),
	IN proportion DOUBLE,
	IN price DOUBLE,
	IN photo LONGTEXT)
  COMMENT 'Publishing houses add books.'
BEGIN
	INSERT INTO books ( `name`, author,photo, theme, publisher_id, pages, volume,price, proportion , display)
	VALUES
		( `name`, author,photo, theme, publisher_id, pages, 0,price, proportion , 1);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for addOrder
-- ----------------------------
DROP PROCEDURE IF EXISTS `addOrder`;
delimiter ;;
CREATE PROCEDURE `addOrder`(IN type INT ( 1 ),
	IN order_id INT ( 15 ),
	IN user_id INT ( 50 ),
	IN receiving_address_id INT ( 50 ))
  COMMENT 'Generate order.'
BEGIN
	DECLARE
		m DOUBLE;
	INSERT INTO orders ( id, user_id, total_price, receiving_address_id, shipping_address, display, pay )
	VALUES
		( order_id, user_id, 0, receiving_address_id, 'BeiJing', 1, 0 );
	IF
		type = 2 THEN
			INSERT INTO order_content SELECT
			order_id,
			book_id,
			store_id,
			book_number 
		FROM
			shopping_cart 
		WHERE
			shopping_cart.user_id = user_id 
			AND shopping_cart.checked = 1;
		SELECT
			sum(stack_room.price * order_content.book_number) INTO m 
		FROM
			stack_room,
			order_content 
		WHERE
			stack_room.store_id = order_content.store_id 
			AND stack_room.book_id = order_content.book_id 
			AND order_content.order_id = order_id;
		UPDATE orders 
		SET total_price = total_price + m 
		WHERE
			orders.id = order_id;
		DELETE 
		FROM
			shopping_cart 
		WHERE
			shopping_cart.user_id = user_id 
			AND shopping_cart.checked = 1;
		
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for addOrderContent
-- ----------------------------
DROP PROCEDURE IF EXISTS `addOrderContent`;
delimiter ;;
CREATE PROCEDURE `addOrderContent`(IN order_id INT ( 15 ),
	IN book_id INT ( 50 ),
	IN store_id INT ( 50 ),
	IN book_number INT ( 5 ))
  COMMENT 'Add order content.'
BEGIN
	DECLARE m DOUBLE;
	INSERT INTO
	order_content(
	order_id,
	book_id,
	store_id,
	book_number
	)VALUES(
	order_id,
	book_id,
	store_id,
	book_number
	);
	SELECT sum(price*book_number) INTO m
	FROM stack_room
	WHERE stack_room.store_id = store_id AND stack_room.book_id =book_id; 
	UPDATE orders
	SET total_price = total_price + m
	WHERE orders.id = order_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for addReceivingAddress
-- ----------------------------
DROP PROCEDURE IF EXISTS `addReceivingAddress`;
delimiter ;;
CREATE PROCEDURE `addReceivingAddress`(IN user_id INT ( 50 ),
	IN `name` VARCHAR ( 255 ),
	IN phone INT ( 11 ),
	IN address LONGTEXT,
	IN _default INT ( 1 ))
  COMMENT 'Add receiving address.'
BEGIN
	DECLARE
		judge INT;
	SELECT
		count( * ) INTO judge 
	FROM
		receiving_address 
	WHERE
		receiving_address.user_id = user_id AND display = 1;
	IF
		judge = 0 THEN
			INSERT INTO receiving_address ( user_id, `name`, phone, address, display, _default )
		VALUES
			( user_id, `name`, phone, address, 1, 1 );
		ELSE INSERT INTO receiving_address ( user_id, `name`, phone, address, display, _default )
		VALUES
			( user_id, `name`, phone, address, 1, _default );
		IF
			_default = 1 THEN
				UPDATE receiving_address 
				SET _default = 0 
			WHERE
				receiving_address.user_id = user_id 
				AND receiving_address.id != LAST_INSERT_ID( );	
		END IF;
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for addToCart
-- ----------------------------
DROP PROCEDURE IF EXISTS `addToCart`;
delimiter ;;
CREATE PROCEDURE `addToCart`(IN user_id INT ( 50 ),
	IN book_id INT ( 50 ),
	IN store_id INT ( 50 ),
	IN number INT ( 5 ))
  COMMENT 'Add to cart.'
BEGIN
	DECLARE
		judge INT;
	SELECT
		COUNT( * ) INTO judge 
	FROM
		shopping_cart 
	WHERE
		shopping_cart.book_id = book_id 
		AND shopping_cart.store_id = store_id 
		AND shopping_cart.user_id = user_id;
	IF
		judge = 0 THEN
			INSERT INTO shopping_cart ( user_id, book_id, store_id, book_number ,checked)
		VALUES
			( user_id, book_id, store_id, number ,1);
		ELSE UPDATE shopping_cart 
		SET book_number = book_number + number 
		WHERE
			shopping_cart.book_id = book_id 
			AND shopping_cart.store_id = store_id 
			AND shopping_cart.user_id = user_id;
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cancelOrder
-- ----------------------------
DROP PROCEDURE IF EXISTS `cancelOrder`;
delimiter ;;
CREATE PROCEDURE `cancelOrder`(IN order_id INT(15))
  COMMENT 'Delete/Cancel order.'
BEGIN
	UPDATE orders
	SET display = 0
	WHERE orders.id = order_id AND orders.display = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ChangePassword
-- ----------------------------
DROP PROCEDURE IF EXISTS `ChangePassword`;
delimiter ;;
CREATE PROCEDURE `ChangePassword`(IN id INT(50),
IN oldPwd LONGTEXT,
IN newPwd LONGTEXT)
  COMMENT 'Change Password.'
BEGIN
	DECLARE
		judge INT;
	DECLARE
		statusNum INT;
	SELECT
		- 1 INTO statusNum;
	SELECT
		COUNT( * ) INTO judge 
	FROM
		users 
	WHERE
		users.id = id AND users.`password` = MD5(oldPwd);
	IF 
		judge = 1 THEN
			UPDATE users
			SET `password` = MD5(newPwd)
			WHERE users.id = id;
			SELECT 1
					INTO statusNum;
	END IF;
	SELECT statusNum AS statusNum;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for checkAccount
-- ----------------------------
DROP PROCEDURE IF EXISTS `checkAccount`;
delimiter ;;
CREATE PROCEDURE `checkAccount`(IN account VARCHAR ( 255 ))
  COMMENT 'Check whether the account number is duplicate.'
BEGIN
	DECLARE
		judge INT;
	DECLARE
		statusNum INT;
	SELECT
		- 1 INTO statusNum;
	SELECT
		COUNT( * ) INTO judge 
	FROM
		users 
	WHERE
		users.account = account;
	IF
		judge = 0 THEN
		SELECT
			1 INTO statusNum;
		
	END IF;
	SELECT
		statusNum AS statusNum;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteBook
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteBook`;
delimiter ;;
CREATE PROCEDURE `deleteBook`(IN id INT(50))
  COMMENT 'Publisher delete book.'
BEGIN
	UPDATE books,stack_room
	SET books.display = 0
	WHERE books.id = id AND books.display = 1
	AND stack_room.display = 1
	AND stack_room.book_id = id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteFromCart
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteFromCart`;
delimiter ;;
CREATE PROCEDURE `deleteFromCart`(IN user_id INT ( 50 ),
	IN book_id INT ( 50 ),
	IN store_id INT ( 50 ))
  COMMENT 'Remove from cart.'
BEGIN
	DELETE FROM shopping_cart
	WHERE shopping_cart.book_id = book_id AND
	shopping_cart.user_id = user_id AND
	shopping_cart.store_id = store_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteReceivingAddress
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteReceivingAddress`;
delimiter ;;
CREATE PROCEDURE `deleteReceivingAddress`(IN id INT ( 50 ))
  COMMENT 'Delete ship to address.'
BEGIN
	DECLARE
		judge INT;
	SELECT
		_default INTO judge 
	FROM
		receiving_address 
	WHERE
		receiving_address.id = id;
	UPDATE receiving_address 
	SET display = 0,
	_default = 0
	WHERE
		receiving_address.id = id 
		AND display = 1;
	IF
		judge = 1 THEN
		
		SELECT user_id into judge from receiving_address
			WHERE receiving_address.id = id;
			UPDATE receiving_address 
			SET receiving_address._default = 1
		WHERE
			receiving_address.display = 1
			AND receiving_address.user_id = judge
			LIMIT 1;
		
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for exportBook
-- ----------------------------
DROP PROCEDURE IF EXISTS `exportBook`;
delimiter ;;
CREATE PROCEDURE `exportBook`(IN book_id INT ( 50 ), IN store_id INT ( 50 ))
  COMMENT 'Merchants delete books.'
BEGIN
	UPDATE stack_room 
	SET display = 0 
	WHERE
		book_id = book_id 
		AND store_id = store_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getBook
-- ----------------------------
DROP PROCEDURE IF EXISTS `getBook`;
delimiter ;;
CREATE PROCEDURE `getBook`(IN id INT(50))
  COMMENT 'Get single book information.'
BEGIN
	SELECT
			books.id AS id,
			books.name AS `name`,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			price AS price,
			users.`name` AS press,
			books.volume AS volume,
			proportion AS proportion
		FROM
			books,users
		WHERE
			books.publisher_id = users.id AND books.display = 1 AND books.id = id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getBookListAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `getBookListAll`;
delimiter ;;
CREATE PROCEDURE `getBookListAll`()
  COMMENT 'Get a list of all books.'
BEGIN
	SELECT
			books.id AS id,
			books.name AS `name`,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			users.`name` AS press,
			books.volume AS volume,
			proportion AS proportion,
			price AS price
		FROM
			books,users
		WHERE
			books.publisher_id = users.id AND display = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getBookListByPress
-- ----------------------------
DROP PROCEDURE IF EXISTS `getBookListByPress`;
delimiter ;;
CREATE PROCEDURE `getBookListByPress`(IN id INT(50))
  COMMENT 'Get the list of books according to the publishing house.'
BEGIN
	SELECT
			id AS id,
			`name` AS `name`,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			volume AS volume,
			proportion AS proportion,
			price AS price
		FROM
			books
		WHERE
			books.publisher_id = id AND display = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getBookListByStore
-- ----------------------------
DROP PROCEDURE IF EXISTS `getBookListByStore`;
delimiter ;;
CREATE PROCEDURE `getBookListByStore`(IN store_id INT(50),
IN start_subscript INT,
IN pageSize INT)
  COMMENT 'Get the list of books according to the store.'
BEGIN
	SELECT
			books.id AS id,
			books.name AS `name`,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			users.`name` AS press,
			books.volume AS volume,
			proportion AS proportion,
			stack_room.price AS price,
			stock AS stock
		FROM
			books,users,stack_room
		WHERE
			books.publisher_id = users.id AND books.display = 1 AND  stack_room.store_id = store_id AND stack_room.display = 1
			AND stack_room.book_id = books.id
		LIMIT start_subscript,pageSize;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getBooksOnSale
-- ----------------------------
DROP PROCEDURE IF EXISTS `getBooksOnSale`;
delimiter ;;
CREATE PROCEDURE `getBooksOnSale`(IN start_subscript INT,
IN pageSize INT)
  COMMENT 'Get a list of all books on sale in all stores.'
BEGIN
	SELECT books.id AS id,
			books.name AS `name`,
			stack_room.store_id AS store_id,
			stack_room.name AS store,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			users.`name` AS press,
			books.volume AS volume,
			stack_room.price AS price,
			stack_room.stock AS stock
			FROM stack_room,users,books
			WHERE stack_room.book_id = books.id
			AND books.display = 1
			AND books.publisher_id = users.id
			AND stack_room.display = 1
			LIMIT start_subscript,pageSize;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getCartBooks
-- ----------------------------
DROP PROCEDURE IF EXISTS `getCartBooks`;
delimiter ;;
CREATE PROCEDURE `getCartBooks`(IN user_id INT(50),
IN store_id INT(50))
  COMMENT 'Get shopping cart books from each store.'
BEGIN
	SELECT 
			books.id AS id,
			books.name AS `name`,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			users.`name` AS press,
			books.volume AS volume,
			proportion AS proportion,
			stack_room.price AS price,
			checked AS checked,
			store_id AS store_id,
			shopping_cart.book_number AS book_number
	FROM books,users,shopping_cart,stack_room
	WHERE
			books.publisher_id = users.id AND books.id = shopping_cart.book_id AND books.display = 1 
			AND shopping_cart.store_id = store_id AND shopping_cart.user_id = user_id
			AND stack_room.store_id = store_id AND stack_room.book_id = books.id AND stack_room.display = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getCartCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `getCartCount`;
delimiter ;;
CREATE PROCEDURE `getCartCount`(IN user_id INT ( 50 ))
  COMMENT 'Get the total number of shopping cart items.'
BEGIN
	IF
		( SELECT COUNT( * ) FROM shopping_cart WHERE shopping_cart.user_id = user_id ) = 0 THEN
		SELECT
			0 AS total_count;
		ELSE SELECT
			SUM( shopping_cart.book_number ) AS total_count 
		FROM
			shopping_cart,
			stack_room 
		WHERE
			shopping_cart.user_id = user_id 
			AND shopping_cart.book_id = stack_room.book_id 
			AND shopping_cart.store_id = stack_room.store_id;
		
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getCartInfo
-- ----------------------------
DROP PROCEDURE IF EXISTS `getCartInfo`;
delimiter ;;
CREATE PROCEDURE `getCartInfo`(IN user_id INT(50))
  COMMENT 'Get shopping cart statistics.'
BEGIN
IF
		( SELECT COUNT( * ) FROM shopping_cart WHERE shopping_cart.user_id = user_id ) = 0 THEN
		SELECT
			0 AS total_count,
			0 AS total_price;
		ELSE
	SELECT sum(shopping_cart.book_number) AS total_count,
		sum(price*book_number) AS total_price
		FROM shopping_cart,stack_room
		WHERE shopping_cart.user_id = user_id AND shopping_cart.book_id = stack_room.book_id
		AND shopping_cart.store_id = stack_room.store_id
		AND shopping_cart.checked = 1;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getCartStores
-- ----------------------------
DROP PROCEDURE IF EXISTS `getCartStores`;
delimiter ;;
CREATE PROCEDURE `getCartStores`(IN user_id INT(50))
  COMMENT 'Get the list of stores contained in the shopping cart.'
BEGIN
	SELECT DISTINCT store_id AS store_id,
	`name` AS `name`
	FROM shopping_cart,users
	WHERE  shopping_cart.user_id = user_id AND shopping_cart.store_id = users.id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getOrder
-- ----------------------------
DROP PROCEDURE IF EXISTS `getOrder`;
delimiter ;;
CREATE PROCEDURE `getOrder`(IN order_id INT(15))
  COMMENT 'Get the main information of the order.'
BEGIN
	#Routine body goes here...
	DECLARE total_count INT;
	SELECT count(*) INTO total_count
	FROM order_content
	WHERE order_content.order_id = order_id;
	SELECT id AS id,
	total_count AS total_count,
	receiving_address_id AS receiving_address_id,
	shipping_address AS shipping_address,
	pay AS pay,
	courier_number AS courier_number,
	total_price AS total_price
	FROM orders
	WHERE orders.id = order_id AND orders.display = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getOrderBooks
-- ----------------------------
DROP PROCEDURE IF EXISTS `getOrderBooks`;
delimiter ;;
CREATE PROCEDURE `getOrderBooks`(IN order_id INT(15),
IN store_id INT(50))
  COMMENT 'Get order books from each store.'
BEGIN
	SELECT 
			books.id AS id,
			books.name AS `name`,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			users.`name` AS press,
			books.volume AS volume,
			proportion AS proportion,
			stack_room.price AS price,
			order_content.book_number AS book_number
	FROM books,stack_room,users,order_content
	WHERE
			books.id = stack_room.book_id AND books.publisher_id = users.id AND stack_room.store_id =store_id  
			AND order_content.store_id = store_id AND order_content.order_id = order_id AND order_content.book_id = books.id ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getOrderFirstBook
-- ----------------------------
DROP PROCEDURE IF EXISTS `getOrderFirstBook`;
delimiter ;;
CREATE PROCEDURE `getOrderFirstBook`(IN order_id INT(15))
  COMMENT 'Get information about the first book in the order.'
BEGIN
	SELECT
			store_id AS store_id,
			books.id AS id,
			books.name AS `name`,
			author AS author,
			photo AS photo,
			theme AS theme,
			pages AS pages,
			users.`name` AS press,
			books.volume AS volume
		FROM
			books,users,order_content
		WHERE
			books.publisher_id = users.id AND books.display = 1 AND books.id in (SELECT
			book_id FROM order_content
			WHERE order_content.order_id = order_id)LIMIT 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getOrderPaid
-- ----------------------------
DROP PROCEDURE IF EXISTS `getOrderPaid`;
delimiter ;;
CREATE PROCEDURE `getOrderPaid`(IN user_id INT ( 50 ), IN start_subscript INT, IN pageSize INT)
  COMMENT 'Get paid order list.'
BEGIN
	SELECT
		id AS id,
		total_price AS total_price,
		courier_number AS courier_number,
		T.total_count AS total_count 
	FROM
		orders,
		(SELECT order_id,sum(book_number) AS total_count
	FROM 	order_content GROUP BY order_id) AS T
	WHERE
		orders.user_id = user_id 
		AND orders.pay = 1 
		AND orders.display = 1 
		AND orders.id = T.order_id 
		LIMIT start_subscript,
		pageSize;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getOrderStores
-- ----------------------------
DROP PROCEDURE IF EXISTS `getOrderStores`;
delimiter ;;
CREATE PROCEDURE `getOrderStores`(IN order_id INT(15))
  COMMENT 'Get the list of stores contained in the order.'
BEGIN
	SELECT DISTINCT store_id AS store_id,
	`name` AS `name`
	FROM order_content,users
	WHERE order_content.store_id = users.id AND order_content.order_id = order_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getOrderToBePaid
-- ----------------------------
DROP PROCEDURE IF EXISTS `getOrderToBePaid`;
delimiter ;;
CREATE PROCEDURE `getOrderToBePaid`(IN user_id INT(50),
IN start_subscript INT,
IN pageSize INT)
  COMMENT 'Get order list to be paid.'
BEGIN
	SELECT id AS id,
	total_price AS total_price,
	T.total_count AS total_count
	FROM orders,(SELECT order_id,sum(book_number) AS total_count
	FROM 	order_content GROUP BY order_id) AS T
	WHERE orders.user_id = user_id AND pay = 0 AND display = 1
	AND orders.id = T.order_id
	LIMIT start_subscript,pageSize;
	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getReceivingAddress
-- ----------------------------
DROP PROCEDURE IF EXISTS `getReceivingAddress`;
delimiter ;;
CREATE PROCEDURE `getReceivingAddress`(IN user_id INT ( 50 ), IN start_subscript INT, IN pageSize INT)
  COMMENT 'Get shipping address list.'
BEGIN
	SELECT
		id AS id,
		`name` AS `name`,
		phone AS phone,
		address AS address,
		_default AS _default 
	FROM
		receiving_address 
	WHERE
		receiving_address.user_id = user_id 
		AND display = 1 
		AND _default = 1 UNION
	SELECT
		id AS id,
		`name` AS `name`,
		phone AS phone,
		address AS address,
		_default AS _default 
	FROM
		receiving_address 
	WHERE
		receiving_address.user_id = user_id 
		AND display = 1 
		AND _default = 0 
		LIMIT start_subscript,
		pageSize;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getReceivingAddressById
-- ----------------------------
DROP PROCEDURE IF EXISTS `getReceivingAddressById`;
delimiter ;;
CREATE PROCEDURE `getReceivingAddressById`(IN id INT ( 50 ))
  COMMENT 'Get single ship to address information.'
BEGIN
	SELECT
		id AS id,
		`name` AS `name`,
		phone AS phone,
		address AS address,
		_default AS _default 
	FROM
		receiving_address 
	WHERE
		receiving_address.id = id 
		AND display = 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getStatistics
-- ----------------------------
DROP PROCEDURE IF EXISTS `getStatistics`;
delimiter ;;
CREATE PROCEDURE `getStatistics`(IN store_id INT)
  COMMENT 'Get store revenue and expenditure statistics.'
BEGIN
	SELECT users.volume AS income,
	users.expenditure AS expenditure
	FROM users
	WHERE users.id = store_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getStatisticsByAuthor
-- ----------------------------
DROP PROCEDURE IF EXISTS `getStatisticsByAuthor`;
delimiter ;;
CREATE PROCEDURE `getStatisticsByAuthor`(IN store_id INT)
  COMMENT 'Get book sales statistics based on the author.'
BEGIN
	SELECT books.author AS author,sum(stack_room.volume) AS volume
	FROM books,stack_room
	WHERE books.id = stack_room.book_id
	AND stack_room.store_id = store_id
	GROUP BY books.author;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getStatisticsByTheme
-- ----------------------------
DROP PROCEDURE IF EXISTS `getStatisticsByTheme`;
delimiter ;;
CREATE PROCEDURE `getStatisticsByTheme`(IN store_id INT)
  COMMENT 'Get book sales statistics based on the theme.'
BEGIN
	SELECT books.theme AS theme,sum(stack_room.volume) AS volume
	FROM books,stack_room
	WHERE books.id = stack_room.book_id
	AND stack_room.store_id = store_id
	GROUP BY books.theme;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `getUser`;
delimiter ;;
CREATE PROCEDURE `getUser`(IN id INT ( 50 ))
  COMMENT 'Get user information according to ID.'
BEGIN
		SELECT
			id AS id,
			`name` AS `name`,
			account AS account,
			address AS address,
			phone AS phone,
			bank_account AS bank_account,
			email AS email,
			type AS type
		FROM
			users
		WHERE
			users.id = id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for getUserList
-- ----------------------------
DROP PROCEDURE IF EXISTS `getUserList`;
delimiter ;;
CREATE PROCEDURE `getUserList`(IN type INT(1),
IN start_subscript INT,
IN pageSize INT)
  COMMENT 'Get user list according to user type.'
BEGIN
	SELECT
			id AS id,
			`name` AS `name`,
			account AS account,
			address AS address,
			phone AS phone,
			bank_account AS bank_account,
			email AS email,
			type AS type
		FROM
			users
		WHERE
			users.type = type
		LIMIT start_subscript,pageSize;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for importBook
-- ----------------------------
DROP PROCEDURE IF EXISTS `importBook`;
delimiter ;;
CREATE PROCEDURE `importBook`(IN book_id INT ( 50 ), IN store_id INT ( 50 ), IN number INT ( 5 ), IN price DOUBLE)
  COMMENT 'Stores import books from publishers.'
BEGIN
	DECLARE
		judge INT;
	DECLARE
		statusNum INT;
	DECLARE
		nm VARCHAR(255);
	SELECT
		- 1 INTO statusNum;
	SELECT
		COUNT( * ) INTO judge 
	FROM
		stack_room 
	WHERE
		stack_room.book_id = book_id 
		AND stack_room.store_id = store_id;
	SELECT
		`name` INTO nm
	FROM 
		users
	WHERE 
		users.id = store_id;
	IF
		judge = 0 THEN
			INSERT INTO stack_room ( book_id, store_id, `name`,stock, price, volume,remaining, revenue, display )
		VALUES
			( book_id, store_id,nm, number, price, 0,number, 0, 1 );
			
			UPDATE books,users
			SET books.volume = books.volume + number,
			users.volume = users.volume+books.price*number
			WHERE books.id = book_id
			AND books.publisher_id = users.id;
			
			UPDATE users,books
			SET users.expenditure = users.expenditure+books.price*number
			WHERE users.id = store_id;
		SELECT
			1 INTO statusNum;
		ELSE SELECT
			display INTO judge 
		FROM
			stack_room 
		WHERE
			stack_room.book_id = book_id 
			AND stack_room.store_id = store_id;
		IF
			judge = 0 THEN
				UPDATE stack_room 
				SET display = 1, 
				stock = number,
				price = price,
				volume = 0,
				revenue = 0
			WHERE
				stack_room.book_id = book_id 
				AND stack_room.store_id = store_id;
				UPDATE books
			SET volume = volume + stock
			WHERE books.id = book_id;
			SELECT
				1 INTO statusNum;
			
		END IF;
		
	END IF;
	SELECT
		statusNum AS statusNum;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Login
-- ----------------------------
DROP PROCEDURE IF EXISTS `Login`;
delimiter ;;
CREATE PROCEDURE `Login`(IN account VARCHAR ( 255 ), IN pwd LONGTEXT)
  COMMENT 'User login.'
BEGIN
	
		SELECT
			id AS id,
			`name` AS `name` ,
			account AS account,
			type AS type
		FROM
			users 
		WHERE
			users.account = account 
			AND users.`password` = MD5( pwd );	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for payForOrder
-- ----------------------------
DROP PROCEDURE IF EXISTS `payForOrder`;
delimiter ;;
CREATE PROCEDURE `payForOrder`(IN order_id INT(15))
  COMMENT 'Payment user\'s order.'
BEGIN
	UPDATE orders
	SET pay = 1,
	courier_number = CEILING(RAND()*90000000+10000000)
	WHERE orders.id = order_id AND pay = 0;
	
	UPDATE books,(SELECT book_id,sum(book_number) AS v
	FROM order_content
	WHERE order_content.order_id = order_id
	GROUP BY book_id) B
	SET books.volume = books.volume + B.v
	WHERE books.id = B.book_id;
	
	UPDATE stack_room,order_content,books,users
	SET  users.volume=users.volume+stack_room.price*order_content.book_number*books.proportion
	WHERE stack_room.book_id = order_content.book_id 
	AND	order_content.book_id = books.id
	and stack_room.store_id = order_content.store_id
	AND order_content.order_id = order_id
	AND books.publisher_id = users.id;
	
	
	UPDATE stack_room,order_content
	SET stack_room.remaining = stack_room.remaining-order_content.book_number
	WHERE stack_room.book_id = order_content.book_id
	and stack_room.store_id = order_content.store_id
	AND order_content.order_id = order_id
	AND stack_room.remaining > order_content.book_number;
	
	
	UPDATE stack_room,order_content,books,users
	SET  users.volume=users.volume+books.price*(stack_room.stock-stack_room.remaining),
	stack_room.remaining=stack_room.stock
	WHERE stack_room.book_id = order_content.book_id
	AND	order_content.book_id = books.id
	and stack_room.store_id = order_content.store_id
	AND stack_room.remaining < order_content.book_number
	AND books.publisher_id = users.id
	AND order_content.order_id = order_id;
	
	UPDATE stack_room,order_content
	SET stack_room.volume = stack_room.volume+order_content.book_number,
	stack_room.revenue = stack_room.revenue+order_content.book_number*stack_room.price
	WHERE stack_room.book_id = order_content.book_id
	and stack_room.store_id = order_content.store_id
	AND order_content.order_id = order_id;
	
	
	UPDATE users,stack_room,order_content
	SET users.volume = users.volume+order_content.book_number*stack_room.price
	WHERE users.id = stack_room.store_id
	AND stack_room.book_id = order_content.book_id
	AND stack_room.store_id = order_content.store_id
	AND order_content.store_id = users.id
	AND order_content.order_id = order_id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Register
-- ----------------------------
DROP PROCEDURE IF EXISTS `Register`;
delimiter ;;
CREATE PROCEDURE `Register`(IN type INT ( 1 ),
	IN account VARCHAR ( 255 ),
	IN pwd LONGTEXT,
	IN `name` VARCHAR ( 255 ),
	IN phone INT ( 11 ),
	IN address LONGTEXT,
	IN bank_account BIGINT ( 19 ),
	IN email LONGTEXT)
  COMMENT 'User registration.'
BEGIN
	DECLARE
		judge INT;
	DECLARE
		statusNum INT;
	SELECT
		- 1 INTO statusNum;
	SELECT
		COUNT( * ) INTO judge 
	FROM
		users 
	WHERE
		users.account = account;
	IF
		judge = 0 THEN
			INSERT INTO users ( `name`, address, email, phone, bank_account, volume, account, `password` ,type)
		VALUES
			( `name`, address, email, phone, bank_account, 0, account, MD5( pwd ) ,type);
		SELECT
			1 INTO statusNum;
	END IF;
	SELECT
		statusNum AS statusNum;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ReviseBook
-- ----------------------------
DROP PROCEDURE IF EXISTS `ReviseBook`;
delimiter ;;
CREATE PROCEDURE `ReviseBook`(IN id INT(50),
IN `name` VARCHAR ( 255 ),
	IN author VARCHAR ( 255 ),
	IN theme VARCHAR ( 255 ),
	IN pages INT ( 10 ),
	IN proportion DOUBLE,
	IN photo LONGTEXT)
  COMMENT 'Publishing house changes book information.'
BEGIN
	UPDATE books 
	SET `name` = `name`,
	author = author,
	theme = theme,
	pages = pages,
	proportion = proportion,
	photo = photo
	WHERE books.id = id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for revisePrice
-- ----------------------------
DROP PROCEDURE IF EXISTS `revisePrice`;
delimiter ;;
CREATE PROCEDURE `revisePrice`(IN book_id INT ( 50 ), IN store_id INT ( 50 ), IN price DOUBLE)
  COMMENT 'Merchants modify book prices.'
BEGIN
	UPDATE stack_room
	SET price = price
	WHERE
			stack_room.book_id = book_id 
			AND stack_room.store_id = store_id; 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for setDefault
-- ----------------------------
DROP PROCEDURE IF EXISTS `setDefault`;
delimiter ;;
CREATE PROCEDURE `setDefault`(IN user_id INT(50),
IN receiving_address_id INT(50))
  COMMENT 'Set as default address.'
BEGIN
	#Routine body goes here...
	UPDATE receiving_address
	SET _default = 1
	WHERE receiving_address.id = receiving_address_id;
	UPDATE receiving_address
	SET _default = 0
	WHERE receiving_address.id != receiving_address_id
	AND receiving_address.user_id = user_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for updateChecked
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateChecked`;
delimiter ;;
CREATE PROCEDURE `updateChecked`(IN user_id INT ( 50 ),
	IN book_id INT ( 50 ),
	IN store_id INT ( 50 ),
	IN checked INT ( 1 ))
  COMMENT 'Update shopping cart item selection status.'
BEGIN
	UPDATE shopping_cart
		SET shopping_cart.checked = checked 
		WHERE
			shopping_cart.book_id = book_id 
			AND shopping_cart.store_id = store_id 
			AND shopping_cart.user_id = user_id;
			SELECT sum(price*book_number) AS total_price
		FROM shopping_cart,stack_room
		WHERE shopping_cart.user_id = user_id AND shopping_cart.book_id = stack_room.book_id
		AND shopping_cart.store_id = stack_room.store_id
		AND shopping_cart.checked = 1;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
