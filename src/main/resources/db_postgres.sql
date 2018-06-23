DROP TABLE IF EXISTS access_level CASCADE;

CREATE TABLE access_level (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(45) DEFAULT NULL
);

INSERT INTO access_level (name) VALUES ('ROLE_USER');

DROP TABLE IF EXISTS account CASCADE;

CREATE TABLE account (
  id       SERIAL PRIMARY KEY,
  login    VARCHAR(255) DEFAULT NULL,
  password VARCHAR(255) DEFAULT NULL
);

DROP TABLE IF EXISTS account_access_level CASCADE;

CREATE TABLE account_access_level (
  account_id      SERIAL,
  access_level_id SERIAL,
  PRIMARY KEY (account_id, access_level_id),
  CONSTRAINT fk_access_level_id FOREIGN KEY (access_level_id) REFERENCES access_level (id),
  CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES account (id)
);

INSERT INTO account (login, password) VALUES ('admin', '$2a$11$568dxJXP57hWhVPO36o.suTzVDaymaikMQKvHJdAV0DVAFeZuKrUW');
INSERT INTO account_access_level (account_id, access_level_id) VALUES ((SELECT id
                                                                        FROM account
                                                                        WHERE login = 'admin'),
                                                                       (SELECT id
                                                                        FROM access_level
                                                                        WHERE name = 'ROLE_USER'));


DROP TABLE IF EXISTS dictionaries CASCADE;

CREATE TABLE dictionaries (
  id        SERIAL PRIMARY KEY,
  parent_id INTEGER      DEFAULT NULL,
  code      VARCHAR(255) DEFAULT NULL,
  title     VARCHAR(255) DEFAULT NULL,
  FOREIGN KEY (parent_id) REFERENCES dictionaries (id)
);


DROP TABLE IF EXISTS contract_status CASCADE;

CREATE TABLE contract_status (
  id          SERIAL PRIMARY KEY,
  contract_id INTEGER   NOT NULL,
  status_date TIMESTAMP NOT NULL DEFAULT current_timestamp,
  state_id    INTEGER            DEFAULT NULL,
  FOREIGN KEY (contract_id) REFERENCES contract (id),
  FOREIGN KEY (state_id) REFERENCES dictionaries (id)
);


INSERT INTO dictionaries (title) VALUES
  ('Позначення договорів'),
  ('Регіон'),
  ('Компанія'),
  ('Тип пульту'),
  ('Об’єкт'),
  ('Стан'),
  ('Доп. позначення'),
  ('Тип договору');


INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'А', 'спостереження за авто (автокомфорт)'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'П', 'пультова охорона'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'П', 'тривожна кнопка'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'П', 'оренда обладнання'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'П', 'пожежне спостереження (окремою зоною)'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'П', 'пожежне обслуговування (окремою зоною)'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'ПР', 'реагування на сторонні пульти'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'ПС', 'спостереження та обслуговування об’єктів сторонніх пультів'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'ППС', 'пожежне спостереження'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'ППО', 'пожежне обслуговування'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Позначення договорів'), 'Т', 'трекер, тривожна кнопка GPS');

INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '01', 'Київська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '02', 'Вінницька область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '03', 'Волинська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '04', 'Дніпропетровська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '05', 'Донецька область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '06', 'Житомирська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '07', 'Закарпатська область‎'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '08', 'Запорізька область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '09', 'Івано-Франківська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '10', 'Кіровоградська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '11', 'Луганська область‎'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '12', 'Львівська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '13', 'Миколаївська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '14', 'Одеська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '15', 'Полтавська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '16', 'Рівненська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '17', 'Сумська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '18', 'Тернопільська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '19', 'Харківська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '20', 'Херсонська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '21', 'Хмельницька область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '22', 'Черкаська область‎'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '23', 'Чернівецька область‎'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '24', 'Чернігівська область'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Регіон'), '25', 'Крим');


INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Компанія'), 'С', 'Сіріус'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Компанія'), 'СП', 'Сіріус Пульт');

INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип пульту'), '0', 'Без пiдключення на пульт'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип пульту'), '1', 'Макс'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип пульту'), '2', 'Лунь'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип пульту'), '3', 'Грифон'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип пульту'), '4', 'Оріон'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип пульту'), '5', 'Дунай');

INSERT INTO dictionaries (parent_id, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Об’єкт'), 'Квартира'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Об’єкт'), 'Будинок'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Об’єкт'), 'Магазин');

INSERT INTO dictionaries (parent_id, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Об’єкт'), 'Кіоск'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Об’єкт'), 'Офіс');

INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Стан'), '6001', 'Охороняється'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Стан'), '6002', 'Призупинено'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Стан'), '6003', 'Відключено');

INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Доп. позначення'), 'Т', 'тривожна кнопка'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Доп. позначення'), 'О', 'оренда обладнання');


INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип договору'), '0', 'Зв’язанi'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип договору'),
   '1', 'Корпоративнi');

INSERT INTO dictionaries (parent_id, code, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип договору'), '0', 'Зв’язанi'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Тип договору'),
   '1', 'Корпоративнi');

--  63
INSERT INTO dictionaries (title) VALUES
  ('Партнери');

INSERT INTO dictionaries (title) VALUES
  ('Менеджери');

INSERT INTO dictionaries (parent_id, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Партнери'), 'Захист-12');

INSERT INTO dictionaries (parent_id, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Сiрiус'), 'Реус');

INSERT INTO dictionaries (parent_id, title) VALUES
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Сiрiус'), 'Миколенко'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Сiрiус'), 'Хрустицька'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Сiрiус'), 'Куценко'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Сiрiус'), 'Доманський'),
  ((SELECT id
    FROM dictionaries
    WHERE title = 'Сiрiус'), 'Бондар');



DROP TABLE IF EXISTS contract CASCADE;

CREATE TABLE ppkEntity (
  id                 SERIAL PRIMARY KEY,
  contact_id         INTEGER,
  address            VARCHAR(600) DEFAULT NULL,
  requisites         VARCHAR(600) DEFAULT NULL,
  manager_id         INTEGER      DEFAULT NULL,
  manager_company_id INTEGER      DEFAULT NULL,
  dashboard_type_id  INTEGER      DEFAULT NULL,
  dashboard_number   INTEGER      DEFAULT NULL,
  dashboard_cell     INTEGER      DEFAULT NULL,
  region_id          INTEGER      DEFAULT NULL,
  company_id         INTEGER      DEFAULT NULL,
  object_type_id     INTEGER      DEFAULT NULL,
  description             VARCHAR(600) DEFAULT NULL,
  responsibility          INTEGER      DEFAULT NULL,
  reaction_time           INTEGER      DEFAULT NULL,
  increase                VARCHAR(600) DEFAULT NULL,
  history                 VARCHAR(600) DEFAULT NULL,
  tech_history            VARCHAR(600) DEFAULT NULL,
  documents               VARCHAR(600) DEFAULT NULL,
  instrument              VARCHAR(600) DEFAULT NULL,
//TODO chech FKs
/*
  FOREIGN KEY (manager_id) REFERENCES dictionaries (id),
  FOREIGN KEY (manager_company_id) REFERENCES dictionaries (id),
  FOREIGN KEY (contract_type_id) REFERENCES dictionaries (id),
  FOREIGN KEY (contract_type_ext_id) REFERENCES dictionaries (id),
  FOREIGN KEY (region_id) REFERENCES dictionaries (id),
  FOREIGN KEY (company_id) REFERENCES dictionaries (id),
  FOREIGN KEY (dashboard_type_id) REFERENCES dictionaries (id),
  FOREIGN KEY (object_type_id) REFERENCES dictionaries (id),
  FOREIGN KEY (parent_id) REFERENCES contract (id)
*/
);

create table contract
(
  id               SERIAL PRIMARY KEY,
  ppk_id           INTEGER,
  payment_tote     VARCHAR(600) DEFAULT NULL,
  payment_date     DATE         DEFAULT NULL,
  contract_type_id INTEGER      DEFAULT NULL,
  payment          float
);

DROP TABLE IF EXISTS contract_files CASCADE;

CREATE TABLE ppk_files (
  id          SERIAL PRIMARY KEY,
  ppk_id INTEGER NOT NULL UNIQUE,
  scheme      BYTEA DEFAULT NULL,
  map         BYTEA DEFAULT NULL,
  map_details BYTEA DEFAULT NULL,
  FOREIGN KEY (ppk_id) REFERENCES ppkEntity (id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS payments CASCADE;

CREATE TABLE payments (
  contract_id   INTEGER   NOT NULL,
  period_number INTEGER   NOT NULL,
  price         FLOAT     NOT NULL,
  payed         FLOAT,
  payed_ts      TIMESTAMP NOT NULL DEFAULT current_timestamp,
  comment       VARCHAR(45),
  PRIMARY KEY (contract_id, period_number),
  FOREIGN KEY (contract_id) REFERENCES contract (id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS payments_history;

CREATE TABLE payments_history (
  id          SERIAL PRIMARY KEY,
  contract_id INTEGER NOT NULL,
  create_date DATE    NOT NULL,
  amount      INTEGER NOT NULL,
  note        VARCHAR(45),
  FOREIGN KEY (contract_id) REFERENCES contract (id) ON DELETE CASCADE
);


CREATE TABLE person (
  id    SERIAL PRIMARY KEY,
  name  VARCHAR(42),
  phone VARCHAR(12),
  email VARCHAR(20),
  fax   VARCHAR(20),
  skype VARCHAR(20),
  note  VARCHAR(40)
);

CREATE OR REPLACE FUNCTION end_of_month(DATE)
  RETURNS DATE AS
$$
SELECT (date_trunc('month', $1) + INTERVAL '1 month' - INTERVAL '1 day') :: DATE;
$$ LANGUAGE 'sql'
IMMUTABLE STRICT;

CREATE OR REPLACE VIEW months_ukr AS
  SELECT
    column1 AS number,
    column2 AS title
  FROM (
         VALUES
           (1, 'Січень'),
           (2, 'Лютий'),
           (3, 'Березень'),
           (4, 'Квітень'),
           (5, 'Травень'),
           (6, 'Червень'),
           (7, 'Липень'),
           (8, 'Серпень'),
           (9, 'Вересень'),
           (10, 'Жовтень'),
           (11, 'Листопад'),
           (12, 'Грудень')
       ) AS monthers;

CREATE OR REPLACE FUNCTION contract_number(contract_id INTEGER)
  RETURNS VARCHAR(100)
AS $$
BEGIN
  RETURN (SELECT trim(TRAILING '-' FROM concat(
      (SELECT code
       FROM dictionaries
       WHERE id = p.company_id),
      '-',
      (SELECT code
       FROM dictionaries
       WHERE id = p.region_id),
      '-',
      (SELECT code
       FROM dictionaries
       WHERE id = p.dashboard_type_id),
      p.dashboard_number,
      lpad(p.dashboard_cell :: TEXT, 3, '0')
  ))
          FROM ppk p
          WHERE p.id = contract_id);
END;
$$ LANGUAGE plpgsql;

DROP VIEW contract_view;
CREATE VIEW contract_view AS
  SELECT
    contract_number(c.id),
    c.*
  FROM contract c;

CREATE OR REPLACE FUNCTION number_to_string(n INTEGER)
  RETURNS VARCHAR(100) AS $$
DECLARE
  ans  VARCHAR(100);
  dig1 INTEGER;
  dig2 INTEGER;
  dig3 INTEGER;
BEGIN
  ans := '';
  dig2 := floor(n / 1000);
  dig1 := n - dig2 * 1000;
  IF dig2 > 0
  THEN
    dig3 := dig2 - 100 * floor(dig2 / 100);
    ans := concat(thousand_to_string(dig2));
    IF dig3 = 1
    THEN
      ans := concat(ans, ' тисяча');
    ELSE IF dig3 > 1 AND dig3 < 5
    THEN ans := concat(ans, ' тисячі');
    ELSE ans := concat(ans, ' тисяч');
    END IF;
    END IF;
  END IF;

  IF dig1 > 0
  THEN
    ans := concat(ans, ' ', thousand_to_string(dig1));
    IF dig1 = 1
    THEN
      ans := concat(ans, ' гривня');
    ELSE IF dig1 > 1 AND dig1 < 5
    THEN ans := concat(ans, ' гривні');
    ELSE ans := concat(ans, ' гривень');
    END IF;
    END IF;
  END IF;
  RETURN ans;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION thousand_to_string(n INTEGER)
  RETURNS VARCHAR(100) AS $$
DECLARE
  ans  VARCHAR(100);
  dig1 INTEGER;
  dig2 INTEGER;
  dig3 INTEGER;
BEGIN
  ans := '';

  dig3 := floor(n / 100);
  dig2 := floor(n / 10) - dig3 * 10;
  dig1 = n - (dig3 * 100 + dig2 * 10);

  IF dig3 > 0
  THEN
    CASE
      WHEN dig3 = 1
      THEN ans := concat(ans, 'сто');
      WHEN dig3 = 2
      THEN ans := concat(ans, 'двісті');
      WHEN dig3 = 3
      THEN ans := concat(ans, 'триста');
      WHEN dig3 = 4
      THEN ans := concat(ans, 'чотириста');
      WHEN dig3 = 5
      THEN ans := concat(ans, 'п''ятсот');
      WHEN dig3 = 6
      THEN ans = concat(ans, 'шістсот');
      WHEN dig3 = 7
      THEN ans = concat(ans, 'сімсот');
      WHEN dig3 = 8
      THEN ans = concat(ans, 'вісімсот');
      WHEN dig3 = 9
      THEN ans := concat(ans, 'дев''ятсот');
    ELSE ans := ans;
    END CASE;
  END IF;

  IF dig2 = 1
  THEN
    CASE
      WHEN (dig2 * 10 + dig1) = 10
      THEN ans := concat(ans, ' десять');
      WHEN (dig2 * 10 + dig1) = 11
      THEN ans := concat(ans, ' одинадцять');
      WHEN (dig2 * 10 + dig1) = 12
      THEN ans := concat(ans, ' двенадцять');
      WHEN (dig2 * 10 + dig1) = 13
      THEN ans := concat(ans, ' тринадцять');
      WHEN (dig2 * 10 + dig1) = 14
      THEN ans := concat(ans, ' чотирнадцять');
      WHEN (dig2 * 10 + dig1) = 15
      THEN ans := concat(ans, ' п''ятнадцять');
      WHEN (dig2 * 10 + dig1) = 16
      THEN ans := concat(ans, ' шістнадцять');
      WHEN (dig2 * 10 + dig1) = 17
      THEN ans := concat(ans, ' сімнадцять');
      WHEN (dig2 * 10 + dig1) = 18
      THEN ans := concat(ans, ' вісімнадцять');
      WHEN (dig2 * 10 + dig1) = 19
      THEN ans := concat(ans, ' дев''ятнацять');
    ELSE ans := ans;
    END CASE;
  ELSE
    IF dig2 > 0
    THEN
      CASE
        WHEN dig2 = 2
        THEN ans := concat(ans, ' двадцять');
        WHEN dig2 = 3
        THEN ans := concat(ans, ' тридцять');
        WHEN dig2 = 4
        THEN ans := concat(ans, ' сорок');
        WHEN dig2 = 5
        THEN ans := concat(ans, ' п''ятдесят');
        WHEN dig2 = 6
        THEN ans := concat(ans, ' шістдесят');
        WHEN dig2 = 7
        THEN ans := concat(ans, ' сімдесят');
        WHEN dig2 = 8
        THEN ans := concat(ans, ' вісімдесят');
        WHEN dig2 = 9
        THEN ans := concat(ans, ' дев''яносто');
      ELSE ans := ans;
      END CASE;
    END IF;
    IF dig1 > 0
    THEN
      CASE
        WHEN dig1 = 1
        THEN ans := concat(ans, ' одна');
        WHEN dig1 = 2
        THEN ans := concat(ans, ' дві');
        WHEN dig1 = 3
        THEN ans := concat(ans, ' три');
        WHEN dig1 = 4
        THEN ans := concat(ans, ' чотири');
        WHEN dig1 = 5
        THEN ans := concat(ans, ' п''ять');
        WHEN dig1 = 6
        THEN ans := concat(ans, ' шість');
        WHEN dig1 = 7
        THEN ans := concat(ans, ' сімь');
        WHEN dig1 = 8
        THEN ans := concat(ans, ' вісім');
        WHEN dig1 = 9
        THEN ans := concat(ans, ' д''евять');
      ELSE ans := ans;
      END CASE;
    END IF;
  END IF;
  RETURN trim(ans);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW rank AS
  SELECT n
  FROM (
         SELECT (a.digit + (10 * b.digit) + (100 * c.digit) + (1000 * d.digit)) AS n
         FROM (SELECT 0 AS digit
               UNION ALL SELECT 1
               UNION ALL SELECT 2
               UNION ALL SELECT 3
               UNION ALL SELECT 4
               UNION ALL SELECT 5
               UNION ALL SELECT 6
               UNION ALL SELECT 7
               UNION ALL SELECT 8
               UNION ALL SELECT 9) AS a
           CROSS JOIN (SELECT 0 AS digit
                       UNION ALL SELECT 1
                       UNION ALL SELECT 2
                       UNION ALL SELECT 3
                       UNION ALL SELECT 4
                       UNION ALL SELECT 5
                       UNION ALL SELECT 6
                       UNION ALL SELECT 7
                       UNION ALL SELECT 8
                       UNION ALL SELECT 9) AS b
           CROSS JOIN (SELECT 0 AS digit
                       UNION ALL SELECT 1
                       UNION ALL SELECT 2
                       UNION ALL SELECT 3
                       UNION ALL SELECT 4
                       UNION ALL SELECT 5
                       UNION ALL SELECT 6
                       UNION ALL SELECT 7
                       UNION ALL SELECT 8
                       UNION ALL SELECT 9) AS c
           CROSS JOIN (SELECT 0 AS digit
                       UNION ALL SELECT 1
                       UNION ALL SELECT 2
                       UNION ALL SELECT 3
                       UNION ALL SELECT 4
                       UNION ALL SELECT 5
                       UNION ALL SELECT 6
                       UNION ALL SELECT 7
                       UNION ALL SELECT 8
                       UNION ALL SELECT 9) AS d
       ) a
  WHERE N <> 1000 AND N > 0;

--56	6	6001	Охороняється
--57	6	6002	Призупинено
--58	6	6003	Відключено

CREATE OR REPLACE FUNCTION period_number(p_date DATE)
  RETURNS INTEGER
AS $$
DECLARE
  v_period_number INTEGER;
BEGIN
  SELECT date_part('year', p_date) * 100 + date_part('month', p_date)
  INTO v_period_number;
  RETURN v_period_number;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION price_of_day;

CREATE OR REPLACE FUNCTION price_of_day(p_date DATE, p_contract_id INTEGER)
  RETURNS DOUBLE PRECISION
AS $$
DECLARE
  v_status_id      INTEGER;
  v_month_price    NUMERIC;
  v_month_duration INTEGER;
BEGIN

  SELECT state_id
  INTO v_status_id
  FROM contract_status
  WHERE contract_id = p_contract_id AND status_date < p_date
  ORDER BY status_date DESC
  LIMIT 1;

  IF v_status_id ISNULL
  THEN v_status_id := 57;
  END IF;

  IF v_status_id IN (57, 58)
  THEN
    RETURN 0;
  END IF;
  SELECT coalesce(p.price, c.payment)
  INTO v_month_price
  FROM contract c LEFT JOIN (SELECT *
                             FROM payments
                             WHERE period_number = period_number(p_date)) p
      ON C.id = p.contract_id
  WHERE C.id = p_contract_id;

  RAISE NOTICE 'Month price: %', v_month_price;

  SELECT EXTRACT(DAY FROM end_of_month(p_date) - date_trunc('month', p_date)) + 1
  INTO v_month_duration;

  --fix for april
  IF date_part('month', p_date) = 3
  THEN
    v_month_duration = v_month_duration + 1;
  END IF;

  RETURN v_month_price / v_month_duration;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW payments_view
  AS
    SELECT
      price_per_period.contract_id,
      price_per_period.parent_id,
      price_per_period.period_number,
      end_of_month,
      coalesce(p.price, round(period_price)) AS price,
      coalesce(p.payed, 0)                   AS payed
    FROM (
           SELECT
             contract_id,
             parent_id,
             period_number(contract_creation_date + day_number),
             end_of_month(contract_creation_date + day_number)                   AS end_of_month,
             sum(price_of_day(contract_creation_date + day_number, contract_id)) AS period_price
           FROM (
                  SELECT
                    contract_id,
                    parent_id,
                    contract_creation_date,
                    generate_series(0, days) AS day_number
                  FROM (
                         SELECT
                           cs.contract_id,
                           c.parent_id,
                           min(date_trunc('day', cs.status_date)) :: DATE                                   AS contract_creation_date,
                           DATE_PART('day', DATE '2018-12-31' - min(date_trunc('day',
                                                                               cs.status_date))) :: INTEGER AS days
                         FROM contract_status cs, contract c
                         WHERE cs.contract_id = c.id
                         GROUP BY contract_id, parent_id) day_for_contract) price_per_day
           GROUP BY contract_id, parent_id, period_number, end_of_month) AS price_per_period LEFT JOIN payments p
        ON price_per_period.contract_id = p.contract_id AND price_per_period.period_number = p.period_number
    UNION ALL
    SELECT
      c.id,
      c.parent_id,
      -1   AS period_number,
      NULL AS end_of_month,
      coalesce(p.price, c.payment),
      coalesce(p.payed, 0)
    FROM contract c LEFT JOIN payments p
        ON
          c.id = p.contract_id AND p.period_number = -1;

CREATE OR REPLACE FUNCTION pay_amount(p_parent_id INTEGER, amount DOUBLE PRECISION, create_date DATE)
  RETURNS INTEGER
AS $$
DECLARE
  pv                 payments_view%ROWTYPE;
  pay_current_period FLOAT;
BEGIN
  INSERT INTO payments_history (contract_id, create_date, amount)
  VALUES (p_parent_id, create_date, amount);
  FOR pv IN
  (SELECT *
   FROM payments_view
   WHERE price > payed AND (contract_id = p_parent_id OR (contract_id IN (
     SELECT id
     FROM contract
     WHERE parent_id = p_parent_id AND contract_type_ext_id IN (59, 60)
   )))
   ORDER BY period_number, parent_id DESC, contract_id)
  LOOP
    IF amount = 0
    THEN
      RETURN 0;
    END IF;
    pay_current_period := least(amount, pv.price - pv.payed);
    amount := amount - pay_current_period;
    UPDATE payments
    SET payed = payed + pay_current_period, payed_ts = current_timestamp
    WHERE contract_id = pv.contract_id AND period_number = pv.period_number;
    IF NOT FOUND
    THEN
      INSERT INTO payments (contract_id, period_number, price, payed, payed_ts)
      VALUES (pv.contract_id, pv.period_number, pv.price, pay_current_period, current_timestamp);
    END IF;
  END LOOP;
  RETURN 1;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION update_contract_status;

CREATE OR REPLACE FUNCTION update_contract_status(p_contract_id INTEGER, p_new_status INTEGER, p_creation_date DATE)
  RETURNS INTEGER
AS $$
DECLARE
  v_old_status INTEGER;
BEGIN
  SELECT state_id
  INTO v_old_status
  FROM contract_status
  WHERE contract_id = p_contract_id
  ORDER BY status_date DESC
  LIMIT 1;
  RAISE NOTICE '%', v_old_status;
  IF v_old_status ISNULL OR v_old_status <> p_new_status
  THEN
    INSERT INTO contract_status (contract_id, status_date, state_id)
    VALUES (p_contract_id, p_creation_date, p_new_status);
  END IF;
  RETURN 1;
END;
$$ LANGUAGE plpgsql;