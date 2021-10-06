DROP PROCEDURE sp_six;

CREATE PROCEDURE sp_six()

BEGIN

SELECT m.name AS 'Month', t.category AS 'Category', SUM(t.price) AS 'Amount'
FROM transactions t
LEFT JOIN month m
ON SUBSTRING(t.purchase_date, 6, 2) = m.code
GROUP BY m.name, t.category
ORDER BY m.id, t.category;

END;