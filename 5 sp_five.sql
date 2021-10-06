DROP PROCEDURE sp_five;

CREATE PROCEDURE sp_five (IN month VARCHAR(15))

BEGIN

SELECT c.name AS 'Country', SUM(t.price) AS 'Amount'
FROM transactions t
LEFT JOIN country c
ON t.country = c.id
WHERE SUBSTRING(t.purchase_date, 6, 2) = 
(
    SELECT m.code
    FROM month m
    WHERE m.name = month
)
GROUP BY t.country;

END;