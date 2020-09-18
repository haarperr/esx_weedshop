CREATE TABLE `weedshop` (
	`id` int NOT NULL AUTO_INCREMENT,
	`type` varchar(255) DEFAULT NULL,
	`amount` int DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `weedshop` (type, amount) VALUES
	('weed', 0),
	('joint', 0),
	('register', 0)
;

INSERT INTO `jobs` (name, label) VALUES
	('weedshop', 'Coffeeshop')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('weedshop', 0, 'starter', 'Starter', 200, '{}', '{}'),
	('weedshop', 1, 'boss', 'Boss', 200, '{}', '{}')
;

INSERT INTO `items` (name, label) VALUES
	('joint', 'Joint')
;