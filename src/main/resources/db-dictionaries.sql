
DROP TABLE IF EXISTS `dictionaries`;
CREATE TABLE `dictionaries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(45) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`parent_id`) REFERENCES `dictionaries` (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8;

INSERT INTO dictionaries (title) VALUES
  ("Позначення договорів"),
  ("Регіон"),
  ("Компанія"),
  ("Тип пульту"),
  ("Об’єкт"),
  ("Стан"),
  ("Доп. позначення");

INSERT INTO dictionaries (parent_id, code, title) VALUES
  (1, "А", "спостереження за авто (автокомфорт)"),
  (1, "П", "пультова охорона"),
  (1, "П", "тривожна кнопка"),
  (1, "П", "оренда обладнання"),
  (1, "П", "пожежне спостереження (окремою зоною)"),
  (1, "П", "пожежне обслуговування (окремою зоною)"),
  (1, "ПР", "реагування на сторонні пульти"),
  (1, "ПС", "спостереження та обслуговування об’єктів сторонніх пультів"),
  (1, "ППС", "пожежне спостереження"),
  (1, "ППО", "пожежне обслуговування"),
  (1, "Т", "трекер, тривожна кнопка GPS");

INSERT INTO dictionaries (parent_id, code, title) VALUES
  (2, "01", "Київська область"),
  (2, "02", "Вінницька область"),
  (2, "03", "Волинська область"),
  (2, "04", "Дніпропетровська область"),
  (2, "05", "Донецька область"),
  (2, "06", "Житомирська область"),
  (2, "07", "Закарпатська область‎"),
  (2, "08", "Запорізька область"),
  (2, "09", "Івано-Франківська область"),
  (2, "10", "Кіровоградська область"),
  (2, "11", "Луганська область‎"),
  (2, "12", "Львівська область"),
  (2, "13", "Миколаївська область"),
  (2, "14", "Одеська область"),
  (2, "15", "Полтавська область"),
  (2, "16", "Рівненська область"),
  (2, "17", "Сумська область"),
  (2, "18", "Тернопільська область"),
  (2, "19", "Харківська область"),
  (2, "20", "Херсонська область"),
  (2, "21", "Хмельницька область"),
  (2, "22", "Черкаська область‎"),
  (2, "23", "Чернівецька область‎"),
  (2, "24", "Чернігівська область"),
  (2, "25", "Крим");


INSERT INTO dictionaries (parent_id, code, title) VALUES
  (3, "С", "Сіріус"),
  (3, "СП", "Сіріус Пульт");

INSERT INTO dictionaries (parent_id, code, title) VALUES
  (4, "0", "Без пiдключення на пульт"),
  (4, "1", "Макс"),
  (4, "2", "Лунь"),
  (4, "3", "Грифон"),
  (4, "4", "Оріон"),
  (4, "5", "Дунай");

INSERT INTO dictionaries (parent_id, title) VALUES
  (5, "Квартира"),
  (5, "Будинок"),
  (5, "Магазин");

INSERT INTO dictionaries (parent_id, code, title) VALUES
  (6, "6001", "Охороняється"),
  (6, "6002", "Призупинено"),
  (6, "6003", "Відключено");

INSERT INTO dictionaries (parent_id, code, title) VALUES
  (7, "Т", "тривожна кнопка"),
  (7, "О", "оренда обладнання");

INSERT INTO dictionaries (title) VALUES ('Тип договору');

INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT a.id
    FROM (SELECT id
          FROM dictionaries
          WHERE title = 'Тип договору') a),
   '0', 'Зв’язанi'),
  ((SELECT a.id
    FROM (SELECT id
          FROM dictionaries
          WHERE title = 'Тип договору') a),
   '1', 'Корпоративнi');