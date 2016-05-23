CREATE TABLE `test` (
	`id` INT(8) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(25) NOT NULL,
	`age` INT(11) NOT NULL,
	`admin` BIT(1) NOT NULL,
	`createdDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
