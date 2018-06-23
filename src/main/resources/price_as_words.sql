DROP FUNCTION `number_to_string`;

CREATE FUNCTION `number_to_string`(n INT)
  RETURNS VARCHAR(1000)
  BEGIN
    DECLARE ans VARCHAR(100);
    DECLARE dig1, dig2, dig3 INT; -- (one variable per digit)

    SET ans = '';

    SET dig2 = floor(n / 1000);
    SET dig1 = n - dig2 * 1000;
    IF dig2 > 0
    THEN
      set dig3 = dig2 - 100 * floor(dig2 / 100);
      SET ans = concat(thousand_to_string(dig2));
      IF dig3 = 1
      THEN
        SET ans = concat(ans, ' тисяча');
      ELSE IF dig3 > 1 AND dig3 < 5
      THEN SET ans = concat(ans, ' тисячі');
      ELSE SET ans = concat(ans, ' тисяч');
      END IF;
      END IF;
    END IF;

    IF dig1 > 0
    THEN
      SET ans = concat(ans, ' ', thousand_to_string(dig1));
      IF dig1 = 1
      THEN
        SET ans = concat(ans, ' гривня');
      ELSE IF dig1 > 1 AND dig1 < 5
      THEN SET ans = concat(ans, ' гривні');
      ELSE SET ans = concat(ans, ' гривень');
      END IF;
      END IF;
    END IF;
    RETURN ans;
  END;

DROP FUNCTION thousand_to_string;

CREATE FUNCTION `thousand_to_string`(n INT)
RETURNS VARCHAR(100)
BEGIN
  DECLARE ans VARCHAR(100);
  DECLARE dig1, dig2, dig3 INT; -- (one variable per digit)

  SET ans = '';

  SET dig3 = floor(n / 100);
  SET dig2 = floor(n / 10) - dig3 * 10;
  SET dig1 = n - (dig3 * 100 + dig2 * 10);

  IF dig3 > 0
  THEN
    CASE
  WHEN dig3 = 1
  THEN SET ans = concat(ans, 'сто');
    WHEN dig3 = 2
  THEN SET ans = concat(ans, 'двісті');
    WHEN dig3 = 3
  THEN SET ans = concat(ans, 'триста');
    WHEN dig3 = 4
  THEN SET ans = concat(ans, 'чотириста');
    WHEN dig3 = 5
      THEN SET ans = concat(ans, 'п\'ятсот');
    WHEN dig3 = 6
  THEN SET ans = concat(ans, 'шістсот');
    WHEN dig3 = 7
  THEN SET ans = concat(ans, 'сімсот');
    WHEN dig3 = 8
  THEN SET ans = concat(ans, 'вісімсот');
    WHEN dig3 = 9
      THEN SET ans = concat(ans, 'дев\'ятсот');
    ELSE SET ans = ans;
    END CASE;
  END IF;

  IF dig2 = 1
  THEN
    CASE
  WHEN (dig2 * 10 + dig1) = 10
  THEN SET ans = concat(ans, ' десять');
    WHEN (dig2 * 10 + dig1) = 11
  THEN SET ans = concat(ans, ' одинадцять');
    WHEN (dig2 * 10 + dig1) = 12
  THEN SET ans = concat(ans, ' двенадцять');
    WHEN (dig2 * 10 + dig1) = 13
  THEN SET ans = concat(ans, ' тринадцять');
    WHEN (dig2 * 10 + dig1) = 14
  THEN SET ans = concat(ans, ' чотирнадцять');
    WHEN (dig2 * 10 + dig1) = 15
      THEN SET ans = concat(ans, ' п\'ятнадцять');
    WHEN (dig2 * 10 + dig1) = 16
  THEN SET ans = concat(ans, ' шістнадцять');
    WHEN (dig2 * 10 + dig1) = 17
  THEN SET ans = concat(ans, ' сімнадцять');
    WHEN (dig2 * 10 + dig1) = 18
  THEN SET ans = concat(ans, ' вісімнадцять');
    WHEN (dig2 * 10 + dig1) = 19
      THEN SET ans = concat(ans, ' дев\'ятнацять');
    ELSE SET ans = ans;
    END CASE;
  ELSE
    IF dig2 > 0
  THEN
    CASE
  WHEN dig2 = 2
    THEN SET ans = concat(ans, ' двадцять');
    WHEN dig2 = 3
    THEN SET ans = concat(ans, ' тридцять');
    WHEN dig2 = 4
    THEN SET ans = concat(ans, ' сорок');
    WHEN dig2 = 5
      THEN SET ans = concat(ans, ' п\'ятдесят');
    WHEN dig2 = 6
    THEN SET ans = concat(ans, ' шістдесят');
    WHEN dig2 = 7
    THEN SET ans = concat(ans, ' сімдесят');
    WHEN dig2 = 8
    THEN SET ans = concat(ans, ' вісімдесят');
    WHEN dig2 = 9
      THEN SET ans = concat(ans, ' дев\'яносто');
    ELSE SET ans = ans;
    END CASE;
    END IF;
    IF dig1 > 0
  THEN
    CASE
  WHEN dig1 = 1
    THEN SET ans = concat(ans, ' одна');
    WHEN dig1 = 2
    THEN SET ans = concat(ans, ' дві');
    WHEN dig1 = 3
    THEN SET ans = concat(ans, ' три');
    WHEN dig1 = 4
    THEN SET ans = concat(ans, ' чотири');
    WHEN dig1 = 5
      THEN SET ans = concat(ans, ' п\'ять');
    WHEN dig1 = 6
    THEN SET ans = concat(ans, ' шість');
    WHEN dig1 = 7
    THEN SET ans = concat(ans, ' сімь');
    WHEN dig1 = 8
    THEN SET ans = concat(ans, ' вісім');
    WHEN dig1 = 9
      THEN SET ans = concat(ans, ' д\'евять');
    ELSE SET ans = ans;
    END CASE;
    END IF;
  END IF;
  RETURN trim(ans);
END;

SELECT number_to_string(101785);
SELECT number_to_string(105785);
SELECT number_to_string(2400);
SELECT number_to_string(5);
SELECT number_to_string(111000);
SELECT number_to_string(200);
SELECT number_to_string(2000);
SELECT number_to_string(1000);
SELECT number_to_string(2000);
SELECT number_to_string(3000);
SELECT number_to_string(4000);
SELECT number_to_string(5000);
