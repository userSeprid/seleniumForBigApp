CREATE DATABASE  IF NOT EXISTS `accounts`;
USE `accounts`;
--
-- Table structure for table `accessLevel`
--

DROP TABLE IF EXISTS `accessLevel`;
CREATE TABLE `accessLevel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `accessLevel`
--

LOCK TABLES `accessLevel` WRITE;
INSERT INTO `accessLevel` VALUES (1,'ROLE_USER');
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_user_role_roleid_idx` (`role_id`),
  CONSTRAINT `fk_user_role_roleid` FOREIGN KEY (`role_id`) REFERENCES `accessLevel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_userid` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO accounts.account (login, password) VALUES ('admin', '$2a$11$568dxJXP57hWhVPO36o.suTzVDaymaikMQKvHJdAV0DVAFeZuKrUW');
INSERT INTO user_role(user_id, role_id) VALUES ((SELECT id FROM account WHERE login = 'admin'),
                                                (select id from accessLevel where name = 'ROLE_USER'));
