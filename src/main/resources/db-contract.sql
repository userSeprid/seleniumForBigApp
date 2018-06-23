DROP TABLE IF EXISTS contract_files;


  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

DROP VIEW IF EXISTS rank;

CREATE VIEW rank AS
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
  WHERE N <> 1000 AND N > 0